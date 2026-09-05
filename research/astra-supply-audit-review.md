# Independent review of the weighted supply audit

Date: 2026-09-05. Task: `/root/vanishing_slope-supply-audit-review`, requested
Astra/xhigh. Runtime model and effort are not independently exposed; no runtime
provenance claim is inferred from the routing record.

**Accepted without manuscript corrections.** The uniform strip-count proposition
is proved with its stated hypotheses. The complete 49-grid obstruction and its
unbounded lifts are valid, while both displayed strict witnesses establish that
this is a failure of the selected grid, not of LRC. The exact finite computation
establishes `tau_7 = 5`; the proposed bound for general primes remains unproved.

## Artifact and scope

The entire reviewed artifact is `research/astra-weighted-supply-audit.md`,
SHA-256 `64939cae6b8d1019970feb91a4906595e2f0c30472f6485c0d6ae0235da48ee6`.
The current project configuration, workflow, policy and state were read, and
`python3 scripts/validate_workflow.py` passed. This review writes only this note.
Earlier frozen review files, Lean sources, shared state, Git and caches are
unchanged by this task. No Lean declaration or Lean verification is claimed for
the new manuscript results.

The author reproducer was read and rerun successfully. Its reported results
were exactly 1,622 strip fixtures; 120 three-class controls at `p=5` and 5,985
four-class controls at `p=7`; and 171/1,176 two-outlier controls at `p=7,11`.
These finite domains are accurately described and do not establish a theorem at
other primes or arbitrary moduli.

## Strip count: complete quantifiers and closed boundary

Fix an odd prime `p`, an arbitrary finite list of positive integer speeds with
no speed divisible by `p²`, and a fixed `1 ≤ j ≤ p-1`. Consider all `p` times

```text
t_k = k/p + j/p²,       0 ≤ k < p.
```

If `v=p*q`, the hypothesis excludes `p|q`. Thus `v*t_k=q*k+q*j/p` has a
nonzero residue with denominator `p`, and its distance is at least `1/p` for
every `k`. If `p∤v`, write `v*j=p*q+e`, where `1≤e≤p-1`. Reducing `v*k+q`
modulo `p` to `h` gives the fractional phase `(h+e/p)/p`. For `h=0` it is
strictly below `1/p`; for `h=p-1` it is strictly above `1-1/p`. For every
`1≤h≤p-2`, it lies within the closed good interval. As multiplication by `v`
permutes the residues modulo `p`, exactly two values of `k` are bad for this row.

Taking the union of bad choices for the `m` unit rows proves that at least
`p-2m` choices remain. This integer lower bound is vacuous when negative.
Multiplicity causes no difficulty: repeated bad sets only make the union
smaller. There is no restriction on list length; the empty list gives all `p`
choices and a list consisting entirely of automatic rows does likewise. The
assumption excluding `p²|v` is necessary for a positive bound of this kind,
since such a speed vanishes at every grid point.

The strips have distinct residues `j mod p`, so their positive lower bounds add
to `(p-1)(p-2m)`. For exactly `p-1` labels, at least `(p-1)/2` divisible labels
imply `m≤(p-1)/2`. These statements require neither distinctness, primitivity
nor a height bound. Separately, if there are no divisible labels, `1/p` is a
witness for every row without any restriction on `m`.

This is an actual sufficient input condition, not an assumption that an affine
witness already exists. It counts `k=0` as well. In the homogeneous presentation,
every `k` can be written as a sum of two nonzero residues: choose `r0` outside
`{0,k}` and set `s=k-r0`; the odd prime has at least three elements. Thus the
use of the full set of `k` does not silently lose the zero sum.

## Exact obstruction and lift family

For `V=(1,3,4,5,18,7)`, positivity, distinctness and gcd one are immediate, and
none of its speeds is divisible by 49. At zero all rows fail. For numerators
1 through 24, the manuscript's six disjoint lists cover every numerator once;
direct multiplication confirms every listed distance is strictly less than 7.
Reflection preserves distance, so these lists cover every remaining nonzero
residue as well. Integer periodicity then proves failure for every integer
numerator, including negative or arbitrarily large ones.

