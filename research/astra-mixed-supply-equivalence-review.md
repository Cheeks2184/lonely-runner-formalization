# Independent review: stationary exact supply is mixed witness existence

2026-09-05; requested Astra/xhigh task `/root/mixed_equivalence_freeze`,
assigned checkpoint `5e7d690e6606ad096bf4a2319be0328f9c6d2e68`.
Configuration, workflow, policy, current state and validator were inspected;
`python3 -B scripts/validate_workflow.py` passed. Research is authorized and
canonical completion remains absent. Runtime model/effort were not independently
exposed. Only this owned review is written; no Lean, state, Git or cache changes.

**Accepted at independently reviewed manuscript scope:** for every `N>=3`
and sorted distinct positive integers `W_1<...<W_(N-1)=H`, with chosen runner
stationary, the full exact two-anchor supply contract S is equivalent to a
real mixed witness. A rational mixed witness suffices and always exists when
a real one exists. This supplies an equivalence, not uniform mixed witnesses.

Frozen inputs read directly (SHA-256):

| Manuscript in `research/` | SHA-256 |
| --- | --- |
| `astra-mixed-anchor-lemma.md` | `5f6f765ec83df352eecfdabe7a65202ed17a79029d5139e315c989ad7dcce273` |
| `astra-exact-affine-union-audit.md` | `a44b368e25bd88084ff7cd1d0098e912d452e77d28af7743a1b9f4d43c5be5b2` |
| `astra-exact-affine-union-review.md` | `1bb496699831546d2b5377d77339b2b69efb55197fb76b4b5d488a77f34a0f02` |
| `astra-exact-rounding-scope-audit.md` | `ba16410bdd0ca08262573fbfa36d6e46078a7b3910f68e7593318dea63d78c3c` |

Write `||x||` for distance to the nearest integer, `delta=1/N`, and
`delta0=1/(N-1)`. Mixed means `||W_i T||>=delta` for every original moving
label and `||HT||>=delta0`, all at one T. Preserve every label and closed bound.
S quantifies over positive integer q, integral u with stationary `u_0=0`
and `u_H=q`, any two distinct moving labels A,B, and one real tau. Define
`p=H/q`, `beta=W_A+W_B`, `alpha=-(u_A+u_B)`, `w_i=beta*u_i+alpha*W_i`,
`R_i=q*W_i-H*u_i`, and the actual count `c=card{|w_i|}`. Every w_i is nonzero;
`w_A=-w_B` implies `1<=c<=N-2`. The simultaneous requirements are
`E_i=||w_i tau||-(|R_i|/H)||beta tau||>=delta` and
`C_i=||w_i tau||>=1/(c+1)`. No bound on u, tau, or q is added.

For necessity use the frozen transport, derived here to retain all q and ties.
Set `n=1-floor(alpha*tau/q)`, `y=alpha*tau+q*n`,
`x=(alpha*p+beta)*tau`, `D=p*y-x=H*n-beta*tau`, let j be either nearest
integer to D, and put `t=(j+x)/p`. Then `q<=y<2q` and
`|t-y|=||beta*tau||/p<=1/(2p)`, so `t>=q*(1-1/(2H))>0`.
For `v_i=W_i-p*u_i`, exact expansion gives
`W_i*t=u_i*j+w_i*tau+R_i*n+v_i*(t-y)`. The first and third terms are integers;
the norm's Lipschitz inequality and E give all ordinary margins at this t.
At H the residual vanishes and `H*t=q*j+w_H*tau` exactly. Therefore
`||Ht||=||w_H*tau||>=1/(c+1)>=delta0`. This proves S implies mixed,
including negative real tau, half-integer rounding ties, and q greater than H.

To rationalize any real mixed witness, fix `z_i=floor(W_i*T)` and set
`d_i=delta` except `d_H=delta0`. The finite closed intersection
`[L,R]=intersection_i [(z_i+d_i)/W_i,(z_i+1-d_i)/W_i]`
contains T. Its endpoints are rational, `L<=R`, and either endpoint remains
a mixed witness. This also handles `d_H=1/2` and singleton intersections;
an approximation or an unproved strict margin is unnecessary.

