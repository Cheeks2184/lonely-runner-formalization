AUDIT OF RESPONSE 44 AND PROMPT 45 — LOGARITHMIC HEIGHT NOW FORMALIZED; QUADRATIC SHORTCUT REJECTED

Do not claim a proof or disproof of the Lonely Runner Conjecture unless every quantifier and bridge is supplied. Continue as GPT-5.6 Pro with multiple materially different routes.

INDEPENDENTLY VERIFIED RESULT A — full Lean theorem.

Let N,t>=1. If

  (4*(floor(log_2 N)+1)+1)*t <= N,

then every injective family of N-1 positive integer speeds bounded by N+t has one common real time at closed circular distance >=1/N for every speed.

The proof is now kernel-checked in Lean 4, without sorry, admit, custom axioms, native_decide, or hidden hypotheses. The exact formal statement is:

  theorem logarithmicHeight_family_witness
      {n N t : Nat} (speeds : Fin n -> Nat)
      (hnN : n+1=N) (ht : 0<t)
      (hpos : forall i, 0<speeds i)
      (hinj : Function.Injective speeds)
      (hbound : forall i, speeds i<=N+t)
      (hgrowth : (4*(Nat.log 2 N+1)+1)*t<=N) :
      exists tau : Real, forall i,
        (N:Real)^(-1) <= circleNorm (tau*(speeds i:Real)).

The checked proof extracts a genuinely missing c in [1,N]. If N+t<2c, 1/c works. Otherwise set

  start=N+c+t+1, ell=N-c-t,

so the candidate interval is exactly [N+c+t+1,2N]. A complete c-period handles ell>=c. For ell<c, absence of a coprime candidate gives phi(c)<=c-ell<=2t. The checked sharp estimate

  c <= (omega(c)+1)*phi(c),
  omega(c) <= floor(log_2 c) <= floor(log_2 N),

then contradicts N<2c+t and the growth hypothesis. A coprime q satisfies N<q<=2N and q-c>N+t, so the inverse of c modulo q excludes residues 0,+1,-1 and gives the closed 1/N witness. The explicit checked gain is

  u_N = N div (4*(Nat.log 2 N+1)+1).

An adversarial reviewer accepted all quantifiers, natural-subtraction guards, interval endpoints, and the equality q=2N. Exact computation independently checked 553,106 arithmetic triples through N=500 and all 361,220 admissible hole configurations through N=60.

First, audit this theorem independently. Identify the first invalid line if any. If accepted, seek a strictly stronger height theorem, not a restatement. In particular investigate whether a rigorous explicit upper bound for c/phi(c) in terms of log log c, usable uniformly with all small cases and no unjustified analytic import, improves the gain from N/log N toward N/log log N. State every imported number-theoretic theorem precisely and distinguish a new proof from a conditional consequence.

INDEPENDENTLY VERIFIED RESULT B — quadratic sufficient condition fails.

For the primitive tuple (1,3,5,6,7), n=5 and N=6, Response 44's quadratic lower bound H0-H1+alpha_5 H2 is nonpositive at every pivot. With alpha_5=7280/14641, its scaled pivot numerators are

  (-14722, 0, -324, -486, -972).

The full Chebyshev-score numerators over denominator 29282 are

  (-4, 0, 117112, 116148, 174696),

so the last three full scores are positive. The direct lonely time 7/30 has distances

  7/30, 3/10, 1/6, 2/5, 11/30.

Thus only the quadratic sufficient condition is rejected. Exact exhaustive calibration found no lower-dimensional failure among 126,768,878 primitive n=3,4 tuples of maximum at most 240, but this is not a global minimality theorem.

Work on three distinct routes:

ROUTE A — stronger bounded height. Starting from the accepted Lean theorem, derive the strongest rigorously explicit uniform replacement for omega(c)+1 or c/phi(c). Preserve all small cases, integer floors, t>=1, q<=2N, and the closed boundary. Give a theorem ready to formalize, its exact dependencies, and any finite exception certificate required.

ROUTE B — full Chebyshev/CRT score. Abandon the rejected quadratic shortcut. Either prove that some pivot has positive full prescribed Chebyshev score using a genuine cross-pivot CRT-table inequality, or find an exact all-pivot failure of the full score. Do not use D0, safe-residue enumeration, or full inclusion-exclusion as a disguised proof. A score failure is only a certificate failure; provide exact scores and a direct lonely witness when possible.

ROUTE C — residual minimal counterexample. Use least counterexample dimension before primitive sum minimality. Combine the now-formal logarithmic height restriction, divisor cover, deletion-gcd-one, comparable top, lcm/product bounds, terminal-interval restrictions, cross-pivot scaling, and signed-descent irreducibility. Derive a genuinely incompatible restriction or give an explicit infinite compatible family showing why the present conditions still coexist.

Required output: precise quantified statements; complete proofs or the first unsupported implication; explicit dependency lists; exact counterexamples/certificates and source when computational; several materially different strategies; and strict labels `proved`, `computed finite evidence`, `conditional`, `conjectural`, or `rejected`. Do not announce LRC solved from the bounded-height theorem or from Lean accepting a weaker encoding.
