# Conditional nearest-grid transport and owner-count induction

Task `/root/nearest_grid_audit`, requested in-session Astra/xhigh, 2026-09-05.
Source checkpoint: `808595cf7615d01f849eb071648d8a82ee7c97c1`.
The project configuration, workflow, policy, and active state were read and
`python3 scripts/validate_workflow.py` passed. Only this note is worker-owned.
No Lean build, dependency restoration, Git mutation, or shared-state edit was
performed by this worker. This is an author manuscript awaiting independent
review and formalization, not a kernel proof or an LRC resolution.

**Result.** The root's nearest-grid observation is correct. Its original
condition is `2N >= 3(c+2)`. Using the pivot's own good phase improves this to
`2Np >= (c+2)(2p+q)`, where q is the largest lower speed. Choosing between the
two adjacent grid points improves it further to
`p(N-c-2)(q+s) >= (c+2)qs`, where q>s are the two largest lower speeds.
All three statements require an ordinary witness for the listed lower speeds
and the actual pivot. Smaller-count induction supplies that premise for proper
subfamilies of a minimal positive-integer counterexample. It does not prove
the universal sparse-owner statement or global Prompt95.

## 1. Exact objects and generic transport contract

Write `||x||` for `circleNorm x`. Let N,p be natural numbers with N>=2 and
p>0. Set M=Np and use precisely the repository's candidate and bad sets:

```text
R(N,p) = {r in Z : 0<=r<M and N does not divide r},
B_d    = {r in R(N,p) : min(rd mod M, -rd mod M) < p}.
```

The residue representatives are natural numbers in the Lean definitions.
The integer notation here permits signed rounding before reduction. In
particular `|R|=(N-1)p>0`, and being outside B_d retains the closed boundary
`||d*r/M|| >= 1/N`. The pivot itself is good at every candidate, because
`||p*r/M||=||r/N||>=1/N` when `N` does not divide r.

**Generic nearest transport theorem (settled manuscript contract).** Let C
be any finite labelled set, d:C->Nat with `0<d_i<p`, and t,alpha real.
Suppose

```text
||pt|| >= alpha,
||d_i t|| >= alpha                         for every i in C,
alpha > 1/(2N),
alpha - d_i/(2Np) >= 1/N                  for every i in C.       (T)
```

Then there is `r in R(N,p)` outside every B_(d_i), and the time `r/(Np)`
protects exactly those lower speeds and p at threshold 1/N. This lemma has
no LRC, cardinality, injectivity, maximal-covered-pivot, gcd, or primitivity
premise. For a nonempty C the last inequality already implies
`alpha>=1/N>1/(2N)`, so the separate strict pivot hypothesis is redundant.
An alternative uniform contract assumes q>=0, every `d_i<=q`, and
`alpha-q/(2Np)>=1/N`; this also implies the strict pivot hypothesis even
when C is empty.

**Proof.** Choose any nearest integer z to Mt, with `|z-Mt|<=1/2`, and
put u=z/M. The existing 1-Lipschitz property gives

```text
||d_i u|| >= ||d_i t|| - d_i |u-t|
           >= alpha - d_i/(2Np) >= 1/N.
```

If N divides z, then pu=z/N is an integer. The original pivot would satisfy
`||pt||<=|pt-pu|<=1/(2N)<alpha`, a contradiction. Thus N does not divide z.
Let r be the Euclidean remainder of z modulo the positive integer M, so
`z=r+M h`, with h an integer and `0<=r<M`. Because N divides M,
`N divides z` iff `N divides r`. Moreover `u=r/M+h`, so multiplication by
any listed integer speed changes the phase by an integer. All norms are
unchanged. Thus r is the required natural candidate. This handles negative t
and negative z directly; reducing time modulo one before rounding is optional.

The strict inequality on alpha is used only to exclude a forbidden rounded
integer. At `alpha=1/(2N)` a nearest integer may be a multiple of N; see the
control below. Equality in the last line of (T) is valid because badness is
strict. Positivity of p and N is needed in every division and remainder.

## 2. Correct count and first improvement

Let C have c distinct lower speeds, all positive and below p, and put
`k=c+2`. An ordinary LRC witness for the c+1 moving speeds `C union {p}`
relative to zero is a witness for **k total runners**. Its guaranteed margin
is `alpha=1/k`, not `1/(c+1)` and not `1/N`. The ambient denominator N is
unchanged when taking this subfamily.

First apply Lipschitz to all c+1 speeds using the maximum p. This gives a
candidate and every listed speed good if

```text
1/k - 1/(2N) >= 1/N  <=>  2N >= 3k.                  (A)
```

The pivot's final norm is then positive, which also excludes N dividing z.
Thus the root's original argument is valid including equality.

