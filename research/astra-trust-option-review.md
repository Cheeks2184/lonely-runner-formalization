# Independent review of the synchronous-elaboration trust exception

Final disposition: accepted for frozen scanner `bc46f490` and tests `301e557c`.
The last section records final hashes and replay evidence; earlier sections
preserve the two corrected review findings.

Reviewer: in-session Astra, requested extra-high reasoning, 2026-09-05.
Checkpoint: `8a3a407f729163316a11ffbb863ca9dddf249d36`. This is a narrow review
of the trust scanner and its regression tests, independent of their author.
Only this review file is reviewer-owned; no scripts, tests, Lean source,
workflow state, Git state, or caches were edited.

## Initial frozen candidate: changes required

Initial scanner SHA-256:
`f0b65b5becd7b5f3bd344963ce8596c2cef4b1a64bc701e10d4a60748d836241`.
Initial tests SHA-256:
`8cd7f67d81796c3630f1f89a9b9528db7b065e0583fd923c10e74de7267b01dc`.

The entire scanner and diff were inspected. The only scanner change was the
negative-lookahead exemption for `Elab.async false`; the allowed axiom set,
source paths, required reports, and report validation were unchanged.

The scheduling exception itself is sound, but the first candidate loses a
source-policy rejection for valid same-line scoped commands:

```lean
set_option Elab.async false in axiom forged : False
```

The old regex rejects this source through its blanket false-option ban. The
new regex accepts it because `axiom` is no longer at the beginning of a line.
Pinned Lean accepts the declaration with exit status zero. The same issue
affects a scoped `opaque` declaration and an inline theorem using `sorry`.
This does not bypass Lean's kernel: an axiom is explicitly being introduced,
and transitive axiom reporting rejects audited proofs that depend on it.
It does, however, remove the scanner's rejection of these previously rejected
sources. Acceptance was held and the issue reported for a narrow fix.

Exact independent reproducer, writing no Lean file:

```sh
python3 - <<'PY'
import re, subprocess
from scripts.audit_lean_trust import FORBIDDEN_SOURCE
old = re.compile(r'^\s*(?:sorry|admit|axiom|opaque|unsafe|extern|partial_fixpoint)\b|\bimplemented_by\b|\bnative_decide\b|\bset_option\s+\S+\s+false\b', re.MULTILINE)
for source in (
    'set_option Elab.async false in axiom forged : False\n',
    'set_option Elab.async false in theorem forged : False := by sorry\n',
    'set_option Elab.async false in opaque hidden : True := True.intro\n',
):
    print(repr(source), bool(old.search(source)), bool(FORBIDDEN_SOURCE.search(source)))
    run = subprocess.run([
        '/home/joshua/.elan/toolchains/leanprover--lean4---v4.32.1/bin/lean', '--stdin'
    ], input=source, text=True, stdout=subprocess.PIPE,
       stderr=subprocess.STDOUT, timeout=30)
    print(run.returncode, run.stdout.strip())
PY
```

Initial outputs were `True False` for all three regex comparisons; all three
Lean commands exited zero. Only the theorem using `sorry` emitted a warning.

## Pinned Lean semantics

The installed `leanprover/lean4:v4.32.1` sources were read directly:

| Source, relative to the toolchain's `src/lean/` | SHA-256 |
| --- | --- |
| `Lean/CoreM.lean` | `0e94919972c60e8f2bdc73ecc9845a745c9a3373fce4069b9e27ae52560c0a7a` |
| `Lean/Elab/MutualDef.lean` | `8ece8e532e13d63e37f3ebebdd1e067d9c7071759eda866c735db0a90546c0de` |
| `Lean/Elab/Tactic/Decide.lean` | `4cbd21f448eb8afbd81daee71bed7ce3f272af0fe916621b1e56b506c29a5c7b` |
| `Lean/AddDecl.lean` | `db9e450202be18ec6870d28c2cc2e7aeda5bfc22a0eb1747e2fcca06f548b905` |

