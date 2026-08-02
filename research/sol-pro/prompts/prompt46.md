AUDIT OF RESPONSE 45 AND PROMPT 46 — EXACT PRIMORIAL THEOREM ACCEPTED; A MUCH STRONGER JACOBSTHAL ROUTE FOUND

Do not claim a proof or disproof of the Lonely Runner Conjecture. Continue as GPT-5.6 Pro, preserve every strict/closed endpoint, and label imported, proved, conditional, computed, conjectural, and rejected claims separately.

RESPONSE 45 AUDIT

1. The audit of the kernel-checked logarithmic-height theorem is accepted.

2. The exact primorial-ratio theorem is mathematically accepted after an independent algebra audit. Let P_k be the largest primorial at most N and Q_k=product_{i<=k}(p_i-1). For every 1<=c<=N,

  c Q_k <= phi(c) P_k,

and P_k/Q_k is exactly max_{c<=N} c/phi(c), attained at c=P_k. In the short interval branch, phi(c)<=2c+t-N and 2c<=N+t imply

  N Q_k <= (4P_k-Q_k)t.

Thus the strict hypothesis

  (4P_k-Q_k)t < N Q_k

gives the claimed witness, and the exact largest integral gain is floor((N Q_k-1)/(4P_k-Q_k)). Equality gives no conclusion. This is a valid partial theorem, not LRC.

3. Both attached sources were recovered byte-for-byte. Their SHA-256 hashes match your report:

  prompt45_cheb_grid.cpp:
  68d23c43a8fdc9b7d67a09ebb23d02ce6f72719ea2874c35a49eaa9c664b6a6d

  prompt45_primorial_residual_verifier.py:
  f766d44fd2937b0bb3ab85d5e47b3dd21be06e36c831a9faa7eff3dcfddd3653

The Python verifier ran independently, and its output hash is exactly

  9e703e7d4209f2853fae3ed9c291a70ed371db22bc9e7f30339405bdc6e10ecd.

The long C++ grid replay is still running and is finite evidence only.

4. The active-terminal residual family is accepted after direct checking. For N>=10 it consists equivalently of the small fillers 2,...,floor(N/2), together with N and the even values 2*ceil(N/2),...,2N-2 (with set union removing duplication). It has N-1 distinct positive speeds, deletion gcd one, divisor cover, comparable top, active terminal interval, blocked largest-speed signed descent, and the direct closed witness 1/(2N). It shows compatibility, not a counterexample.

5. The Rosser-Schoenfeld attribution was checked against the primary 1962 paper, Theorem 15. The universal 2.50637 version follows from its 5/2 bound plus the one listed exception. However, do not prioritize formalizing this analytic theorem because the following much stronger route has now appeared.

NEW ROUTE A — KANOLD/JACOBSTHAL LINEAR HEIGHT

Let g(c) be the least positive L such that every L consecutive integers contain an integer coprime to c. Kanold's classical bound is

  g(c) <= 2^omega(c),

where omega(c) is the number of distinct prime divisors. The cited primary source is H.-J. Kanold, “Über eine zahlentheoretische Funktion von Jacobsthal,” Math. Ann. 170 (1967), 314–326, DOI 10.1007/BF01350607. Later primary papers explicitly restate the same convention and bound.

This appears to imply the following much stronger theorem:

  Let N,t>=1 and n+1=N. For every positive injective family of n integer speeds bounded by N+t, if 6t<=N, then there exists one real tau with circleNorm(tau*a_i)>=1/N for every i.

Proposed deduction. Choose a missing c in [1,N]. The reciprocal branch handles N+t<2c. Otherwise 2c<=N+t and set

  start=N+c+t+1,
  ell=N-c-t,

so Ico(start,start+ell) is exactly the inclusive integer interval [N+c+t+1,2N]. For c>=7, prove

  5*2^omega(c) <= 2c.

Also 6t<=N and 2c<=N+t imply

  5ell >= 2c.

Hence ell>=2^omega(c)>=g(c), so I contains a coprime q. The existing checked inverse bridge supplies the closed witness, including q=2N.

The cases c=1,...,6 have exact g-values (1,2,2,2,2,4) and require a separate complete arithmetic proof. An exact audit found no failure among all 30,016,120 admissible (N,t,c) triples with N<=1000. The same local selector with coefficient 5 fails at (N,t,c)=(11,2,6), where I=[20,22] contains no integer coprime to 6; this rejects only that selector proof, not a possible coefficient-5 family theorem.

First independently audit every line. In particular:

- use the exact least-length convention for g(c), with no off-by-one change;
- give a complete proof of 5*2^omega(c)<=2c for every c>=7, including omega=0,1,2 and nonsquarefree values;
- give a complete symbolic or finite-table proof for c<=6 under 6t<=N and 2c<=N+t;
- verify ell>0 and every natural-subtraction guard;
- verify that Ico(start,start+ell) ends at 2N+1 and therefore includes q=2N;
- state whether 6 is optimal only for this selector argument or for the full bounded-height theorem.

Then reconstruct Kanold's bound as a self-contained finite combinatorial proof suitable for Lean 4. Do not merely cite it or introduce it as an axiom. Decompose it into explicit lemmas over Finset/intervals/Coprime, identify the induction invariant, and give the first genuinely difficult Lean goal. If a faithful self-contained reconstruction cannot be supplied, say exactly where it stops and keep the resulting height theorem conditional.

ROUTE B — FORMAL FALLBACKS

If the Kanold reconstruction is too long, give a Lean-ready decomposition of the accepted exact primorial-ratio theorem. Separately assess the independently compiled square-root-log fallback based on

  c^2 <= 8*omega(c)*phi(c)^2,

which would give c<=2*(sqrt(2*omega(c))+1)*phi(c). The Wallis recurrence, prime-slot bound 2*|s|<=max(s)+1, and final square extraction already compile in scratch Lean. The missing bridge is precisely the prime-factor product/totient inequality above. Supply a clean proof or identify the obstruction.

ROUTE C — EXACT PIVOT FRONTIER

Continue the full prescribed Chebyshev/CRT score rather than the rejected quadratic projection. Either derive a genuine cross-pivot signed CRT-table inequality or find an exact all-pivot failure. No safe-residue enumeration, D0, or full inclusion-exclusion may be disguised as a proof. Report finite searches only as finite evidence.

Required output: exact quantified theorem statements, complete proofs or the first unsupported implication, explicit source/dependency list, a Lean-oriented lemma graph, exact counterexamples/certificates, and several materially different routes. No unrestricted LRC completion claim is permitted.
