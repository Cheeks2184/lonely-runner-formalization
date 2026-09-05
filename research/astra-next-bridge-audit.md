# Owner-cover contract audit and a three-owner supply lemma

Task `/root/affine_grid-next-bridge-audit`, requested Astra/xhigh, 2026-09-05.
The project workflow, policy, and active research state were read; the workflow
validator passed. This worker edited only this note, restored no cache, and ran
no Lean build. Existing kernel status below is supported by inspected source
and the accepted project reviews; **the new three-owner proof is manuscript
mathematics, pending independent review and formalization**.

The unrestricted existence input remains open. The audit nevertheless obtains
a uniform, nonconditional arithmetic result: **three distinct positive speeds
below a pivot cannot cover its canonical row at threshold `1/7`, at any speed
height**. Together with the existing numerical theorem this treats three lower
owners for every `N>=7`. It supplies a new sufficient class, not arbitrary
internal-cover redundancy or LRC.

## 1. Exact dependency and contract map

Use `N` for the distance denominator, `p` for the actual pivot speed, and

```text
R(N,p) = {0 <= r < N*p : N does not divide r},
B(N,p,d) = {r in R(N,p) : min(r*d mod(N*p), -r*d mod(N*p)) < p},
Z(N,p,d) = {r in R(N,p) : r*d = 0 mod(N*p)}.
```

Badness is strict, so equality at distance `p` is safe. No prime assumption is
part of these definitions. The original full tuple has `n` moving speeds and
`N=n+1`; a partial owner family does not change that threshold.

| Inspected kernel interface | Actual content / absent input |
| --- | --- |
| `BHKRealReduction.conjecture_iff_positiveIntegerConjecture` (declaration is in namespace `LonelyRunner`) | Canonical real-speed `Conjecture` iff positive, injective integer-speed LRC at every size; neither proposition is inhabited. |
| `PivotBoundary.exists_witness_iff_exists_pivot_certificate` | For a fixed nonempty positive family and `N>=2`, a closed real witness iff some original pivot has a residue in `R` outside **every** other original bad set. |
| `positiveIntegerConjecture_iff_pivotCertificateConjecture` | Uniform version, retaining positivity, injectivity, and `N=n+1`. Thus unrestricted certificate supply is **exactly LRC-equivalent**. |
| `IntegerInduction.positiveIntegerConjecture_iff_divisorOrUncoveredPivotPrinciple` | The divisor-or-uncovered-pivot alternative is another checked equivalent, not an easier existence theorem. |
| `OwnerKernelCover.exists_pivotCandidate_avoiding_ownerKernel_family` and its gcd / real-witness adapters | For `N>=3`, positive `d_i<p`, labelled `E subset C` dominating the nonempty `Z_i`, and `2(N+1)|C|+(N-2)|E| <= N(N+1)`, supply a residue good for the pivot and **only the listed owners**. No internality, maximum status, or injectivity is assumed or obtained. |
| `PrimitivePrompt95.primitiveMaxCovered_iff_unrestricted` and `maxCovered_iff_primitiveDivisible_and_nondivisible` | Gcd normalization and the exact split into primitive `N`-divisible maximum-pivot redundancy AND unrestricted `N`-nondivisible redundancy. Neither conjunct is proved. |

File prefixes in the table identify locations, not Lean namespaces. All named
declarations have namespace `LonelyRunner`.

Explicitly, `F=coveredPivots N a` consists of the pivots whose entire candidate
row is covered by the other original labels. At a speed-maximal member `j` of
`F`, an internal owner set is `C subset F\{j}`. `InternalCoverRedundantAt`
requires **every** such complete cover to have a removable label.
These are `Prop` definitions in `Prompt99Scaling.lean`, not theorems asserting
their truth. Redundancy is equivalent, by finite minimal-cover selection, to
the absence of an internal complete cover at that pivot. This manuscript
equivalence does not turn either assertion into an existence proof.

Universal Prompt95 would imply LRC: if every pivot were covered, a largest
speed would have a nonempty candidate row and a minimal complete internal
cover, contradicting redundancy. A noncovered pivot then supplies the checked
certificate. The finite-minimization wrapper is straightforward but was not
found as an exported closing theorem in this source branch. More importantly,
its universal redundancy premise is unproved. **Do not identify Prompt95 with
bare LRC:** an ordinary witness only guarantees that some pivot is noncovered;
it says nothing by itself about internal covers at the maximum of the remaining
covered pivots. No converse to Prompt95's sufficient implication is claimed.

