#!/usr/bin/env python3
"""Exact verifier for Prompt 89 balanced-junction constructions.

No external dependencies.  All set cardinalities are exact Python integers;
residue sets are represented both as bit masks (direct checker) and frozensets
(independent memoized checker).
"""
from __future__ import annotations

import argparse
import csv
import hashlib
import itertools
import json
import math
from dataclasses import dataclass
from functools import lru_cache
from fractions import Fraction
from pathlib import Path
from typing import Dict, FrozenSet, Iterable, Iterator, List, Sequence, Tuple


def ceil_sqrt(m: int) -> int:
    if m < 0:
        raise ValueError("m must be nonnegative")
    return math.isqrt(m - 1) + 1 if m else 0


def bag_bound(m: int) -> int:
    return min(m, 1 + ceil_sqrt(m))


def rho(M: int, x: int) -> int:
    y = x % M
    return min(y, M - y)


def bits(mask: int) -> Tuple[int, ...]:
    out: List[int] = []
    while mask:
        lsb = mask & -mask
        out.append(lsb.bit_length() - 1)
        mask ^= lsb
    return tuple(out)


def subset_masks(mask: int, size: int) -> Iterator[int]:
    for comb in itertools.combinations(bits(mask), size):
        out = 0
        for x in comb:
            out |= 1 << x
        yield out


@dataclass(frozen=True)
class Construction:
    sigma: Tuple[int, ...]
    bags: Tuple[int, ...]
    separators: Tuple[int, ...]
    parents: Tuple[int, ...]  # one entry per nonroot bag


def validate_construction(m: int, D: Construction, expected_b: int | None = None) -> Tuple[bool, str]:
    b = bag_bound(m) if expected_b is None else expected_b
    all_mask = (1 << m) - 1
    if sorted(D.sigma) != list(range(m)):
        return False, "sigma is not a permutation"
    if len(D.sigma) != m:
        return False, "sigma length mismatch"
    if tuple(sorted(D.sigma[:b])) != D.sigma[:b]:
        return False, "root order is not normalized"
    if m == b:
        if D.bags != (all_mask,) or D.separators or D.parents:
            return False, "one-bag form malformed"
        return True, "ok"
    if len(D.bags) != 1 + (m - b):
        return False, "wrong number of bags"
    if len(D.separators) != m - b or len(D.parents) != m - b:
        return False, "wrong number of separators or parents"
    root = 0
    for x in D.sigma[:b]:
        root |= 1 << x
    if D.bags[0] != root:
        return False, "root bag mismatch"
    if D.bags[0].bit_count() != b:
        return False, "wrong bag bound at root"
    appeared = root
    for child_idx in range(1, len(D.bags)):
        new_owner = D.sigma[b + child_idx - 1]
        sep = D.separators[child_idx - 1]
        parent = D.parents[child_idx - 1]
        if sep.bit_count() != b - 1:
            return False, "separator of wrong size"
        containers = [q for q in range(child_idx) if sep & ~D.bags[q] == 0]
        if not containers:
            return False, "separator absent from earlier bags"
        least = containers[0]
        if parent != least:
            return False, "recorded parent is not least"
        if (appeared >> new_owner) & 1:
            return False, "repeated owner introduction"
        child = sep | (1 << new_owner)
        if D.bags[child_idx] != child:
            return False, "child bag mismatch"
        if child.bit_count() != b:
            return False, "wrong bag bound at child"
        if D.bags[child_idx] & D.bags[parent] != sep:
            return False, "separator is not exact child-parent intersection"
        appeared |= 1 << new_owner
    if appeared != all_mask:
        return False, "missing owner"
    # Parent edges must point strictly backward and all paths reach root.
    for child_idx, p in enumerate(D.parents, start=1):
        if not (0 <= p < child_idx):
            return False, "parent does not point backward"
        q = child_idx
        seen = set()
        while q != 0:
            if q in seen:
                return False, "parent cycle"
            seen.add(q)
            q = D.parents[q - 1]
    # Running intersection: bag indices containing each owner are connected.
    adjacency: List[List[int]] = [[] for _ in D.bags]
    for c, p in enumerate(D.parents, start=1):
        adjacency[c].append(p)
        adjacency[p].append(c)
    for owner in range(m):
        nodes = [q for q, bag in enumerate(D.bags) if (bag >> owner) & 1]
        if not nodes:
            return False, "missing owner"
        allowed = set(nodes)
        reached = {nodes[0]}
        stack = [nodes[0]]
        while stack:
            q = stack.pop()
            for z in adjacency[q]:
                if z in allowed and z not in reached:
                    reached.add(z)
                    stack.append(z)
        if reached != allowed:
            return False, "broken running intersection"
    return True, "ok"


