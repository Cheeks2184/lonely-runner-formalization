# 1. Exact status table

| Result or route                                                | Status                                                           |
| -------------------------------------------------------------- | ---------------------------------------------------------------- |
| Corrected DPLP soundness and induction bridge                  | **proved-lean**                                                  |
| Positive-integer, pivot-certificate, and real LRC equivalences | **proved-lean**                                                  |
| `threeHeight_family_witness`                                   | **proved-lean** bounded-height theorem                           |
| Exact ordinary-bad and deep-hole one-coordinate counts         | **proved-math**; reported independently checked                  |
| Shell-surplus criterion below                                  | **proved-math**, uniform form rejected                           |
| Third-order deep-Bonferroni shell criterion below              | **proved-math**, uniform form rejected                           |
| Deletion-safe maximizer and active-cycle theorem below         | **proved-math**                                                  |
| DPLP itself                                                    | **conjectural**                                                  |
| Large-prime almost-forcing theorem below                       | **proved-math**                                                  |
| Collision-rich eventual prime-forcing class below              | **proved-math**                                                  |
| Uniform prime-forcing supply                                   | **conjectural**                                                  |
| Minimal-counterexample product bound                           | **imported primary theorem**, not yet formalized in this project |
| Top-two pivot conjecture                                       | **open**                                                         |
| Minimal-counterexample height compression                      | **open**                                                         |
| Unrestricted LRC                                               | **open**                                                         |

The strongest conclusion from this turn is negative but clarifying: both natural low-order `WeightedShellSurplus` inequalities fail on exact DPLP-eligible tuples. The remaining DPLP route that genuinely uses all deletion premises is the deletion-safe maximizer cycle, not another capacity sum.

---

# 2. Exact DPLP setup

Let

[
n\ge2,\qquad N=n+1,
]

and let

[
a:\operatorname{Fin}n\to\mathbb N
]

be positive and injective.

Fix a pivot (j), put

[
p=a_j,\qquad M=np,
]

and define the deletion-pivot candidate set

[
R_j={0\le r<M:n\nmid r}.
]

For (i\ne j), define:

[
B_{ji}=
{r\in R_j:\rho_M(ra_i)<p},
]

the ordinary strict deletion-bad set;

[
D_{ji}=
{r\in R_j:N\rho_M(ra_i)<np},
]

the strict deep-hole set; and

[
H_{ji}=B_{ji}\setminus D_{ji},
]

the shell.

Thus (r\in H_{ji}) means

[
N\rho_M(ra_i)\ge np
\quad\text{and}\quad
\rho_M(ra_i)<p.
]

The shell’s lower boundary is closed.

Write

[
\delta_j(r)=
|{i\ne j:r\in D_{ji}}|,
]

[
s_j(r)=
|{i\ne j:r\in H_{ji}}|.
]

A candidate gives a full DPLP lift exactly when

[
\boxed{\delta_j(r)=0\quad\text{and}\quad s_j(r)\le1.}
]

This includes:

* an empty ordinary bad set, (s_j(r)=0);
* a shell singleton, (s_j(r)=1).

---

# 3. DPLP attempt I: weighted shell surplus

## 3.1 Exact set identity

### Theorem D1 — proved-math

Let (G_j\subseteq R_j) be the full-lifting candidates. Then

[
\boxed{
R_j\setminus G_j
================

\left(\bigcup_{i\ne j}D_{ji}\right)
\cup
\left{
r:\text{(r) belongs to at least two shell sets }H_{ji}
\right}.
}
]

### Proof

If (r\notin G_j), either some coordinate is deep, or no coordinate is deep and at least two coordinates are ordinarily bad. In the latter case all ordinary bad coordinates are shell coordinates.

Conversely, a deep coordinate prevents lifting, and two shell-bad coordinates prevent the candidate from certifying any single deletion.

---

## 3.2 First shell-surplus inequality

### Theorem D2 — proved-math

[
\boxed{
|G_j|
\ge
|R_j|
-----

## \sum_{i\ne j}|D_{ji}|

\sum_{\substack{i<k\i,k\ne j}}
|H_{ji}\cap H_{jk}|.
}
]

Therefore the strict inequality