The fixed-strip example `(2,3,12,8,7,14)` has a different scope. Its seven
listed blockers rule out exactly the strip `n=7k+1`; a complete independent
Fraction check gives good 49-grid numerators
`[5,9,10,11,38,39,40,44]`. In particular, numerator 5 uses `k=0` and is good.
That example alone does not rule out the enlarged grid. The second tuple's
complete partition supplies the stronger grid obstruction.

For the second tuple, the strict witness distances are exactly

```text
t = 5/11:     (5,4,2,3,2,2)/11,       minimum 2/11 > 1/7;
t = 156/343:  (156,125,62,94,64,63)/343, minimum 62/343 > 1/7.
```

Adding `539*z_i` independently to the last five speeds leaves every residue
modulo 49 unchanged and adds an integer phase `245*z_i` at time `5/11`.
Distinct residues guarantee distinct speeds regardless of their ordering or
height; the fixed speed 1 guarantees gcd one. Nonnegative lift parameters retain
positivity, and no lifted speed becomes divisible by 49. Thus the obstruction
and strict `5/11` witness hold for the whole stated unbounded family. The claim
does not require the `156/343` witness to survive those lifts.

## Transport and the precise limit of the obstruction

From `p*r=M*r0+beta` and `beta/M=j/p` with integral `j`, the time satisfies

```text
s/p+r/M = (s+r0)/p+j/p².
```

This algebra puts the time on the `p²` grid regardless of the external modulus
whenever the stipulated integral parameters exist. Choosing a multiple of `p²`
for `M` supplies such parameters explicitly; increasing it does not refine the
grid. Allowing every integral `j` includes the nonunit numerators too, and the
full 49-point obstruction already covers them.

Under the precise original-speed congruence
`W_i = sign_i*b*V_i (mod p*M)`, the extra phase at the grid time is an integer
because `(p*M)*t=s*M+p*r`. Therefore circle distance for `W_i*t` is that for
`V_i*(b*t)`. With integer `b`, `b*t` still lies on the `p²` grid; independent
signs do not change the distance. No choice of representatives, signs or integer
common multiplier can evade this particular obstruction while retaining these
transport conditions and this time grid. Coprimality of `b` is not needed for
this negative conclusion.

Conversely, arbitrary correction envelopes can leave this grid. The audit does
not assert failure for all moduli, all weighted-avoidance inputs, or all real
times. The ordinary strict witness at `5/11` explicitly prevents an LRC
counterexample interpretation. The six reported envelope weights
`(6,8,8,9,9,9)` are correct and exceed five, but these excessive weights alone
would not prove that every grid point fails. The complete partition is the
separate decisive evidence. Whole envelopes for a prescribed rounding function
still require a union over every permitted `r0`; no favorable single correction
is substituted for that union.

## Finite covering conclusion and unresolved target

On the unit group modulo `p²`, a unit speed permutes the group. Its bad set is
the inverse image of `±1,...,±(p-1)`, hence has exactly `2(p-1)` elements.
The group has `p(p-1)` elements, giving the general elementary lower bound
`tau_p≥ceil(p/2)`. A cover exists by choosing, for each unit numerator, its
inverse as a speed. These arguments validate the definition and minimum.

At `p=7`, all unit speed classes modulo sign are represented by the 21 positive
integers below 25 not divisible by 7. Opposite signs give the same bad set;
repetitions do not help a union. Therefore checking all 5,985 four-element
subsets of these 21 representatives excludes every four-set cover. Any smaller
cover could be extended to four classes, so it also excludes smaller covers.
The five classes `(1,3,4,5,18)` do cover all 42 unit numerators, proving the
matching upper bound. The manuscript's bit-mask checker is complete: its speed-7
mask covers exactly nonunit numerators, so comparison with the full 49-bit mask
tests precisely the remaining unit-group cover. An independent direct-set
implementation below confirms the same conclusion.

