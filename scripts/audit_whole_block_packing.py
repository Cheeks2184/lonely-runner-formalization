#!/usr/bin/env python3
"""Exact whole-block capacity packing for strict modular pivot data.

For each child/target token choose at most one complete fiber intersection
with a distinct parent's bad set.  A residue may be used at most its bad-set
multiplicity minus one.  Nonbinding constraints are removed, the remaining
token conflict graph is decomposed, and each component is solved exactly by
integer branch-and-bound with replayed certificates.
"""

from __future__ import annotations

from collections import defaultdict
from dataclasses import dataclass
from math import gcd
import random


F = (8, 15, 35, 40, 48, 56, 75, 132, 147)
G = (15, 21, 40, 48, 56, 105, 126, 280, 1200)


@dataclass(frozen=True)
class Choice:
    parent: int
    residues: frozenset[int]


@dataclass(frozen=True)
class Token:
    owner: int
    target: int
    choices: tuple[Choice, ...]


@dataclass(frozen=True)
class PackingReport:
    speeds: tuple[int, ...]
    pivot: int
    candidate_count: int
    bad_sum: int
    union_size: int
    union_debt: int
    required_credit: int
    optimum_credit: int
    certified_bound: int
    succeeds_strictly: bool
    token_count: int
    variable_count: int
    binding_residues: int
    components: int
    largest_component: int
    search_nodes: int
    selected: tuple[tuple[int, int, int, tuple[int, ...]], ...]


@dataclass(frozen=True)
class FeasibleReport:
    speeds: tuple[int, ...]
    pivot: int
    required_credit: int
    feasible_credit: int
    union_debt_upper: int
    succeeds_strictly: bool
    rounds: int
    selected: tuple[tuple[int, int, int, tuple[int, ...]], ...]


def strict_bad(image: int, pivot: int, modulus: int) -> bool:
    return image < pivot or image > modulus - pivot


def literal_instance(
    speeds: tuple[int, ...], pivot: int
) -> tuple[
    tuple[int, ...],
    tuple[int, ...],
    dict[int, frozenset[int]],
    tuple[Token, ...],
]:
    if pivot not in speeds or len(set(speeds)) != len(speeds):
        raise ValueError("invalid pivot tuple")
    n = len(speeds)
    modulus = (n + 1) * pivot
    candidates = tuple(
        residue for residue in range(modulus) if residue % (n + 1) != 0
    )
    if len(candidates) != n * pivot:
        raise AssertionError("candidate count mismatch")
    vertices = tuple(speed for speed in speeds if speed != pivot)
    bad_sets = {
        speed: frozenset(
            residue
            for residue in candidates
            if strict_bad(speed * residue % modulus, pivot, modulus)
        )
        for speed in vertices
    }
    tokens: list[Token] = []
    for owner in vertices:
        targets = sorted({owner * residue % modulus for residue in bad_sets[owner]})
        for target in targets:
            fiber = frozenset(
                residue
                for residue in candidates
                if owner * residue % modulus == target
            )
            if not fiber or not fiber <= bad_sets[owner]:
                raise AssertionError("target is not a whole strict bad fiber")
            choices = []
            for parent in vertices:
                if parent == owner:
                    continue
                block = fiber & bad_sets[parent]
                if block:
                    choices.append(Choice(parent, block))
            if choices:
                tokens.append(Token(owner, target, tuple(choices)))
    return candidates, vertices, bad_sets, tuple(tokens)


@dataclass(frozen=True)
class CompressedChoice:
    binding: tuple[int, ...]
    weight: int
    original: Choice | None


