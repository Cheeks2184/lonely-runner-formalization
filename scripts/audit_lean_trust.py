#!/usr/bin/env python3
"""Build the explicit axiom report and reject nonstandard project axioms."""

from __future__ import annotations

import re
import shutil
import subprocess
import unicodedata
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
ALLOWED_AXIOMS = {"propext", "Classical.choice", "Quot.sound"}
FORBIDDEN_SOURCE = re.compile(
    r"\b(?:sorry|admit|axiom|opaque|unsafe|extern|partial_fixpoint)\b"
    r"|\bimplemented_by\b|\bnative_decide\b"
    # `Elab.async false` selects Lean's synchronous elaboration path.  It
    # changes scheduling only; every other false-valued option stays banned.
    r"|\bset_option\s+(?!Elab\.async\s+false\b)\S+\s+false\b",
    re.MULTILINE,
)


def strip_lean_comments(source: str) -> str | None:
    """Mask Lean comments while retaining all non-comment source text.

    This deliberately is not a complete Lean parser.  It tracks strings, raw
    strings, character literals, and quoted identifiers only so comment-like
    content inside them cannot hide later source.  Unterminated lexical forms
    fail closed by returning ``None``.
    """
    masked = list(source)
    length = len(source)
    index = 0

    def mask(position: int) -> None:
        if masked[position] != "\n":
            masked[position] = " "

    def consume_quoted(
        position: int, closing: str, reject_unescaped_brace: bool = False,
        escaped: bool = False,
    ) -> int | None:
        position += 1
        while position < length:
            if escaped:
                escaped = False
            elif source[position] == "\\":
                escaped = True
            elif reject_unescaped_brace and source[position] == "{":
                # Lean strings can interpolate arbitrary terms here.  This
                # small scanner does not parse interpolation, so fail closed.
                return None
            elif source[position] == closing:
                return position + 1
            position += 1
        return None

    def identifier_continuation(character: str) -> bool:
        """Recognize enough Lean identifier suffixes to avoid quote confusion."""
        category = unicodedata.category(character)
        return (
            character in "_'"
            or character.isalnum()
            or category.startswith(("L", "M"))
            or category in {"Nl", "Pc"}
        )

    while index < length:
        if source.startswith("--", index):
            while index < length and source[index] != "\n":
                mask(index)
                index += 1
        elif source.startswith("/-", index):
            depth = 1
            mask(index)
            mask(index + 1)
            index += 2
            while index < length and depth:
                if source.startswith("/-", index):
                    depth += 1
                    mask(index)
                    mask(index + 1)
                    index += 2
                elif source.startswith("-/", index):
                    depth -= 1
                    mask(index)
                    mask(index + 1)
                    index += 2
                else:
                    mask(index)
                    index += 1
            if depth:
                return None
        elif source[index] == '"':
            end = consume_quoted(index, '"', reject_unescaped_brace=True)
            if end is None:
                return None
            index = end
        elif source[index] == "r":
            delimiter_end = index + 1
            while delimiter_end < length and source[delimiter_end] == "#":
                delimiter_end += 1
            if delimiter_end < length and source[delimiter_end] == '"':
                hashes = source[index + 1:delimiter_end]
                closing = '"' + hashes
                end = source.find(closing, delimiter_end + 1)
                if end == -1:
                    return None
                index = end + len(closing)
            else:
                index += 1
        elif (
            source[index] == "'"
            and (index + 1 == length or source[index + 1] != "'")
            and (index == 0 or not identifier_continuation(source[index - 1]))
        ):
            end = consume_quoted(index, "'")
            if end is None:
                return None
            index = end
        elif source[index] == "«":
            end = source.find("»", index + 1)
            if end == -1:
                return None
            index = end + 1
        else:
            index += 1
    return "".join(masked)


def find_forbidden_source(source: str) -> str | None:
    """Return a forbidden construct, or a fail-closed lexical error marker."""
    masked = strip_lean_comments(source)
    if masked is None:
        return "unterminated Lean lexical structure"
    match = FORBIDDEN_SOURCE.search(masked)
    return match.group(0) if match else None


def source_has_forbidden_constructs(source: str) -> bool:
    return find_forbidden_source(source) is not None


def main() -> None:
    lean_files = [ROOT / "LonelyRunner.lean", *sorted((ROOT / "LonelyRunner").rglob("*.lean"))]
    forbidden: list[str] = []
    for path in lean_files:
        if source_has_forbidden_constructs(path.read_text(encoding="utf-8")):
            forbidden.append(str(path.relative_to(ROOT)))
    if forbidden:
        raise SystemExit("forbidden Lean source construct in: " + ", ".join(forbidden))

    lake = shutil.which("lake")
    if lake is None:
        elan_lake = Path.home() / ".elan" / "bin" / "lake"
        if elan_lake.is_file():
            lake = str(elan_lake)
        else:
            raise SystemExit("lake was not found on PATH or under ~/.elan/bin")
    run = subprocess.run(
        [lake, "env", "lean", "LonelyRunner/AxiomAudit.lean"],
        cwd=ROOT,
        text=True,
        stdout=subprocess.PIPE,
        stderr=subprocess.STDOUT,
        check=False,
    )
    print(run.stdout, end="")
    if run.returncode != 0:
        raise SystemExit(f"Lean axiom audit failed with exit code {run.returncode}")
    reports = re.findall(r"depends on axioms:\s*\[([^]]*)\]", run.stdout)
    if not reports:
        raise SystemExit("axiom audit produced no theorem reports")
    for report in reports:
        used = {item.strip() for item in report.replace("\n", " ").split(",") if item.strip()}
        unexpected = used - ALLOWED_AXIOMS
        if unexpected:
            raise SystemExit("unexpected axiom names: " + ", ".join(sorted(unexpected)))
    required_probes = {
        "LonelyRunner.logarithmicHeightGain_positiveInteger_witness",
        "LonelyRunner.boundedPrimorialHeight_family_witness",
        "LonelyRunner.kanoldIntervalBound_vandermonde",
        "LonelyRunner.seventeenThirdsHeight_family_witness",
        "LonelyRunner.fiveHeight_family_witness",
        "LonelyRunner.fourHeight_family_witness",
        "LonelyRunner.three_short_interval_large_or_exception",
        "LonelyRunner.three_witness_or_large_or_exception",
        "LonelyRunner.threeHeight_family_witness",
        "LonelyRunner.slowest_fastest_gap_of_no_fastestPivotCertificate",
        "LonelyRunner.exists_fastestPivotCertificate_of_extremal_band",
        "LonelyRunner.exists_fastestPivotCertificate_of_mem_extremal_interval",
        "LonelyRunner.extremal_interval_compression_of_no_fastestPivotCertificate",
        "LonelyRunner.isTwoSidedTransversal_of_covers",
        "LonelyRunner.exists_top_certificate_of_not_isTwoSidedTransversal",
        "LonelyRunner.saturatedTopTwo_avoids_pivotBadResidues",
    }
    missing_probes = sorted(probe for probe in required_probes if probe not in run.stdout)
    if missing_probes:
        raise SystemExit("missing required axiom probes: " + ", ".join(missing_probes))
    print(f"Trust audit accepted {len(reports)} theorem reports.")


if __name__ == "__main__":
    main()
