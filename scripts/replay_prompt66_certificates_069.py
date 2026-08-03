#!/usr/bin/env python3
"""Independent, deterministic replay of the frozen Prompt66 audit.

This verifier deliberately treats the supplied ZIP as data.  It implements the
finite modular definitions in the Prompt66 contract directly and checks the
published witness, rational-dual, branch-tree, and two criterion certificates.
It never imports or executes any supplied solver or replay source.
"""

from __future__ import annotations

import argparse
import hashlib
import json
import platform
import sys
import time
import zipfile
from collections import Counter, defaultdict
from dataclasses import dataclass
from fractions import Fraction
from pathlib import Path
from typing import Any, BinaryIO, Iterable, Iterator, Mapping, Sequence


BASE_COMMIT = "136e9c6e0eeeb608bfe943762969bdc412745da0"
BUNDLE_CONCEPTUAL_PATH = (
    "research/sol-pro/artifacts/prompt66/"
    "SOL-P66-PRO-B-001-artifacts.zip"
)
UNPACKED_CONCEPTUAL_PATH = "research/sol-pro/artifacts/prompt66/unpacked"
EXPECTED_BUNDLE_BYTES = 7_235_209
EXPECTED_BUNDLE_SHA256 = (
    "4fc0f17d8feda472c6a20a7af7d2bdbdcb2f02ae82586d6d153ebcc2430fdea8"
)
EXPECTED_PROMPT_RAW_SHA256 = (
    "fc4300e55e72d00a70fc25b63f9504b42923714e1e7f95bc81c22ee42b9d5d24"
)
EXPECTED_PROMPT_UI_SHA256 = (
    "3f4e4acbc21e0fd97c5a4ca318c519c0db89ad5b358450cffdbdf80f238da9e5"
)

BASE_CASES: tuple[tuple[str, tuple[int, ...]], ...] = (
    ("F", (8, 15, 35, 40, 48, 56, 75, 132, 147)),
    ("G", (15, 21, 40, 48, 56, 105, 126, 280, 1200)),
    ("RF", (2, 3, 7, 9, 10, 12, 15, 16, 19)),
    ("GCD1", (8, 15, 35, 40, 48, 56, 63, 75, 78)),
    ("GCD2", (6, 8, 15, 21, 28, 35, 40, 48, 75)),
    ("hardA", (1, 2, 5, 7, 9, 11, 12, 13)),
    ("hardB", (1, 5, 7, 8, 9, 11, 13, 15)),
    ("small", (1, 2, 3, 5)),
    ("D", (10, 37, 45, 51, 54, 56, 61, 71, 91)),
    ("C", (8, 15, 35, 40, 48, 56, 68, 75, 78)),
    ("E", (5, 28, 35, 40, 68, 88, 108, 148, 165)),
)
MUTATION_DELTAS = (-3, -2, -1, 1, 2, 3)

EXPECTED_ZIP_ENTRIES: tuple[str, ...] = (
    "SOL-P66-PRO-B-001-report.md",
    "prompt66_user_contract.md",
    "p66_execution_manifest.json",
    "p66_first_obstructions.json",
    "p66_base_witness_digest.json",
    "p66_solver.py",
    "p66_modular_attacks.py",
    "p66_replay.py",
    "p66_replay_pre_schema_fix.py",
    "run3/p66_transcript.jsonl",
    "run3/p66_certificates.jsonl",
    "run3/p66_summary.json",
    "run3/p66_replay_report.json",
    "run3/solver_progress.log",
    "attacks/p66_attack_radial_descent_transcript.jsonl",
    "attacks/p66_attack_radial_descent_certificates.jsonl",
    "attacks/p66_attack_radial_descent_summary.json",
    "attacks/p66_attack_signed_phase_cells_transcript.jsonl",
    "attacks/p66_attack_signed_phase_cells_certificates.jsonl",
    "attacks/p66_attack_signed_phase_cells_summary.json",
    "attacks/p66_attacks_summary.json",
)


class AuditError(RuntimeError):
    """A replay obligation failed."""


def require(condition: bool, message: str) -> None:
    if not condition:
        raise AuditError(message)


def sha256_bytes(data: bytes) -> str:
    return hashlib.sha256(data).hexdigest()


def sha256_stream(stream: BinaryIO) -> tuple[int, str]:
    digest = hashlib.sha256()
    size = 0
    while True:
        chunk = stream.read(1024 * 1024)
        if not chunk:
            break
        size += len(chunk)
        digest.update(chunk)
    return size, digest.hexdigest()


def json_bytes(value: Any) -> bytes:
    return json.dumps(value, sort_keys=True, separators=(",", ":")).encode(
        "utf-8"
    )


def read_entry(zf: zipfile.ZipFile, name: str) -> bytes:
    try:
        return zf.read(name)
    except KeyError as exc:
        raise AuditError(f"missing ZIP entry: {name}") from exc


def read_json(zf: zipfile.ZipFile, name: str) -> Any:
    try:
        return json.loads(read_entry(zf, name).decode("utf-8"))
    except (UnicodeDecodeError, json.JSONDecodeError) as exc:
        raise AuditError(f"invalid JSON entry: {name}: {exc}") from exc


def read_jsonl(zf: zipfile.ZipFile, name: str) -> list[Any]:
    try:
        text = read_entry(zf, name).decode("utf-8")
    except UnicodeDecodeError as exc:
        raise AuditError(f"invalid UTF-8 JSONL entry: {name}") from exc
    rows: list[Any] = []
    for line_no, line in enumerate(text.splitlines(), 1):
        try:
            rows.append(json.loads(line))
        except json.JSONDecodeError as exc:
            raise AuditError(f"invalid JSONL {name}:{line_no}: {exc}") from exc
    return rows


def parse_fraction(value: Sequence[int], label: str) -> Fraction:
    require(
        isinstance(value, (list, tuple)) and len(value) == 2,
        f"{label}: malformed rational {value!r}",
    )
    numerator, denominator = value
    require(
        isinstance(numerator, int) and isinstance(denominator, int),
        f"{label}: rational components are not integers",
    )
    require(denominator > 0, f"{label}: nonpositive denominator")
    return Fraction(numerator, denominator)


def parse_price(value: Sequence[int], label: str) -> Fraction:
    require(
        isinstance(value, (list, tuple)) and len(value) == 3,
        f"{label}: malformed price {value!r}",
    )
    _, numerator, denominator = value
    require(
        isinstance(numerator, int) and isinstance(denominator, int),
        f"{label}: price components are not integers",
    )
    require(numerator >= 0 and denominator > 0, f"{label}: invalid price")
    return Fraction(numerator, denominator)


@dataclass(frozen=True)
class Token:
    index: int
    owner: int
    target: int
    fiber: tuple[int, ...]
    parents: tuple[int, ...]
    blocks: tuple[tuple[int, ...], ...]