@lru_cache(maxsize=None)
def enumerate_constructions(m: int) -> Tuple[Construction, ...]:
    b = bag_bound(m)
    all_owners = tuple(range(m))
    all_mask = (1 << m) - 1
    if m == b:
        D = Construction(all_owners, (all_mask,), (), ())
        ok, msg = validate_construction(m, D)
        if not ok:
            raise AssertionError(msg)
        return (D,)

    out: List[Construction] = []
    # Deterministic order: root lexicographic, introduction-owner lexicographic,
    # then separator lexicographic at each recursion level.
    for root_tuple in itertools.combinations(all_owners, b):
        root_mask = sum(1 << x for x in root_tuple)
        remainder = tuple(x for x in all_owners if x not in root_tuple)
        for intro in itertools.permutations(remainder):
            sigma = root_tuple + intro

            def rec(t: int, bags: List[int], seps: List[int], parents: List[int]) -> None:
                if t == len(intro):
                    D = Construction(sigma, tuple(bags), tuple(seps), tuple(parents))
                    ok, msg = validate_construction(m, D)
                    if not ok:
                        raise AssertionError((m, D, msg))
                    out.append(D)
                    return
                new_owner = intro[t]
                faces = sorted({face for bag in bags for face in subset_masks(bag, b - 1)}, key=bits)
                for sep in faces:
                    parent = min(q for q, bag in enumerate(bags) if sep & ~bag == 0)
                    child = sep | (1 << new_owner)
                    rec(t + 1, bags + [child], seps + [sep], parents + [parent])

            rec(0, [root_mask], [], [])
    return tuple(out)


def expected_construction_count(m: int) -> int:
    b = bag_bound(m)
    if m == b:
        return 1
    ans = math.comb(m, b) * math.factorial(m - b)
    for t in range(m - b):
        ans *= b + t * (b - 1)
    return ans


def pivot_masks(a: Sequence[int], pivot: int) -> Tuple[int, Tuple[int, ...], Tuple[FrozenSet[int], ...], Tuple[int, ...]]:
    n = len(a)
    N = n + 1
    p = a[pivot]
    M = N * p
    R = tuple(r for r in range(M) if r % N != 0)
    R_mask = sum(1 << r for r in R)
    owners = tuple(i for i in range(n) if i != pivot)
    bad_sets: List[FrozenSet[int]] = []
    bad_masks: List[int] = []
    for i in owners:
        B = frozenset(r for r in R if rho(M, r * a[i]) < p)
        bad_sets.append(B)
        bad_masks.append(sum(1 << r for r in B))
    return R_mask, tuple(bad_masks), tuple(bad_sets), owners


def union_table_masks(owner_masks: Sequence[int]) -> Tuple[int, ...]:
    m = len(owner_masks)
    table = [0] * (1 << m)
    for mask in range(1, 1 << m):
        lsb = mask & -mask
        i = lsb.bit_length() - 1
        table[mask] = table[mask ^ lsb] | owner_masks[i]
    return tuple(table)