The numerical owner theorem provides a sufficient condition for such an
internal set to be noncovering, since maximum status and injectivity make every
internal owner strictly slower than the pivot. It does not prove that the
condition holds. With `c=|C|`, even `E=empty` cannot pass when `2c>N`.
The exact-count and ordered-overlap tools can give stronger particular
certificates; none supplies their orders, parents, or strict totals uniformly.

## 2. Conditions that must not be relaunched as new supply

- **Prompt99 without primitivity:** scaling every speed by `N` preserves all
  covers and makes the pivot divisible by `N`. Its supposedly narrower
  universal branch is kernel-proved equivalent to full Prompt95. The
  primitive split above is honest but still unproved on both sides.
- **Prompt104:** accepted cover density gives `N+1<3c`, while the owner/outside
  partition gives `c+o<=N-2`. Two-fold expansion for the proper cosingleton
  `C\{i}` would force `2(c-1)<=o`, hence `3c<=N`, a contradiction. There is
  no surviving full-core circuit under these hypotheses. This is a scope
  collapse to no-internal-cover, not a counterexample to Prompt95.
- **Prompt105:** the four-gcd total safe-residue mass bound is manuscript-
  equivalent to ordinary witness existence. After gcd normalization, a safe
  component away from `1/2` contributes two labelled boundary certificates
  (also for a singleton, which needs two active labels), and reflection gives
  two more. If `1/2` is safe, every speed is odd; the largest pivot supplies
  `N-1` safe residues around the antipode, with the two other pivots providing
  the remaining count when there are three moving speeds. Common scaling
  multiplies each count by the gcd. Conversely positive mass supplies a
  certificate. This is not a new quantitative existence input.
- **Internal pair-overlap supply:** the already accepted refutation uses
  `N=9`, `(7,8,9,10,11,13,18,3243240)`. At the maximum covered pivot `18`,
  the maximal internal owner set has six labels, but the proposed strict
  phase-incidence/pair-overlap comparison fails at every admissible base.
  An internal safe candidate nonetheless exists (`r=56`). The generic
  multiplicity inequality survives; its universal numerical supply does not.
- **Zero domination alone / overlap repackaging:** the accepted literal row
  `N=7,p=11,d=(1,4,5,6,7)` is covered with domination number one. Also every
  zero-separated tree certificate with one zero dominator is subsumed by the
  existing original-set two-parent ordered-union mechanism. Neither dropping
  the budget nor renaming the overlap bound produces a new supply theorem.

These conclusions use the accepted owner review, the pair-overlap refutation,
and the takeover audit's explicit Prompt104/105 proofs. Historical launch
labels in old documents are superseded by the current workflow holds. No old
prompt, attachment, or launch queue was executed in this audit.

## 3. New proved arithmetic lemma: three lower owners at N=7

**Theorem.** For all natural numbers `0<a<b<c<p`, there exists
`r in R(7,p)` outside `B(7,p,a) union B(7,p,b) union B(7,p,c)`.
Thus the same time `r/(7p)` is closed-good for all four speeds `a,b,c,p`.
There is no supplied witness, bound on `p`, coprimality, primitive-tuple,
divisibility, internality, or maximal-pivot hypothesis.
The conclusion protects **three lower owners plus the pivot**, not the six
arbitrary moving speeds of a full seven-runner instance. Unlisted rows can
still kill this residue; the internal-cover application uses exactly the
specified owner subset.

Write `A=|R|=6p`. For an owner `d`, set

```text
h=gcd(d,p), P=p/h, D=d/h, k=gcd(D,7).
```

The existing exact normalized count and zero formula say

```text
|B_d| = h*[ k*(2*floor((P-1)/k)+1) - (2*floor((P-1)/7)+1) ],
|Z_d| = h*(k-1).
```

Here `gcd(D,P)=1` and `0<D<P`. Since 7 is prime, `k` is 1 or 7.
If `Z_d` is empty, the compiled scalar estimate gives `|B_d|<=12p/7`.
Otherwise `D=7e`, `P>=8`, `7 does not divide P`, and, for
`q=floor((P-1)/7)>=1`,

