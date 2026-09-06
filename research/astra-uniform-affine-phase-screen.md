# Uniform short affine phase rescue: exact obstruction

The proposed phase-supply claim is false. It remains false for actual positive,
distinct, primitive integer speeds with a common rational time, a nonzero bad
oriented pivot, an actual upper face, a strict complement seed, and the basic
minimal-counterexample divisor profile. A stronger disjunction that also allows
an undilated shift followed by forward motion fails for every `N >= 9`.
These are failures of a local rescue rule, not counterexamples to LRC.

This is a manuscript proof and exact rational screen, not a Lean result or an
independent review. Only this report is owned. Config, workflow, policy, focused
active state and holds were read; startup workflow validation exited 0. Research
is authorized/in progress at checkpoint `a064347`. No Lean check/edit, cache,
shared-state or Git mutation was performed. Existing failed routes were not
relaunched. Root and this worker independently converged on the prime-denominator
blocker construction; root supplied the final uniform factorial/unit-filler
choice. The small `N=9` certificate below uses this worker's checked fillers.

## Exact target and source boundary

Write `||y|| = min(fract y, 1-fract y)` and `delta=1/N`. The proposed relaxation is

> For every integer `N >= 4`, every `x : Fin (N-2) -> R` and
> `r : Fin (N-2) -> Z/N`, if `delta <= x_j <= 1-delta` for all `j`, and
> some `x_h=1-delta`, then there are common integers `2 <= a < N` and
> `0 <= b < N` such that `||a*x_j + b*r_j/N|| >= delta` for every `j`.

The residue representatives do not affect the norm. The desired actual-speed
instance has `N-1` positive speeds, a distinguished label `p` with `N | v_p`,
`x_j=fract(t*v_j)` and `r_j=v_j mod N` on the `N-2` complement labels, and
`0 < fract(t*v_p) < delta`. These data give the exact identity

`fract((a*t+b/N)*v_j) = fract(a*x_j+b*r_j/N)`.

It follows by subtracting the integer `a*floor(t*v_j)+b*(v_j-r_j)/N`.
No independent choice of coordinate phases is needed or justified in this
instance. The `N=6` specialization is `fract_sixth_affine_time`.

`reciprocal_dilate_shift_improves` proves, for every `2<=a<N` and every integer
`b`, that this transformed time strictly increases the pivot norm. However,
the contradiction requires its complement to remain safe **and** the original
time to maximize the pivot norm over the entire all-real complement-safe set.
`exists_oriented_complement_maximizer` provides that global condition, as well
as `0<t<1`, oriented badness and an actual upper face, under a strict seed and
a missing full witness. Removing the global condition is a substantive loss.

The signed sixth-phase results are not the relaxation above: they have three
typed coordinates, restricted signed weights, and alternatives involving
strict undilated shifts. `SixRunnerOrdinary` obtains its special divisor cases
under a missing-witness assumption before applying their assembled witnesses.
Those finite theorems do not supply arbitrary residue profiles for arbitrary N.

## Exact common-time arithmetic

An actual upper face at positive integer speed `v_h` forces

`t = (N*m-1)/(N*v_h)` for an integer `m`.

In reduced form `t=A/Q`, with `Q>0` and `gcd(A,Q)=1`, necessarily `N | Q` and
`gcd(A,N)=1`: the numerator `N*m-1` is coprime to N, so reduction cannot remove
the N factor from the denominator. In the normalized interval `0<t<1`, take
`0<A<Q`. Put `z_j=Q*x_j`. Exact compatibility is

`z_j` is an integer, `0<=z_j<Q`, and `z_j = A*r_j (mod N)`.

Conversely, for fixed such `A,Q`, these conditions are sufficient for positive
integer speeds with the specified phases and residues. Choose the unique speed
class `v_j=A^{-1}*z_j (mod Q)` and take positive lifts; distinct lifts can make
the speeds pairwise distinct. This converse does not automatically give a
primitive tuple or global maximality.

For an N-divisible pivot, its phase numerator `z_p` must itself be divisible
by N. Nonzero badness is exactly `0<z_p<Q/N`; in particular it requires
`Q>N^2`. Thus arbitrary phase/residue pairs are not all realizable. The
certificates below satisfy the actual common-time relation, so restoring this
lost relation cannot repair the false supply claim.

## Small certificates and the necessary stronger screen

