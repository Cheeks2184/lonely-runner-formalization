import ast
import unittest
from pathlib import Path

from scripts.replay_prompt66_certificates_069 import (
    BASE_CASES,
    EXPECTED_BUNDLE_BYTES,
    EXPECTED_BUNDLE_SHA256,
    EXPECTED_PROMPT_RAW_SHA256,
    EXPECTED_PROMPT_UI_SHA256,
    build_model,
    mutation_cases,
    verify_selection,
)


class Prompt66Replay069Tests(unittest.TestCase):
    def test_frozen_base_literals_are_authoritative(self):
        self.assertEqual(BASE_CASES[0], ("F", (8, 15, 35, 40, 48, 56, 75, 132, 147)))
        self.assertEqual(BASE_CASES[1], ("G", (15, 21, 40, 48, 56, 105, 126, 280, 1200)))
        self.assertEqual(len(BASE_CASES), 11)

    def test_mutation_order_and_counts(self):
        cases = mutation_cases()
        self.assertEqual(len(cases), 4149)
        self.assertEqual([case["case"] for case in cases[:9]], list(range(1, 10)))
        self.assertEqual(cases[0]["descriptor"], {"base": "F"})
        self.assertEqual(
            next(case for case in cases if case["name"] == "G" and case["tuple_kind"] == "base")["descriptor"],
            {"base": "G"},
        )
        mutation_descriptors = {
            (
                case["name"],
                case["descriptor"]["coordinate"],
                case["descriptor"]["delta"],
            )
            for case in cases
            if case["tuple_kind"] == "mutation"
        }
        # Descriptors are expanded into pivot rows; this counts each distinct
        # construction descriptor while preserving repeated sorted tuples.
        self.assertEqual(len(mutation_descriptors), 461)
        self.assertEqual(sum(1 for case in cases if case["tuple_kind"] == "base"), 92)
        self.assertEqual(
            sum(1 for case in cases if case["tuple_kind"] == "mutation"),
            4057,
        )

    def test_model_reconstructs_canonical_grid_and_tokens(self):
        model = build_model((1, 2, 3, 5), 3)
        self.assertEqual(model.N, 5)
        self.assertEqual(model.M, 15)
        self.assertEqual(len(model.residues), 12)
        self.assertEqual(model.residues, tuple(r for r in range(15) if r % 5))
        self.assertEqual(model.all_tokens[0][0], 1)
        self.assertEqual(model.all_tokens[0][1], 1)
        self.assertEqual(len(model.active_tokens), model.variables[-1][0] + 1)
        self.assertTrue(all(set(token.fiber) for token in model.active_tokens))

    def test_selection_checks_whole_block_and_capacity(self):
        model = build_model((1, 2, 3, 5), 3)
        token = model.active_tokens[0]
        selection = [
            {
                "owner": token.owner,
                "parent": token.parents[0],
                "residues": list(token.blocks[0]),
                "target": token.target,
                "token_index": token.index,
            }
        ]
        credit, selected, use = verify_selection(model, selection, "unit test")
        self.assertEqual(credit, len(token.blocks[0]))
        self.assertEqual(selected, {token.index: 0})
        self.assertEqual(sum(use.values()), credit)

    def test_provenance_constants_and_standard_library_imports(self):
        self.assertEqual(EXPECTED_BUNDLE_BYTES, 7235209)
        self.assertEqual(len(EXPECTED_BUNDLE_SHA256), 64)
        self.assertEqual(len(EXPECTED_PROMPT_RAW_SHA256), 64)
        self.assertEqual(len(EXPECTED_PROMPT_UI_SHA256), 64)
        source = Path("scripts/replay_prompt66_certificates_069.py").read_text(encoding="utf-8")
        tree = ast.parse(source)
        allowed = {
            "argparse",
            "collections",
            "dataclasses",
            "fractions",
            "hashlib",
            "json",
            "pathlib",
            "platform",
            "sys",
            "time",
            "typing",
            "zipfile",
            "__future__",
        }
        imported = set()
        for node in ast.walk(tree):
            if isinstance(node, ast.Import):
                imported.update(alias.name.split(".")[0] for alias in node.names)
            elif isinstance(node, ast.ImportFrom):
                imported.add((node.module or "").split(".")[0])
        self.assertTrue(imported <= allowed, imported - allowed)
        self.assertNotIn("random", imported)
        self.assertNotIn("scipy", source.lower())
        self.assertNotIn("numpy", source.lower())


if __name__ == "__main__":
    unittest.main()
