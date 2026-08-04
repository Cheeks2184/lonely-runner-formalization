#!/usr/bin/env python3
"""Validate the rolling task ledger and print its derived pipeline metrics.

The validator intentionally uses only the Python standard library.  The JSON
Schema is the interoperability contract; these checks add repository-aware and
cross-record invariants that JSON Schema cannot express succinctly.
"""

from __future__ import annotations

import argparse
import hashlib
import json
import re
import subprocess
import sys
from collections import Counter
from functools import lru_cache
from pathlib import Path
from typing import Any, Iterable, Mapping, Sequence


ROOT = Path(__file__).resolve().parents[1]
DEFAULT_LEDGER = ROOT / "research/task-ledger.json"
DEFAULT_SCHEMA = ROOT / "research/task-ledger.schema.json"
PROMOTION_REGISTRY_PATH = "research/promotion-decisions.json"
# This allowlist is intentionally code-frozen. The validator reads the
# immutable Git object, never the mutable worktree copy, so a task row cannot
# fabricate PI authority by adding a free-form string or source reference.
PROMOTION_REGISTRY_COMMIT = "b5ab2cf19327b4e0e0c42288416de2ec3f98e4b3"

LIFECYCLE_STAGES = [
    "preparation",
    "contract_review",
    "launch_ready",
    "launched",
    "active_research",
    "response_recovery",
    "independent_audit",
    "correction",
    "integration",
    "publication",
]
STATUSES = {
    "planned", "prepared", "active", "review", "verified", "rejected",
    "integrated", "completed", "frozen", "blocked",
}
OPERATIONAL_STATES = {"active", "prepared", "frozen", "terminal"}
ADMISSION_CLASSES = {
    "LUNA-READY", "MEDIUM-SPEC-REQUIRED", "RESEARCH-UNRESOLVED", "NOT-APPLICABLE",
}
EVIDENCE_LABELS = {
    "none", "operational-only", "contract-only", "documentation-only",
    "recovery-provenance", "computed-finite-evidence", "proved-math-qualified",
    "literature-external-unformalized", "rejected-operational-output",
    "accepted-audit-deliverable", "accepted-negative-audit",
}
PROMOTED_EVIDENCE_LABELS = {
    "recovery-provenance", "computed-finite-evidence", "proved-math-qualified",
    "literature-external-unformalized", "rejected-operational-output",
    "accepted-audit-deliverable", "accepted-negative-audit",
}
AUDIT_OUTCOMES = {"not_applicable", "accepted", "accepted_negative", "rejected", "pending", "deferred"}
QUEUE_STATES = {"none", "launch_ready", "waiting", "parked"}
VERIFICATION_STATES = {"pending", "active", "complete", "not_required"}
EFFORTS = {None, "low", "medium", "high", "xhigh", "pro"}
DESKTOP_OWNER = "GPT-5.6 Sol High top-level desktop orchestrator"
DESKTOP_RUNTIME = "original browser-capable desktop Codex session"
DESKTOP_READBACK_KEYS = {
    "signed_in", "new_conversation", "chat_selected", "work_selected",
    "sol_selected", "pro_selected", "exact_prompt_readback",
    "generation_started", "tracked_prompt_bytes", "tracked_prompt_characters",
    "submitted_payload_bytes", "submitted_payload_characters",
    "tracked_terminal_lf", "submitted_terminal_lf",
}
DESKTOP_AFFIRMATIVE_KEYS = {
    "signed_in", "new_conversation", "chat_selected", "sol_selected",
    "pro_selected", "exact_prompt_readback", "generation_started",
}
DESKTOP_COUNT_KEYS = {
    "tracked_prompt_bytes", "tracked_prompt_characters",
    "submitted_payload_bytes", "submitted_payload_characters",
}
SHA256_RE = re.compile(r"^[0-9a-f]{64}$")
COMMIT_RE = re.compile(r"^[0-9a-f]{40}$")
TASK_ID_RE = re.compile(r"^[A-Z][A-Z0-9-]*[0-9]$")
TIMESTAMP_RE = re.compile(
    r"^20[0-9]{2}-[0-9]{2}-[0-9]{2}T[0-9]{2}:[0-9]{2}:[0-9]{2}"
    r"(?:\.[0-9]+)?(?:Z|[+-][0-9]{2}:[0-9]{2})$"
)


class LedgerError(ValueError):
    """A deterministic ledger validation failure."""