For N>=4 the frozen mixed-anchor lemma is valid without correction.
Normalize this rational witness modulo one and reflect if needed so
`f_H=Ht-floor(Ht) in [delta0,1/2]`; integer speeds preserve every norm.
For the ordinary bands with these fixed floors define
`L=max_i((z_i+delta)/W_i)`, `R=min_i((z_i+1-delta)/W_i)`,
and `K=(z_H+1/2)/H`. Thus `L<=t<=R` and `t<=K`.
If `R<=K`, every upper endpoint owner has phase `1-delta`; none is H,
whose phase `h'=HR-z_H` lies in `[delta0,1/2]`. Any such speed a<H gives
`||(a+H)R||=h'-delta>0`. This includes tied owners, R=K, and L=R.
If `K<R`, use s=K. The identity `||x+1/2||=1/2-||x||` implies
`0<||(a+H)s||<=1/2-delta` whenever some original a<H is nonhalf.
If all original phases are half, put `b=1/2-delta0>0`,
`epsilon=b/(4H)`, and `T'=s+epsilon`. No phase crosses an integer:
`||W_i*T'||=1/2-W_i*epsilon>=1/2-b/4>delta0`.
For any original a<H, `(a+H)s` is integral and
`0<(a+H)*epsilon<2H*epsilon=b/2<1/2`, whereas
`(a+2H)*epsilon<3b/4<1/2-delta`. Hence
`0<||(a+H)T'||<||HT'||-delta`. All returned witnesses are rational.
The accepted conditional constructor therefore supplies S, with anchors a,H,
q=1, exact common-time E+C, and actual `c=N-2`. Its nonzero error enables
open shift intervals and finite collision avoidance; neither is assumed at zero.

For N=3 write W=(a,H). Mixed forces `||HT||=1/2`. If `||aT||<1/2`,
the half-phase identity gives `0<||(a+H)T||=1/2-||aT||<=1/2-1/3`;
the accepted conditional constructor applies with no free coordinates.
If both phases are half, bypass its nonzero-anchor premise: choose
`q=1`, `p=H`, `u=(0,1)`, `alpha=-1`, `beta=a+H`, `tau=-T`.
Then `w=(-a,a)` is nowhere zero, c=1, and beta*T is an integer.
Thus `||beta*tau||=0` and every E_i=C_i=1/2 at the same tau.
In the old normalization `n=1-floor(T)`, `y=T+n`, `x=-a*T`,
`D=beta*T+H*n` is an integer, so `j=D` and returned `t=T+1-floor(T)>0`.
All original phases are preserved. The anchor determinant is -a, nonzero,
so this also meets an optional rank-two premise. This finishes mixed implies S.

For `(1,3)`, N=3, the complete mixed set modulo one is `{1/2}`: the H-half
candidates `1/6,1/2,5/6` have speed-1 norms `1/6,1/2,1/6`.
Its only pair-sum norm is zero. This refutes the all-N nonzero-anchor lemma
but supplies the zero-loss S packet above; it is not an obstruction to S or LRC.
No arbitrary-tuple mixed supply, nonstationary equivalence, new Lean theorem,
or full canonical proof/disproof follows. Uniform supply remains unresolved.

The following sole independent program adds four N=3 zero-loss packets
(including negative time and nonprimitive scaling), a nonhalf equality, and
four singleton intersections. It guards the four frozen sources above;
existing author/reviewer programs already cover the larger constructors.
These fixed controls support the proof; they are not a uniform-supply search.

