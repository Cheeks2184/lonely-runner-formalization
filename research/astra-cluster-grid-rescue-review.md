# Independent review of the narrow-cluster grid witness

**Accepted as a manuscript theorem; no correction required.** The stated
class has an actual ordinary adapted-grid witness at full arity, with every
fractional phase in the forward band `[1/N,1-1/N)`. The residue lemma and
its common-time realization are valid for every integer `N>=5`. This is a
uniform sufficient class, not unrestricted LRC or a reduction of all tuples
to that class. The proof is independent of the separate revisiting-repair
manuscript and any asserted failure of that algorithm.

Review date: 2026-09-06. Requested route: the existing independent Astra/xhigh
session. Source checkpoint:
`737ac0634c02c21025bcafebacc97c9152f04bf4`.
The complete root-authored source reviewed is
`research/astra-cluster-grid-rescue.md`, SHA-256
`edc948e31d6939132dd44dec7fe84612912ab952ceb8e98140a6b9cb2e9b5f9c`.
That file was read in full and its hash matched the frozen assignment.

For the comparison only, I read the exact reciprocal-tail contract and its
ordering argument in sections 1 and its separation consequence of
`research/astra-forward-grid-uniform-supply.md`, SHA-256
`1a13ab3fab7652987d2494d1a799d8ee21857a5faca972d687b0c99c9017e8e2`.
The optional old-arity composition refers to the already reviewed
`research/astra-forward-grid-insertion.md`, whose read-back SHA-256 is
`b1185bc69414dbb6dfa36bc04ed2a80f92b75856867190015b19c53216babb33`.
Neither dependency is needed to prove the cluster witness itself.

## 1. Exact theorem scope

Fix an integer `N>=5`. The full tuple consists of `N-1` distinct positive
integer speeds

`1, M+c_1, ..., M+c_b`, where `b=N-2`.

Here M is a positive integer, all offsets c_i are nonnegative integers,
at least one c_i is zero, and `H=max_i c_i`. The zero offset ensures that
M is an actual speed and is the least fast speed. Distinctness of the
actual speeds makes the offsets distinct as integers; their residues
modulo N need not be distinct. Assume

`M > (N-1) max(H,1)`.                                (C)

In particular `M>N-1` and `M>(N-1)H`. Thus M differs from the unit speed,
and the time construction can use their two separate grid coordinates.
The conclusion is the existence of digits for the ordinary zero-offset
adapted N-grid, with all but these two coordinates zero, such that every
one of the `N-1` moving labels has fractional phase in `[1/N,1-1/N)`.
Consequently every label has circle norm at least `1/N` at one common
positive time. The stationary reference runner is implicit in this usual
ordinary formulation, so the total count is N.

The proof remains valid for `1<=b<=N-2` with the same hypotheses, including
an actual zero-offset fast anchor. That smaller-arity statement keeps N
as its target denominator. No stronger own-margin target is inferred.

## 2. The finite residue lemma

Let `R` be a subset of `Z/N`, with `0 in R` and `|R|<=N-2`. The required
conclusion is a common residue B and an integer `1<=k<=N-2` for which

`k r+B` belongs to neither `{0,-1}`, for every `r in R`. (R)

For prime N, the complement of R contains distinct residues a and b.
Both are nonzero because zero belongs to R. Their difference is nonzero,
so it has an inverse in `Z/N`. Set

`k=(a-b)^(-1)` and `B=-k a`.

Then the affine map `r -> k r+B` sends a to zero and b to minus one,
since `k(b-a)=-1`. Multiplication by k is a bijection, so these are the
unique preimages of the two forbidden residues. Both preimages lie outside
R, proving avoidance.

The modular value of k is nonzero. Swapping a and b replaces k by minus k
and replaces B accordingly, while still placing the two missing residues
at zero and minus one. At least one orientation has `k != -1`: if both
k and minus k were minus one, then `1=-1` in `Z/N`, which would force
`N|2`, impossible for `N>=5`. The nonzero representative of the chosen
k is therefore in `{1,...,N-2}`. Finally, `0 in R` implies that B itself
is not a forbidden residue. No independent B is chosen for different labels.

For composite `N>=5`, write `N=a d` with `2<=a<=d`. The larger factor
d is at least three, since `a=d=2` would give N=4. Also

`d <= N/2 <= N-2`.

Thus d is a proper divisor in the required digit range. Choose the integer
`k=d` and residue `B=1`. Reduction modulo d is well-defined on `Z/N`,
since `d|N`. Every value `d r+1` reduces to 1 modulo d, whereas zero
reduces to 0 and minus one reduces to `d-1`. The residues 0, 1, and d-1
are distinct because `d>=3`. Therefore neither forbidden value can occur.
This branch indeed needs neither the size bound nor the zero-membership
hypothesis on R. It does not require k to be invertible modulo N.

The branches exhaust all N in the stated domain. The prime proof uses the
two missing residues, while the composite proof uses a noninvertible
multiplier deliberately; a demand for an invertible k in both branches
would alter the theorem and is unnecessary for the actual grid.

## 3. Exact realization and every phase endpoint

Take R to be the image of the offsets c_i under reduction modulo N.
Its cardinality is at most b, even if several offsets have the same
residue, and its zero residue comes from the actual zero offset. Hence
the lemma supplies one k and one B valid for all the fast labels.

Choose the representative `ell in {0,...,N-1}` of `B-k M` modulo N and
set

`t = k/N + ell/(N M)`.

The first summand uses digit k at speed 1; the second uses digit ell at
the actual speed M. Both digits are within `{0,...,N-1}`. All remaining
digits are zero. This is exactly an ordinary adapted-grid time, including
when ell is zero, and it is positive because k is positive.