```text
|B_d|/p = 6*(2q+1)/P.                                  (1)
```

There is exactly one possible owner with `|B_d|>2p`:

```text
8 divides p, d*=7p/8, P=8, D=7, |B_*|=9p/4.             (2)
```

Indeed `P>=7q+1`. For `q>=2`, `6(2q+1)<=2(7q+1)`;
for `q=1`, only `P=8` gives `18/P>2`. In that case `D<P`
and `7 divides D` force `D=7`. This also proves the uniform zero-row
bound `|B_d|<=9p/4`. Distinct owners cannot repeat the exceptional row.

If the three owners have zero, one, or two nonempty zero kernels, their total
bad counts are at most, respectively,

```text
(36/7)p, (159/28)p, (167/28)p,
```

all strictly less than `6p`. This already settles every such triple by the
ordinary union bound. In particular the two-zero case is outside the compiled
owner budget when the zero kernels require two representatives (`58>56`).

If all three zero kernels are nonempty and the exceptional row is absent,
each count is at most `2p`. All three bad sets contain the distinct candidates
`1` and `7p-1`; hence their union is at most their sum minus four and is
strictly smaller than `6p`.

It remains to treat the exceptional row and two other zero rows. We prove

```text
|B_d \ B_*| < 15p/8   for every other zero owner d.        (3)
```

First remove the common 7-adic factor. Let `g=7^v7(p)`. Nonempty `Z_d`
means `v7(d)>v7(p)`, so every owner in this remaining case is divisible by
`g`. Divide the pivot and all three speeds by `g`. Reduction modulo the
smaller `7p` preserves candidate and bad-set membership, with exactly `g`
copies of every residue, so it preserves cover and multiplies all set and
remainder counts by `g`. This is the same common-scaling identity already
proved in `Prompt99Scaling`; it is not a change of one pivot while fixing
the other speeds. We may therefore assume `7 does not divide p`.

All owners are now `d=7he`, with `p=hP`, `gcd(e,P)=1`, and `7e<P`.
Their badness depends only on `r mod p`. Each residue modulo `p` has seven
lifts modulo `7p`, exactly one of which is divisible by 7. Thus every relevant
set or intersection has six times its cardinality on the complete `p`-period.
On that period, the exceptional bad set is exactly

```text
r mod 8 in {0,1,7}.                                     (4)
```

For all `P` other than `8,9,15,16,22`, (1) is already strictly less than
`15/8`. To check this finite exception list: for `q>=4`,
`48(2q+1)<15(7q+1)` is exactly `33<9q`; for `q=1,2,3`,
the only integers with `6(2q+1)/P>=15/8` are respectively
`P=8,9`, `P=15,16`, and `P=22`. The case `P=8` is the removed
exceptional owner itself.

The four remaining denominators give (3) by exact periodic counting:

| P | Constraint and remainder bound |
| --- | --- |
| 9 or 15 | `gcd(P,8)=1`. In the common period `8P`, each bad residue modulo `P` runs through every class modulo 8. Exactly five of the eight classes avoid (4). Therefore `|B_d\B_*|=(5/8)|B_d|=5p/4`. |
| 16 | `0<e<16/7` and `gcd(e,16)=1` force `e=1`. The bad classes modulo 16 are `0,1,2,14,15`; only `2,14` avoid (4). Thus the remainder is `6*(2p/16)=3p/4`. |
| 22 | Each class modulo 22 has four lifts to the common period 88, running through one parity class modulo 8. At most three avoid (4). Thus the remainder is at most `(3/4)|B_d|=63p/44<15p/8`. |

All common periods divide `p`, because `8 divides p` and `P divides p`.
This proves (3), including arbitrary common factors with 7 via the earlier
scaling argument. Finally

```text
|B_* union B_b union B_c|
 <= |B_*| + |B_b\B_*| + |B_c\B_*|
 < (9/4 + 15/8 + 15/8)*p = 6p.
```

The complement in `R` is nonempty. This completes the proof.

### Value and exact recommended next lemma

The immediate implementation target is the theorem just proved, for example