@dataclass(frozen=True)
class Model:
    speeds: tuple[int, ...]
    pivot: int
    n: int
    N: int
    M: int
    residues: tuple[int, ...]
    bad: Mapping[int, frozenset[int]]
    all_tokens: tuple[tuple[int, int, tuple[int, ...], tuple[int, ...]], ...]
    active_tokens: tuple[Token, ...]
    mu: Mapping[int, int]
    capacity: Mapping[int, int]
    S: int
    union: frozenset[int]
    variables: tuple[tuple[int, int, tuple[int, ...]], ...]

    def rho(self, value: int) -> int:
        remainder = value % self.M
        return min(remainder, self.M - remainder)


def build_model(speeds: Sequence[int], pivot: int) -> Model:
    ordered = tuple(speeds)
    require(ordered == tuple(sorted(ordered)), "tuple is not sorted")
    require(len(ordered) == len(set(ordered)), "tuple is not injective")
    require(all(value > 0 for value in ordered), "tuple is not positive")
    require(pivot in ordered, f"pivot {pivot} not in tuple")
    n = len(ordered)
    N = n + 1
    M = N * pivot
    residues = tuple(r for r in range(M) if r % N != 0)
    bad: dict[int, frozenset[int]] = {}
    fibers: dict[int, dict[int, tuple[int, ...]]] = {}
    for owner in ordered:
        if owner == pivot:
            continue
        by_target: dict[int, list[int]] = defaultdict(list)
        bad_points: list[int] = []
        for residue in residues:
            target = (residue * owner) % M
            if min(target, M - target) < pivot:
                bad_points.append(residue)
                by_target[target].append(residue)
        bad[owner] = frozenset(bad_points)
        fibers[owner] = {
            target: tuple(points) for target, points in by_target.items()
        }

    # This is the canonical pivot equivalence, checked literally for every
    # grid point rather than assumed from the definition.
    for residue in residues:
        require(
            min((residue * pivot) % M, M - ((residue * pivot) % M)) >= pivot,
            f"pivot safety failed at residue {residue}",
        )

    all_tokens_list: list[tuple[int, int, tuple[int, ...], tuple[int, ...]]] = []
    for owner in ordered:
        if owner == pivot:
            continue
        for target in sorted(fibers[owner]):
            fiber = fibers[owner][target]
            parents: list[int] = []
            blocks: list[tuple[int, ...]] = []
            for parent in ordered:
                if parent in (owner, pivot):
                    continue
                block = tuple(residue for residue in fiber if residue in bad[parent])
                if block:
                    parents.append(parent)
                    blocks.append(block)
            all_tokens_list.append((owner, target, fiber, tuple(parents)))

    active: list[Token] = []
    for owner, target, fiber, potential_parents in all_tokens_list:
        parents = tuple(potential_parents)
        blocks = tuple(
            tuple(residue for residue in fiber if residue in bad[parent])
            for parent in parents
        )
        if not parents:
            continue
        active.append(
            Token(len(active), owner, target, fiber, parents, blocks)
        )

    mu: dict[int, int] = {}
    for residue in residues:
        mu[residue] = sum(residue in bad[owner] for owner in bad)
    # The contract uses natural subtraction: points with no bad owner have
    # capacity zero, not a negative capacity.
    capacity = {residue: max(0, mu[residue] - 1) for residue in residues}
    union: set[int] = set()
    S = 0
    for points in bad.values():
        union.update(points)
        S += len(points)
    variables = tuple(
        (token.index, choice, token.blocks[choice])
        for token in active
        for choice in range(len(token.parents))
    )
    return Model(
        ordered,
        pivot,
        n,
        N,
        M,
        residues,
        bad,
        tuple(all_tokens_list),
        tuple(active),
        mu,
        capacity,
        S,
        frozenset(union),
        variables,
    )


def mutation_cases() -> tuple[dict[str, Any], ...]:
    """Return the exact ordered modular cases after preflight case 0."""
    cases: list[dict[str, Any]] = []
    case_number = 1
    for name, base in BASE_CASES:
        cases.extend(
            {
                "case": case_number + offset,
                "name": name,
                "speeds": base,
                "pivot": pivot,
                "descriptor": {"base": name},
                "tuple_kind": "base",
            }
            for offset, pivot in enumerate(base)
        )
        case_number += len(base)
    for name, base in BASE_CASES:
        for coordinate, old_value in enumerate(base):
            for delta in MUTATION_DELTAS:
                replacement = old_value + delta
                if replacement <= 0:
                    continue
                mutated = list(base)
                mutated[coordinate] = replacement
                if len(set(mutated)) != len(mutated):
                    continue
                speeds = tuple(sorted(mutated))
                descriptor = {
                    "base": name,
                    "coordinate": coordinate,
                    "delta": delta,
                }
                cases.extend(
                    {
                        "case": case_number + offset,
                        "name": name,
                        "speeds": speeds,
                        "pivot": pivot,
                        "descriptor": descriptor,
                        "tuple_kind": "mutation",
                    }
                    for offset, pivot in enumerate(speeds)
                )
                case_number += len(speeds)
    return tuple(cases)


def verify_zip_integrity(
    zf: zipfile.ZipFile,
) -> tuple[dict[str, dict[str, Any]], dict[str, Any]]:
    infos = zf.infolist()
    names = [info.filename for info in infos]
    require(names == list(EXPECTED_ZIP_ENTRIES), "ZIP entry inventory/order mismatch")
    require(len(names) == 21, "ZIP entry count is not exactly 21")
    require(len(set(names)) == len(names), "ZIP contains duplicate entry names")
    for name in names:
        require(
            not name.startswith("/")
            and "\\" not in name
            and ".." not in name.split("/")
            and name != ""
            and not name.endswith("/"),
            f"unsafe ZIP entry path: {name!r}",
        )

    entries: dict[str, dict[str, Any]] = {}
    for name in names:
        with zf.open(name, "r") as stream:
            size, digest = sha256_stream(stream)
        info = zf.getinfo(name)
        require(size == info.file_size, f"ZIP size disagreement for {name}")
        entries[name] = {"bytes": size, "sha256": digest}

    manifest = read_json(zf, "p66_execution_manifest.json")
    require(isinstance(manifest, dict), "execution manifest is not an object")
    listed = manifest.get("final_artifacts")
    require(isinstance(listed, dict), "execution manifest has no final_artifacts")
    for name, expected in listed.items():
        require(name in entries, f"manifest lists absent artifact {name}")
        require(
            entries[name] == expected,
            f"manifest size/hash mismatch for {name}: {entries[name]} != {expected}",
        )
    return entries, manifest


