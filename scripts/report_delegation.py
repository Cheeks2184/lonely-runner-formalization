#!/usr/bin/env python3
"""Summarize actual delivery data for current Terra/high task records.

This read-only report deliberately treats absent usage as unknown.  It totals
only input/output counts recorded in per-task runtime usage receipts, never
deriving tokens from elapsed time, repaired lines, or another proxy.
"""

from __future__ import annotations

import argparse
import json
import math
import sys
from pathlib import Path
from typing import Any, Mapping


ROOT = Path(__file__).resolve().parents[1]
STATE_PATH = Path("research/workflow-state.json")
TERRA_HIGH = ("gpt-5.6-terra", "high")


def nonnegative_finite_number(value: Any) -> bool:
    if isinstance(value, bool):
        return False
    if isinstance(value, int):
        return value >= 0
    return isinstance(value, float) and math.isfinite(value) and value >= 0


def nonempty_string(value: Any) -> bool:
    return isinstance(value, str) and bool(value.strip())


def actual_usage(usage: Any) -> bool:
    """Recognize the validator's complete, evidence-backed usage receipt."""
    return (
        isinstance(usage, Mapping)
        and set(usage) == {"source", "input_tokens", "output_tokens"}
        and nonempty_string(usage.get("source"))
        and nonnegative_finite_number(usage.get("input_tokens"))
        and nonnegative_finite_number(usage.get("output_tokens"))
    )


def format_number(value: int | float) -> str:
    """Render integers exactly instead of coercing large JSON values to float."""
    return str(value) if isinstance(value, int) and not isinstance(value, bool) else f"{value:g}"


def current_terra_high(task: Any) -> bool:
    return isinstance(task, Mapping) and (
        task.get("requested_model"), task.get("requested_effort")
    ) == TERRA_HIGH


def check_kind(task: Mapping[str, Any]) -> str:
    """Use an explicit kind when available; keep malformed records visible."""
    metrics = task.get("delivery_metrics")
    kind = metrics.get("check_kind") if isinstance(metrics, Mapping) else None
    return kind if isinstance(kind, str) and kind in {"lean", "python", "static", "other"} else "unknown"


def summarize_tasks(tasks: list[tuple[str, Mapping[str, Any]]]) -> dict[str, Any]:
    """Aggregate only data actually present in the supplied task records."""
    known_first_checks = 0
    successful_first_checks = 0
    worker_repair_rounds = 0
    astra_repair_rounds = 0
    astra_repair_lines = 0
    known_astra_repair_lines = 0
    usage_covered = 0
    input_tokens = 0
    output_tokens = 0
    entries = []
    for disposition, task in tasks:
        metrics = task.get("delivery_metrics")
        metrics = metrics if isinstance(metrics, Mapping) else {}
        first_check = metrics.get("first_check_success")
        if isinstance(first_check, bool):
            known_first_checks += 1
            successful_first_checks += int(first_check)
        worker_rounds = metrics.get("worker_repair_rounds")
        if nonnegative_finite_number(worker_rounds):
            worker_repair_rounds += worker_rounds
        astra_rounds = metrics.get("astra_repair_rounds")
        if nonnegative_finite_number(astra_rounds):
            astra_repair_rounds += astra_rounds
        astra_lines = metrics.get("astra_repair_lines")
        if nonnegative_finite_number(astra_lines):
            known_astra_repair_lines += 1
            astra_repair_lines += astra_lines
        usage = metrics.get("usage")
        if actual_usage(usage):
            usage_covered += 1
            input_tokens += usage["input_tokens"]
            output_tokens += usage["output_tokens"]
        entries.append({
            "id": task.get("id"),
            "status": disposition,
            "check_kind": check_kind(task),
            "first_check_success": first_check if isinstance(first_check, bool) else None,
            "usage_observed": actual_usage(usage),
        })

    return {
        "task_count": len(tasks),
        "active_count": sum(disposition == "active" for disposition, _ in tasks),
        "closed_count": sum(disposition == "closed" for disposition, _ in tasks),
        "first_check": {"successful": successful_first_checks, "known": known_first_checks},
        "repairs": {
            "worker_rounds": worker_repair_rounds,
            "astra_rounds": astra_repair_rounds,
            "astra_lines": astra_repair_lines if known_astra_repair_lines else None,
            "astra_lines_coverage": known_astra_repair_lines,
        },
        "usage": {
            "covered_tasks": usage_covered,
            "task_count": len(tasks),
            "input_tokens": input_tokens if usage_covered else None,
            "output_tokens": output_tokens if usage_covered else None,
            "total_tokens": input_tokens + output_tokens if usage_covered else None,
        },
        "tasks": entries,
    }


