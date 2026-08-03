AUDIT OF RESPONSE 56 AND PROMPT 57 — COATOMIC CONTRACTION IS NONCANONICAL;
THREE FIXED J1 SHIFTS ARE INSUFFICIENT

Do not claim a proof or disproof of unrestricted Lonely Runner. Continue as
GPT-5.6 Sol Pro. Preserve the exact Gamma relation

  N < d <= N+t,   N+t < c+d <= 2N,   gcd(c,d)=1,

with a strict lower sum boundary and closed upper sum boundary. Distinguish
proved-lean, proved-math, exact finite computation, conditional, conjectural,
rejected, and open results.

RESPONSE 56 RECOVERY AND AUDIT

The exact copied response has 22,290 characters, 22,325 UTF-8 bytes, and
SHA-256

  fac674394208d03cb49e1bcc8117a88ec08e7c8843a19d1ef2ea559e5b4325f6.

Its mathematical statements K1--K5, L1--L3, M1, and N1--N3 survive
independent audit at their stated necessary or conditional strength.

K1 is now independently proved in Lean. For an abstract monotone neighborhood
operator, `criticalCore_coSingleton_tight` proves that every co-singleton of a
nontrivial critical deficiency-one set is tight, and
`atomicCriticalCore_card_eq_one` proves that a critical core with no nonempty
proper tight subset has card one. Both compile under Lean 4.32.1 and use only
`propext`, `Classical.choice`, and `Quot.sound`. Therefore unrestricted atomic
contraction is rejected as vacuous, not an open Gamma exclusion strategy.

K2 is correct: after contracting a tight S, the residual neighborhood is
`N_G(X union S) \ N_G(S)` and the residual slack equals the original slack of
`X union S`. K3's restricted contraction is equivalent to contracting only
nonspanning tight blocks, because a tight block in an m-left critical core has
proper neighborhood exactly when its left cardinality is at most m-2.

K4's `3m-5` proof is accepted with the explicit case split m=2; for m>=3 the
two endpoint cuts have at least two crossing rights and every interior cut at
least three. K5/M1 are accepted only as necessary inequalities. No reverse
arithmetic estimate has been proved.

L1's two-total chain criterion is correct. Slots of separated contiguous
blocks are disjoint, and different Delta-chains cannot have cross-layer
collisions. L2 is a correct sufficient orientation condition. L3 exactly
reproduces the `(36,16)` inward-orientation failure.

N1 and N2 are correct conditional classes. N3 correctly gives an infinite
obstruction to nonnegative forward offsets at `(N,t,c)=(2m,m,m)` and an
available backward choice `d=2m+1`.

The supplied `GammaTwoTranslation.lean` attachment was explicitly labeled
uncompiled. Its download could not be recovered through the signed-in browser
because an older modal Save As target intercepted the virtualized attachment
control. An independent tracked implementation defines the named map and
proves `gammaTwoTranslation_isSdr`; it compiles cleanly and its axiom report is
exactly `[propext, Classical.choice, Quot.sound]`. Do not claim your unattached
file was compiled. If it adds content, paste its complete source inline.

NEW FORMAL RESULT: ARBITRARY FEASIBLE SINGLE-TOTAL REVERSAL

`CoefficientTwoArbitraryReversal.lean` now kernel-checks the manuscript claim
left open in the previous audit. It defines

  Q_s = N+s+2*ell,
  f_s(c)=Q_s-c,

and proves `rectangleReversalAt_isSdr_of_feasible`: for any exact feasible
start s, if every actual generic candidate is coprime to Q_s, the named map is
injective and lands in each exact Gamma neighborhood. The interval corollary
assumes exactly `16<=t`, `2*t<=N`, nonempty generic band, and
`startLower<=s<=startUpper`. Both direct probes use only standard axioms. This
is a conditional single-total theorem; it does not revive DIAGONAL-HALL.

EXACT OBJECTION 1: RESTRICTED CONTRACTION TERMINALS ARE NONCANONICAL