Already `N=5`, `t=1/30`, and speeds `(p,complement)=(5;24,15,10)` refute the
relaxation with actual arithmetic: complement phases `(4/5,1/2,1/3)` and
residues `(4,0,0)` are safe; `24` is the upper face and the pivot phase is
`1/6<1/5`. The speed 15 blocks `a=2,4`, and 10 blocks `a=3`, for every b.
This primitive example has three 5-divisible speeds and therefore fails the
stronger deletion/divisor profile. It is only a first diagnostic.

At `N=7`, take `t=1/210` and `(7;105,70,42,180,60)`. The three zero-residue
phases `1/2,1/3,1/5` block all `a=2,...,6`, while the remaining phases are
`6/7,2/7`. This example satisfies the stronger profile. But `a=1,b=2` sends
the complement phases to `(1/2,1/3,1/5,2/7,3/7)`, all strictly safe.
Therefore the dilation-only obstruction does not by itself refute a full
Renault-style alternative. Its independent full witness is `u=1/49`, with
norms `(1/7,1/7,3/7,1/7,16/49,11/49)`.

For the full screen, allow this more generous forward alternative:

* either `2<=a<N`, `0<=b<N`, and all complement norms at `a*t+b/N` are
  at least `delta`;
* or `a=1`, `0<=b<N`, and all actual complement fractional phases at
  `t+b/N` lie in `[delta,1-delta)`.

The second clause permits lower endpoints and is sufficient for forward
improvement while the pivot is oriented and bad. It is weaker than requiring
all complement norms strictly greater than delta. Refuting it therefore also
refutes the strict-shift variant.

An exact full-rescue counterexample is

`N=9, t=1/5670, v=(9;2835,1890,1134,810,5040,631,632)`.

| Speed | Phase at t | Residue mod 9 | Role |
| --- | --- | --- | --- |
| 9 | 1/630 | 0 | Oriented bad pivot |
| 2835 | 1/2 | 0 | Blocks even a |
| 1890 | 1/3 | 0 | Blocks a divisible by 3 |
| 1134 | 1/5 | 0 | Blocks a=5 |
| 810 | 1/7 | 0 | Blocks a=7 |
| 5040 | 8/9 | 0 | Fixed upper face |
| 631 | 631/5670 | 1 | Strictly safe free label |
| 632 | 316/2835 | 2 | Strictly safe free label |

Every integer `2<=a<=8` has a prime divisor in `{2,3,5,7}`. The corresponding
blocker has phase `1/q` and a 9-divisible speed, so its transformed phase is
an integer for every b. Its norm is zero, strictly below the closed threshold.
For `a=1`, the 9-divisible upper label always has fractional phase `8/9`.
Thus every candidate in both clauses fails. There are no approximate endpoint
comparisons in this argument.

All eight speeds are positive and distinct. The gcd of every seven-speed
deletion is 1. Consequently, for **every** integer `ell>=2`, at most six
speeds are ell-divisible: seven such speeds would form a deletion whose gcd
was divisible by ell. Counts for `ell=2,...,9` are `(5,6,2,4,4,4,2,6)`, so
all those denominators are covered. These are exactly the basic nonempty
divisor cover and codimension-one upper-count constraints, not assumed
missing-witness or minimality conclusions.

All complement phases except the upper face are strictly between `1/9` and
`8/9`. The time `t-1/100000000` is an exact strict complement seed. By
continuity of these finitely many positive-speed affine phases, sufficiently
small negative motion keeps every complement strictly safe, while sufficiently
small positive motion immediately violates the upper face. The pivot phase
stays in `(0,1/2)` and increases strictly with time. Hence t is a strict local
maximum of the pivot norm relative to the complement-safe set.

It is explicitly **not** a global maximum: at `u=6/13`, the full tuple has
norms `(2,6,4,5,2,2,3,4)/13`, all greater than `1/9`, and the pivot norm
`2/13` is greater than `1/630`. This full witness was found after 42 exact
checks in the declared finite denominator range `2..300`; the certificate
itself is verified directly below. No globally bad maximum was searched for
or presumed in the refutation.

There is also a positive affine control outside the proposed slope range:
`a=11,b=0` increases the pivot norm to `11/630` while all actual complement
phases lie in `[1/9,8/9)`. Its full norm vector is
`(11/630,1/2,1/3,1/5,3/7,2/9,1271/5670,641/2835)`.
This root-supplied exact control shows why the restriction `a<N` matters;
the pivot-improvement API's finite interval is sufficient, not necessary.

## Uniform analytic family, for every N >= 9

Let `L=N!`, `Q=N*L`, `t=1/Q`, and let P be the primes less than N. Write
`k=|P|` and `s=N-k-3`. Define exactly `N-1` speeds:

