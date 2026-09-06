# Independent review of conditional exact two-anchor supply

2026-09-05. Requested Astra/xhigh task
`/root/single_anchor_review-exact-affine-constructor-review`, assigned checkpoint
`1412a65421d2b0898f7dc28fd1b6f3b736131d33`. Project configuration, workflow,
policy, and current state were read; workflow structural validation passed.
Research is authorized; canonical completion remains absent. Runtime model
and effort were not independently exposed. Only this review file was written.
No author source, Lean, state, Git, or cache changes were made. This evidence
is separate from the Pass28/PR27 checkpoint.

**Accepted as a conditional manuscript theorem without mathematical correction.**
The full frozen source is `research/astra-exact-affine-union-audit.md`, SHA-256
`a44b368e25bd88084ff7cd1d0098e912d452e77d28af7743a1b9f4d43c5be5b2`.
The extra nonzero second-anchor inequality is a genuine hypothesis. The
manuscript proves that a rational witness satisfying all three stated
premises yields an exact two-anchor E+C packet with true count `c=N-2`.
It neither derives that anchor from an arbitrary mixed witness nor proves
uniform supply for the direct-or-exact union. No Lean theorem or unrestricted
LRC resolution is established by this review.

## Contract and exact phase preservation

The input is `N>=3`, sorted distinct positive integers
`W_1<...<W_(N-1)=H`, a stationary chosen runner, and a rational time T.
Let `delta=1/N`, `delta0=1/(N-1)`, and `h=norm(H*T)`. The hypotheses are

```text
norm(W_i*T) >= delta for every original moving label,
h >= delta0,
0 < norm((a+H)*T) <= h-delta for some original speed a<H.
```

There is no assumption that T is positive or in a particular unit interval.
There is no primitive-gcd or individual-coprimality hypothesis. The original
labels are retained throughout. The output has stationary coefficients zero,
`q=1`, `p=H`, integral moving u with `u_H=1`, and `v_i=W_i-H*u_i`.
At one common tau its nowhere-zero collision row must satisfy both

```text
E_i = norm(w_i*tau) - (|W_i-H*u_i|/H)*norm(beta*tau) >= delta,
C_i = norm(w_i*tau) >= 1/(c+1),
c = number of distinct positive magnitudes |w_i|.
```

No small-error bound, monotonicity, or upper bound on u is part of that
contract. The construction's large and possibly negative u values are legal.

Put `beta=a+H`, let ell be nearest to beta*T, and let
`b=beta*T-ell`. The anchor premise gives
`0<|b|<=h-delta<=1/2-delta<1/2`. Thus ell is unique, including when the
anchor inequality is an equality; T itself may be negative. Choose a large
positive integer L and set

```text
m=1+beta*L, d=H*m-beta>0, k=-ell,
u_a=m-1, u_H=1, alpha=-m,
e=-H*b/d, tau=(k+e)/beta.
```

Then `w_a=beta*(m-1)-m*a=d` and `w_H=beta-m*H=-d`.
As L increases, e is nonzero and its absolute value tends to zero. Choose
`|e|<1/2`. With `y0=-m*tau`, `n=1-floor(y0)`, and `y=y0+n`, the old
transport has

```text
1<=y<2, D=H*n-k-e, j=H*n-k uniquely nearest,
t=(j+(alpha*H+beta)*tau)/H = y+e/H.
```

The signs in these equations are correct: `j-D=e`, not -e. Since H is a
positive integer, `t>=1-1/(2*H)>0`. In the stated distinct tuple H>=2.
The computation, without suppressing the normalization integer, gives

```text
t = n-m*k/beta - d*e/(H*beta)
  = n-m*k/beta + b/beta,
t-T = n-(m*k+ell)/beta = n+L*ell, an integer.
```

This proves exact preservation of all original phases for negative T as
well as positive T. It does not require a separate time for each comparison.
The fastest endpoint identity `H*t=j+w_H*tau` holds exactly; hence the
two anchor collision norms are both h. The last residual is zero and the
other anchor residual is `a-H*(m-1)=-d`, so

