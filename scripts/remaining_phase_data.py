#!/usr/bin/env python3
"""Fixed, exact data generator for the reviewed Renault 6.1 and 6.4 routes.

This program deliberately has no default numerical action.  A separately
authorized invocation must supply both ``--execute`` and ``--output-dir``.
It uses only integer arithmetic for the finite band predicates.
"""

from __future__ import annotations

import argparse
import hashlib
import json
import os
import signal
import sys
from dataclasses import dataclass
from fractions import Fraction
from pathlib import Path
from typing import Iterable


SPEC_VERSION = "remaining-phase-6.1-6.4-v1"
ASSESSMENT_SHA256 = "16ad698faeac6f3469c391094806f8bc301bc46fdfe294caefbf557051ba0589"
DENOMINATOR = 360
MAX_WALL_SECONDS = 60
CPU_SOFT_SECONDS = 59
CPU_HARD_SECONDS = 60
ADDRESS_SPACE_BYTES = 256 * 1024 * 1024
MAX_RETAINED_BYTES = 1024 * 1024
CODE_METADATA_DIAGNOSTICS_RESERVE = 65_536
PREDICATE_CALL_BOUND = 6_975
CONTAINMENT_TEST_BOUND = 70_722
TRIPLE_INTERSECTION_BOUND = 963_081

# Literal `renaultPhaseCuts`, retained so the data pass does not depend on a
# parser for Lean source or any mutable external table.
CUTS = (
    0, 12, 15, 20, 24, 30, 36, 40, 45, 48, 60, 72, 75, 80, 84, 90, 96,
    100, 105, 108, 120, 132, 135, 140, 144, 150, 156, 160, 165, 168, 180,
    192, 195, 200, 204, 210, 216, 220, 225, 228, 240, 252, 255, 260, 264,
    270, 276, 280, 285, 288, 300, 312, 315, 320, 324, 330, 336, 340, 345,
    348, 360,
)


class DataFailure(RuntimeError):
    """A bounded data attempt failed and must not be retried automatically."""


@dataclass(frozen=True)
class Candidate:
    slope: int
    b: int
    strict: bool

    def as_json(self) -> dict[str, int | bool]:
        return {"slope": self.slope, "b": self.b, "strict": self.strict}


@dataclass(frozen=True)
class CoreData:
    masks: tuple[int, ...]
    representative_atoms: tuple[int, ...]
    dominators: tuple[int, ...]
    containment_tests: int


