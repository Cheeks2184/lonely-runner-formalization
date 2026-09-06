# Independent review of the finite-grid horizon

Date: 2026-09-06. Task `/root/finite_grid_horizon_review`, in the requested
Astra/xhigh session `/root/uniform_seed_coupling`.
Source checkpoint: `8b9ea58d8a477a0fad733c3cf6674c307c1f9782`.
Owned output: this review only. The author manuscript was not changed.

**Disposition: accepted as a manuscript proof.** No mathematical defect or
missing theorem hypothesis was found in the frozen author source
`research/astra-finite-grid-horizon.md`, SHA-256
`1cd85650cc5ba679ad016c6b30f3604787c84e3bf86a4a90f11a82b9f653d865`.
The finite deficit argument proves the advertised half-open horizon for
arbitrary real phases and positive real frequencies, including b=1.
The insertion and optimized-tail consequences are sound. Root clarified
one phrase in the tail paragraph before the final freeze; the sole wording
change was verified and changes no contract. This is not a Lean or
unrestricted-LRC proof.

## 1. Exact finite theorem and independent derivation

Let b be an integer with b>=1, let `w_i>0` and `theta_i` be real for
`0<=i<b`, and choose any index j. Put

```text
P=sum_i 1/w_i,
H_j=((b-1)P+1/w_j)/b.
```

For every real a there exists `t in [a,a+H_j)` with
`||theta_i+w_i t||>=1/(2b)` for every i. Neither distinctness nor
integrality of the frequencies is required. All coordinates use this
one common t; the theorem does not choose label-dependent times.

Replace each phase by `theta_i+w_i a` and prove the assertion at a=0.
With `delta=1/(2b)`, set

```text
z=floor(1/2-b theta_j),
h=fract(1/2-b theta_j)/(b w_j),
t(k)=h+sum_i k_i/(b w_i),     k in {0,...,b-1}^b.
```

The real floor identity, without any rationality assumption, gives
`0<=h<1/(b w_j)` and `theta_j+w_j h=delta-z/b`.

For each label i, hold all coordinates except k_i fixed. The b phases on
this fiber differ by multiples of 1/b. For distinct residues the circular
distance is `min(d,b-d)/b>=1/b`, where `1<=d<=b-1`. If two phases both had
norm strictly below delta, the circular triangle inequality would give
distance below `2delta=1/b`, which is impossible. This includes wraparound;
the ordinary difference of phases need not lie in a chosen unit interval.
For b=1, the same at-most-one conclusion is simply the size of the fiber.

The anchor fiber, on which all coordinates other than k_j are zero, has
phases `(2(k_j-z)+1)/(2b)`. After subtracting any integer, the numerator
remains odd and hence has absolute value at least one. Every phase on this
fiber is therefore closed-good, including equality at delta. For b=1 this
is the unique assignment and its phase is an antipode.

Let `B=b^(b-1)`, the number of fibers for each coordinate. The bad subset
for each label has size at most B, and the anchor's bad subset has size at
most `B-1`: one entire fiber contributes zero rather than at most one.
Thus the union of the b bad subsets has size at most `bB-1=b^b-1`.
There is a surviving assignment, and it gives all the required closed
inequalities. Distinct assignments need not give distinct real times;
the counting is on assignments, so no such injectivity is required.

Finally every assignment satisfies

```text
0<=t(k)<=h+((b-1)/b)P<H_j.
```

This proves the claimed half-open support directly. In particular it
also proves the closed-interval statement; there is no continuity limit
or measure-zero endpoint issue hidden in the argument.

## 2. Support improvement, insertion and optimal tail

For fixed frequencies, minimizing H_j means minimizing `1/w_j`, so a
fastest anchor is optimal. Also

```text
P-H_j=(P-1/w_j)/b.
```

This is positive for b>=2 and zero for b=1. If all frequencies are at
least W>0, then `H_j<=(b-1+1/b)/W`. These comparisons are correct and
claim no optimality among all possible horizon proofs.

For insertion, the exact hypotheses are `N>=3`, `m=N-1-b>=1`,
`b>=1`, `2b<=N`, a positive slow maximum M, and one common slow seed s
at margin `1/(N-b)`. Define `eta=b/[N(N-b)]`. The Lipschitz inequality
protects every slow label at margin `1/N` on
`[s-eta/M,s+eta/M]`. The finite theorem supplies a fast witness inside
this interval whenever

```text
M((b-1)sum_fast 1/w_i+1/w_j)
    <= 2b eta = 2b^2/[N(N-b)].                       (G)
```

Indeed (G) is exactly `H_j<=2eta/M`. Apply the theorem with left endpoint
`a=s-eta/M`. Its half-open support is contained in the protected closed
interval even at equality in (G), and its fast margin `1/(2b)` is at
least `1/N`. Arbitrary fast phases are allowed; taking them all zero
gives the ordinary application without any shifted-LRC assumption.