```python
from fractions import Fraction as Q
from pathlib import Path
from hashlib import sha256
from math import floor
guards = {
    'astra-mixed-anchor-lemma.md': '5f6f765ec83df352eecfdabe7a65202ed17a79029d5139e315c989ad7dcce273',
    'astra-exact-affine-union-audit.md': 'a44b368e25bd88084ff7cd1d0098e912d452e77d28af7743a1b9f4d43c5be5b2',
    'astra-exact-affine-union-review.md': '1bb496699831546d2b5377d77339b2b69efb55197fb76b4b5d488a77f34a0f02',
    'astra-exact-rounding-scope-audit.md': 'ba16410bdd0ca08262573fbfa36d6e46078a7b3910f68e7593318dea63d78c3c',
}
for name, digest in guards.items():
    assert sha256((Path('research') / name).read_bytes()).hexdigest() == digest
def norm(x):
    f = x - floor(x)
    return min(f, 1-f)
for a, H, T in ((1,3,Q(1,2)), (1,3,-Q(1,2)), (2,6,Q(1,4)), (3,9,Q(1,6))):
    W, u, q, p, alpha, beta, tau = (a,H), (0,1), 1, H, -1, a+H, -T
    assert all(norm(v*T) == Q(1,2) for v in W)
    w = tuple(beta*ui+alpha*v for v, ui in zip(W,u))
    c = len(set(map(abs,w)))
    assert w == (-a,a) and all(w) and c == 1 and norm(beta*tau) == 0
    for v, ui, wi in zip(W,u,w):
        C = norm(wi*tau)
        E = C - Q(abs(q*v-H*ui),H)*norm(beta*tau)
        assert E == C == Q(1,c+1) == Q(1,2) and E >= Q(1,3)
    n = 1-floor(alpha*tau/q)
    y, x = alpha*tau+q*n, (alpha*p+beta)*tau
    D = p*y-x
    assert D.denominator == 1
    j = int(D)
    t = (j+x)/p
    assert t == T+1-floor(T) and 1 <= t < 2 and H*t == q*j+w[-1]*tau
    assert all(norm(v*t) == norm(v*T) for v in W)
assert norm(5*Q(1,6)) == Q(1,2)-norm(2*Q(1,6)) == Q(1,6)
assert [Q(2*k+1,6) for k in range(3) if norm(Q(2*k+1,6)) >= Q(1,3)] == [Q(1,2)]
for W, T in (((1,3),Q(1,2)), ((1,3,6),Q(1,4)), ((1,3,4,5),Q(9,20)), ((1,3,4,5),Q(11,20))):
    N, H = len(W)+1, W[-1]
    bands = [((floor(v*T)+d)/v, (floor(v*T)+1-d)/v) for v in W for d in [Q(1,N-1) if v == H else Q(1,N)]]
    L, R = max(b[0] for b in bands), min(b[1] for b in bands)
    assert L == R == T and all(norm(v*L) >= Q(1,N) for v in W) and norm(H*L) >= Q(1,N-1)
print('PASS: 4 N3 zero-loss packets; 1 N3 nonhalf boundary; 4 closed singleton cells; 4 frozen source guards.')
```

The block ran successfully with exact rational arithmetic and the single PASS
line above. Program SHA-256: `39b3976e17e411205f0510368a96c0795fb6f8f2414f79a8c863a262489c8e3b`.
Stdout SHA-256: `350342151674b46fdb4b01cda788dba2370f3b88d7c8f7a89902979954cf0628`.
Both hashes include the respective final newline. Replay from repository root:

```sh
python3 -B - <<'MIXED_SUPPLY_REVIEW'
from pathlib import Path
from hashlib import sha256
from contextlib import redirect_stdout
import io, re
blocks = re.findall(r'^```python\n(.*?)^```[ \t]*$', Path('research/astra-mixed-supply-equivalence-review.md').read_text(), re.M | re.S)
assert len(blocks) == 1 and sha256(blocks[0].encode()).hexdigest() == '39b3976e17e411205f0510368a96c0795fb6f8f2414f79a8c863a262489c8e3b'
capture = io.StringIO()
with redirect_stdout(capture):
    exec(compile(blocks[0], 'mixed-supply-equivalence-review', 'exec'), {})
assert sha256(capture.getvalue().encode()).hexdigest() == '350342151674b46fdb4b01cda788dba2370f3b88d7c8f7a89902979954cf0628'
print(capture.getvalue(), end='')
MIXED_SUPPLY_REVIEW
```

Final readback and byte-exact replay passed. All owned commands are stopped
at handoff. The final artifact hash is reported separately to avoid self-reference.