[
\sum_i|D_{ji}|
+
\sum_{i<k}|H_{ji}\cap H_{jk}|
<
|R_j|
]

is sufficient for a DPLP lift.

### Proof

At a candidate (r),

[
1_{{\delta_j(r)\ge1}}\le\delta_j(r)
]

and

[
1_{{s_j(r)\ge2}}
\le\binom{s_j(r)}2.
]

Sum the exact complement identity.

No selector distribution is introduced.

---

## 3.3 Exact rejection

For

[
a=(1,2,3,60),\qquad n=4,\quad N=5,
]

all corrected DPLP premises hold:

* primitive;
* positive and injective;
* (60) is divisible by (N=5);
* (60>5+\lfloor5/3\rfloor);
* every deletion has a certificate.

The shell-surplus lower bounds, in pivot order (1,2,3,60), are

[
\boxed{(-1,0,-9,-36).}
]

Nevertheless pivot (60) has (24) shell-singleton lifts.

Thus the uniform strict shell-surplus assertion is **rejected**.

The (N)-divisible premise is used only to establish that this is a genuine DPLP-eligible counterexample to the inequality. It plays no role in the proof of D2.

---

# 4. DPLP attempt II: deep Bonferroni plus shell pairs

The failure above comes from extensive overlap among the deep sets. The exact third-order correction is the strongest low-order variant that survived the initial mandatory examples.

## 4.1 Pointwise deep-union bound

For an integer (\delta\ge0),

[
1_{{\delta\ge1}}
\le
\delta-\binom\delta2+\binom\delta3.
]

For (\delta\ge1),

[
\delta-\binom\delta2+\binom\delta3
==================================

1+\binom{\delta-1}{3}\ge1.
]

## 4.2 Third-order shell-surplus theorem

### Theorem D3 — proved-math

Define

[
D_{1,j}=\sum_{i\ne j}|D_{ji}|,
]

[
D_{2,j}=
\sum_{\substack{i<k\i,k\ne j}}
|D_{ji}\cap D_{jk}|,
]

[
D_{3,j}=
\sum_{\substack{i<k<\ell\i,k,\ell\ne j}}
|D_{ji}\cap D_{jk}\cap D_{j\ell}|,
]

and

[
H_{2,j}=
\sum_{\substack{i<k\i,k\ne j}}
|H_{ji}\cap H_{jk}|.
]

Then

[
\boxed{
|G_j|
\ge
|R_j|-
(D_{1,j}-D_{2,j}+D_{3,j})-H_{2,j}.
}
]

Strict positivity of the right side is sufficient for DPLP.

### Proof

The third-order Bonferroni expression is an upper bound for the union of the deep sets. The number of candidates lying in at least two shell sets is at most (H_{2,j}). Apply the exact complement identity from D1.

Every term is obtainable from exact CRT intersection counts with two threshold types. This remains non-tautological: only deep intersections through order three and shell intersections through order two are used.

---

## 4.3 Exact rejection

Consider

[
\boxed{a=(1,3,4,5,18),\qquad n=5,\quad N=6.}
]

It satisfies all corrected DPLP premises:

* primitive;
* positive and injective;
* (18) is divisible by (6);
* (18>6+\lfloor6/3\rfloor=8);
* every deletion has a certificate.

The D3 lower bounds at pivots (1,3,4,5,18) are

[
\boxed{(0,0,0,0,0).}
]

Yet pivot (18), with modulus (90), has four shell-singleton lifts:

[
\boxed{
(39,5,15),\ (41,4,16),\ (49,4,16),\ (51,5,15).
}
]

Each triple is

[
(r,\text{exceptional speed},\rho_{90}(r,a_k)).
]

For example, at (r=39), the only deletion-bad coordinate is speed (5), and

[
\rho_{90}(39\cdot5)=15.
]

Since

[
N\cdot15=90= n\cdot18,
]

this is exactly the closed shell boundary and therefore lifts.

Thus the uniform third-order deep-Bonferroni shell criterion is **rejected**.

This is the first failure in the deterministic lexicographic domains:

[
(n,\max a)=
(3,20),\ (4,20),\ (5,18)
]

after checking respectively (557), (2{,}864), and (266) DPLP-eligible tuples.

---

## 4.4 Mandatory evaluations

For each tuple below, the displayed vectors are in pivot order.

