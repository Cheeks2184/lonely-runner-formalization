# Independent review of one-anchor exact-loss completeness

2026-09-05. Requested Astra xhigh, task `/root/single_anchor_review`, assigned
checkpoint `dcee411946aff78931147df421e1095d25dbb948`. Project configuration,
workflow, policy, and current state were read; research is authorized and
`python3 scripts/validate_workflow.py` passed. Runtime model and effort were
not independently exposed. This review is separate from Pass27. Only this
owned review file was written; no author manuscript, Lean source, shared
state, Git, or cache changes were made.

**Accepted at manuscript level without a mathematical correction.** The full
frozen author manuscript is `research/astra-single-anchor-completeness-audit.md`,
SHA-256 `206e70ab052453c343b6ff5cd6b68d42152f884b8a7868a28ff8e5b49ea1b20a`.
For each fixed stationary positive integer tuple with at least two moving
comparison labels, ordinary witness existence is equivalent to existence of
a one-anchor packet satisfying both E and its true collision-count condition
C at one common time. Repeated positive speeds are allowed. This is neither
uniform packet supply from the lower-count hypothesis nor a new kernel-checked
theorem. The unrestricted LRC objective remains unresolved.

## Exact contract and forward implication

There are `m=N-1>=2` positive integer speeds `W_i`, with all original labels
retained. The stationary coordinate alone has `u_0=v_0=0` and is excluded
from the collision row. Moving coefficients `u_i` are arbitrary integers;
`p>0` is rational, `q>0` is integral, and `L=p*q` is a positive integer.
Set `v_i=W_i-p*u_i`, so `q*v_i=q*W_i-L*u_i` is integral. For two distinct
moving labels a,b, define

```text
beta=W_a+W_b, alpha=-(u_a+u_b), w_i=beta*u_i+alpha*W_i.
```

The nowhere-zero hypothesis is explicit. Since `w_a=-w_b`, the actual
number `c` of distinct positive absolute magnitudes satisfies
`1<=c<=m-1=N-2`. Counting the stationary zero, assuming all other magnitudes
distinct, or substituting `N-2` for the actual c would change the contract.
The same real tau must satisfy, for every original moving comparison,

```text
norm(w_i*tau) - (|v_i|/p)*norm(beta*tau) >= 1/N       (E)
norm(w_i*tau) >= 1/(c+1)                            (C).
```

I independently expanded the general transport, for arbitrary real tau:

```text
x=(alpha*p+beta)*tau, y0=alpha*tau,
n=1-floor(y0/q), y=y0+q*n,
D=p*y-x=L*n-beta*tau, j a nearest integer to D,
t=(j+x)/p.
```

The floor inequalities give `q<=y<2*q`, including negative y0. Because L*n
is an integer, `|j-D|=norm(beta*tau)` for either nearest integer at a tie.
Consequently `|t-y|=norm(beta*tau)/p`. Direct expansion gives the equality

```text
W_i*t = u_i*j + w_i*tau + q*v_i*n + v_i*(t-y).
```

Its first and third terms are integral. Integer invariance followed by the
circle norm's Lipschitz inequality proves the exact E-bound. In particular,
E for every original comparison gives a witness at the same t. C is not
needed in this direction. No phase compatibility condition is missing.

Positivity uses the integer product, not a lower bound on p itself:

```text
t >= q-1/(2*p) = q*(1-1/(2*L)) >= q/2 > 0.
```

Thus `p<1`, `L=1`, closed bounds, and both nearest-integer tie choices are
covered. The controls below include an actual E+C packet with p=1/2 and a
separate C-only tie fixture attaining `t=q/2` for its lower tie choice. The
latter fixture does not satisfy E and is not reported as a witness packet.

## Existing-witness premise and balanced pair

Given an original witness, `F(T)=min_i norm(W_i*T)` is continuous and
period one and attains a maximum `M>=1/N>0` on [0,1]. Both endpoints have
value zero, so a maximizer is in (0,1). If M<1/2, each active wave has a
nonzero local slope, either +W_i or -W_i; active phases avoid both types
of corner. Every inactive wave has strict slack. Finiteness supplies one
neighborhood preserving those inactive inequalities. If all active slopes
had the same sign, moving a sufficiently short distance in their increasing
direction would increase F. Hence two distinct active labels have opposite
slopes. Orient them so their fractional phases are M and 1-M.