```lean
theorem threeLowerOwner_noncover_seven
    (p a b c : Nat) (ha : 0 < a) (hab : a < b)
    (hbc : b < c) (hcp : c < p) :
    ∃ r ∈ pivotCandidates 7 p,
      r ∉ pivotBadResidues 7 p a ∧
      r ∉ pivotBadResidues 7 p b ∧
      r ∉ pivotBadResidues 7 p c
```

This declaration is proposed, not present in Lean. No new arithmetic search
or unproved supply premise is needed to implement it after review. For
`N>=8`, three lower owners already satisfy the compiled theorem with `E=C`,
since its budget becomes `9N<=N(N+1)`. Hence the new proof extends the uniform
three-owner result to all `N>=7`. Internal complete covers at a maximum
covered pivot consequently need at least four owners when `N>=7`; in
particular redundancy is vacuous for at most four covered labels there.

This is a genuinely new sufficient domain relative to the inspected
`OwnerKernelCover` test, not a claim of literature priority. The strongest
old general pair result covers only two owners. The new proof also does not
follow directly from `fastRunnerInsertion`: that theorem assumes an old
witness and a factor-four separation for inserting a fourth moving speed,
whereas here owners may approach `p`. For example `d*=7p/8` violates that
separation by a wide margin. The generic ordered-union theorem already
justifies the final set arithmetic; the added supply is the **uniform
arithmetic remainder estimate (3)**.

Two separating fixtures are

```text
N=7,p=72, owners=(1,56,63): bad counts=(122,144,162), safe count=128;
N=7,p=360, owners=(315,280,168): bad counts=(810,720,720), safe count=600.
```

Their zero kernels need respectively two and three representatives, so both
fail the old budget. The second also defeats the raw sum test and the common
two-point correction: `2250-4>2160`. A two-parent certificate can encode the
new overlap proof; the uniform arithmetic producing it is the additional
result, not a newly named certificate format.

`SaturatedTopTwo.saturatedTopTwo_avoids_pivotBadResidues` instead treats
`1,2,...,N-2,B` and may select either `N-2` or B as pivot. It does not allow
three arbitrary lower speeds of unbounded height at the fixed pivot p.
Completing arbitrary owners to a saturated interval would generally enlarge
N and weaken the threshold; merely retaining a saturated theorem's other
pivot also would not establish noncoverage of p. Consequently its present
contract does not supply the new theorem. This is a comparison of exact
sufficient statements, not an assertion that their proof ideas cannot help.

The remaining general problem is still dense internal covers with more owners,
including `N=13,c=9` in the control below. This note does **not** propose that
the new three-owner argument scales to arbitrary `c`, or revive an endpoint
selector after its refutation. It does not prove the analogous three-owner
claim at `N=5,6`; finite nonfindings there are not promoted into statements.

## 4. Symbolic stress control: the balanced guard tuple

Use the frozen single-zero audit's tuple

```text
A=(1,7,8,10,17,136,133,64,100,80),
C=47028800=13*lcm(A), B=423259206=9C+6,
V=A+(B,C), N=13.
```

The strict witness `1/9` has minimum distance `1/9`. The two large pivot grids
need not be enumerated. Exact boundary perturbations give certificates

```text
at pivot B: t_B=1/9+10/(39B), r_B=(13B+30)/9=611374412;
at pivot C: t_C=1/9-17/(117C), r_C=(13C-17)/9=67930487.
```

The displayed numerators are integers, are respectively `-1` and `1` modulo
13, and lie in their candidate ranges. At `t_B`, the B-phase is `12/13`;
each small speed loses less than `136*10/(39B)<4/117` of its original
`1/9` margin. The C-phase is `2/9+10C/(39B)`, between `1/13` and `12/13`
because `C/B<1/9`.
At `t_C`, the C-phase is `1/13`; the small-speed loss is at most
`136*17/(117C)<4/117`. The B-phase modulo one is

```text
14/39 - 34/(39C),
```

strictly between `1/13` and `12/13`. Thus both large pivots are noncovered.
This perturbation uses an explicit strict witness and existing Lipschitz
reasoning; it is a control, not new unconditional fast-speed insertion.

For every `a in A`, `13a` divides C, so C alone covers **every** candidate of
the a-pivot, with zero phase. Hence the covered-pivot set is exactly A and its
maximum is 136. At this genuine maximum covered pivot, all nine maximal
internal owners have empty zero kernels, yet the numerical budget is
`28*9=252>182`. Their internal union is nonetheless noncovering: the single
candidate `r=196` modulo `13*136=1768` has distances, in A order omitting 136,

