# Narrow Elab.async trust-filter exception

Source checkpoint: `8a3a407f729163316a11ffbb863ca9dddf249d36`.

The trust-source filter now accepts only the exact source option
`set_option Elab.async false`.  It continues to reject every other
false-valued option and all existing forbidden source constructs.  The
exception has no theorem, module, path, or axiom-report exemption.

The filter now first masks line and nested block comments, preserving line
breaks and other source positions, before searching forbidden tokens at every
code position.  The small lexical guard recognizes normal escaped strings,
raw strings, character literals, and quoted identifiers so comment markers in
those forms cannot hide later code.  It fails closed on an unterminated
comment or lexical form.  This supplements the source policy; it is not a
complete Lean parser.  Literal text remains visible to the token policy, so a
forbidden keyword inside a literal may conservatively be rejected.

Lean string interpolation can contain arbitrary Lean syntax between an
unescaped `{` and its matching `}`.  Rather than reproduce that parser, the
guard now fails closed on an unescaped `{` in an ordinary string.  This closes
the reviewed interpolation/comment-state bypass.  Apostrophes following
identifier continuations, including repeated primes, underscores, and Unicode
letter/mark continuations, remain identifier text instead of being mistaken
for unterminated character literals.

Pinned Lean `v4.32.1` evidence:

* `Lean/CoreM.lean`, lines 35-45, registers `Elab.async` as a Boolean with
  default `false` and describes it as multi-thread elaboration scheduling.
  SHA-256: `0e94919972c60e8f2bdc73ecc9845a745c9a3373fce4069b9e27ae52560c0a7a`.
* `Lean/Elab/MutualDef.lean`, lines 1238 onward, calls `elabAsync` only when
  `Elab.async` is true and otherwise calls `elabSync`; `elabSync` calls
  `finishElab`.  SHA-256:
  `8ece8e532e13d63e37f3ebebdd1e067d9c7071759eda866c735db0a90546c0de`.
* `Lean/Elab/Tactic/Decide.lean`, lines 116 onward, locally sets
  `Elab.async` to false before making its auxiliary kernel-checked lemma.
  SHA-256: `4cbd21f448eb8afbd81daee71bed7ce3f272af0fe916621b1e56b506c29a5c7b`.
* `Lean/Parser/Basic.lean`, lines 543-560 and 719-780, defines nested block
  comments and the normal/raw string forms used by the supplemental lexical
  guard.  SHA-256:
  `52bc0d189a600e760fde91f55e1429d9a612b1a63452da063ee74de9ed3f3d8e`.

The test module checks the exact spelling, rejects neighboring and unknown
options, confirms that later forbidden constructs remain visible, and runs an
in-memory `example : False := by decide` control under the accepted option.
It uses `lean --stdin`, so it requires neither Lake nor project dependencies.
The control first requires an accepted `True` proof and then requires the
specific `decide` rejection diagnostic for `False`; if no Lean executable is
available, only this runtime-control test is skipped.  No false probe is
written into the project.

Focused verification at this checkpoint:

```text
python3 -m unittest tests/test_audit_lean_trust.py
# available Lean runtime: exit 0, 10 tests passed: static source-filter and direct
# `lean --stdin` positive and negative decide controls.

python3 -c 'import unittest; import tests.test_audit_lean_trust as t; t.find_lean = lambda *args, **kwargs: None; result = unittest.TextTestRunner().run(unittest.defaultTestLoader.loadTestsFromModule(t)); raise SystemExit(not result.wasSuccessful())'
# forced unavailable-runtime path: exit 0, 10 tests run, 1 skipped; the nine
# static checks pass and only the runtime control is skipped.

/home/joshua/.elan/bin/lake env lean LonelyRunner/FourLowerOwnerNine.lean
# exit 0.

python3 scripts/audit_lean_trust.py
# exit 0: Trust audit accepted 369 theorem reports.
```

Implementation hashes after this fix:

* `scripts/audit_lean_trust.py`:
  `bc46f490dded05f768d58766df4c0b0ac9d3af7670760dee6ed8d87a5b078cad`.
* `tests/test_audit_lean_trust.py`:
  `301e557c7f705e6e402ef8b6247a78da8b1992e50ec5d492f7785a8b248fd93d`.