`CoreM.lean:35` registers the Boolean scheduling option. The command-line
driver normally overrides its default to true. `MutualDef.lean:1238` selects
`elabAsync` or `elabSync`; the synchronous branch calls `finishElab`.
More directly, `AddDecl.lean:167` dispatches the same `doAddAndCommit` either
as a task or synchronously. Its `doAdd` calls `addDeclAux` under the kernel
type-checking trace. Thus false changes scheduling, not whether the declaration
is checked. Error recovery can provisionally add an axiom, but rethrows the
error; it does not turn a failing compile into successful verification.

`Decide.lean:116` deliberately sets `Elab.async` to false around `mkAuxLemma`
in the `+kernel` branch. Plain `by decide` can reject False during elaborator
reduction before kernel submission, so that negative test alone is not direct
evidence of a kernel rejection. The independent `+kernel` pair below exercises
the explicit kernel path as well. Both paths reject False and accept True.

```sh
python3 - <<'PY'
import subprocess
lean = '/home/joshua/.elan/toolchains/leanprover--lean4---v4.32.1/bin/lean'
for prop in ('True', 'False'):
    source = f'set_option Elab.async false in\nexample : {prop} := by decide +kernel\n'
    run = subprocess.run([lean, '--stdin'], input=source, text=True,
        stdout=subprocess.PIPE, stderr=subprocess.STDOUT, timeout=30)
    print(prop, run.returncode, run.stdout.strip())
    if prop == 'True':
        assert run.returncode == 0, run.stdout
    else:
        assert run.returncode != 0, run.stdout
        assert 'Tactic `decide` proved that the proposition' in run.stdout
        assert 'False' in run.stdout and 'is false' in run.stdout
PY
```

Observed: True exited zero with no diagnostic; False exited one with
`Tactic `decide` proved that the proposition`, followed by `False` and
`is false`. Neither missing Lean nor an unrelated error satisfies this pair.

## Tests and portability

The initial frozen six-test module passed locally, including its positive
plain-decide proof before the negative proof and the specific rejection
diagnostic assertions. Forcing `find_lean` to return None ran all six tests
with exactly one skip; four regex checks and the missing-runtime helper check
still ran. Independent mocked checks also verified PATH preference, the Elan
path fallback, and absence of both paths.

```sh
python3 -m unittest tests/test_audit_lean_trust.py
python3 -c 'import unittest; import tests.test_audit_lean_trust as t; t.find_lean = lambda *args, **kwargs: None; result = unittest.TextTestRunner().run(unittest.defaultTestLoader.loadTestsFromModule(t)); raise SystemExit(not result.wasSuccessful())'
```

An independent finite filter domain comprised every combination of six
whitespace strings (`space`, two spaces, tab, LF, CRLF, NBSP) on either side
of each of these fifteen option names: `Elab.async`, `Elab.asyncx`,
`Elab.async.trace`, `elab.async`, `_root_.Elab.async`, `Elab_async`,
`ElabXasync`, `XElab.async`, `Elab.аsync` (Cyrillic a), `Elab.asynс`
(Cyrillic c), `Elab.async₀`, `Elab.async'`, `Elab.«async»`, `Elab.async`
followed by U+200B, and `Elab.asynċ`. The source template was
`set_option{left}{name}{right}false in\nexample : True := by decide\n`.
All 540 cases matched the expected filter result: only the exact option name
was accepted. This was a regex boundary test; it does not assert that every
whitespace variant is valid Lean syntax.

`.github/workflows/ci.yml` has separate Lean and certificate jobs. The latter
installs Python/native certificate dependencies but does not install Lean.
Optional runtime testing is therefore appropriate there; the Lean job still
runs the real source/axiom audit. The lookup helper detects a binary path;
the mandatory positive subprocess verifies that it is usable. A present but
broken launcher does not produce a false-positive negative-proof result.
The forced missing-runtime test verifies control flow, not an actual GitHub
runner image. CI remains an orchestrator verification step.

## Disposition for the initial frozen candidate

**Changes required:** preserve source-policy rejection for forbidden constructs
after the allowed option, including valid same-line scoped commands. The
initial frozen scanner is not accepted. A correction needs replacement frozen
hashes and independent replay of the reported regressions, existing static
guards, Lean-present/absent paths, and the positive/negative kernel pair.