If M=1/2, every phase is half-integral and any distinct pair of labels works,
including repeated speeds. In both cases their phase sum is integral, so
`beta*T=k` for a positive integer k<beta. This supplies exactly the balanced
pair input of the author. The positive integer speeds and period-one
normalization are used; there is no assertion for arbitrary real speeds.
The rest of the constructor needs these balanced relations and the common
margin, not global maximality. This argument uses the already supplied
original witness to ensure `M>=1/N`; it is not a time selector from H_N.

## Independent check of the simultaneous constructor

Let `r_i` be the least residue of k*W_i modulo beta. Since all original
norms are positive, `1<=r_i<beta`. Set
`d_i=min(r_i,beta-r_i)/beta`; then `d_i>=M` and
`r_a=beta*M`, `r_b=beta-r_a`. The chosen row must satisfy
`w_i congruent -r_i modulo beta` and `w_a=-w_b`. These conditions give

```text
u_i=(w_i+k*W_i)/beta integral, u_a+u_b=k,
p=beta/k, q=k, alpha=-k, v_i=-w_i/k,
p*q=beta, q*v_i=-w_i, x=0.
```

Thus the chosen row really is the packet's computed collision row. In
particular, every moving v_i is nonzero; this is outside the previous class
with a vanishing last residual.

For M<1/2, set `h=1/2-M`, `rho_a=beta-r_a`,
`A=rho_a+6*beta^2`, and `epsilon=h/A`. Since `0<h<1/2` and
`rho_a>0`,

```text
A>6*beta^2>2*beta,
0<epsilon<1/(12*beta^2), 0<beta*epsilon<1/(12*beta)<1/2.
```

For each nonhalf coordinate the integer numerator in
`D_i=1/2-d_i=(beta-2*min(r_i,beta-r_i))/(2*beta)` is positive.
Thus `D_i>=1/(2*beta)` and `D_i<=h`. These two inequalities imply
`6*beta<B_i=D_i/epsilon<=A` simultaneously for every coordinate.
No unspecified large-parameter limit is needed.

Take `w_a=A`, `w_b=-A`. For an extra nonhalf coordinate, let
`eta=+1` below half and `eta=-1` above half,
`rho=beta-min(r_i,beta-r_i)`, and
`z0=rho+beta*floor((B_i-rho)/beta)`. Then
`0<=B_i-z0<beta`, so `z0>B_i-beta>5*beta`.
Also `z0<=B_i<=A`. If z0=A, subtract beta; otherwise retain z0.
This yields `0<z<A`, `z<=B_i`, and

```text
0 <= D_i-z*epsilon < 2*beta*epsilon.
```

In fact the decremented case has B_i=z0=A and the residual is exactly
beta*epsilon. Subtracting beta preserves the residue. For either eta,
`eta*rho congruent -r_i modulo beta`, so `w_i=eta*z` has the required
sign and congruence. At `tau=-1/beta+epsilon`, a phase originally below
half moves upward by z*epsilon, while one above half moves downward by
the same amount. The bound `z*epsilon<=D_i` prevents crossing half;
therefore its new norm is exactly `d_i+z*epsilon`.

For an extra half coordinate beta is even and `w_i=beta/2` has the correct
residue and is smaller than A. Its phase is `1/2+(beta/2)*epsilon` modulo
one, strictly below one, so its norm is `1/2-(beta/2)*epsilon`.

The pair's norms are exactly 1/2. Every nonhalf extra norm is strictly
greater than `1/2-2*beta*epsilon>1/2-1/(6*beta)>=5/12>1/3`.
Every half extra norm is also greater than 1/3 by the same epsilon bound.
For N=3 only the opposite pair exists, so the true count is c=1 and C
requires exactly 1/2. For N>=4 at least one extra magnitude exists and is
positive and strictly smaller than A, proving c>=2. Together with the
opposite-pair duplication, `2<=c<=N-2`, so `1/(c+1)<=1/3` proves C.
Extra magnitudes may repeat each other. The proof does not require their
distinctness or distinct positive W_i.

The exact rounding norm is beta*epsilon. Since `|v_i|/p=|w_i|/beta`,
the exact loss is |w_i|*epsilon. Subtracting it leaves d_i for every
nonhalf coordinate, including the pair. For a half coordinate it leaves
`1/2-beta*epsilon>M` because A>beta. Thus E holds at the closed threshold
1/N, jointly with C at the same tau.

