# Independent review of the bounded four-runner canonical bridge plan

Assigned Astra/xhigh review by `/root/mss_published_bound_audit` at
`0e49249d9fcbba5e4a8312d845224bc11466db76`. Only this review and the separate
deletion-gcd review are owned. Current configuration, workflow, policy and
active state were read; the workflow validator passed. Requested routing is
recorded, not independently attested runtime metadata. No Lean implementation
is part of this review.

**Verdict: accept the plan at its exact bounded scope. No mathematical
correction is required before implementing steps 3a–3c.** Its formerly pending
C4 premise is now supplied by the separately accepted, committed four-runner
mixed classification. The plan's historical pending wording is accurate to its
authoring stage and need not be rewritten. New ordinary, H5, bounded-real and
canonical declarations remain implementation obligations; this review does not
claim they have been built or audited.

## Ordinary triples and H5

For positive a<b<H, off the scaled exceptional shape, C4 supplies one positive
time and weakening the fastest third bound gives all three quarter bounds.
For (a,2a,3a), t=1/(4a)>0 has phases (1/4,1/2,3/4), hence ordinary norms
(1/4,1/2,1/4). Sorting via `exists_strictMono_reindex` points from sorted
positions to original labels, so evaluation at `e.symm i` restores each input
label at the same time. Only ordinary bounds are transported; no original
label is incorrectly designated fastest.

The exact `LowerCountPositiveIntegerHypothesis 5` definition asks for distinct
positive natural rows of dimensions d=1,2,3, with bounds 1/(d+1). The first
two existing small-count theorems and the just-described ordinary triple
theorem discharge these cases. It is H5, not a five-total-runner theorem.
The concurrent `FourRunnerOrdinary.lean` implementation is outside this plan
review and is not used as an established premise here.

## Strict orbit transfer and bounded real reduction

The proposed helper `exists_stationaryStrictWitness_of_relations` has exactly
the right assumptions: real rows u,z on `Fin m`; arbitrary real delta,tau;
every integer linear relation vanishing on u also vanishes on z; and a single
tau with all z norms strictly above delta. The existing
`orbitHom_mem_closure_range_of_relations u z tau` has this precise relation
direction and puts the target in the closure of the full real u-orbit.
The set of torus points with every coordinate norm >delta is open, since the
index type is finite and coordinate norm maps are continuous. The target
lies in this open set, so `mem_closure_iff` supplies an actual orbit point in
it. Its one real time works for every coordinate. No rationality, positivity,
injectivity, count-supply premise or uniform positive slack must be added to
the helper. The finite intersection already handles coordinatewise strictness.
The helper also permits m=0; its conclusion is then vacuous and satisfiable.

This is a direct extraction of the final open-set block of
`exists_stationaryWitness_of_rational_collision`. That older theorem takes
the global `PositiveRationalConjecture`; the extracted block does not use it.
Calling the old global theorem with a fixed-count premise would be invalid.
Adding the helper while preserving the old theorem type avoids this leakage.

For the proposed `positiveRealWitness_of_lowerCount`, m>=1 and H_(m+2)
cover exactly distinct positive natural rows of sizes 1 through m.
The two branches require different instantiations of the same bounded
rational-collision lemma:

* Irrational ratio: its two indices differ because each positive self-ratio
  is one. Thus m>=2. The actual BHK theorem returns a nowhere-zero rational
  row w, the required real relation implication, and
  card(image(abs(w)))<m. Restrict H_(m+2) to H_(m+1) by the inequality
  `(m+1)-2 <= (m+2)-2`. At N=m+1, the bounded lemma's conditions are N>=3,
  positive row length m, and magnitude count <=m-1; all follow. Its output
  is the closed margin 1/(N-1)=1/m. Since m>0,
  `1/(m+1)<1/m`, every target coordinate is strictly above the desired
  threshold. Apply the new open-set helper and then weaken strict to closed.
