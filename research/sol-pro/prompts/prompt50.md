AUDIT OF RESPONSE 49 AND PROMPT 50 — COEFFICIENT THREE IS LEAN-CHECKED; ATTACK THE EMPTY COMMON-SLICE FRONTIER

Do not claim a proof or disproof of the Lonely Runner Conjecture. Continue as GPT-5.6 Sol Pro. Preserve strict versus closed endpoints and distinguish proved-lean, proved-math, conditional, computed, conjectural, and rejected results.

RESPONSE 49 RECOVERY AND FORMAL AUDIT

Chrome's virtualized `Copy response` controls were not enumerated chronologically. The actual Response 49 begins `Status corrections`. Its raw CRLF clipboard representation has 16,115 characters, 16,192 UTF-8 bytes, and SHA-256

  b553c921e824c2ee3769442e439a64842000ef4c8d2ec0aee151e8b9a33613ff.

Its LF-normalized preserved representation has 15,400 characters, 15,477 UTF-8 bytes, 715 LF characters, a final LF, and SHA-256

  25168ac758f8be28ca31eee9e9b8d2e22b4cbd762ca7e57dbbbe0e98b3a1838a.

Your mathematical saturated-class proof, fastest interval compression, common-grid count/union criterion, and coefficient-four proof were independently audited and accepted within their stated scopes. None proves global top-two or unrestricted LRC.

Your attached saturated Lean source with SHA-256

  7f112ac4b2f2f281d609cc393521fe3d6d73a193ecd0830536692f834c9c4072

does not compile under Lean 4.32.1/mathlib v4.32.1 and remains rejected as formal evidence. The first failures were:

  line 66: rewriting N=(N-1)+1 also rewrites inside N-1;
  line 117: product/natural-subtraction goal not closed;
  line 143: positivity goal not closed;
  line 148: incorrect use of dvd_add_iff;
  line 178: natural-subtraction rewrite failure;
  line 192: complement inequality proved in the wrong orientation;
  line 236: inverse inequality elaboration failure;
  line 249: an extra tactic after the goal is closed.

Later goals were not treated as validated. An independent tracked implementation proves the saturated theorem under canonical pivotCandidates and pivotBadResidues, so the mathematics is retained but your attachment is not.

CURRENT VERIFIED FORMAL STATUS

1. `fourHeight_family_witness` is proved-lean under maximum speed `N+t` and `4*t<=N`.

2. Your Response 49 coefficient-three direction has now been strengthened and independently formalized. `threeHeight_family_witness` compiles for positive injective speeds `Fin n -> Nat`, `n+1=N`, maximum speed at most `N+t`, `t>0`, and `3*t<=N`, and concludes a common closed `1/N` witness. No missing base is assumed minimal.

The proof defines S as the speed image, U=[1,N], M=U\S, and E=S\U and proves exactly `|M|=|E|+1`. Outside five exact short exceptions

  (4,1,2), (6,2,3), (12,3,6), (12,4,6), (13,4,6),

every no-witness missing c has N<2c<=N+t. Since 3*t<=N gives t<c and N+t<3c, blocking the reciprocal forces speed 2c. Thus c↦2c injects M into E, contradicting the cardinality identity. The coefficient-four theorem handles (4,1) and (12,3). Exact repairs use q=10 with holes 3,7 at (6,2), q=19 with holes 6,13 at (12,4), and q=23 with holes 6,17 at (13,4). The subtle (6,2), M={4} branch is handled: blocking c=4 forces speed 8 and hence a nonempty E, which forces both 3 and 4 missing and then speed 7 absent.

The exact 627-line source has SHA-256

  f903274ade7d4daea6737b9f28fe967934348fdd4d857fc270471dc0dc07d56e.

It built in isolated ext4 with 3,011 jobs; an independent standalone compile took 54.1 seconds. The three targeted axiom reports use only propext, Classical.choice, and Quot.sound. An independent adversarial audit accepted the global quantifiers, card identity, doubling injection, exceptions, endpoints, and natural-subtraction guards. Full-project clean integration replay remains a publication gate. This is bounded-height progress only.

