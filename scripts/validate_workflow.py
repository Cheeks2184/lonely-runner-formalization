#!/usr/bin/env python3
"""Validate the project workflow control plane without judging mathematics.

This intentionally small validator checks the durable routing and lifecycle
records.  It can establish that records are structurally consistent, but it
cannot certify the truth, correctness, or kernel validity of a proof claim.
"""

from __future__ import annotations

import argparse
import hashlib
import json
import math
import sys
import tomllib
from pathlib import Path
from typing import Any, Mapping


ROOT = Path(__file__).resolve().parents[1]
POLICY_PATH = Path("research/workflow-policy.json")
STATE_PATH = Path("research/workflow-state.json")
CONFIG_PATH = Path(".codex/config.toml")
WORKFLOW_DOCUMENT = Path("docs/project-workflow.md")
EXPECTED_LEGACY_SHA256 = "595a0aba29a22195d4611937dc3bbb805880bf38952f129a86033f75e50e2527"
EXPECTED_ROLES = {
    "orchestrator": ("gpt-6-astra", "high"),
    "research": ("gpt-6-astra", "xhigh"),
    "routine": ("gpt-5.6-terra", "high"),
}
AGENT_CONFIGS = {
    "research": Path(".codex/agents/researcher.toml"),
    "routine": Path(".codex/agents/implementer.toml"),
}
PHASE_STATUSES = {
    "setup_only": "not_started",
    "ready": "not_started",
    "research": "in_progress",
    "complete": "complete",
    "interrupted": "interrupted",
}
TASK_KINDS = {"setup", "research", "routine", "review"}
COMPLETION_EVIDENCE_FIELDS = {
    "declaration_type",
    "axioms",
    "artifact",
    "source_checkpoint",
    "clean_source_build",
    "trust_audit",
    "independent_semantic_review",
    "regressions",
    "recorded_at",
}


def load_json(path: Path) -> Any:
    try:
        return json.loads(path.read_text(encoding="utf-8"))
    except (OSError, UnicodeDecodeError, json.JSONDecodeError) as exc:
        raise ValueError(f"{path}: invalid JSON: {exc}") from exc


def load_toml(path: Path) -> Mapping[str, Any]:
    try:
        return tomllib.loads(path.read_text(encoding="utf-8"))
    except (OSError, UnicodeDecodeError, tomllib.TOMLDecodeError) as exc:
        raise ValueError(f"{path}: invalid TOML: {exc}") from exc