def summarize(state: Mapping[str, Any]) -> dict[str, Any]:
    """Return auditable aggregates for records on the current routine route."""
    tasks: list[tuple[str, Mapping[str, Any]]] = []
    for collection, disposition in (("active_tasks", "active"), ("completed_tasks", "closed")):
        records = state.get(collection, [])
        if isinstance(records, list):
            tasks.extend((disposition, task) for task in records if current_terra_high(task))
    summary = summarize_tasks(tasks)
    kinds = sorted({check_kind(task) for _, task in tasks})
    summary["by_check_kind"] = {
        kind: summarize_tasks([(disposition, task) for disposition, task in tasks if check_kind(task) == kind])
        for kind in kinds
    }
    return summary


def format_human_summary(summary: Mapping[str, Any], prefix: str = "") -> list[str]:
    first = summary["first_check"]
    known = first["known"]
    rate = "unknown" if not known else f"{first['successful']}/{known} ({first['successful'] / known:.0%})"
    repairs = summary["repairs"]
    usage = summary["usage"]
    usage_totals = "unknown" if usage["total_tokens"] is None else (
        f"input {format_number(usage['input_tokens'])}, output {format_number(usage['output_tokens'])}, total {format_number(usage['total_tokens'])}"
    )
    astra_lines = "unknown" if repairs["astra_lines"] is None else str(repairs["astra_lines"])
    return [
        f"{prefix}tasks: {summary['task_count']} ({summary['active_count']} active, {summary['closed_count']} closed)",
        f"{prefix}first-check success: {rate}; unknown checks excluded",
        f"{prefix}repair rounds: worker {format_number(repairs['worker_rounds'])}, Astra {format_number(repairs['astra_rounds'])}; Astra repair lines: {astra_lines} ({repairs['astra_lines_coverage']} observed)",
        f"{prefix}usage coverage: {usage['covered_tasks']}/{usage['task_count']}; {usage_totals}",
    ]


def format_human(summary: Mapping[str, Any]) -> str:
    lines = ["Terra/high delegation report (actual recorded data only)", "aggregate:"]
    lines.extend(format_human_summary(summary, prefix="  "))
    for kind, grouped in summary["by_check_kind"].items():
        lines.append(f"check kind: {kind}")
        lines.extend(format_human_summary(grouped, prefix="  "))
    return "\n".join(lines)


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--root", type=Path, default=ROOT, help="project root containing workflow state")
    parser.add_argument("--json", action="store_true", help="emit the structured report as JSON")
    args = parser.parse_args(argv)
    try:
        state = json.loads((args.root / STATE_PATH).read_text(encoding="utf-8"))
    except (OSError, UnicodeDecodeError, json.JSONDecodeError) as exc:
        print(f"delegation report error: cannot read workflow state: {exc}", file=sys.stderr)
        return 1
    if not isinstance(state, Mapping):
        print("delegation report error: workflow state must be a JSON object", file=sys.stderr)
        return 1
    summary = summarize(state)
    if args.json:
        print(json.dumps(summary, indent=2, sort_keys=True))
    else:
        print(format_human(summary))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
