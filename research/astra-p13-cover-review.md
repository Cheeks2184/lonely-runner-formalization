# Independent review of the p=13 covering certificate

Date: 2026-09-05. Task: `/root/vanishing_slope-p13-cover-review`, requested
Astra/xhigh. The runtime does not independently expose its model or effort.

**Accepted without corrections.** The certificate proves `tau_13 ≤ 10 < 11`.
It therefore refutes the proposed universal lower bound `tau_p ≥ p-2`, and
refutes universal prime-square-grid supply even with two prime-divisible speeds
and no prime-square-divisible speed. It does not refute LRC or the preceding
strip-count proposition.

## Bound artifact and verification scope

Reviewed all of `research/astra-prime-square-cover-search.md`, SHA-256
`e6564412dab8c0a112b8f88b1f515da72ce158693c0988cf951df8608d9858bf`.
Read the current project configuration, workflow, policy and state, and ran
`python3 scripts/validate_workflow.py` successfully. Only this review note was
written; earlier frozen manuscripts/reviews and all Lean, shared state, cache
and Git files remain unchanged by this task.

The retained certificate is independently verifiable without the discovery
algorithm. The reported seed, swap budget, 3,456 discovery attempts and p=11
budget nonfinding are worker provenance, not independently reproduced facts.
Neither the certificate nor this review needs a search-wide negative result.
There is no Lean theorem or kernel-verification claim for this certificate.

## Complete certificate and consequence

The selected unit speeds and complete tuple are

```text
A = (1,7,8,9,10,17,33,36,64,69)
V = (1,7,8,9,10,17,33,36,64,69,13,26).
```

Thirteen is prime. All ten elements of `A` are units modulo 169. For a unit
speed `a`, its bad set in the unit group is precisely

```text
S(a) = {a⁻¹*d mod 169 : d ∈ {±1,±2,...,±12}}.
```

This inverse-image description is equivalent to distance strictly less than
`13/169=1/13`. Residues `±13` are excluded from the bad target; equality at the
closed boundary is therefore treated correctly. Each displayed set has 24
elements. The independent inverse-set calculation below verifies that their
union has all 156 unit residues, with no missing numerator.

For any nonunit numerator `n=13*q`, speed 13 has phase
`13*n/169=q`, and hence distance zero. Speed 26 does too. Thus all 169 residues
are blocked by the full tuple. A separate exact Fraction scan checks the actual
phases at every grid point, independently of the inverse-set construction.
Integer periodicity extends the conclusion to all integer numerators, including
negative and arbitrarily large ones.

The full tuple has exactly 12 positive distinct speeds, gcd one, exactly two
speeds divisible by 13, and none divisible by 169. These facts match every
hypothesis of the refuted supply proposal. The ten-set cover proves only an
upper bound on `tau_13`; it does not establish the exact minimum. Since
`10=13-3<13-2`, no lower-bound computation is needed to refute the proposed
universal inequality.

The earlier proved strip proposition is unaffected: this tuple has `m=10`
unit rows and its strip lower bound is `13-2*10=-7`, which is vacuous.
The earlier finite result `tau_7=5` is also unaffected. The general covering
question, explicitly left unproved in the frozen supply audit, is now answered
negatively by this separate certificate.

## Strict witness and independent lifts

At time `5/19`, the exact coordinate distances are

```text
(5,3,2,7,7,9,6,9,3,3,8,3)/19.
```

Their minimum is `2/19`, with strict margin
`2/19-1/13=7/247>0`. Thus this tuple has an ordinary strict LRC witness despite
having no witness on the 169-grid. Neither failure for arbitrary moduli nor a
failure of arbitrary real-time existence follows.

Write the last eleven lifted speeds as `W_i=V_i+3211*z_i`, independently for
arbitrary nonnegative integers `z_i`, while keeping the first speed equal to one.
The exact identities `3211=169*19` imply

```text
(W_i-V_i)*(n/169) = 19*z_i*n ∈ Z,
(W_i-V_i)*(5/19)  = 845*z_i   ∈ Z.
```