| Tuple          | First-order shell surplus                        | Third-order deep surplus        | Exact good counts                   |
| -------------- | ------------------------------------------------ | ------------------------------- | ----------------------------------- |
| ((1,3,4,7))    | ((0,-2,-6,-4))                                   | ((0,0,0,0))                     | ((0,0,0,0))                         |
| ((1,2,3,60))   | ((-1,0,-9,-36))                                  | ((0,0,0,24))                    | ((0,0,0,24))                        |
| ((1,2,6,8,10)) | ((0,-2,-8,-10,-22))                              | ((0,0,0,4,2))                   | ((0,0,0,4,4))                       |
| OPT-ADD (G)    | ((-16,-70,-138,-174,-268,-492,-642,-1422,-5826)) | ((28,26,26,30,26,86,26,-30,90)) | ((28,28,52,48,58,126,138,304,1328)) |
| ((1,3,4,5,18)) | ((0,0,-4,-12,-20))                               | ((0,0,0,0,0))                   | ((0,0,0,0,4))                       |

For the consecutive family ((1,\ldots,n)), (3\le n\le20), the best third-order surplus is

[
\boxed{
(0,0,0,0,0,0,0,0,0,-2,0,0,0,0,0,-10,0,-4).
}
]

These tuples contain no speed divisible by (N=n+1), so they are calibration tests rather than DPLP-eligible instances.

---

## 4.5 Reproducibility

[Exact DPLP verifier](sandbox:/mnt/data/prompt59_dplp_shell_audit.py)

[Expected output](sandbox:/mnt/data/prompt59_dplp_shell_audit.out)

```text
Python: 3.13.5
Randomness: none
Third-party packages: none
Script-measured runtime: 2.100721 seconds

SHA-256 source:
406b64139de1f7be51e3f42c750feb2a7e095d58865e82d6bdd76ab76a264e30

SHA-256 output:
bee3383da291f7e65af8ef06aa9d2c532d5a51e7ddc9155fc9b0985854a807fc
```

Command:

```bash
python3 prompt59_dplp_shell_audit.py
```

---

# 5. DPLP attempt III: deletion-safe maximizers and an active cycle

This route uses all deletion-existence premises simultaneously and does not choose one arbitrary certificate per deletion.

## 5.1 Continuous deletion-safe sets

Because the speeds are integers, time may be taken in the circle

[
\mathbb T=\mathbb R/\mathbb Z.
]

For each coordinate (k), define

[
K_k=
\left{
t\in\mathbb T:
|t a_i|\ge\frac1n
\quad\forall i\ne k
\right}.
]

The corrected premise

[
\forall k,\ \operatorname{Nonempty}(\operatorname{Cert}k)
]

implies (K_k\ne\varnothing).

Each (K_k) is closed, hence compact.

Define

[
\eta_k=
\max_{t\in K_k}|t a_k|.
]

The maximum is attained.

If

[
\eta_k\ge\frac1N
]

for any (k), then the maximizing time is a full witness, because every other coordinate is at distance at least

[
\frac1n>\frac1N.
]

---

## 5.2 Pairwise disjointness under failure

### Lemma D4 — proved-math

If the full tuple has no (1/N) witness, then

[
\boxed{K_k\cap K_\ell=\varnothing\qquad(k\ne\ell).}
]

### Proof

If (t\in K_k\cap K_\ell), then:

* membership in (K_\ell) makes coordinate (k) safe at (1/n);
* membership in (K_k) makes coordinate (\ell) safe at (1/n);
* all other coordinates are safe in either set.

Thus every coordinate is at least (1/n>1/N), a contradiction.

This is why a phase-collision argument would be decisive, but the audited tuple ((1,2,3,60)) shows that the premises do not force such a collision.

---

## 5.3 Active-coordinate theorem

### Theorem D5 — proved-math

Assume the full tuple has no (1/N) witness. For every (k), choose a maximizer

[
t_k\in K_k,\qquad
|t_k a_k|=\eta_k.
]

Then there exists some

[
i(k)\ne k
]

such that

[
\boxed{|t_k a_{i(k)}|=\frac1n.}
]

### Proof

Because there is no full witness,

[
\eta_k<\frac1N<\frac12.
]

