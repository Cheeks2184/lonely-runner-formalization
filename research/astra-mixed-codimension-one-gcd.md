# Mixed supply from a codimension-one common divisor

Author `/root/mixed_equivalence_freeze`, requested Astra/xhigh, 2026-09-05.
Source checkpoint `7e1b4073cfd0095a3e514df975313562feb82688`.
Routing is the requested assignment, not an independent runtime attestation.
Only this manuscript is owned. Project configuration, workflow, policy and
active state were read; `python3 -B scripts/validate_workflow.py` passed.
The unrestricted kernel-checked LRC goal remains active and unresolved.

**Disposition: the proposed conditional deduction is correct. Its method is
already present in the formal divisor-grid lemmas and the accepted
endpoint-label audit. The all-deletions mixed-failure filter is useful scope
bookkeeping, not new ordinary coverage or a new research route.** The
published divisor-insertion conclusion does not itself expose the stronger
bound. No Lean change is proposed without a concrete downstream caller.

## Exact conditional statement and proof

Write `||x||` for distance to the nearest integer, and put `alpha=1/(N-1)`.
Let `N>=5` and let `W` contain `N-1` distinct positive integer speeds, with
`gcd(W)=1`. Let `H=max(W)` and assume the repository's exact
`LowerCountPositiveIntegerHypothesis N`. If some deletion `I=W\{h}` has
`g=gcd(I)>1`, then there is a positive real `T` such that

```text
||w*T|| >= alpha for every w in W.                         (A)
```

In particular `T` is a fastest-mixed witness: every original norm is at
least `1/N`, and `||H*T||>=1/(N-1)` at that same time.

Indeed, `I` has `N-2` distinct positive entries. The lower-count hypothesis,
with `d=N-2`, supplies a real `T0` with all its norms at least `alpha`.
It does not promise positive time, and no such promise is used. Any divisor
of both `g` and `h` divides every member of `W`, so `gcd(g,h)=1`.
For integers `j`, the times `T0+j/g` preserve every phase in `I` modulo one.
The outside phase runs through the translated grid

```text
h*T0 + j*h/g mod 1,   j=0,...,g-1.
```

Coprimality makes this exactly a translate of the uniform `g`-point grid.
Some point is within `1/(2g)` of the half-integer class, giving outside norm
at least `(g-1)/(2g)`. For `g>=2` and `N>=5`,

```text
(g-1)/(2g) >= 1/4 >= 1/(N-1) = alpha.
```

All bounds hold at one shifted time `S`. Replace it by
`T=S+1-floor(S)`, which lies in `[1,2)`. This integer time shift preserves
every integer-speed norm, proving (A). The outside speed need not be largest:
the proof raises every coordinate to `alpha`, so the location of `H` is
irrelevant. Sorting is unnecessary apart from identifying the maximum.

The lower-count premise can be replaced by the single assumption that `I`
has an `alpha` witness. Mere ordinary goodness of all of `W` gives only
`1/N` on `I`; it does not supply this stronger seed when `H` lies in `I`.

## Closed endpoints, small counts, and scaling

The exact sufficient mesh condition for (A) is
`2g <= (N-1)(g-1)`. It holds for every `g>=2` at `N>=5`, with equality at
`N=5,g=2`. A translated two-point grid `{1/4,3/4}` has maximal norm exactly
`1/4`; a strict improvement cannot be inferred.

For `N=4`, the same argument works for `g>=3`, including equality at `g=3`.
At `g=2`, it guarantees only `1/4`, below `alpha=1/3`. The universal (A)
conclusion is actually false there: take `W=(1,2,6)` and `I=(2,6)`.
If both `||T||` and `||2T||` are at least `1/3`, the fractional part of `T`
must be `1/3` or `2/3`; then `||6T||=0`. Hence no all-third time exists.
Nevertheless `T=5/18` is fastest-mixed, with norms `(5/18,4/9,1/3)`.
This obstruction concerns (A), not mixed supply, strict-to-mixed, or LRC.
At the seed `T0=1/4`, both members of `I` have norm `1/2`, while both
outside phases in the two-point orbit have norm exactly `1/4`.