Also include the two-line source
`set_option Elab.async false in\ntheorem forged : False := by sorry` in those
controls. Restricting the option itself to its own line would not by itself
address that payload. This review does not demand a complete Lean parser or
assert that the inherited scanner was complete; it identifies concrete valid
sources that the proposed exception changes from rejected to accepted.

The option's scheduling semantics are independently accepted. The initial
frozen tests pass, but their later-forbidden cases miss these layouts. No
project source was altered to perform the checks. All reviewer commands
completed. The full build and transitive theorem axiom audit remain separate
required evidence; root reported 369 accepted reports, which this reviewer
did not rerun during this narrow review.

## Comment-aware candidate: additional correction required

The completed implementation observed at scanner SHA-256
`06621111ed8d8f2115f809f4c685692d4dbc3e8f6837b24712adca5164688e2f`
and test SHA-256
`e90487ef59e33a7cdb239788b8f7dcbcab0ff491f7827680caf111ef6fa81c4e`
addresses the original scoped-command issue by masking comments and checking
forbidden words at every remaining position. However, the comment masker
has a valid-source interpolation boundary counterexample:

```lean
def x := s!"{"/-"}"
axiom forged : False
def y := "-/"
-- "
```

Pinned Lean accepts this source with exit status zero. The candidate's
`find_forbidden_source` returns None. It mistakes a quote inside an
interpolated expression for the end of the outer string, interprets the
following literal `/-` as a comment, and masks the axiom. The quote in the
real final line comment balances the masker's mistaken string state. The
shorter example without that final comment fails closed, which is why the
full control matters. No synchronous option is needed for this new issue.

The same candidate also rejects the ordinary valid source
`def x'' : Nat := 0\nexample : Nat := x''\n` as an unterminated lexical
structure: a preceding apostrophe is not included in its identifier test.
That is a false positive, separate from the interpolation false negative.

Exact supplementary command:

```sh
python3 - <<'PY'
import subprocess
from scripts.audit_lean_trust import find_forbidden_source, strip_lean_comments
for source in (
    'def x := s!"{"/-"}"\naxiom forged : False\ndef y := "-/"\n-- "\n',
    "def x'' : Nat := 0\nexample : Nat := x''\n",
):
    print(repr(source), find_forbidden_source(source), repr(strip_lean_comments(source)))
    run = subprocess.run([
        '/home/joshua/.elan/toolchains/leanprover--lean4---v4.32.1/bin/lean', '--stdin'
    ], input=source, text=True, stdout=subprocess.PIPE,
       stderr=subprocess.STDOUT, timeout=30)
    print(run.returncode, run.stdout.strip())
PY
```

Both issues were reported to the orchestrator before acceptance. A conservative
fail-closed treatment of ambiguous interpolation is acceptable; a complete
Lean interpolation parser is not required by this review. Final acceptance
still awaits a corrected candidate and independent replay.

## Accepted replacement

**Accepted for its stated role as a bounded supplemental source guard.**
This disposition supersedes the changes-required decisions for the two earlier
candidates above. The entire final scanner, its diff from the source checkpoint,
all ten tests, and the complete implementation note were independently read.
Frozen accepted hashes:

| Artifact | SHA-256 |
| --- | --- |
| `scripts/audit_lean_trust.py` | `bc46f490dded05f768d58766df4c0b0ac9d3af7670760dee6ed8d87a5b078cad` |
| `tests/test_audit_lean_trust.py` | `301e557c7f705e6e402ef8b6247a78da8b1992e50ec5d492f7785a8b248fd93d` |
| `research/astra-trust-option-fix.md` | `674677a963ce350234457929e56183d343b17b3728e8ed4f5d72eb4e30a84cba` |

The global forbidden-token search catches the reported scoped payloads.
Comment masking handles line and nested block comments; retained literal and
quoted-name content prevents those regions from silently exempting keywords.
Ordinary quoted text containing an unescaped opening brace now fails closed
before an interpolation expression can desynchronize comment recognition.
That deliberately rejects some harmless literal strings as well as interpolation.
Identifier-continuation handling now includes repeated primes, underscores,
and Unicode letters/marks, fixing the reported legal-name failure.