def verify_prompt_provenance(zf: zipfile.ZipFile, manifest: Mapping[str, Any]) -> None:
    raw = read_entry(zf, "prompt66_user_contract.md")
    require(sha256_bytes(raw) == EXPECTED_PROMPT_RAW_SHA256, "raw prompt hash mismatch")
    require(
        manifest.get("input", {}).get("prompt_sha256") == EXPECTED_PROMPT_RAW_SHA256,
        "manifest prompt hash mismatch",
    )
    require(
        sha256_bytes(raw.rstrip(b"\r\n")) == EXPECTED_PROMPT_UI_SHA256,
        "UI-readback prompt hash is not raw hash minus trailing line terminators",
    )
    require(
        raw.endswith(b"\n") and not raw.rstrip(b"\r\n").endswith(b"\n"),
        "prompt provenance did not remove exactly its trailing terminator",
    )


def verify_triangle(row: Mapping[str, Any]) -> None:
    expected = {
        "case": 0,
        "fractional_optimum": "3/1",
        "fractional_point_loads": ["1", "1", "1"],
        "integer_credit_units": 2,
        "integer_optimum": 2,
        "integer_selected_blocks_max": 1,
        "kind": "abstract_triangle",
        "method_obstruction": True,
    }
    require(dict(row) == expected, "abstract triangle preflight mismatch")
    # Direct finite replay: any two of {x,y},{y,z},{z,x} share a point, so
    # unit capacities permit one whole block; the three half-block choices
    # have point load one and total fractional credit three.
    blocks = ((0, 1), (1, 2), (2, 0))
    for first in range(3):
        for second in range(first + 1, 3):
            require(set(blocks[first]).intersection(blocks[second]), "triangle disjointness error")


def verify_case_metadata(row: Mapping[str, Any], case: Mapping[str, Any], model: Model) -> None:
    for key in ("case", "name", "descriptor", "tuple_kind"):
        require(row.get(key) == case[key], f"case metadata mismatch for {key}")
    require(tuple(row.get("speeds", ())) == case["speeds"], "speed order mismatch")
    require(row.get("N") == model.N and row.get("M") == model.M, "N/M mismatch")
    require(row.get("R") == len(model.residues), "grid cardinality mismatch")
    require(row.get("S") == model.S, "S mismatch")
    require(row.get("union") == len(model.union), "union cardinality mismatch")
    require(row.get("all_tokens") == len(model.all_tokens), "all-token count mismatch")
    require(row.get("active_tokens") == len(model.active_tokens), "active-token count mismatch")
    require(row.get("variables") == len(model.variables), "variable count mismatch")
    require(
        row.get("required_credit") == model.S - len(model.residues),
        "strict boundary mismatch",
    )


def verify_selection(
    model: Model,
    selection: Sequence[Mapping[str, Any]],
    label: str,
) -> tuple[int, dict[int, int], dict[int, int]]:
    selected: dict[int, int] = {}
    use: Counter[int] = Counter()
    credit = 0
    for ordinal, item in enumerate(selection):
        require(isinstance(item, dict), f"{label}: selection item is not an object")
        try:
            token_index = item["token_index"]
            owner = item["owner"]
            target = item["target"]
            parent = item["parent"]
            supplied_residues = item["residues"]
        except KeyError as exc:
            raise AuditError(f"{label}: missing selection field {exc}") from exc
        require(
            isinstance(token_index, int) and 0 <= token_index < len(model.active_tokens),
            f"{label}: invalid token index at {ordinal}",
        )
        require(token_index not in selected, f"{label}: token selected twice")
        token = model.active_tokens[token_index]
        require(owner == token.owner and target == token.target, f"{label}: token identity mismatch")
        require(parent in token.parents, f"{label}: ineligible parent")
        choice = token.parents.index(parent)
        block = token.blocks[choice]
        require(block, f"{label}: selected empty block")
        require(
            isinstance(supplied_residues, list)
            and len(supplied_residues) == len(set(supplied_residues))
            and set(supplied_residues) == set(block),
            f"{label}: whole-block residue mismatch for token {token_index}",
        )
        # The model's owner/parent construction enforces the only parent
        # distinctness required by the contract; no cross-token injectivity is
        # imposed here.
        require(parent != owner and parent != model.pivot, f"{label}: invalid parent identity")
        selected[token_index] = choice
        credit += len(block)
        for residue in block:
            use[residue] += 1

    for residue, count in use.items():
        require(
            count <= model.capacity[residue],
            f"{label}: capacity exceeded at residue {residue}",
        )
    return credit, selected, dict(use)


def verify_dual(
    model: Model,
    dual: Mapping[str, Any],
    expected_variables: Iterable[tuple[int, int, tuple[int, ...]]],
    capacities: Mapping[int, int],
    label: str,
    branch_leaf: bool = False,
) -> Fraction:
    variables = tuple(expected_variables)
    # The two zero-variable rows omit all optional dual metadata in the
    # supplied schema.  Their empty dual is still checked literally: there
    # are no block variables, no token or residue prices, and the exact upper
    # bound is zero.  This is a schema repair for a degenerate case, not a
    # relaxation of any nonempty certificate.
    if not variables:
        require(dual.get("residue_prices") == [], f"{label}: nonempty zero-row residue prices")
        require(dual.get("token_prices") == [], f"{label}: nonempty zero-row token prices")
        require(parse_fraction(dual.get("objective"), f"{label}: zero-row objective") == 0, f"{label}: zero-row objective")
        return Fraction(0)
    if branch_leaf:
        require(
            dual.get("kind") in (None, "exact_rational_weak_dual"),
            f"{label}: wrong branch-leaf dual kind",
        )
    else:
        require(dual.get("kind") == "exact_rational_weak_dual", f"{label}: wrong dual kind")
    residue_prices = dual.get("residue_prices")
    token_prices = dual.get("token_prices")
    require(isinstance(residue_prices, list), f"{label}: malformed residue prices")
    require(isinstance(token_prices, list), f"{label}: malformed token prices")
    residue_values: dict[int, Fraction] = {}
    last_index = -1
    for entry in residue_prices:
        require(len(entry) == 3, f"{label}: malformed residue price")
        index = entry[0]
        require(isinstance(index, int) and index > last_index, f"{label}: residue prices not ordered")
        require(index in model.residues, f"{label}: residue price outside R")
        residue_values[index] = parse_price(entry, f"{label}: residue {index}")
        last_index = index
    token_values: dict[int, Fraction] = {}
    last_index = -1
    for entry in token_prices:
        require(len(entry) == 3, f"{label}: malformed token price")
        index = entry[0]
        require(isinstance(index, int) and index > last_index, f"{label}: token prices not ordered")
        require(0 <= index < len(model.active_tokens), f"{label}: token price outside active tokens")
        token_values[index] = parse_price(entry, f"{label}: token {index}")
        last_index = index
    if dual.get("priced_residue_count") is not None:
        require(
            dual.get("priced_residue_count") == len(residue_prices),
            f"{label}: priced residue count mismatch",
        )
    active_token_indices = {token_index for token_index, _choice, _block in variables}
    if dual.get("token_count") is not None:
        require(
            dual.get("token_count") == len(active_token_indices),
            f"{label}: token count mismatch",
        )
    if dual.get("variable_count") is not None:
        require(dual.get("variable_count") == len(variables), f"{label}: variable count mismatch")

    objective = Fraction(0)
    for residue, price in residue_values.items():
        objective += capacities[residue] * price
    for token_index in active_token_indices:
        objective += token_values.get(token_index, Fraction(0))

    for token_index, _choice, block in variables:
        lhs = token_values.get(token_index, Fraction(0))
        lhs += sum((residue_values.get(residue, Fraction(0)) for residue in block), Fraction(0))
        require(lhs >= len(block), f"{label}: dual constraint violated for token {token_index}")
    stated = parse_fraction(dual.get("objective"), f"{label}: objective")
    require(objective == stated, f"{label}: objective mismatch {objective} != {stated}")
    return objective