def strict_json(path: Path) -> Any:
    """Load UTF-8 JSON while rejecting duplicate keys at every depth."""

    def unique_object(pairs: list[tuple[str, Any]]) -> dict[str, Any]:
        result: dict[str, Any] = {}
        for key, value in pairs:
            if key in result:
                raise LedgerError(f"{path}: duplicate JSON key {key!r}")
            result[key] = value
        return result

    try:
        return json.loads(path.read_text(encoding="utf-8"), object_pairs_hook=unique_object)
    except (OSError, UnicodeDecodeError, json.JSONDecodeError) as exc:
        raise LedgerError(f"{path}: invalid JSON: {exc}") from exc


def sha256_file(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as handle:
        for block in iter(lambda: handle.read(1024 * 1024), b""):
            digest.update(block)
    return digest.hexdigest()


def add_if(errors: list[str], condition: bool, message: str) -> None:
    if condition:
        errors.append(message)


def safe_public_identifier(value: str | None) -> bool:
    if value is None:
        return True
    lowered = value.lower()
    return not (
        value.startswith(("/", "\\"))
        or "\\" in value
        or re.match(r"^[a-zA-Z]:", value) is not None
        or "/home/" in lowered
        or "/users/" in lowered
        or "wsl.localhost" in lowered
    )


def safe_relative_path(value: str) -> bool:
    path = Path(value)
    return not path.is_absolute() and ".." not in path.parts and "\\" not in value


@lru_cache(maxsize=None)
def commit_exists(commit: str) -> bool:
    process = subprocess.run(
        ["git", "-C", str(ROOT), "cat-file", "-e", f"{commit}^{{commit}}"],
        stdout=subprocess.DEVNULL,
        stderr=subprocess.DEVNULL,
        check=False,
    )
    return process.returncode == 0


@lru_cache(maxsize=None)
def json_from_commit(commit: str, path: str) -> Any:
    """Read strict JSON from an immutable repository object without writes."""

    process = subprocess.run(
        ["git", "-C", str(ROOT), "show", f"{commit}:{path}"],
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
        check=False,
    )
    if process.returncode != 0:
        raise LedgerError(f"cannot read {path} at {commit}")

    def unique_object(pairs: list[tuple[str, Any]]) -> dict[str, Any]:
        result: dict[str, Any] = {}
        for key, value in pairs:
            if key in result:
                raise LedgerError(f"{path}@{commit}: duplicate JSON key {key!r}")
            result[key] = value
        return result

    try:
        return json.loads(process.stdout.decode("utf-8"), object_pairs_hook=unique_object)
    except (UnicodeDecodeError, json.JSONDecodeError) as exc:
        raise LedgerError(f"{path}@{commit}: invalid JSON: {exc}") from exc


def promotion_required(task: Mapping[str, Any]) -> bool:
    return (
        task["evidence_label"] in PROMOTED_EVIDENCE_LABELS
        or task["audit_outcome"] in {"accepted", "accepted_negative", "rejected"}
        or (
            task["operational_state"] == "terminal"
            and task["status"] in {"verified", "integrated"}
        )
    )


def derive_metrics(tasks: Sequence[Mapping[str, Any]]) -> dict[str, Any]:
    audits = Counter(task["audit_outcome"] for task in tasks if task["kind"] == "audit")
    route_queues = Counter(
        task["route_queue"]
        for task in tasks
        if task["current_route_marker"] and task["route_queue"] != "none"
    )
    level_queues = Counter(
        str(task["verification"]["level"])
        for task in tasks
        if task["verification"]["state"] in {"pending", "active"}
    )
    active_medium_leads = {
        task["owner"]
        for task in tasks
        if task["operational_state"] == "active" and task["runtime"]["effort"] == "medium"
    }
    luna_tasks = [task for task in tasks if task["runtime"]["model"] == "gpt-5.6-luna"]
    completed_pro_routes = {
        task["parent_route"]
        for task in tasks
        if task["runtime"]["pro_cell"] and task["status"] == "completed"
    }
    recovered_routes = {
        task["parent_route"]
        for task in tasks
        if task["kind"] == "recovery"
        and task["operational_state"] == "terminal"
        and task["status"] in {"verified", "integrated", "completed"}
    }
    audited_routes = {
        task["parent_route"]
        for task in tasks
        if task["kind"] == "audit" and task["verification"]["state"] in {"pending", "active"}
    }
    launch_ready_contracts = sum(
        task["current_route_marker"] and task["route_queue"] == "launch_ready"
        for task in tasks
    )
    return {
        "active_pro_cells": sum(
            task["runtime"]["pro_cell"] and task["status"] == "active" for task in tasks
        ),
        "route_queues": {
            "launch_ready": route_queues["launch_ready"],
            "waiting": route_queues["waiting"],
            "parked": route_queues["parked"],
        },
        "audits": {
            "total": sum(audits.values()),
            "accepted": audits["accepted"],
            "accepted_negative": audits["accepted_negative"],
            "rejected": audits["rejected"],
            "pending": audits["pending"],
            "deferred": audits["deferred"],
        },
        "verification_level_queues": {
            "1": level_queues["1"],
            "2": level_queues["2"],
            "3": level_queues["3"],
        },
        "pipeline": {
            "active_medium_leads": len(active_medium_leads),
            "luna_ready_tasks": sum(
                task["admission_class"] == "LUNA-READY"
                and task["operational_state"] in {"active", "prepared"}
                for task in tasks
            ),
            "active_luna_workers": sum(
                task["runtime"]["model"] == "gpt-5.6-luna"
                and task["operational_state"] == "active"
                for task in tasks
            ),
            "integration_backlog": sum(
                task["lifecycle_stage"] == "integration"
                and task["operational_state"] in {"active", "prepared"}
                for task in tasks
            ),
            "sol_high_review_backlog": sum(
                task["status"] == "review"
                and task["operational_state"] == "prepared"
                and (
                    task["owner"] == DESKTOP_OWNER
                    or (
                        task["runtime"]["model"] == "gpt-5.6-sol"
                        and task["runtime"]["effort"] == "high"
                    )
                )
                for task in tasks
            ),
            "pro_cells_awaiting_recovery": len(completed_pro_routes - recovered_routes),
            "responses_under_audit": len(recovered_routes & audited_routes),
            "launch_ready_contracts": launch_ready_contracts,
        },
        # Historical rows lack a complete, consistently sourced event series.
        # Unknown speed values remain null rather than being reverse-engineered.
        "speed_metrics": {
            "dispatch_latency_seconds": None,
            "execution_duration_seconds": None,
            "review_latency_seconds": None,
            "recovery_latency_seconds": None,
            "integration_latency_seconds": None,
            "end_to_end_cycle_seconds": None,
            "throughput_tasks_per_hour": None,
        },
        "luna_narrow_effectiveness": {
            "launched": sum(task["status"] not in {"planned", "prepared"} for task in luna_tasks),
            "admitted": sum(task["admission_class"] == "LUNA-READY" for task in luna_tasks),
            "rejected": sum(task["status"] == "rejected" for task in luna_tasks),
            "preflight_runs": None,
            "full_runs": None,
            "accepted": sum(task["status"] in {"verified", "integrated"} for task in luna_tasks),
            "escalations": None,
            "repairs": None,
            "runtime_failures": None,
            "rejected_outputs": sum(
                task["evidence_label"] == "rejected-operational-output" for task in luna_tasks
            ),
            "review_cycles": None,
            "duplicates": None,
            "integration_time_seconds": None,
        },
    }


def find_cycle(tasks_by_id: Mapping[str, Mapping[str, Any]]) -> list[str] | None:
    visiting: set[str] = set()
    visited: set[str] = set()

    def walk(task_id: str, trail: list[str]) -> list[str] | None:
        if task_id in visiting:
            return trail[trail.index(task_id):] + [task_id]
        if task_id in visited:
            return None
        visiting.add(task_id)
        trail.append(task_id)
        for dependency in tasks_by_id[task_id]["dependencies"]:
            if dependency in tasks_by_id:
                cycle = walk(dependency, trail)
                if cycle:
                    return cycle
        trail.pop()
        visiting.remove(task_id)
        visited.add(task_id)
        return None

    for task_id in tasks_by_id:
        cycle = walk(task_id, [])
        if cycle:
            return cycle
    return None


def validate_schema_contract(schema: Mapping[str, Any], errors: list[str]) -> None:
    add_if(errors, schema.get("$schema") != "https://json-schema.org/draft/2020-12/schema", "schema: wrong draft")
    add_if(errors, schema.get("additionalProperties") is not False, "schema: root must fail closed on extra properties")
    definitions = schema.get("$defs")
    add_if(errors, not isinstance(definitions, dict), "schema: missing $defs")


def validate_promotion_registry(
    ledger: Mapping[str, Any], tasks: Sequence[Mapping[str, Any]], errors: list[str]
) -> None:
    """Bind every promotion to the immutable, root-authorized PI registry."""

    registry_commit = ledger.get("promotion_registry_commit")
    add_if(
        errors,
        registry_commit != PROMOTION_REGISTRY_COMMIT,
        "ledger: promotion registry commit is not the frozen PI decision commit",
    )
    if registry_commit != PROMOTION_REGISTRY_COMMIT:
        return
    try:
        registry = json_from_commit(registry_commit, PROMOTION_REGISTRY_PATH)
    except LedgerError as exc:
        errors.append(f"promotion registry: {exc}")
        return
    if not isinstance(registry, dict) or set(registry) != {"schema_version", "authority", "decisions"}:
        errors.append("promotion registry: malformed root")
        return
    add_if(errors, registry["schema_version"] != "1.0.0", "promotion registry: wrong schema version")
    add_if(errors, registry["authority"] != "/root", "promotion registry: authority must be /root")
    decisions = registry["decisions"]
    if not isinstance(decisions, list):
        errors.append("promotion registry: decisions must be a list")
        return
    record_keys = {
        "decision_id", "task_id", "authority", "status", "operational_state",
        "evidence_label", "audit_outcome", "disposition_sha256",
    }
    decisions_by_task: dict[str, Mapping[str, Any]] = {}
    for index, decision in enumerate(decisions):
        prefix = f"promotion registry decision[{index}]"
        if not isinstance(decision, dict) or set(decision) != record_keys:
            errors.append(f"{prefix}: malformed record")
            continue
        task_id = decision["task_id"]
        add_if(errors, task_id in decisions_by_task, f"{prefix}: duplicate task decision {task_id}")
        add_if(errors, decision["decision_id"] != f"PI-{task_id}", f"{prefix}: decision ID is not task-bound")
        add_if(errors, decision["authority"] != "/root", f"{prefix}: authority must be /root")
        add_if(
            errors,
            not isinstance(decision["disposition_sha256"], str)
            or SHA256_RE.fullmatch(decision["disposition_sha256"]) is None,
            f"{prefix}: invalid disposition digest",
        )
        decisions_by_task[task_id] = decision

    required_ids: set[str] = set()
    for task in tasks:
        if not promotion_required(task):
            continue
        task_id = task["id"]
        required_ids.add(task_id)
        decision = decisions_by_task.get(task_id)
        if decision is None:
            errors.append(f"task {task_id}: promotion lacks immutable /root decision")
            continue
        for field in ("status", "operational_state", "evidence_label", "audit_outcome"):
            add_if(
                errors,
                decision[field] != task[field],
                f"task {task_id}: promotion decision {field} mismatch",
            )
        disposition_digest = hashlib.sha256(task["disposition"].encode("utf-8")).hexdigest()
        add_if(
            errors,
            decision["disposition_sha256"] != disposition_digest,
            f"task {task_id}: PI disposition differs from immutable decision",
        )
        if (
            task["evidence_label"] in PROMOTED_EVIDENCE_LABELS
            or task["audit_outcome"] in {"accepted", "accepted_negative", "rejected"}
        ):
            add_if(
                errors,
                task["supervising_lead"] != "/root",
                f"task {task_id}: promoted evidence requires /root supervision",
            )
    extra_ids = set(decisions_by_task) - required_ids
    add_if(errors, bool(extra_ids), f"promotion registry: unbound decisions {sorted(extra_ids)}")


def validate_task(task: Mapping[str, Any], task_ids: set[str], errors: list[str]) -> None:
    task_id = task.get("id", "<missing-id>")
    prefix = f"task {task_id}"
    required = {
        "id", "parent_route", "kind", "owner", "supervising_lead", "runtime",
        "base_commit", "lifecycle_stage", "dependencies", "branch", "worktree_id",
        "status", "operational_state", "route_queue", "current_route_marker",
        "admission_class", "verification", "evidence_label", "hashes", "disposition",
        "audit_outcome", "review_ids", "integration_commit", "timestamps", "source_refs",
    }
    add_if(errors, set(task) != required, f"{prefix}: fields differ from frozen task schema")
    if set(task) != required:
        return

    add_if(errors, TASK_ID_RE.fullmatch(task_id) is None, f"{prefix}: invalid task ID")
    add_if(errors, task["lifecycle_stage"] not in LIFECYCLE_STAGES, f"{prefix}: invalid lifecycle stage")
    add_if(errors, task["status"] not in STATUSES, f"{prefix}: invalid status")
    add_if(errors, task["operational_state"] not in OPERATIONAL_STATES, f"{prefix}: invalid operational state")
    add_if(errors, task["route_queue"] not in QUEUE_STATES, f"{prefix}: invalid route queue")
    add_if(errors, task["admission_class"] not in ADMISSION_CLASSES, f"{prefix}: invalid admission class")
    add_if(errors, task["evidence_label"] not in EVIDENCE_LABELS, f"{prefix}: invalid evidence label")
    add_if(errors, task["audit_outcome"] not in AUDIT_OUTCOMES, f"{prefix}: invalid audit outcome")
    add_if(errors, not safe_public_identifier(task["worktree_id"]), f"{prefix}: worktree identifier is not public-safe")

    base = task["base_commit"]
    add_if(errors, base is not None and COMMIT_RE.fullmatch(base) is None, f"{prefix}: malformed base commit")
    if base is None:
        add_if(errors, task["status"] not in {"planned", "prepared"}, f"{prefix}: null base allowed only before execution")
        add_if(errors, task["evidence_label"] != "none", f"{prefix}: null base cannot carry evidence")
    elif COMMIT_RE.fullmatch(base):
        add_if(errors, not commit_exists(base), f"{prefix}: base commit is not available")

    integration = task["integration_commit"]
    add_if(errors, integration is not None and COMMIT_RE.fullmatch(integration) is None, f"{prefix}: malformed integration commit")
    if integration is not None and COMMIT_RE.fullmatch(integration):
        add_if(errors, not commit_exists(integration), f"{prefix}: integration commit is not available")
    add_if(errors, task["status"] == "integrated" and integration is None, f"{prefix}: integrated status needs integration commit")

    dependencies = task["dependencies"]
    add_if(errors, not isinstance(dependencies, list), f"{prefix}: dependencies must be a list")
    if isinstance(dependencies, list):
        add_if(errors, len(dependencies) != len(set(dependencies)), f"{prefix}: duplicate dependency")
        for dependency in dependencies:
            add_if(errors, dependency not in task_ids, f"{prefix}: unknown dependency {dependency}")
            add_if(errors, dependency == task_id, f"{prefix}: self dependency")

    review_ids = task["review_ids"]
    add_if(errors, not isinstance(review_ids, list), f"{prefix}: review_ids must be a list")
    if isinstance(review_ids, list):
        add_if(errors, len(review_ids) != len(set(review_ids)), f"{prefix}: duplicate review ID")
        for review_id in review_ids:
            add_if(errors, review_id not in task_ids, f"{prefix}: unknown review ID {review_id}")

    verification = task["verification"]
    add_if(errors, not isinstance(verification, dict) or set(verification) != {"level", "state"}, f"{prefix}: malformed verification record")
    if isinstance(verification, dict):
        state = verification.get("state")
        level = verification.get("level")
        add_if(errors, state not in VERIFICATION_STATES, f"{prefix}: invalid verification state")
        if state == "not_required":
            add_if(errors, level is not None, f"{prefix}: not-required verification must not have a level")
        else:
            add_if(errors, level not in {1, 2, 3}, f"{prefix}: invalid verification level")

    runtime = task["runtime"]
    runtime_keys = {"route", "model", "effort", "pro_cell"}
    allowed_runtime_keys = runtime_keys | {"desktop_readback"}
    add_if(
        errors,
        not isinstance(runtime, dict)
        or not runtime_keys.issubset(runtime)
        or not set(runtime).issubset(allowed_runtime_keys),
        f"{prefix}: malformed runtime record",
    )
    if isinstance(runtime, dict) and runtime_keys.issubset(runtime) and set(runtime).issubset(allowed_runtime_keys):
        add_if(errors, runtime.get("effort") not in EFFORTS, f"{prefix}: invalid runtime effort")
        if isinstance(verification, dict) and verification.get("level") == 3:
            # Level 3 is intentionally scarce: targeted replay belongs at
            # Level 2, while only authoritative fresh-clone publication gates
            # may occupy the publication-checkpoint queue.
            route = str(runtime.get("route") or "").lower()
            add_if(
                errors,
                task["lifecycle_stage"] != "publication"
                or "authoritative" not in route
                or "fresh-clone" not in route,
                f"{prefix}: Level 3 is reserved for authoritative fresh-clone publication checkpoints",
            )
        readback = runtime.get("desktop_readback")
        if readback is not None:
            add_if(
                errors,
                not isinstance(readback, dict) or set(readback) != DESKTOP_READBACK_KEYS,
                f"{prefix}: malformed desktop readback",
            )
            if isinstance(readback, dict) and set(readback) == DESKTOP_READBACK_KEYS:
                add_if(
                    errors,
                    not all(readback[key] is True for key in DESKTOP_AFFIRMATIVE_KEYS),
                    f"{prefix}: desktop readback is not exact and affirmative",
                )
                add_if(errors, readback["work_selected"] is True, f"{prefix}: desktop readback cannot select Work and Chat")
                for key in DESKTOP_COUNT_KEYS:
                    value = readback[key]
                    add_if(
                        errors,
                        value is not None and (type(value) is not int or value < 0),
                        f"{prefix}: invalid desktop readback count {key}",
                    )
        if runtime["pro_cell"] and task["status"] == "active":
            add_if(errors, not runtime["model"] or not runtime["effort"], f"{prefix}: active Pro cell needs model and effort")
            add_if(errors, not any(item.get("kind") == "prompt" for item in task["hashes"]), f"{prefix}: active Pro cell needs prompt hash")
            add_if(errors, not any(stamp.get("event") == "launched" for stamp in task["timestamps"]), f"{prefix}: active Pro cell needs launch timestamp")
        if runtime["pro_cell"] and runtime.get("route") == DESKTOP_RUNTIME:
            add_if(errors, runtime.get("effort") != "pro", f"{prefix}: browser Pro cell effort must be pro")
        if runtime.get("model") == "gpt-5.6-luna":
            add_if(errors, task["admission_class"] == "NOT-APPLICABLE", f"{prefix}: Luna task needs explicit Narrow admission class")

    # Desktop Pro launch provenance is universal, including completed cells.
    # Route-specific checks would silently admit older Prompt67/68 records.
    if isinstance(runtime, dict) and runtime.get("pro_cell") and runtime.get("route") == DESKTOP_RUNTIME:
        add_if(errors, task["owner"] != DESKTOP_OWNER, f"{prefix}: wrong browser Pro cell owner")
        add_if(errors, runtime.get("model") != "gpt-5.6-sol", f"{prefix}: wrong browser Pro cell model")
        add_if(errors, runtime.get("desktop_readback") is None, f"{prefix}: browser Pro cell needs exact desktop readback")
        add_if(errors, not any(item.get("kind") == "prompt" for item in task["hashes"]), f"{prefix}: browser Pro cell needs prompt hash")
        add_if(errors, not any(item.get("kind") == "launch_payload" for item in task["hashes"]), f"{prefix}: browser Pro cell needs launch-payload hash")
        add_if(errors, not any(stamp.get("event") == "launched" for stamp in task["timestamps"]), f"{prefix}: browser Pro cell needs launch timestamp")
        add_if(
            errors,
            verification != {"level": None, "state": "not_required"},
            f"{prefix}: browser Pro cell verification must be not_required without a level",
        )

    # Prompt69/70 are reserved for the original signed-in desktop Sol High
    # orchestrator. Reviews retain their actual audit owner, but no route row
    # may ever regress to an unassigned owner or a different supervisor.
    if task["parent_route"] in {"Prompt69", "Prompt70"}:
        add_if(errors, task["owner"] == "unassigned", f"{prefix}: Prompt69/70 owner cannot be unassigned")
        add_if(errors, task["supervising_lead"] != "/root", f"{prefix}: Prompt69/70 supervising authority must be /root")
        if task["kind"] in {"prompt_preparation", "pro_research"}:
            add_if(errors, task["owner"] != DESKTOP_OWNER, f"{prefix}: wrong Prompt69/70 desktop owner")
        if task["kind"] == "pro_research":
            add_if(errors, not isinstance(runtime, dict) or runtime.get("route") != DESKTOP_RUNTIME, f"{prefix}: wrong Prompt69/70 launch runtime")
    if task_id in {
        "PIPE-P71-PRIVATE-POINT-ENERGY-CONTRACT-134",
        "PIPE-P72-MODULAR-COVER-CIRCUIT-CONTRACT-135",
        "PIPE-P73-MINIMAL-COUNTEREXAMPLE-NEW-OP-CONTRACT-137",
        "PIPE-P74-GLOBAL-PSD-CHARACTER-CONTRACT-139",
    }:
        add_if(errors, task["owner"] != DESKTOP_OWNER, f"{prefix}: wrong pipeline route owner")
        add_if(errors, task["supervising_lead"] != "Sol Medium Research Pipeline Lead", f"{prefix}: wrong pipeline supervising lead")
        add_if(errors, not isinstance(runtime, dict) or runtime.get("pro_cell") is not False, f"{prefix}: preparation cannot consume a Pro cell")

    add_if(errors, task["status"] == "active" and task["operational_state"] != "active", f"{prefix}: active status/state mismatch")
    add_if(errors, task["status"] == "prepared" and task["operational_state"] != "prepared", f"{prefix}: prepared status/state mismatch")
    add_if(errors, task["status"] in {"rejected", "frozen"} and task["operational_state"] not in {"frozen", "terminal"}, f"{prefix}: rejected/frozen task must be closed")
    add_if(errors, task["current_route_marker"] and task["route_queue"] == "none", f"{prefix}: current route marker needs a queue state")
    add_if(errors, not task["current_route_marker"] and task["route_queue"] != "none", f"{prefix}: noncurrent task cannot affect queue metrics")
    add_if(
        errors,
        task["lifecycle_stage"] == "launch_ready"
        and task["current_route_marker"]
        and task["route_queue"] != "launch_ready",
        f"{prefix}: current launch-ready stage/queue mismatch",
    )

    if task["kind"] == "audit":
        add_if(errors, task["audit_outcome"] == "not_applicable", f"{prefix}: audit needs an audit outcome")
    else:
        add_if(errors, task["audit_outcome"] != "not_applicable", f"{prefix}: non-audit cannot affect audit totals")
    if task["audit_outcome"] == "accepted_negative":
        add_if(errors, task["evidence_label"] != "accepted-negative-audit", f"{prefix}: negative audit label mismatch")

    hashes = task["hashes"]
    add_if(errors, not isinstance(hashes, list), f"{prefix}: hashes must be a list")
    if isinstance(hashes, list):
        seen_hashes: set[tuple[str, str | None]] = set()
        for index, item in enumerate(hashes):
            label = f"{prefix}: hash[{index}]"
            expected_keys = {"kind", "algorithm", "value", "path"}
            add_if(errors, not isinstance(item, dict) or set(item) != expected_keys, f"{label}: malformed hash record")
            if not isinstance(item, dict) or set(item) != expected_keys:
                continue
            add_if(errors, item["algorithm"] != "sha256", f"{label}: unsupported algorithm")
            add_if(errors, SHA256_RE.fullmatch(item["value"]) is None, f"{label}: malformed SHA-256")
            identity = (item["kind"], item["path"])
            add_if(errors, identity in seen_hashes, f"{label}: duplicate kind/path")
            seen_hashes.add(identity)
            if item["path"] is not None:
                add_if(errors, not safe_relative_path(item["path"]), f"{label}: unsafe repository path")
                candidate = ROOT / item["path"]
                add_if(errors, not candidate.is_file(), f"{label}: tracked path missing")
                if candidate.is_file() and SHA256_RE.fullmatch(item["value"]):
                    add_if(errors, sha256_file(candidate) != item["value"], f"{label}: repository hash mismatch")

    timestamps = task["timestamps"]
    add_if(errors, not isinstance(timestamps, list), f"{prefix}: timestamps must be a list")
    if isinstance(timestamps, list):
        for index, stamp in enumerate(timestamps):
            label = f"{prefix}: timestamp[{index}]"
            add_if(errors, not isinstance(stamp, dict) or set(stamp) != {"event", "at", "source"}, f"{label}: malformed timestamp")
            if isinstance(stamp, dict) and set(stamp) == {"event", "at", "source"}:
                add_if(errors, TIMESTAMP_RE.fullmatch(stamp["at"]) is None, f"{label}: timestamp lacks trustworthy offset")
                add_if(errors, not stamp["source"].strip(), f"{label}: missing timestamp source")


def validate(ledger: Mapping[str, Any], schema: Mapping[str, Any]) -> tuple[list[str], dict[str, Any]]:
    errors: list[str] = []
    validate_schema_contract(schema, errors)
    expected_root = {
        "schema_version", "base_commit", "promotion_registry_commit", "lifecycle_stages", "verification_levels",
        "tasks", "placeholders", "expected_metrics",
    }
    add_if(errors, set(ledger) != expected_root, "ledger: fields differ from frozen root schema")
    if set(ledger) != expected_root:
        return errors, {}
    add_if(errors, ledger["schema_version"] != "1.0.0", "ledger: unsupported schema version")
    add_if(errors, ledger["lifecycle_stages"] != LIFECYCLE_STAGES, "ledger: lifecycle stages changed or reordered")
    add_if(errors, COMMIT_RE.fullmatch(ledger["base_commit"]) is None, "ledger: malformed base commit")
    if COMMIT_RE.fullmatch(ledger["base_commit"]):
        add_if(errors, not commit_exists(ledger["base_commit"]), "ledger: base commit is unavailable")

    tasks = ledger["tasks"]
    add_if(errors, not isinstance(tasks, list), "ledger: tasks must be a list")
    if not isinstance(tasks, list):
        return errors, {}
    ids = [task.get("id") for task in tasks if isinstance(task, dict)]
    duplicates = sorted(task_id for task_id, count in Counter(ids).items() if count > 1)
    add_if(errors, bool(duplicates), f"ledger: duplicate task IDs {duplicates}")
    task_ids = {task_id for task_id in ids if isinstance(task_id, str)}
    for index, task in enumerate(tasks):
        if not isinstance(task, dict):
            errors.append(f"ledger: task[{index}] is not an object")
            continue
        validate_task(task, task_ids, errors)

    validate_promotion_registry(ledger, tasks, errors)

    tasks_by_id = {task["id"]: task for task in tasks if isinstance(task, dict) and isinstance(task.get("id"), str)}
    cycle = find_cycle(tasks_by_id) if len(tasks_by_id) == len(tasks) else None
    add_if(errors, cycle is not None, f"ledger: dependency cycle {' -> '.join(cycle or [])}")

    markers = Counter(task["parent_route"] for task in tasks if task["current_route_marker"])
    duplicate_markers = sorted(route for route, count in markers.items() if count > 1)
    add_if(errors, bool(duplicate_markers), f"ledger: multiple current route markers {duplicate_markers}")

    placeholders = ledger["placeholders"]
    add_if(errors, not isinstance(placeholders, list), "ledger: placeholders must be a list")
    if isinstance(placeholders, list):
        placeholder_ids: set[str] = set()
        for index, placeholder in enumerate(placeholders):
            label = f"placeholder[{index}]"
            keys = {"placeholder_id", "authoritative", "reason", "parent_route", "lifecycle_stage"}
            add_if(errors, not isinstance(placeholder, dict) or set(placeholder) != keys, f"{label}: malformed placeholder")
            if isinstance(placeholder, dict) and set(placeholder) == keys:
                add_if(errors, placeholder["authoritative"] is not False, f"{label}: placeholder cannot be authoritative")
                add_if(errors, placeholder["lifecycle_stage"] != "publication", f"{label}: unexpected placeholder stage")
                add_if(errors, placeholder["placeholder_id"] in placeholder_ids, f"{label}: duplicate placeholder ID")
                placeholder_ids.add(placeholder["placeholder_id"])

    metrics = derive_metrics(tasks)
    add_if(errors, metrics != ledger["expected_metrics"], f"ledger: expected metrics mismatch; derived={json.dumps(metrics, sort_keys=True)}")
    return errors, metrics


def main(argv: Sequence[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--ledger", type=Path, default=DEFAULT_LEDGER)
    parser.add_argument("--schema", type=Path, default=DEFAULT_SCHEMA)
    parser.add_argument("--print-metrics", action="store_true")
    args = parser.parse_args(argv)
    try:
        ledger = strict_json(args.ledger)
        schema = strict_json(args.schema)
        if not isinstance(ledger, dict) or not isinstance(schema, dict):
            raise LedgerError("ledger and schema roots must be objects")
        errors, metrics = validate(ledger, schema)
    except LedgerError as exc:
        print(f"TASK LEDGER INVALID: {exc}", file=sys.stderr)
        return 1
    if errors:
        print("TASK LEDGER INVALID", file=sys.stderr)
        for error in sorted(errors):
            print(f"- {error}", file=sys.stderr)
        return 1
    print("TASK LEDGER VALID")
    if args.print_metrics:
        print(json.dumps(metrics, indent=2, sort_keys=True))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
