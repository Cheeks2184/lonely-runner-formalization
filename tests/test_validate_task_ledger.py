import copy
import tempfile
import unittest
from pathlib import Path

from scripts.validate_task_ledger import (
    DEFAULT_LEDGER,
    DEFAULT_SCHEMA,
    LedgerError,
    derive_metrics,
    strict_json,
    validate,
)


class TaskLedgerValidatorTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.ledger = strict_json(DEFAULT_LEDGER)
        cls.schema = strict_json(DEFAULT_SCHEMA)

    def errors_for(self, mutate):
        ledger = copy.deepcopy(self.ledger)
        mutate(ledger)
        errors, _ = validate(ledger, self.schema)
        return errors

    def assertHasError(self, errors, fragment):
        self.assertTrue(any(fragment in error for error in errors), errors)

    def test_checked_in_ledger_is_valid_and_metrics_are_exact(self):
        errors, metrics = validate(self.ledger, self.schema)
        self.assertEqual(errors, [])
        self.assertEqual(metrics, self.ledger["expected_metrics"])
        self.assertEqual(metrics["active_pro_cells"], 2)
        self.assertEqual(metrics["route_queues"], {"launch_ready": 0, "waiting": 2, "parked": 0})
        self.assertEqual(metrics["audits"], {"total": 26, "accepted": 13, "accepted_negative": 7, "rejected": 0, "pending": 6})
        self.assertEqual(metrics["verification_level_queues"], {"1": 1, "2": 4, "3": 3})

    def test_desktop_pro_authority_and_readback_are_fail_closed(self):
        def unassign(ledger):
            task = next(task for task in ledger["tasks"] if task["id"] == "PIPE-P69-RESPEC-128")
            task["owner"] = "unassigned"

        self.assertHasError(self.errors_for(unassign), "owner cannot be unassigned")

        def wrong_runtime(ledger):
            task = next(task for task in ledger["tasks"] if task["id"] == "SOL-P70-DESKTOP-LAUNCH-130")
            task["runtime"]["route"] = "top-level CLI"

        self.assertHasError(self.errors_for(wrong_runtime), "wrong Prompt69/70 launch runtime")

        for task_id in ("SOL-P67-PRO-C2-099", "SOL-P68-DESKTOP-LAUNCH-124"):
            with self.subTest(missing_readback=task_id):
                def missing_readback(ledger, target=task_id):
                    task = next(task for task in ledger["tasks"] if task["id"] == target)
                    del task["runtime"]["desktop_readback"]

                self.assertHasError(self.errors_for(missing_readback), "browser Pro cell needs exact desktop readback")

        def missing_payload_hash(ledger):
            task = next(task for task in ledger["tasks"] if task["id"] == "SOL-P67-PRO-C2-099")
            task["hashes"] = [item for item in task["hashes"] if item["kind"] != "launch_payload"]

        self.assertHasError(self.errors_for(missing_payload_hash), "browser Pro cell needs launch-payload hash")

        def conflated_orchestrator_effort(ledger):
            task = next(task for task in ledger["tasks"] if task["id"] == "SOL-P70-DESKTOP-LAUNCH-130")
            task["runtime"]["effort"] = "high"

        self.assertHasError(self.errors_for(conflated_orchestrator_effort), "browser Pro cell effort must be pro")

    def test_browser_pro_generation_never_enters_verification_queues(self):
        pro_tasks = [task for task in self.ledger["tasks"] if task["runtime"]["pro_cell"]]
        self.assertGreaterEqual(len(pro_tasks), 4)
        for task in pro_tasks:
            self.assertEqual(task["verification"], {"level": None, "state": "not_required"})

        def misclassify(ledger):
            task = next(task for task in ledger["tasks"] if task["id"] == "SOL-P68-DESKTOP-LAUNCH-124")
            task["verification"] = {"level": 3, "state": "active"}

        errors = self.errors_for(misclassify)
        self.assertHasError(errors, "browser Pro cell verification must be not_required without a level")
        self.assertHasError(errors, "expected metrics mismatch")

    def test_prompt67_launch_shape_and_payload_are_exact(self):
        task = next(task for task in self.ledger["tasks"] if task["id"] == "SOL-P67-PRO-C2-099")
        readback = task["runtime"]["desktop_readback"]
        self.assertEqual(
            (readback["tracked_prompt_bytes"], readback["tracked_prompt_characters"]),
            (14800, 14796),
        )
        self.assertEqual(
            (readback["submitted_payload_bytes"], readback["submitted_payload_characters"]),
            (14799, 14795),
        )
        payload = next(item for item in task["hashes"] if item["kind"] == "launch_payload")
        self.assertEqual(payload["value"], "30fefd070ee0a5b091ba520ee779022b7df3f2d489083d63989a77e6d34370b6")

    def test_pipeline_preparation_preserves_route_owner_without_using_pro(self):
        def wrong_owner(ledger):
            task = next(task for task in ledger["tasks"] if task["id"] == "PIPE-P72-MODULAR-COVER-CIRCUIT-CONTRACT-135")
            task["owner"] = "Sol Medium Research Pipeline Lead"

        self.assertHasError(self.errors_for(wrong_owner), "wrong pipeline route owner")

        def consumes_pro(ledger):
            task = next(task for task in ledger["tasks"] if task["id"] == "PIPE-P72-MODULAR-COVER-CIRCUIT-CONTRACT-135")
            task["runtime"]["pro_cell"] = True

        self.assertHasError(self.errors_for(consumes_pro), "preparation cannot consume a Pro cell")

    def test_duplicate_task_id_fails_closed(self):
        errors = self.errors_for(lambda ledger: ledger["tasks"].append(copy.deepcopy(ledger["tasks"][0])))
        self.assertHasError(errors, "duplicate task IDs")

    def test_invalid_stage_status_and_evidence_label_are_rejected(self):
        for field, value, fragment in (
            ("lifecycle_stage", "almost_done", "invalid lifecycle stage"),
            ("status", "successful", "invalid status"),
            ("evidence_label", "proof-ish", "invalid evidence label"),
        ):
            with self.subTest(field=field):
                errors = self.errors_for(lambda ledger, f=field, v=value: ledger["tasks"][0].__setitem__(f, v))
                self.assertHasError(errors, fragment)

    def test_missing_conditional_fields_are_rejected(self):
        def mutate(ledger):
            task = ledger["tasks"][0]
            task["status"] = "active"
            task["operational_state"] = "active"
            task["runtime"]["model"] = None
            task["timestamps"] = []

        errors = self.errors_for(mutate)
        self.assertHasError(errors, "active Pro cell needs model and effort")
        self.assertHasError(errors, "active Pro cell needs launch timestamp")
        self.assertHasError(errors, "expected metrics mismatch")

    def test_null_base_cannot_carry_evidence(self):
        def mutate(ledger):
            task = ledger["tasks"][0]
            task["base_commit"] = None

        errors = self.errors_for(mutate)
        self.assertHasError(errors, "null base allowed only before execution")
        self.assertHasError(errors, "null base cannot carry evidence")

    def test_queue_and_level_metrics_cannot_drift(self):
        def mutate_queue(ledger):
            task = next(task for task in ledger["tasks"] if task["id"] == "INFRA-ROLLING-LEDGER-CORRECTION-155")
            task["route_queue"] = "parked"

        self.assertHasError(self.errors_for(mutate_queue), "expected metrics mismatch")

        def mutate_level(ledger):
            ledger["expected_metrics"]["verification_level_queues"]["3"] = 1

        self.assertHasError(self.errors_for(mutate_level), "expected metrics mismatch")

    def test_prompt_hash_mismatch_is_rejected(self):
        def mutate(ledger):
            task = next(task for task in ledger["tasks"] if task["id"] == "VER-P68-FINAL-HASH-SCOPE-117")
            task["hashes"][0]["value"] = "0" * 64

        self.assertHasError(self.errors_for(mutate), "repository hash mismatch")

    def test_public_worktree_identifier_is_required(self):
        def mutate(ledger):
            ledger["tasks"][0]["worktree_id"] = "/home/example/private-worktree"

        self.assertHasError(self.errors_for(mutate), "worktree identifier is not public-safe")

    def test_unknown_dependency_and_cycles_are_rejected(self):
        def unknown(ledger):
            ledger["tasks"][0]["dependencies"] = ["MISSING-TASK-999"]

        self.assertHasError(self.errors_for(unknown), "unknown dependency")

        def cycle(ledger):
            ledger["tasks"][0]["dependencies"] = ["OPS-P67-RECOVERY-PACKAGE-100"]

        self.assertHasError(self.errors_for(cycle), "dependency cycle")

    def test_duplicate_json_keys_are_rejected(self):
        with tempfile.TemporaryDirectory() as directory:
            path = Path(directory) / "duplicate.json"
            path.write_text('{"id": 1, "id": 2}\n', encoding="utf-8")
            with self.assertRaises(LedgerError):
                strict_json(path)

    def test_derived_metrics_ignore_non_authoritative_placeholders(self):
        metrics = derive_metrics(self.ledger["tasks"])
        self.assertNotIn("publication-queue-unassigned", str(metrics))


if __name__ == "__main__":
    unittest.main()
