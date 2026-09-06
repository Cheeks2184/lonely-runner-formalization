# Thirty-eighth Astra checkpoint: five-adic proof components

This checkpoint formalizes finite coupled carries, a five-adic filtering
theorem for arbitrary finite label sets, and natural residue normalization.
These are components of the direct route toward the five-total-runner case.
The carry-to-speed adapter, valuation-pattern assembly, and canonical real
five-total theorem remain to be proved. Unrestricted LRC remains unresolved.

## Filtering contract

Write `R=5^m` and `P=5R`. The input is a finite family with exact
decompositions `d_i=5^ell_i*u_i`, positive speeds, units `5 ∤ u_i`, and
`ell_i≤m`. Every level strictly below `m` may contain at most two labels.
The theorem supplies `0<lambda<P`, `lambda%5=1`, a unit multiplier, and
closed cyclic distances at least `R` for all labels. It also supplies good
digits 1 through 3 below the top and preserves every original top residue.
There is no bound on the number of top labels, or requirement of distinct
speeds, an attained maximum, a nonempty family, ordering, or primitivity.

The seeded version starts from any positive unit `A` and cutoff `h≤m`.
It preserves the exact residues of labels at levels at least `h`, their
existing distance bounds, and `A%5`, while filling all lower levels.
Induction first constructs an unbounded multiplier and then reduces it
modulo `P`. This bound concerns the multiplier, not a velocity-height cutoff.

At level `j<m`, multiplication by `1+k*5^(m-j)` changes the selected digit
by `k*((A*u_i)%5)`. Higher residues remain fixed. A symbolic finite-union
argument shows that two nonzero affine rows forbid at most four of the five
choices of `k`. At the top, digit four is valid at residue `4R`, where the
closed distance is exactly `R`; the proof retains this boundary separately.

## Coupled carries and normalization

`fiveCarryTriple` has the unchanged universal contract over three arbitrary
`FiveCarryState` values. Each state contains a top digit, a residue decoded
as 1 or 2, and one tag selecting the coupled double/triple carries
`(0,0)`, `(0,1)`, `(1,1)`, or `(1,2)`. A common multiplier index in 1 through
3 and translation in 0 through 4 put all three resulting digits in 1 through
3. Repeated states are permitted and no realizability hypothesis is added.

The kernel proof uses normalized helpers with 1,600 and 80 inputs. Field
algebra handles the absolute top positions and common translation; an
eight-case residue partition joins the equal-residue and pair arguments.
The previous full-domain proof attempts exceeded the fixed memory cap and
were replaced. The final proof does not evaluate the 64,000-state target.

The natural normalization module proves that complementary residues have
equal cyclic distances after every natural multiplier, including zero and
nonunits. It maps any five-unit to a positive representative below `P` with
residue 1 or 2 modulo five, preserving the distance for every later
multiplier. This constructor includes `m=0`. It does not yet construct a
carry state from a speed or prove the hard valuation-pattern theorem.

## Verification

All three named modules and the full project build passed; the full build
contains 3,654 jobs including cached targets. The trust audit accepted 517
dependency lists and three axiom-free declarations. The only permitted
dependencies remain `propext`, `Classical.choice`, and `Quot.sound`.
The root import and explicit audit include all 21 new public theorems.

The complete carry source is 16,638 bytes. Root replay of its self-contained
resource command passed in 4.94 seconds with a GNU-time peak of 3,853,580 KiB.
The online monitor measured 3,853,936 KiB across sampled descendants. The
whole-source limits remain 60 seconds, 4 GiB, and 64 KiB of source. The
20-ms sampling can miss brief aggregate peaks; GNU time reports a separate
process-level measurement. Both recorded measurements passed.

The [independent final source review](../research/astra-five-adic-formal-review.md)
accepted all 21 new contracts without source corrections. Root replay passed
all 44 focused examples and 19 source guards, with the identical recorded
output hash. Exact inputs and outcomes are in
the [verification record](../research/astra-pass38-verification.json), the
[carry implementation report](../research/astra-five-adic-carry-implementation.md),
[filtering report](../research/astra-five-adic-filter-arithmetic-implementation.md),
and [normalization report](../research/astra-five-adic-hard-pattern-implementation.md).

## Historical evidence and next step

The [direct-proof screen](../research/astra-five-total-direct-proof-screen.md)
motivates this route. The separately checked
[ordinary-insertion plan](../research/astra-five-runner-ordinary-insertion-plan.md)
is retained as a deferred alternative, with no implementation in this pass.
The reviewed filtering, symbolic carry, and natural-adapter manuscripts retain
their original dated contracts and source hashes.

The symbolic carry plan and its review refer to a failed source and report
that predate the successful implementation. Their exact bytes were recovered
and verified against the previously recorded hashes, then saved in the
19,276-byte [historical evidence archive](../research/astra-five-adic-pre-symbolic-evidence.json).
Both small-helper reproducers were replayed in a temporary five-file snapshot
using those archived inputs; their original output hashes matched. No
historical Lean proof or full-state search was rerun. This archive is unique
reproducibility evidence, not a rebuildable dependency cache.

Replay those two historical small-helper programs from the repository root:

```python
from pathlib import Path
from hashlib import sha256
import json, re, subprocess, sys, tempfile

root = Path.cwd()
archive = root / 'research/astra-five-adic-pre-symbolic-evidence.json'
assert sha256(archive.read_bytes()).hexdigest() == '4ace825e19f3ecaf96f3f13afa4d4d2fce594aabfce42fbd2abd8ccd942add3a'
items = json.loads(archive.read_text())['files']
expected = {
    'astra-five-adic-carry-symbolic-plan.md': (
        'ffd0739e680cbc3c12e3ac0e35cb6b41e6f3b6c4a5a3db4500c76031de4aa6aa',
        '3e95ff25d9c4e17ecf30b7979b6d48ef1b6912fcfe2923bc6fbb4e9914e3553c'),
    'astra-five-adic-carry-symbolic-plan-review.md': (
        'cf2eeb638a05889118e1037ec4886c7e60fd13e09539020d93287beafe01e309',
        'cfe6f316074907d94ca56bbd91d781c34d80e3b70ee4c3917d9f5624942bb8ff'),
}
with tempfile.TemporaryDirectory(prefix='astra-carry-history-') as directory:
    base = Path(directory)
    for relative, item in items.items():
        assert sha256(item['content'].encode()).hexdigest() == item['sha256']
        target = base / relative
        target.parent.mkdir(parents=True, exist_ok=True)
        target.write_text(item['content'])
    for name in ['astra-five-adic-carry-plan.md', *expected]:
        (base / 'research' / name).write_bytes((root / 'research' / name).read_bytes())
    for name, (program_hash, output_hash) in expected.items():
        text = (base / 'research' / name).read_text()
        blocks = re.findall(r'^```python\n(.*?)^```\s*$', text, re.M | re.S)
        assert len(blocks) == 1
        assert sha256(blocks[0].encode()).hexdigest() == program_hash
        result = subprocess.run([sys.executable, '-B', '-'], input=blocks[0],
            cwd=base, text=True, capture_output=True, check=True)
        assert sha256(result.stdout.encode()).hexdigest() == output_hash
        print(name + ': historical guarded replay passed')
```

Next, construct the coupled carry tag and bounded state from normalized
natural speeds, prove the exact digit identity, and assemble the hard
three-unit/one-top pattern. The reviewed finite-label filtering theorem can
then be combined with valuation decomposition and the existing canonical
bridge. One shared dependency cache is retained for this immediately queued implementation.
