# Independent mathematical audit of Response68

Audit task: `VERIFY-P68-MATHEMATICAL-AUDIT-148`

Base commit: `6d1a06047718570d3038b8e069b493be4bf3023c`

Recovered response inspected at: `23ca5b89b13ae879c546598d7b56888a92fc39f2`

Audited artifact: `research/sol-pro/responses/response68.md`

Audit scope: mathematical claims and implication chain only. Attached programs were not executed.

## Disposition

**QUALIFIED ACCEPT as a mathematical research memo; no promotion of the main
conjecture or of `COFINITE-PRIME-FORCING`.**

The elementary modular claims, the exact CRT fiber calculation, the bounded
modular-annihilator theorem, and its rational-hyperplane consequence survive
independent scrutiny, subject to freezing the garbled displayed constant as

\[
H_n := 2n\,5^{n-1}4^n+1.
\]

The response does not prove cofinite prime forcing. Its own `PIVOT`
disposition is therefore not an accepted mathematical status label. The
complete route to unrestricted LRC remains conditional on both:

1. `COFINITE-PRIME-FORCING` in every moving dimension `n ≥ 3`; and
2. the external, presently unformalized MSS/Rosenfeld product criterion.

The finite computations are **computed-unreviewed**, not accepted computed
finite evidence in this audit: the response links transient attachments, but
the recovery commit does not contain the declared source/output bundle and
this task expressly did not execute attachments.

## Claim table

| Response claim | Audit disposition | Scope and qualification |
| --- | --- | --- |
| Cofinite/finite-bad-set/finite-exception/cutoff equivalence | `proved-math` | Sound for each fixed `n ≥ 3`, including the empty exceptional set (`D=1`, cutoff `0`). |
| Inclusion-minimal selected cover and private points | `proved-math` | Sound in the finite coordinate set; repetitions are allowed. Minimality removes duplicate selected sets, not duplicate input coordinates. |
| Exact bad-set cardinality | `proved-math` | Sound with strict badness: `|B_i| = d_i(2⌊(p-1)/d_i⌋+1)`, where `d_i=gcd(Np,v_i)` and `d_i ∣ N`. Equality is safe. |
| Primewise deletion-gcd criterion | `proved-math` | Sound: for every prime `ℓ ∣ Np`, at least two coordinates are nonzero modulo `ℓ`. |
| Universal witness for `p ≤ N` | `proved-math` | Sound with `r=N`, including `p ∣ N`; no CRT assumption is used. |
| Product of primes `p ≤ N` is below `T_n` | `proved-math` | Sound for all `n ≥ 3`. It also correctly shows the automatic small primes alone cannot meet the later product threshold. |
| Mandatory `N`-divisible coordinate and upper bound `n-2` | `proved-math` | Sound for every admissible full cover, including repetitions and primes dividing `N`. |
| Exact `p>N` CRT fiber formula and capacity inequality | `proved-math` | Sound, including `d_i=1` and `d_i=N`; only this branch uses `gcd(p,N)=1`. |
| Bounded modular-annihilator theorem | `proved-math`, corrected statement required | Fourier proof is sound after fixing `H_n` as above and explicitly defining the circle representative/tent function. Deletion gcd is not needed. |
| Bounded rational-hyperplane consequence | `proved-math` | Sound necessary condition for positive-integer counterexamples; it does not imply a finite exceptional-prime set. |
| Exact natural threshold equivalence | `proved-math` | Sound in `ℕ`; no ceiling argument is hidden. |
| Euclidean prime extraction from supplied `D_n` | `proved-math` (conditional lemma) | Sound and constructive once the cofinite certificate is assumed. |
| Primitive reduction | `proved-math` | Sound for positive injective integer tuples. |
| Every-deletion gcd bridge | `proved-math` (conditional lemma) | Sound assuming lower-dimensional LRC. The open-arc endpoint at equality is handled correctly. |
| Reduction modulo `Nq` and prime divisibility | `proved-math` (conditional lemma) | Sound after the deletion-gcd bridge; repetitions after reduction are permitted. No CRT or `q∤N` hypothesis is needed here. |
| Product assembly | `proved-math` (conditional lemma) | Sound for distinct supplied primes dividing the positive speed product. |
| MSS/Rosenfeld strict product upper bound | `literature`, `external-unformalized` | The cited primary statements support the indexing and strict bound used, but no repository Lean declaration supplies this edge. |
| Full cofinite-to-real-LRC chain | `conditional` | Sound as a mathematical implication with the two dependencies listed above. |
| Two displayed full-cover fixtures and eight-prime sweep | `computed-unreviewed` | Plausible and internally specified, but not independently replayed from a recovered immutable bundle in this audit. |
| `COFINITE-PRIME-FORCING` | `open` | Neither Attack A nor Attack B proves it. |
| Unrestricted LRC | `open` | No promotion. |