def sha256_file(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as handle:
        for block in iter(lambda: handle.read(1024 * 1024), b""):
            digest.update(block)
    return digest.hexdigest()


def nonempty_string(value: Any) -> bool:
    return isinstance(value, str) and bool(value.strip())


def recorded(value: Any) -> bool:
    """Accept a present evidence value without interpreting its mathematical content."""
    if isinstance(value, str):
        return bool(value.strip())
    return bool(value)


def nonnegative_integer(value: Any) -> bool:
    """Return whether a JSON value is a nonnegative integer, excluding booleans."""
    return isinstance(value, int) and not isinstance(value, bool) and value >= 0


def nonnegative_finite_number(value: Any) -> bool:
    """Return whether a JSON number is finite, nonnegative, and not a boolean."""
    if isinstance(value, bool):
        return False
    if isinstance(value, int):
        # JSON integers are finite regardless of magnitude; passing a very
        # large one to math.isfinite first can itself raise OverflowError.
        return value >= 0
    return isinstance(value, float) and math.isfinite(value) and value >= 0


def historical_medium_task_ids(policy: Mapping[str, Any], errors: list[str]) -> set[str]:
    """Validate and return the immutable exception list for pre-migration records.

    The exception exists only to preserve durable provenance for completed work
    launched under the previous Terra/medium policy.  It is deliberately not a
    general permit for new or active Medium records.
    """
    history = policy.get("routing_history")
    if not isinstance(history, Mapping):
        errors.append("policy.routing_history must be an object")
        return set()
    task_ids = history.get("terra_medium_task_ids")
    if not isinstance(task_ids, list):
        errors.append("policy.routing_history.terra_medium_task_ids must be an array of nonempty task IDs")
        return set()
    valid_ids = [task_id for task_id in task_ids if nonempty_string(task_id)]
    if len(valid_ids) != len(task_ids):
        errors.append("policy.routing_history.terra_medium_task_ids must be an array of nonempty task IDs")
    if len(valid_ids) != len(set(valid_ids)):
        errors.append("policy.routing_history.terra_medium_task_ids must contain unique task IDs")
    return set(valid_ids)


def is_historical_medium_record(
    task: Mapping[str, Any], collection: str, historical_ids: set[str]
) -> bool:
    """Recognize only terminal completed records explicitly preserved by policy."""
    return (
        collection == "completed_tasks"
        and task.get("status") in {"complete", "interrupted"}
        and task.get("id") in historical_ids
        and (task.get("requested_model"), task.get("requested_effort")) == ("gpt-5.6-terra", "medium")
    )


def validate_delivery_metrics(task: Mapping[str, Any], collection: str, label: str, errors: list[str]) -> None:
    """Validate measured Terra/high delivery metadata without inventing usage.

    ``usage`` is either null (the runtime did not expose usage) or exactly a
    source plus actual input/output token counts from one per-task receipt.
    Null remains unknown and is never converted to a zero value by reporting.
    """
    metrics = task.get("delivery_metrics")
    required = {
        "check_kind",
        "first_check_success",
        "worker_repair_rounds",
        "astra_repair_rounds",
        "astra_repair_lines",
        "worker_elapsed_seconds",
        "usage",
        "evidence",
    }
    if not isinstance(metrics, Mapping):
        errors.append(f"{label}.delivery_metrics must be an object for a new Terra high task")
        return
    missing = sorted(required - set(metrics))
    extra = sorted(set(metrics) - required)
    if missing or extra:
        errors.append(f"{label}.delivery_metrics must contain exactly the documented delivery metric fields")
        return
    if not isinstance(metrics["check_kind"], str) or metrics["check_kind"] not in {"lean", "python", "static", "other"}:
        errors.append(f"{label}.delivery_metrics.check_kind must be lean, python, static, or other")
    if metrics["first_check_success"] is not None and not isinstance(metrics["first_check_success"], bool):
        errors.append(f"{label}.delivery_metrics.first_check_success must be a boolean or null")
    repairs = metrics["worker_repair_rounds"]
    if not nonnegative_integer(repairs) or repairs > 2:
        errors.append(f"{label}.delivery_metrics.worker_repair_rounds must be a nonnegative integer at most 2")
    if not nonnegative_integer(metrics["astra_repair_rounds"]):
        errors.append(f"{label}.delivery_metrics.astra_repair_rounds must be a nonnegative integer")
    lines = metrics["astra_repair_lines"]
    if lines is not None and not nonnegative_integer(lines):
        errors.append(f"{label}.delivery_metrics.astra_repair_lines must be a nonnegative integer or null")
    elapsed = metrics["worker_elapsed_seconds"]
    if elapsed is not None and not nonnegative_finite_number(elapsed):
        errors.append(f"{label}.delivery_metrics.worker_elapsed_seconds must be a nonnegative finite number or null")

    usage = metrics["usage"]
    if usage is not None:
        if not isinstance(usage, Mapping) or set(usage) != {"source", "input_tokens", "output_tokens"}:
            errors.append(f"{label}.delivery_metrics.usage must be null or source with actual input_tokens and output_tokens")
        else:
            if not nonempty_string(usage["source"]):
                errors.append(f"{label}.delivery_metrics.usage.source must be a nonempty evidence source")
            for field in ("input_tokens", "output_tokens"):
                if not nonnegative_finite_number(usage[field]):
                    errors.append(f"{label}.delivery_metrics.usage.{field} must be a nonnegative finite number")

    evidence = metrics["evidence"]
    if not isinstance(evidence, list) or not all(nonempty_string(path) for path in evidence):
        errors.append(f"{label}.delivery_metrics.evidence must be an array of nonempty paths")
    elif collection == "completed_tasks" and not evidence:
        errors.append(f"{label}.delivery_metrics.evidence must be nonempty for a closed task")


def has_explicit_user_high_override(task: Mapping[str, Any], label: str, errors: list[str]) -> bool:
    """Accept only the durable record for a per-task user-authorized Astra/high route."""
    override = task.get("routing_override")
    expected = {
        "source": "user",
        "requested_model": "gpt-6-astra",
        "requested_effort": "high",
    }
    if not isinstance(override, Mapping):
        errors.append(f"{label} Astra high routing requires a routing_override object")
        return False
    if set(override) != {"source", "requested_model", "requested_effort", "instruction"}:
        errors.append(f"{label}.routing_override must record exactly source, requested_model, requested_effort, and instruction")
        return False
    if any(override.get(field) != value for field, value in expected.items()):
        errors.append(f"{label}.routing_override must record the explicit user Astra high route")
        return False
    if not nonempty_string(override.get("instruction")):
        errors.append(f"{label}.routing_override.instruction must be a nonempty string")
        return False
    if (task.get("requested_model"), task.get("requested_effort")) != (
        override["requested_model"], override["requested_effort"]
    ):
        errors.append(f"{label}.routing_override must match the task requested route")
        return False
    return True


def validate_task(
    task: Any, collection: str, index: int, errors: list[str], historical_medium_ids: set[str]
) -> None:
    label = f"{collection}[{index}]"
    if not isinstance(task, Mapping):
        errors.append(f"{label} must be an object")
        return
    for field in ("id", "target", "source_checkpoint"):
        if not nonempty_string(task.get(field)):
            errors.append(f"{label}.{field} must be a nonempty string")
    kind = task.get("kind")
    if kind not in TASK_KINDS:
        errors.append(f"{label}.kind must be one of {sorted(TASK_KINDS)}")
    status = task.get("status")
    allowed_statuses = {"in_progress", "interrupted"} if collection == "active_tasks" else {"complete", "interrupted"}
    if status not in allowed_statuses:
        errors.append(f"{label}.status must be one of {sorted(allowed_statuses)}")
    owned_files = task.get("owned_files")
    if not isinstance(owned_files, list) or not all(nonempty_string(item) for item in owned_files):
        errors.append(f"{label}.owned_files must be an array of nonempty paths")
    checks = task.get("checks")
    if not isinstance(checks, list):
        errors.append(f"{label}.checks must be an array")

    model, effort = task.get("requested_model"), task.get("requested_effort")
    if kind in {"research", "review"}:
        if (model, effort) == EXPECTED_ROLES["research"]:
            if "routing_override" in task:
                errors.append(f"{label}.routing_override is allowed only for an explicit Astra high route")
        elif (model, effort) == EXPECTED_ROLES["orchestrator"]:
            has_explicit_user_high_override(task, label, errors)
        else:
            errors.append(f"{label} {kind} routing must request gpt-6-astra xhigh")
            if "routing_override" in task:
                errors.append(f"{label}.routing_override must match the task requested route")
    uses_historical_medium = is_historical_medium_record(task, collection, historical_medium_ids)
    if kind == "routine" and (model, effort) != EXPECTED_ROLES["routine"] and not uses_historical_medium:
        errors.append(f"{label} routine routing must request gpt-5.6-terra high; Medium is reserved for listed completed historical records")
    if kind == "setup" and (model, effort) not in {EXPECTED_ROLES["research"], EXPECTED_ROLES["routine"]} and not uses_historical_medium:
        errors.append(f"{label} setup routing must request an approved current route; Medium is reserved for listed completed historical records")
    if kind not in {"research", "review"} and "routing_override" in task:
        errors.append(f"{label}.routing_override is allowed only for research or review tasks")

    # Observed runtime provenance is deliberately optional.  Its absence must
    # never be turned into a claim that the requested route was observed.
    for field in ("observed_model", "observed_effort"):
        if field in task and task[field] is not None and not nonempty_string(task[field]):
            errors.append(f"{label}.{field} must be a string or null when present")
    observed = (task.get("observed_model"), task.get("observed_effort"))
    requested = (model, effort)
    if any(value is not None for value in observed) and observed != requested:
        if status != "interrupted" or not nonempty_string(task.get("failure_reason")):
            errors.append(f"{label} observed routing differs from requested routing without an interrupted failure record")

    # Both routine tasks and setup maintenance on the current Terra/high route
    # receive the same delivery record.  Astra work and preserved historical
    # Medium records retain their original, intentionally sparse provenance.
    if (model, effort) == EXPECTED_ROLES["routine"]:
        validate_delivery_metrics(task, collection, label, errors)


def validate_root(root: Path = ROOT) -> list[str]:
    """Return all structural workflow errors for *root*; never judge proof validity."""
    root = Path(root)
    errors: list[str] = []
    required = [POLICY_PATH, STATE_PATH, CONFIG_PATH, WORKFLOW_DOCUMENT, *AGENT_CONFIGS.values()]
    for relative in required:
        if not (root / relative).is_file():
            errors.append(f"missing required workflow file: {relative}")
    if errors:
        return errors
    try:
        policy = load_json(root / POLICY_PATH)
        state = load_json(root / STATE_PATH)
        config = load_toml(root / CONFIG_PATH)
        agent_configs = {role: load_toml(root / path) for role, path in AGENT_CONFIGS.items()}
    except ValueError as exc:
        return [str(exc)]
    if not isinstance(policy, Mapping) or not isinstance(state, Mapping):
        return ["workflow policy and state must both be JSON objects"]

    medium_history_ids = historical_medium_task_ids(policy, errors)

    if policy.get("schema_version") != 1:
        errors.append("policy.schema_version must be 1")
    if policy.get("instructions_path") != str(CONFIG_PATH):
        errors.append("policy.instructions_path must be .codex/config.toml")
    if policy.get("max_concurrent_agents_including_orchestrator") != 4:
        errors.append("policy concurrency must remain 4 including the orchestrator")
    for field, expected in {
        "browser_model_sessions_allowed": False,
        "external_cli_agents_allowed": False,
        "silent_model_substitution_allowed": False,
    }.items():
        if policy.get(field) is not expected:
            errors.append(f"policy.{field} must remain {str(expected).lower()}")
    for section, expected_values in {
        "storage": {
            "retain_toolchain": True, "retain_unique_evidence": True,
            "duplicate_build_caches_allowed": False, "clean_rebuildable_outputs_when_idle": True,
        },
        "continuation": {
            "routine_confirmation_required": False, "branch_failure_ends_goal": False,
            "research_start_requires_user_go_ahead": True, "external_runtime_limits_may_interrupt": True,
        },
    }.items():
        values = policy.get(section)
        for field, expected in expected_values.items():
            if not isinstance(values, Mapping) or values.get(field) is not expected:
                errors.append(f"policy.{section}.{field} must remain {str(expected).lower()}")
    completion_policy = policy.get("completion")
    if not isinstance(completion_policy, Mapping):
        errors.append("policy.completion must be an object")
    else:
        if completion_policy.get("proof_declaration_type") != "LonelyRunner.Conjecture":
            errors.append("policy completion proof declaration type must be LonelyRunner.Conjecture")
        if completion_policy.get("disproof_declaration_type") != "Not LonelyRunner.Conjecture":
            errors.append("policy completion disproof declaration type must be Not LonelyRunner.Conjecture")
        if completion_policy.get("allowed_axioms") != ["propext", "Classical.choice", "Quot.sound"]:
            errors.append("policy completion allowed axioms have drifted")
        for field in ("independent_semantic_review_required", "clean_source_build_required"):
            if completion_policy.get(field) is not True:
                errors.append(f"policy completion {field} must remain true")

    roles = policy.get("roles")
    if not isinstance(roles, Mapping):
        errors.append("policy.roles must be an object")
    else:
        for role, (model, effort) in EXPECTED_ROLES.items():
            route = roles.get(role)
            if not isinstance(route, Mapping) or (route.get("model"), route.get("effort")) != (model, effort):
                errors.append(f"policy.roles.{role} must route to {model} {effort}")
        orchestrator = roles.get("orchestrator", {})
        if not isinstance(orchestrator, Mapping) or orchestrator.get("transport") != "current-session":
            errors.append("policy.roles.orchestrator must use the current session")
        for role in ("research", "routine"):
            route = roles.get(role, {})
            if not isinstance(route, Mapping) or route.get("transport") != "in-session-subagent" or route.get("fork_turns") != "none":
                errors.append(f"policy.roles.{role} must use an in-session subagent with fork_turns none")

    if (config.get("model"), config.get("model_reasoning_effort")) != EXPECTED_ROLES["orchestrator"]:
        errors.append(".codex/config.toml orchestrator route must be gpt-6-astra high")
    if config.get("agents", {}).get("max_threads") != policy.get("max_concurrent_agents_including_orchestrator"):
        errors.append(".codex/config.toml agents.max_threads must match policy concurrency")
    for role, agent_config in agent_configs.items():
        if (agent_config.get("model"), agent_config.get("model_reasoning_effort")) != EXPECTED_ROLES[role]:
            errors.append(f"{AGENT_CONFIGS[role]} must match policy {role} routing")
    instructions = config.get("developer_instructions")
    if not nonempty_string(instructions):
        errors.append(".codex/config.toml developer_instructions must be nonempty")
    elif any(token not in instructions for token in (
        "docs/project-workflow.md", "research/workflow-policy.json", "research/workflow-state.json",
        "SETUP GATE", "PERSISTENCE", "GPT-6 Astra", "GPT-5.6 Terra",
    )):
        errors.append(".codex/config.toml developer_instructions is missing workflow startup, gate, persistence, or role guidance")

    legacy = policy.get("legacy_ledger")
    if not isinstance(legacy, Mapping) or legacy.get("mode") != "historical-only":
        errors.append("policy legacy ledger mode must remain historical-only")
    if not isinstance(legacy, Mapping) or legacy.get("sha256") != EXPECTED_LEGACY_SHA256:
        errors.append("policy legacy ledger hash has drifted")
    if isinstance(legacy, Mapping) and nonempty_string(legacy.get("path")):
        ledger_path = root / legacy["path"]
        if not ledger_path.is_file():
            errors.append(f"legacy ledger is missing: {legacy['path']}")
        elif legacy.get("sha256") != sha256_file(ledger_path):
            errors.append("legacy ledger content does not match its preserved hash")

    phase, goal_status = state.get("phase"), state.get("goal_status")
    if state.get("schema_version") != 1:
        errors.append("state.schema_version must be 1")
    if not nonempty_string(state.get("latest_checkpoint")):
        errors.append("state.latest_checkpoint must be a nonempty string")
    next_actions = state.get("next_actions")
    if not isinstance(next_actions, list) or not next_actions or not all(nonempty_string(item) for item in next_actions):
        errors.append("state.next_actions must be a nonempty array of nonempty strings")
    if not isinstance(state.get("research_holds"), list):
        errors.append("state.research_holds must be an array")
    if phase not in PHASE_STATUSES:
        errors.append(f"state.phase must be one of {sorted(PHASE_STATUSES)}")
    elif goal_status != PHASE_STATUSES[phase]:
        errors.append(f"state.goal_status must be {PHASE_STATUSES[phase]!r} for phase {phase!r}")
    authorization = state.get("start_authorization")
    active = state.get("active_tasks")
    completed = state.get("completed_tasks")
    for collection, tasks in (("active_tasks", active), ("completed_tasks", completed)):
        if not isinstance(tasks, list):
            errors.append(f"state.{collection} must be an array")
            continue
        for index, task in enumerate(tasks):
            validate_task(task, collection, index, errors, medium_history_ids)
    all_tasks = [task for tasks in (active, completed) if isinstance(tasks, list) for task in tasks if isinstance(task, Mapping)]
    ids = [task.get("id") for task in all_tasks if nonempty_string(task.get("id"))]
    if len(ids) != len(set(ids)):
        errors.append("task IDs must be unique across active and completed records")
    if phase in {"setup_only", "ready"}:
        if authorization is not None:
            errors.append(f"state.start_authorization must be null during {phase}")
        if any(task.get("kind") != "setup" for task in all_tasks):
            errors.append(f"{phase} may contain only setup task records")
    elif not nonempty_string(authorization):
        errors.append(f"state.start_authorization must be nonempty during {phase}")
    if phase in {"ready", "complete"} and isinstance(active, list) and active:
        errors.append(f"{phase} state may not contain active task records")

    evidence = state.get("completion_evidence")
    if phase == "complete":
        if not isinstance(evidence, Mapping):
            errors.append("complete state requires recorded completion_evidence")
        else:
            missing = sorted(field for field in COMPLETION_EVIDENCE_FIELDS if not recorded(evidence.get(field)))
            if missing:
                errors.append("complete state is missing completion evidence fields: " + ", ".join(missing))
            elif evidence.get("declaration_type") not in {
                completion_policy.get("proof_declaration_type") if isinstance(completion_policy, Mapping) else None,
                completion_policy.get("disproof_declaration_type") if isinstance(completion_policy, Mapping) else None,
            }:
                errors.append("completion evidence declaration_type is not a canonical declaration type")
            elif not isinstance(completion_policy, Mapping) or evidence.get("axioms") != completion_policy.get("allowed_axioms"):
                errors.append("completion evidence axioms do not match the canonical allowed axioms")
    elif evidence is not None and not isinstance(evidence, Mapping):
        errors.append("state.completion_evidence must be an object or null")
    return errors


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--root", type=Path, default=ROOT, help="project root to validate")
    args = parser.parse_args(argv)
    errors = validate_root(args.root)
    if errors:
        for error in errors:
            print(f"workflow validation error: {error}", file=sys.stderr)
        return 1
    print("workflow structural validation passed; it cannot certify mathematical validity.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