At `N=2b`, (G) has right side 1. The bound
`min_fast >= (b^2-b+1)M` implies it, because the parenthesis is at most
`(b^2-b+1)/min_fast`. In this insertion specialization m=b-1>=1, so
b>=2. The separate horizon theorem still includes b=1 without restriction.
At b=1 and N>=3, (G) requires
`w>=N(N-1)M/2`, which is strictly stronger than the existing one-fast
threshold `(N-1)M`; there is no claimed one-fast improvement.

Here is the unambiguous optimized-tail contract. Sort positive distinct
speeds as `v_1<...<v_(N-1)` and set `m=N-1-b`. Among every m-element
slow set, complementary b-element fast set, and fast anchor, the minimum
left side in (G) is

```text
v_m((b-1)sum_(i=m+1)^(N-1) 1/v_i+1/v_(N-1)).       (Gmin)
```

Every candidate slow maximum is at least v_m; every candidate reciprocal
sum is at least the reciprocal sum of the b largest speeds; and every
candidate anchor reciprocal is at least `1/v_(N-1)`. The coefficient b-1
is nonnegative, all other factors are positive, and the tail partition
with global-maximum anchor attains all three bounds. This remains true
at b=1, when the reciprocal-sum term vanishes.

The final author source explicitly identifies the bound as the largest
slow speed `v_(N-1-b)=v_m`, agreeing with (Gmin). No theorem correction
is needed.

If every relevant slow subtuple has its own-margin witness and the full
tuple has no closed target witness, (Gmin) must be strictly greater than
`2b^2/[N(N-b)]` for every permitted b. This is a conditional necessary
arithmetic restriction, not a proof that some b passes the test.

## 3. The stronger profile still leaves selection open

The already authorized positive control
`N=7`, `V=(1,6,10,21,84,85)` fails the new test for every admissible b:

| b | Optimized left side (Gmin) | Required upper bound |
| --- | --- | --- |
| 1 | `84/85>1/21` | `1/21` |
| 2 | `21(1/84+2/85)>1/4>8/35` | `8/35` |
| 3 | `10(2/21+2/84+3/85)>20/21>9/14` | `9/14` |

These are all integers `1<=b<=7/2`. By optimality, changing the partition
or anchor cannot make the uniform bound (G) hold. This does not exclude
an actual seed-specific shorter support or success of another witness
argument. The tuple has the explicit common witness `43/168`, with norms
`(43,78,74,63,84,41)/168`, all greater than `1/7`.

The existing gluing report, whose relevant control section was reread,
establishes that this tuple has primitive and all deletion gcd one,
all required denominator coverage, every divisor/orbit capacity, the full
subset-gcd height bound, the earlier one-fast and spread exclusions, and
a connected label graph. It also fails all earlier discrepancy and
product-horizon tail criteria. The latter additionally follows here from
`H_j<=P`: failure of the better support test implies failure of the
product-horizon test. No new numerical experiment was needed.

Thus the finite theorem improves the conditional horizon and replaces
measure and limiting arguments with a finite, endpoint-exact proof. It
does not provide an arbitrary-N selection mechanism: the enlarged listed
arithmetic profile remains compatible with an actual positive tuple.
This control is not a counterexample to LRC and satisfies no no-witness
hypothesis. A contradiction using further seed geometry remains logically
possible, but is not established by these arithmetic conditions.

The finite projection and missing-zero-image implementation outline is
mathematically sound, including b=1. It is a suitable exact contract for
a future cohesive implementation if a caller needs it. This review does
not recommend a standalone implementation solely to enlarge the existing
profile; no unrestricted supply or next necessary caller has been proved.

## Source and check receipt

The initial author hash was
`5aa924b80112e1e526164e5679d2de0c411622618342da530c0c26173c968d91`.
After the wording clarification, the final author hash above was checked.
Reversing exactly that stated text replacement in memory reproduced the
initial hash, verifying that no other source content changed. This was
a metadata check, not a mathematical computation. The control source is
`research/astra-uniform-multi-fast-gluing.md`, SHA-256
`2c5c9b37758cd5e7c52d6db986bde5a11b77ea3cb95a3d09671563b5c527dd03`.
Its controls were originally derived and hand-checked in this session;
that existing result is used as a bound source, not independently
re-certified as part of the present author review.

Current project config, workflow, policy and focused state were read.
`python3 -B scripts/validate_workflow.py` exited 0 with the full output

```text
workflow structural validation passed; it cannot certify mathematical validity.
```

The review used exact symbolic reasoning and the displayed hand arithmetic.
No mathematical program, solver, enumeration, external literature claim,
Lean invocation or cache restoration was used. Only this review was
written; author sources, shared state and Git data were preserved.
Acceptance is of the frozen manuscript proof, not a kernel-checked theorem.