## Detailed checks

### 1. Cofinite formulations and minimal covers

For fixed `n`, a prime is bad exactly when `PrimeForcing(n,p)` fails. If a
positive integer `D` captures all bad primes, the bad set is contained in the
finite set of prime divisors of `D`. Conversely, the product of a finite bad
set works; the empty product is `1`. A finite bad set has a maximum unless
empty, for which cutoff `0` works. These implications preserve all fixed-`n`
quantifiers.

A least-cardinality selected subcover exists because there are finitely many
coordinates. Removing a selected coordinate must expose a private point.
Every individual bad set is proper by the cardinality calculation below, so a
minimal full cover has at least two members. Since `0` is in every bad set,
no private point can be `0`.

### 2. Bad-set cardinality and endpoints

Let `M=Np` and `d=gcd(M,v_i)`. Admissibility gives `p∤v_i`, hence `p∤d`;
because `d∣Np`, this forces `d∣N`, even when `p∣N`. Multiplication by `v_i`
has kernel size `d`, and after dividing by `d`, the image coordinate is a
unit modulo `M/d`. Strict badness becomes

\[
d\rho_{M/d}(x)<p
\quad\Longleftrightarrow\quad
\rho_{M/d}(x)\le \left\lfloor\frac{p-1}{d}\right\rfloor.
\]

The positive and negative ranges do not overlap because `N≥4`. Multiplying
their count by the kernel size proves

\[
|B_i|=d\left(2\left\lfloor\frac{p-1}{d}\right\rfloor+1\right).
\]

The bound `|B_i|≤2p+N-2<Np` is strict since
`Np-(2p+N-2)=(N-2)(p-1)>0`. This confirms properness and confirms that points
with `ρ=p` are excluded.

### 3. Deletion gcd and the small-prime branch

For each prime `ℓ∣M`, every deletion retains gcd one with `M` exactly when at
least two coordinates are not divisible by `ℓ`: deleting the only
nondivisible coordinate proves necessity, and one of two survives every
deletion for sufficiency.

The identity `ρ_{Np}(Nx)=Nρ_p(x)` gives the witness `r=N`. Since `p∤v_i`,
`ρ_p(v_i)≥1`; hence `ρ_{Np}(Nv_i)≥N≥p` whenever `p≤N`. Equality is safe.
This explicitly covers every `p∣N` case before CRT is invoked.

Writing `S_N` for the product of primes at most `N`, `S_N≤N^N`. The response's
separate check for `n=3` is correct. For `n≥4`, with
`C_n=n(n+1)/2`, the chain based on `N≤2n`, `C_n≥2n`, and
`n(n-1)≥2n+1` is strict at the required step and gives
`n^nS_N<C_n^{n(n-1)}`. Thus `S_N<T_n` under the exact threshold definition.

### 4. `N`-divisibility and CRT fibers

At `r=p`,

\[
r\in B_i\iff p\rho_N(v_i)<p\iff N\mid v_i.
\]

A full cover therefore has an `N`-divisible coordinate. For any prime
`ℓ∣N`, the deletion condition leaves at least two coordinates nondivisible
by `ℓ`; consequently at most `n-2` coordinates can be divisible by `N`.

For `p>N`, CRT is legitimate. In the column `x mod p`, set
`z_i` to the representative of `xb_i` in `{0,…,p-1}` and
`d_i=gcd(N,c_i)`. For `x≠0`, the only signed representatives with absolute
value `<p` are `z_i` and `z_i-p`. The congruence `c_i y≡a (mod N)` has exactly
`d_i` solutions iff `d_i∣a`, proving the displayed fiber formula.

If both divisibilities hold then `d_i∣p`; since `d_i∣N` and `gcd(p,N)=1`,
`d_i=1`. In that remaining case the two solution classes are distinct modulo
`N`, because their right sides differ by `p` and `N∤p`. Thus no solutions
were double-counted. For `d_i=N`, the column contribution is either `0` or
all `N` points; for `d_i<N` it is at most `2d_i`. The stated capacity bound
is therefore a valid necessary condition on any column not already wholly
covered by an `N`-divisible coordinate. It is not an average or a sufficient
condition.

### 5. Bounded annihilator

The first display of `H_n` in the response is typographically corrupted. The
later inequalities and final boundary uniquely identify the intended frozen
constant as