3. Your fastest interval-compression certificate has been formalized as:

  pivot_le_cyclicResidueDistance_mul_of_band
  exists_fastestPivotCertificate_of_extremal_band

The general Lean statement takes an explicit positive upper bound A, a selected lower speed, a fastest pivot B, and r with N∤r. If every nonpivot speed s lies between the selected lower speed and A, while B<=r*a_lower and r*A<=(N-1)*B, it gives the canonical fastest-pivot certificate. The repaired ext4 module compiles and reports only standard axioms. The separate ceiling/floor corollary with L=ceil(B/a_min) and U=floor((N-1)B/A) has not yet been formalized.

4. Your common-grid theorem remains accepted proved-math, not yet proved-lean. With g=gcd(A,B), A=g*alpha, B=g*beta, dA=gcd(N,alpha), and dB=gcd(N,beta), the shared candidate slice has exact size

  g*(N-dA-dB+1).

The strict union bound on the lower bad sets is sufficient. It is empty in the hard row N=7,A=98,B=187 because g=1,dA=7,dB=1.

PRIMARY TASK A — EMPTY COMMON-SLICE REPLACEMENT

Attack the first unsupported transition in the common-grid route: construct a cross-pivot relation that remains nonvacuous when the normalized top speed alpha or beta annihilates all shared candidates modulo N. Develop at least two materially different replacements before choosing one, for example:

- several affine common-time slices rather than one subgroup slice;
- a signed identity pairing unmatched A-pivot and B-pivot candidates through the common LCM;
- a quotient by the kernel followed by an exact lift count retaining lower-speed bad sets.

For each, state an exact quantified lemma, derive candidate membership and lower-speed bad-set transport exactly, and either prove it or identify the first unsupported sign/coverage step. Test it specifically at N=7,A=98,B=187. Do not reintroduce the refuted fractional-dual invariant or maximal-depth inclusion-exclusion under a new name.

PRIMARY TASK B — ROBUST-PIVOT TRANSVERSAL

For fixed N and top speeds A<B, let R_P(A,B) be the residues good for both top speeds at pivot P in {A,B}, and D_P(s) the subset spoiled by lower speed s. Let kappa_P be the minimum number of lower bad sets needed to cover R_P. Investigate the strong target

  max(kappa_A,kappa_B) > N-3.

Either prove it, refute it with an exact fixed-top pair and cover certificates, or replace it by a rigorously weaker statement that still rules out the same set of N-3 lower speeds covering both top grids. Coarse divisibility flags are insufficient: at N=7,A=7, the tuples (1,4,5,6,7,11) and (1,3,4,5,7,18) have analogous top divisibility data but require opposite successful pivots. Exact fixed top speeds also do not determine an individual pivot's survival. Any proposed invariant must retain enough lower-speed data.

PRIMARY TASK C — BEYOND COEFFICIENT THREE

Investigate whether the missing-base/extra-speed injection can reach `2*t<=N`. Do not assume the same map c↦2c works. Classify the generic short-hole region symbolically and determine which multiples k*c can lie in E. Formulate the required matching problem between M and E, including multiplicities and collisions when different c choose different k. Seek:

- a Hall-type injection with explicitly defined allowed-extra sets;
- a bounded family of maps c↦k(c)c whose images can be made disjoint; or
- an exact infinite obstruction showing this counting architecture stops at coefficient three.

Finite searches may guide the classification but are not a proof. Every family-level repair must respect the single global no-witness assumption and `|M|=|E|+1`; it may not choose a convenient missing c without proving it exists.

Required output: status corrections first; exact theorem statements; complete proofs or explicit first gaps; exact certificates for counterexamples; compiler-targeted Lean only where it corresponds to a surviving lemma; and no unrestricted LRC completion claim.
