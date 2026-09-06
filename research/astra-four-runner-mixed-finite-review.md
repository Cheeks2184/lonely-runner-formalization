# Independent review of the four-runner mixed finite plan

Assigned independent Astra/xhigh review by `/root/mss_published_bound_audit`,
at orchestrator-supplied source checkpoint
`fd99b6f550bcb931f101ef2186168f1fc09aec4d`. This review is the only owned file.
Current project instructions, policy and active state were read, and
`python3 -B scripts/validate_workflow.py` passed. The assignment is authorized;
observed runtime model/effort were not independently exposed. Other workers'
source and shared state were preserved.

**Verdict: accept the precise finite-reduction and certificate plan. No
mathematical correction is required.** Independent replay verifies the reported
finite evidence. The classification is still a prospective Lean theorem:
acceptance of the new affine implementation and a kernel-checked finite
certificate with its bridges remain required. This review neither substitutes
for the separate affine source review nor promotes Python output to a theorem.

## Lower counts, exact cutoff and stationary interpretation

The actual definition of `LowerCountPositiveIntegerHypothesis 4` quantifies over
moving counts d with `1<=d<=4-2`, hence exactly d=1 and d=2. The first case
follows from `BaseCases.oneMovingRunner` after casting the positive natural
speed to a nonzero real and identifying the unique `Fin 1` label. Its bound is
1/2, exactly the required 1/(d+1). The second follows from
`SmallDimensions.twoMovingRunners`, with positive natural speeds again cast to
nonzero reals. Its bound is exactly 1/3. These sources require no general LRC
or mixed hypothesis; they even allow more general nonzero real speeds. Their
existential time need not be positive because the lower-count definition does
not require positivity. Thus the required H_4 has no unproved count premise.

I inspected the new declaration
`primitive_sorted_largeHeight_stationary_mixed` in the current working source.
It takes m>=1, H_(m+2), a strictly increasing natural tuple s of size m+2 with
s(0)=0 and `Finset.univ.gcd s=1`, and the strict height inequality
`choose(m+2,2)^m < s(last)`. It returns one t>0 satisfying both stationary
`LonelyAt ... 0 t` and fastest norm at least 1/(m+1).
At m=2 these are exactly cutoff `choose(4,2)^2=36`, ordinary threshold 1/4,
and fastest threshold 1/3. The finite branch includes H=36; the height theorem
applies to H>36. There is no missing height or factor from changing the runner.

For a primitive positive triple a<b<H, use `s=![0,a,b,H]` on `Fin 4`.
Its strict ordering and zero endpoint follow from 0<a<b<H, and its finite gcd
is gcd(a,b,H) because adjoining zero does not change the gcd. The three
nonzero labels are exactly the other labels relative to runner zero.
`Definitions.lonelyAt_iff_relativeLonelyAt`, followed by the zero-speed
identity, turns the ordinary conclusion into the three circle norms at that
same positive time. The extra endpoint is the label of H, not a different
runner or a relative maximum selected after translation.

The current declaration matches the plan's required contract. Its full affine
proof chain and fresh build/trust evidence are being reviewed separately; this
review makes that dependency explicit rather than claiming independent
verification of the entire changed implementation.

## Finite domain and exact replay

All increasing positive triples of height at most 36 are precisely the
3-element subsets of {1,...,36}, listed once in increasing order. Their count
is `choose(36,3)=7140`. The program's `combinations(range(1,37),3)` covers
exactly this set and filters only on gcd 1. It does not impose direct-divisor,
strict-witness, small-lower-speed or pairwise-coprime eligibility conditions.
The independently checked primitive count can also be obtained without the
tuple loop by the finite Möbius sum:

```
choose(36,3) - choose(18,3) - choose(12,3) - choose(7,3)
 + choose(6,3) - choose(5,3) + choose(3,3) - choose(3,3)
 = 7140 - 816 - 220 - 35 + 20 - 10 + 1 - 1 = 6079.
```

These are the nonzero contributions for divisors 1,2,3,5,6,7,10,11;
squareful divisors have Möbius value zero and divisors above 12 have no triple.