\[
H_n=2n\,5^{n-1}4^n+1.
\]

With `w=(N-2)/(2N)`, the periodic tent centered at `1/2` has closed support
`[1/N,1-1/N]` and value zero at both endpoints. Its coefficients are

\[
\widehat g(0)=w,
\qquad
\widehat g(k)=(-1)^k w^{-1}
\left(\frac{\sin(\pi k w)}{\pi k}\right)^2.
\]

The response's bounds
`|ĝ(k)|≤1/(4wk²)`, total Fourier `ℓ¹` norm `<5`, and tail
`∑_{|k|>H}|ĝ(k)|<1/(2wH)` follow from `π²>4` and the elementary reciprocal
square estimates. The product tail is bounded by the union bound
`n5^{n-1}/(2wH)`. With the corrected `H_n`, it is strictly below
`4^{-n}≤w^n`, the constant coefficient.

Under the cover hypothesis, including at `x=0`, at least one coordinate lies
outside the tent's closed safe support, so every sampled product is zero.
Absolute convergence justifies termwise averaging. Root-of-unity
orthogonality keeps precisely the integer frequencies satisfying
`c·b≡0 (mod p)`. If the bounded cube contained no nonzero annihilator, the
remaining tail could not cancel the positive constant term. This proves a
nonzero `c` with `||c||∞≤H_n`. If `p>H_n`, a support-one relation would force
`p∣c_i` while `|c_i|<p`, hence is impossible because `b_i≠0`.

The reduction from a failed `PrimeForcing` tuple is also sound: restricting
the full cover to `r=Nx` gives the required strict field-circle cover through
`ρ_{Np}(Nxv_i)=Nρ_p(xb_i)`. Deletion hypotheses are unused.

### 6. Rational hyperplanes

Let a positive-integer LRC counterexample `a` be fixed. For every sufficiently
large prime `p>max(N,H_n,a_1,…,a_n)`, sample the counterexample at times
`x/p`. The bounded-annihilator theorem supplies a nonzero coefficient vector
from a finite set. One vector occurs for infinitely many primes. Those primes
all divide the fixed integer `∑c_i a_i`, so that integer is zero. Positivity
forces the nonzero vector to contain both signs.

This is a genuine unrestricted necessary theorem, but not a cofinite theorem:
a fixed exact rational relation reduces modulo every prime and therefore can
explain bounded annihilators for infinitely many primes.

### 7. Inductive bridge and dependencies

Primitive reduction is correct: dividing by the positive full gcd preserves
positivity and injectivity, and a witness at time `t` for the divided tuple
lifts to time `t/g` for the original tuple.

For a primitive tuple, if a deletion has gcd `d>1`, the omitted speed is
coprime to `d`. A lower-dimensional witness for the divided survivors persists
at the `d` times `(t+j)/d`. The omitted phases form `d` equally spaced circle
points. An open bad arc of length `2/N≤1-1/d` cannot contain all of them;
openness handles equality. Hence every deletion gcd is one, conditional on
lower-dimensional LRC.

For a supplied prime `q` not dividing the speed product, reduction modulo
`Nq` is admissible: no coordinate is divisible by `q`, and survivor gcds with
`Nq` remain one. Repetitions after reduction are harmless. A prime-forcing
witness yields a real witness at `t=r/(Nq)`, so every supplied prime must
divide the product. Distinct supplied primes then divide it jointly.

The natural threshold and Euclidean recursion are correct. The recursion
chooses a prime divisor of `DR_j+1`, so each new prime divides neither `D` nor
`R_j`; the primes are distinct and prime-forcing, and their product eventually
reaches `T_n`.