* Rational ratios: select q_i=u_i/u_first in the rationals. Each q_i is
  positive and nonzero; repetitions are allowed. Its absolute-value image
  has cardinality <=m by `Finset.card_image_le`. At N=m+2 the bounded lemma
  requires exactly this weak bound, not a collision pair. Its existing proof
  enumerates actual distinct magnitudes, clears their positive rational
  denominators, obtains the smaller-dimensional witness, and returns it to
  every original occurrence with margin 1/(N-1)=1/(m+1). For the resulting
  tau, t=tau/u_first preserves phases exactly. The denominator is positive;
  the conclusion requires only a real time, so no extra time-sign argument
  is needed. The m=1 boundary belongs to this branch and uses N=3.

In particular, m=3 uses H4 and margin 1/3 in the irrational branch, but H5
and margin 1/4 in the rational branch. Using N=m+2 for both calls would lose
the strict margin needed by the open-set argument. The plan explicitly avoids
that error. Importing modules which define global conjectures does not itself
assume those conjectures; no proposed proof step calls such a global premise.

## Signs, original labels and import direction

The signed wrapper applies the positive result to abs(v_i), using nonzero
input coordinates for positivity and `circleNorm_mul_abs_right` to recover
each signed phase. Distinct signed speeds may have repeated magnitudes;
the positive result deliberately has no injectivity assumption. For a chosen
label r among four original distinct real speeds, the `Fin 3` row
`speeds(r.succAbove i)-speeds(r)` is nonzero by the existing helper.
Every other label occurs in this row by `Fin.exists_succAbove_eq`.
At m=3 the bound is the original 1/4, and
`lonelyAt_iff_relativeLonelyAt` returns the actual quotient-circle distance.
Thus arbitrary real speeds, signs, translations, chosen labels, and closed
quarter equality are preserved. The canonical time domain is all reals.
Positive time can be added separately by excluding zero and reflecting;
it is not a missing hypothesis of the literal canonical specialization.

Root's subsequent integration refinement is also accepted: expose the same
labelled bridge generically, then specialize it at m=3:

```lean
theorem lonelyAt_of_lowerCount {m : ℕ} (hm : 1 ≤ m)
    (hLower : LowerCountPositiveIntegerHypothesis (m + 2))
    (speeds : Fin (m + 1) → ℝ) (hinj : Function.Injective speeds)
    (runner : Fin (m + 1)) : ∃ t : ℝ, LonelyAt speeds runner t
```

The complement of runner is exactly `Fin m`; the signed stationary bound is
1/(m+1), equal to the original total-runner threshold. For m=1 this is the
ordinary two-total-runner threshold, so there is no lost smallest case. The
generic helper is conditional on H_(m+2) and does not establish additional
counts by itself. `fourRunners` then specializes m=3 with the new H5 theorem.
Hosting this helper in `BoundedRealReduction` requires the additional import
`StationaryEquivalence`, which itself imports only `Formulations`; it creates
no cycle or dependency on the four-runner classification.

The proposed file directions are acyclic. `LowerCountSupply` remains
independent of C4. `BHKCollisionToWitness` need not import bounded supply to
host the strict helper. `BoundedRealReduction` imports only bounded supply,
the finite BHK collision construction and the strict-transfer module.
`FourRunnerCanonical` can import that module, `FourRunnerOrdinary` and the
existing stationary-label bridge. I checked these proposed edges against the
current local import graph. Global equivalence declarations can remain intact.

H5 supplies the final four-total-runner specialization after steps 1–2 are
implemented. A five-total-runner tuple has four moving coordinates and would
need H6, including a four-moving natural statement absent here. No N=5 claim,
fastest-third bound for general real tuples, or unrestricted LRC conclusion
follows. These are reviewed implementation contracts, not new kernel proofs.

## Provenance and reproducible checks

The author plan hash is
`9f752fa91fcbf56bb80d1a8a424697801e21b78262bc1315c138431c2e160f0c`.
Its sole Python block was independently replayed in memory after checking
that hash and program SHA
`6e5ecddab2f0bfe3781ac219d8300726eb5daf3dd90ffb0d67167751561efd92`.
It verified all 15 interface hashes below and their byte equality to its
historical base `7e1b4073cfd0095a3e514df975313562feb82688`. It exited zero and
reproduced stdout SHA
`56b4f981f84181586e284f41628874900bf74a8178ca2bac34f4e2327ae21aa8`:

