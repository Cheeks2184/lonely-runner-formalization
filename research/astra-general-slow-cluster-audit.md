# General slow speed in the two-digit cluster candidate

This bounded analytical audit does **not** prove or refute the proposed
two-digit witness theorem. It proves the exact distinction between its closed
and forward targets, and exhibits an actual integer family where the attempted
transfer of the unit-speed proof fails. That family itself has an explicit
forward two-digit witness. No candidate counterexample, unrestricted supply
theorem, or Lean implementation is claimed.

Task: `/root/general_slow_cluster_audit`, requested Astra/xhigh.
Source checkpoint: `737ac0634c02c21025bcafebacc97c9152f04bf4`.
Only this manuscript is owned and changed. Other authors' files are preserved.

The accepted inputs were read in full and their SHA-256 bindings checked:

- `research/astra-cluster-grid-rescue.md`:
  `edc948e31d6939132dd44dec7fe84612912ab952ceb8e98140a6b9cb2e9b5f9c`.
- `research/astra-cluster-grid-rescue-review.md`:
  `99caba49dd2b5b20475d89901d39fd6ce24fbbb5a060b949ab7707f52a6b569e`.

## 1. Contract and exact admissible rows

Let N>=5, a and M be positive integers, and let C be a set of N-2 distinct
nonnegative integer offsets containing 0. Put H=max C and assume

    M > (N-1) max(H,a).

The N-1 actual positive integer speeds are a and M+c for c in C. In particular
a<M, so the slow speed is distinct from every fast speed. All phases start at
zero and use the same time. The proposed candidate set is

    t(k,ell) = k/(N a) + ell/(N M),    0<=k,ell<=N-1.

The closed target is frac(vt) in [1/N,1-1/N] for every speed. The forward
target replaces the upper inequality by a strict inequality.

The slow phase is

    a t(k,ell) = k/N + a ell/(N M),
    0 <= a ell/(N M) < 1/N.

It never reaches 1. Consequently:

- k=0 is always bad for the slow speed, including the closed target.
- Every row 1<=k<=N-2 is forward-good for the slow speed, for every ell.
- At k=N-1 only ell=0 is closed-good; none of this row is forward-good.

Thus the forward problem is exactly the selection of one of the (N-2)N pairs
with 1<=k<=N-2. The closed problem additionally permits the single pair
(N-1,0). Forgetting that exceptional pair would silently strengthen the closed
claim. A closed witness supplied elsewhere need not be a forward witness at
that same time.

## 2. First approach: transfer the residue proof after scaling

Dividing every speed by a preserves the ordinary witness problem after the
corresponding time rescaling, but it need not preserve integer fast speeds or
integer offsets. The exact fast phase at a candidate is

    (M+c)t(k,ell) = [k(M+c)/a + ell + c ell/M]/N.

Write k(M+c)/a = A_c(k)+beta_c(k), with A_c(k) an integer and
0<=beta_c(k)<1. The accepted unit-speed proof would need a favorable residue
of A_c(k)+ell together with a suitable bound on the additional numerator

    beta_c(k) + c ell/M.

The cluster hypothesis gives c ell/M<1, but gives no bound less than 1 on
this sum. Also A_c(k) is not generally k A_c(1), even modulo N. These are
two distinct failures of that attempted proof, not merely a missing notation
change.

Both failures occur in the following uniform actual integer family. Fix any
N>=5 and any integer a>N, and take

    M = N a - 1,
    C = {0,1,...,N-4} union {a}.

There are exactly N-2 distinct offsets, H=a, and
M-(N-1)a=a-1>0, as required. For the anchor c=0 and every 1<=k<=N-2,

    A_0(k) = floor(k(N-1/a)) = kN-1.

Hence A_0(k) is always -1 modulo N, whereas k A_0(1) is -k modulo N.
Already k=2 contradicts the proposed linear residue substitution.