def verify_branch_tree(model: Model, certificate: Mapping[str, Any], target: int, label: str) -> int:
    branch = certificate.get("lp_branch_certificate")
    require(isinstance(branch, dict), f"{label}: missing branch certificate")
    require(branch.get("kind") == "exact_rational_lp_branch_tree", f"{label}: wrong branch kind")
    variable_residues = tuple(sorted({residue for _ti, _ci, block in model.variables for residue in block}))
    require(tuple(branch.get("all_residues", ())) == variable_residues, f"{label}: all_residues mismatch")
    require(branch.get("target") == target, f"{label}: branch target mismatch")

    initial_available = frozenset((ti, ci) for ti, ci, _block in model.variables)
    initial_capacity = dict(model.capacity)
    leaf_count = 0
    node_count = 0
    maximum_depth = 0
    leaf_upper_bounds: list[int] = []

    def visit(
        node: Mapping[str, Any],
        available: frozenset[tuple[int, int]],
        capacities: Mapping[int, int],
        accumulated: int,
        depth: int,
    ) -> None:
        nonlocal leaf_count, node_count, maximum_depth
        require(isinstance(node, dict), f"{label}: branch node is not an object")
        node_count += 1
        maximum_depth = max(maximum_depth, depth)
        node_type = node.get("type")
        if node_type == "dual_leaf":
            leaf_count += 1
            require(node.get("accumulated") == accumulated, f"{label}: accumulated mismatch at leaf")
            require(
                node.get("floor_remaining_upper") is not None,
                f"{label}: missing floor at leaf",
            )
            variables = tuple(
                (ti, ci, model.active_tokens[ti].blocks[ci])
                for ti, ci in sorted(available)
            )
            dual = node.get("dual")
            require(isinstance(dual, dict), f"{label}: missing leaf dual")
            objective = verify_dual(
                model,
                dual,
                variables,
                capacities,
                f"{label}: leaf {leaf_count}",
                branch_leaf=True,
            )
            require(
                dual.get("remaining_variable_count") == len(variables),
                f"{label}: remaining variable count mismatch",
            )
            require(
                objective.numerator // objective.denominator == node["floor_remaining_upper"],
                f"{label}: floor upper mismatch",
            )
            require(
                accumulated + node["floor_remaining_upper"] <= target,
                f"{label}: leaf does not prove target upper bound",
            )
            leaf_upper_bounds.append(accumulated + objective.numerator // objective.denominator)
            return

        require(node_type == "branch", f"{label}: unexpected branch node type {node_type!r}")
        token_index = node.get("token_index")
        choice_index = node.get("choice_index")
        require(
            isinstance(token_index, int)
            and isinstance(choice_index, int)
            and (token_index, choice_index) in available,
            f"{label}: branch choice is not available",
        )
        token = model.active_tokens[token_index]
        block = token.blocks[choice_index]
        for residue in block:
            require(
                capacities[residue] >= 1,
                f"{label}: select branch starts over capacity",
            )
        forbidden = frozenset(item for item in available if item != (token_index, choice_index))
        selected_available = frozenset(
            item for item in available if item[0] != token_index
        )
        selected_capacity = dict(capacities)
        for residue in block:
            selected_capacity[residue] -= 1
        require("forbid" in node and "select" in node, f"{label}: branch is not binary")
        visit(node["forbid"], forbidden, dict(capacities), accumulated, depth + 1)
        visit(
            node["select"],
            selected_available,
            selected_capacity,
            accumulated + len(block),
            depth + 1,
        )

    visit(branch.get("root"), initial_available, initial_capacity, 0, 0)
    require(branch.get("nodes") == node_count, f"{label}: node count mismatch")
    require(branch.get("leaves") == leaf_count, f"{label}: leaf count mismatch")
    require(branch.get("max_depth") == maximum_depth, f"{label}: depth mismatch")
    require(leaf_count > 0, f"{label}: empty branch tree")
    return max(leaf_upper_bounds)


def verify_main_case(
    row: Mapping[str, Any],
    certificate: Mapping[str, Any],
    case: Mapping[str, Any],
    model: Model,
) -> tuple[str, bool]:
    verify_case_metadata(row, case, model)
    require(
        certificate.get("case") == row["case"]
        and certificate.get("name") == row["name"]
        and certificate.get("pivot") == row["pivot"]
        and tuple(certificate.get("speeds", ())) == model.speeds
        and certificate.get("descriptor") == row["descriptor"]
        and certificate.get("tuple_kind") == row["tuple_kind"]
        and certificate.get("N") == model.N
        and certificate.get("M") == model.M,
        f"certificate identity mismatch at case {row['case']}",
    )
    selection = certificate.get("selection")
    require(isinstance(selection, list), f"case {row['case']}: missing selection")
    credit, _selected, _use = verify_selection(model, selection, f"case {row['case']}")
    require(row.get("credit") == credit, f"case {row['case']}: credit mismatch")
    strict = len(model.residues) + credit > model.S
    require(row.get("strict") is strict, f"case {row['case']}: strict flag mismatch")

    status = row.get("status")
    if status == "packing_witness":
        require(strict, f"case {row['case']}: witness does not pass strict threshold")
        require(row.get("exact_optimum") is False, f"case {row['case']}: witness marked exact")
        require(row.get("upper_bound") is None, f"case {row['case']}: witness has upper bound")
        return status, False

    require(not strict, f"case {row['case']}: failure certificate passes strict threshold")
    require(row.get("exact_optimum") is True, f"case {row['case']}: failure not exact")
    search = certificate.get("exact_search_certificate")
    require(isinstance(search, dict), f"case {row['case']}: missing exact search certificate")
    if status == "fixed_pivot_failure_dual":
        dual = search.get("dual_certificate")
        require(isinstance(dual, dict), f"case {row['case']}: missing rational dual")
        objective = verify_dual(model, dual, model.variables, model.capacity, f"case {row['case']}")
        require(row.get("upper_bound_kind") == "exact_rational_weak_dual", f"case {row['case']}: upper kind")
        require(parse_fraction(row.get("upper_bound"), f"case {row['case']}: row upper") == objective, f"case {row['case']}: row upper mismatch")
        require(objective.numerator // objective.denominator <= row["required_credit"], f"case {row['case']}: dual does not prove failure")
        require(credit <= objective.numerator // objective.denominator, f"case {row['case']}: lower exceeds dual upper")
        return status, objective.numerator // objective.denominator == credit

    require(status == "fixed_pivot_failure_lp_tree", f"case {row['case']}: unknown status {status!r}")
    require(row.get("upper_bound_kind") == "exact_rational_lp_branch_tree", f"case {row['case']}: branch upper kind")
    upper = verify_branch_tree(model, search, row["required_credit"], f"case {row['case']}")
    require(parse_fraction(row.get("upper_bound"), f"case {row['case']}: row upper") == Fraction(row["required_credit"], 1), f"case {row['case']}: branch target mismatch")
    require(credit <= row["required_credit"], f"case {row['case']}: lower exceeds branch target")
    require(upper <= row["required_credit"], f"case {row['case']}: branch does not prove failure")
    return status, upper == credit


def verify_attack(
    zf: zipfile.ZipFile,
    criterion: str,
    transcript_name: str,
    certificate_name: str,
) -> dict[str, Any]:
    transcript = read_jsonl(zf, transcript_name)
    certificates = read_jsonl(zf, certificate_name)
    require(len(transcript) == 10 and len(certificates) == 9, f"{criterion}: attack row count")
    require(
        transcript[0]
        == {
            "case": 0,
            "disposition": "method sanity only; modular criterion not applicable",
            "kind": "abstract_triangle",
        },
        f"{criterion}: attack preflight mismatch",
    )
    expected_pivots = BASE_CASES[0][1]
    model_cache = {pivot: build_model(expected_pivots, pivot) for pivot in expected_pivots}
    failures: list[dict[str, Any]] = []
    for offset, pivot in enumerate(expected_pivots, 1):
        row = transcript[offset]
        certificate = certificates[offset - 1]
        model = model_cache[pivot]
        require(row.get("criterion") == criterion, f"{criterion}: transcript criterion")
        require(row.get("case") == offset, f"{criterion}: case order")
        require(row.get("pivot") == pivot, f"{criterion}: pivot order")
        require(row.get("descriptor") == {"base": "F"}, f"{criterion}: descriptor")
        require(row.get("tuple_kind") == "base" and row.get("name") == "F", f"{criterion}: tuple identity")
        require(tuple(row.get("speeds", ())) == expected_pivots, f"{criterion}: speed order")
        require(row.get("R") == len(model.residues), f"{criterion}: R mismatch")
        require(row.get("S") == model.S, f"{criterion}: S mismatch")
        require(row.get("required_credit") == model.S - len(model.residues), f"{criterion}: boundary mismatch")
        require(certificate.get("criterion") == criterion, f"{criterion}: certificate criterion")
        require(certificate.get("pivot") == pivot and certificate.get("M") == model.M and certificate.get("N") == model.N, f"{criterion}: certificate identity")
        maxima = certificate.get("token_maxima")
        require(isinstance(maxima, list) and len(maxima) == len(model.active_tokens), f"{criterion}: maxima count")
        if criterion == "signed_phase_cells":
            cell_owner: dict[int, int] = {}
            for residue in model.residues:
                candidates = [
                    (model.rho(residue * owner) if False else 0, owner)
                    for owner in ()
                ]
                signed_candidates = []
                for owner in model.bad:
                    if residue in model.bad[owner]:
                        remainder = (residue * owner) % model.M
                        phase = remainder if remainder < pivot else remainder - model.M
                        signed_candidates.append((phase, owner))
                if signed_candidates:
                    cell_owner[residue] = min(signed_candidates)[1]
            pairs = [(residue, cell_owner[residue]) for residue in model.residues if residue in cell_owner]
            expected_cell_hash = sha256_bytes(json_bytes(pairs))
            require(certificate.get("cell_owner_sha256") == expected_cell_hash, f"{criterion}: cell-owner hash mismatch")
        else:
            cell_owner = {}

        expected_selection: list[dict[str, Any]] = []
        expected_maxima: list[dict[str, Any]] = []
        credit = 0
        tie_count = 0
        for token in model.active_tokens:
            eligible: list[tuple[int, int, tuple[int, ...]]] = []
            owner_depth = model.rho(token.target)
            for choice, parent in enumerate(token.parents):
                block = token.blocks[choice]
                if criterion == "radial_descent":
                    allowed = all(
                        model.rho(residue * parent) < model.rho(residue * token.owner)
                        for residue in block
                    )
                else:
                    allowed = all(cell_owner.get(residue) == token.owner for residue in block)
                if allowed:
                    eligible.append((len(block), parent, block))
            best = max((item[0] for item in eligible), default=0)
            tied = [parent for weight, parent, _block in eligible if weight == best]
            if len(tied) > 1:
                tie_count += 1
            credit += best
            if criterion == "radial_descent":
                expected_maxima.append(
                    {
                        "max_weight": best,
                        "owner": token.owner,
                        "owner_depth": owner_depth,
                        "target": token.target,
                        "tied_parents": tied,
                        "token_index": token.index,
                    }
                )
            else:
                expected_maxima.append(
                    {
                        "max_weight": best,
                        "owner": token.owner,
                        "target": token.target,
                        "tied_parents": tied,
                        "token_index": token.index,
                    }
                )
            if tied and best > 0:
                parent = tied[0]
                choice = token.parents.index(parent)
                expected_selection.append(
                    {
                        "owner": token.owner,
                        "parent": parent,
                        "residues": list(token.blocks[choice]),
                        "target": token.target,
                        "token_index": token.index,
                    }
                )
        require(maxima == expected_maxima, f"{criterion}: maxima mismatch at pivot {pivot}")
        require(certificate.get("selection") == expected_selection, f"{criterion}: selection mismatch at pivot {pivot}")
        selected_credit, _selected, use = verify_selection(model, expected_selection, f"{criterion} pivot {pivot}")
        require(selected_credit == credit, f"{criterion}: credit mismatch at pivot {pivot}")
        require(row.get("credit") == credit, f"{criterion}: transcript credit mismatch at pivot {pivot}")
        require(row.get("strict") is (len(model.residues) + credit > model.S), f"{criterion}: strict mismatch")
        require(row.get("ties") == tie_count, f"{criterion}: tie count mismatch")
        if criterion == "signed_phase_cells":
            require(max(use.values(), default=0) <= 1, f"{criterion}: cell blocks overlap")
            require(all(model.mu[residue] >= 2 for residue in use), f"{criterion}: selected point has one bad owner")
        failures.append({"pivot": pivot, "credit": credit, "required": row["required_credit"]})
    return {"criterion": criterion, "pivots": failures}


def verify_supporting_artifacts(
    zf: zipfile.ZipFile,
    manifest: Mapping[str, Any],
    results: Mapping[str, Any],
    base_witnesses: Mapping[tuple[str, int], Mapping[str, Any]],
) -> None:
    first = read_json(zf, "p66_first_obstructions.json")
    obstruction = first["first_modular_fixed_pivot_failure"]
    row = obstruction["transcript_row"]
    require(row["case"] == 5 and row["name"] == "F" and row["pivot"] == 48, "first obstruction identity mismatch")
    require(
        {key: row[key] for key in ("R", "S", "union", "credit", "required_credit", "upper_bound")}
        == {"R": 432, "S": 706, "union": 392, "credit": 262, "required_credit": 274, "upper_bound": [1314, 5]},
        "first obstruction values mismatch",
    )
    require(first["preflight"]["method_obstruction"] is True, "preflight obstruction lost")
    require(first["disposition"]["all_cases_exhausted"] is True, "domain was not exhausted")
    require(first["disposition"]["lemma_refutation_hit"] is None, "supplied lemma hit is not null")
    require(len(base_witnesses) == len(BASE_CASES), "base witness digest count mismatch")

    summary = read_json(zf, "run3/p66_summary.json")
    replay_report = read_json(zf, "run3/p66_replay_report.json")
    replay_main = replay_report.get("main", {})
    expected = {
        "cases_emitted": 4150,
        "modular_instances_emitted": 4149,
        "exact_fixed_pivot_failures": 435,
        "witness_pivots": 3714,
        "stopped_early": False,
        "first_lemma_refutation_hit": None,
    }
    for key, value in expected.items():
        require(summary.get(key) == value, f"run3 summary mismatch for {key}")
    require(replay_main.get("replayed_modular_instances") == 4149, "replay report row count mismatch")
    require(replay_main.get("fixed_pivot_failures") == 435, "replay report failure count mismatch")
    require(replay_main.get("dual_failure_certificates") == 421, "replay report dual count mismatch")
    require(replay_main.get("lp_branch_tree_certificates") == 14, "replay report branch count mismatch")
    require(replay_main.get("branch_failure_certificates") == 0, "replay report branch failure flag mismatch")
    require(replay_main.get("strict_witness_pivots") == 3714, "replay report witness count mismatch")
    require(replay_main.get("stopped_early") is False, "replay report says early stop")
    outcome = manifest.get("outcome", {})
    require(outcome.get("main_packing_lemma") == "open", "main lemma was promoted")
    require(outcome.get("unrestricted_lrc") == "open", "LRC was promoted")
    require(outcome.get("lemma_refutation_hit") is None, "manifest claims a lemma hit")
    for criterion in ("uniform_radial_descent", "uniform_signed_phase_cells"):
        require(outcome.get(criterion) == "rejected on complete F pivot bundle", f"criterion status mismatch: {criterion}")


def verify_base_witness_digest(zf: zipfile.ZipFile, replayed: Mapping[tuple[str, int], Mapping[str, Any]]) -> dict[tuple[str, int], Mapping[str, Any]]:
    digest = read_json(zf, "p66_base_witness_digest.json")
    require(isinstance(digest, list) and len(digest) == len(BASE_CASES), "base witness digest shape")
    by_key: dict[tuple[str, int], Mapping[str, Any]] = {}
    for item in digest:
        require(isinstance(item, dict), "base witness digest item shape")
        key = (item.get("name"), item.get("pivot"))
        require(key in replayed, f"base witness digest unknown pivot {key}")
        require(key not in by_key, f"duplicate base witness digest {key}")
        source = replayed[key]
        for field in ("case", "credit", "required", "speeds", "selection"):
            source_field = "required_credit" if field == "required" else field
            require(item[field] == source[source_field], f"base witness digest mismatch {key} {field}")
        by_key[key] = item
    return by_key


def file_hash(path: Path) -> tuple[int, str]:
    with path.open("rb") as stream:
        return sha256_stream(stream)


def report_text(
    bundle_size: int,
    bundle_sha256: str,
    entries: Mapping[str, Mapping[str, Any]],
    manifest: Mapping[str, Any],
    runtime: float,
    source_hashes: Mapping[str, str],
    counts: Mapping[str, Any],
    attacks: Mapping[str, Any],
) -> str:
    artifact_lines = "\n".join(
        f"| `{name}` | {entries[name]['bytes']} | `{entries[name]['sha256']}` |"
        for name in EXPECTED_ZIP_ENTRIES
    )
    radial = attacks["radial"]["pivots"]
    signed = attacks["signed"]["pivots"]
    table = "\n".join(
        f"| {r['pivot']} | {r['credit']} | {s['credit']} | {r['required']} |"
        for r, s in zip(radial, signed)
    )
    return f"""# Prompt66 independent audit — LUNA-P66-CERT-REPLAY-069

Result: `PASS` for the finite frozen-domain replay. This is independently
verified finite evidence only. It does not prove the main packing lemma.

## Scope and provenance

- Exact base commit: `{BASE_COMMIT}`.
- Read-only bundle: `{BUNDLE_CONCEPTUAL_PATH}`.
- Read-only unpacked conceptual source: `{UNPACKED_CONCEPTUAL_PATH}`.
- Bundle bytes/SHA-256: `{bundle_size}` / `{bundle_sha256}`.
- ZIP inventory: exactly 21 safe entries, ordered and path-checked.
- Raw contract SHA-256: `{EXPECTED_PROMPT_RAW_SHA256}`.
- UI-readback SHA-256 after removing exactly one trailing line terminator: `{EXPECTED_PROMPT_UI_SHA256}`.
- No network, package installation, solver binary, floating-point evidence,
  randomness, or import/execution of the supplied solver/replay was used.

The 18 hashes and sizes explicitly listed by `p66_execution_manifest.json` were
recomputed from the ZIP and all matched. The complete 21-entry inventory is
recorded below for auditability.

| ZIP entry | bytes | SHA-256 |
|---|---:|---|
{artifact_lines}

## Independent replay counts

| Quantity | Verified value |
|---|---:|
| triangle preflight | 1 |
| base tuples / base pivots | 11 / 92 |
| retained mutation descriptors (not deduplicated) | 461 |
| mutation pivots | 4,057 |
| modular rows / total cases | 4,149 / 4,150 |
| complete tuple bundles | 472 |
| strict witness pivots | {counts['witnesses']} |
| fixed-pivot failures | {counts['failures']} |
| exact rational weak-dual failures | {counts['duals']} |
| exact rational branch-tree failures | {counts['branches']} |
| exact integer optima independently certified | {counts['exact_optima']} |
| supplied exact-optimum flags not independently supported | {counts['unverified_exact_optima']} |
| all-pivot tuple hits | 0 |

Every modular row reconstructed `R`, all strict bad sets, canonical attained
targets, complete fibers, eligible whole blocks, `mu`, natural capacity `mu-1`,
`S`, and the literal bad-set union. Every supplied selection was checked for
one parent per token, parent eligibility/distinctness from its owner and pivot,
whole-block equality, exact residues, point capacities, credit, and strict
threshold. Equality was treated as failure.

The supplied transcript marks every fixed-pivot failure as `exact_optimum`.
That label was accepted only where an independently replayed feasible lower
bound coincided with the integer floor of the checked upper certificate. Rows
where the supplied selection was lower than the checked upper bound remain
verified fixed-pivot failures when the upper bound proves the threshold, but
their exact optimum label was not promoted.

## First fixed-pivot obstruction

The first fixed-pivot packing failure in the declared order is tuple `F`, pivot
speed `48`, with `R=432`, `S=706`, union size `392`, exact integer optimum
`262`, and rational upper bound `1314/5`. Its required strict credit boundary
is `274`, so the fixed-pivot packing instance fails. The same row has literal
noncoverage because its union is smaller than `R`; this does not turn the row
into an all-pivot packing refutation, an all-pivot certificate refutation, or
an LRC counterexample. No tuple had packing failure at every pivot.

## Rejected sufficient criteria on the complete nine-pivot F bundle

| Pivot | Radial-descent credit | Signed-phase-cell credit | Required strict boundary |
|---:|---:|---:|---:|
{table}

The radial-descent and signed-phase-cell data were replayed from their modular
definitions, including all per-token maxima, ties, chosen whole blocks,
capacity checks, and the signed cell-owner hash. Both criteria fail on every
pivot of `F`, so both are labeled `rejected`. This supports only rejection of
those sufficient criteria; it is not a failure of the main packing lemma.

## Toolchain and final artifact hashes

- Python: `{sys.version.split()[0]}` ({sys.implementation.name}).
- Platform: `{platform.platform()}`.
- Deterministic/no-randomness status: deterministic; no random source used.
- Runtime: `{runtime:.3f}` seconds.
- Verifier SHA-256: `{source_hashes['verifier']}`.
- Tests SHA-256: `{source_hashes['tests']}`.

The final report SHA-256 is recorded in the audit manifest. The verifier emits
the final manifest SHA-256 after writing both artifacts.

## Status labels

- `computed finite evidence`: all 4,150 frozen cases and both complete F
  criterion bundles above.
- `rejected`: radial-descent and signed-phase-cell uniform criteria.
- `open`: `ALL-PIVOT-MODULAR-WHOLE-BLOCK-PACKING` and unrestricted LRC.

No theorem, axiom, solver output, or unrestricted status was promoted.
"""


def run(bundle: Path, report_path: Path, manifest_path: Path) -> dict[str, Any]:
    started = time.perf_counter()
    bundle_size, bundle_sha256 = file_hash(bundle)
    require(bundle_size == EXPECTED_BUNDLE_BYTES, "bundle size mismatch")
    require(bundle_sha256 == EXPECTED_BUNDLE_SHA256, "bundle SHA-256 mismatch")
    cases = mutation_cases()
    require(len(cases) == 4149, "mutation case count mismatch")
    base_rows = [case for case in cases if case["tuple_kind"] == "base"]
    mutation_rows = [case for case in cases if case["tuple_kind"] == "mutation"]
    mutation_descriptors = {
        (
            case["name"],
            case["descriptor"]["coordinate"],
            case["descriptor"]["delta"],
        )
        for case in mutation_rows
    }
    require(len(base_rows) == 92, "base pivot count mismatch")
    require(len(mutation_descriptors) == 461, "retained mutation descriptor count mismatch")
    require(len(mutation_rows) == 4057, "mutation pivot count mismatch")

    with zipfile.ZipFile(bundle, "r") as zf:
        entries, execution_manifest = verify_zip_integrity(zf)
        verify_prompt_provenance(zf, execution_manifest)

        transcript = read_jsonl(zf, "run3/p66_transcript.jsonl")
        certificates = read_jsonl(zf, "run3/p66_certificates.jsonl")
        require(len(transcript) == 4150, "main transcript count mismatch")
        require(len(certificates) == 4149, "main certificate count mismatch")
        verify_triangle(transcript[0])

        witness_count = 0
        dual_count = 0
        branch_count = 0
        failure_count = 0
        exact_optimum_count = 0
        unverified_exact_optimum_count = 0
        bundle_statuses: defaultdict[tuple[str, str, str, tuple[int, ...]], list[str]] = defaultdict(list)
        base_replayed: dict[tuple[str, int], Mapping[str, Any]] = {}
        certificate_index = 0
        expected_case_index = 0
        for case in cases:
            row = transcript[expected_case_index + 1]
            certificate = certificates[certificate_index]
            expected_case_index += 1
            certificate_index += 1
            pivot = case["pivot"]
            require(row.get("pivot") == pivot, f"case {case['case']}: pivot order")
            model = build_model(case["speeds"], pivot)
            status, exact_optimum_verified = verify_main_case(row, certificate, case, model)
            if status == "packing_witness":
                witness_count += 1
            else:
                failure_count += 1
                if exact_optimum_verified:
                    exact_optimum_count += 1
                else:
                    unverified_exact_optimum_count += 1
                if status == "fixed_pivot_failure_dual":
                    dual_count += 1
                else:
                    branch_count += 1
            bundle_key = (
                case["name"],
                case["tuple_kind"],
                json.dumps(case["descriptor"], sort_keys=True, separators=(",", ":")),
                case["speeds"],
            )
            bundle_statuses[bundle_key].append(status)
            if case["tuple_kind"] == "base":
                base_replayed[(case["name"], pivot)] = {
                    "case": row["case"],
                    "credit": row["credit"],
                    "required_credit": row["required_credit"],
                    "speeds": row["speeds"],
                    "selection": certificate["selection"],
                    "status": status,
                }
        require(expected_case_index == 4149 and certificate_index == 4149, "main order count mismatch")
        require(len(bundle_statuses) == 472, "tuple bundle count mismatch")
        for bundle_key, statuses in bundle_statuses.items():
            expected_length = len(bundle_key[3])
            require(len(statuses) == expected_length, f"bundle length mismatch for {bundle_key}")
            require(not all(status != "packing_witness" for status in statuses), f"all-pivot packing hit in {bundle_key}")
        require(witness_count == 3714, "witness count mismatch")
        require(failure_count == 435, "failure count mismatch")
        require(dual_count == 421, "dual failure count mismatch")
        require(branch_count == 14, "branch failure count mismatch")
        base_digest = verify_base_witness_digest(zf, base_replayed)

        attack_radial = verify_attack(
            zf,
            "radial_descent",
            "attacks/p66_attack_radial_descent_transcript.jsonl",
            "attacks/p66_attack_radial_descent_certificates.jsonl",
        )
        attack_signed = verify_attack(
            zf,
            "signed_phase_cells",
            "attacks/p66_attack_signed_phase_cells_transcript.jsonl",
            "attacks/p66_attack_signed_phase_cells_certificates.jsonl",
        )
        verify_supporting_artifacts(
            zf,
            execution_manifest,
            {"witnesses": witness_count, "failures": failure_count},
            base_digest,
        )

    runtime = time.perf_counter() - started
    verifier_path = Path(__file__).resolve()
    tests_path = verifier_path.parent.parent / "tests" / "test_replay_prompt66_certificates_069.py"
    _, verifier_sha256 = file_hash(verifier_path)
    _, tests_sha256 = file_hash(tests_path)
    counts = {
        "witnesses": witness_count,
        "failures": failure_count,
        "duals": dual_count,
        "branches": branch_count,
        "exact_optima": exact_optimum_count,
        "unverified_exact_optima": unverified_exact_optimum_count,
    }
    source_hashes = {"verifier": verifier_sha256, "tests": tests_sha256}
    report = report_text(
        bundle_size,
        bundle_sha256,
        entries,
        execution_manifest,
        runtime,
        source_hashes,
        counts,
        {"radial": attack_radial, "signed": attack_signed},
    )
    report_path.parent.mkdir(parents=True, exist_ok=True)
    manifest_path.parent.mkdir(parents=True, exist_ok=True)
    report_path.write_text(report, encoding="utf-8", newline="\n")
    report_size, report_sha256 = file_hash(report_path)
    manifest_output = {
        "task": "LUNA-P66-CERT-REPLAY-069",
        "base_commit": BASE_COMMIT,
        "deterministic": True,
        "randomness_used": False,
        "network_used": False,
        "toolchain": {
            "python": sys.version.split()[0],
            "implementation": sys.implementation.name,
            "platform": platform.platform(),
            "standard_library_only": True,
        },
        "input": {
            "bundle_conceptual_path": BUNDLE_CONCEPTUAL_PATH,
            "unpacked_conceptual_path": UNPACKED_CONCEPTUAL_PATH,
            "read_only": True,
            "bytes": bundle_size,
            "sha256": bundle_sha256,
            "prompt_raw_sha256": EXPECTED_PROMPT_RAW_SHA256,
            "prompt_ui_readback_sha256": EXPECTED_PROMPT_UI_SHA256,
            "prompt_transform": "remove exactly one trailing LF; no other bytes changed",
        },
        "zip_audit": {
            "entry_count": len(entries),
            "safe_paths": True,
            "exact_inventory_order": list(EXPECTED_ZIP_ENTRIES),
            "entries": entries,
            "execution_manifest_final_artifacts_rechecked": len(execution_manifest["final_artifacts"]),
        },
        "counts": {
            "triangle_preflight": 1,
            "base_tuples": 11,
            "base_pivots": 92,
            "retained_mutation_descriptors": 461,
            "mutation_pivots": 4057,
            "modular_instances": 4149,
            "total_cases": 4150,
            "tuple_bundles": 472,
            "strict_witness_pivots": witness_count,
            "fixed_pivot_failures": failure_count,
            "rational_weak_dual_failures": dual_count,
            "rational_branch_tree_failures": branch_count,
            "exact_integer_optima_independently_certified": exact_optimum_count,
            "supplied_exact_optimum_flags_not_supported": unverified_exact_optimum_count,
            "all_pivot_tuple_hits": 0,
        },
        "first_fixed_pivot_obstruction": {
            "tuple": "F",
            "pivot": 48,
            "R": 432,
            "S": 706,
            "union": 392,
            "integer_optimum": 262,
            "rational_upper_bound": "1314/5",
            "required_credit": 274,
            "classification": "fixed-pivot packing failure and literal noncoverage; not all-pivot packing, all-pivot-certificate, or LRC",
        },
        "criterion_audits": {
            "radial_descent": "rejected on complete F pivot bundle",
            "signed_phase_cells": "rejected on complete F pivot bundle",
        },
        "evidence_status": {
            "main_packing_lemma": "open",
            "unrestricted_lrc": "open",
            "finite_result_label": "computed finite evidence",
        },
        "source_hashes": {
            "verifier": {"path": "scripts/replay_prompt66_certificates_069.py", "bytes": verifier_path.stat().st_size, "sha256": verifier_sha256},
            "tests": {"path": "tests/test_replay_prompt66_certificates_069.py", "bytes": tests_path.stat().st_size, "sha256": tests_sha256},
            "report": {"path": "artifacts/prompt66-independent-audit/report.md", "bytes": report_size, "sha256": report_sha256},
        },
        "runtime_seconds": round(runtime, 6),
        "notes": [
            "The verifier did not execute or import p66_solver.py, p66_replay.py, or any supplied computational source.",
            "The verifier computed the final manifest SHA-256 after writing this JSON; it is emitted on stdout because a file cannot contain its own final SHA-256 without changing it.",
        ],
    }
    manifest_path.write_text(json.dumps(manifest_output, sort_keys=True, indent=2) + "\n", encoding="utf-8", newline="\n")
    manifest_size, manifest_sha256 = file_hash(manifest_path)
    print(
        "FINAL_FILE_SHA256 "
        + json.dumps(
            {
                "verifier": verifier_sha256,
                "tests": tests_sha256,
                "report": report_sha256,
                "manifest": manifest_sha256,
                "manifest_bytes": manifest_size,
            },
            sort_keys=True,
        )
    )
    return {
        "runtime": runtime,
        "counts": counts,
        "bundle_sha256": bundle_sha256,
        "report_sha256": report_sha256,
        "manifest_sha256": manifest_sha256,
        "verifier_sha256": verifier_sha256,
        "tests_sha256": tests_sha256,
    }


def main(argv: Sequence[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--bundle", type=Path, required=True)
    parser.add_argument("--report", type=Path, required=True)
    parser.add_argument("--manifest", type=Path, required=True)
    args = parser.parse_args(argv)
    try:
        result = run(args.bundle, args.report, args.manifest)
    except (AuditError, OSError, zipfile.BadZipFile) as exc:
        print(f"AUDIT_FAILED {exc}", file=sys.stderr)
        return 1
    print(
        "AUDIT_PASS "
        + json.dumps(
            {
                "modular_instances": result["counts"]["witnesses"] + result["counts"]["failures"],
                "total_cases": 4150,
                "runtime_seconds": round(result["runtime"], 3),
            },
            sort_keys=True,
        )
    )
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