Finally `y0=k*(1/beta-epsilon)` is positive and less than T<1<=q=k.
Hence n=1 and

```text
y=k+T-k*epsilon, D=p*y=beta+1-beta*epsilon,
j=beta+1 uniquely, t=j/p=k+T.
```

This checks the preserved single original time, including k>1. Its
difference from T is an integer, preserving every original integer phase.

When M=1/2, take every magnitude beta/2 with the b entry negative and
`tau=-1/beta`. All residues are beta/2, all collision norms are 1/2,
the true count is c=1, and rounding is zero. Here too n=1,
`j=beta+1`, and `t=k+T`. The c>=2 argument is correctly absent in this
branch even when N>=4 and speeds repeat.

## Scope controls and evidence

The accepted two-anchor obstruction remains valid. Its last-coordinate
identity uses `v_last=0`, `u_last=q`, and `p*q=H`. The present contract
removes these last-anchor requirements; the constructor has nonzero last
residual. In the old N=4 tuple (1,2,3), the closed original witness times
are 1/4 and 3/4 modulo one and the last norm is 1/4. A two-anchor C packet
would force that same norm to be at least 1/3, so it is still impossible.
The new packet succeeds by leaving that old class. No contradiction arises.

I replayed the unmodified author's sole program and verified its program
hash `6ca37f19035643b2591f14833d648cd4afc5f417c6142188a8d8542ac4077f56`
and output hash `9a01362df1883306496507e37b44200a0402c903433442587e903db194ab8111`.
Its four packet controls and eleven original comparisons passed. Its fixed
constructors do not exercise a nonhalf extra coordinate. The independent
program below adds exactly these six supplied-witness fixtures, with no
tuple, time, denominator, or packet search:

| W | T | Pair indices | Purpose |
| --- | --- | --- | --- |
| (1,1,2) | 1/3 | (0,2) | Positive active extra, z0=A decrement |
| (1,2,2) | 1/3 | (0,2) | Negative active extra, z0=A decrement |
| (1,2,3,4) | 1/5 | (0,3) | Nonactive extras of both phase directions, nonintegral floor target |
| (2,2,2) | 1/4 | (0,1) | Repeated speeds, half branch, true c=1 at N=4 |
| (1,2) | 2/3 | (1,0) | Reversed active-pair orientation, k=2, N=3 closed equality |
| (2,6,10) | 3/4 | (0,1) | Half branch with k=6 and nonprimitive speeds |

The first two rows produce (56,53,-56) and (56,-53,-56). Without the
decrement their magnitudes would all be 56, so c>=2 would be false;
that control diagnoses the proof's cardinality step, not the necessity of
decrementing for packet existence. The third row produces
(154,48,-48,-154), with true c=2 despite four original moving labels.
The general result follows from the derivations above, not these fixtures.

The program also checks one genuine p=1/2 E+C packet; both tie choices
in a C-only p=1/2, L=1 fixture; an E-only zero-rounding endpoint packet
whose C condition fails; and a nonintegral-product arithmetic control
where `|j-D|=norm(beta*tau)` fails. These are separate assertions about
their stated scopes, not examples asserted to satisfy missing premises.

## Complete deterministic replay

The independent program's SHA-256 is `3a1914fbbecb2d5f97199e6d8a0fd65cc8fe1989d17b8cb6425e8689537986e8`.
Its single-line JSON output including the final newline has SHA-256
`cd0d960db8fede55e6843b806939a84425ae1db61d2e16f52fef508c3ad1904e`. It binds the full frozen author and previous accepted
scope source/review, and replays the exact author program, which additionally
binds its five source inputs. No Lean execution or dependency restoration is
part of this manuscript evidence.

