# Uniform group insertion and the finite-grid horizon

Pass65 merged through PR64 at `8b9ea58d8a477a0fad733c3cf6674c307c1f9782`.
Both required CI jobs passed and root verified fetched main. This pass records
uniform manuscript results and exact limitations. It does not add a Lean
declaration or resolve unrestricted LRC.

The finite orbit-only Fourier relaxation is bounded by its supplied witness:
if p/q already supplies margin a/q, its nonnegative triangular-kernel weights
force c_0/f(0)<=a/q. Freeing the signs at every zero-weight sample does not
improve that value. The finite argument handles aliasing and closed endpoints
without a global-maximizer premise. The author and independent review retain
the exact coefficient/sample signs; this is not a general Fourier impossibility.

The group-insertion results split N-1 positive speeds into m=N-1-b slow
speeds and b fast speeds, with m>=1. A slow seed at margin 1/(N-b), slow
maximum M, and eta=b/[N(N-b)] protect an interval of length 2eta/M at
the desired margin 1/N. For 2b<N, the sharp periodic-pulse discrepancy
estimate supplies a full witness whenever

    M sum_fast 1/w_i <= b(N-2b)/[(N-b)(N-2)].

Equality is valid: a hypothetical strict open cover of the entire closed
interval extends slightly beyond it and contradicts the same bound there.
For b=1 the speed threshold is the existing (N-1)M condition, though the
existing formal theorem has finer displacement and signed-speed scope.

At 2b=N, a different argument supplies a finite horizon for arbitrary real
phases and positive real fast frequencies. Adding independent uniform increments
of lengths 1/w_i gives each runner an exactly uniform phase marginal on a
common compact time interval of length sum_i 1/w_i. A union bound below
1/(2b), followed by an attained maximum, retains the closed critical margin.
Only the auxiliary increments are independent; all runners use the same time.

A root finite-grid proof strengthens that horizon and removes integration
and limiting arguments. Choose an anchor j and align its phase at 1/(2b)
modulo 1/b. On the b^b candidate assignments

    t(k)=h+sum_i k_i/(b w_i),  0<=k_i<b,

at most one point of every coordinate fiber is strictly bad for its label.
One entire anchor fiber is closed-good, so the union of strict bad sets has
at most b^b-1 points. A surviving assignment lies in an interval of length

    H_j=((b-1) sum_i 1/w_i + 1/w_j)/b.

The proof includes b=1, arbitrary phases, noncommensurable real frequencies,
and every translated interval; it does not use a numerical enumeration.
It supplies conditional full insertion for 2b<=N under

    M ((b-1) sum_fast 1/w_i + 1/w_j) <= 2b^2/[N(N-b)].

At N=2b, minimum fast speed at least (b^2-b+1)M suffices. This improves
the period-sum criterion's b^2 M. The fastest anchor minimizes H_j; for a
fixed b, the largest-speed tail minimizes the entire insertion expression.
These are sufficient separation criteria, not a proof that such a tail exists.

The exact N=7 hand control (1,6,10,21,420,421) passes the two-fast
discrepancy test while all single-fast tests fail. The related tuple
(1,6,10,21,84,85) fails every permissible tail for all three displayed
criteria, despite having an explicit full witness 43/168 and satisfying
the earlier necessary arithmetic profiles. Thus even these stronger tests
leave a real gap in uniform partition/seed supply. The controls serve this
uniform mechanism; they are not a successive-runner-count research program.

For 2b>N, the separate manuscript constructs actual ordinary integer speeds
with arbitrarily large fast/slow separation whose fast bad sets cover one
entire protected slow-seed interval. This refutes that phase-independent
one-seed extension. It does not block every slow seed or disprove LRC.

Independent Astra reviews and root full reads check all three insertion
arguments and the Fourier restriction. The finite-grid review records the
minor clarification identifying the largest slow speed in the optimal-tail
comparison; the theorem itself needed no correction. These are manuscript
proofs. No cache restoration or Lean implementation is justified yet solely
by the availability of another conditional lemma. A useful next step must
supply a uniform partition/seed mechanism or exploit additional correlations
among bad events for actual common-origin integer speeds.

A separate audit rules out a direct upgrade of this particular grid to the
full target. At margin 1/N a q_i-point fiber has worst strict-bad count
ceil(2q_i/N). The summed bounds exceed the entire grid cardinality by
at least one, so a single anchor-fiber saving cannot force a survivor.
Ordinary common-origin phases give additional incidence savings and overlap,
but those elementary savings are still insufficient.

There is also an actual arithmetic obstruction, beyond failure of the bound.
For prime N>=3 and speeds 1,...,N-1, the only full-margin times modulo one
are p/N with p coprime to N. The N orbit points are pairwise separated by
at least 1/N, forcing equal circular spacing. At origin A=0, both the
zero-offset q=N-1 grid and the prescribed anchor-aligned grid have
denominators dividing 2(N-1)lcm(1,...,N-1), which is coprime to N.
Neither grid contains any full witness. This excludes precisely these
candidate grids and offsets; other grid sizes and translated offsets remain
available. In particular q=N contains the witness 1/N for this family.

The verification receipt binds the frozen reports, reviews and documentation
and preserves actual command output. Checkpoint validation covers byte bindings,
workflow consistency, whitespace and storage. A separate bounded exact q=N
grid screen found no obstruction among 1,140
triples from 1..20 (N=4) or 1,820 quadruples from 1..16 (N=5). This
is a bounded nonfinding for a single uniform candidate, with no domain
expansion or uniform conclusion. The receipt retains the actual executable
source and complete output. No solver or Lean build ran locally. The canonical
N=6 theorem remains established; the unrestricted canonical goal remains active.