The corrected nonspanning contraction carries a sequence certificate. After
any sequence there is one original tight set K such that the total deleted
right set is exactly D=N_original(K), `|D|=|K|`, D is proper in N(A), and every
residual row is exactly `N_original(c) \ D`. Residual contractible blocks
correspond to larger original nonspanning tight supersets of K. Thus terminal
states correspond to inclusion-maximal original nonspanning tight blocks.

But terminals need not be unique or even have the same size. The critical
graph L={0,1,2,3}, R={0,1,2}, with rows

  0:{0,1,2},  1:{1,2},  2:{1,2},  3:{0}

has two maximal nonspanning tight blocks. Contract `{3}->{0}` and the terminal
has three left vertices and two rights. Contract `{1,2}->{1,2}` and the
terminal has two left vertices and one right. Therefore no coatomic potential
may assume order-independent size, labels, or interval shape. What survives
from Gamma is only a common puncture certificate `(K,D)` with every row
`Gamma(c)\D`.

At `(20,10)`, contracting `{12,14}` deletes `{23,25}` and changes raw row 10
from `[21..30]` to `{21,22,24,26,27,28,29,30}`. Bare consecutive-ones support
is not inherited.

EXACT OBJECTION 2: SMALL FIXED J1 SHIFT FAMILIES FAIL

The exact shifted-translation model uses base offset

  b(c)=c for c<=t, and b(c)=c-t for c>t,

and permits `d=N+b(c)+s` only when the right range, strict/closed Gamma bands,
and gcd condition all hold. Deterministic enumeration covered every active
graph for `20<=N<=300`: 7,517 graphs and 203,021 candidate rows.

The canonical family S={-1,0,1} first fails in this domain at `(20,9)`, with
actual candidates `{10,11,12,13,14}` and offset rows

  10:{1}, 11:{1,3}, 12:{3}, 13:{3,4,5}, 14:{5}.

The Hall witness `{10,11,12}->{1,3}` is deficient. Full Gamma still has the SDR

  10->27, 11->21, 12->23, 13->22, 14->25.

Stronger: for the four active N=20 cases t=7,8,9,10, every effective shift is
in `[-9,8]`. All 988 fixed families of cardinality at most three were
enumerated; none works for all four instances. Exactly four size-four families
work at N=20, namely `(-3,0,1,k)` for k=4,5,6,7, and every one fails already at
`(21,9)`. Symmetric radii 7 and 8 have no failure through N=300, but this is
finite evidence only, not a bound.

PRIMARY TASKS

1. Formalize K2 and the coatomic terminal characterization in Lean 4.32.1,
   including exact residual subtypes or Finset restrictions. State whether
   source was actually compiled. Do not assume the terminal is canonical.

2. Attack COATOMIC-GAMMA-EXCLUSION while retaining the puncture certificate
   `(K,D)`. Either derive a new arithmetic inequality strictly incompatible
   with K4/M1, or give the smallest exact Gamma-derived punctured core showing
   a proposed inheritance or reverse inequality is false.

3. Develop L1 beyond two totals. Seek a component/interval criterion for a
   finite ordered family of total layers, then connect rowwise Jacobsthal
   availability to collision orientation. A fixed family of at most three J1
   shifts is already rejected; do not propose one as a uniform solution.

4. Explore backward/reflection translation choices suggested by N3. State the
   smallest obstruction to every bounded choice family you propose. Separate
   row nonemptiness from Hall collisions.

5. Attempt a sharp lower-bound theorem showing the number/radius of translated
   choices must grow, or identify an arithmetic adaptive rule that evades the
   N=20/N=21 obstructions without using a product over all candidates.

6. Give a complete formal theorem for the `3m-5` span inequality only if the
   statement includes every finiteness, order, nonempty, and criticality
   hypothesis and the file actually compiles.

REQUIRED OUTPUT

1. Status table with exact labels.
2. Complete proofs for every new proved-math statement.
3. Exact counterexamples to every rejected local claim.
4. The first unsupported arithmetic implication on each surviving route.
5. Reproducible source, expected output, versions, domains, runtimes, and
   SHA-256 for every computation.
6. No `sorry`, `admit`, custom axiom, placeholder, `unsafe`, or uncompiled
   theorem may be called proved-lean.
7. No claim that exact Gamma Hall, coefficient two in every dimension,
   top-two, or unrestricted LRC is proved.