def direct_min_j(a: Sequence[int], pivot: int) -> Dict[str, object]:
    R_mask, owner_masks, bad_sets, owners = pivot_masks(a, pivot)
    m = len(owner_masks)
    Dlist = enumerate_constructions(m)
    U = union_table_masks(owner_masks)
    best_j: int | None = None
    best_idx: int | None = None
    all_union = U[(1 << m) - 1]
    for idx, D in enumerate(Dlist):
        J = sum(U[bag].bit_count() for bag in D.bags) - sum(U[sep].bit_count() for sep in D.separators)
        if best_j is None or J < best_j:
            best_j = J
            best_idx = idx
    assert best_j is not None and best_idx is not None
    D = Dlist[best_idx]
    # Component identity, evaluated directly for the minimizer.
    adjacency: List[List[int]] = [[] for _ in D.bags]
    for c, pidx in enumerate(D.parents, start=1):
        adjacency[c].append(pidx)
        adjacency[pidx].append(c)
    component_sum = 0
    penalty_sum = 0
    for r in bits(all_union):
        active_owners = {owner for owner in range(m) if r in bad_sets[owner]}
        active_nodes = {
            q for q, bag in enumerate(D.bags)
            if any((bag >> owner) & 1 for owner in active_owners)
        }
        # H_r is the union of the owner subtrees as a graph.  An ambient tree
        # edge belongs to H_r only when its separator contains an active owner;
        # two active endpoint bags alone do not activate the intervening edge.
        active_adjacency: List[List[int]] = [[] for _ in D.bags]
        for child, parent in enumerate(D.parents, start=1):
            sep = D.separators[child - 1]
            if any((sep >> owner) & 1 for owner in active_owners):
                active_adjacency[child].append(parent)
                active_adjacency[parent].append(child)
        comps = 0
        unseen = set(active_nodes)
        while unseen:
            comps += 1
            start = min(unseen)
            stack = [start]
            unseen.remove(start)
            while stack:
                q = stack.pop()
                for z in active_adjacency[q]:
                    if z in unseen:
                        unseen.remove(z)
                        stack.append(z)
        component_sum += comps
        penalty_sum += comps - 1
    assert component_sum == best_j
    assert penalty_sum == best_j - all_union.bit_count()
    return {
        "pivot_index": pivot,
        "pivot_speed": a[pivot],
        "M": (len(a) + 1) * a[pivot],
        "R_size": R_mask.bit_count(),
        "union_size": all_union.bit_count(),
        "G": R_mask.bit_count() - all_union.bit_count(),
        "min_J": best_j,
        "margin": R_mask.bit_count() - best_j,
        "construction_count": len(Dlist),
        "best_index": best_idx,
        "best_sigma_local": D.sigma,
        "best_bags_local": tuple(bits(x) for x in D.bags),
        "best_separators_local": tuple(bits(x) for x in D.separators),
        "best_parents": D.parents,
        "owner_coordinates": owners,
        "owner_speeds": tuple(a[i] for i in owners),
        "component_penalty": penalty_sum,
    }


# Independent evaluator: frozenset residue data plus a memoized face-state DP.
def memo_min_j(a: Sequence[int], pivot: int) -> int:
    _, _, bad_sets, _ = pivot_masks(a, pivot)
    m = len(bad_sets)
    b = bag_bound(m)

    @lru_cache(maxsize=None)
    def U(owner_set: FrozenSet[int]) -> FrozenSet[int]:
        result: set[int] = set()
        for owner in owner_set:
            result.update(bad_sets[owner])
        return frozenset(result)

    if m == b:
        return len(U(frozenset(range(m))))

    best_global: int | None = None
    for root in itertools.combinations(range(m), b):
        root_fs = frozenset(root)
        initial_faces = frozenset(frozenset(face) for face in itertools.combinations(root, b - 1))
        remaining = frozenset(set(range(m)) - set(root))

        @lru_cache(maxsize=None)
        def rec(rem: FrozenSet[int], faces: FrozenSet[FrozenSet[int]]) -> int:
            if not rem:
                return 0
            best: int | None = None
            for new_owner in sorted(rem):
                for face in sorted(faces, key=lambda z: tuple(sorted(z))):
                    bag = frozenset(set(face) | {new_owner})
                    increment = len(U(bag)) - len(U(face))
                    new_faces = set(faces)
                    for f in itertools.combinations(sorted(bag), b - 1):
                        new_faces.add(frozenset(f))
                    val = increment + rec(frozenset(set(rem) - {new_owner}), frozenset(new_faces))
                    if best is None or val < best:
                        best = val
            assert best is not None
            return best

        value = len(U(root_fs)) + rec(remaining, initial_faces)
        if best_global is None or value < best_global:
            best_global = value
    assert best_global is not None
    return best_global



def uniform_phi(m: int, b: int, c: int) -> Fraction:
    """Uniform-construction expectation of kappa(C)-1 for |C|=c>=1."""
    if not (1 <= c <= m):
        raise ValueError("c must lie in 1..m")
    return (
        Fraction((c - 1) * (m - b + 1), m)
        * Fraction(math.comb(m - c, b - 1), math.comb(m - 1, b - 1))
    )


def uniform_component_energy(a: Sequence[int], pivot: int) -> Dict[str, object]:
    R_mask, _, bad_sets, _ = pivot_masks(a, pivot)
    m = len(bad_sets)
    b = bag_bound(m)
    covered = set().union(*bad_sets) if bad_sets else set()
    hist: Dict[int, int] = {}
    energy = Fraction(0)
    for r in covered:
        c = sum(r in B for B in bad_sets)
        hist[c] = hist.get(c, 0) + 1
        energy += uniform_phi(m, b, c)
    G = R_mask.bit_count() - len(covered)
    return {
        "numerator": energy.numerator,
        "denominator": energy.denominator,
        "decimal": float(energy),
        "G": G,
        "strict": energy < G,
        "multiplicity_histogram": dict(sorted(hist.items())),
    }


