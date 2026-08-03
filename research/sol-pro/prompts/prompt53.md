AUDIT OF RESPONSE 52 AND PROMPT 53 — FORMALIZE THE RECTANGLE CORE AND MAKE THE ASYMPTOTIC CUTOFF EFFECTIVE

Do not claim a proof or disproof of unrestricted Lonely Runner. Continue as GPT-5.6 Sol Pro. Preserve strict versus closed endpoints and distinguish proved-lean, proved-math, imported primary theorems, finite exact computation, conditional statements, conjectures, and rejected strategies.

RESPONSE 52 AUDIT

1. AFFINE-SUPPORT-ESCAPE remains rejected at (N,A,B)=(4,2,8). The corrected top-two frontier is disjunctive.

2. Your minimal Hall-deficient core theorem is accepted as proved-math. For inclusion-minimal deficient A, |Gamma(A)|=|A|-1, Gamma(A\{c})=Gamma(A), no right vertex is private, the induced incidence graph is connected, and deleting any left vertex leaves a perfect matching onto Gamma(A). The endpoint-overlap and private-strip restrictions are sound but do not exclude a core.

3. An independent exact strengthening is now authoritative. Under not Auto(c), Gamma(c) is the coprime part of

  [max(N+1,H-c+1), 2N-c],

whose length is N-max(c,t). Kanold blocks give

  |Gamma(c)| >= floor((N-max(c,t))/2^omega(c)).

The only empty candidate row is (8,4,6). The globally complete singleton-Gamma list has 22 rows, all with N<=19. Outside the four repaired selector failures, any new minimal deficient core must have N>=20, at least three left vertices, deficiency exactly one, connected incidence, and minimum degree at least two on both sides. The expanded deterministic verifier prints and checks the exact bounded classification. These graph properties alone do not contradict deficiency.

4. Your even two-rectangle construction is accepted. In c-coordinates, with

  a=floor(3(N-t)/4)+1,
  b=floor((N+t)/2),
  q=floor(t/4), ell=2q,
  a0=max(t-ell,b-2ell+1),

the adjacent left intervals C0,C1 of length ell cover [a,b] for t>=16, and the disjoint extra intervals D0,D1 lie in (N,H]. Every pair in C0 x D1 and C1 x D0 satisfies the exact band H<c+d<=2N. Pomerance’s published even-interval theorem therefore proves the generic Gamma selector for all sufficiently large N on the active 3t>N branch. Combining it with the Lean-verified 3t<=N theorem proves the coefficient-two bounded-height theorem for all sufficiently large dimensions. This is accepted proved-math using a primary imported theorem. It is non-effective and not Lean-formalized.

Primary input: Carl Pomerance, Coprime matchings, arXiv:2111.07157. The theorem used has an unspecified absolute constant and sufficiently-large ambient cutoff. Bohman–Peng arXiv:2109.09860 supplies an earlier weaker threshold. Neither paper directly states Gamma Hall.

5. The critical pair-energy inequality, exact Mobius overlap formula, and common-q sufficient criterion are accepted as proved-math. ENERGY-EXCLUSION remains conjectural.

6. Your common-g B2 class is no longer merely a Lean target. It was independently implemented in the tracked module CommonPivotBadCount.lean. The declarations

  commonPivotBadCount_eq_card,
  exists_commonPivotCandidate_of_sum_badCount_lt,
  commonPivotCandidate_avoids_unitMultiple,
  scaledCommonPivotTime_eq,
  simultaneousTopTwo_of_commonPivotBadCount

compile against Lean/mathlib v4.32.1. The final theorem has a Fin-indexed positive lower family, N>=2, g>0, 0<alpha<beta, both normalized top speeds coprime to N, and the exact strict bad-count sum below g(N-1). It returns both scaled candidates, lower safety, mutual top safety, and both real-time equalities. A clean 3,579-job build and 263-report standard-only trust audit passed. Treat this as proved-lean, but not unrestricted top-two.

PRIMARY RESEARCH TASK

Pursue three materially different fronts. Every proved-math claim needs a complete proof; every Lean claim must be exact repository-compatible Lean 4.32.1 source with no sorry/admit/axiom placeholder.

FRONT A — formalize the elementary rectangle reduction.

Give Lean-ready declarations for the arithmetic part of the two-rectangle theorem only. Do not encode Pomerance’s theorem as an untrusted axiom. Formalize natural floor/division guards and Finset intervals proving:

* C0 union C1 covers every c satisfying 2c<=N+t and 3(N-t)<4c;
* D0,D1 are disjoint subsets of {N+1,...,N+t};
* C0 x D1 and C1 x D0 satisfy N+t<c+d<=2N;
* two supplied coprime bijections on those rectangles combine to an SDR for every actual generic candidate subset.

State the conditional coprime-bijection inputs explicitly. Preserve the strict lower sum boundary and closed upper boundary. Identify the minimal existing Finset interval/cardinality lemmas and give code in dependency order. If full source is too long, provide the first exact compiling module and the next unsolved Lean goal.

FRONT B — make the asymptotic theorem effective.

Trace Pomerance’s proof to explicit constants, or replace it with an effective coprime-matching lemma sufficient for these specific separated rectangles. The target is an explicit computable N0, not “sufficiently large”. State every external analytic input with an effective version and numerical constant. Then estimate the remaining finite case count and propose a compact reproducible certificate architecture. Do not report a large search without source, expected output, versions, case count, and hashes. If Pomerance’s use of an ineffective or unstated constant blocks extraction, identify the exact lemma and stop there.

Also test whether the special geometry—left values in roughly [3(N-t)/4,(N+t)/2] and right values above N—permits a stronger elementary Hall proof than arbitrary interval matching.

FRONT C — exclude arithmetic critical cores directly.

Use the exact no-private-neighbor identities, near-perfect matchings after every deletion, minimum degree two, monotone endpoint overlap, and the Mobius pair-intersection formula. Develop at least two candidates:

1. a strict pair-energy or higher-moment inequality that exploits different prime supports across c;
2. an alternating-cycle/near-perfect-matching argument that converts a critical core into a common-q or two-hole witness.

Any proposed inequality must be tested against the four repaired small failures, the N=19 affine-charge collisions, and abstract deficiency-one graphs. State the first exact arithmetic implication not supplied by graph theory.

BOUNDARY AND LOGIC REQUIREMENTS

* Domain: 4<=N, 0<t, 2t<=N, H=N+t; use 3t<=N only through the verified coefficient-three theorem.
* Candidate C is a no-witness superset, not the actual missing set.
* Gamma uses N<d<=H, strict H<c+d, closed c+d<=2N, and gcd(c,d)=1.
* Do not infer an explicit cutoff from an existential published theorem.
* Do not add Pomerance’s theorem as a Lean axiom or claim its formalization.
* Preserve canonical pivot bounds, N not dividing numerators, strict badness, and closed safe equality.
* Do not confuse one witness per coordinate with one common witness.
* Any real-to-integer reduction must use the verified equivalence.

Required output order:

1. Status corrections, including B2 now proved-lean.
2. Lean-oriented rectangle module and exact compiler status.
3. Effective-cutoff audit with exact external dependencies.
4. Two distinct critical-core attacks and their first gaps.
5. Strongest new complete theorem.
6. Reproducible artifacts only if materially new.
7. Final status table.

Do not claim exact coefficient two, unrestricted top-two, or unrestricted LRC unless the exact canonical theorem is proved and independently verified.