Thus `tau_7=5` is accepted as an exact finite computation, not a Lean theorem.
The proposed general statement `tau_p≥p-2` for all odd primes `p≥5` is not proved
or assumed. Its stated conditional consequence is valid: a `p-1`-tuple with at
least two divisible rows has at most `p-3` unit rows, which could not cover the
unit group under that proposed bound; the divisible rows are good throughout
that group when no speed is divisible by `p²`. This implication covers all rows
but does not establish its unproved premise.

## Independent exact reproducer

The following implementation uses rational phase comparisons and ordinary sets,
rather than the author's integer-distance/bit-mask implementation. It passed
1,444 unit-row strips, 156 automatic-row strips, 243 independent lift choices,
all 5,985 four-set covers and 28,812 signed transport comparisons. Finite row
checks support the symbolic proof above; they do not replace its unrestricted
quantifiers.

```python
# BEGIN INDEPENDENT SUPPLY AUDIT CONTROLS
from fractions import Fraction as Q
from itertools import combinations, product
from math import comb, gcd

def bad(p, a, n):
    r = Q(a*n, p*p) % 1
    return r < Q(1, p) or r > Q(p-1, p)

def norm(q):
    r = q % 1
    return min(r, 1-r)

unit_row_strips = zero_row_strips = 0
for p in (3, 5, 7, 11):
    for a in range(1, p*p):
        for j in range(1, p):
            badks = {k for k in range(p) if bad(p, a, p*k+j)}
            if a % p:
                q, e = divmod(a*j, p)
                assert 0 < e < p and len(badks) == 2
                assert badks == {k for k in range(p) if (a*k+q) % p in (0, p-1)}
                unit_row_strips += 1
            else:
                assert not badks
                zero_row_strips += 1

V0 = (2, 3, 12, 8, 7, 14)
assert [n for n in range(49) if not any(bad(7, a, n) for a in V0)] == [5,9,10,11,38,39,40,44]
V = (1, 3, 4, 5, 18, 7)
assert all(any(bad(7, a, n) for a in V) for n in range(49))
assert tuple(norm(Q(5*a, 11)) for a in V) == tuple(Q(x, 11) for x in (5,4,2,3,2,2))
assert tuple(norm(Q(156*a, 343)) for a in V) == tuple(Q(x, 343) for x in (156,125,62,94,64,63))
assert Q(62, 343) > Q(1, 7)
lift_cases = 0
for zs in product((0, 1, 10**20), repeat=5):
    lifted = (1,) + tuple(v+539*z for v,z in zip(V[1:], zs))
    assert len(set(lifted)) == 6 and gcd(*lifted) == 1
    assert all(v % 49 for v in lifted)
    assert tuple(v % 49 for v in lifted) == V
    assert tuple(norm(Q(5*v, 11)) for v in lifted) == tuple(Q(x, 11) for x in (5,4,2,3,2,2))
    lift_cases += 1

G = {n for n in range(49) if n % 7}
reps = [a for a in range(1,25) if a % 7]
S = {a: {n for n in G if bad(7, a, n)} for a in reps}
assert len(G) == 42 and len(reps) == 21
assert all(len(x) == 12 for x in S.values())
cover_checks = 0
for aa in combinations(reps, 4):
    assert set.union(*(S[a] for a in aa)) != G
    cover_checks += 1
assert cover_checks == comb(21, 4) == 5985
assert set.union(*(S[a] for a in (1,3,4,5,18))) == G

transport_cases = 0
for b in range(49):
    for n in range(49):
        assert any(bad(7, a, (b*n) % 49) for a in V)
        for a in V:
            for sign in (-1, 1):
                W = (sign*b*a) % 49
                assert norm(Q(W*n, 49)) == norm(Q(a*b*n, 49))
                transport_cases += 1
assert (unit_row_strips, zero_row_strips, lift_cases, cover_checks, transport_cases) == (1444,156,243,5985,28812)
print('independent supply audit controls passed', unit_row_strips, zero_row_strips,
      lift_cases, cover_checks, transport_cases)
# END INDEPENDENT SUPPLY AUDIT CONTROLS
```

No correction is requested at the bound source hash. The accepted new content
is a proved special strip-count mechanism, a complete obstruction to a specific
grid and its transports, and a finite covering value. General envelope supply,
the proposed general covering bound and canonical LRC remain unresolved.
