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
        self.assertEqual(metrics["active_pro_cells"], 1)
        self.assertEqual(metrics["route_queues"], {"launch_ready": 0, "waiting": 3, "parked": 0})
        self.assertEqual(metrics["audits"], {"total": 9, "accepted": 5, "accepted_negative": 4, "rejected": 0, "pending": 0})
        self.assertEqual(metrics["verification_level_queues"], {"1": 2, "2": 1, "3": 2})

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
            ledger["tasks"][-1]["route_queue"] = "parked"

        self.assertHasError(self.errors_for(mutate_queue), "expected metrics mismatch")

        def mutate_level(ledger):
            ledger["tasks"][-1]["verification"]["level"] = 3

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