```text
PASS: 15 stable interface hashes and assigned-base byte comparisons
```

The small independent import check reads only local import lines, overlays
the proposed three additive module edges stated above, and performs a DFS
cycle check from `FourRunnerCanonical`. It passed, additionally checking that
`LowerCountSupply` does not reach C4 and `BHKCollisionToWitness` does not reach
`LowerCountSupply`. The later generic labelled-helper refinement adds only
the acyclic `StationaryEquivalence` import described above. No Lean command,
tuple enumeration, external retrieval,
dependency operation or cache rebuild was needed for this plan audit.

```text
5f0258a6ab99950fc7045b2200d6708fe7603d3caa4d62855ef2b19a330c95aa  LonelyRunner/Definitions.lean
0c3328e975bee236ff66862d3a5cadeb58fbc7c804fa953e53701ba466b9d788  LonelyRunner/Formulations.lean
31e2c328e060c077c6c9928e3fb431601326e4e54a949ee5148aed5cd3687d1f  LonelyRunner/BaseCases.lean
e4933da3551792130eebf1ede4701bff3296f59eb696dfb7b6276e16d940d699  LonelyRunner/SmallDimensions.lean
71b47c20282d091129fe9990b2d1bbdfdebff45e49dea2bfbd7d4425fe89f775  LonelyRunner/FiniteTupleSorting.lean
0705291adc53011fb72fc718a7260876512b092741442d6a6cceb4b76eb5ccf4  LonelyRunner/LowerCountSupply.lean
c707227a24eb53d06b20ff00e2e86ce52c158ba7eed55c1d8eba32cf9c457a4e  LonelyRunner/RationalReduction.lean
20193ad984f308ce8512930fe683d3118a2b3b5c18636a6a1f4454aa6df43797  LonelyRunner/Normalization.lean
12dce8930c34b211bc01e2dc21e932087270726bce2bf127fa2d8d6594544b49  LonelyRunner/StationaryEquivalence.lean
98d7c878eef7e4a3b7f7c504c882cf35191c1343816a59d731193ac8a207ed26  LonelyRunner/BHKRealReduction.lean
7569f6798bc42be6ffd5ae04e0f8110f386f941aa58f02a2f168d597a17a514e  LonelyRunner/BHKPositiveCollision.lean
42e7665af7981ef336ab4e1826ff3f096e6d6855b50440f76e2ede7a538f7f87  LonelyRunner/BHKCollisionToWitness.lean
50e0ff4babbe451598f84ada0907180bb17b0a8f8ae5aa84d7cb923d227c4198  LonelyRunner/KroneckerSeparation.lean
dda82d1f8830d961499292656c3dfac884a471ad5ef38bd925b1a25c403603a5  LonelyRunner/FastRunnerInsertion.lean
5328a7a88d2b42f86ffc3f0f0418ca22c761219e8fa3e5822bda5a18ac286e8c  LonelyRunner/StructuredClasses.lean
```

C4 is separately bound to `FourRunnerMixed.lean` SHA
`ae47b419c5b4cebfa72a325bdb50cd32e03444c39850a74b885037d83e312a5c`
and its accepted formal review SHA
`07ce0bc6831899c3ac3f00482f7143b5daaff5ea0dacee284d0038c12742ca4b`.
The new implementation should retain the plan's stated contracts and receive
separate source/type/axiom review after the focused and full checks. In
particular signed repeated magnitudes and a nonstationary chosen runner must
be included among its semantic controls.

The 15-interface readback was performed before the concurrently authorized
generic implementation began. These hashes bind the inspected interface base,
not the unfinished implementation's future bytes. The author plan and accepted
C4 artifacts remain separately guarded at this review's freeze.

All review commands concerning this plan stop at its freeze. No Lean, shared
state, Git data or cache was edited. Only this owned review was written for
this first subtask; the deletion-gcd review is separate. The final raw review
hash is reported externally. The unrestricted canonical goal remains open.