```python
from fractions import Fraction as Q
from math import floor
from collections import Counter
from contextlib import redirect_stdout
from hashlib import sha256
from pathlib import Path
import io, json, re

bindings = {
    'research/astra-single-anchor-completeness-audit.md': '206e70ab052453c343b6ff5cd6b68d42152f884b8a7868a28ff8e5b49ea1b20a',
    'research/astra-exact-rounding-scope-audit.md': 'ba16410bdd0ca08262573fbfa36d6e46078a7b3910f68e7593318dea63d78c3c',
    'research/astra-exact-rounding-scope-review.md': '37c5d7c39c24e3153d29008ebcccaa6e6141756b6ae0138f61d9c7c548840435',
}
for path, expected in bindings.items():
    assert sha256(Path(path).read_bytes()).hexdigest() == expected, path
source = Path('research/astra-single-anchor-completeness-audit.md').read_text()
blocks = re.findall(r'^```python\n(.*?)^```[ \t]*$', source, re.M | re.S)
assert len(blocks) == 1
assert sha256(blocks[0].encode()).hexdigest() == '6ca37f19035643b2591f14833d648cd4afc5f417c6142188a8d8542ac4077f56'
capture = io.StringIO()
with redirect_stdout(capture):
    exec(compile(blocks[0], 'frozen-author-controls', 'exec'), {})
assert sha256(capture.getvalue().encode()).hexdigest() == '9a01362df1883306496507e37b44200a0402c903433442587e903db194ab8111'
author_counts = json.loads(capture.getvalue())['counts']
counts = Counter()
records = []

def norm(x):
    f = Q(x) % 1
    return min(f, 1-f)

def transfer(name, W, u, p, q, pair, tau, expected_e=True, expected_c=True):
    N = len(W)+1
    assert N >= 3 and len(W) == len(u)
    assert all(type(z) is int and z > 0 for z in W)
    assert all(type(z) is int for z in u)
    p, tau = Q(p), Q(tau)
    assert p > 0 and type(q) is int and q > 0
    L = p*q
    assert L.denominator == 1 and L >= 1
    a, b = pair
    assert 0 <= a < len(W) and 0 <= b < len(W) and a != b
    beta, alpha = W[a]+W[b], -(u[a]+u[b])
    v = tuple(Q(Wi)-p*ui for Wi, ui in zip(W, u))
    w = tuple(beta*ui+alpha*Wi for Wi, ui in zip(W, u))
    assert all((q*vi).denominator == 1 for vi in v)
    assert all(wi != 0 for wi in w) and w[a] == -w[b]
    c = len(set(abs(wi) for wi in w))
    assert 1 <= c <= N-2
    margins = tuple(norm(wi*tau) for wi in w)
    radius = norm(beta*tau)
    lower = tuple(mi-abs(vi)*radius/p for mi, vi in zip(margins, v))
    e = all(mi >= Q(1, N) for mi in lower)
    own = all(mi >= Q(1, c+1) for mi in margins)
    assert e == expected_e and own == expected_c
    x, y0 = (alpha*p+beta)*tau, alpha*tau
    n = 1-floor(y0/q)
    y = y0+q*n
    D = p*y-x
    assert q <= y < 2*q and D == L*n-beta*tau
    candidates = (floor(D), floor(D)+1)
    best = min(abs(Q(j)-D) for j in candidates)
    nearest = tuple(j for j in candidates if abs(Q(j)-D) == best)
    assert best == radius
    times = []
    for j in nearest:
        t = (j+x)/p
        assert abs(t-y) == radius/p
        assert t >= q-Q(1, 2)/p >= Q(q, 2) > 0
        for Wi, ui, vi, wi, lo in zip(W, u, v, w, lower):
            assert Wi*t == ui*j+wi*tau+q*vi*n+vi*(t-y)
            assert (ui*j+q*vi*n).denominator == 1
            assert norm(Wi*t) >= lo
            if e:
                assert norm(Wi*t) >= Q(1, N)
            counts['forward_comparisons'] += 1
        times.append(t)
        counts['nearest_integer_choices'] += 1
    counts['forward_instances'] += 1
    counts['valid_E_C_packets'] += int(e and own)
    records.append(dict(name=name, W=W, w=w, c=c, p=str(p), q=q,
                        times=list(map(str, times)), E=e, C=own,
                        margins=list(map(str, margins)), lower=list(map(str, lower))))
    return w, c, tuple(times), lower

def construct(name, W, T, pair):
    T = Q(T)
    N = len(W)+1
    a, b = pair
    beta = W[a]+W[b]
    assert 0 < T < 1 and (beta*T).denominator == 1
    k = int(beta*T)
    assert 0 < k < beta
    residues = tuple((k*Wi) % beta for Wi in W)
    d = tuple(Q(min(r, beta-r), beta) for r in residues)
    M = min(d)
    assert all(residues) and M >= Q(1, N)
    assert Q(residues[a], beta) == M
    assert Q(residues[b], beta) == 1-M
    row = [None]*len(W)
    before = [None]*len(W)
    if M == Q(1, 2):
        assert beta % 2 == 0 and all(2*r == beta for r in residues)
        row = [beta//2]*len(W)
        row[b] = -beta//2
        before = row[:]
        eps = Q(0)
        counts['half_constructors'] += 1
    else:
        h = Q(1, 2)-M
        A = beta-residues[a]+6*beta**2
        eps = h/A
        assert A > 6*beta**2 > 2*beta
        assert 0 < eps < Q(1, 12*beta**2)
        assert 0 < beta*eps < Q(1, 12*beta) < Q(1, 2)
        row[a], row[b] = A, -A
        before[a], before[b] = A, -A
        for i, (r, di) in enumerate(zip(residues, d)):
            if di < Q(1, 2):
                gap = Q(1, 2)-di
                assert Q(1, 2*beta) <= gap <= h
                target = gap/eps
                assert 6*beta < target <= A
            if i in pair:
                continue
            if di == Q(1, 2):
                row[i] = before[i] = beta//2
                assert beta % 2 == 0 and 0 < row[i] < A
                counts['half_extras'] += 1
            else:
                sign = 1 if 2*r < beta else -1
                rho = beta-min(r, beta-r)
                z0 = rho+beta*floor((target-rho)/beta)
                assert (sign*rho+r) % beta == 0
                assert 0 <= target-z0 < beta and z0 > 5*beta
                before[i] = sign*z0
                z = z0-beta if z0 == A else z0
                assert 0 < z < A and z <= target
                assert 0 <= gap-z*eps < 2*beta*eps
                if z0 == A:
                    assert target == A and gap-z*eps == beta*eps
                    counts['positive_decrements' if sign == 1 else 'negative_decrements'] += 1
                if di > M:
                    assert target.denominator > 1
                    counts['positive_nonactive_floors' if sign == 1 else 'negative_nonactive_floors'] += 1
                row[i] = sign*z
                counts['nonhalf_extras'] += 1
        assert all(0 < abs(row[i]) < A for i in range(len(W)) if i not in pair)
        c = len(set(map(abs, row)))
        if N == 3:
            assert c == 1
            counts['subhalf_count_one'] += 1
        else:
            assert 2 <= c <= N-2
        counts['subhalf_constructors'] += 1
    tau = -Q(1, beta)+eps
    for wi, Wi, di in zip(row, W, d):
        assert wi != 0 and (wi+k*Wi) % beta == 0
        assert (wi*(-Q(1, beta))-Wi*T).denominator == 1
        if di < Q(1, 2):
            assert norm(wi*tau) == di+abs(wi)*eps
            assert norm(wi*tau)-abs(wi)*eps == di
        else:
            assert norm(wi*tau) == Q(1, 2)-Q(beta, 2)*eps
        counts['constructor_comparisons'] += 1
    assert norm(beta*tau) == beta*eps
    u = tuple((wi+k*Wi)//beta for wi, Wi in zip(row, W))
    assert u[a]+u[b] == k
    assert all(Q(Wi)-Q(beta, k)*ui == -Q(wi, k) for Wi, ui, wi in zip(W, u, row))
    got, c, times, lower = transfer(name, W, u, Q(beta, k), k, pair, tau)
    assert got == tuple(row) and times == (k+T,)
    assert all((Wi*times[0]-Wi*T).denominator == 1 for Wi in W)
    if M == Q(1, 2):
        assert c == 1 and all(norm(wi*tau) == Q(1, 2) for wi in row)
    elif N == 3:
        assert all(norm(wi*tau) == Q(1, 2) for wi in row)
    counts['closed_threshold_comparisons'] += sum(lo == Q(1, N) for lo in lower)
    counts['constructor_fixtures'] += 1
    return got, len(set(map(abs, before)))

# Every input time and pair is supplied explicitly; no discovery loop occurs.
w, old_c = construct('positive active extra', (1,1,2), Q(1,3), (0,2))
assert w == (56,53,-56) and old_c == 1
counts['decrement_cardinality_controls'] += 1
w, old_c = construct('negative active extra', (1,2,2), Q(1,3), (0,2))
assert w == (56,-53,-56) and old_c == 1
counts['decrement_cardinality_controls'] += 1
w, _ = construct('two nonactive directions', (1,2,3,4), Q(1,5), (0,3))
assert w == (154,48,-48,-154)
w, _ = construct('repeated half speeds', (2,2,2), Q(1,4), (0,1))
assert w == (2,-2,2)
w, _ = construct('reversed pair k2 N3', (1,2), Q(2,3), (1,0))
assert w == (-56,56)
w, _ = construct('half branch k6', (2,6,10), Q(3,4), (0,1))
assert w == (4,-4,4)

w, c, ts, _ = transfer('valid p below one', (1,1), (1,0), Q(1,2), 2, (0,1), Q(1,2))
assert w == (1,-1) and c == 1 and ts == (Q(7,2),)
counts['valid_p_below_one_controls'] += 1
w, c, ts, lo = transfer('both ties C only', (1,2), (1,-1), Q(1,2), 2, (0,1), Q(1,6), False, True)
assert ts == (Q(1), Q(3)) and ts[0] == Q(2,2)
assert lo == (Q(0), Q(-2))
assert all(norm(Wi*t) == 0 for Wi in (1,2) for t in ts)
counts['both_ties_and_closed_positivity_controls'] += 1
counts['C_without_E_controls'] += 1
w, c, ts, _ = transfer('E only old endpoint encoding', (1,2,3), (0,1,1), 3, 1, (0,2), -Q(1,4), True, False)
assert w == (-1,2,1) and c == 2 and ts == (Q(5,4),)
counts['E_without_C_controls'] += 1

# Without an integral product, the claimed rounding equality is unavailable.
p, q, beta, alpha, tau = Q(1,4), 2, 3, 0, Q(1,6)
L = p*q
y0 = alpha*tau
n = 1-floor(y0/q)
y = y0+q*n
x = (alpha*p+beta)*tau
D = p*y-x
assert L.denominator != 1 and D == 0
assert abs(Q(0)-D) == 0 != norm(beta*tau)
assert any((q*(Q(Wi)-p*ui)).denominator != 1 for Wi, ui in zip((1,2), (1,-1)))
counts['missing_integer_product_controls'] += 1

assert counts['constructor_fixtures'] == 6 and counts['constructor_comparisons'] == 18
assert counts['forward_instances'] == 9 and counts['forward_comparisons'] == 27
assert counts['nearest_integer_choices'] == 10 and counts['valid_E_C_packets'] == 7
assert counts['positive_decrements'] == counts['negative_decrements'] == 1
assert counts['positive_nonactive_floors'] == counts['negative_nonactive_floors'] == 1
assert counts['half_constructors'] == 2 and counts['subhalf_constructors'] == 4
assert counts['closed_threshold_comparisons'] == 4
print(json.dumps(dict(author_counts=author_counts, counts=dict(sorted(counts.items())), records=records), sort_keys=True, separators=(',', ':')))
```

