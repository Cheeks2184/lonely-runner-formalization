#!/usr/bin/env python3
"""Build the explicit axiom report and reject nonstandard project axioms."""

from __future__ import annotations

import re
import shutil
import subprocess
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
ALLOWED_AXIOMS = {"propext", "Classical.choice", "Quot.sound"}
FORBIDDEN_SOURCE = re.compile(
    r"^\s*(?:sorry|admit|axiom|opaque|unsafe|extern|partial_fixpoint)\b"
    r"|\bimplemented_by\b|\bnative_decide\b|\bset_option\s+\S+\s+false\b",
    re.MULTILINE,
)


def main() -> None:
    lean_files = [ROOT / "LonelyRunner.lean", *sorted((ROOT / "LonelyRunner").rglob("*.lean"))]
    forbidden: list[str] = []
    for path in lean_files:
        if FORBIDDEN_SOURCE.search(path.read_text(encoding="utf-8")):
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
    }
    missing_probes = sorted(probe for probe in required_probes if probe not in run.stdout)
    if missing_probes:
        raise SystemExit("missing required axiom probes: " + ", ".join(missing_probes))
    print(f"Trust audit accepted {len(reports)} theorem reports.")


if __name__ == "__main__":
    main()