def sha256_file(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as handle:
        for chunk in iter(lambda: handle.read(65_536), b""):
            digest.update(chunk)
    return digest.hexdigest()


def decode_six_one() -> tuple[Candidate, ...]:
    result = []
    for index in range(24):
        if index < 20:
            result.append(Candidate(2 + index // 5, 1 + index % 5, False))
        else:
            result.append(Candidate(1, 1 + index - 20, True))
    return tuple(result)


def decode_six_four() -> tuple[Candidate, ...]:
    result = [Candidate(2, 0, True), Candidate(1, 1, True), Candidate(1, 5, True)]
    for index in range(3, 15):
        offset = index - 3
        result.append(Candidate(3 + 2 * (offset // 6), offset % 6, False))
    return tuple(result)


def atom_numerator(cuts: tuple[int, ...], atom: int) -> int:
    point = atom // 2
    return 2 * cuts[point] if atom % 2 == 0 else cuts[point] + cuts[point + 1]


def band_predicate(
    cuts: tuple[int, ...], atom: int, candidate: Candidate, shift_multiplier: int
) -> bool:
    """The assessment's exact finite `AffineSixthBandFact` predicate."""
    residue_numerator = atom_numerator(cuts, atom)
    effective_shift = shift_multiplier * candidate.b
    phase_numerator = candidate.slope * residue_numerator + 120 * effective_shift
    quotient = phase_numerator // 720
    if atom % 2 == 0:
        residue = phase_numerator % 720
        return 120 < residue < 600 if candidate.strict else 120 <= residue <= 600
    point = atom // 2
    lower = candidate.slope * cuts[point] + 60 * effective_shift
    upper = candidate.slope * cuts[point + 1] + 60 * effective_shift
    return 360 * quotient + 60 <= lower and upper <= 360 * quotient + 300


def masks_for(
    cuts: tuple[int, ...], candidates: tuple[Candidate, ...], shift_multiplier: int, atom_count: int
) -> tuple[tuple[int, ...], int]:
    if atom_count > 2 * len(cuts) - 1:
        raise DataFailure("requested atom count exceeds the supplied cuts")
    masks: list[int] = []
    calls = 0
    for atom in range(atom_count):
        mask = 0
        for index, candidate in enumerate(candidates):
            calls += 1
            if band_predicate(cuts, atom, candidate, shift_multiplier):
                mask |= 1 << index
        if mask >= 1 << len(candidates):
            raise DataFailure("candidate mask exceeds its declared bit width")
        masks.append(mask)
    return tuple(masks), calls


def subset(left: int, right: int) -> bool:
    return left & right == left


def minimal_cores(masks: tuple[int, ...]) -> CoreData:
    """Deduplicate, select inclusion-minimal masks, then choose least dominators."""
    representatives: dict[int, int] = {}
    for atom, mask in enumerate(masks):
        representatives.setdefault(mask, atom)
    classes = sorted(representatives.items(), key=lambda item: item[1])
    containment_tests = 0
    minima: list[tuple[int, int]] = []
    for mask, representative in classes:
        is_minimal = True
        for other, _ in classes:
            if other == mask:
                continue
            containment_tests += 1
            if subset(other, mask):
                is_minimal = False
                break
        if is_minimal:
            minima.append((mask, representative))
    minima.sort(key=lambda item: item[1])
    dominators: list[int] = []
    for mask in masks:
        chosen = None
        for core_index, (core_mask, _) in enumerate(minima):
            containment_tests += 1
            if subset(core_mask, mask):
                chosen = core_index
                break
        if chosen is None:
            raise DataFailure("a generated row has no inclusion-minimal dominator")
        dominators.append(chosen)
    return CoreData(
        masks=tuple(mask for mask, _ in minima),
        representative_atoms=tuple(rep for _, rep in minima),
        dominators=tuple(dominators),
        containment_tests=containment_tests,
    )


def least_set_bit(mask: int) -> int:
    if mask == 0:
        raise DataFailure("uncovered core triple")
    return (mask & -mask).bit_length() - 1


def mixed_witnesses(weight_two: CoreData, weight_one: CoreData) -> tuple[bytes, int]:
    witnesses = bytearray()
    count = 0
    for weight_two_index, mask_two in enumerate(weight_two.masks):
        for first, mask_one in enumerate(weight_one.masks):
            for second in range(first, len(weight_one.masks)):
                count += 1
                common = mask_two & mask_one & weight_one.masks[second]
                if common == 0:
                    raise DataFailure(
                        "uncovered 6.1 triple "
                        f"(weight_two={weight_two_index}, "
                        f"weight_one={first}, weight_one_sorted={second})"
                    )
                witnesses.append(least_set_bit(common))
    return bytes(witnesses), count


def equal_type_witnesses(core: CoreData) -> tuple[bytes, int]:
    witnesses = bytearray()
    count = 0
    for first, first_mask in enumerate(core.masks):
        for second in range(first, len(core.masks)):
            for third in range(second, len(core.masks)):
                count += 1
                common = first_mask & core.masks[second] & core.masks[third]
                if common == 0:
                    raise DataFailure(f"uncovered 6.4 triple ({first}, {second}, {third})")
                witnesses.append(least_set_bit(common))
    return bytes(witnesses), count


def verify_cut_contract() -> dict[str, object]:
    if len(CUTS) != 61 or CUTS[0] != 0 or CUTS[-1] != DENOMINATOR:
        raise DataFailure("literal 6.1 cuts are not the reviewed 61-point closed unit grid")
    if tuple(sorted(set(CUTS))) != CUTS:
        raise DataFailure("literal cuts are not strictly increasing")
    required = sorted({Fraction(k, 6 * slope) for slope in range(1, 6)
                       for k in range(6 * slope + 1)})
    scaled = []
    for point in required:
        numerator = point * DENOMINATOR
        if numerator.denominator != 1 or numerator.numerator not in CUTS:
            raise DataFailure(f"required breakpoint missing from literal cuts: {point}")
        scaled.append(numerator.numerator)
    closed_cuts = CUTS[10:51]
    if len(closed_cuts) != 41 or closed_cuts[0] != 60 or closed_cuts[-1] != 300:
        raise DataFailure("6.4 must use exactly 41 cuts from 1/6 through 5/6")
    if 2 * len(closed_cuts) - 1 != 81:
        raise DataFailure("6.4 must retain all 81 closed-domain atoms including 5/6")
    return {
        "literal_cut_count": len(CUTS),
        "required_breakpoint_count": len(required),
        "required_breakpoint_numerators": scaled,
        "six_four_cut_count": len(closed_cuts),
        "six_four_atom_count": 2 * len(closed_cuts) - 1,
        "six_four_endpoint_numerators": [closed_cuts[0], closed_cuts[-1]],
    }


def write_json(path: Path, value: object) -> None:
    path.write_text(json.dumps(value, sort_keys=True, separators=(",", ":")) + "\n", encoding="utf-8")


def enforce_retention_limit(output_dir: Path, source: Path) -> None:
    files = [path for path in output_dir.rglob("*") if path.is_file()]
    output_bytes = sum(path.stat().st_size for path in files)
    metadata_bytes = sum(path.stat().st_size for path in files if path.suffix == ".json")
    code_and_metadata = source.stat().st_size + metadata_bytes
    if code_and_metadata > CODE_METADATA_DIAGNOSTICS_RESERVE:
        raise DataFailure("source plus metadata/diagnostics exceeded the 65,536-byte reserve")
    if source.stat().st_size + output_bytes > MAX_RETAINED_BYTES:
        raise DataFailure("retained code and output exceeded the 1 MiB cap")


def apply_limits() -> None:
    import resource

    def timeout_handler(_signum: int, _frame: object) -> None:
        raise DataFailure("predeclared resource limit reached")

    signal.signal(signal.SIGALRM, timeout_handler)
    signal.signal(signal.SIGXCPU, timeout_handler)
    resource.setrlimit(resource.RLIMIT_CPU, (CPU_SOFT_SECONDS, CPU_HARD_SECONDS))
    resource.setrlimit(resource.RLIMIT_AS, (ADDRESS_SPACE_BYTES, ADDRESS_SPACE_BYTES))
    signal.setitimer(signal.ITIMER_REAL, MAX_WALL_SECONDS)


def run(output_dir: Path) -> None:
    source = Path(__file__).resolve()
    output_dir.mkdir(parents=True, exist_ok=False)
    try:
        if source.stat().st_size + CODE_METADATA_DIAGNOSTICS_RESERVE > MAX_RETAINED_BYTES:
            raise DataFailure("declared retention reserve cannot fit beneath the total cap")
        apply_limits()
        cut_contract = verify_cut_contract()
        six_one = decode_six_one()
        six_four = decode_six_four()
        # 6.1 keeps its last open atom ending at 1 but excludes the singleton 1.
        weight_two_masks, weight_two_calls = masks_for(CUTS, six_one, 2, 120)
        weight_one_masks, weight_one_calls = masks_for(CUTS, six_one, 1, 120)
        closed_cuts = CUTS[10:51]
        # 6.4 instead includes its final singleton, the closed endpoint 5/6.
        six_four_masks, six_four_calls = masks_for(closed_cuts, six_four, 1, 81)
        predicate_calls = weight_two_calls + weight_one_calls + six_four_calls
        if predicate_calls != PREDICATE_CALL_BOUND:
            raise DataFailure(f"predicate call count {predicate_calls} differs from fixed bound")
        weight_two_core = minimal_cores(weight_two_masks)
        weight_one_core = minimal_cores(weight_one_masks)
        six_four_core = minimal_cores(six_four_masks)
        containment_tests = (weight_two_core.containment_tests +
                             weight_one_core.containment_tests +
                             six_four_core.containment_tests)
        if containment_tests > CONTAINMENT_TEST_BOUND:
            raise DataFailure("directed containment-test cap exceeded")
        mixed, mixed_count = mixed_witnesses(weight_two_core, weight_one_core)
        equal_type, equal_type_count = equal_type_witnesses(six_four_core)
        triple_count = mixed_count + equal_type_count
        if triple_count > TRIPLE_INTERSECTION_BOUND:
            raise DataFailure("triple-intersection cap exceeded")
        (output_dir / "six_one_witnesses.bin").write_bytes(mixed)
        (output_dir / "six_four_witnesses.bin").write_bytes(equal_type)
        metadata = {
            "status": "success",
            "spec_version": SPEC_VERSION,
            "assessment_sha256": ASSESSMENT_SHA256,
            "source_sha256": sha256_file(source),
            "limits": {
                "wall_seconds": MAX_WALL_SECONDS,
                "cpu_seconds": [CPU_SOFT_SECONDS, CPU_HARD_SECONDS],
                "address_space_bytes": ADDRESS_SPACE_BYTES,
                "retained_bytes": MAX_RETAINED_BYTES,
                "code_metadata_diagnostics_reserve": CODE_METADATA_DIAGNOSTICS_RESERVE,
            },
            "cut_contract": cut_contract,
            "candidates": {
                "six_one": [candidate.as_json() for candidate in six_one],
                "six_four": [candidate.as_json() for candidate in six_four],
                "six_one_effective_shift_multipliers": {"weight_two": 2, "weight_one": 1},
                "six_four_effective_shift_multiplier": 1,
            },
            "masks": {
                "six_one_weight_two": list(weight_two_masks),
                "six_one_weight_one": list(weight_one_masks),
                "six_four": list(six_four_masks),
            },
            "cores": {
                "six_one_weight_two": weight_two_core.__dict__,
                "six_one_weight_one": weight_one_core.__dict__,
                "six_four": six_four_core.__dict__,
            },
            "counts": {
                "predicate_calls": predicate_calls,
                "directed_containment_tests": containment_tests,
                "mixed_triples": mixed_count,
                "equal_type_triples": equal_type_count,
                "triple_intersections": triple_count,
            },
            "witness_files": {
                "six_one_witnesses.bin": {"bytes": len(mixed), "sha256": sha256_file(output_dir / "six_one_witnesses.bin")},
                "six_four_witnesses.bin": {"bytes": len(equal_type), "sha256": sha256_file(output_dir / "six_four_witnesses.bin")},
            },
        }
        write_json(output_dir / "metadata.json", metadata)
        enforce_retention_limit(output_dir, source)
    except BaseException as error:
        diagnostic = {
            "status": "failure",
            "spec_version": SPEC_VERSION,
            "assessment_sha256": ASSESSMENT_SHA256,
            "source_sha256": sha256_file(source),
            "error_type": type(error).__name__,
            "error": str(error),
        }
        try:
            write_json(output_dir / "failure.json", diagnostic)
        finally:
            raise
    finally:
        signal.setitimer(signal.ITIMER_REAL, 0)


def parse_args(argv: Iterable[str] | None = None) -> argparse.Namespace:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--output-dir", type=Path, help="new directory for compact fixed-family artifacts")
    parser.add_argument("--execute", action="store_true", help="perform the separately authorized fixed data pass")
    args = parser.parse_args(argv)
    if not args.execute:
        parser.error("numerical execution is disabled unless --execute is supplied")
    if args.output_dir is None:
        parser.error("--output-dir is required with --execute")
    return args


def main(argv: Iterable[str] | None = None) -> int:
    args = parse_args(argv)
    run(args.output_dir)
    return 0


if __name__ == "__main__":
    try:
        exit_code = main()
    except Exception as error:
        print(f"remaining_phase_data: {type(error).__name__}: {error}", file=sys.stderr)
        raise
    raise SystemExit(exit_code)