I independently replayed the frozen program, verified its source and program
hashes before execution, checked its exact stdout hash, and checked the saved
root stdout hash. The replay returned 6,078 positive rational witness rows,
only the primitive exception (1,2,3), and maximum reduced denominator 140.
The complete ordered row digest matched, so agreement is on every positive
row, not only aggregate counts. The replay wrote no file and searched no
larger domain. Exact command, run from the repository root:

```sh
python3 -B - <<'FOUR_RUNNER_REVIEW_REPLAY'
from pathlib import Path
from hashlib import sha256
from contextlib import redirect_stdout
import io,re
p=Path('research/astra-four-runner-mixed-finite-plan.md')
assert sha256(p.read_bytes()).hexdigest()=='9b71c56eb36093793df2bf02807e4f7da5f69ef1bccf4edeb68230c154dee085'
b=re.findall(r'^```python\n(.*?)^```[ \t]*$',p.read_text(),re.M|re.S)
assert len(b)==1 and sha256(b[0].encode()).hexdigest()=='233831abc5b5fa246012c05d4ac8ee84738520529c6bf320f1a88d0aec83c845'
namespace={};out=io.StringIO()
with redirect_stdout(out):exec(compile(b[0],'four-runner-mixed-independent-replay','exec'),namespace)
assert sha256(out.getvalue().encode()).hexdigest()=='1b39847584961da45a366d2bfc8035c5be82ef0a7d179927a1297016e6f70aa9'
assert sha256(Path('/tmp/astra-four-runner-mixed-finite-root-replay.json').read_bytes()).hexdigest()=='1b39847584961da45a366d2bfc8035c5be82ef0a7d179927a1297016e6f70aa9'
print(out.getvalue(),end='')
FOUR_RUNNER_REVIEW_REPLAY
```

The band code retains closed endpoints with `<=`. For each positive speed w,
indices 0,...,floor(w/2) contain every good band meeting [0,1/2]. Each speed's
bands are sorted and disjoint. The two-pointer intersection correctly advances
the interval ending first and advances both at equality. Integer periodicity
and reflection preserve all norms, including the fastest one, so a mixed time
exists globally if and only if its half-period good set is nonempty.
Every returned row is checked directly by exact rational norms and separately
by all six integer residue inequalities. Positivity of its time is checked.

## The negative case and scaling

The analytic exclusion is sufficient independently of any negative search
result. For (1,2,3), period one and reflection reduce time to [0,1/2]. The first
ordinary norm bound forces t>=1/4; the second then forces t<=3/8. On
[1/4,1/3], the third norm is 1-3t, which is >=1/4 only at t=1/4. On
[1/3,3/8], it is 3t-1<=1/8, so there are no other points. At 1/4 the norms
are (1/4,1/2,1/4), which satisfy ordinary but fail mixed and strict ordinary.
The full ordinary good set modulo one is {1/4,3/4}.

An independent Cartesian-product intersection of the three ordinary band
families on [0,1] recovered exactly these two singleton cells. This is a fixed
boundary check, not the justification for the analytic exclusion.

For a smaller Lean exclusion proof, the first two bounds already give
`3t-1 in [-1/4,1/8]`, hence `||3t|| <= |3t-1| <=1/4<1/3` by integer
periodicity and the norm upper bound by a real representative. With strict
first-speed margin, t>1/4 makes that absolute value strictly below 1/4, ruling
out strict ordinary at the third speed. Thus the classification and K_4 proofs
can avoid formalizing the complete singleton set; the frozen plan's stronger
singleton derivation remains correct.

For arbitrary 0<a<b<H, put g=gcd(a,b,H)>0 and divide all three speeds by g.
The divided triple remains positive and strictly increasing, is primitive,
and its fastest speed is H/g. The exact phase identity

```
(g*v)*(s/g) = v*s
```

preserves every norm at one time and preserves positivity of time. The inverse
substitution s=g*t proves equivalence of mixed existence in both directions,
and also preserves strict ordinary existence. The height cutoff must be
applied after this normalization: unnormalized exceptional triples
(a,2a,3a) have arbitrarily large height.