def solve_exact(
    candidates: tuple[int, ...],
    vertices: tuple[int, ...],
    bad_sets: dict[int, frozenset[int]],
    tokens: tuple[Token, ...],
) -> tuple[int, dict[int, Choice], int, int, int, int]:
    multiplicity = {
        residue: sum(residue in bad_sets[speed] for speed in vertices)
        for residue in candidates
    }
    capacity = {
        residue: max(0, multiplicity[residue] - 1) for residue in candidates
    }
    token_degree: dict[int, int] = defaultdict(int)
    for residue in candidates:
        token_degree[residue] = sum(
            any(residue in choice.residues for choice in token.choices)
            for token in tokens
        )
    binding = tuple(
        residue
        for residue in candidates
        if capacity[residue] < token_degree[residue]
    )
    binding_set = frozenset(binding)

    compressed: dict[int, tuple[CompressedChoice, ...]] = {}
    for token_index, token in enumerate(tokens):
        best: dict[tuple[int, ...], CompressedChoice] = {
            (): CompressedChoice((), 0, None)
        }
        for choice in token.choices:
            signature = tuple(sorted(choice.residues & binding_set))
            candidate = CompressedChoice(signature, len(choice.residues), choice)
            old = best.get(signature)
            if old is None or candidate.weight > old.weight or (
                candidate.weight == old.weight
                and candidate.original is not None
                and old.original is not None
                and candidate.original.parent < old.original.parent
            ):
                best[signature] = candidate
        compressed[token_index] = tuple(
            sorted(
                best.values(),
                key=lambda item: (
                    -item.weight,
                    item.binding,
                    -1 if item.original is None else item.original.parent,
                ),
            )
        )

    incident: dict[int, set[int]] = defaultdict(set)
    for token_index, choices in compressed.items():
        for choice in choices:
            for residue in choice.binding:
                incident[residue].add(token_index)
    adjacency = {index: set() for index in range(len(tokens))}
    for token_indices in incident.values():
        for token_index in token_indices:
            adjacency[token_index].update(token_indices - {token_index})
    components: list[tuple[int, ...]] = []
    unseen = set(range(len(tokens)))
    while unseen:
        root = min(unseen)
        stack = [root]
        component = set()
        while stack:
            token_index = stack.pop()
            if token_index in component:
                continue
            component.add(token_index)
            stack.extend(adjacency[token_index] - component)
        unseen -= component
        components.append(tuple(sorted(component)))

    total_credit = 0
    selected: dict[int, Choice] = {}
    nodes = 0
    for component in components:
        component_binding = sorted(
            {
                residue
                for token_index in component
                for choice in compressed[token_index]
                for residue in choice.binding
            }
        )
        local_position = {
            residue: index for index, residue in enumerate(component_binding)
        }
        local_capacity = tuple(capacity[residue] for residue in component_binding)
        ordered_tokens = tuple(
            sorted(
                component,
                key=lambda index: (
                    -sum(bool(choice.binding) for choice in compressed[index]),
                    -max(choice.weight for choice in compressed[index]),
                    index,
                ),
            )
        )
        local_choices = []
        for token_index in ordered_tokens:
            converted = tuple(
                (
                    choice,
                    tuple(local_position[residue] for residue in choice.binding),
                )
                for choice in compressed[token_index]
            )
            local_choices.append(converted)

        # A reproducible grid dual supplies an additional *safe* upper bound.
        # With SCALE units per credit, any nonnegative prices z give the dual
        # value
        #   sum_r cap(r) z_r
        #   + sum_token max_choice(SCALE*w - sum_{r in Q} z_r).
        # Coordinate descent only improves the bound; optimality of the prices
        # is not assumed.  Flooring is safe because the primal objective is an
        # integer.
        scale = 12

        def dual_value(prices: tuple[int, ...]) -> int:
            value = sum(
                local_capacity[position] * prices[position]
                for position in range(len(prices))
            )
            for choices in local_choices:
                value += max(
                    scale * choice.weight
                    - sum(prices[position] for position in used)
                    for choice, used in choices
                )
            return value

        price_starts = (
            tuple(0 for _ in component_binding),
            tuple(scale for _ in component_binding),
            tuple(scale // 2 for _ in component_binding),
        )
        best_prices = price_starts[0]
        best_dual = dual_value(best_prices)
        for start in price_starts:
            prices = list(start)
            current_dual = dual_value(tuple(prices))
            for _round in range(8):
                changed = False
                for position in range(len(prices)):
                    old = prices[position]
                    local_best = old
                    local_value = current_dual
                    for candidate_price in range(scale + 1):
                        if candidate_price == old:
                            continue
                        prices[position] = candidate_price
                        candidate_value = dual_value(tuple(prices))
                        if candidate_value < local_value:
                            local_value = candidate_value
                            local_best = candidate_price
                    prices[position] = local_best
                    if local_best != old:
                        current_dual = local_value
                        changed = True
                if not changed:
                    break
            if current_dual < best_dual:
                best_dual = current_dual
                best_prices = tuple(prices)

        best_credit = -1
        best_selection: dict[int, CompressedChoice] | None = None
        memo: dict[tuple[int, tuple[int, ...]], int] = {}

        # Seed the exact search with reproducible feasible component packings.
        # This changes only the incumbent; the proof still comes from the
        # exhaustive branches and safe upper bounds below.
        component_rng = random.Random(20260802 + len(component) + sum(component))
        for greedy_round in range(96):
            greedy_order = list(range(len(ordered_tokens)))
            if greedy_round:
                component_rng.shuffle(greedy_order)
            greedy_remaining = list(local_capacity)
            greedy_selection: dict[int, CompressedChoice] = {}
            greedy_credit = 0
            for local_token in greedy_order:
                feasible = [
                    (choice, used)
                    for choice, used in local_choices[local_token]
                    if all(greedy_remaining[position] > 0 for position in used)
                ]
                if not feasible:
                    continue
                maximum = max(choice.weight for choice, _used in feasible)
                tied = [item for item in feasible if item[0].weight == maximum]
                choice, used = (
                    tied[0] if greedy_round == 0 else component_rng.choice(tied)
                )
                greedy_selection[ordered_tokens[local_token]] = choice
                greedy_credit += choice.weight
                for position in used:
                    greedy_remaining[position] -= 1
            if greedy_credit > best_credit:
                best_credit = greedy_credit
                best_selection = greedy_selection

        def dfs(
            remaining_mask: int,
            remaining: tuple[int, ...],
            credit: int,
            choices_so_far: dict[int, CompressedChoice],
        ) -> None:
            nonlocal best_credit, best_selection, nodes
            nodes += 1
            if remaining_mask == 0:
                if best_selection is None or credit > best_credit:
                    best_credit = credit
                    best_selection = dict(choices_so_far)
                return
            feasible_by_token = {}
            token_upper = 0
            nonbinding_upper = 0
            for local_token in range(len(ordered_tokens)):
                if remaining_mask & (1 << local_token) == 0:
                    continue
                feasible = tuple(
                    (choice, used_positions)
                    for choice, used_positions in local_choices[local_token]
                    if all(remaining[position] > 0 for position in used_positions)
                )
                if not feasible:
                    raise AssertionError("missing empty choice in compressed token")
                feasible_by_token[local_token] = feasible
                token_upper += max(choice.weight for choice, _used in feasible)
                nonbinding_upper += max(
                    choice.weight - len(used) for choice, used in feasible
                )
            upper = credit + min(
                token_upper,
                sum(remaining) + nonbinding_upper,
            )
            dual_scaled = sum(
                remaining[position] * best_prices[position]
                for position in range(len(remaining))
            )
            for feasible in feasible_by_token.values():
                dual_scaled += max(
                    scale * choice.weight
                    - sum(best_prices[position] for position in used)
                    for choice, used in feasible
                )
            upper = min(upper, credit + dual_scaled // scale)
            if upper <= best_credit:
                return
            key = (remaining_mask, remaining)
            if memo.get(key, -1) >= credit:
                return
            memo[key] = credit
            # Maximum regret first tends to decide the choices that are most
            # expensive to postpone.  This affects traversal only.
            def priority(local_token: int) -> tuple[int, int, int, int]:
                weights = sorted(
                    (choice.weight for choice, _used in feasible_by_token[local_token]),
                    reverse=True,
                )
                regret = weights[0] - (weights[1] if len(weights) > 1 else 0)
                return (
                    regret,
                    -len(weights),
                    weights[0],
                    -local_token,
                )

            local_token = max(feasible_by_token, key=priority)
            token_index = ordered_tokens[local_token]
            for choice, used_positions in feasible_by_token[local_token]:
                next_remaining = list(remaining)
                for position in used_positions:
                    next_remaining[position] -= 1
                choices_so_far[token_index] = choice
                dfs(
                    remaining_mask ^ (1 << local_token),
                    tuple(next_remaining),
                    credit + choice.weight,
                    choices_so_far,
                )
                del choices_so_far[token_index]

        dfs((1 << len(ordered_tokens)) - 1, local_capacity, 0, {})
        if best_selection is None:
            raise AssertionError("component solver returned no solution")
        total_credit += best_credit
        for token_index, choice in best_selection.items():
            if choice.original is not None:
                selected[token_index] = choice.original

    # Replay the uncompressed literal solution and all constraints.
    used = defaultdict(int)
    replay_credit = 0
    for token_index, choice in selected.items():
        token = tokens[token_index]
        if choice not in token.choices:
            raise AssertionError("compressed solution is not a literal choice")
        replay_credit += len(choice.residues)
        for residue in choice.residues:
            used[residue] += 1
    if replay_credit != total_credit:
        raise AssertionError("compressed objective changed on replay")
    if any(used[residue] > capacity[residue] for residue in used):
        raise AssertionError("replayed solution exceeds capacity")
    return (
        total_credit,
        selected,
        len(binding),
        len(components),
        max(map(len, components), default=0),
        nodes,
    )


def greedy_lower_bound(
    candidates: tuple[int, ...],
    vertices: tuple[int, ...],
    bad_sets: dict[int, frozenset[int]],
    tokens: tuple[Token, ...],
    rounds: int = 256,
    seed: int = 20260802,
) -> tuple[int, dict[int, Choice]]:
    """Construct a reproducible feasible packing; makes no optimality claim."""

    capacity = {
        residue: max(
            0, sum(residue in bad_sets[speed] for speed in vertices) - 1
        )
        for residue in candidates
    }
    generator = random.Random(seed)
    best_credit = 0
    best_selection: dict[int, Choice] = {}
    base = list(range(len(tokens)))
    for round_index in range(rounds):
        order = list(base)
        if round_index == 0:
            order.sort(
                key=lambda index: (
                    -max(map(lambda choice: len(choice.residues), tokens[index].choices)),
                    len(tokens[index].choices),
                    tokens[index].owner,
                    tokens[index].target,
                )
            )
        elif round_index == 1:
            order.sort(key=lambda index: (len(tokens[index].choices), index))
        else:
            generator.shuffle(order)
        remaining = dict(capacity)
        selection = {}
        credit = 0
        for token_index in order:
            feasible = [
                choice
                for choice in tokens[token_index].choices
                if all(remaining[residue] > 0 for residue in choice.residues)
            ]
            if not feasible:
                continue
            maximum = max(map(lambda choice: len(choice.residues), feasible))
            tied = [choice for choice in feasible if len(choice.residues) == maximum]
            choice = tied[0] if round_index < 2 else generator.choice(tied)
            selection[token_index] = choice
            credit += len(choice.residues)
            for residue in choice.residues:
                remaining[residue] -= 1
        # Coordinate improvement with exact release/reinsert feasibility.
        changed = True
        while changed:
            changed = False
            for token_index in base:
                old = selection.get(token_index)
                if old is not None:
                    for residue in old.residues:
                        remaining[residue] += 1
                    credit -= len(old.residues)
                feasible = [
                    choice
                    for choice in tokens[token_index].choices
                    if all(remaining[residue] > 0 for residue in choice.residues)
                ]
                new = max(
                    feasible,
                    key=lambda choice: (len(choice.residues), -choice.parent),
                    default=None,
                )
                if new is not None:
                    selection[token_index] = new
                    credit += len(new.residues)
                    for residue in new.residues:
                        remaining[residue] -= 1
                else:
                    selection.pop(token_index, None)
                if (0 if old is None else len(old.residues)) < (
                    0 if new is None else len(new.residues)
                ):
                    changed = True
        if credit > best_credit:
            best_credit = credit
            best_selection = dict(selection)
    return best_credit, best_selection


def audit_pivot(speeds: tuple[int, ...], pivot: int) -> PackingReport:
    candidates, vertices, bad_sets, tokens = literal_instance(speeds, pivot)
    optimum, selected_indices, binding, components, largest, nodes = solve_exact(
        candidates, vertices, bad_sets, tokens
    )
    bad_sum = sum(map(len, bad_sets.values()))
    union = frozenset().union(*bad_sets.values())
    selected = tuple(
        (
            tokens[index].owner,
            tokens[index].target,
            choice.parent,
            tuple(sorted(choice.residues)),
        )
        for index, choice in sorted(
            selected_indices.items(),
            key=lambda item: (
                tokens[item[0]].owner,
                tokens[item[0]].target,
                item[1].parent,
            ),
        )
    )
    required = bad_sum - len(candidates)
    return PackingReport(
        speeds=speeds,
        pivot=pivot,
        candidate_count=len(candidates),
        bad_sum=bad_sum,
        union_size=len(union),
        union_debt=bad_sum - len(union),
        required_credit=required,
        optimum_credit=optimum,
        certified_bound=bad_sum - optimum,
        succeeds_strictly=optimum > required,
        token_count=len(tokens),
        variable_count=sum(len(token.choices) for token in tokens),
        binding_residues=binding,
        components=components,
        largest_component=largest,
        search_nodes=nodes,
        selected=selected,
    )


def audit_feasible_pivot(
    speeds: tuple[int, ...], pivot: int, rounds: int = 256
) -> FeasibleReport:
    """Replay a deterministic feasible lower bound without claiming optimality."""

    candidates, vertices, bad_sets, tokens = literal_instance(speeds, pivot)
    credit, indexed = greedy_lower_bound(
        candidates, vertices, bad_sets, tokens, rounds=rounds
    )
    capacity = {
        residue: max(
            0, sum(residue in bad_sets[speed] for speed in vertices) - 1
        )
        for residue in candidates
    }
    used = defaultdict(int)
    replay = 0
    for token_index, choice in indexed.items():
        if choice not in tokens[token_index].choices:
            raise AssertionError("greedy certificate is not a literal block")
        replay += len(choice.residues)
        for residue in choice.residues:
            used[residue] += 1
    if replay != credit or any(
        used[residue] > capacity[residue] for residue in used
    ):
        raise AssertionError("greedy certificate failed literal replay")
    bad_sum = sum(map(len, bad_sets.values()))
    union = frozenset().union(*bad_sets.values())
    selected = tuple(
        (
            tokens[index].owner,
            tokens[index].target,
            choice.parent,
            tuple(sorted(choice.residues)),
        )
        for index, choice in sorted(
            indexed.items(),
            key=lambda item: (
                tokens[item[0]].owner,
                tokens[item[0]].target,
                item[1].parent,
            ),
        )
    )
    required = bad_sum - len(candidates)
    return FeasibleReport(
        speeds=speeds,
        pivot=pivot,
        required_credit=required,
        feasible_credit=credit,
        union_debt_upper=bad_sum - len(union),
        succeeds_strictly=credit > required,
        rounds=rounds,
        selected=selected,
    )


STRESS_CASES = {
    "RF": (2, 3, 7, 9, 10, 12, 15, 16, 19),
    "GCD1": (8, 15, 35, 40, 48, 56, 63, 75, 78),
    "GCD2": (6, 8, 15, 21, 28, 35, 40, 48, 75),
    "hardA": (1, 2, 5, 7, 9, 11, 12, 13),
    "hardB": (1, 5, 7, 8, 9, 11, 13, 15),
    "small": (1, 2, 3, 5),
    "D": (10, 37, 45, 51, 54, 56, 61, 71, 91),
    "C": (8, 15, 35, 40, 48, 56, 68, 75, 78),
    "E": (5, 28, 35, 40, 68, 88, 108, 148, 165),
}


def audit_stress_set(rounds: int = 64) -> tuple[tuple[str, FeasibleReport], ...]:
    """Find and replay one successful pivot on each fixed prior stress tuple."""

    result = []
    for name, speeds in STRESS_CASES.items():
        witness = None
        for pivot in speeds:
            report = audit_feasible_pivot(speeds, pivot, rounds=rounds)
            if report.succeeds_strictly:
                witness = report
                break
        if witness is None:
            raise AssertionError(f"no packing witness found for stress case {name}")
        result.append((name, witness))
    return tuple(result)


def audit_tuple(speeds: tuple[int, ...]) -> tuple[PackingReport, ...]:
    if tuple(sorted(speeds)) != speeds or any(speed <= 0 for speed in speeds):
        raise ValueError("speeds must be positive, distinct, and increasing")
    if gcd(*speeds) != 1:
        raise ValueError("tuple must be primitive")
    return tuple(audit_pivot(speeds, pivot) for pivot in speeds)


def main() -> None:
    # The exact list is intentionally bounded to rows that complete quickly
    # under the pure-Python solver.  Other rows are reported only as replayed
    # feasible lower bounds and literal union-debt upper bounds.
    for name, speeds, pivot in (
        ("F", F, 8),
        ("G", G, 15),
        ("G", G, 21),
        ("G", G, 40),
        ("G", G, 48),
        ("G", G, 126),
    ):
        report = audit_pivot(speeds, pivot)
        print(
            "EXACT", name, pivot,
            "need/opt/debt", (
                report.required_credit,
                report.optimum_credit,
                report.union_debt,
            ),
            "components/max/nodes",
            (report.components, report.largest_component, report.search_nodes),
        )
    for name, speeds in (("F", F), ("G", G)):
        for pivot in speeds:
            report = audit_feasible_pivot(speeds, pivot)
            print(
                "BOUNDS", name, pivot,
                (report.feasible_credit, report.union_debt_upper),
                "need", report.required_credit,
                "ok", report.succeeds_strictly,
            )
    for name, report in audit_stress_set():
        print(
            "STRESS", name, report.pivot,
            report.feasible_credit, ">", report.required_credit,
        )


if __name__ == "__main__":
    main()