No axiom allowlist, source path, theorem-report requirement, or nonzero-exit
check was relaxed. The scanner remains a supplemental lexical screen; no
complete or extensible Lean parser guarantee is claimed. It is intentionally
conservative for literal keywords, ambiguous braces, and unsupported/malformed
lexical forms. These limits do not relax the independent full build and
transitive axiom audit requirements.

The final ten tests passed with Lean available. The forced-no-runtime replay
ran ten tests with exactly one skip, retaining all nine non-runtime checks.
The independent program below also passed:

- 540 exact/neighbor/Unicode option and whitespace combinations.
- 33 unscoped, same-line scoped, and next-line scoped forbidden payloads.
- The complete valid interpolation bypass, plus conservative brace controls.
- 16 valid literal/name programs checked by pinned Lean, with all 32 appended
  forbidden payloads detected.
- Nested-comment position preservation, six unterminated forms, and
  conservative literal-keyword rejection.
- Three Lean lookup branches and the exact True/False `decide +kernel` pair.
- All 112 current project Lean source files passed the final helper.

Three ordinary application attempts using `bar"hello"`, `hr"hello"`,
and `foo.bar"hello"` all fail parsing in pinned Lean with an unexpected-token
error. They do not establish a valid-source raw/ordinary-string masking
counterexample. This bounded check does not claim to parse custom syntax
extensions.

Reproduce the exact final program without restoring dependencies or writing
a Lean source file:

```sh
PYTHONDONTWRITEBYTECODE=1 python3 - <<'PY'
import pathlib, re
review = pathlib.Path('research/astra-trust-option-review.md').read_text()
program = re.search(r'<!-- final-replay -->\n```python\n(.*?)\n```', review, re.S).group(1)
exec(compile(program, '<trust-review>', 'exec'))
PY
```

