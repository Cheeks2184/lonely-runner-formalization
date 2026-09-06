import json
import subprocess
import tempfile
import unittest
from pathlib import Path

from scripts.report_delegation import ROOT, format_human, summarize


def task(task_id, *, status="complete", first=None, worker_rounds=0, astra_rounds=0,
         astra_lines=None, usage=None):
    return {
        "id": task_id,
        "status": status,
        "requested_model": "gpt-5.6-terra",
        "requested_effort": "high",
        "delivery_metrics": {
            "check_kind": "python",
            "first_check_success": first,
            "worker_repair_rounds": worker_rounds,
            "astra_repair_rounds": astra_rounds,
            "astra_repair_lines": astra_lines,
            "worker_elapsed_seconds": None,
            "usage": usage,
            "evidence": [],
        },
    }


class DelegationReportTests(unittest.TestCase):
    def test_unknown_is_distinct_from_zero_and_first_check_rate_excludes_unknown(self):
        state = {
            "active_tasks": [task("unknown", status="in_progress", first=None)],
            "completed_tasks": [
                task("pass", first=True),
                task("fail", first=False),
                # Historical Medium work must never enter the current report.
                dict(task("old"), requested_effort="medium"),
            ],
        }
        report = summarize(state)
        self.assertEqual(report["task_count"], 3)
        self.assertEqual(report["active_count"], 1)
        self.assertEqual(report["closed_count"], 2)
        self.assertEqual(report["first_check"], {"successful": 1, "known": 2})
        self.assertEqual(set(report["by_check_kind"]), {"python"})
        self.assertEqual(report["by_check_kind"]["python"]["task_count"], 3)
        self.assertIsNone(report["usage"]["input_tokens"])
        self.assertIsNone(report["usage"]["output_tokens"])
        self.assertIsNone(report["usage"]["total_tokens"])
        self.assertEqual(report["repairs"]["worker_rounds"], 0)
        self.assertIsNone(report["repairs"]["astra_lines"])

    def test_partial_actual_usage_coverage_totals_only_observed_records(self):
        state = {
            "active_tasks": [task("unknown-usage", status="in_progress", usage=None)],
            "completed_tasks": [task("observed-usage", usage={
                "source": "runtime receipt", "input_tokens": 12, "output_tokens": 8,
            })],
        }
        report = summarize(state)
        self.assertEqual(report["usage"], {
            "covered_tasks": 1,
            "task_count": 2,
            "input_tokens": 12.0,
            "output_tokens": 8.0,
            "total_tokens": 20.0,
        })

    def test_usage_without_a_complete_nonempty_source_is_unknown(self):
        missing_source = task("missing-source", usage={"input_tokens": 12, "output_tokens": 8})
        blank_source = task("blank-source", usage={"source": "  ", "input_tokens": 4, "output_tokens": 2})
        report = summarize({"active_tasks": [missing_source], "completed_tasks": [blank_source]})
        self.assertEqual(report["usage"]["covered_tasks"], 0)
        self.assertIsNone(report["usage"]["total_tokens"])
        self.assertFalse(report["tasks"][0]["usage_observed"])
        self.assertFalse(report["tasks"][1]["usage_observed"])

    def test_groups_first_check_rates_by_check_kind(self):
        lean_task = task("lean-pass", first=True)
        lean_task["delivery_metrics"]["check_kind"] = "lean"
        tooling_task = task("tooling-fail", first=False)
        tooling_task["delivery_metrics"]["check_kind"] = "static"
        report = summarize({"active_tasks": [lean_task], "completed_tasks": [tooling_task]})
        self.assertEqual(report["by_check_kind"]["lean"]["first_check"], {"successful": 1, "known": 1})
        self.assertEqual(report["by_check_kind"]["static"]["first_check"], {"successful": 0, "known": 1})

    def test_malformed_check_kind_and_large_integer_do_not_crash_reporting(self):
        malformed = task("unknown-kind", usage={
            "source": "runtime receipt", "input_tokens": 10 ** 1000, "output_tokens": 0,
        })
        malformed["delivery_metrics"]["check_kind"] = []
        report = summarize({"active_tasks": [malformed], "completed_tasks": []})
        self.assertEqual(set(report["by_check_kind"]), {"unknown"})
        self.assertEqual(report["usage"]["covered_tasks"], 1)
        self.assertIn(str(10 ** 1000), format_human(report))

    def test_json_cli_uses_optional_root_without_writing_state(self):
        state = {"active_tasks": [], "completed_tasks": [task("zero-usage", usage={
            "source": "runtime receipt", "input_tokens": 0, "output_tokens": 0,
        })]}
        with tempfile.TemporaryDirectory() as tempdir:
            root = Path(tempdir)
            path = root / "research/workflow-state.json"
            path.parent.mkdir(parents=True)
            path.write_text(json.dumps(state), encoding="utf-8")
            before = path.read_bytes()
            result = subprocess.run(
                ["python3", str(ROOT / "scripts/report_delegation.py"), "--root", str(root), "--json"],
                check=False, capture_output=True, text=True,
            )
            self.assertEqual(result.returncode, 0, result.stderr)
            self.assertEqual(json.loads(result.stdout)["usage"]["total_tokens"], 0.0)
            self.assertEqual(path.read_bytes(), before)


if __name__ == "__main__":
    unittest.main()
