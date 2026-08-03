AUDIT OF RESPONSE 54 AND PROMPT 55 — DEPENDENCY THEOREM FORMALIZED; CONTRACT TIGHT BLOCKS OR PROVE DIAGONAL HALL

Do not claim a proof or disproof of unrestricted Lonely Runner. Continue as
GPT-5.6 Sol Pro. Preserve strict versus closed endpoints and distinguish
proved-lean, proved-math, imported primary theorems, conditional results,
finite computation, conjectures, and rejected strategies.

RESPONSE 54 AUDIT

1. D1 and D2 are accepted and are now proved-lean independently. The tracked
`MatchingDependency.lean` works for finite types L,R, a decidable bipartite
relation, and an injective left-saturating matching. It proves exactly:

  `tight_iff_successorClosed_and_avoidsBad`

and

  `strictHall_iff_every_vertex_reaches_bad`.

The first theorem correctly includes the empty tight set; the strict theorem
quantifies over nonempty subsets. Both compile without warnings under Lean
4.32.1 and direct probes report only propext, Classical.choice, Quot.sound.

2. Your exact `HallDependency.lean` attachment, SHA-256

  267a5fbec1898ac53d49c4e86f9a4b0f776abc91a76224845256930abdd21722,

does not compile. Lean reports missing `DecidableEq R` at lines 45 and 53 and
`push Not made no progress at hnot` at line 142. Failed elaboration causes
generated declarations at lines 61 and 108 to be reported as using sorry,
although no literal `sorry` occurs in the source. The independent tracked
implementation, not this attachment, is the formal evidence.

3. D3 is accepted as a reachability dichotomy. Correct one wording: “exactly
one” is not justified as mutual exclusivity of the two existential outcomes.
If the current vertex reaches a bad vertex, the proof extracts an augmenting
path; otherwise its reachable set is deficiency one. An augmenting path from
the current vertex does not by itself exclude a different deficient subset
elsewhere.

4. The `(N,t)=(20,10)` obstruction is accepted and independently reproduced
with the exact Auto and generic candidate guards. The candidate rows are
exactly c=10,...,15 as displayed. Under the descending matching,
`{12,14}` is successor-closed, avoids bad vertices, and has common
neighborhood `{23,25}`. Vertices 12,14,15 do not reach bad. The full graph is
nevertheless matchable, so this refutes only strict reachability for that one
completed matching.

5. E1 and E2 are accepted as proved-math. For the active nonempty generic
band, the exact feasible starts are

  max(t-ell,b+1-2*ell) <= s <= min(a,N+1-3*ell).

The equivalence preserves coverage, right-height inclusion, strict lower
sum, closed upper sum, every t mod 4, t=16, and 2t=N. The tracked `a0` is the
least feasible start.

6. Your exact `GammaRectangleReversal.lean` attachment, SHA-256

  425bf751229bd0ae52412f95ad0a1316c82f4d0cd8341e3d64fbdec7de72e189,

compiles unchanged and is tracked as `CoefficientTwoReversal.lean`. Its final
theorem is now proved-lean. It is only the least-start fixed-total class under
the explicit premise that every actual candidate is coprime to that total.
The complete variable-start interval remains proved-math; DIAGONAL-HALL is
open.

7. F1--F3 are accepted as proved-math at their exact strengths. The endpoint
strip prime-cover inequality and prime-power/large-prime corollaries are local
exclusions. Candidate conditions do not force ENDPOINT-OVERLOAD. Alternating
coprime chains do not yield a monotone chain, common total, private neighbor,
or two-hole witness.

8. ENERGY-EXCLUSION remains rejected, not conjectural. At
`(14,6,{6,8,9,10})`, all proper subsets and the full set are Hall-good while
`m=4,e=9,p=9` gives equality 81. Do not restore the stale label.

NEW FORMAL AND COMPUTATIONAL INPUTS

The exact dependency criterion allows strict Hall to be checked by reverse
reachability after a saturating matching is known. A hardened deterministic
C++ audit independently validates every matching owner map and returns
nonzero on any mathematical/count regression. It reports:

* medium grid: 4,338 graphs, 3,557,016 candidate rows, no fallback/failure;
* endpoints: every 1001<=N<=20000 at t=floor(N/2), 19,000 graphs,
  49,898,384 rows, no fallback/failure;
* sparse active grid through N<100000: 887 graphs, 7,114,873 rows, no
  fallback/failure;