The scale-invariant generalization removes the primitive assumption. Set
`D=gcd(I)`, `G=gcd(W)=gcd(D,h)`, and `m=D/G`. Shifts by `j/D` preserve `I`,
while the outside grid has exactly `m` points because
`gcd(h/G,D/G)=1`. Thus the sufficient condition is
`2m <= (N-1)(m-1)`. For `N>=5`, `D>G` suffices. Raw `D>1` does not suffice
without normalization: if `D=G`, the orbit has one point and no outside
improvement is guaranteed. Common positive scaling preserves the property,
with witness time divided by the scale, and preserves the ratio `D/G`.
For an explicit all-coordinate obstruction with a valid seed despite raw
`D>1`, use `N=5`,
`W=(2,4,6,8)`, `I=(2,4,6)`, and the quarter-margin seed `T0=1/8`.
Here `D=G=2`. An all-quarter time would make the five circle points
`0,2T,4T,6T,8T` pairwise separated by at least `1/4`, because each pair
difference is one of the original speeds times `T`, up to sign. Their five
cyclic gaps would sum to at least `5/4>1`, a contradiction. This refutes
only the stronger seed-based all-coordinate claim without primitivity, not M.

Consequently, under the stated lower-count hypothesis, every primitive
no-mixed tuple at `N>=5` has gcd one after **every** single-speed deletion.
Equivalently, an unnormalized no-mixed tuple must have deletion gcd equal
to its full gcd for every deletion. These are necessary conditions only;
they assert no sufficiency for mixed failure or ordinary witness existence.

## Existing coverage and actual formal interface

`LonelyRunner.exists_int_coprime_grid_circleNorm_ge` already proves the
closed mesh bound for every real starting phase. Its companion
`exists_int_grid_circleNorm_ge` proves the underlying rounded-grid estimate.
`codimensionOneDivisorInsertion` uses exactly the phase-preserving time
construction above, but states an ordinary `1/(n+2)` conclusion after
weakening the old `1/(n+1)` seed margin. In the primitive setting instantiate
its parameters by `n=N-2`, `dividedSpeeds` enumerating `w/g` for `w in I`,
`D=m=g`, its factor parameter `g=1`, `c=h`, and `s=g*T0`.
Its ordinary closure condition is `2g<=N(g-1)`; the stronger
condition here is `2g<=(N-1)(g-1)`. The stronger conclusion is present in
the proof's intermediate estimates, not in that public theorem's type.

The accepted endpoint-label audit and review already derive the general
effective orbit `D/gcd(D,h)`, preserve every old norm, and apply any threshold
allowed by that mesh. Their additional same-row statement is irrelevant
here. The accepted strict-to-mixed audit states the mixed consequence for
deletion of the actual maximum; its separate N=4 arguments also cover the
gcd-two lower-core case and shared gcd with the maximum. This manuscript
records the arbitrary-deletion filter at `N>=5` with the stronger seed
premise retained; it adds no new grid argument or ordinary coverage.

If a formal caller needs (A), apply the existing coprime grid helper directly.
An optional shared extraction could return the old seed margin unchanged
and the outside mesh bound simultaneously, with no closure condition, then
recover the old ordinary theorem by weakening. That is a small interface
refactor, not a reason to reopen this research branch. Close the branch once
this scope statement is reviewed; the gcd-one remainder remains unresolved.

## Verification status and provenance

Symbolic proof and interface comparison are complete. The sole program below
checks exactly four named fixtures (eight orbit points altogether), including
negative representatives followed by positive integer-period normalization.
The global negative claims above are analytic proofs; finite orbit checks are
not being substituted for them. No discovery search, Lean elaboration, cache
operation, or background command was run.

Read and compared: `LonelyRunner/DivisorInsertion.lean`,
`LonelyRunner/LowerCountSupply.lean`, the strict-to-mixed audit and review,
and the mathematical common-divisor sections of the endpoint-label audit
and review. Targeted searches in the nearby primitive-endpoint-exchange,
direct-mixed, and two-hole manuscripts revealed no separate required route.

The six source hashes in the program are the raw reviewed file hashes.
Run from the repository root with standard `python3 -B`, extracting this sole
Python block in memory; it writes no files and launches no child processes.