<!-- final-replay -->
```python
import itertools, pathlib, subprocess
from unittest.mock import patch
from scripts.audit_lean_trust import find_forbidden_source, source_has_forbidden_constructs, strip_lean_comments
from tests.test_audit_lean_trust import find_lean
lean = '/home/joshua/.elan/toolchains/leanprover--lean4---v4.32.1/bin/lean'
def check_lean(source):
    return subprocess.run([lean, '--stdin'], input=source, text=True,
        stdout=subprocess.PIPE, stderr=subprocess.STDOUT, timeout=30)
spaces = (' ', '  ', '\t', '\n', '\r\n', '\u00a0')
names = ('Elab.async', 'Elab.asyncx', 'Elab.async.trace', 'elab.async', '_root_.Elab.async',
    'Elab_async', 'ElabXasync', 'XElab.async', 'Elab.аsync', 'Elab.asynс',
    'Elab.async₀', "Elab.async'", 'Elab.«async»', 'Elab.async\u200b', 'Elab.asynċ')
for name, left, right in itertools.product(names, spaces, spaces):
    source = f'set_option{left}{name}{right}false in\nexample : True := by decide\n'
    assert source_has_forbidden_constructs(source) == (name != 'Elab.async'), repr(source)
print('540 option spelling/whitespace cases passed.')
forbidden = ('sorry', 'admit', 'axiom forged : False', 'opaque hidden : True := True.intro',
    'unsafe def bad := 0', 'extern "bad" def bad : Nat', 'partial_fixpoint bad : Nat := bad',
    'def bad : Nat := by implemented_by exact 0', 'example : True := by native_decide',
    'theorem forged : False := by sorry', 'set_option pp.universes false in\nexample : True := by decide')
for prefix, payload in itertools.product(('', 'set_option Elab.async false in ', 'set_option Elab.async false in\n'), forbidden):
    assert source_has_forbidden_constructs(prefix + payload), repr(prefix + payload)
print('33 unscoped/same-line/next-line forbidden payload cases passed.')
interpolation = 'def x := s!"{"/-"}"\naxiom forged : False\ndef y := "-/"\n-- "\n'
assert source_has_forbidden_constructs(interpolation)
run = check_lean(interpolation)
assert run.returncode == 0, run.stdout
for prefix in ('s!', 'm!', 'dbg_trace '):
    assert source_has_forbidden_constructs(prefix + '"{"/-"}"\naxiom forged : False\ndef y := "-/"\n-- "\n')
assert source_has_forbidden_constructs('def plain := "literal { brace"\n')
print('Recorded valid interpolation bypass is rejected; conservative brace cases passed.')
benign = ['def value := "-- /- quoted -/"\n',
    r'def value := "escaped \" /- -- -/"' + '\n',
    'def «/- quoted --» := 0\n']
for char in ("'-'", "'/'", r"'\''", r"'\x2d'", r"'\u002d'"):
    benign.append(f'def value : Char := {char}\n')
for name in ("x'", "x''", "x_'", "α''"):
    benign.append(f'def {name} : Nat := 0\nexample : Nat := {name}\n')
for size in range(4):
    hashes = '#' * size
    body = '/- -- -/' if size == 0 else '/- "' + '#' * (size - 1) + ' -- -/'
    benign.append(f'def value := r{hashes}"{body}"{hashes}\n')
for source in benign:
    assert not source_has_forbidden_constructs(source), repr(source)
    run = check_lean(source)
    assert run.returncode == 0, (source, run.stdout)
    assert source_has_forbidden_constructs(source + 'axiom forged : False\n'), repr(source)
    assert source_has_forbidden_constructs(source + 'set_option pp.universes false\n'), repr(source)
print(f'{len(benign)} legal literal/name programs passed Lean; all 32 appended forbidden payloads were detected.')
comments = '/- axiom /- sorry -/ opaque -/\n-- native_decide\nexample : True := by decide\n'
assert not source_has_forbidden_constructs(comments)
masked = strip_lean_comments(comments)
assert masked is not None and len(masked) == len(comments)
assert [i for i,c in enumerate(masked) if c == '\n'] == [i for i,c in enumerate(comments) if c == '\n']
for source in ('/-', '"open', 'r##"open', "'x", '«open', '/- outer /- inner -/'):
    assert source_has_forbidden_constructs(source)
assert source_has_forbidden_constructs('def value := "axiom"\n')
print('Comment-position preservation, six unterminated forms, and conservative literal-word check passed.')
for name in ('bar', 'hr', 'foo.bar'):
    source = f'def {name} (s : String) := s\ndef value := {name}"hello"\n'
    run = check_lean(source)
    assert run.returncode != 0 and 'unexpected token' in run.stdout, (source, run.stdout)
print('Three identifier-ending-r/ordinary-string adjacency controls are invalid pinned Lean syntax.')
with patch.object(pathlib.Path, 'is_file', return_value=True) as exists:
    assert find_lean(lambda _: '/mock/path/lean', pathlib.Path('/mock/elan/lean')) == '/mock/path/lean'
    exists.assert_not_called()
with patch.object(pathlib.Path, 'is_file', return_value=True):
    assert find_lean(lambda _: None, pathlib.Path('/mock/elan/lean')) == '/mock/elan/lean'
with patch.object(pathlib.Path, 'is_file', return_value=False):
    assert find_lean(lambda _: None, pathlib.Path('/mock/elan/lean')) is None
for prop in ('True', 'False'):
    run = check_lean(f'set_option Elab.async false in\nexample : {prop} := by decide +kernel\n')
    if prop == 'True':
        assert run.returncode == 0, run.stdout
    else:
        diagnostic = 'Tactic ' + chr(96) + 'decide' + chr(96) + ' proved that the proposition'
        assert run.returncode != 0 and diagnostic in run.stdout
        assert 'False' in run.stdout and 'is false' in run.stdout
    print('kernel pair', prop, 'exit', run.returncode, run.stdout.strip())
files = [pathlib.Path('LonelyRunner.lean'), *sorted(pathlib.Path('LonelyRunner').rglob('*.lean'))]
assert all(not source_has_forbidden_constructs(path.read_text()) for path in files)
print(f'Three runtime lookup branches passed; all {len(files)} current project Lean sources pass the supplemental guard.')
```

The final replay exited zero. Its explicit kernel results were True exit zero
without diagnostics and False exit one with the exact false-proposition
`decide` diagnostic recorded above. Workflow structural validation also passed.
The orchestrator separately reported the full 3615-job build and 369-report
trust audit before coordinated cache cleanup; this reviewer did not restore
or rebuild dependencies afterward. All final review commands completed, the
accepted hashes remained unchanged, and only this review file was edited.