* the pivot N;
* one speed `Q/q` for every `q in P`;
* the upper-face speed `(N-1)*L`;
* s free speeds `L+j` for `1<=j<=s-1`, together with `L+N-1`.

Since `1,4,6,8` are four nonprime members of `1,...,N-1`, `k<=N-5` and
`s>=2`. Also `k>=2`, so the listed free indices are distinct and less than
N-1 except for the explicitly last index. The elementary bound `N!>N^2`
for `N>=9` follows already from `4!>4^2` and induction.

The main speeds are distinct. Each blocker is at least `N*L/(N-1)`, which
is greater than `L+N-1` because `L>(N-1)^2`; hence no blocker equals a free
speed. The upper face is larger than every blocker and free speed, and N is
smaller than all of them. Thus the complete tuple is positive and injective.

All blockers and the upper face are N-divisible. The pivot phase is
`1/L`, strictly between 0 and `1/N`. Blocker phases are `1/q`, which lie
strictly between `1/N` and `1-1/N`; the upper phase is exactly `1-1/N`.
Every free phase is `1/N+j/(N*L)` for `1<=j<=N-1`, also strictly inside
the band. This gives actual common-time compatibility and, as above, a
strict seed on the left and a strict local constrained maximum.

For every `2<=a<N`, some prime q divides a. Its blocker is transformed to
`a/q+b*(L/q)`, an integer for every integer b. For `a=1`, the upper speed
is N-divisible, so its upper phase is fixed by every b/N shift. This proves
failure of both short affine rescue clauses for every N>=9, with no finite
enumeration or unproved prime-distribution estimate.

The arithmetic profile also holds uniformly. The upper speed is divisible
by every integer from 2 through N because each divides L. For every deletion
other than the pivot, one of `L+1,L+N-1` remains along with the pivot N, and
is coprime to N. If the pivot is deleted, `L+1` and the blocker `Q/2` remain:
`gcd(L+1,N*L)=1` since `N|L`, so their gcd is 1 as well. Therefore every
deletion has gcd 1, the tuple is primitive, and every ell>=2 divides at most
N-3 speeds. This proves that adding these admissible divisor conditions does
not repair either local phase rule. No claim is made that these tuples are
minimal counterexamples or that all arithmetic conditions implied by a
missing global witness have been exhausted.

## Consequence and Lean value

The failed rules lose global optimization information. Exact phase/residue
compatibility, divisor cover, primitivity, every-deletion gcd 1 and even a
strict local constrained maximum do not restore it. At N=6 the special
divisor classification and three-coordinate signed phase alternatives carry
additional information; a general proof needs a new argument retaining
global maximality, a different candidate family, or a stronger independently
proved structural restriction. Merely assuming the desired rescuing candidate
exists would be the missing conclusion again.

This does not refute all rational shifts, larger dilations, choices of another
pivot, or any mechanism that genuinely uses global maximality. In particular,
the small witness above demonstrates the distinction from LRC directly.
Finite N values here screen one uniform mechanism; they are not new runner-count
milestones or a replacement roadmap after the canonical six-runner result.

The general affine fractional-part transport is a modest reusable Lean lemma,
following the existing sixth-specific proof. The finite N=9 countercertificate
would also be straightforward exact Lean arithmetic if needed as a durable
guard. Neither it nor a formalized false-rule family supplies unrestricted LRC;
no implementation is recommended merely to enlarge the theorem inventory.

## Source bindings and reproducibility

The actual source contracts and needed proofs were read at these hashes:

| Source | SHA-256 |
| --- | --- |
| `LonelyRunner/ConstrainedMaximizer.lean` | `2ef07e6b83b8675a22184571c31d2a71dab9d5c072e3cd165cb8382957b46e92` |
| `LonelyRunner/SixRunnerOrdinary.lean` | `8da5bb6f35373ab4da8d0ab8e2a1040376a74b028efdc7e00d006ee91eb25755` |
| `LonelyRunner/SixthAffinePhase.lean` | `76e420713079ec0c3979e9b169cd78ecb6a932d6dc790ea7d9711adbb64b7d4b` |
| `LonelyRunner/SignedRemainingPhase.lean` | `f75e742e3b0109fc9b1e23818dcc4873e1d824395171adbc4188da862050597c` |
| `LonelyRunner/SixTotalDivisorCounts.lean` | `0b62ef724eb8c24db4085e247e9f16f650ec450291c7ccac2b0ad0981f148727` |
| `LonelyRunner/RationalShiftInsertion.lean` | `6ab6e77e8f5edcdc2a2d242fb2616327004b376496616f46896303a06876db23` |
| `LonelyRunner/SmallDenominatorWitness.lean` | `1570a359100594f4a5589588e3b32674dc2d54d60e500df1d47aca64c2faf95f` |