```text
E_H=h, E_a=h-(d/H)*|e|=h-|b|>=delta.
```

Closed original, fastest-endpoint, and anchor equalities are retained.
The unique-nearest argument uses strict `|b|,|e|<1/2`; the hypotheses imply
the former, and the finite construction ensures the latter.

## Open shift intervals and actual cardinality

For each free coordinate, write
`s_i=(W_i/H-u_i)*e`. Since t-T is integral and u_i and v_i are integers,
the exact transport identity gives

```text
w_i*tau congruent W_i*T-s_i modulo integers,
(|W_i-H*u_i|/H)*norm(beta*tau)=|s_i|.
```

These are the signs and exact loss needed by the interval argument. If the
signed principal phase is z with `g=|z|<1/2`, then g>=delta>0, so z has
a definite nonzero sign. Taking

```text
s_i=-sign(z)*r,
max(0,delta0-g)<r<1/2-g
```

moves the phase toward half without crossing it. Its norm is g+r>delta0
and subtracting |s_i|=r leaves exactly g>=delta. This remains valid when
the original coordinate has norm exactly delta. The interval width is
positive: it is `1/2-g` if g>=delta0 and `1/2-delta0` otherwise.

For g=1/2 use the symmetric interval

```text
|s_i|<min((1/2-delta)/2, 1/2-delta0).
```

The collision norm is `1/2-|s_i|>delta0`, and its E-bound is
`1/2-2*|s_i|>delta`. These intervals have positive width for N>=4,
regardless of the choice of signed representative at a half-integer.
For N=3 there are no free coordinates: the anchor hypothesis forces
h=delta0=1/2, and the opposite anchor pair has true c=1. No open interval
with an impossible strict margin greater than 1/2 is invoked in that case.

All intervals J_i are fixed from T before L is chosen. Since e is nonzero,
the inverse image of J_i under `u -> (W_i/H-u)*e` is an open interval
of length `length(J_i)/|e|`. This works for either sign of e. There are
finitely many intervals; taking L sufficiently large makes every length
greater than 4N simultaneously. If an interval is (A,B), its first 2N
integers starting at `floor(A)+1` are strictly inside: the first is greater
than A and the last is at most A+2N<B. Open endpoints cause no rounding gap.

The author's explicit finite parameter choice also satisfies its claims.
For positive
`eta=min(1/4, length(J_i)/(4N) over free i)`, taking

```text
L=1+ceil((beta+H*|b|/eta)/(H*beta))
```

gives `H*beta*L>beta+H*|b|/eta`, whence
`d=H+H*beta*L-beta>H*|b|/eta` and `0<|e|<eta`.
For N=3 the minimum is just 1/4. No limiting or oracle step remains in the
fixed rational construction.

After j previous free coordinates, disallow collision values
`0,+d,-d,+w_previous,-w_previous`. At most `3+2j` integers u are forbidden
because `w_i=beta*u-m*W_i` has nonzero coefficient beta. There are at most
N-3 free coordinates, so `j<=N-4` and `3+2j<=2N-5<2N`.
At least one candidate therefore survives. Sequential choice makes all
free magnitudes nonzero, mutually distinct, and different from d. Exactly
the anchor pair duplicates a magnitude; hence `c=1+(N-3)=N-2`.
The free strict margin and anchor closed margin now prove C at its true
threshold delta0. The exact shift identities prove E. This avoids any
circular assumption about c while choosing the free coordinates.

The optional rank-two claim is also correct: the anchor determinant
`H*u_a-a*u_H=d` is nonzero. It does not create a smaller original tuple,
denominator descent, or a hypothesis about nonstationary chosen runners.

## Independent fixed rejection control

The frozen author's five constructors all select their first tested integer.
To exercise an actual forbidden-value rejection, I constructed the following
fixed input analytically, without a tuple search:

