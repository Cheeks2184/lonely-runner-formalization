# Response 51 audit: corrected transversal and coefficient-two frontiers

Status: **accepted only as partial mathematics**. Response 51 does not prove
the top-two pivot conjecture, the coefficient-two bounded-height theorem, or
unrestricted Lonely Runner.

## Recovery and provenance

Prompt 51 was submitted in the signed-in Chrome conversation after explicitly
selecting GPT-5.6 Sol Pro. Its exact archived text has 9,156 characters, 9,172
UTF-8 bytes, 133 line feeds, and SHA-256

```text
0a5f3cc5e30e2f51aa1159643edaeb304af9efe243835a99992a2f8ac1f04df0
```

The recovered response begins `Status corrections`, has 18,958 UTF-8 bytes,
and has SHA-256

```text
3954d503b79a9724008fb407816fb40e53eff714328e2e16f0830b0a012509b8
```

It supplied no attachment or computational artifact.

## Strategy A: one lemma accepted, the target rejected

The affine-support inclusion A1 is sound. If the same lower-speed set covers
both robust top grids, choosing one spoiler at each endpoint and lifting both
strict inequalities to the common cyclic group puts every occupied robust
phase in one of the displayed difference sets. This is only a necessary
condition for a simultaneous cover.

The proposed uniform `AFFINE-SUPPORT-ESCAPE` statement is false. At

```text
(N,A,B)=(4,2,8)
```

the `A`-robust candidate grid is empty: every `A`-pivot candidate is spoiled
by the other top speed. Consequently the robust affine support is empty and
is contained in every union of difference sets, even for an empty lower-speed
set. This also refutes the stronger unconditional demand for a paired shift
family with transversal number greater than `N-3`.

This is not a top-two counterexample. For the speed tuple `(1,2,8)`, pivot
`B=8` and numerator `r=9` give residues at distance `(9,14,8)` modulo `32`,
so all three closed thresholds are met. The correct paired frontier is the
disjunction

```text
kappa_A > N-3
or kappa_B > N-3
or both robust grids are nonempty and some selected robust-pair family
   has transversal number > N-3.
```

The tracked `TopTwoTransversal.lean` proves the sound abstract bridge: a set
covering both robust grids is a two-sided transversal, and a lower-speed set
which is not such a transversal yields a complete certificate at one of the
two top pivots. It asserts no uniform existence premise.

## Strategy B: valid conditional special classes

The large-gap interval argument B1 is correct only with the exact domain of
the Lean fastest-pivot theorem made explicit: the selected `a` must be a
positive lower bound drawn from the nonfastest speeds, and `A` must be a
positive upper bound for every nonfastest speed. Under those hypotheses,
`L<U` supplies two consecutive integers in the closed interval, at least one
of which is not divisible by `N`. The displayed algebraic inequality is a
sound sufficient condition. This is a corollary of a proved-Lean theorem, but
Response 51 did not itself supply a formal declaration.

The common-`g` bad-count argument B2 is sound as a conditional manuscript
theorem: the strict union bound leaves a candidate `u`; coprimality of the
normalized top speeds with `N` preserves candidate membership after scaling;
and the cyclic-distance scaling identities give both top certificates. Its
dependency on the exact bad-set cardinality theorem is explicit. The response
nevertheless labels a prose proof as its strongest complete special class and
does not provide checked Lean code. It remains an audited formalization target,
not a new Lean-verified result.

The displayed example `(7,14,21,28,35,42)` is just a scaling of the saturated
family `(1,2,3,4,5,6)`, so it does not demonstrate the claimed strict
extension. The theorem itself does extend beyond that class. For example, at
`N=7`, take `g=7`, lower speeds `(7,14,21,35)`, `A=56`, and `B=63`; the four
lower bad counts vanish and `u=1` supplies the common grid candidate.

## Strategy C: structural reduction, not a repair theorem

The generic coefficient-two observations are sound under their stated band
hypotheses: only multipliers two and three can block a reciprocal, every
selected `3*c` is extra, and the extra-blocker graph has maximum degree two.
Its left-heavy components have the displayed powers-of-two/powers-of-three
path form.

The proposed `CHAIN-REPAIR` is not a quantified theorem and has no proof. In
particular, an isolated hole can be blocked by an occupied internal `2*c`, and
unrelated occupied values can block a suggested complementary repair. The
response does not control these possibilities or close the thirteen residual
rows. Therefore Strategy C stops before the required implication.

The sharper surviving frontier, on the exact domain `4<=N`, is the
complementary-hole relation `Gamma`
in [the coefficient-two audit](coefficient-two-gamma.md). Under no witness,
every `Gamma(c)` neighbor of a missing candidate `c` must be occupied. A
uniform Hall theorem for this sliding coprime interval family would close
coefficient two. Exact tests through `N=300` find four repaired finite
exceptions, but the Hall theorem is conjectural.

The domain guard matters: at `(N,t)=(3,1)`, `C={2}` and `Gamma(2)` is empty.
This would be a fifth selector exception if `4<=N` were omitted, although the
row is already discharged by `threeHeight_family_witness` since `3*t<=N`.

## Final classification

| Claim | Audited status |
| --- | --- |
| Affine-support inclusion A1 | proved mathematics |
| Uniform affine-support escape | refuted by `(4,2,8)` |
| Corrected abstract two-sided bridge | Lean-verified locally |
| Large-gap interval class B1 | proved mathematics from a Lean-verified input |
| Common-`g` bad-count class B2 | proved mathematics; not yet formalized |
| Generic blocker-path structure C1/C2 | proved mathematics under stated hypotheses |
| `CHAIN-REPAIR` | conjectural and insufficiently quantified |
| Uniform `Gamma` Hall selector | conjectural; finite evidence only |
| Unrestricted top-two and LRC | open |