Suppose every other constraint is strict at (t_k):

[
|t_k a_i|>\frac1n
\qquad(i\ne k).
]

There are finitely many coordinates, so continuity gives an open neighborhood (U) of (t_k) contained in (K_k).

The function

[
t\mapsto|t a_k|
]

has no local maximum at a value strictly below (1/2):

* away from an integer phase and the antipode, it is locally affine with nonzero slope;
* at an integer phase, it has a local minimum;
* its only local maxima occur at distance (1/2).

Hence some (t'\in U) satisfies

[
|t'a_k|>|t_ka_k|,
]

contradicting maximality.

Therefore at least one other coordinate is active at the exact closed deletion threshold (1/n).

No nonattained supremum is used.

---

## 5.4 Active-cycle corollary

### Corollary D6 — proved-math

Under DPLP failure, there are distinct indices

[
k_1,\ldots,k_m,\qquad m\ge2,
]

such that, cyclically,

[
\boxed{
|t_{k_s}a_{k_{s+1}}|=\frac1n,
\qquad
|t_{k_s}a_{k_s}|<\frac1N.
}
]

### Proof

Choose one active coordinate (i(k)\ne k) from D5. This defines a self-loop-free function on a finite set. Every finite functional graph contains a directed cycle, necessarily of length at least two.

---

## 5.5 First unsupported implication

The surviving target is now exact.

### `NDivisibleActiveCycleBreak` — conjectural

Let (a) be primitive, positive, and injective, with some coordinate divisible by (N). Suppose every (K_k) is nonempty. Then the active-maximizer functional graph described above cannot have all

[
\eta_k<\frac1N.
]

Equivalently, some active cycle forces a shell or empty lift.

The strongest obstruction is that:

* the active equalities occur at different times (t_k);
* the directed cycle need not contain the (N)-divisible coordinate;
* divisibility by (N) supplies no immediate comparison between distinct maximizing phases.

This is the first DPLP route in this turn that genuinely uses the entire family of deletion-safe sets rather than only low-order capacities.

## Recommended next Lean declaration

At most one new declaration is justified:

```lean
theorem deletionSafeMaximizer_has_active_coordinate
```

It should formalize D5 on the finite torus or `AddCircle`, including compact attainment and the “no sub-antipodal local maximum” lemma.

It is a real bridge. It is not a reformulation of DPLP.

---

# 6. Prime forcing: exact contract

Let (n\ge2), (N=n+1), and let (p) be prime. Put

[
M=Np.
]

Repeated residues are allowed.

### `PrimeForcing(n,p)`

For every

[
v:\operatorname{Fin}n\to{0,\ldots,M-1}
]

satisfying:

1. [
   p\nmid v_i\qquad\forall i;
   ]
2. for every deleted index (k),
   [
   \gcd\bigl(M,{v_i:i\ne k}\bigr)=1;
   ]

there exists (0\le r<M) such that

[
\boxed{
\rho_M(rv_i)\ge p
\qquad\forall i.
}
]

No injectivity is imposed on the residues.

### `UniformPrimeForcingSupply`

For every moving dimension (n) in the induction range, there is a finite set of distinct primes (\mathcal P_n) such that:

1. `PrimeForcing(n,p)` holds for every (p\in\mathcal P_n);
2. [
   \prod_{p\in\mathcal P_n}p
   \ge
   \left(
   \frac{\binom{n+1}{2}^{,n-1}}{n}
   \right)^n.
   ]

Combined with the imported minimal-counterexample product theorem and the deletion-gcd structure, this implies the positive-integer conjecture.

The product theorem remains a primary-source dependency and is not yet kernel-checked in this project.

---

# 7. Large-prime almost forcing

## 7.1 Exact one-coordinate count

For coordinate (i), let

[
A_i=
{r\bmod M:\rho_M(rv_i)<p}.
]

Put

[
d_i=\gcd(v_i,M).
]

Since (p\nmid v_i), one has (d_i\mid N). Multiplication by (v_i) has fibers of size (d_i), and the strict interval contains exactly

[
2\left\lfloor\frac{p-1}{d_i}\right\rfloor+1
]

multiples of (d_i). Therefore

[
\boxed{
|A_i|=
d_i\left(
2\left\lfloor\frac{p-1}{d_i}\right\rfloor+1
\right).
}
]

In particular,

[
|A_i|
\le2p+d_i-2
\le2p+N-2.
]

---

## 7.2 Quantitative almost-forcing theorem

For (r\bmod M), let

[
\mu(r)=|{i:r\in A_i}|.
]

Let

[
Z_0=|{r:\mu(r)=0}|,
\qquad
Z_1=|{r:\mu(r)=1}|.
]

### Theorem P1 — proved-math

[
\boxed{
2Z_0+Z_1
\ge
2p-(N-1)(N-2).
}
]

Consequently, if

[
\boxed{
2p>(N-1)(N-2),
}
]

there exists a residue bad for at most one coordinate.

### Proof

Double-count bad incidences:

[
\sum_r\mu(r)
============

\sum_i|A_i|
\le
(N-1)(2p+N-2).
]

On the other hand, every residue outside the zero- and one-bad classes has multiplicity at least two:

[
\sum_r\mu(r)
\ge
Z_1+2(M-Z_0-Z_1)
================

2Np-2Z_0-Z_1.
]

Rearranging gives the claim.

The deletion-gcd conditions are not used.

---

## 7.3 Singleton elimination is genuinely necessary

Take

[
n=3,\qquad N=4,\qquad p=5,
]

and repeated-residue-eligible tuple

[
v=(1,3,4)\pmod{20}.
]

The deletion gcd conditions hold:

[
\gcd(20,3,4)=
\gcd(20,1,4)=
\gcd(20,1,3)=1.
]

Also (5\nmid1,3,4).

Yet there is no prime-forcing residue.

It suffices by symmetry (r\leftrightarrow20-r) to inspect (0\le r\le10):

|     (r) | A coordinate with distance (<5) |
| ------: | ------------------------------- |
|       0 | (1)                             |
| 1,2,3,4 | (1)                             |
|       5 | (4), distance (0)               |
|       6 | (3), distance (2)               |
|       7 | (3), distance (1)               |
|       8 | (3), distance (4)               |
|       9 | (4), distance (4)               |
|      10 | (4), distance (0)               |

There are no empty residues, although there are (13) singleton-bad residues.

Here

[
2p=10>(N-1)(N-2)=6,
]

so P1 applies exactly as intended: it gives a singleton, not an empty residue.

Thus large-prime averaging does not prove prime forcing.

---

# 8. An eventual prime-forcing special class

Define a sign class modulo (M) by

[
v\sim w
\iff
v\equiv\pm w\pmod M.
]

Sign-equivalent coordinates have identical bad sets.

Let (s) be the number of sign classes among the (v_i).

### Theorem P2 — proved-math

If

[
\boxed{
s(2p+N-2)<Np,
}
]

then `PrimeForcing(n,p)` holds for this residue family.

In particular, if

[
2s<N,
]

then it holds for every prime satisfying

[
\boxed{
p>
\frac{s(N-2)}{N-2s}.
}
]

### Proof

There are at most (s) distinct bad sets, each of cardinality at most (2p+N-2). Hence their union has cardinality at most

[
s(2p+N-2)<Np=M.
]

Some residue avoids every bad set.

This theorem allows repeated residues and needs no deletion-gcd assumption.

### Limitation

The deletion-gcd conditions do not force (s<N/2). Collision-free tuples with (s=N-1) are compatible with all deletion gcds.

For a fixed integer counterexample and increasingly large primes, residues are typically distinct even up to sign. Thus P2 does not supply the required uniform prime product.

---

# 9. DPLP versus prime forcing

## Logical distance

### DPLP

```text
lower-dimensional pivot completeness
+ coefficient-three height branch
+ direct 1/N branch when no speed is N-divisible
+ DPLP
        ↓
DeletionPivotLifting.lean
        ↓
PositiveIntegerConjecture
        ↓
verified BHK equivalence
        ↓
LRC
```

Only DPLP itself is open; the bridge is kernel-checked.

### Prime forcing

```text
lower-dimensional theorem
+ deletion-gcd-one structure
+ UniformPrimeForcingSupply
+ imported minimal-counterexample product theorem
        ↓
product contradiction
        ↓
PositiveIntegerConjecture
        ↓
LRC
```

The local-to-global arithmetic is short, but two substantive dependencies remain:

1. uniform prime supply;
2. formal incorporation of the product bound.

P1 shows that for large primes the local cover theorem reduces to an empty-versus-singleton problem. That is structurally very close to DPLP rather than easier than it.

## Honest conclusion

Prime forcing currently **relocates** the hard singleton-elimination problem to modulus (Np). It gains multiplicative accumulation over many primes, but it pays for that gain through the product theorem and a stronger universal local statement.

DPLP is logically closer to the present verified project.

---

# 10. Adversarial ranking

The percentages below are research-management estimates for one major Sol turn, not mathematical probabilities.

|  Rank | Route              |               Open bridge count | One-turn chance of material progress | Independent publishability | Main objection                                                                                           |
| ----: | ------------------ | ------------------------------: | -----------------------------------: | -------------------------- | -------------------------------------------------------------------------------------------------------- |
| **1** | Corrected DPLP     |                               1 |                           **30–40%** | High                       | Low-order surplus criteria already fail; active-cycle arithmetic is still missing                        |
| **2** | Prime forcing      | 1 plus imported product theorem |                           **20–30%** | Very high                  | Large-prime averaging reaches only a singleton; full local forcing may encode the original cover problem |
| **3** | Top-two pivots     |                               1 |                           **10–20%** | High                       | Several natural cross-pivot and fractional invariants are already false                                  |
| **4** | Height compression |                               1 |        **<5%** with known operations | High if found              | Verified replacements apply to an extremely sparse subset of residual tuples                             |

### Why DPLP now ranks first

* its exact implication chain is already kernel-checked;
* it uses lower-dimensional completeness directly;
* its (N)-divisible premise excludes the consecutive obstruction;
* its remaining failure mode has the sharp geometric form “pairwise-disjoint deletion-safe sets with sub-(1/N) exceptional maxima”;
* the active-maximizer theorem supplies a concrete cycle structure not present in the raw modular-cover formulation.

Prime forcing remains the strongest parallel project because the product-amplification mechanism is independently valuable.

---

# 11. Stop/continue decision

## Continue DPLP, but only on the active-cycle route

Continue for one further major Sol turn with the single target:

### `NDivisibleActiveCycleBreak`

Prove or refute that the active-maximizer cycle from D6 is incompatible with:

* primitivity;
* positivity and injectivity;
* some (N)-divisible speed;
* pairwise-disjoint deletion-safe sets (K_k);
* all exceptional maxima below (1/N).

### Budget

* one analytic derivation of the signed active constraints at the maximizing times;
* one exact finite sweep of the resulting signed-cycle condition;
* one Lean declaration:

  ```lean
  deletionSafeMaximizer_has_active_coordinate
  ```

### Stop conditions

Freeze DPLP if:

1. a DPLP-eligible tuple realizes the complete signed-cycle obstruction with no lift;
2. the signed-cycle statement reduces to selecting one arbitrary certificate per deletion;
3. the first necessary cycle inequality is already violated by ((1,2,3,60)), ((1,2,6,8,10)), or (G);
4. no arithmetic use of the (N)-divisible coordinate survives the fact that the directed cycle can avoid it.

## Freeze the low-order DPLP counting branch

Both natural forms are now exactly refuted:

* first-order deep plus shell-pair surplus;
* third-order deep Bonferroni plus shell-pair surplus.

No higher fixed-order variant should be pursued without a new structural reason. Otherwise it repeats the rejected correlation-polynomial history.

---

# 12. Final first gaps

| Route              | First unsupported implication                                                                                                                         |
| ------------------ | ----------------------------------------------------------------------------------------------------------------------------------------------------- |
| DPLP active-cycle  | Convert the active equality cycle, at different maximizing times, into a shell or empty lift using the global (N)-divisible coordinate.               |
| Prime forcing      | Eliminate the singleton-bad residues guaranteed in abundance by P1 under the deletion-gcd conditions.                                                 |
| Top-two            | Prove the second pivot succeeds in the exact compressed fastest-pivot failure regime.                                                                 |
| Height compression | Find a height-reducing replacement whose changed-pivot witness lifts and which is available on a substantial fraction of structurally minimal tuples. |

No unrestricted proof claim is made.
