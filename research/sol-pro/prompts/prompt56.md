AUDIT OF RESPONSE 55 AND PROMPT 56 — DIAGONAL HALL REFUTED; ATOMIC CONTRACTION OR CONTROLLED TOTAL LAYERS

Do not claim a proof or disproof of unrestricted Lonely Runner. Continue as
GPT-5.6 Sol Pro. Preserve the strict lower Gamma boundary, closed upper
boundary, and the distinction among proved-lean, proved-math, exact finite
computation, imported primary theorem, conditional result, conjecture, and
rejected strategy.

RESPONSE 55 AUDIT

1. Your feasible-total DIAGONAL-HALL statement is rejected, as you correctly
found. The exact attachment finds the first possible rectangle-domain failure
at (N,t)=(32,16), where Q={57}, four candidate rows are empty, the diagonal
matching has size 6/10, and the full Gamma graph has an explicit 10/10 SDR.
The exact 4,733-byte source and 687-byte output were recovered and replayed;
their SHA-256 values are

  c640d591c6e15b6b53dc91adc629e73ff244e1c273a4b08aa9423efcf5663f8e
  8ff94b024f96bc3c255d678751d1234927827ec2038688cbd89835b7615be43a.

2. A stronger independent obstruction must now be treated as authoritative.
At (N,t)=(36,16), ell=8, feasible starts S={11,12,13}, totals
Q={63,64,65}, and actual candidates C={20,21,22,23,24,25,26}. The retained
diagonal rows are exactly

  20:{43}; 21:{43,44}; 22:{41,43}; 23:{40,41,42};
  24:{41}; 25:{38,39}; 26:{37}.

Every row is nonempty, yet A={20,22,24} has neighborhood {41,43}, so Hall
fails by a genuine collision. The full Gamma graph is Hall-good via

  20->41, 21->40, 22->45, 23->39, 24->43, 25->38, 26->37.

Every pair satisfies 52<c+d<=72 and gcd(c,d)=1. Exact lexicographic
enumeration from the minimal possible N=32 proves (36,16) is the first
diagonal failure with every row nonempty. The tracked deterministic source
has SHA-256

  401a1323c2939c81507fbcd94a0ad7e9a588b4a0bfbe7c58d750bf2e69004937.

Therefore no rowwise coprimality argument can rescue feasible-total Hall;
useful non-diagonal Gamma edges are essential.

3. G1--G4 are accepted as proved-math. In particular, every saturating
matching maps a tight block bijectively onto its neighborhood; internal or
global rematching cannot dissolve tightness. Contracting a proper tight block
from a critical deficiency-one graph preserves critical deficiency one;
iteration yields a strict critical minor; and a deletion-perfect matching in
that strict core has root-spanning dependency reachability.

4. A stronger contraction result is now proved-lean independently.
MatchingContraction.lean defines U as all vertices reaching no bad vertex
relative to a supplied injective saturating matching. It proves U
successor-closed, bad-free, and tight; deletes U and M(U); constructs the
restricted injective saturating matching; lifts every marked-reaching path to
the residual; and proves strict Hall for every nonempty residual subset.
Declarations include

  nonReachingSet_tight,
  residual_every_vertex_reaches_bad,
  residual_strictHall.

All direct probes report only propext, Classical.choice, Quot.sound. This is a
decomposition of a graph with an already known saturation. It does not prove
the original Gamma graph saturable or make U empty.

5. Your PartialMatchingDichotomy.lean attachment compiles with two harmless
warnings. The tracked version removes the unused hx hypothesis and warning
noise and compiles. Your CoefficientTwoFeasibleStarts.lean attachment fails
at lines 98,107,141,146 because `dsimp made no progress`. Removing only those
four redundant commands yields a compiling tracked module proving
rectangleStartFeasible_iff. TightBlockRematching.lean compiles with one
warning, but the tracked contraction module strictly subsumes its main use.
An integrated project build succeeded and the expanded trust audit accepted
281 reports, standard axioms only. Do not call the unmodified feasible-start
attachment proved-lean.

6. H1 is accepted: every Gamma edge belongs to the unique total layer Q=c+d,
and a fixed layer is an injective partial matching. I1--I3 are accepted at
their exact strengths: prefix/suffix strip capacity, prime-cover union bounds,
and a cross-cut lcm-coprime bridge. J1 is accepted as a conditional
two-translation SDR class. None is uniform Gamma Hall.

7. The current exact gaps are GAMMA-ATOMIC-EXCLUSION, a controlled family of
non-diagonal total layers, CUT-OR-STRIP-OVERLOAD, and extension of J1 through
its gcd failures and cross collisions. Exact Gamma Hall, coefficient two in
every dimension, top-two, and unrestricted LRC remain open.

PRIMARY RESEARCH TASK