```text
N=5, W=(1,3,4,6), T=5/12, a=1, H=6,
beta=7, ell=3, b=-1/12, h=1/2,
L=3, m=22, d=125, e=1/250.
```

The original norms are `(5/12,1/4,1/3,1/2)`, satisfying all premises.
For speed 3 the shift interval is `(-1/4,0)`, whose u interval is
`(1/2,63)`. Choose the ten consecutive candidates 42 through 51 and accept
42, giving `w_3=228`. For speed 4 the shift interval is `(0,1/6)`, whose
u interval is `(-41,2/3)`. All ten candidates -20 through -11 lie strictly
inside it. The first, -20, gives `w_4=-228` and is actually rejected because
its magnitude is already used. The next, -19, gives -221 and is accepted.
The final packet is

```text
q=1, p=6, u=(21,42,-19,1), w=(125,228,-221,-125), c=3,
tau=-107/250, returned t=17/12,
collision norms=(1/2,52/125,103/250,1/2),
E bounds=(5/12,1/4,1/3,1/2).
```

This uses permissible candidate windows inside the same proved intervals;
the theorem does not prescribe which such 2N consecutive integers to try.
The program verifies all candidate-window endpoints and records the rejection.

For perspective on that fixture, `m=1 mod beta` implies gcd(m,beta)=1.
Under the stated distinct-speed bounds, zero collisions and collisions with
either anchor magnitude are already impossible by congruence; equality of
two free collision values is also impossible. The integer equation
`w_i=-w_j` is solvable precisely when the two distinct free speeds sum to
beta; this does not assert that a solution lies in every permitted shift
interval. The fixture uses `3+4=1+6=7`. This observation explains the test;
the author's more conservative `3+2j` exclusion bound remains valid and
does not need this refinement.

## Scope and reproducibility

The necessary endpoint implication `S => original witness with fastest norm
at least delta0` is correct for the old two-anchor contract. The fixed
ordinary/mixed interval certificates and literal q=4 packet in the author
were also replayed exactly. Their closed endpoint intersections support only
the stated fixed tuple conclusions. They do not prove the converse of that
necessary implication. The zero-b half-phase packet is a success outside
this constructor: b=0 would make e=0 and invalidate the inverse-interval
step, so excluding it here is correct rather than an impossibility claim.

The independent controls below include the actual rejection fixture, a
negative-time boundary fixture, N=3 with exact anchor equality, a negative
half-phase fixture, a nonprimitive scaling of a supplied fixture, and the
supplied N=7 fixture with a free coordinate exactly at the original threshold.
They test both signs of b and e, open intervals, closed E/C boundaries,
the no-free case, and true cardinality. Two explicit invalid-premise controls
separate zero b and a bad anchor choice from the theorem's allowed inputs.
The universal conditional theorem is accepted from the derivation above;
these finite controls are supporting evidence only.

The source program hash is
`5aef75b40a1cbb1a175ee98c0b349c0fc2ddee21da1c82812c270f23b763cc8f`;
its stdout hash is
`cba49a167680aa29ef8d92f676103c27d9fcad39ef89e4437813bdb580b45400`.
I replayed it unmodified and obtained the exact hashes, seven verified
packets, 25 original comparison checks, and the recorded interval controls.
The independent program below binds the full author source, replays that
program with its five frozen dependencies, and uses only exact rational
arithmetic. It performs no tuple discovery and writes no file.

## Sole independent program

Program SHA-256: `14119c0209df4afcfe4087b22f548b55dce77e8bbc001c0d77da6b3b834c2951`.
Exact single-line stdout, including the final newline, SHA-256:
`facad043b8229753d47f0bafa4759cb4e25b738c1b8b4ff6d7a7f8a8e39f84ec`.