```text
(196,396,200,192,204,452,168,152,232),
```

all at least 136. The outside owner C kills this point, as it must. This proves
directly that maximum-covered status plus internality cannot by itself imply
the old numerical budget. It is not a counterexample to redundancy, since
the maximal internal set already has a safe candidate.

For completeness, at the actual largest pivot B the eleven lower owners have
zero-kernel sizes `(0,0,0,0,0,0,0,0,0,0,24)`; at pivot C every other row has
empty zero kernel. The B row fails the old budget already at `28*11>182`.
The C row contains the larger outside speed B, so the lower-owner theorem
cannot be applied to its full family at all. Dropping that speed would lose
an original coordinate. These distinctions prevent interpreting either the
endpoint obstruction or its strict witness as unrestricted owner supply.

## 5. Compact exact reproduction

This sole standard-library block performs no large pivot-grid enumeration.
It checks all 230,300 triples at `N=7,4<=p<=50`, the periodic remainder
formula for 6,074 `(P,e)` pairs with `9<=P<=400`, the four exceptional
denominators, two nonvacuous common-7-power controls, the two separating
fixtures, and three explicit guard-row certificates. The proof above, not
these bounded checks, gives the unrestricted-height theorem. Exploratory
nonfindings in other small domains are not used as evidence or retained as
an exhaustion claim.

```python
from fractions import Fraction as F
from itertools import combinations
from math import gcd, lcm

def dist(M, x):
    return min(x % M, (-x) % M)

def row(p, ds):
    R = {r for r in range(7*p) if r % 7}
    B = [{r for r in R if dist(7*p, r*d) < p} for d in ds]
    return R, B

trials = 0
zero_classes = [0]*4
for p in range(4, 51):
    R = [r for r in range(7*p) if r % 7]
    full = (1 << len(R)) - 1
    masks = {d: sum(1 << j for j, r in enumerate(R)
                    if dist(7*p, r*d) < p) for d in range(1, p)}
    for a, b, c in combinations(masks, 3):
        assert masks[a] | masks[b] | masks[c] != full
        z = sum(gcd(d, 7*p) > gcd(d, p) for d in (a, b, c))
        zero_classes[z] += 1
        trials += 1
assert trials == 230300
assert zero_classes == [161721, 60627, 7707, 245]

periodic = 0
exceptional = {9: [], 15: [], 16: [], 22: []}
for P in range(9, 401):
    if P % 7 == 0:
        continue
    for e in range(1, (P-1)//7 + 1):
        if gcd(e, P) != 1:
            continue
        p = lcm(8, P)
        star = {r for r in range(p) if r % 8 in (0, 1, 7)}
        bad = {r for r in range(p) if 7*dist(P, e*r) < P}
        remainder = 6*len(bad-star)
        assert 8*remainder < 15*p
        if P in exceptional:
            exceptional[P].append((e, F(remainder, p)))
        periodic += 1
assert periodic == 6074
assert exceptional == {
    9: [(1, F(5, 4))], 15: [(1, F(5, 4)), (2, F(5, 4))],
    16: [(1, F(3, 4))], 22: [(1, F(51, 44)), (3, F(51, 44))]}
for p, expected in ((504, 1008), (3528, 7056)):
    ds = (7*p//8, 7*p//9, 7*p//12)
    assert len(set(ds)) == 3
    assert all(gcd(d, 7*p) > gcd(d, p) for d in ds)
    R, Bs = row(p, ds)
    assert len(R-set().union(*Bs)) == expected
for p, ds, sizes, safe in (
    (72, (1, 56, 63), (122, 144, 162), 128),
    (360, (315, 280, 168), (810, 720, 720), 600),
):
    R, Bs = row(p, ds)
    assert tuple(map(len, Bs)) == sizes
    assert len(R-set().union(*Bs)) == safe
assert dist(56, 4*2) == 8  # equality is safe, not strict badness

A = (1, 7, 8, 10, 17, 136, 133, 64, 100, 80)
C = 47028800
B = 423259206
V = A + (B, C)
assert C == 13*lcm(*A) and B == 9*C+6
assert all(C % (13*a) == 0 for a in A)
assert min(min(F(v, 9) % 1, -F(v, 9) % 1) for v in V) == F(1, 9)
for p, r in ((B, 611374412), (C, 67930487)):
    assert 0 <= r < 13*p and r % 13
    assert min(dist(13*p, r*v) for v in V) == p
assert tuple(gcd(d, 13*B)-gcd(d, B) for d in V if d != B) == (0,)*10+(24,)
assert all(gcd(d, 13*C) == gcd(d, C) for d in V if d != C)
owners = tuple(a for a in A if a != 136)
assert all(gcd(a, 1768) == gcd(a, 136) for a in owners)
assert tuple(dist(1768, 196*a) for a in owners) == (
    196, 396, 200, 192, 204, 452, 168, 152, 232)
assert all(dist(1768, 196*a) >= 136 for a in A)
assert dist(1768, 196*C) == 0
print({'three_owner_cases': trials, 'zero_classes': zero_classes,
       'periodic_cases': periodic, 'seven_power_controls': 2,
       'separating_fixtures': 2, 'guard_pivot_certificates': 3})
```