Pursue the following materially different strategies. Every claimed theorem
needs a complete proof. Test local monotonicity statements by exact search
before presenting them. Do not replace Gamma arithmetic by an arbitrary
interval graph, and do not infer uniformity from a finite sweep.

STRATEGY K — exclude an atomic contracted Gamma core.

Start with an inclusion-minimal Gamma-deficient core A. Contract every proper
tight block as in G2/G3 until every proper nonempty residual subset has strict
Hall and the whole residual has deficiency one. The residual right set is
irregular and is not itself Gamma(N',t'), so a bare induction on parameters is
invalid.

Find a property inherited from the original sliding coprime intervals that
survives deletion of tight-block neighborhoods and contradicts an atomic
critical residual. Candidate properties include ordered consecutive-ones
support before coprime filtering, exact exclusive-strip capacities, monotone
raw endpoints, and cross-cut lcm witnesses. State the first inheritance lemma
exactly. If contraction destroys it, give the smallest exact Gamma example
where it fails. Do not simply restate GAMMA-ATOMIC-EXCLUSION.

STRATEGY L — controlled non-diagonal total layers.

Use the exact layer identity Q=c+d. Feasible totals for the entire generic
band are too few. Seek a candidate-dependent or block-dependent interval of
totals whose union retains exact Gamma bounds and satisfies Hall. Collisions
obey Q-c=Q'-c' iff c'-c=Q'-Q, while missing an edge at c means every available
Q shares a prime with c.

Quantify the total interval required to overcome a coprime-free run in terms
of 2^omega(c), a Jacobsthal bound, or the exact Kanold theorem. Then control
collisions across candidates. A product over all candidates is unacceptable
without a usable interval-length bound. Separate the row-nonemptiness problem
from the Hall-collision problem exposed at (36,16).

An exact finite warning is already available. Expanding the feasible-start
interval symmetrically by radius r while retaining only exact Gamma edges was
tested on all 83,380 nonempty cases with 32<=N<=1000. Although radius at most
4 works through N=300, the row (N,t)=(841,420) requires radius 8. Its feasible
starts are {211,212}; candidate c=630 has no admissible coprime total through
radius 7 because Q=1472,...,1480 are all divisible by one of 2,3,5,7. At
radius 8, Q=1481 is coprime and the graph matches. The reproduced histogram
of minimum radii 0,...,8 is

  [81519,398,1159,134,166,0,3,0,1].

This is finite evidence, not a bound, but it refutes any casually inferred
fixed-small-radius claim and identifies the exact Jacobsthal obstruction.

STRATEGY M — synchronize cut bridges and strip capacity.

Combine I1--I3 over every ordered cut. Derive a global inequality summing
exclusive-strip deficits and cross-cut lcm-coprime witnesses without double
counting right vertices. The target is an explicit contradiction for an
atomic critical core, not a pairwise heuristic. State how one right vertex
can be charged across several cuts and why the total charge remains bounded.
Test the proposed inequality on all exact small Gamma graphs and particularly
on the Hall-good tight-block graph (20,10).

STRATEGY N — extend the two-translation class.

For c<=t, J1 uses N+c and requires gcd(c,N)=1. For c>t, it uses N-t+c and
requires gcd(c,N-t)=1; cross collisions have c1=c0+t. Add a bounded family of
translations or alternating swaps that handles shared factors and collision
chains. Preserve N<d<=N+t and N+t<c+d<=2N exactly. Give the smallest row
where any proposed bounded translation list fails.

FORMAL TASKS

Give Lean 4.32.1 source only for complete results not already formalized.

1. Formalize the conditional two-translation class J1 on top of the tracked
Gamma neighborhood definitions. Include both branches, gcd identities, exact
strict/closed sum bands, and cross-branch injectivity. Do not assume its gcd
or collision hypotheses uniformly.

2. Formalize one complete contraction lemma not already in
MatchingContraction.lean only if it adds genuine content, for example G2 for
a critical deficient Finset and an arbitrary proper tight block. Do not
redeclare nonReachingSet_tight or residual_strictHall.

3. If formalizing a strip lemma, state exact Finset intervals and boundary
guards. Avoid natural-subtraction ambiguity by proving the necessary order
hypotheses first.

For every attachment, state whether it was actually compiled. No sorry,
admit, custom axiom, placeholder declaration, `unsafe`, or unverified theorem
label is permitted.

REQUIRED OUTPUT

1. Status table with proved-lean, proved-math, computed, conditional,
   conjectural, rejected, and open labels.
2. Complete proofs for every new proved-math statement.
3. Exact counterexamples to failed local claims.
4. The first unsupported arithmetic implication on each surviving route.
5. Reproducible source, expected output, versions, domain, runtime, and
   SHA-256 for every computation.
6. No claim that unrestricted LRC is proved or disproved.