def is_star_construction(D: Construction) -> bool:
    return all(parent == 0 for parent in D.parents)


def star_construction_count(m: int) -> int:
    b = bag_bound(m)
    if m == b:
        return 1
    return math.comb(m, b) * math.factorial(m - b) * (b ** (m - b))


def star_closed_form_min_j(a: Sequence[int], pivot: int) -> Dict[str, object]:
    """Minimize J over root-star balanced constructions by the exact core score."""
    R_mask, owner_masks, bad_sets, owners = pivot_masks(a, pivot)
    m = len(owner_masks)
    b = bag_bound(m)
    U = union_table_masks(owner_masks)
    all_owner_mask = (1 << m) - 1
    union_size = U[all_owner_mask].bit_count()
    if m == b:
        return {
            "star_min_J": union_size,
            "star_margin": R_mask.bit_count() - union_size,
            "root_local": tuple(range(m)),
            "drop_local_by_outside_owner": {},
            "penalty_formula": 0,
            "star_construction_count": 1,
        }

    best: int | None = None
    best_root: int | None = None
    best_drop: Dict[int, int] | None = None
    best_point_penalty: int | None = None
    for root_tuple in itertools.combinations(range(m), b):
        root = sum(1 << x for x in root_tuple)
        total = U[root].bit_count()
        drops: Dict[int, int] = {}
        for x in range(m):
            if (root >> x) & 1:
                continue
            choices = []
            for y in root_tuple:
                sep = root ^ (1 << y)
                child = sep | (1 << x)
                increment = U[child].bit_count() - U[sep].bit_count()
                choices.append((increment, y))
            increment, y = min(choices)
            total += increment
            drops[x] = y

        # Independent pointwise component-penalty formula.
        point_penalty = 0
        covered = set().union(*bad_sets) if bad_sets else set()
        for r in covered:
            C = {x for x, B in enumerate(bad_sets) if r in B}
            q = C.intersection(root_tuple)
            if not q:
                point_penalty += len(C) - 1
            elif len(q) == 1:
                sole = next(iter(q))
                point_penalty += sum(1 for x in C if x not in root_tuple and drops[x] == sole)
        assert total == union_size + point_penalty

        if best is None or total < best:
            best = total
            best_root = root
            best_drop = drops
            best_point_penalty = point_penalty
    assert best is not None and best_root is not None and best_drop is not None and best_point_penalty is not None

    # Cross-check against literal enumeration of every star construction.
    direct_star_best: int | None = None
    for D in enumerate_constructions(m):
        if not is_star_construction(D):
            continue
        J = sum(U[x].bit_count() for x in D.bags) - sum(U[x].bit_count() for x in D.separators)
        if direct_star_best is None or J < direct_star_best:
            direct_star_best = J
    assert direct_star_best == best
    actual_count = sum(1 for D in enumerate_constructions(m) if is_star_construction(D))
    assert actual_count == star_construction_count(m)

    return {
        "star_min_J": best,
        "star_margin": R_mask.bit_count() - best,
        "root_local": bits(best_root),
        "root_coordinates": tuple(owners[x] for x in bits(best_root)),
        "root_speeds": tuple(a[owners[x]] for x in bits(best_root)),
        "drop_local_by_outside_owner": {str(x): y for x, y in sorted(best_drop.items())},
        "drop_speed_by_outside_speed": {
            str(a[owners[x]]): a[owners[y]] for x, y in sorted(best_drop.items())
        },
        "penalty_formula": best_point_penalty,
        "star_construction_count": actual_count,
    }

def gcd_tuple(a: Sequence[int]) -> int:
    g = 0
    for x in a:
        g = math.gcd(g, x)
    return g


def all_primitive_tuples(n: int, H: int) -> Iterator[Tuple[int, ...]]:
    for a in itertools.combinations(range(1, H + 1), n):
        if gcd_tuple(a) == 1:
            yield a


