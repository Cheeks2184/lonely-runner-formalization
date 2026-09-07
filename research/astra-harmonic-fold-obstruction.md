# A uniform obstruction to reciprocal-margin fold induction

Root manuscript, source `27309c7e0a0d93c8f9ce90245cec013a3ffcd5d8`.
This is an exact hand proof awaiting independent mathematical review. The
initial bounded Python control located the three-speed base case. The
extension below applies to every moving count; it is not a count-by-count
search or a counterexample to the Lonely Runner Conjecture.

Write `mu(v)=max_t min_i ||v_i*t||_(R/Z)`. The proposed induction rule was
that some normalized global maximizing time `0<t<1/2`, with

    n_i=2*floor(v_i*t)+1,
    w_i=v_i-2*n_i,
    V=primitive positive deduplication of the nonzero |w_i|,
    q=|V|,

would satisfy

    mu(v) >= mu(V)/(1+(d-q)*mu(V)).                         (1)

If valid for all primitive mixed-parity tuples, this would combine with
strict folded height decrease and induction to supply the ordinary LRC
bound. It is false for every `d>=3`, including every count beyond the
established six-total-runner milestone.

## Exact family and the complete set of maximizing choices

Let `H` be any finite set of distinct positive integers and take

    v_H=(1,6,12) together with (198h+1)_(h in H).

There are `d=3+|H|` positive distinct speeds. The tuple is primitive and
mixed parity. Periodicity and reflection reduce ordinary optimization to
`0<=t<=1/2`. The pair of speeds `6,12` always has minimum distance at most
`1/3`: for a fractional part `x` of `6t`, simultaneous distances of `x`
and `2x` at least `1/3` require exactly `x=1/3` or `x=2/3`.

Consequently, any time with margin at least `1/3` must also have
`t>=1/3` because speed `1` is present. Among `6t=k+1/3` or `k+2/3` in
this interval, the only possibilities are

    t_1=7/18,   t_2=4/9.

They both attain margin `1/3` on the base tuple. For an appended speed,

    (198h+1)*t_1=77h+7/18,
    (198h+1)*t_2=88h+4/9.

Thus all appended distances exceed `1/3` at both times. It follows that

    mu(v_H)=1/3,
    {normalized global maximizing times}={7/18,4/9}.       (2)

This proves completeness over all real times, independently of the
critical-time enumeration used by the numerical checker.

## Both folds strictly improve the margin without losing coordinates

At `t_1`, the odd target and raw fold are

    n=(1,5,9) together with (154h+1),
    w=(-1,-4,-6) together with (-110h-1).

At `t_2`, they are

    n=(1,5,11) together with (176h+1),
    w=(-1,-4,-10) together with (-154h-1).

All absolute folded entries are positive and distinct, with gcd one.
In both cases `q=d`; no zero deletion, sign convention, duplicate removal,
or common divisor accounts for the failure of (1). Every appended speed
strictly decreases, as does at least one base speed.

For the first fold, the base tuple `(1,4,6)` has margin exactly `2/5`.
The time `2/5` attains it. A larger margin would, after reflection, force
`2/5<t<=1/2` by speed `1`; but then speed `4` has distance strictly below
`2/5`. Each appended speed `110h+1` has distance exactly `2/5` at the
same witness time. Hence

    mu(V_1)=2/5.                                         (3)

For the second fold, `(1,4,10)` has margin exactly `4/11`, attained at
`t=4/11`. For the upper bound, a hypothetical larger margin forces
`t>4/11` by speed `1` and `t<9/22` by speed `4`, after reflection to
`[0,1/2]`. Then

    40/11 < 10t < 45/11,

so its distance to the integer `4` is strictly below `4/11`. Each appended
speed `154h+1` has fractional part `4/11` at `t=4/11`. Therefore

    mu(V_2)=4/11.                                        (4)

Combining (2)--(4) and `q=d`, both right sides of (1) exceed `1/3`.
Equivalently, the reciprocal discrepancies are exactly

    1/mu(v_H)-1/mu(V_1)-(d-q)=1/2,
    1/mu(v_H)-1/mu(V_2)-(d-q)=1/4.

There are no other maximizing choices to rescue the proposed rule.

## Scope and next mathematical requirement

These tuples satisfy LRC with substantial slack: `1/3>=1/(d+1)` for
every `d>=3`. Their ordinary odd-coset radius is `1/3`, below the
strict-failure threshold `(d-1)/(d+1)`. The result therefore rules out the
unconditional reciprocal-margin induction and any attempted repair merely
requiring a larger count or preserving all folded coordinates. It does
not rule out a lemma using the full strict minimal-failure hypotheses.

Together with the separately reviewed closest-point analysis, this shows
that height decrease and improved folded margin alone do not provide the
missing reverse transfer. A viable fold argument must supply a different
invariant or use additional strict-failure information. No Lean lemma is
proposed for the false rule, and no unrestricted proof/disproof is claimed.

## Numerical provenance and endpoint correction

The initial checker source had SHA-256
`55ec97ee965cebd6e0fe31d836b78f416be3bd27f71592f63b04622808dc9a1c`;
its original receipt had SHA-256
`0e50da097bbd3999b2f1bb956b4ebe0f93ee9cd410b93f98a2faba6658769a32`.
It reported the base `(1,6,12)` and both folds exactly. Root subsequently
identified a generic omission of time `1/2` when a folded tuple has multiple
all-odd speeds. A separate Terra/high repair preserves the original receipt
and corrects that endpoint. Neither fold in this exact counterfamily is
all odd, and the complete hand proof above does not depend on that program
or on the claim that its base was the first searched counterexample.