The final contradiction uses the primary-source product criterion in
[Malikiosis--Santos--Schymura, Theorem A](https://arxiv.org/html/2411.06903v2)
and its product corollary in
[Rosenfeld, Theorem 1 and Corollary 2](https://arxiv.org/html/2512.01912v1).
At the response's indexing, a primitive counterexample must satisfy

\[
n^n\prod_i a_i<C_n^{n(n-1)},
\]

whereas the supplied-prime construction forces the reverse weak inequality.
The source indexing and strict/weak directions agree. This remains a
`literature`/`external-unformalized` dependency, not a repository theorem.
Rosenfeld's Lemmas 3 and 4 also match the prime-divisibility and deletion-gcd
roles, although the response supplies direct mathematical arguments for those
two bridges.

The repository declarations actually present at the base commit are:

- `LonelyRunner.oneMovingRunner` in `LonelyRunner/BaseCases.lean`;
- `LonelyRunner.twoMovingRunners` in `LonelyRunner/SmallDimensions.lean`; and
- `LonelyRunner.conjecture_iff_positiveIntegerConjecture` in
  `LonelyRunner/BHKRealReduction.lean`.

They supply the two induction bases and the final real/integer equivalence;
they do not supply cofinite prime forcing or the external product theorem.

## Quantifier and boundary audit

- **`x=0`:** It belongs to every strict bad set. It is included in the
  Fourier average and causes no exception.
- **Strict versus closed:** Badness is always `ρ<p` (or normalized
  distance `<1/N`); equality is safe. The tent vanishes at the two equality
  endpoints, so the analytic proof respects this convention.
- **`p>N`:** Used only to obtain `gcd(p,N)=1` for CRT and, separately, when a
  sufficiently large prime is selected for the hyperplane corollary.
- **`p∣N`:** Fully discharged by the `r=N` small-prime witness. No invalid CRT
  split is made in this case.
- **Repetitions:** Allowed throughout the modular tuple domain. Minimal covers
  may discard coincident selected sets, but no distinct-residue reduction is
  inferred.
- **Primitivity:** Introduced only after a valid positive-integer gcd
  reduction. It is required for the deletion-gcd bridge and external product
  criterion, not for the modular/Fourier theorem.
- **Deletion:** The modular admissibility condition is obtained only after the
  lower-dimensional deletion argument; it is not smuggled into the Fourier
  theorem.
- **Injectivity:** Required in the positive-integer LRC formulation and
  preserved by division by the common gcd. Modular reduction may create
  repetitions, which the finite prime-forcing statement permits.

## Exact first unresolved edge

Attack A ends because its exact CRT column indicators and field ratios vary
with `p`; it produces neither a fixed cutoff nor a predeclared nonzero integer
whose prime divisors contain every bad prime.

Attack B ends one step later but at the same cofinite edge. It confines every
large-prime obstruction to one of finitely many bounded modular hyperplanes.
It does **not** exclude a bounded coefficient vector that is the reduction of
an exact rational relation among the speeds. The exact first missing lemma is
therefore:

> For each fixed `n≥3` and each nonzero mixed-sign integer vector `c` with
> `||c||∞≤H_n`, prove that admissible full strict covers satisfying
> `c·b=0` occur for only finitely many primes, with a bound uniform over the
> finite set of such `c`; or provide a counterexample family.

No argument in Response68 proves this statement, and it may itself need
further narrowing. Merely naming the annihilator or taking a post hoc
determinant divisible by `p` would be circular.

## Recommended frozen specification

The best first declaration-level target is the bounded-annihilator theorem,
followed by a separate hyperplane corollary. Freeze all of the following
before implementation:

1. `n≥3`, `N=n+1`, prime `p`, and `b : Fin n → ZMod p` with every `b i` a unit;
2. the hypothesis `∀x, ∃i, circleResidue p (x*b i) < p/N`, with the real/rational
   coercions and strict boundary explicit;
3. `H n = 2*n*5^(n-1)*4^n+1` with natural exponentiation;
4. the conclusion `∃c : Fin n → ℤ, c≠0 ∧ (∀i, |c i|≤H n) ∧
   ∑i (c i : ZMod p)*b i=0`;
5. the support-at-least-two conclusion as a separate theorem assuming
   `p>H n`;
6. no deletion-gcd premise; and
7. no claim of cofinite forcing.

Evidence label on a successful placeholder-free Lean implementation would be
`proved-lean` for this necessary theorem only. Until then it is an audited
`proved-math` candidate.

## Computational boundary

The response declares deterministic fixtures, a finite `n=3` sweep, source
and output hashes, and sensible strict/equality/enumeration conventions. The
linked artifacts use transient `sandbox:/mnt/data/...` paths and are absent
from the inspected recovery commit. Consequently this audit neither validates
the stated hashes nor promotes the counts. They remain
`computed-unreviewed`. This has no effect on the accepted symbolic proofs and
no finite sweep would imply cofiniteness in any event.

## Final evidence boundary

- Accepted as audited `proved-math`: the elementary reductions, exact CRT
  theorem, corrected bounded-annihilator theorem, hyperplane consequence, and
  conditional arithmetic bridges described above.
- Accepted as `literature`/`external-unformalized`: the cited product upper
  bound only.
- Preserved as `proved-lean`: only the three existing repository declarations
  listed above, at their exact scopes.
- Classified `computed-unreviewed`: all Response68 finite computations.
- Classified `conditional`: the cofinite-to-LRC implication chain.
- Classified `open`: cofinite prime forcing and unrestricted LRC.