For nonempty C let q=max(C). The pivot exclusion in (T) instead lets us
spend only the largest lower-speed loss. Its sufficient condition is

```text
1/k - q/(2Np) >= 1/N
    <=> 2Np >= k(2p+q)
    <=> 2p(N-k) >= kq.                                (B)
```

Because q>0, (B) forces N>k, so the pivot exclusion is automatic. No extra
`2N>k` assumption is needed here. Since q<p, (A) implies (B), with a strict
lower-speed margin at equality in (A). The pivot can still finish exactly on
the closed target boundary. Conversely failure of (B) means only that this
uniform nearest-point argument is unavailable.

When `2c<N` and c>=4, integrality gives `N>=2c+1`, whence
`2N>=4c+2>=3c+6=3k`. Thus a supplied ordinary witness proves sparse noncover
throughout this range. This is conditional; no ordinary LRC witness for
arbitrary c has been silently supplied.

## 3. Stronger choice between adjacent candidates

**Two-neighbor theorem.** Suppose c>=2, C has distinct positive integer speeds
below p, q>s are its two largest speeds, and the listed c+1 moving speeds have
a common witness at margin `alpha=1/k`, with k=c+2. If

```text
p(N-k)(q+s) >= kqs,                                   (C)
```

then one of the two integers bracketing Npt, reduced modulo Np, is a candidate
outside every lower bad set. Equality is sufficient. This is the strongest
speed-dependent sufficient condition established in this note; no optimality
or universal witness claim is made.

**Proof.** Condition (C) implies N>k, hence alpha>delta=1/N and N>=3.
If Mt is an integer, its grid point is already a witness. Otherwise let
`z_-=floor(Mt)`, `z_+=z_-+1`, `t_-=z_-/M`, `t_+=z_+/M`, and put
`h_-=t-t_->0`, `h_+=t_+-t>0`, so `h_-+h_+=1/M`.

Write pt=b+f_p with b integral and `f_p in [alpha,1-alpha]`. Then
`Mt=Nb+Nf_p`. Since `Nalpha>1`, both bracketing integers lie strictly between
Nb and N(b+1), so neither is divisible by N. This uses the actual pivot's
original good phase; applying nearest rounding to lower speeds alone would
not prove this fact.

For any lower d write dt=a+f with a integral and
`f in [alpha,1-alpha]`. At the two times, the lifted fractional parts are
`f-dh_-` and `f+dh_+`. As `d/M<1/N=delta<alpha`, both lie strictly between
zero and one: no wrap is hidden in the following endpoint inequalities.
Badness at the left point therefore means `f-dh_-<delta`, and badness at
the right point means `f+dh_+>1-delta`.

The same d cannot be bad at both points. Such simultaneous strict inequalities
would give

```text
d/M = d(h_-+h_+) > 1-2delta,
```

whereas `d/M<delta<=1-2delta` for N>=3. If both grid points fail, there are
therefore **distinct** lower blockers d_L and d_R. Their failures imply

```text
h_- > (alpha-delta)/d_L,
h_+ > (alpha-delta)/d_R.
```

Distinctness and the definition of q>s give
`1/d_L+1/d_R >= 1/q+1/s`. Consequently

```text
1/(Np) > (alpha-delta)(1/d_L+1/d_R)
        >= (1/k-1/N)(1/q+1/s)
        >= 1/(Np),
```

where the last inequality is exactly (C). This contradiction proves that
at least one endpoint is good for all lower speeds. Reduce its signed index
modulo M as in Section 1. The strict failures explain why equality in (C)
still proves the desired closed-boundary conclusion.

Condition (B) implies (C), since `qs/(q+s)<q/2` for s<q. The improvement
can be strict: `N=5, (s,q,p)=(10,15,24)` gives equality in (C) while (B)
fails. A supplied `1/4` witness is t=1/32, and both adjacent candidates work.

The same proof also shows that with **one** lower owner and a supplied 1/3
witness including p, N>=3 suffices: both bracketing candidates are allowed
(the weak `Nalpha>=1` suffices), and a single owner cannot spoil both.
With no lower owner, r=1 works for every N>=2 and p>0. These small cases
are not needed to conceal a missing supplied-witness premise.

## 4. Minimal count: legitimate induction and cover consequences

There is a clean way to use these conditional statements without assuming
unrestricted LRC. Suppose the canonical conjecture is false. The checked
all-dimensional theorem `conjecture_iff_positiveIntegerConjecture` then
supplies a failing positive-integer instance. Choose one with the smallest
number n of moving speeds and put N=n+1. Thus every distinct positive-integer
family with m<n moving speeds has an ordinary margin `1/(m+1)` witness.
This is ordinary well-ordering under a hypothetical counterexample, not an
unproved witness theorem inserted as an axiom.

