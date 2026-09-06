# Five-adic decomposition and two-label filtering contracts

2026-09-06. Bounded Astra/xhigh research assignment from `/root`; requested
routing is not independently attested. Source checkpoint:
`84eacffc06cabd017d67c53d1d70995a8d25de3d`, with unrelated pending box work.
The four required workflow files were read; state was `research` /
`in_progress` with recorded start authorization, and validation exited 0.
Only this report is owned. Status: proposed manuscript derivation and exact
implementation interfaces, pending independent review and Lean proof.

## Published proof versus this design

Barajas–Serra, *The lonely runner with seven runners* (2008), Section 2,
Lemma 2 and Corollary 3, pp. 3–4, filter prime-power digit classes by
descending valuation. Section 3, p. 5, applies this to four positive
integer speeds, hence five total runners at the closed margin 1/5.
Its ordinary branch has at most two labels per lower five-adic level;
the other branch has three units and one top-level entry. The paper's
Corollary 3 has a positive cutoff hypothesis, so the all-top base case
deserves its own argument. I read these actual proofs in the
[publisher PDF](https://www.combinatorics.org/ojs/index.php/eljc/article/download/v15i1r48/pdf).

The rest is our decomposition-first formulation and derivation. It does
not import a chromatic-number equivalence, a primitive-family conjecture,
a height cutoff, or the separate three-unit carry proof.

## Arithmetic core, including the current coefficient

Fix natural numbers `m`, `R = 5^m`, `P = 5*R = 5^(m+1)`. For naturals x set
`q_m(x) = (x/R)%5`, `GoodDigit_m(x) := 1 <= q_m(x) and q_m(x) <= 3`.
The proposed Lean spelling of this predicate is `GoodDigit m x`.
Euclidean division gives the exact identity

```text
x % P = R*q_m(x) + x%R,                 0 <= x%R < R.
```

Consequently a good digit implies `R <= cyclicResidueDistance P x`, using
the existing `cyclicResidueDistance P x = min (x%P) (P-x%P)`.
This implication is sufficient; it is not an equivalence for arbitrary x:
`x=4R` has digit 4 and distance R.

Assume labelled positive naturals `d_i = 5^ell_i * u_i`, `5 ∤ u_i`,
`ell_i <= m`. Keep these fixed certificates throughout the proof. For
any current multiplier `A>0`, `5 ∤ A`, the current data are

```text
x_i = A*d_i = 5^ell_i * (A*u_i),        5 ∤ A*u_i.
```

Thus neither the levels nor the unit certificates change. There is no
need to recompute a valuation after each correction. Fix `j<m`, `k<5`,
and `C_j(k) = 1 + k*5^(m-j)`. The following are exact natural identities:

```text
C_j(k)>0,                C_j(k)%5 = 1;
ell_i>j  ==> (C_j(k)*A*d_i)%P = (A*d_i)%P;
ell_i=j  ==> C_j(k)*A*d_i = A*d_i + k*R*(A*u_i);
ell_i=j  ==> q_m(C_j(k)*A*d_i)
             = (q_m(A*d_i) + k*((A*u_i)%5))%5.
```

For the higher-level identity, the increment is
`k*5^(m-j+ell_i)*(A*u_i)`, divisible by `5^(m+1)` because
`j<ell_i` and `j<=m`. At the selected level,
`(m-j)+j=m`, so the increment is exactly a multiple of R and division
by R adds `k*A*u_i`. Reduction modulo 5 gives the stated digit identity.
No signed subtraction, floor carry, or valuation API is needed here.

The nonzero row coefficient is **`(A*u_i)%5`**, equivalently
`((A*d_i)/5^j)%5` at level j. It is not generally `u_i%5`.
For the unseeded construction only, A starts at 1 and every correction
is 1 modulo 5, so `A%5=1` and that simplification is valid. More generally
all later coefficients equal `(A_initial*u_i)%5`.

At `ell_i=m`, for every unit A,

```text
(A*d_i)%P = R*((A*u_i)%5),             1 <= (A*u_i)%5 <= 4.
```

Both distances to the endpoints of `[0,P]` are at least R. There can be
arbitrarily many top-level labels, including repeats. No top-level
forbidden-digit condition or cardinal bound should be introduced.
For `m=0`, all levels are zero and `lambda=1`, `P=5` already works.
The condition `j<m` is essential: at `j=m,k=4`, the proposed correction
would be 5 and would fail to be a unit.

## Exact finite avoidance contract

For a finite label type I with `card I <= 2`, take arbitrary
`q,s : I -> Fin 5` with `s_i != 0`. There is `k : Fin 5` such that
every `q_i+k*s_i` avoids 0 and 4. Arithmetic here is that of `Fin 5`.
For each row, the affine map is a permutation: the inverses of residues
1,2,3,4 are respectively 1,3,2,4. Each row therefore forbids exactly two
choices. The union forbids at most `2*card I <= 4` of the five choices.
This proves existence symbolically, with no speed enumeration.

Zero labels allow all five k, and k=0 is a valid choice. One label allows
exactly three k. Two labels allow at least one k, with repeated rows and
repeated coefficients permitted. The lower bound of one can be attained:
rows `(q,s)=(0,1),(2,1)` allow only k=1. Nonzero coefficients are necessary;
a row `(0,0)` forbids every choice.

If a bounded kernel computation is preferred, the only finite theorem
needed is the following proposed type; `by decide` may later be evaluated
and measured, without `native_decide` or another computational trust shortcut:

```lean
theorem fin5_avoid_two (q s : Fin 2 -> Fin 5)
    (hs : forall i, s i ≠ 0) :
    exists k : Fin 5, forall i,
      q i + k * s i ≠ 0 /\ q i + k * s i ≠ 4
```

The general `card <= 2` wrapper must explicitly cover empty, singleton,
and two-element domains. Duplicate the singleton row when padding to two;
choose k=0 for the empty domain. For two labels use an equivalence with
`Fin 2`; values need not be distinct. Alternatively prove the union bound
directly for the finite label type, avoiding this enumeration adapter.

## Descending induction and strongest useful interfaces

Use a seeded extension lemma. For an arbitrary finite type I (which may
be empty), natural functions d,ell,u, and m, assume

```text
forall i, 0<d_i, d_i=5^ell_i*u_i, 5 ∤ u_i, ell_i<=m;
h<=m; A>0; 5 ∤ A;
forall j<h, card {i : I | ell_i=j} <= 2;
forall i with h<=ell_i, R <= cyclicResidueDistance P (A*d_i).
```

The proposed conclusion is a natural lambda with

```text
0<lambda<P; 5 ∤ lambda; lambda%5=A%5;
forall i with h<=ell_i, (lambda*d_i)%P=(A*d_i)%P;
forall i with ell_i<h, GoodDigit_m(lambda*d_i);
forall i, R <= cyclicResidueDistance P (lambda*d_i).
```

This preserves exact higher residues, including closed boundary cases,
while filling every lower layer. Here is the full induction domain:
fix m and the decomposition data, then prove this statement for every
natural cutoff h satisfying `h<=m` and every positive unit A. The
unbounded-multiplier version is proved first; reduce modulo P only once
at the end.

* At h=0 the hypotheses already cover every label; use A.
* At h=r+1, r<m. Restrict q and the nonzero coefficients `(A*u_i)%5`
  to the subtype `ell_i=r`, apply the two-label contract, and put
  `A' = C_r(k)*A`. Every level strictly above r retains its exact residue;
  level r acquires a good digit. Positivity and the unit property persist.
* Apply the induction hypothesis at cutoff r with the new A'. Its
  exact-residue conclusion preserves the newly filled level r as well
  as all the older higher levels. Lower good digits are supplied by that
  recursive call. Compose the high-residue equalities and modulo-five
  equalities to obtain the conclusions at cutoff r+1.

Finally set `lambda=B%P` for the positive unit output B of that induction.
Because `5|P`, its residue is nonzero modulo 5 and hence positive;
it is less than P. Products have the same residues modulo P, and the
digit identity at the start shows that all good digits are also preserved.
The condition `5 ∤ lambda` is equivalently invertibility modulo this
power P; a `Nat.Coprime lambda P` wrapper may be derived if useful.

The unseeded theorem uses h=m and A=1, with the automatic top-level
bound. Its proposed Lean interface, using only definitions above, is:

```lean
theorem exists_five_adic_filtered_multiplier
    {I : Type*} [Fintype I] [DecidableEq I]
    (d ell u : I -> Nat) (m : Nat)
    (hd : forall i, 0 < d i)
    (hdecomp : forall i, d i = 5 ^ ell i * u i)
    (hu : forall i, Not (5 ∣ u i))
    (hell : forall i, ell i <= m)
    (hcard : forall j, j < m ->
      (Finset.univ.filter (fun i => ell i = j)).card <= 2) :
    exists lam : Nat, 0 < lam /\ lam < 5 * 5 ^ m /\
      lam % 5 = 1 /\ Not (5 ∣ lam) /\
      (forall i, ell i < m -> GoodDigit m (lam * d i)) /\
      (forall i, ell i = m ->
        (lam * d i) % (5 * 5 ^ m) = d i % (5 * 5 ^ m)) /\
      (forall i, 5 ^ m <=
        cyclicResidueDistance (5 * 5 ^ m) (lam * d i))
```

No nonempty, sortedness, injectivity, primitivity, attained maximum, or
unrestricted LRC premise belongs in this theorem. Its cardinal assumptions
count labels, not distinct values. Its full scope includes `Fin 0`, all-top
families, unused levels, and any number of top labels. Attainment of the
maximum is needed only by the subsequent Fin 4 case split.

## Positive Fin 4 adapters and module ownership plan

For arbitrary positive `v : Fin 4 -> Nat`, define
`ell_i=padicValNat 5 (v_i)`, `u_i=v_i/5^ell_i`, and `m=max_i ell_i`.
Then `v_i=5^ell_i*u_i`, all data are positive, `5 ∤ u_i`, `ell_i<=m`,
and the maximum m is attained. Indeed, `5^ell_i|v_i` gives the exact
decomposition; `5|u_i` would imply `5^(ell_i+1)|v_i`, contradicting
maximality. This raw decomposition suffices for the preferred assembly.

Pinned Mathlib is commit `520045ab14e26149ee970e2e617ca04b09bde5d6`
with Lean `v4.32.1`. In `NumberTheory/Padics/PadicVal/Basic.lean`, useful
checked source interfaces are `padicValNat.mul` (line 380, both factors
nonzero), `.div_of_dvd` (383), `.div_pow` (403),
`padicValNat_dvd_iff` (436, with an explicit zero disjunct), and
`pow_succ_padicValNat_not_dvd` (440, nonzero input), together with the
imported `pow_padicValNat_dvd`. Install `Fact (Nat.Prime 5)` locally.
The decomposition core itself should not import this adapter. No p-adic
field or topology is involved. As an alternative, existing
`exists_scaleSpeeds_primitive` in `PrimitivePrompt95.lean` has no Prompt95
premise; its larger gcd normalization is valid but unnecessary here.

The sharper finite classification, suggested by the orchestrator and
independently checked here, is: if `ell : Fin 4 -> Nat` has attained
maximum m, either every layer below m has at most two labels, or there
are `j<m` and a unique top label p with `ell_p=m` and `ell_i=j` for every
`i!=p`. Three labels on a lower layer leave exactly one position for the
attained maximum, so there are exactly three, and j is automatically the
minimum. Repeating a speed does not alter this label-counting argument.

Only in this second branch divide every speed by `g=5^j`: write
`v_i=g*d_i`, with three units and one entry of exact level `m-j>0`.
Apply the separately supplied hard theorem at `R'=5^(m-j)`, `P'=5*R'`.
That theorem supplies a raw positive unit multiplier
`lambda_raw=a*(1+k*R')`, with `a in {1,2,3}` and `0<=k<5`, and its
closed residue bounds; it does **not** supply `lambda_raw<P'`.
Set `lambda=lambda_raw%P'`. Since `5|P'`,
`lambda%5=lambda_raw%5!=0`, so `0<lambda<P'` and `5 ∤ lambda`.
For every natural d, `(lambda*d)%P'=(lambda_raw*d)%P'`, preserving
the cyclic residue distance and hence every hard-branch bound.
This normalization is required before using the upper bound: for example,
`R'=5,a=3,k=4` gives `lambda_raw=63>25=P'` and `lambda=13`.

Since `g*R'=R` and `g*P'=P`, natural residue arithmetic then gives

```text
cyclicResidueDistance (g*P') (lambda*(g*d_i))
    = g * cyclicResidueDistance P' (lambda*d_i).
```

Thus the normalized positive unit lambda supplies the original closed
residue bound at modulus `P=5^(m+1)`; its established bound `lambda<P'`
and `P'<=g*P'=P` imply `lambda<P`. Both branches therefore share the time
`lambda/P`. This avoids global minimum normalization and the primitive
API entirely. The proof of the hard theorem is not part of this report.

Optional common-power normalization remains valid if an existing caller
prefers a level-zero witness: let `c=min_i ell_i`, `g=5^c`,
`d_i=v_i/g`, and `ell'_i=ell_i-c`. The equality
`5^ell_i=5^c*5^(ell_i-c)` proves the divided decomposition, and both
minimum 0 and maximum `m-c` are attained. Under this normalization the
hard lower layer above must be level zero. No gcd or injectivity premise
is required by either version.

Proposed later file responsibilities, subject to root review:

| Module | Exact responsibility |
| --- | --- |
| `FiveAdicFiltering.lean` | Natural digit/residue algebra, finite two-row avoidance, seeded descent, unseeded arbitrary-label theorem; import `PivotResidues`, no valuation machinery |
| `FiveAdicDecomposition.lean` | Positive decomposition, pure Fin 4 level classification, and division by the hard branch's common power; import pinned `PadicVal.Basic` |
| Separate carry module, owned by the other assignment | Three-unit natural/signed carry result and restoration of original positive labels; not part of this report |
| Later `FiveRunnerOrdinary.lean` integration | Combine the two branches, then apply `circleNorm_nat_div_ge` and scale transport |

For the preferred assembly a positive unit lambda with the original closed
residue bound gives positive real time `t=lambda/P`, with `R/P=1/5`.
If using the optional normalized data instead, divide their witness time
by g. This follows directly from `circleNorm_nat_div_ge` in
`PivotResidues.lean`; `StructuredClasses.lean` also supplies the signed
band bridge when the carry module needs it.
The resulting natural Fin 4 theorem may allow repeated values; the existing
injective lower-count interface can simply specialize it. This report
does not implement that assembly or the H6/canonical bridge.

## Falsification status and first unresolved implication

The identities, counting, induction, and classification above have complete
manuscript derivations, but no Lean declarations were created or checked.
I found no semantic gap in this bounded filtering contract. Small controls
below explicitly expose three tempting false strengthenings: using u_i as
the coefficient for an arbitrary seed, requiring top digit avoidance, and
allowing j=m. They do not certify any infinite theorem.
Root review identified the previously implicit representative step in the
hard-branch assembly; it is now explicit. No upper bound is asserted for
the carry theorem's raw multiplier.

The first unresolved implementation obligation is to kernel-check the
natural digit/residue identities and the exact two-row finite contract,
then their seeded induction. For the complete direct five-total proof,
the first additional mathematical implication is the separately assigned
three-unit carry contract, including its arithmetic/sign adapter. This
filter theorem alone does not cover that branch, prove five-total LRC,
prove a mixed threshold, or resolve unrestricted LRC.

## Compact reproducibility receipt

Run from the repository root with the shared pinned Mathlib sources present.
This program guards seven source files and checks fixed arithmetic controls;
it does not search speed tuples or execute Lean.

```python
from hashlib import sha256
from pathlib import Path
guards = {
    'research/astra-five-total-direct-proof-screen.md':'7a3affdab83961ce8e014496f8cff7ce00bce891f002b8b45a2844adf3420483',
    'LonelyRunner/PrimitivePrompt95.lean':'d1d6cf01650c809da0cb19ed722754071df070831e02e22a3c4b2c3dc28afb04',
    'LonelyRunner/PivotResidues.lean':'362da5ab923f22e900ae7ac821dd4cf4aab91dfe70889987bc9e5a05d19c276a',
    'LonelyRunner/StructuredClasses.lean':'5328a7a88d2b42f86ffc3f0f0418ca22c761219e8fa3e5822bda5a18ac286e8c',
    '.lake/packages/mathlib/Mathlib/NumberTheory/Padics/PadicVal/Basic.lean':'494d5829e218df7dba759758e39752b278958f7f384226cc62d138d4408ae390',
    'lean-toolchain':'8e3538e0ab5f81a3ee04927d8838c8c674e0e112838b4b3ce87ec218143276af',
    'lake-manifest.json':'887450bc75a38effdae452a14b60f6d225bc10b48c71b3827e3479b800f41218',
}
for path, digest in guards.items():
    assert sha256(Path(path).read_bytes()).hexdigest() == digest, path
assert all(s*t % 5 == 1 for s,t in ((1,1),(2,3),(3,2),(4,4)))
def allowed(rows):
    return [k for k in range(5) if all((q+k*s)%5 in (1,2,3) for q,s in rows)]
assert allowed([]) == [0,1,2,3,4]
assert allowed([(0,1)]) == [1,2,3]
assert allowed([(0,1),(2,1)]) == [1]
assert allowed([(0,1),(0,1)]) == [1,2,3]
assert allowed([(0,0)]) == []
m,j,k,A,u = 3,1,3,2,7
R,P,C = 5**m,5**(m+1),1+k*5**(m-j)
x = A*5**j*u
digit = lambda y: (y//R)%5
assert C%5 == 1 and C*x == x+k*R*A*u
assert digit(C*x) == (digit(x)+k*((A*u)%5))%5 == 2
assert digit(C*x) != (digit(x)+k*(u%5))%5
higher = A*5**(j+1)*3
assert (C*higher)%P == higher%P
distance = lambda modulus,y: min(y%modulus,modulus-y%modulus)
assert digit(4*R) == 4 and distance(P,4*R) == R
assert 1+4*5**(m-m) == 5
assert all(distance(5,d) >= 1 for d in (1,4,6,14,4))
Rp,Pp = 5,25
raw = 3*(1+4*Rp)
representative = raw%Pp
assert raw == 63 > Pp and representative == 13
assert 0 < representative < Pp and representative%5 == raw%5 != 0
assert (representative*11)%Pp == (raw*11)%Pp
assert distance(Pp,representative*11) == distance(Pp,raw*11) == 7
print('source_guards=7 passed')
print('fixed_controls=pass; false_strengthenings=exposed')
print('hard_multiplier_control=pass; raw=63; representative=13; modulus=25')
print('Lean_execution=none; speed_tuple_scan=none; theorem_promotion=none')
```

Receipt command (extracts exactly the Python block above):

```sh
python3 -B - <<'PY'
from pathlib import Path
from hashlib import sha256
from contextlib import redirect_stdout
import re,io
f=chr(96)*3
s=Path('research/astra-five-adic-filter-plan.md').read_text()
b=re.findall(rf'^{f}python\n(.*?)^{f}[ \t]*$',s,re.M|re.S)
assert len(b)==1
out=io.StringIO()
with redirect_stdout(out):
    exec(compile(b[0],'<five-adic-filter-controls>','exec'),{})
print(out.getvalue(),end='')
print('program_sha256='+sha256(b[0].encode()).hexdigest())
print('stdout_sha256='+sha256(out.getvalue().encode()).hexdigest())
PY
```

The exact receipt and final workflow validator both completed with terminal
exit 0 after the representative correction (tool chunk `29ce9d`).
Program SHA-256:
`e17d3a5c02a94cffb1e599db2ceb57e3b36e954776e5b992e3fac9b1ebd527e3`.
Raw program stdout SHA-256:
`68be37f01856a5938e64e989c8b0b1ab90430f10dd04415a93e67497837003aa`.
The validator certifies record consistency only. All commands have stopped
at handoff. No Lean/source, shared state, Git, toolchain, build,
installation, or cache modification was performed. The report's final
SHA-256 is supplied separately to the orchestrator to avoid a self-hash.