The normalized triple is (1,2,3) exactly when b=2a and H=3a. In the forward
direction a=g and the two equalities follow by multiplying by g. Conversely,
gcd(a,2a,3a)=a, so division gives (1,2,3). Thus, once the primitive positive
certificate and the height dependency are checked, the proposed global integer
classification is exactly

```
Mixed(a,b,H) <-> not (b=2*a and H=3*a),    for 0<a<b<H.
```

The exceptional shape has no strict ordinary point by the same scaling and
singleton proof. A strict ordinary witness therefore excludes that shape, and
the classification then gives a positive mixed time. This proves the proposed
K_4 consequence once its dependencies are formalized. It concerns three
positive integer moving speeds relative to zero; it makes no mixed assertion
for arbitrary real velocities or arbitrary chosen labels, and no claim about
K at larger counts or unrestricted LRC.

## Certificate contract and implementation obligations

A clean finite certificate uses natural numbers p,q and the predicate

```
0 < p, 0 < q;
q <= 4*((a*p)%q),  4*((a*p)%q) <= 3*q;
q <= 4*((b*p)%q),  4*((b*p)%q) <= 3*q;
q <= 3*((H*p)%q),  3*((H*p)%q) <= 2*q.
```

Recording p>0 explicitly makes the positive-time conclusion immediate. It is
also implied by q>0 and either lower-band pair, since p=0 would force q<=0.
Reduced fractions, coprimality of p and q, and the upper time bound 1/2 are
unnecessary for soundness of a supplied row.

For r=(w*p)%q and q>0, r<q. The lower-band pair at denominator D=4 or D=3
is equivalent to `q<=D*min(r,q-r)`: both sides of the unit circle are bounded,
and natural subtraction has its usual value because r<q. With
`cyclicResidueDistance` and `circleNorm_nat_div_eq q (w*p)`, casting and division
by the positive q give `1/D <= circleNorm((p/q)*w)`. The D=3 fastest bound
implies its D=4 ordinary bound. This is exactly the pattern already present in
`PairSumGeometry`, with the per-coordinate thresholds made explicit.

Required finite coverage is the theorem

```
forall a b H : Nat,
  0<a -> a<b -> b<H -> H<=36 -> gcd(a,gcd(b,H))=1 ->
  (a,b,H)!=(1,2,3) -> exists p q, validMixedRow a b H p q.
```

An explicit witness table or deterministic finite lookup may establish this,
but row arithmetic and coverage must both be kernel-checked. A Boolean checker
needs a proved soundness bridge to this exact statement. A table needs checked
matching of tuple keys and coverage of every eligible tuple; knowing that it
has 6,078 rows or matching a digest does not prove coverage. Splitting the
finite verification by H gives small independent chunks without weakening the
domain. Ordinary `decide`/kernel reduction with a decidable natural checker is
suitable; `native_decide`, a custom axiom, or reliance on Python to certify
absence is not. The exceptional case should use its separate analytic lemma.

The recommended concrete implementation contract is a total executable
`W : Fin 37 -> Fin 37 -> Fin 37 -> Nat * Nat`, with arguments H,a,b, together
with `rowOK a b H p q : Bool` deciding the positive-numerator/denominator and
six-band predicate above. A height-grouped explicit table with default (0,0)
is sufficient. Kernel-check this single coverage statement, splitting into
37 fixed-height lemmas if resource limits justify it:

```text
forall H a b : Fin 37,
  0<a.val -> a.val<b.val -> b.val<H.val ->
  Nat.gcd a.val (Nat.gcd b.val H.val)=1 ->
  not (a.val=1 and b.val=2 and H.val=3) ->
  rowOK a.val b.val H.val (W H a b).1 (W H a b).2 = true.
```