```python
from fractions import Fraction as Q
from math import floor, ceil, gcd
from collections import Counter
from contextlib import redirect_stdout
from hashlib import sha256
from pathlib import Path
import io, json, re

author_path = Path('research/astra-exact-affine-union-audit.md')
assert sha256(author_path.read_bytes()).hexdigest() == 'a44b368e25bd88084ff7cd1d0098e912d452e77d28af7743a1b9f4d43c5be5b2'
blocks = re.findall(r'^```python\n(.*?)^```[ \t]*$', author_path.read_text(), re.M | re.S)
assert len(blocks) == 1
assert sha256(blocks[0].encode()).hexdigest() == '5aef75b40a1cbb1a175ee98c0b349c0fc2ddee21da1c82812c270f23b763cc8f'
capture = io.StringIO()
with redirect_stdout(capture):
    exec(compile(blocks[0], 'frozen-author-program', 'exec'), {})
assert sha256(capture.getvalue().encode()).hexdigest() == 'cba49a167680aa29ef8d92f676103c27d9fcad39ef89e4437813bdb580b45400'
author_counts = json.loads(capture.getvalue())['counts']
counts, records, rejected = Counter(), [], []

def principal(x):
    x = Q(x)
    return x-floor(x+Q(1, 2))

def norm(x):
    return abs(principal(x))

def premises(W, T, a):
    N, H = len(W)+1, W[-1]
    return (all(norm(Wi*T) >= Q(1, N) for Wi in W)
            and norm(H*T) >= Q(1, N-1)
            and 0 < norm((a+H)*T) <= norm(H*T)-Q(1, N))

def verify(name, W, T, a, window_starts=None):
    W, T = tuple(W), Q(T)
    N, H = len(W)+1, W[-1]
    assert N >= 3 and W == tuple(sorted(set(W)))
    assert all(type(Wi) is int and Wi > 0 for Wi in W)
    assert a in W and a < H and premises(W, T, a)
    ai, hi = W.index(a), len(W)-1
    delta, delta0 = Q(1, N), Q(1, N-1)
    beta = a+H
    ell = floor(beta*T+Q(1, 2))
    b = beta*T-ell
    h = norm(H*T)
    assert 0 < abs(b) <= h-delta < Q(1, 2)
    counts['positive_b' if b > 0 else 'negative_b'] += 1
    free = tuple(i for i in range(len(W)) if i not in (ai, hi))
    intervals = {}
    for i in free:
        z, g = principal(W[i]*T), norm(W[i]*T)
        if g == Q(1, 2):
            radius = min((Q(1, 2)-delta)/2, Q(1, 2)-delta0)
            lo, up = -radius, radius
            counts['half_free_coordinates'] += 1
        else:
            sign = 1 if z > 0 else -1
            r0, r1 = max(Q(0), delta0-g), Q(1, 2)-g
            assert 0 <= r0 < r1
            lo, up = sorted((-sign*r0, -sign*r1))
            counts['positive_principal_free' if z > 0 else 'negative_principal_free'] += 1
        assert lo < up
        intervals[i] = (lo, up)
        counts['tight_original_free_coordinates'] += int(g == delta)
    eta = min([Q(1, 4)]+[(up-lo)/(4*N) for lo, up in intervals.values()])
    L = 1+ceil((beta+H*abs(b)/eta)/(H*beta))
    m, k = 1+beta*L, -ell
    d = H*m-beta
    e = -H*b/d
    assert d > H*abs(b)/eta > 0 and 0 < abs(e) < eta <= Q(1, 4)
    assert m % beta == 1 and gcd(m, beta) == 1
    assert (m*k+ell) % beta == 0
    u = [None]*len(W)
    u[ai], u[hi] = m-1, 1
    used = {d}
    free_data = []
    for order, i in enumerate(free):
        lo, up = intervals[i]
        Ulo, Uhi = sorted((Q(W[i], H)-lo/e, Q(W[i], H)-up/e))
        assert Uhi-Ulo > 4*N
        first = (window_starts or {}).get(W[i], floor(Ulo)+1)
        candidates = tuple(range(first, first+2*N))
        assert all(Ulo < v < Uhi for v in candidates)
        forbidden = {0} | {z for magnitude in used for z in (magnitude, -magnitude)}
        assert len(forbidden) <= 3+2*order <= 2*N-5
        excluded = [ui for ui in candidates if beta*ui-m*W[i] in forbidden]
        assert len(excluded) <= len(forbidden) < len(candidates)
        for ui in candidates:
            wi = beta*ui-m*W[i]
            shift = (Q(W[i], H)-ui)*e
            assert lo < shift < up
            assert norm(W[i]*T-shift) > delta0
            assert norm(W[i]*T-shift)-abs(shift) >= delta
            counts['examined_candidates'] += 1
            if wi in forbidden:
                rejected.append(dict(name=name, speed=W[i], u=ui, w=wi))
                counts['actual_forbidden_rejections'] += 1
                continue
            u[i] = ui
            used.add(abs(wi))
            free_data.append((i, shift))
            break
        assert u[i] is not None
        counts['free_coordinates'] += 1
        counts['candidate_window_integers'] += len(candidates)
    tau = (k+e)/beta
    alpha = -m
    w = tuple(beta*ui+alpha*Wi for Wi, ui in zip(W, u))
    assert w[ai] == d and w[hi] == -d and all(w)
    c = len(set(map(abs, w)))
    assert c == N-2 and len(used) == c
    assert H*u[ai]-a*u[hi] == d
    x, y0 = (alpha*H+beta)*tau, alpha*tau
    n = 1-floor(y0)
    y = y0+n
    D = H*y-x
    j = H*n-k
    t = (j+x)/H
    assert 1 <= y < 2 and D == H*n-k-e
    assert j == floor(D+Q(1, 2)) and abs(j-D) == abs(e) < Q(1, 2)
    assert t == y+e/H and t >= 1-Q(1, 2*H) > 0
    assert t-T == n+L*ell and (t-T).denominator == 1
    assert H*t == j+w[hi]*tau
    assert norm(beta*tau) == abs(e)
    C, E = [], []
    for i, (Wi, ui, wi) in enumerate(zip(W, u, w)):
        residual = Wi-H*ui
        shift = Q(residual, H)*e
        margin = norm(wi*tau)
        loss = Q(abs(residual), H)*abs(e)
        lower = margin-loss
        assert loss == abs(shift)
        assert (wi*tau-Wi*T+shift).denominator == 1
        assert Wi*t == ui*j+wi*tau+residual*n+residual*(t-y)
        assert norm(Wi*t) == norm(Wi*T) >= lower >= delta
        assert margin >= Q(1, c+1)
        C.append(margin)
        E.append(lower)
        counts['packet_coordinates'] += 1
    assert C[ai] == C[hi] == h and E[hi] == h and E[ai] == h-abs(b)
    for i, shift in free_data:
        assert C[i] > delta0
        if norm(W[i]*T) < Q(1, 2):
            assert E[i] == norm(W[i]*T)
        else:
            assert E[i] == Q(1, 2)-2*abs(shift) > delta
    if not free:
        assert N == 3 and c == 1 and C == [Q(1, 2), Q(1, 2)]
        counts['N3_no_free'] += 1
    counts['anchor_E_equalities'] += int(E[ai] == delta)
    counts['endpoint_C_equalities'] += int(h == delta0)
    counts['negative_supplied_times'] += int(T < 0)
    counts['packets'] += 1
    record = dict(name=name, W=W, T=str(T), a=a, L=L, m=m, d=d,
                  b=str(b), e=str(e), u=u, w=w, c=c, tau=str(tau),
                  t=str(t), C=list(map(str, C)), E=list(map(str, E)))
    records.append(record)
    return record

# These fixed witnesses are supplied or obtained by explicit reflection/scaling.
r = verify('actual opposite collision rejection', (1,3,4,6), Q(5,12), 1, {3:42, 4:-20})
assert r['L'] == 3 and r['m'] == 22 and r['d'] == 125 and r['e'] == '1/250'
assert r['u'] == [21,42,-19,1] and r['w'] == (125,228,-221,-125)
assert r['tau'] == '-107/250' and r['t'] == '17/12'
assert r['C'] == ['1/2','52/125','103/250','1/2']
assert r['E'] == ['5/12','1/4','1/3','1/2']
assert rejected == [dict(name='actual opposite collision rejection', speed=4, u=-20, w=-228)]
verify('negative boundary witness', (1,3,4), -Q(5,12), 3)
r = verify('N3 exact anchor equality', (2,3), Q(1,6), 2)
assert r['E'] == ['1/3','1/2'] and r['C'] == ['1/2','1/2']
verify('negative half coordinate', (3,6,8), -Q(1,12), 3)
verify('nonprimitive scaled witness', (2,6,8), Q(5,24), 6)
assert gcd(gcd(2,6),8) == 2
verify('tight original free coordinate', (1,4,5,6,7,11), Q(15,49), 5)

# Missing-anchor-premise controls do not claim that all other anchors fail.
assert all(norm(Wi*Q(1,2)) == Q(1,2) for Wi in (1,3,5))
assert norm(6*Q(1,2)) == 0 and not premises((1,3,5), Q(1,2), 1)
counts['zero_b_exclusion_controls'] += 1
assert all(norm(Wi*Q(9,20)) >= Q(1,5) for Wi in (1,3,4,5))
assert norm(5*Q(9,20)) == Q(1,4)
assert norm(6*Q(9,20)) == Q(3,10) > Q(1,4)-Q(1,5)
assert not premises((1,3,4,5), Q(9,20), 1)
counts['bad_selected_anchor_controls'] += 1

assert counts['packets'] == 6 and counts['packet_coordinates'] == 21
assert counts['free_coordinates'] == 9 and counts['candidate_window_integers'] == 100
assert counts['examined_candidates'] == 10 and counts['actual_forbidden_rejections'] == 1
assert counts['negative_supplied_times'] == 2 and counts['N3_no_free'] == 1
assert counts['half_free_coordinates'] == 1 and counts['tight_original_free_coordinates'] == 1
assert counts['anchor_E_equalities'] == 4 and counts['endpoint_C_equalities'] == 4
assert counts['positive_b'] == 2 and counts['negative_b'] == 4
print(json.dumps(dict(author_counts=author_counts, counts=dict(sorted(counts.items())), records=records, rejected=rejected), sort_keys=True, separators=(',', ':')))
```