Therefore every grid distance and every `5/19` witness distance is preserved.
All residues modulo 169 remain unchanged and distinct, so distinctness, the
absence of a 169-divisible speed and the presence of exactly two 13-divisible
speeds persist. Nonnegative lift parameters give positive speeds and the fixed
speed one gives gcd one. This algebra proves the whole unbounded family;
finite coordinate lift tests below are controls, not its justification.

## What the p=11 control establishes

For `B=(1,2,3,5,6,7,8,9)`, the independent inverse-set computation finds exactly
the uncovered unit numerators `(12,32,89,109)` modulo 121. This verifies the
reported retained set, including its four-point deficiency. It does not prove
that this is a globally best eight-set selection, that no cover was available
elsewhere in the unretained search, or any lower bound for `tau_11` beyond
previously justified mathematics. The bounded nonfinding is not used in the
p=13 conclusion.

## Independent direct reproduction

The root's retained exact block was rerun and passed. The independently written
block below instead constructs the bad sets by modular inverses, checks actual
phases using Fractions, verifies the strict witness vector and tests each lift
coordinate separately at large height. It imports no project search code.

```python
# BEGIN INDEPENDENT P13 COVER CONTROLS
from fractions import Fraction as F
from math import gcd

p = 13
modulus = p*p
A = (1,7,8,9,10,17,33,36,64,69)
V = A + (13,26)
units = {n for n in range(modulus) if gcd(n,modulus) == 1}
short = {sign*d % modulus for sign in (-1,1) for d in range(1,p)}
assert len(units) == 156 and len(short) == 24
covers = {a: {(pow(a,-1,modulus)*d) % modulus for d in short} for a in A}
assert len(A) == 10 and all(a % p for a in A)
assert all(len(s) == 24 for s in covers.values())
assert set.union(*covers.values()) == units

def norm(x):
    r = x % 1
    return min(r,1-r)

badrows = {n: tuple(v for v in V if norm(F(n*v,modulus)) < F(1,p))
           for n in range(modulus)}
assert len(badrows) == 169 and all(badrows.values())
assert len(set(V)) == 12 and gcd(*V) == 1 and all(v % modulus for v in V)
assert sum(v % p == 0 for v in V) == 2
assert tuple(norm(F(5*v,19)) for v in V) == tuple(F(d,19) for d in (5,3,2,7,7,9,6,9,3,3,8,3))
assert min(norm(F(5*v,19)) for v in V) == F(2,19) > F(1,13)
lift_cases = 0
for j in range(11):
    zs = [0]*11
    zs[j] = 10**40+j
    W = (1,) + tuple(v+3211*z for v,z in zip(V[1:],zs))
    assert tuple(v % 169 for v in W) == V
    assert tuple(norm(F(5*v,19)) for v in W) == tuple(norm(F(5*v,19)) for v in V)
    assert len(set(W)) == 12 and gcd(*W) == 1
    lift_cases += 1

B = (1,2,3,5,6,7,8,9)
units11 = {n for n in range(121) if n % 11}
short11 = {sign*d % 121 for sign in (-1,1) for d in range(1,11)}
cover11 = set.union(*({pow(b,-1,121)*d % 121 for d in short11} for b in B))
assert sorted(units11-cover11) == [12,32,89,109]
print({'p13_unit_cover': len(set.union(*covers.values())),
       'complete_grid_points': len(badrows),
       'strict_margin': str(F(2,19)-F(1,13)),
       'coordinate_lift_controls': lift_cases,
       'p11_specific_uncovered': sorted(units11-cover11)})
# END INDEPENDENT P13 COVER CONTROLS
```

Successful output:

```text
{'p13_unit_cover': 156, 'complete_grid_points': 169, 'strict_margin': '7/247', 'coordinate_lift_controls': 11, 'p11_specific_uncovered': [12, 32, 89, 109]}
```

The accepted result is an exact computational refutation of the proposed
covering inequality and associated prime-square-grid supply, together with an
explicit strict witness and an algebraic lift family. General weighted-envelope
supply and canonical LRC remain unresolved.