For a fast label, direct multiplication gives

`(M+c_i)t = (k M+k c_i+ell)/N + c_i ell/(N M)`.

The numerator in parentheses is an integer. Its residue modulo N is
`k c_i+B`, with representative `q_i in {1,...,N-2}` by (R). Write its
integer quotient separately. The only remaining phase contribution is

`e_i=c_i ell/(N M)`.

Because all offsets and ell are nonnegative,

`0 <= e_i <= H(N-1)/(N M) < 1/N`.

The strict upper bound follows directly from `(N-1)H<M`, which (C)
implies even if H is zero. Consequently

`1/N <= q_i/N+e_i < (N-1)/N < 1`.

This expression is already in `[0,1)`, so it is the actual fractional
phase; no wrap or additional branch of the circle norm is being ignored.
The lower equality is permitted, including for the zero-offset anchor.
The upper equality is excluded even at the maximal residue `q_i=N-2`
and maximal digit `ell=N-1`. Setting ell to zero causes no problem:
it simply removes the nonnegative phase errors.

For the unit label, `ell<=N-1<M` implies

`0 <= ell/(N M) < 1/N`.

Together with `1<=k<=N-2`, this gives

`1/N <= k/N <= t < (k+1)/N <= (N-1)/N < 1`.

Thus the unit fractional phase also lies in the exact forward band.
The construction has verified every actual moving label, not merely its
nominal residue before the errors are added. The integer M appears in
the choice of ell and is absorbed there; the proof never assumes `N|M`,
nor does it impose divisibility of any offset by N.

The orientation restriction `k!=N-1` has a concrete purpose: it gives the
unit speed room for its nonnegative extra phase. The prohibition of the
fast residue `-1` has the same purpose for each fast speed. These two
strict upper bounds are retained throughout the proof.

## 4. Comparison with the reciprocal-tail class

The earlier sufficient condition for a displayed order of positive speeds
u_1,...,u_m is

`(N-1) sum_(j>i) u_i/u_j <= N-3` for every i.         (S)

For the full cluster tuple in increasing order, the two largest speeds are
fast speeds, since `b=N-2>=3` and `M>N-1>1`. Denote them by x<y. Then
`x>=M` and `y<=M+H`, so

`x/y >= M/(M+H) > (N-1)/N`.

The strict inequality follows from `H/M<1/(N-1)`. Also

`(N-1)/N - (N-3)/(N-1) = (N+1)/(N(N-1)) > 0`.

At the penultimate position the tail contains exactly y. Thus the ratio
x/y is strictly larger than `(N-3)/(N-1)`, contradicting (S).

Nor can another order of this same tuple satisfy (S): for any i<j, the
positive term `u_i/u_j` is at most the tail sum, and that sum is bounded
by `(N-3)/(N-1)<1`. Hence (S) forces every earlier speed to be strictly
smaller than every later speed. The only possible order of the distinct
speeds is increasing, which has just failed at its final pair.

The claimed comparison is therefore valid as a statement about the two
sufficient hypotheses. It does not say that the cluster class lacks other
known witness methods, or that every tuple outside (S) belongs to (C).
No arbitrary partition or induction supply is established by this comparison.

## 5. Motivation, smaller arity, and independence

If there are `N-3` fast labels together with the unit label, the same proof
gives an old forward-good assignment for `m=N-2`. This is the exact type
needed by the separately reviewed commensurate insertion theorem. At full
arity the present construction already gives the witness directly, without
inserting any additional speed or using that dependency.

The author's motivating offsets `0` or `N^4+r` with integer `r<N` have
`H<=N^4+N-1`, provided the original nonnegativity hypothesis is retained.
For `N>=5`,

`N^4+N-1 < N^5`,

since `N^5-(N^4+N-1)=(N-1)(N^4-1)>0`. Therefore

`(N-1)(N^4+N-1) < N^6 < N^8`.

Thus `M=N^8` satisfies (C) for that stated cluster form; the maximum with
1 is harmless because `N^4+N-1>=1`. This verifies the numerical scale
comparison as an algebraic implication, with no finite experiment.

No assertion about the separate repair algorithm is used in the residue
lemma, digit selection, or endpoint bounds. In particular, a failure to
find a witness while keeping a previously selected unit digit fixed would
not conflict with this construction: it selects the initial digit k from
the full offset residue set. This review does not accept or refute that
other algorithm's failure claim, execution trace, or manuscript.

## 6. Verification and disposition

The complete frozen cluster source was checked by hand, including the
prime inverse and orientation, composite divisor range, repeated residues,
actual grid realization, included lower and excluded upper endpoints,
absence of an `N|M` premise, full arity, and the exact tail comparison.
No mathematical defect or required author correction was found.

The result is an independently reviewed manuscript sufficient class with
an explicit two-digit witness. It remains neither kernel-certified nor an
unrestricted proof. General positive integer tuples may have no unit speed,
may have several widely distributed clusters, or may fail (C); there is no
proved reduction placing them in this class. The report appropriately does
not queue Lean work without a broader use for the lemma.

Project configuration, workflow, policy, and focused active state were read.
`python3 scripts/validate_workflow.py` exited 0 with complete output:

```text
workflow structural validation passed; it cannot certify mathematical validity.
```

Source bindings were read back with `sha256sum`. No mathematical program,
search, external literature claim, Lean check, Git operation, cache change,
shared-state edit, or delegation was performed. Administrative JSON reading
and the structural validator are not mathematical evidence. Only this owned
review file was written. Actual per-task elapsed time, token usage, and
independently exposed runtime model metadata are unavailable and remain null.
No owned process remains, and this task needs no `.lake` or dependency source.