The following standard-library-only reproducer retains no generated artifact.
Its eight factorial controls `N=9..16` illustrate the proved uniform formula;
they are not evidence for an unbounded assertion by extrapolation. It checks
1,192 affine candidates and 92 deletion gcds in that family, plus the three
small certificates. The first exact controls exited 0; the persisted block
was then executed directly from this report and also exited 0.

```python
from fractions import Fraction as F
from functools import reduce
from math import factorial, gcd

def norm(y):
    z = y % 1
    return min(z, 1-z)

def no_dilate(N, t, v):
    return all(any(norm((a*t+F(b,N))*d) < F(1,N) for d in v[1:])
               for a in range(2,N) for b in range(N))

v5 = (5,24,15,10)
assert no_dilate(5,F(1,30),v5)
assert [F(d,30) % 1 for d in v5] == [F(1,6),F(4,5),F(1,2),F(1,3)]

v7 = (7,105,70,42,180,60)
assert no_dilate(7,F(1,210),v7)
assert all(norm((F(1,210)+F(2,7))*d)>F(1,7) for d in v7[1:])
assert all(norm(F(d,49))>=F(1,7) for d in v7)

N, t = 9, F(1,5670)
v = (9,2835,1890,1134,810,5040,631,632)
assert len(v)==N-1 and len(set(v))==N-1 and min(v)>0
assert 0 < (t*v[0]) % 1 < F(1,N) and v[0] % N == 0
assert all(F(1,N)<=t*d<=1-F(1,N) for d in v[1:])
assert no_dilate(N,t,v)
assert all(((t+F(b,N))*5040) % 1 == F(8,9) for b in range(N))
assert all(reduce(gcd,v[:j]+v[j+1:])==1 for j in range(len(v)))
assert [sum(d%q==0 for d in v) for q in range(2,10)] == [5,6,2,4,4,4,2,6]
assert all(norm((t-F(1,100000000))*d)>F(1,N) for d in v[1:])
assert [norm(F(6,13)*d) for d in v] == [F(k,13) for k in (2,6,4,5,2,2,3,4)]
assert all(norm(F(6,13)*d)>F(1,N) for d in v)
assert all(F(1,N)<=(11*t*d)%1<1-F(1,N) for d in v[1:])
assert [norm(11*t*d) for d in v] == [F(11,630),F(1,2),F(1,3),F(1,5),
                                     F(3,7),F(2,9),F(1271,5670),F(641,2835)]
assert norm(11*t*v[0])>norm(t*v[0])

affine_checks = deletion_checks = 0
for N in range(9,17):
    L = factorial(N)
    Q, t = N*L, F(1,N*L)
    P = [p for p in range(2,N) if all(p%d for d in range(2,p))]
    s = N-len(P)-3
    free = [L+j for j in range(1,s)]+[L+N-1]
    v = [N]+[Q//p for p in P]+[(N-1)*L]+free
    h = 1+len(P)
    assert s>=2 and L>N*N and len(v)==N-1 and len(set(v))==N-1
    assert min(v)>0 and 0<t*v[0]<F(1,N)
    assert t*v[h]==1-F(1,N) and v[h]%N==0
    assert all(F(1,N)<t*d<1-F(1,N)
               for j,d in enumerate(v) if j not in (0,h))
    for j in range(len(v)):
        deletion_checks += 1
        assert reduce(gcd,v[:j]+v[j+1:])==1
    assert all(any(d%q==0 for d in v) for q in range(2,N+1))
    for a in range(2,N):
        for b in range(N):
            affine_checks += 1
            assert any(norm((a*t+F(b,N))*d)<F(1,N) for d in v[1:])
    for b in range(N):
        affine_checks += 1
        assert ((t+F(b,N))*v[h]) % 1 == 1-F(1,N)
assert (affine_checks,deletion_checks)==(1192,92)
print("exact phase screen passed: 3 small certificates; 8 family controls; "
      "1192 affine candidates; 92 deletion gcds")
```

Task metrics: no Lean checks or repair rounds; source/implementation repair
metrics are not applicable. Per-task elapsed time and model token usage were
not exposed or measured and remain null. No external mathematical result or
web source was used. The memory quick pass found no relevant project entry.