## 6. Source bindings and status boundary

The source hashes below were read directly; no missing cache was restored to
duplicate prior kernel checks. The new proof has **not** been Lean-checked.
The canonical conjecture remains active and unresolved.

```text
bf4c025bcdcc178f4e9c94884314635e3d26697fe105a9a9a6a55ca1aa60f139  LonelyRunner/OwnerKernelCover.lean
d1d6cf01650c809da0cb19ed722754071df070831e02e22a3c4b2c3dc28afb04  LonelyRunner/PrimitivePrompt95.lean
49131a7f9690042d1b16cbc876417f9d9ce1b53cc6565f87b6d1b53c4e3340cd  LonelyRunner/Prompt99Scaling.lean
0e56cab74d30ef8b537ed4ec24503aae875bd8aadc369d26da99ba882cc3603f  LonelyRunner/PivotBoundary.lean
98d7c878eef7e4a3b7f7c504c882cf35191c1343816a59d731193ac8a207ed26  LonelyRunner/BHKRealReduction.lean
7b315fe9ea7f8639eb45e376365f1c3795c52e2f93e608db578390c1083a5753  LonelyRunner/IntegerInduction.lean
ac24bb6cfcf524a08c0ceb2a728b2febf826c595d4aaa72eb7f10d2e5baa96dd  LonelyRunner/Prompt100TwoOwnerCounts.lean
4a9e242429e601f07559a1482031d84f0cc5677a3c128a15481f4003d4f5333e  LonelyRunner/OwnerKernelBound.lean
6487d679e2f8d84657827f01f1c98e232c997c62cb48dad5ac9c22db897df3b1  LonelyRunner/PivotZeroKernel.lean
0298105bda5d7af5beb7bdc1cab32880e170979ab5b611dcb706b9409777685a  LonelyRunner/KernelCoverCertificates.lean
8b7e9dc5be1236acb812607c19454fe43ecd1333145aef675e7df8e6d0c3871c  LonelyRunner/ModularCertificates.lean
dda82d1f8830d961499292656c3dfac884a471ad5ef38bd925b1a25c403603a5  LonelyRunner/FastRunnerInsertion.lean
08f8589caf8cc435cc88d3c47a823a49c7a24ee89d385a8e06311789ac671b38  LonelyRunner/SaturatedTopTwo.lean
39e235f311aef5f0a790a89c7e22cb8c8206a7d3f94ba30e9911e22544d199b8  research/astra-owner-review.md
9d949bf0ff389b519721cb9fcf3fb60123df08b9f4612a35ba4b90e36e084de3  docs/internal-pair-overlap-supply-refutation.md
7b47f0748b21708b74c84eddc0a5934cb13f0624174e506c4fc2bd8b0b831d76  research/astra-single-zero-balanced-audit.md
```

The directly consulted takeover review is
`/home/joshua/Documents/Codex/audits/lonely-runner-2026-09-04/audit.md`,
SHA-256 `96edbbb6028ec08460fee5ff38d24f5183f131464ec9506e6bfd40cbdc6ed5dc`.
Its Prompt104 arithmetic and Prompt105 manuscript equivalence are reported at
their actual scopes; this audit did not execute its historical attachments.