Fix the maximum speed p of this minimal instance. For any lower-owner set C
of size `c<=N-3`, the c+1 moving speeds `C union {p}` form a **proper**
subfamily, and minimality supplies a witness at `1/(c+2)`. Hence any complete
cover of this maximum pivot by such a C must violate each applicable
sufficient condition above:

```text
2N < 3(c+2),
2p(N-c-2) < (c+2)q                       if c>=1,
p(N-c-2)(q+s) < (c+2)qs                 if c>=2.        (D)
```

In particular every complete cover has

```text
c >= floor(2N/3)-1,                                    (E)
```

for N>=3. For a proper cover this follows from the first strict inequality
in (D). The only remaining size is the full `c=N-2`, which satisfies (E)
arithmetically; it receives no smaller-count witness from minimality. The
speed-sensitive inequalities (D) are asserted only for proper covers.
The full all-other-owner cover must not be fed back into the induction premise.

Moreover, **no sparse complete cover with `2c<N` exists in this minimal
instance**. For c>=4, `c+1<n` and (A) applies as shown in Section 2. For
c=0 the candidate row is nonempty. For c=1,2 the existing `OwnerKernelCover`
theorem with every owner as its own representative gives noncover under
`3c<=N+1`, which holds on their sparse ranges. For c=3, N=7 is the existing
`threeLowerOwner_noncover_seven` case, and N>=8 satisfies (A) (or the old
budget). Thus any complete cover has at least `ceil(N/2)` owners as well.
The checked N=9 four-owner theorem remains an unconditional fixed-N result;
it is not needed as an extra induction premise for c=4 here.

This eliminates sparse covers **conditionally inside a minimal
counterexample**. It does not prove sparse noncover for every independent
choice of N,p,C: a proper-subfamily witness is the crucial extra input.
The inequalities still permit dense covers, in particular the full set of
N-2 lower labels, so they do not contradict existence of the minimal instance.

There is a count bookkeeping distinction concerning the word canonical.
The existing BHK bridge is an all-dimensional equivalence; its exposed
statement does not itself assert that the least failing real-runner count
equals the least failing positive-integer count. The argument above safely
chooses the latter after applying that equivalence. Alternatively, given a
positive-integer counterexample at a runner count N known to be minimal for
the real canonical formulation, the same subfamily induction follows directly.
No unproved count-preserving BHK wrapper is required or claimed here.

## 5. Lower owners, internal owners, and Prompt95 are different contracts

The transport lemmas require only `0<d_i<p`; an owner need not be a covered
pivot. For an arbitrary positive injective family and a maximum **covered**
pivot j, every internal owner is lower: internal means a different covered
label, maximality gives `a_i<=a_j`, and injectivity makes this strict.
Therefore any supplied witness for those internal owners plus j can be used.
Uncovered labels may have speeds above p and receive no protection.

If smaller-count LRC is available up to the relevant c+1 moving speeds, every
internal complete cover satisfying (A), (B), or (C) is impossible. If every
internal owner set falls in that range, internal-cover redundancy is vacuous.
For example, if b is the total number of covered labels, `b<=N-2`, smaller
count supply is available, and `2N>=3(b+1)`, then every internal set has
`c<=b-1` and no internal complete cover exists. The explicit b bound ensures
that the largest such subfamily is proper when using minimal-count supply.

In a hypothetical witness-free full instance, **every pivot is covered**:
an uncovered pivot yields a candidate protecting every other speed and itself,
hence an ordinary witness. Thus the maximum covered pivot is the actual
maximum speed, internal labels are exactly all other labels, and the entire
set is a complete internal cover. Here b=N-1 and that full cover has c=N-2,
precisely where smaller-count supply is unavailable. A residue avoiding a
proper chosen C need not avoid the omitted labels; its existence does not
contradict full coverage.

Global `MaxCoveredPivotInternalCoverRedundancy` (Prompt95) quantifies over
every positive injective family, every maximum covered pivot, and every
internal complete cover. On a nonempty candidate row, the checked
`internalCoverRedundantAt_iff_no_internal_complete_cover` identifies this
coverwise redundancy with absence of any internal complete cover. Neither
ordinary witness supply for one selected smaller subfamily nor the owner-count
obstructions above prove that universal statement. No iteration of deletion
has been shown to reach a forbidden sparse cover: a dense cover can be
inclusion-minimal.

## 6. Decisive exact controls and reproduction

The following is a small rational control suite, not an exhaustive theorem
proof or a search for a counterexample. It checks both nearest tie choices,
negative signed reduction, equality in all three numerical conditions, a
strict improvement of (C) over (B), actual target-boundary equality, failure
of nearest rounding without a sufficient margin, and the strict pivot gate.
No floating-point computations or project verifier imports are used.