For the other failure, use the actual candidate k=1, ell=N-2 and the actual
speed M+a. Here A_a(1)=N and beta_a(1)=1-1/a. Its floored residue
A_a(1)+ell is N-2 modulo N, a favorable residue in the unit-speed proof.
Nevertheless, putting

    epsilon = a(N-2)/M - 1/a,

gives 0<epsilon<1: positivity follows from a^2(N-2)>Na-1=M, and
a(N-2)/M<(N-2)/(N-1)<1. The fractional fast phase is therefore

    frac((M+a)t(1,N-2)) = (N-1+epsilon)/N,

strictly above the closed upper face. Its norm is (1-epsilon)/N<1/N.
The slow speed is forward-good at this candidate by Section 1. Thus a
favorable floored residue does not justify the needed phase conclusion.

This is **not** a family of two-digit candidate failures. In fact every tuple
in this family has the forward candidate

    t_* = t(1,2) = 1/(N a) + 2/(N M).

For the slow speed, a t_* lies in [1/N,2/N), since 2a<M. For every c in C,

    (M+c)t_* = 1 + [2+(c-1)/a+2c/M]/N.

The bracket is increasing in c and lies strictly between 1 and 4: its minimum
is 2-1/a>1, and its maximum is 3-1/a+2a/M<4. Since N>=5, these actual fast
fractional phases all lie in (1/N,1-1/N). This explicit alternate witness
limits the negative conclusion to the two proof steps just identified.

## 3. Second approach: retain the coupled row inequalities

For the general tuple, keep the real numerator

    X_c(k,ell) = k(M+c)/a + ell(1+c/M).

A candidate is closed-good for fast colour c precisely when some integer z
satisfies

    Nz+1 <= X_c(k,ell) <= Nz+N-1.

For the forward target the right inequality is strict. These exact conditions
include all carries and wrap points. They involve the same k and ell for every
c; independently chosen shifts, row residues, or rounding errors are not
permitted substitutes.

Let E_c^F(k) be the set of columns ell in {0,...,N-1} failing the forward
inequality for c, and define E_c^C(k) with the closed inequality. A forward
selection requires

    some k in {1,...,N-2} with union_(c in C) E_c^F(k) != {0,...,N-1}.

The analogous condition with E_c^C(k), or success of the exceptional pair
(N-1,0), is precisely the closed selection problem. This formulation is an
exact remaining obligation, **not** a new supply lemma. The residue-avoidance
lemma in the accepted source acts on k times a fixed set in Z/NZ; the changing
floors and the column-dependent corrections above are not its hypotheses.
The first approach's family demonstrates both obstructions without replacing
the ordinary integer tuple by an unrelated phase system.

This bounded second approach supplies no inequality preventing all columns
from being covered in every admissible row. Neither the original separation
condition nor the number N-2 of fast labels has been shown here to force the
required coupled escape. No proof for an independently shifted abstraction is
being assumed, and no first-slow-round witness principle is being imported.

## 4. Disposition and verification

The proved content is the row pruning, the two exact algebraic failures of
the naive proof transfer, and the explicit forward witness for the same
integer family. The existence of a closed two-digit witness under the general
contract remains unresolved in this audit; its stronger forward version also
remains unresolved. This branch supplies no new uniform reduction of arbitrary
tuples to the cluster hypothesis and no reason to implement a general theorem
in Lean. The accepted unit-speed theorem is unchanged.

Verification was hand algebra with the displayed symbolic bounds. No
mathematical program, enumeration, solver, external-source theorem, Lean build,
cache restoration, or Git/state mutation was used. The project config,
workflow, policy and focused state were read. The source hashes above matched.
`python3 -B scripts/validate_workflow.py` exited 0 with:

    workflow structural validation passed; it cannot certify mathematical validity.

The owned manuscript was checked for trailing whitespace and a final newline.
Independent mathematical review is still required before checkpoint promotion.