Then a separate generic `rowOK` soundness lemma supplies the positive mixed
time. Since every natural value <=36 has a `Fin 37` representative, the
displayed coverage statement yields the natural-number bounded theorem.
Missing or miskeyed eligible rows cannot be concealed by a row count: they
produce the default (0,0), which fails `rowOK`, unless another valid witness
for that exact key is supplied. The total-gcd guard must not be replaced by a
pairwise-coprimality guard. Neither the table's cardinality nor a digest is a
premise of the final mathematical theorem.

The plan's denominator bound is sound: the positive left endpoint of an
intersection is one of the lower endpoints with denominator 4a,4b or 3H, before
reduction. It cannot arise from the clipping endpoint zero, since every retained
band starts positively. Thus its reduced denominator divides one of those
three numbers. An optional tighter bound on this specific finite domain is
`q<=max(4*b,3*H)<=max(4*35,3*36)=140`; the plan's bound 144 is also valid.
No denominator-completeness theorem is required if explicit positive rows and
their exhaustive coverage are verified; it is useful if a bounded witness
search is used instead.

After the finite certificate, remaining compositional obligations are: prove
H_4 from the two existing small-count theorems; connect `![0,a,b,H]` and its gcd
to the exact mixed-height declaration; combine H<=36 with H>36; formalize the
exception; and transport by the positive gcd. These are all necessary parts of
the finished classification. Existing ordinary finite-family statements alone
do not carry the stronger fastest margin and must not be substituted for the
mixed bounded certificate.

## Hashes, checks and handoff

| Inspected artifact | SHA-256 |
| --- | --- |
| Frozen root plan | `9b71c56eb36093793df2bf02807e4f7da5f69ef1bccf4edeb68230c154dee085` |
| Plan's sole program, final newline included | `233831abc5b5fa246012c05d4ac8ee84738520529c6bf320f1a88d0aec83c845` |
| Independently reproduced exact stdout | `1b39847584961da45a366d2bfc8035c5be82ef0a7d179927a1297016e6f70aa9` |
| Ordered 6,078-row encoding, final newline included | `08e98062af51e2c5e5e5c7d45caaa0cb166d19caa8e55f1ca370d55fef6bdbd3` |
| `BaseCases.lean` | `31e2c328e060c077c6c9928e3fb431601326e4e54a949ee5148aed5cd3687d1f` |
| `SmallDimensions.lean` | `e4933da3551792130eebf1ede4701bff3296f59eb696dfb7b6276e16d940d699` |
| `LowerCountSupply.lean` | `0705291adc53011fb72fc718a7260876512b092741442d6a6cceb4b76eb5ccf4` |
| `Definitions.lean` | `5f0258a6ab99950fc7045b2200d6708fe7603d3caa4d62855ef2b19a330c95aa` |
| Current `FiniteHeightReduction.lean` declaration dependency | `cb41059260b943411e2ab5360b84b59cd13f2ddf352c3c50a0b3715b9b9987d6` |
| `PivotResidues.lean` | `362da5ab923f22e900ae7ac821dd4cf4aab91dfe70889987bc9e5a05d19c276a` |
| `PairSumGeometry.lean` | `3bc47a6f1a77950577edc54b571e9809bb03bffd37575ebc10bae0fcfcab9384` |

Commands were scoped source reads (`cat`, `sed`, `rg`, `rg --files`), Python
JSON/hash inspection, the exact single finite replay above, the workflow
validator, and a small separate standard-library rational control. The latter
checked the displayed binomial/Möbius counts, the full-period exceptional cells,
the structural denominator bound 140, and the mixed row (1,2,4,p=3,q=8) before
and after common scaling by 7. All substantive checks passed. An exploratory
`rg` against four guessed certificate filenames returned missing-file errors;
the actual certificate files were then located with `rg --files` and read.
No write or dependency operation resulted from that lookup.

Only this review was written. No Git, Lean, shared-state or cache operation was
run, and no additional tuple domain was enumerated. Source guards and final
readback precede freezing; the final review hash is reported separately. All
reviewer commands are stopped at handoff. The accepted plan still requires the
listed kernel obligations and separate affine semantic acceptance before the
classification can be advertised as formalized. The unrestricted goal remains
unresolved.