```python
from fractions import Fraction as Q
from hashlib import sha256
from math import floor, gcd
from pathlib import Path
guards = {
    'LonelyRunner/DivisorInsertion.lean': '212fa6d879bab6d70f09a4a43b2027b96724b5e5ac4a22cdf4b368509973166f',
    'LonelyRunner/LowerCountSupply.lean': '0705291adc53011fb72fc718a7260876512b092741442d6a6cceb4b76eb5ccf4',
    'research/astra-strict-to-mixed-audit.md': 'c7559719cc61d715a47958ab8d1a844faf021c53e08ee3e87c1d0d54e0fb5f2f',
    'research/astra-strict-to-mixed-review.md': '6f0ba11b6640b662eb72a86326a1b7d429444e61a1a78b60a8d1b8b8e06a466d',
    'research/astra-endpoint-label-audit.md': '667b9bcdebf30333c551badf6e9ef6c861e5e1ca1095808ece5354733745e44d',
    'research/astra-endpoint-label-review.md': '865f434052997ff1cd0b9d6fdd5c4a23c792feb409c9e3b492ccb009076e01e7',
}
for path, expected in guards.items():
    assert sha256(Path(path).read_bytes()).hexdigest() == expected
def norm(x):
    return min(x % 1, (-x) % 1)
fixtures = (
    ('N5_g2_closed', 5, (2, 6, 10), 1, Q(1, 4), 2, Q(1, 4), True),
    ('N4_g3_closed', 4, (3, 9), 2, Q(1, 6), 3, Q(1, 3), True),
    ('N4_g2_insufficient', 4, (2, 6), 1, Q(1, 4), 2, Q(1, 4), False),
    ('N5_nonprimitive', 5, (2, 4, 6), 8, Q(1, 8), 1, Q(0), False),
)
orbit_points = 0
for name, N, I, h, seed, expected_m, expected_max, all_alpha in fixtures:
    W = tuple(sorted(I + (h,)))
    assert len(W) == len(set(W)) == N - 1 and min(W) > 0
    alpha, D, G = Q(1, N - 1), gcd(*I), gcd(*W)
    m = D // G
    assert m == expected_m and gcd(h // G, m) == 1
    assert all(norm(w * seed) >= alpha for w in I)
    orbit = [seed + Q(j, D) for j in range(m)]
    assert len({(h * t) % 1 for t in orbit}) == m
    for t in orbit:
        assert all((w * (t - seed)).denominator == 1 for w in I)
        assert all(norm(w * t) == norm(w * seed) for w in I)
    S = max(orbit, key=lambda t: norm(h * t)) - 2
    T = S + 1 - floor(S)
    assert S < 0 and 1 <= T < 2
    assert all(norm(w * T) == norm(w * S) for w in W)
    assert norm(h * T) == expected_max >= Q(m - 1, 2 * m)
    assert (all(norm(w * T) >= alpha for w in W)) == all_alpha
    if all_alpha:
        assert all(norm(w * T) >= Q(1, N) for w in W)
        assert norm(max(W) * T) >= alpha and max(W) in I
    orbit_points += m
    print(name + ': orbit=' + str(m) + ', outside_max=' + str(expected_max))
assert [norm(w * Q(5, 18)) for w in (1, 2, 6)] == [Q(5, 18), Q(4, 9), Q(1, 3)]
assert all(norm(6 * t) == 0 for t in (Q(1, 3), Q(2, 3)))
assert orbit_points == 8
print('PASS: 6 source guards; 4 fixed fixtures; 8 orbit points; no tuple search')
```

Executed extraction command (completed, exit 0):

```bash
python3 -B - <<'PY'
from pathlib import Path
from hashlib import sha256
from contextlib import redirect_stdout
import io, re
raw = Path('research/astra-mixed-codimension-one-gcd.md').read_text()
blocks = re.findall(r'^```python\n(.*?)^```[ \t]*$', raw, re.M | re.S)
assert len(blocks) == 1
out = io.StringIO()
with redirect_stdout(out):
    exec(compile(blocks[0], 'codimension-one-gcd-controls', 'exec'), {})
print(out.getvalue(), end='')
print('program_sha256=' + sha256(blocks[0].encode()).hexdigest())
print('output_sha256=' + sha256(out.getvalue().encode()).hexdigest())
PY
```

Exact program stdout, including its final newline:

```text
N5_g2_closed: orbit=2, outside_max=1/4
N4_g3_closed: orbit=3, outside_max=1/3
N4_g2_insufficient: orbit=2, outside_max=1/4
N5_nonprimitive: orbit=1, outside_max=0
PASS: 6 source guards; 4 fixed fixtures; 8 orbit points; no tuple search
```

Raw extracted program SHA-256:
`089485ecefa835cc260c52d96361e36a8f1fed21c7cee05a589e05523a47bcb1`.
Raw stdout SHA-256:
`361ecfdaeec0fdcb4e505b851eb4557f69e06bb714b23fd7d6357fe93fcff8a8`.
The first control run caught a draft range assertion: `S+1-floor(S)` is in
`[1,2)`, not `(0,1]`. The proof and control were corrected; positivity and
integer-period preservation were never affected. The final run above passed.
All commands have stopped. No tuple enumeration or external retrieval was
performed, and only this owned manuscript was written. Final raw manuscript
hash is reported at handoff, avoiding a self-referential embedded digest.