* `(20000,10000)`: 5,001 rows, 22,800,241 edges, strict Hall by dependency
  reachability, all 12,507,501 contiguous left intervals, minimum slack 1,145
  at singleton c=14910.

An independent exhaustive oracle checked the dependency implementation
against every subset of 527 small saturable graphs. These are finite evidence
only. Do not infer a uniform theorem or greedy invariant.

PRIMARY RESEARCH TASK

Develop at least three materially different routes from the now-exact
frontier. State complete lemmas with all quantifiers and give the first
unsupported implication for every incomplete route.

Strategy G — tight-block contraction and rematching.

Starting from descending greedy or another explicit Gamma matching, identify
the successor-closed bad-free tight blocks. Develop a canonical contraction
or Dulmage--Mendelsohn-style rematching operation that changes the matching
inside a tight block and either makes a vertex reach bad, merges adjacent
blocks, or produces a two-hole witness. Prove termination using an explicit
potential such as lexicographic matched-right vector, number/size of terminal
tight blocks, or endpoint span. Ordinary abstract matching theory cannot
prove strict Hall; the local step must use exact Gamma endpoints and
coprimality. Test every proposed monotonicity lemma first at `(20,10)` and
give the smallest exact Gamma counterexample when it fails.

Strategy H — diagonal Hall for all feasible reversal totals.

Let S be the exact feasible-start interval and Q_s=N+s+2ell. Study the graph

  c ~ Q_s-c iff s in S and gcd(c,Q_s)=1.

Use the exact collision equation `Q-c=Q'-c' iff c'-c=Q'-Q`. Seek a Hall proof
by ordering diagonals, interval bigraph methods before gcd filtering, an
augmenting argument across neighboring totals, or a prime-cover bound showing
that no candidate subset can block every diagonal. Do not apply Kanold to the
product of all candidates without a usable interval-length inequality. State
whether the diagonal graph can itself fail Hall on a finite exact row; if so,
give the smallest row and determine whether Gamma still matches.

Strategy I — endpoint prime-support overload plus alternating chains.

Combine the exact endpoint-strip prime-cover inequality, dual strict Hall,
exclusive strips, c2-c1<2^omega(c1), and alternating coprime paths. Seek a
quantified theorem forcing one of: a private Gamma neighbor; a diagonal
augmentation; an automatic above-height complement; or a two-hole witness.
Account for shared lcm prime support explicitly. “Averaging” or “many primes”
without a displayed inequality is not a lemma.

Strategy J — a different arithmetic matching family.

Construct a bounded explicit family of matchings not based solely on the
least free neighbor or one reversal total. Candidates include shifts of
reversal totals, modular inverses on short blocks, or prime-by-prime switchings.
Use the proved-lean dependency theorem to reduce correctness to reachability,
but supply the arithmetic local step. Separate a complete special class from
any proposed uniform extension.

FORMAL TASKS

Give Lean 4.32.1 declarations only for complete results:

1. a partial-matching augment-or-deficiency theorem with wording that does not
   claim unproved mutual exclusivity;
2. the full feasible-start iff theorem on top of
   `CoefficientTwoRectangle.lean`, including natural-subtraction guards;
3. any valid fixed-block rematching lemma surviving `(20,10)`;
4. do not redeclare the already proved fixed-matching or fixed-reversal
   theorem unless materially strengthening it.

Do not declare Pomerance, GAMMA-AUGMENT, DIAGONAL-HALL, ENDPOINT-OVERLOAD,
exact Gamma Hall, coefficient two, top-two, or LRC as axioms or premises
disguised as definitions.

BOUNDARY REQUIREMENTS

Preserve `4<=N`, `0<t`, `2t<=N`, exact Auto exclusions, all 22 nongeneric
rows, strict `N+t<c+d`, closed `c+d<=2N`, natural subtraction, empty candidate
sets, and the canonical pivot convention. Any computation must include source,
expected output, commands, versions, exact domains, deterministic seeds, and
hashes.

Required output order:

1. Status corrections and exact accepted compiler evidence.
2. Tight-block contraction/rematching route.
3. Diagonal-Hall route and finite obstruction search.
4. Endpoint/prime-support alternating-chain route.
5. Distinct arithmetic matching family.
6. Lean declarations for complete lemmas only.
7. Exact first gap for every incomplete route.
8. Final status table with no unrestricted completion claim.