Run this saved block, unmodified, from the repository root:

```sh
python3 -B - <<'SINGLE_ANCHOR_REVIEW_REPLAY'
from pathlib import Path
from hashlib import sha256
from contextlib import redirect_stdout
import io, re
text = Path('research/astra-single-anchor-completeness-review.md').read_text()
blocks = re.findall(r'^```python\n(.*?)^```[ \t]*$', text, re.M | re.S)
assert len(blocks) == 1
assert sha256(blocks[0].encode()).hexdigest() == '3a1914fbbecb2d5f97199e6d8a0fd65cc8fe1989d17b8cb6425e8689537986e8'
capture = io.StringIO()
with redirect_stdout(capture):
    exec(compile(blocks[0], 'single-anchor-independent-controls', 'exec'), {})
assert sha256(capture.getvalue().encode()).hexdigest() == 'cd0d960db8fede55e6843b806939a84425ae1db61d2e16f52fef508c3ad1904e'
print(capture.getvalue(), end='')
SINGLE_ANCHOR_REVIEW_REPLAY
```

The replay passes with six additional constructor fixtures, eighteen constructor
comparisons, nine general transport instances, and twenty-seven comparisons
across ten nearest-integer choices. Seven of those general instances satisfy
both E and C; the two deliberately partial-premise instances are identified
separately. Source identity and the unmodified author output are also checked.

Acceptance is limited to the stated manuscript equivalence and its supporting
exact arithmetic controls. No Lean declaration, canonical theorem bridge,
uniform H_N supply, finite-family supply, or unrestricted LRC resolution is
claimed. All owned commands have stopped at final handoff.