```python
from fractions import Fraction as F

def norm(x):
    f = x % 1
    return min(f, 1-f)

def neighbors(x):
    a = x.numerator // x.denominator
    return (a,) if x == a else (a, a+1)

def nearest(x):
    ns = neighbors(x)
    radius = min(abs(F(z)-x) for z in ns)
    return tuple(z for z in ns if abs(F(z)-x) == radius)

def safe(N, p, lower, z):
    r = z % (N*p)
    return r % N != 0 and all(
        norm(F(r*v, N*p)) >= F(1,N) for v in tuple(lower)+(p,))

def original_witness(lower, p, t):
    k = len(lower)+2
    assert all(norm(v*t) >= F(1,k) for v in tuple(lower)+(p,))

# (A) equality: c=4,k=6,N=9. One pivot lands on the target boundary.
N,p,lower,t = 9,5,(1,2,3,4),F(1,6)
original_witness(lower,p,t)
assert 2*N == 3*(len(lower)+2)
assert nearest(N*p*t) == (7,8)
assert all(safe(N,p,lower,z) for z in nearest(N*p*t))
assert norm(F(8,9)) == F(1,9)

# (B) equality with an actual lower-speed endpoint at 1/N.
N,p,lower,t = 5,8,(1,4),F(5,16)
original_witness(lower,p,t)
assert 2*N*p == (len(lower)+2)*(2*p+max(lower))
assert nearest(N*p*t) == (12,13)
assert norm(F(12*4,40)) == F(1,5)
for signed_t in (t,-t,t+2,t-2):
    original_witness(lower,p,signed_t)
    for z in nearest(N*p*signed_t):
        r=z%(N*p)
        assert safe(N,p,lower,z) and 0<=r<N*p
        assert z%N == r%N
        assert all(norm(F(z*v,N*p)) == norm(F(r*v,N*p))
                   for v in lower+(p,))
assert nearest(-N*p*t) == (-13,-12)
assert tuple(z%40 for z in nearest(-N*p*t)) == (27,28)

# (C) equality succeeds while (B) fails.
N,p,lower,t = 5,24,(10,15),F(1,32)
s,q=lower; k=len(lower)+2
original_witness(lower,p,t)
assert p*(N-k)*(q+s) == k*q*s
assert 2*N*p < k*(2*p+q)
assert neighbors(N*p*t) == (3,4)
assert all(safe(N,p,lower,z) for z in neighbors(N*p*t))
assert norm(F(4,5)) == F(1,5)

# No margin for nearest rounding: valid 1/3 witness rounds to a bad lower.
N,p,lower,t = 3,4,(3,),F(1,9)
original_witness(lower,p,t)
assert nearest(N*p*t) == (1,)
assert not safe(N,p,lower,1) and safe(N,p,lower,2)
assert norm(F(3,12)) == F(1,4) < F(1,3)

# Strict pivot exclusion cannot be weakened for every nearest integer.
N,p,t = 4,3,F(1,24)
assert norm(p*t) == F(1,2*N)
assert 0 in nearest(N*p*t) and 0%N == 0

# Condition failure is not nonexistence: this dense partial family is safe.
N,p,lower,t = 8,5,(1,2,3,4),F(1,6)
original_witness(lower,p,t)
s,q=lower[-2:]; k=len(lower)+2
assert p*(N-k)*(q+s) < k*q*s
assert safe(N,p,lower,7) and norm(F(7,8)) == F(1,8)

# Empty and positive-time representative controls, including N=2.
for N in (2,3,9):
    for p in (1,2,17):
        assert safe(N,p,(),1)

print({'nearest_original_equality':'passed',
       'nearest_speed_equality':'passed',
       'two_neighbor_strict_improvement':'passed',
       'signed_and_boundary_controls':'passed',
       'ordinary_witness_supply':'explicit hypothesis only'})
```

## 7. Remaining boundary and next action

The settled first implementation target is the generic transport theorem (T),
using `circleNorm_sub_abs_le_circleNorm`, signed integer rounding, positive
modulus remainder, and the literal `pivotCandidates`/`pivotBadResidues`
bridges. Keep cardinality/LRC assumptions outside that reusable lemma. After
independent review, add a separate ordinary-witness corollary and the
two-neighbor theorem with explicit distinct blockers. Then formalize a
minimal-count positive-integer wrapper that records (D) and (E), with the
proper-subfamily check `c<=N-3` visible in its contract.

The substantive research burden remains dense/all-covered configurations and
how omitted labels constrain the witnesses furnished by deletion. No universal
extension from a proper owner set to all speeds is established. Fixed-order
Riesz and Bonferroni routes were not relaunched. The full unrestricted
canonical conjecture and its negation remain unproved.