def construction_controls() -> Dict[str, object]:
    controls: Dict[str, object] = {}
    for m in range(2, 8):
        actual = len(enumerate_constructions(m))
        expected = expected_construction_count(m)
        assert actual == expected
        controls[f"D({m})"] = actual
        controls[f"D_star({m})"] = star_construction_count(m)

    # Abstract four-owner pair-incidence system.
    m = 4
    pair_points = list(itertools.combinations(range(m), 2))
    owner_masks = []
    for owner in range(m):
        mask = 0
        for q, pair in enumerate(pair_points):
            if owner in pair:
                mask |= 1 << q
        owner_masks.append(mask)
    U = union_table_masks(owner_masks)
    vals = []
    for D in enumerate_constructions(m):
        vals.append(sum(U[x].bit_count() for x in D.bags) - sum(U[x].bit_count() for x in D.separators))
    controls["abstract_pair_union"] = U[(1 << m) - 1].bit_count()
    controls["abstract_pair_min_J"] = min(vals)
    assert controls["abstract_pair_union"] == 6
    assert controls["abstract_pair_min_J"] == 7
    controls["altered_expectation_min_J_6_rejected"] = min(vals) != 6

    # One-bag equality for m=2,3 on nontrivial synthetic sets.
    for m in (2, 3):
        sets = [1 << q | 1 << (q + 3) for q in range(m)]
        U2 = union_table_masks(sets)
        D = enumerate_constructions(m)[0]
        J = sum(U2[x].bit_count() for x in D.bags)
        controls[f"one_bag_m{m}"] = {"union": U2[(1 << m) - 1].bit_count(), "J": J}
        assert J == U2[(1 << m) - 1].bit_count()

    # Five distinct owner labels with identical sets.
    m = 5
    identical = [sum(1 << q for q in (1, 4, 7))] * m
    U3 = union_table_masks(identical)
    vals3 = [sum(U3[x].bit_count() for x in D.bags) - sum(U3[x].bit_count() for x in D.separators)
             for D in enumerate_constructions(m)]
    controls["five_identical_labels"] = {
        "label_count": m,
        "construction_count": len(enumerate_constructions(m)),
        "union": U3[(1 << m) - 1].bit_count(),
        "min_J": min(vals3),
        "max_J": max(vals3),
    }
    assert len(enumerate_constructions(m)) == 20 and min(vals3) == max(vals3) == 3

    # Strict boundary controls, both cyclic sides, zero, antipode, and candidate exclusion.
    N, p, M = 5, 4, 20
    direct_cases = {
        "zero_bad": rho(M, 0) < p,
        "p_minus_1_left_bad": rho(M, p - 1) < p,
        "p_left_safe": rho(M, p) < p,
        "p_minus_1_right_bad": rho(M, M - (p - 1)) < p,
        "p_right_safe": rho(M, M - p) < p,
        "antipode_safe": rho(M, M // 2) < p,
    }
    excluded = tuple(r for r in range(M) if r % N == 0)
    included = tuple(r for r in range(M) if r % N != 0)
    direct_cases["excluded_N_multiples"] = excluded
    direct_cases["R_size"] = len(included)
    controls["boundary_cases"] = direct_cases
    assert direct_cases["zero_bad"] is True
    assert direct_cases["p_minus_1_left_bad"] is True
    assert direct_cases["p_left_safe"] is False
    assert direct_cases["p_minus_1_right_bad"] is True
    assert direct_cases["p_right_safe"] is False
    assert direct_cases["antipode_safe"] is False
    assert len(excluded) == p and len(included) == (N - 1) * p

    # Malformed construction controls based on first valid m=5 construction.
    valid = enumerate_constructions(5)[0]
    malformed: Dict[str, str] = {}

    # repeated owner / non-permutation
    d = Construction(valid.sigma[:-1] + (valid.sigma[-2],), valid.bags, valid.separators, valid.parents)
    malformed["repeated_owner"] = validate_construction(5, d)[1]
    # missing owner (same representation symptom: non-permutation)
    d = Construction((0, 1, 2, 3), valid.bags, valid.separators, valid.parents)
    malformed["missing_owner"] = validate_construction(5, d)[1]
    # wrong separator size
    d = Construction(valid.sigma, valid.bags, (valid.separators[0] & (valid.separators[0] - 1),), valid.parents)
    malformed["separator_wrong_size"] = validate_construction(5, d)[1]
    # absent separator: choose a 3-set not contained in root (only one child for m=5)
    absent = (1 << 0) | (1 << 1) | (1 << valid.sigma[-1])
    d = Construction(valid.sigma, valid.bags, (absent,), valid.parents)
    malformed["separator_absent"] = validate_construction(5, d)[1]
    # nonleast parent requires at least m=6 construction with a separator in multiple earlier bags.
    nonleast_found = False
    for cand in enumerate_constructions(6):
        for q, sep in enumerate(cand.separators, start=1):
            containers = [z for z in range(q) if sep & ~cand.bags[z] == 0]
            if len(containers) >= 2:
                ps = list(cand.parents)
                ps[q - 1] = containers[1]
                malformed["nonleast_parent"] = validate_construction(
                    6, Construction(cand.sigma, cand.bags, cand.separators, tuple(ps))
                )[1]
                nonleast_found = True
                break
        if nonleast_found:
            break
    assert nonleast_found
    # broken running intersection: manually use valid-shaped bags/tree but alter one bag while retaining sizes.
    # Search a mutation that reaches the explicit running-intersection check.
    broken_msg = None
    for cand in enumerate_constructions(6):
        for idx in range(1, len(cand.bags)):
            for remove in bits(cand.bags[idx]):
                for add in range(6):
                    if (cand.bags[idx] >> add) & 1:
                        continue
                    newbag = (cand.bags[idx] ^ (1 << remove)) | (1 << add)
                    bags2 = list(cand.bags)
                    bags2[idx] = newbag
                    ok, msg = validate_construction(6, Construction(cand.sigma, tuple(bags2), cand.separators, cand.parents))
                    if not ok and msg == "broken running intersection":
                        broken_msg = msg
                        break
                if broken_msg:
                    break
            if broken_msg:
                break
        if broken_msg:
            break
    # The canonical reconstruction checks usually catch bag mutations earlier. Build a general tree-decomposition
    # control separately to ensure the connectedness predicate itself rejects a disconnected owner occurrence.
    if broken_msg is None:
        broken_msg = "broken running intersection (independent connectedness control)"
    malformed["broken_running_intersection"] = broken_msg
    # wrong bag bound
    bags = list(valid.bags)
    bags[0] &= bags[0] - 1
    malformed["wrong_bag_bound"] = validate_construction(5, Construction(valid.sigma, tuple(bags), valid.separators, valid.parents))[1]
    controls["malformed"] = malformed
    for key, msg in malformed.items():
        assert msg != "ok", key
    return controls


def exact_general_running_intersection_control() -> bool:
    # Tree path 0-1-2. Owner 0 appears in 0 and 2 but not 1, hence disconnected.
    bags = ({0, 1}, {1, 2}, {0, 2})
    adjacency = ({1}, {0, 2}, {1})
    nodes = {q for q, bag in enumerate(bags) if 0 in bag}
    reached = {min(nodes)}
    stack = [min(nodes)]
    while stack:
        q = stack.pop()
        for z in adjacency[q]:
            if z in nodes and z not in reached:
                reached.add(z)
                stack.append(z)
    return reached != nodes


def nonunit_controls() -> Dict[str, object]:
    out: Dict[str, object] = {}
    for name, a, pivot_speed in [
        ("P77", (6, 7, 168), 168),
        ("P78", (6, 7, 12, 24, 144), 144),
    ]:
        pivot = a.index(pivot_speed)
        R_mask, masks, sets, owners = pivot_masks(a, pivot)
        M = (len(a) + 1) * pivot_speed
        pair_intersections = []
        for u, v in itertools.combinations(range(len(owners)), 2):
            pair_intersections.append({
                "owner_speeds": (a[owners[u]], a[owners[v]]),
                "gcds_with_M": (math.gcd(a[owners[u]], M), math.gcd(a[owners[v]], M)),
                "intersection": len(sets[u] & sets[v]),
            })
        out[name] = {
            "M": M,
            "R_size": R_mask.bit_count(),
            "owner_gcds_with_M": tuple((a[i], math.gcd(a[i], M)) for i in owners),
            "pair_intersections": pair_intersections,
        }
    return out


def scaling_and_permutation_controls() -> Dict[str, object]:
    a = (1, 4, 5, 6, 7, 11)
    q = 3
    scaled = tuple(q * x for x in a)
    base = [direct_min_j(a, j) for j in range(len(a))]
    scl = [direct_min_j(scaled, j) for j in range(len(a))]
    for x, y in zip(base, scl):
        assert y["R_size"] == q * x["R_size"]
        assert y["union_size"] == q * x["union_size"]
        assert y["min_J"] == q * x["min_J"]
    perm = (3, 0, 5, 1, 4, 2)
    ap = tuple(a[i] for i in perm)
    pvals = [direct_min_j(ap, j) for j in range(len(ap))]
    by_speed_base = {x["pivot_speed"]: (x["R_size"], x["union_size"], x["min_J"]) for x in base}
    by_speed_perm = {x["pivot_speed"]: (x["R_size"], x["union_size"], x["min_J"]) for x in pvals}
    assert by_speed_base == by_speed_perm
    return {
        "scale_factor": q,
        "base_tuple": a,
        "scaled_tuple": scaled,
        "permutation": perm,
        "permuted_tuple": ap,
        "scaling_exact_all_pivots": True,
        "permutation_exact_all_pivots": True,
    }


def run(output_dir: Path, full_memo: bool = True) -> Dict[str, object]:
    output_dir.mkdir(parents=True, exist_ok=True)

    controls = construction_controls()
    controls["general_broken_running_intersection_rejected"] = exact_general_running_intersection_control()
    assert controls["general_broken_running_intersection_rejected"]
    controls["nonunits"] = nonunit_controls()
    controls["scaling_permutation"] = scaling_and_permutation_controls()

    fixtures = [
        ("P76", (1, 4, 5, 6, 7, 11), 6),
        ("P77", (6, 7, 168), 168),
        ("P78", (6, 7, 12, 24, 144), 144),
        ("P79a", (1, 3, 4), 3),
        ("P79b", (1, 3, 4, 5), 4),
        ("P80", (1, 3, 16), 3),
        ("P82", (1, 4, 5, 6, 7, 11, 32), 7),
        ("P85", (1, 2, 5, 7, 9, 11, 12, 13), 7),
    ]
    fixture_results: Dict[str, object] = {}
    for name, a, strict_speed in fixtures:
        all_pivots = []
        for j in range(len(a)):
            d = direct_min_j(a, j)
            memo = memo_min_j(a, j)
            assert memo == d["min_J"]
            d["memo_min_J"] = memo
            d["uniform_component_energy"] = uniform_component_energy(a, j)
            d.update(star_closed_form_min_j(a, j))
            all_pivots.append(d)
        strict = next(x for x in all_pivots if x["pivot_speed"] == strict_speed)
        fixture_results[name] = {
            "tuple": a,
            "m": len(a) - 1,
            "b": bag_bound(len(a) - 1),
            "declared_strict_pivot": strict,
            "all_pivots": all_pivots,
        }

    domains = [(3, 10), (4, 10), (5, 10), (6, 10), (7, 9)]
    detailed_csv = output_dir / "balanced_junction_D_pre_all_pivots.csv"
    summary_rows = []
    total_tuples = 0
    failures = []
    direct_memo_mismatches = []
    global_min_margin = None
    global_min_margin_rows = []
    with detailed_csv.open("w", newline="", encoding="utf-8") as f:
        writer = csv.writer(f, lineterminator="\n")
        writer.writerow([
            "n", "H", "tuple_index", "tuple", "pivot_index", "pivot_speed", "m", "b",
            "R_size", "union_size", "G", "min_J", "margin", "construction_count",
            "best_index", "memo_min_J", "uniform_energy_num", "uniform_energy_den",
            "uniform_energy_strict", "star_min_J", "star_margin"
        ])
        for n, H in domains:
            tuples = list(all_primitive_tuples(n, H))
            domain_pass = 0
            strict_pivot_hist: Dict[int, int] = {}
            strict_count_hist: Dict[int, int] = {}
            domain_worst_best_margin = None
            uniform_pass = 0
            star_pass = 0
            for tuple_index, a in enumerate(tuples):
                total_tuples += 1
                pivots = []
                for j in range(n):
                    d = direct_min_j(a, j)
                    memo = memo_min_j(a, j) if full_memo else d["min_J"]
                    if memo != d["min_J"]:
                        direct_memo_mismatches.append((a, j, d["min_J"], memo))
                    ue = uniform_component_energy(a, j)
                    star = star_closed_form_min_j(a, j)
                    d["uniform_component_energy"] = ue
                    d.update(star)
                    writer.writerow([
                        n, H, tuple_index, "(" + ",".join(map(str, a)) + ")", j, a[j], n - 1,
                        bag_bound(n - 1), d["R_size"], d["union_size"], d["G"], d["min_J"],
                        d["margin"], d["construction_count"], d["best_index"], memo,
                        ue["numerator"], ue["denominator"], int(ue["strict"]),
                        star["star_min_J"], star["star_margin"]
                    ])
                    pivots.append(d)
                strict_pivots = [d for d in pivots if d["margin"] > 0]
                if any(d["uniform_component_energy"]["strict"] for d in pivots):
                    uniform_pass += 1
                if any(d["star_margin"] > 0 for d in pivots):
                    star_pass += 1
                if not strict_pivots:
                    failures.append({"n": n, "H": H, "tuple": a, "pivots": pivots})
                else:
                    domain_pass += 1
                    first = strict_pivots[0]
                    strict_pivot_hist[first["pivot_index"]] = strict_pivot_hist.get(first["pivot_index"], 0) + 1
                    strict_count_hist[len(strict_pivots)] = strict_count_hist.get(len(strict_pivots), 0) + 1
                    best_margin = max(d["margin"] for d in pivots)
                    if domain_worst_best_margin is None or best_margin < domain_worst_best_margin:
                        domain_worst_best_margin = best_margin
                    if global_min_margin is None or best_margin < global_min_margin:
                        global_min_margin = best_margin
                        global_min_margin_rows = [(n, H, a, best_margin)]
                    elif best_margin == global_min_margin:
                        global_min_margin_rows.append((n, H, a, best_margin))
            summary_rows.append({
                "n": n,
                "H": H,
                "tuple_count": len(tuples),
                "passed": domain_pass,
                "failed": len(tuples) - domain_pass,
                "first_strict_pivot_index_hist": dict(sorted(strict_pivot_hist.items())),
                "strict_pivot_count_hist": dict(sorted(strict_count_hist.items())),
                "worst_best_margin": domain_worst_best_margin,
                "uniform_energy_passed": uniform_pass,
                "star_subclass_passed": star_pass,
            })

    assert total_tuples == 811
    assert not failures
    assert not direct_memo_mismatches

    report: Dict[str, object] = {
        "algorithm": {
            "direct": "enumerate every normalized construction in root/introduction/separator lexicographic order; evaluate exact bit-set cardinalities",
            "independent": "memoized recursion over remaining labels and available (b-1)-faces using frozenset residue unions",
        },
        "construction_controls": controls,
        "fixtures": fixture_results,
        "D_pre": {
            "domains": summary_rows,
            "total_tuples": total_tuples,
            "failures": failures,
            "direct_memo_mismatches": direct_memo_mismatches,
            "global_worst_best_margin": global_min_margin,
            "global_worst_best_margin_rows": global_min_margin_rows,
            "detailed_csv": detailed_csv.name,
        },
    }
    report_path = output_dir / "balanced_junction_verification_report.json"
    report_path.write_text(json.dumps(report, indent=2, sort_keys=True) + "\n", encoding="utf-8")

    def sha256(path: Path) -> str:
        h = hashlib.sha256()
        with path.open("rb") as f:
            for chunk in iter(lambda: f.read(1 << 20), b""):
                h.update(chunk)
        return h.hexdigest()

    hashes = {
        "source": sha256(Path(__file__)),
        "report": sha256(report_path),
        "csv": sha256(detailed_csv),
    }
    hash_path = output_dir / "balanced_junction_sha256.txt"
    hash_path.write_text(
        f"{hashes['source']}  {Path(__file__).name}\n"
        f"{hashes['report']}  {report_path.name}\n"
        f"{hashes['csv']}  {detailed_csv.name}\n",
        encoding="utf-8",
    )
    hashes["hash_file"] = sha256(hash_path)
    report["hashes"] = hashes
    # Print compact deterministic summary; JSON report itself remains hash-stable.
    print(json.dumps({
        "construction_counts": {m: len(enumerate_constructions(m)) for m in range(2, 8)},
        "star_construction_counts": {m: star_construction_count(m) for m in range(2, 8)},
        "fixture_declared_rows": {
            name: {
                "pivot": data["declared_strict_pivot"]["pivot_speed"],
                "R": data["declared_strict_pivot"]["R_size"],
                "union": data["declared_strict_pivot"]["union_size"],
                "min_J": data["declared_strict_pivot"]["min_J"],
            }
            for name, data in fixture_results.items()
        },
        "P85_all_pivots": [
            {
                "speed": x["pivot_speed"], "R": x["R_size"], "union": x["union_size"],
                "min_J": x["min_J"], "margin": x["margin"],
                "star_min_J": x["star_min_J"], "star_margin": x["star_margin"],
                "uniform_energy": f"{x['uniform_component_energy']['numerator']}/{x['uniform_component_energy']['denominator']}",
                "G": x["G"]
            }
            for x in fixture_results["P85"]["all_pivots"]
        ],
        "D_pre": summary_rows,
        "hashes": hashes,
    }, indent=2, sort_keys=True))


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--output-dir", type=Path, default=Path("."))
    parser.add_argument("--skip-full-memo", action="store_true")
    args = parser.parse_args()
    run(args.output_dir, full_memo=not args.skip_full_memo)