Run the saved block exactly from the repository root:

```sh
python3 -B - <<'EXACT_AFFINE_UNION_REVIEW'
from pathlib import Path
from hashlib import sha256
from contextlib import redirect_stdout
import io, re
text = Path('research/astra-exact-affine-union-review.md').read_text()
blocks = re.findall(r'^```python\n(.*?)^```[ \t]*$', text, re.M | re.S)
assert len(blocks) == 1
assert sha256(blocks[0].encode()).hexdigest() == '14119c0209df4afcfe4087b22f548b55dce77e8bbc001c0d77da6b3b834c2951'
capture = io.StringIO()
with redirect_stdout(capture):
    exec(compile(blocks[0], 'independent-exact-affine-union-review', 'exec'), {})
assert sha256(capture.getvalue().encode()).hexdigest() == 'facad043b8229753d47f0bafa4759cb4e25b738c1b8b4ff6d7a7f8a8e39f84ec'
print(capture.getvalue(), end='')
EXACT_AFFINE_UNION_REVIEW
```

The replay verifies six independent packets and 21 original comparisons,
nine free-coordinate choices, 100 candidate-window integers, and one actual
forbidden-value rejection among ten examined candidates. Frozen author source,
program, output, and its dependency hashes are enforced. The source's seven
packets and interval certificates are replayed separately within the program.

All owned commands have stopped at final handoff. The accepted result remains
conditional manuscript mathematics; the mixed-to-anchor lemma, uniform union
supply, finite-family supply, and unrestricted kernel-checked goal are outside
this acceptance and are not assumed.
