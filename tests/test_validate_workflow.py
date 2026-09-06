import copy
import json
import shutil
import tempfile
import unittest
from pathlib import Path

from scripts.validate_workflow import ROOT, nonnegative_finite_number, validate_root


class WorkflowValidatorTests(unittest.TestCase):
    def setUp(self):
        self.tempdir = tempfile.TemporaryDirectory()
        self.root = Path(self.tempdir.name)
        for relative in (
            "research/workflow-policy.json",
            "research/workflow-state.json",
            "research/task-ledger.json",
            ".codex/config.toml",
            ".codex/agents/researcher.toml",
            ".codex/agents/implementer.toml",
        ):
            source = ROOT / relative
            destination = self.root / relative
            destination.parent.mkdir(parents=True, exist_ok=True)
            shutil.copy2(source, destination)
        workflow_doc = self.root / "docs/project-workflow.md"
        workflow_doc.parent.mkdir(parents=True)
        workflow_doc.write_text("# Workflow\n", encoding="utf-8")

    def tearDown(self):
        self.tempdir.cleanup()

    def change_json(self, relative, mutate):
        path = self.root / relative
        value = json.loads(path.read_text(encoding="utf-8"))
        mutate(value)
        path.write_text(json.dumps(value), encoding="utf-8")

    def write_setup_state(self):
        """Install a phase-stable state for tests that exercise setup gates.

        The checked-in state advances as the project progresses, so setup-gate
        tests must not inherit its phase or task history.
        """
        state = {
            "schema_version": 1,
            "phase": "setup_only",
            "goal_status": "not_started",
            "objective": "Validate workflow lifecycle gates.",
            "start_authorization": None,
            "active_tasks": [],
            "completed_tasks": [],
            "latest_checkpoint": "Stable setup-phase test fixture.",
            "next_actions": ["Exercise the setup gate."],
            "research_holds": [],
            "completion_evidence": None,
        }
        (self.root / "research/workflow-state.json").write_text(
            json.dumps(state), encoding="utf-8"
        )

    def assertError(self, fragment):
        errors = validate_root(self.root)
        self.assertTrue(any(fragment in error for error in errors), errors)

    @staticmethod
    def high_metrics(*, closed=True):
        """A complete current Terra/high receipt used by routing fixtures."""
        return {
            "check_kind": "python",
            "first_check_success": True,
            "worker_repair_rounds": 0,
            "astra_repair_rounds": 0,
            "astra_repair_lines": 0,
            "worker_elapsed_seconds": 1.25,
            "usage": {
                "source": "runtime task usage receipt",
                "input_tokens": 11,
                "output_tokens": 7,
            },
            "evidence": ["research/receipt.json"] if closed else [],
        }

    def add_new_terra_high_task(self, *, kind="routine", status="complete"):
        def add(state):
            state["completed_tasks"].append({
                "id": f"new-terra-high-{kind}", "kind": kind, "status": status,
                "requested_model": "gpt-5.6-terra", "requested_effort": "high",
                "target": "focused implementation", "source_checkpoint": "abc",
                "owned_files": [], "checks": [],
                "delivery_metrics": self.high_metrics(closed=status != "in_progress"),
            })
        self.change_json("research/workflow-state.json", add)

    def test_checked_in_research_state_is_valid(self):
        self.assertEqual(validate_root(ROOT), [])

    def test_rejects_policy_routing_drift(self):
        self.change_json("research/workflow-policy.json", lambda policy: policy["roles"]["research"].update(effort="high"))
        self.assertError("policy.roles.research")

    def test_historical_medium_records_are_preserved_but_new_or_active_medium_is_rejected(self):
        # The checked-in state contains a listed terminal Medium record.  Its
        # preservation is part of the migration contract, including setup work.
        self.assertEqual(validate_root(self.root), [])

        def active_historical_medium(state):
            task = next(task for task in state["completed_tasks"] if task["requested_effort"] == "medium")
            state["completed_tasks"].remove(task)
            task.update(kind="setup", status="in_progress")
            state["active_tasks"].append(task)
        self.change_json("research/workflow-state.json", active_historical_medium)
        self.assertError("Medium is reserved for listed completed historical records")

        def unlisted_medium(state):
            task = state["active_tasks"].pop()
            task.update(id="new-medium-record", status="complete")
            state["completed_tasks"].append(task)
        self.change_json("research/workflow-state.json", unlisted_medium)
        self.assertError("Medium is reserved for listed completed historical records")

    def test_new_terra_high_routine_and_setup_records_are_accepted(self):
        self.add_new_terra_high_task()
        self.add_new_terra_high_task(kind="setup")
        self.assertEqual(validate_root(self.root), [])

    def test_routing_history_requires_unique_nonempty_ids(self):
        self.change_json(
            "research/workflow-policy.json",
            lambda policy: policy["routing_history"].update(terra_medium_task_ids=["", "duplicate", "duplicate"]),
        )
        self.assertError("array of nonempty task IDs")
        self.assertError("unique task IDs")

    def test_routing_history_rejects_nonstring_json_values_without_crashing(self):
        self.change_json(
            "research/workflow-policy.json",
            lambda policy: policy["routing_history"].update(terra_medium_task_ids=["historical", [], {"id": "bad"}]),
        )
        self.assertError("array of nonempty task IDs")

    def test_large_json_integer_is_finite_without_float_conversion(self):
        self.assertTrue(nonnegative_finite_number(10 ** 1000))

    def test_new_terra_high_metrics_reject_missing_invalid_and_nan_values(self):
        self.add_new_terra_high_task()
        self.change_json("research/workflow-state.json", lambda state: state["completed_tasks"][-1].pop("delivery_metrics"))
        self.assertError("delivery_metrics must be an object")

        def malformed_metrics(state):
            state["completed_tasks"][-1]["delivery_metrics"] = self.high_metrics()
            state["completed_tasks"][-1]["delivery_metrics"].update(
                worker_repair_rounds=3,
                first_check_success="yes",
                check_kind=[],
                worker_elapsed_seconds=float("nan"),
                astra_repair_lines=-1,
            )
        self.change_json("research/workflow-state.json", malformed_metrics)
        self.assertError("at most 2")
        self.assertError("boolean or null")
        self.assertError("check_kind must be lean, python, static, or other")
        self.assertError("finite number")
        self.assertError("nonnegative integer or null")

        self.change_json(
            "research/workflow-state.json",
            lambda state: state["completed_tasks"][-1]["delivery_metrics"].update(
                evidence=[], usage={"source": "runtime receipt", "input_tokens": float("nan"), "output_tokens": 0}
            ),
        )
        self.assertError("usage.input_tokens must be a nonnegative finite number")
        self.assertError("evidence must be nonempty for a closed task")

    def test_rejects_project_config_parity_mismatch(self):
        path = self.root / ".codex/agents/implementer.toml"
        path.write_text(path.read_text(encoding="utf-8").replace('model = "gpt-5.6-terra"', 'model = "gpt-6-astra"'), encoding="utf-8")
        self.assertError("implementer.toml must match")

    def test_rejects_setup_gate_violation(self):
        self.write_setup_state()

        def add_research_task(state):
            state["active_tasks"] = [{
                "id": "research-1", "kind": "research", "requested_model": "gpt-6-astra",
                "requested_effort": "xhigh", "target": "bounded review", "source_checkpoint": "abc",
                "owned_files": [], "status": "in_progress", "checks": [],
            }]
        self.change_json("research/workflow-state.json", add_research_task)
        self.assertError("may contain only setup task records")

    def test_setup_state_can_transition_to_valid_research(self):
        self.write_setup_state()

        def start_research(state):
            state.update(
                phase="research",
                goal_status="in_progress",
                start_authorization="User approved research.",
            )
            state["active_tasks"] = [{
                "id": "research-1", "kind": "research", "requested_model": "gpt-6-astra",
                "requested_effort": "xhigh", "target": "bounded review", "source_checkpoint": "abc",
                "owned_files": [], "status": "in_progress", "checks": [],
            }]

        self.change_json("research/workflow-state.json", start_research)
        self.assertEqual(validate_root(self.root), [])

    def test_accepts_exact_explicit_user_astra_high_research_override(self):
        def add_override(state):
            state["active_tasks"] = [{
                "id": "high-research", "kind": "research", "requested_model": "gpt-6-astra",
                "requested_effort": "high", "target": "authorized implementation", "source_checkpoint": "abc",
                "owned_files": [], "status": "in_progress", "checks": [],
                "routing_override": {
                    "source": "user", "requested_model": "gpt-6-astra", "requested_effort": "high",
                    "instruction": "Use Astra high for this implementation.",
                },
            }]
        self.change_json("research/workflow-state.json", add_override)
        self.assertEqual(validate_root(self.root), [])

    def test_rejects_absent_mismatched_and_malformed_astra_high_override(self):
        def add_high_task(state):
            state["active_tasks"] = [{
                "id": "high-research", "kind": "research", "requested_model": "gpt-6-astra",
                "requested_effort": "high", "target": "authorized implementation", "source_checkpoint": "abc",
                "owned_files": [], "status": "in_progress", "checks": [],
            }]
        self.change_json("research/workflow-state.json", add_high_task)
        self.assertError("requires a routing_override object")

        def malformed(state):
            state["active_tasks"][0]["routing_override"] = {
                "source": "agent", "requested_model": "gpt-6-astra", "requested_effort": "high",
                "instruction": "", "extra": "not allowed",
            }
        self.change_json("research/workflow-state.json", malformed)
        self.assertError("must record exactly")

        def mismatched(state):
            state["active_tasks"][0]["routing_override"] = {
                "source": "user", "requested_model": "gpt-6-astra", "requested_effort": "xhigh",
                "instruction": "Use Astra high for this implementation.",
            }
        self.change_json("research/workflow-state.json", mismatched)
        self.assertError("must record the explicit user Astra high route")

    def test_rejects_legacy_hash_drift(self):
        self.change_json("research/workflow-policy.json", lambda policy: policy["legacy_ledger"].update(sha256="0" * 64))
        self.assertError("legacy ledger hash has drifted")

    def test_rejects_policy_boolean_and_completion_contract_drift(self):
        def drift(policy):
            policy["browser_model_sessions_allowed"] = True
            policy["completion"]["allowed_axioms"] = ["propext"]
        self.change_json("research/workflow-policy.json", drift)
        self.assertError("browser_model_sessions_allowed")
        self.assertError("allowed axioms")

    def test_setup_and_ready_allow_only_setup_records_and_ready_has_no_active_tasks(self):
        self.write_setup_state()

        def violate_gate(state):
            state.update(phase="ready", goal_status="not_started")
            state["active_tasks"] = [{
                "id": "routine-1", "kind": "routine", "requested_model": "gpt-5.6-terra",
                "requested_effort": "medium", "target": "script", "source_checkpoint": "abc",
                "owned_files": [], "status": "in_progress", "checks": [],
            }]
        self.change_json("research/workflow-state.json", violate_gate)
        self.assertError("may contain only setup")
        self.assertError("may not contain active")

    def test_rejects_duplicate_task_ids_and_unrecorded_route_substitution(self):
        def add_duplicate(state):
            task = {
                "id": "same", "kind": "setup", "requested_model": "gpt-5.6-terra",
                "requested_effort": "medium", "target": "script", "source_checkpoint": "abc",
                "owned_files": [], "status": "in_progress", "checks": [],
                "observed_model": "gpt-6-astra", "observed_effort": "xhigh",
            }
            state["active_tasks"] = [task]
            state["completed_tasks"] = [dict(task, status="complete")]
        self.change_json("research/workflow-state.json", add_duplicate)
        self.assertError("task IDs must be unique")
        self.assertError("observed routing differs")

    def test_complete_phase_requires_recorded_evidence(self):
        def mark_complete(state):
            state.update(phase="complete", goal_status="complete", start_authorization="user said begin", completion_evidence=None)
        self.change_json("research/workflow-state.json", mark_complete)
        self.assertError("requires recorded completion_evidence")

    def test_complete_phase_rejects_empty_evidence_and_noncanonical_declaration(self):
        def mark_complete(state):
            state.update(phase="complete", goal_status="complete", start_authorization="user said begin")
            state["completion_evidence"] = {
                "declaration_type": "Some.Other.Statement", "axioms": ["propext"], "artifact": {},
                "source_checkpoint": "abc", "clean_source_build": False, "trust_audit": "ok",
                "independent_semantic_review": "ok", "regressions": [], "recorded_at": "now",
            }
        self.change_json("research/workflow-state.json", mark_complete)
        self.assertError("missing completion evidence fields")

    def test_complete_phase_requires_canonical_declaration_and_axioms(self):
        def mark_complete(state):
            state.update(phase="complete", goal_status="complete", start_authorization="user said begin")
            state["completion_evidence"] = {
                "declaration_type": "Some.Other.Statement", "axioms": ["propext"], "artifact": "proof.olean",
                "source_checkpoint": "abc", "clean_source_build": "build log", "trust_audit": "audit log",
                "independent_semantic_review": "review log", "regressions": ["test"], "recorded_at": "now",
            }
        self.change_json("research/workflow-state.json", mark_complete)
        self.assertError("not a canonical declaration type")
        self.change_json(
            "research/workflow-state.json",
            lambda state: state["completion_evidence"].update(declaration_type="LonelyRunner.Conjecture"),
        )
        self.assertError("axioms do not match")

    def test_requires_state_metadata_collections(self):
        def remove_metadata(state):
            state["latest_checkpoint"] = ""
            state["next_actions"] = []
            state["research_holds"] = None
        self.change_json("research/workflow-state.json", remove_metadata)
        self.assertError("latest_checkpoint")
        self.assertError("next_actions")
        self.assertError("research_holds")


if __name__ == "__main__":
    unittest.main()
