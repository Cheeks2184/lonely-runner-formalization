# 1. Research memo and disposition

**Cell:** Prompt 67, `UNIFORM-PRIME-FORCING-SUPPLY`
**Repository boundary inspected:** `Cheeks2184/lonely-runner-formalization`, main head `e9f31fde0644298de4631d1a1d9c5afe83d5087f`. The head change was operational documentation only and promoted no mathematical result.
**Disposition:** **PIVOT**

The uniform supply theorem remains `open`. This turn produced four substantive outcomes.

1. **Small-prime forcing:** `proved-math`. For every `n≥3` and every prime `p≤N=n+1`, `PrimeForcing(n,p)` holds, with the universal witness `r=N`. This does not use the deletion-gcd hypotheses.

2. **Small-prime insufficiency:** `proved-math`. The product of all distinct primes `p≤N` is always strictly too small to reach the exact MSS threshold. Thus the elementary theorem cannot by itself supply `UniformPrimeForcingSupply`.

3. **Frozen computation:** `computed finite evidence`. The one permitted new dimension and interval were

   ```text
   n_new = 4,  N = 5,  primes in [2,7] = 2,3,5,7.
   ```

   The complete repeated-tuple scans found:

   ```text
   PrimeForcing(4,2): no failures
   PrimeForcing(4,3): no failures
   PrimeForcing(4,5): no failures
   PrimeForcing(4,7): 13,824 failures
   ```

   The first `p=7` failure is the ordered tuple `(1,3,4,5)`.

4. **Uniform-route assessment:** Attack A and Attack B each reduce the target to one explicitly named, structurally narrower `open` lemma. Attack A has an exact interval whose prime product automatically crosses the threshold, but its proposed axial modular structure encounters infinite obstructions when dimension varies. Attack B gives a genuine finite-signature classification target and an exact Euclidean distinct-prime extraction once that classification is supplied. It is the better next direction, but no finite-signature classification was proved here.

The correct disposition is therefore **PIVOT**, rather than `CONTINUE`, because the interval approach did not yield any uniform forcing theorem, and rather than `STOP`, because the obstruction-signature statement is a genuine prime-independent structural compression rather than a restatement of the original finite cover.

The external MSS product result remains `literature` and `external-unformalized`. The latest primary fixed-dimensional result used here proves `LRC(k)` for `k≤12`; it does not provide an unrestricted theorem. ([arXiv][1])

---

# 2. Exact theorem statements

## 2.1 `PrimeForcing`

Fix `n : Nat` with `3≤n`, put `N=n+1`, and let `p` be prime. Put `M=Np`.

For `x : Nat`, define

```text
rho_M(x) = min(x mod M, M-(x mod M)),
```

where `x mod M` lies in `{0,…,M-1}`.

Then `PrimeForcing(n,p)` is the proposition:

```text
For every v : Fin n -> Nat satisfying

  0 <= v_i < M                                      for every i,

  gcd(M, {v_i : i != k}) = 1                       for every k,

  p does not divide v_i                            for every i,

there exists r : Nat satisfying

  0 <= r < M

and

  p <= rho_M(r*v_i)                                for every i.
```

Coordinates may repeat. The deletion gcd includes `M` and every surviving coordinate. The witness domain includes `r=0`. Badness is exactly `rho_M(r v_i)<p`, while `rho_M(r v_i)=p` is safe.

Equivalently, defining

```text
B_i(v) = {r in Z/MZ : rho_M(r*v_i) < p},
```

`PrimeForcing(n,p)` says that no admissible repeated tuple has

```text
union_i B_i(v) = Z/MZ.
```

## 2.2 `UniformPrimeForcingSupply`

For `n≥3`, define

```text
C_n = binom(n+1,2),

T_n = min {T : Nat | n^n*T >= C_n^(n*(n-1))}.
```

The defining set is nonempty, and `T_n>0`.

`UniformPrimeForcingSupply` is:

```text
For every n>=3, there exists a finite Finset P_n : Finset Nat such that

  every p in P_n is prime,

  PrimeForcing(n,p) holds for every p in P_n,

and, writing

  Q_n = product_(p in P_n) p,

we have

  Q_n >= T_n,

equivalently

  n^n*Q_n >= C_n^(n*(n-1)).
```

Because `P_n` is a finite set, all primes are distinct. Multiplicity and prime powers do not contribute.

The exact equivalence is `proved-math`:

```text
Q >= T_n  <->  n^n*Q >= C_n^(n*(n-1)).
```

For the forward direction, use the defining inequality for `T_n` and monotonicity. For the converse, `Q` belongs to the set minimized in the definition of `T_n`, hence `T_n≤Q`. No real ceiling argument is used.

## 2.3 `INTERVAL-PRIME-FORCING-SUPPLY`

For `n≥3`, define

```text
L_n = T_n + 1,
U_n = T_n! + 1,

P_n^A = {p prime : L_n <= p <= U_n}.
```

For a prime `p`, put `M=Np` and define the axial candidate set

```text
Ax(n,p)
  = {p*t mod M : 0 <= t < N}
    union
    {N*s mod M : 0 <= s < p}.
```

The single unresolved Attack A statement is:

### `INTERVAL-PRIME-FORCING-SUPPLY`

```text
For every n>=3:

  for every prime p with L_n <= p <= U_n,

  for every possibly repeated v : Fin n -> {0,...,N*p-1}
  satisfying every deletion-gcd premise and p ∤ v_i for every i,

  there exists r in Ax(n,p) such that

    p <= rho_(N*p)(r*v_i) for every i;

and, with

  Q_n^A = product_(p prime, L_n <= p <= U_n) p,

  n^n*Q_n^A >= C_n^(n*(n-1)).
```

**Status:** `open`.

The exact product conclusion is separately `proved-math`; only the axial forcing clause remains unresolved. Thus no unproved prime-counting or prime-product theorem is hidden behind the statement.

This lemma is genuinely narrower in modular structure than the target: its witnesses lie in a fixed set of at most `N+p-1` residues, strictly fewer than `Np`, and its prime set is prescribed rather than existential. It is not equivalent to enumerating all `Np` residues.

## 2.4 `OBSTRUCTION-EXTRACTION-SUPPLY`

For an admissible failure tuple `v`, let

```text
B_i = {r in Z/(N*p)Z : rho_(N*p)(r*v_i) < p}.
```

A selected subtuple indexed by an injection

```text
ι : Fin m -> Fin n
```

is an inclusion-minimal cover when

```text
union_(j : Fin m) B_(ι j) = Z/(N*p)Z
```

but deleting any selected coordinate destroys full coverage.

For `H≥1`, an `H`-bounded obstruction signature is data

```text
sigma = (m, c, z, Delta)
```

where

```text
1 <= m <= n,
c : Fin m -> {0,...,N-1},
z : Fin m -> Int,
|z_i| <= H,
Delta : Int,
Delta != 0.
```

A failure tuple realizes `sigma` when there exist:

```text
an inclusion-minimal cover ι : Fin m -> Fin n,
a unit u modulo N*p,
signs epsilon_i in {-1,+1},
```

such that for every selected coordinate,

```text
u*epsilon_i*v_(ι i) == c_i mod N,
u*epsilon_i*v_(ι i) == z_i mod p.
```

Coordinate permutations, independent sign flips, and common multiplication by a unit preserve full coverage.

The single unresolved Attack B statement is:

### `OBSTRUCTION-EXTRACTION-SUPPLY`

```text
For every n>=3, there exist

  H_n >= 1

and a finite set Sigma_n of H_n-bounded obstruction signatures

such that, for every prime p and every admissible repeated tuple v
for which PrimeForcing(n,p) fails,

  v realizes some sigma in Sigma_n,

and

  p divides Delta_sigma.
```

Put

```text
D_n = product_(sigma in Sigma_n) |Delta_sigma|,
```

with empty product `1`. Define recursively

```text
R_0 = 1,

q_j = the least prime divisor of D_n*R_j + 1,

R_(j+1) = R_j*q_j.
```

Let

```text
m_n = min {m : Nat | R_m >= T_n},

P_n^B = {q_j : 0 <= j < m_n}.
```

The statement includes the direct exact conclusion

```text
the q_j are distinct primes,

PrimeForcing(n,q_j) holds for every j<m_n,

product_(p in P_n^B) p = R_(m_n) >= T_n,

n^n * product_(p in P_n^B) p
  >= C_n^(n*(n-1)).
```

**Status:** `open`.

The only unresolved part is the finite, prime-independent signature classification and the divisibility `p∣Delta_sigma`. The extraction from that classification is `proved-math`.

This is genuinely narrower than the original cover problem. It asks for a bounded finite template set independent of `p`, followed by divisibility by one fixed integer `D_n`. It does not enumerate the original cover separately for each `(n,p)`.

---

# 3. Proof sketches

## 3.1 New exact local facts

### Small-prime forcing

**Claim:** For every `n≥3` and every prime `p≤N=n+1`, `PrimeForcing(n,p)` holds.

**Status:** `proved-math`.

Take any admissible tuple, including tuples with repetitions. Choose

```text
r=N.
```

Since `p≥2`,

```text
0 < N < Np=M.
```

Because `p∤v_i`, the residue `a_i=v_i mod p` lies in `{1,…,p-1}`. Therefore

```text
rho_M(N*v_i)
  = N*rho_p(v_i)
  = N*min(a_i,p-a_i)
  >= N
  >= p.
```

Thus `r=N` is safe for every coordinate. The deletion-gcd hypotheses are not needed.

The exact theorem is slightly stronger than required because primality is used only to interpret `p∤v_i` as a nonzero residue modulo `p`.

### Small-prime product cannot reach the threshold

Let

```text
S_n = {p prime : p <= N},
Q_n^small = product_(p in S_n) p.
```

There are at most `n=N-1` such primes and every factor is at most `N`, hence

```text
Q_n^small <= N^n.
```

Therefore

```text
n^n*Q_n^small
  <= (nN)^n
  = (2*C_n)^n.
```

For `n≥3`, `C_n≥6`, so

```text
2^n < C_n^(n*(n-2)).
```

Multiplying by `C_n^n` gives

```text
(2*C_n)^n < C_n^(n*(n-1)).
```

Consequently,

```text
n^n*Q_n^small < C_n^(n*(n-1)).
```

**Status:** `proved-math`.

Thus the universal theorem for `p≤N` supplies genuine forced prime divisors but can never cross the MSS threshold.

### Deletion-gcd premise in local prime form

Under `p∤v_i` for every coordinate, the condition

```text
forall k, gcd(Np, {v_i : i != k})=1
```

is equivalent to:

```text
for every prime ell dividing N,
at least two coordinates v_i are not divisible by ell.
```

Indeed, the prime `p` cannot divide any survivor. For a prime `ell∣N`, a deletion gcd is divisible by `ell` exactly when deleting one coordinate leaves all survivors divisible by `ell`. This occurs for some deletion exactly when at most one coordinate is nonzero modulo `ell`.

**Status:** `proved-math`.

### Exact bad-set cardinality

For one coordinate, put

```text
d_i = gcd(Np,v_i).
```

Since `p∤v_i`, one has `p∤d_i` and hence `d_i∣N`. Multiplication by `v_i` modulo `M=Np` has image the multiples of `d_i`, with exactly `d_i` preimages for each image point. The strict bad target interval contains exactly

```text
2*floor((p-1)/d_i)+1
```

multiples of `d_i`. Therefore

```text
|B_i|
  = d_i * (2*floor((p-1)/d_i)+1).
```

This count preserves the strict boundary. Targets at distance exactly `p` are excluded from `B_i`.

**Status:** `proved-math`.

## 3.2 Attack A: explicit interval and axial modular structure

### Exact prime-product argument

For fixed `n`, let `T=T_n`. Since `T>0`, the integer `T!+1` has a prime divisor `q`.

If `q≤T`, then `q∣T!`, contradicting `q∣T!+1`. Hence

```text
T < q <= T!+1.
```

Thus `q∈P_n^A`, and therefore

```text
Q_n^A >= q > T_n.
```

The exact threshold equivalence gives

```text
n^n*Q_n^A >= C_n^(n*(n-1)).
```

This proves the product clause without the prime number theorem, Bertrand’s postulate, a density estimate, or an asymptotic argument.

**Status:** `proved-math`.

### Axial identities

For `r=pt` with `0≤t<N`,

```text
rho_(Np)(p*t*v_i)
  = p*rho_N(t*v_i).
```

Thus this coordinate is bad exactly when

```text
N divides t*v_i.
```

For `r=Ns` with `0≤s<p`,

```text
rho_(Np)(N*s*v_i)
  = N*rho_p(s*v_i).
```

Put

```text
h = floor((p-1)/N).
```

Then the coordinate is strictly bad exactly when

```text
rho_p(s*v_i) <= h.
```

Hence the axial cover problem separates into:

```text
a divisibility cover over Z/NZ on the p-axis,

and

a multiplicative short-arc cover over F_p on the N-axis.
```

The exact number of uncovered `N`-axis residues is

```text
sum_(s in F_p)
  product_i (1 - 1_{[-h,h]}(s*v_i)).
```

This can be expanded using additive characters or handled by a polynomial nonvanishing argument. Repeated coordinates remain repeated factors.

### Implication to uniform supply

If `INTERVAL-PRIME-FORCING-SUPPLY` holds, take the prescribed finite set `P_n^A`. Every member is prime, every member satisfies `PrimeForcing`, and the factorial argument gives the exact cross-multiplied threshold. Thus `UniformPrimeForcingSupply` follows immediately.

### Assessment

The unresolved forcing statement is structurally narrower, but the axes do not work uniformly over all dimensions and primes. The infinite obstruction in Section 5 rejects that stronger universal claim. It does not refute the particular high interval `[T_n+1,T_n!+1]` for each fixed `n`.

The attack therefore remains `open`, but it is not the recommended lead.

## 3.3 Attack B: obstruction signatures and Euclidean extraction

Every forcing failure is a full cover by at most `n` strict modular bad sets. Deleting redundant coordinates gives an inclusion-minimal cover. Three exact symmetries preserve the cover property:

```text
coordinate permutations,

independent sign flips v_i -> -v_i,

common multiplication by a unit modulo Np.
```

The proposed classification seeks to normalize every minimal cover into one of finitely many bounded residue templates. A polynomial, determinant, or resultant associated with a normalized template would then vanish modulo every prime realizing that template. The requirement `Delta_sigma≠0` converts this vanishing into the exact divisibility

```text
p divides Delta_sigma.
```

A current primary result demonstrates this kind of polynomial control for one special signature: when `k+1` and `p>k(k+1)` are odd primes, the signature `(1,2,…,k)` is eventually proper in that paper’s `(k,p,l)` framework. It does not classify all signatures and does not prove `PrimeForcing(n,p)` for arbitrary admissible repeated tuples. ([arXiv][1])

### Exact extraction from a finite obstruction integer

Assume the classification clause and put

```text
D=D_n>0.
```

Define

```text
R_0=1,
q_j=minFac(D*R_j+1),
R_(j+1)=R_j*q_j.
```

Then:

1. `q_j` is prime by the definition of `minFac`.

2. `q_j∤D R_j`, because it divides `D R_j+1`. Therefore `q_j∤D`.

3. Every earlier `q_i` divides `R_j`, so `q_j` differs from every earlier prime.

4. If `PrimeForcing(n,q_j)` failed, the classification would imply `q_j∣D`, contradiction.

5. Since every `q_j≥2`,

   ```text
   R_j >= 2^j.
   ```

   Hence some finite `m` satisfies `R_m≥T_n`.

6. For the least such `m`,

   ```text
   P_n={q_0,…,q_(m-1)}
   ```

   is a finite set of distinct prime-forcing primes and

   ```text
   product_(p in P_n) p = R_m >= T_n.
   ```

This part is `proved-math`. No use of one prime with multiplicity occurs.

### Assessment

The finite-signature lemma is highly nontrivial, but it compresses all primes and all repeated tuples into fixed finite data. It is therefore not a disguised enumeration of `PrimeForcing(n,p)`. This is the appropriate **PIVOT** target.

## 3.4 Complete implication chain to unrestricted LRC

The MSS theorem and its strict product corollary are used only at `literature`; `external-unformalized` status. Rosenfeld states the subset-gcd theorem and derives the product sufficient condition by AM-GM. ([arXiv][2]) A later primary source states the exact strict counterexample bound

```text
u_1*...*u_n
  < (C_n^(n-1)/n)^n
```

and the prime-product contradiction. ([arXiv][1])

Assume `UniformPrimeForcingSupply` and the external MSS result.

### Bases

For one positive moving speed, hence two total runners, the repository theorem

```text
LonelyRunner.oneMovingRunner
```

is `proved-lean`.

For two positive moving speeds, hence three total runners, the repository theorems

```text
twoMovingSpeeds_of_abs_le
twoMovingSpeeds
twoMovingRunners
```

are `proved-lean`.

These are two separate bases. The `n≥3` prime-forcing step neither proves nor relabels them.

### Induction step

Fix `n≥3`. Assume positive-integer LRC for every smaller positive-moving dimension, in particular for `n-1` positive moving speeds, which means `n` total runners.

Suppose there is a counterexample with `n` positive, pairwise distinct speeds

```text
a : Fin n -> Nat.
```

#### Primitive reduction

Let `g=gcd_i a_i` and write `a_i=g b_i`. Positivity and injectivity survive division by `g`. A witness for `b` transports to a witness for `a` by inverse time scaling, so a counterexample reduces to a primitive counterexample. The repository contains the corresponding common-scale witness equivalence.

Among primitive counterexamples, choose one of minimum positive speed product. Minimality is available by well-ordering, although the deletion-gcd argument below requires only primitivity and the induction hypothesis.

#### Every deletion gcd is one

Fix a deleted coordinate `k`, and suppose the gcd `q` of the surviving `n-1` speeds is greater than one.

Because the full tuple is primitive,

```text
gcd(q,a_k)=1.
```

The induction hypothesis gives a time for the `n-1` survivors at the stronger threshold `1/n`. By continuity and

```text
1/n > 1/(n+1),
```

choose a rational time `a/b` at which every survivor is still strictly farther than `1/(n+1)`.

Consider the `q` times

```text
(qa+j b)/(q b),  0 <= j < q.
```

Every survivor is divisible by `q`, so its phase is unchanged. For the exceptional coordinate, coprimality makes the `q` phases equally spaced. One is at circle distance at least `1/4`, and

```text
1/4 >= 1/(n+1)
```

for `n≥3`. This gives a witness for the full tuple, contradiction.

Therefore

```text
gcd({a_i : i != k})=1
```

for every deletion `k`.

This argument is `proved-math` at the stated hypotheses and agrees with the literature deletion lemma. ([arXiv][2])

#### Prime forcing gives divisibility

Let `p` satisfy `PrimeForcing(n,p)`. Suppose `p` divides no speed.

Reduce every speed modulo `M=Np`:

```text
v_i = a_i mod M.
```

Distinct speeds may become repeated residues, which is why repetitions in `PrimeForcing` are mandatory.

For each deletion,

```text
gcd(M,{v_i : i != k})
  = gcd(M,{a_i : i != k})
  = 1.
```

Also `p∤v_i`. Prime forcing supplies `0≤r<M` with

```text
rho_M(r v_i) >= p
```

for every coordinate. At time

```text
t = r/M,
```

each speed has circle distance

```text
rho_M(r a_i)/M
  = rho_M(r v_i)/(Np)
  >= 1/N.
```

This contradicts the counterexample. Therefore

```text
p divides product_i a_i.
```

This is `proved-math`; the same local-to-global logic appears in the literature prime-forcing lemma. ([arXiv][2])

#### Distinct-prime product assembly

Let `P_n` be supplied by `UniformPrimeForcingSupply`. Every distinct `p∈P_n` divides the positive integer

```text
A = product_i a_i.
```

Distinct primes are pairwise coprime, so

```text
Q_n = product_(p in P_n) p
```

divides `A`. Since `A,Q_n>0`,

```text
A >= Q_n.
```

The supply inequality gives

```text
n^n*A
  >= n^n*Q_n
  >= C_n^(n*(n-1)).
```

#### Strict MSS contradiction

The external MSS product corollary gives for a primitive counterexample under the lower-dimensional hypothesis

```text
A < (C_n^(n-1)/n)^n.
```

Cross-multiplying by the positive integer `n^n` gives

```text
n^n*A < C_n^(n*(n-1)).
```

This strictly contradicts the preceding weak lower bound. Equality at the supply threshold is sufficient.

Thus positive-integer LRC holds in dimension `n`.

### Completion of induction

The `n=1` and `n=2` bases are `proved-lean`. Applying the conditional `n≥3` step successively proves the positive-integer formulation in every positive-moving dimension.

The repository defines `PositiveIntegerConjecture` with positive injective natural speeds and threshold `1/(n+1)`.  It also contains the exact equivalence

```text
conjecture_iff_positiveIntegerConjecture :
  Conjecture ↔ PositiveIntegerConjecture.
```

This is `proved-lean`.

Therefore:

```text
UniformPrimeForcingSupply
+ external MSS strict product theorem
+ the missing assembled induction wrapper

  -> unrestricted positive-integer LRC
  -> unrestricted real LRC.
```

The route is presently `conditional`. The external MSS theorem is not repository-formalized, and `UniformPrimeForcingSupply` remains `open`.

---

# 4. Dependency and obligation table

| Item                                                                          | Status                                | Exact scope                                                                                                                                       |
| ----------------------------------------------------------------------------- | ------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------- |
| `BASE-01`, `LonelyRunner.oneMovingRunner`                                     | `proved-lean`                         | One positive moving speed, two total runners.                                                                                                     |
| `BASE-02`, `twoMovingSpeeds_of_abs_le`, `twoMovingSpeeds`, `twoMovingRunners` | `proved-lean`                         | Two positive moving speeds, three total runners.                                                                                                  |
| Common positive natural scaling equivalence                                   | `proved-lean`                         | Primitive reduction at fixed stationary threshold.                                                                                                |
| `PositiveIntegerConjecture` definition                                        | `proved-lean` declaration             | Exact positive, injective natural-speed formulation.                                                                                              |
| `RED-01`, `conjecture_iff_positiveIntegerConjecture`                          | `proved-lean`                         | All-dimensional equivalence; supplies no prime-forcing theorem.                                                                                   |
| `PART-79` / Response 60 local bridge                                          | `proved-math` at stated hypotheses    | Deletion-gcd and prime-forcing-to-divisibility logic.                                                                                             |
| `VER-C2-DEPENDENCY-038`                                                       | `verified external dependency audit`  | Confirms MSS indexing, strict product logic, and sufficient integer comparison only.                                                              |
| MSS subset-gcd and product theorem                                            | `literature`; `external-unformalized` | Strict upper bound for a primitive counterexample under lower-dimensional LRC.                                                                    |
| Primitive deletion-gcd-one implication                                        | `proved-math`                         | Reproved above, using the exact induction indexing and `n≥3`.                                                                                     |
| `PrimeForcing(n,p)` to `p∣speedProduct`                                       | `proved-math`                         | Requires primitive deletion gcds and allows repeated reduced residues.                                                                            |
| Distinct forced-prime product assembly                                        | `proved-math`                         | Pairwise-coprime divisibility and positivity.                                                                                                     |
| `Q≥T_n` iff exact cross inequality                                            | `proved-math`                         | Uses the set-minimum definition only.                                                                                                             |
| `SMALL-PRIME-FORCING`, all primes `p≤N`                                       | `proved-math`                         | Universal witness `r=N`; deletion gcd unused.                                                                                                     |
| Product of all primes `p≤N` is below threshold                                | `proved-math`                         | Shows small-prime forcing cannot complete the supply.                                                                                             |
| Bad-cover equivalence                                                         | `proved-math`                         | Failure iff the strict bad sets cover every residue.                                                                                              |
| Local characterization of deletion gcds                                       | `proved-math`                         | At least two coordinates nonzero modulo each prime divisor of `N`.                                                                                |
| Exact single-coordinate bad-set cardinality                                   | `proved-math`                         | `d(2 floor((p-1)/d)+1)` for `d=gcd(Np,v)`.                                                                                                        |
| Factorial interval prime-product crossing                                     | `proved-math`                         | No analytic prime-distribution input.                                                                                                             |
| Axial forcing clause in `INTERVAL-PRIME-FORCING-SUPPLY`                       | `open`                                | All admissible repeated tuples and all primes in the explicit interval.                                                                           |
| `INTERVAL-PRIME-FORCING-SUPPLY`                                               | `open`                                | Product half proved; forcing half unresolved.                                                                                                     |
| Finite bounded-signature classification                                       | `open`; `conjectural`                 | Prime-independent templates and nonzero obstruction integers.                                                                                     |
| Euclidean distinct-prime extraction from fixed `D_n`                          | `proved-math`                         | Conditional on the finite-signature classification.                                                                                               |
| `OBSTRUCTION-EXTRACTION-SUPPLY`                                               | `open`                                | Sole unresolved Attack B statement.                                                                                                               |
| Existing `n=3` rows for `2,3,7,11,13` and failure at `5`                      | `computed finite evidence`            | Fixed dimension only. The new small-prime theorem independently proves the propositions for `p=2,3`; it does not promote the other computed rows. |
| New `n=4`, primes `[2,7]` scan                                                | `computed finite evidence`            | Complete repeated-tuple domain, independently replayed.                                                                                           |
| Optional Lean local-to-global wrapper                                         | `open`; not attempted                 | No new Lean declaration or compilation in this cell.                                                                                              |
| Assembled C2 induction route                                                  | `open`; `conditional`                 | Requires uniform supply and a formal interface to external MSS.                                                                                   |
| Unrestricted positive-integer LRC                                             | `open`                                | No status change.                                                                                                                                 |
| Unrestricted LRC                                                              | `open`                                | No status change.                                                                                                                                 |

---

# 5. Falsification findings

## 5.1 Mandatory baseline: `n=3`, `p=5`

Here

```text
N=4,
M=20,
domain={0,...,19}^3,
tuple order=lexicographic, last coordinate fastest.
```

The verifier reproduced:

```text
all ordered tuples: 8,000
premise tuples:     2,048
failures:             192
first failure:      (1,3,4)
```

For `(1,3,4)`:

```text
gcd(20,3,4)=1,
gcd(20,1,4)=1,
gcd(20,1,3)=1,
5∤1, 5∤3, 5∤4.
```

A complete 0-based first-bad-coordinate certificate for `r=0,…,19` is

```text
[0,0,0,0,0,2,1,1,1,2,2,2,1,1,1,2,0,0,0,0].
```

Thus every `r` has a coordinate with strict distance below `5`.

The closed boundaries are explicitly represented:

```text
r=5:  distances (5,5,0)
r=15: distances (5,5,0)
```

The two coordinates at distance exactly `p=5` are safe; coordinate index `2` is strictly bad.

**Exact rejected claim:** `PrimeForcing(3,5)`.

Collision-pattern census:

| Multiplicity pattern | Premise tuples | Failures |
| -------------------- | -------------: | -------: |
| `1+1+1`              |          1,680 |      192 |
| `2+1`                |            360 |        0 |
| `3`                  |              8 |        0 |

Repeated residues were therefore included and checked, not removed by a distinctness filter.

## 5.2 Frozen new interval: `n=4`, primes `[2,7]`

The declared interval contained exactly the increasing primes

```text
2,3,5,7.
```

No other prime or dimension was scanned.

| Prime `p` | `M=5p` | All ordered tuples | Premise tuples | Failures | First failure |
| --------: | -----: | -----------------: | -------------: | -------: | ------------- |
|         2 |     10 |             10,000 |            608 |        0 | none          |
|         3 |     15 |             50,625 |          9,728 |        0 | none          |
|         5 |     25 |            390,625 |        160,000 |        0 | none          |
|         7 |     35 |          1,500,625 |        787,968 |   13,824 | `(1,3,4,5)`   |

Every zero-failure row is only `computed finite evidence`.

For the first `p=7` failure,

```text
gcd(35,3,4,5)=1,
gcd(35,1,4,5)=1,
gcd(35,1,3,5)=1,
gcd(35,1,3,4)=1,
```

and no coordinate is divisible by `7`.

The complete first-bad-coordinate cover certificate for `r=0,…,34` is

```text
[0,0,0,0,0,0,0,3,2,2,1,1,1,1,3,3,2,2,2,2,
 3,3,1,1,1,1,2,2,3,0,0,0,0,0,0].
```

Boundary rows include

```text
r=7:  (7,14,7,0)
r=14: (14,7,14,0)
r=21: (14,7,14,0)
r=28: (7,14,7,0).
```

Distances equal to `7` are safe. Coordinate index `3`, whose value is `5`, supplies strict badness at the first and last displayed rows.

**Exact rejected claim:** `PrimeForcing(4,7)`.

The `n=4` threshold is

```text
C_4 = 10,
4^4 = 256,
C_4^(4*3) = 10^12,
T_4 = 3,906,250,000.
```

The product of the successful primes in the declared interval is only

```text
2*3*5=30,
256*30=7,680 < 10^12.
```

Thus the new interval supplies no threshold argument even before accounting for the failure at `p=7`.

## 5.3 Collision patterns in the new interval

Each cell is `premise tuples / failures`.

| Pattern   |     `p=2` |       `p=3` |         `p=5` |              `p=7` |
| --------- | --------: | ----------: | ------------: | -----------------: |
| `4`       |   `4 / 0` |     `8 / 0` |      `20 / 0` |           `24 / 0` |
| `3+1`     |  `64 / 0` |   `288 / 0` |   `1,520 / 0` |        `2,784 / 0` |
| `2+2`     |  `60 / 0` |   `264 / 0` |   `1,140 / 0` |        `2,520 / 0` |
| `2+1+1`   | `360 / 0` | `4,128 / 0` |  `41,040 / 0` |      `136,800 / 0` |
| `1+1+1+1` | `120 / 0` | `5,040 / 0` | `116,280 / 0` | `645,840 / 13,824` |

Every collision pattern compatible with the premises occurred in the enumeration. The fact that all observed `p=7` failures have four distinct residues is a fixed-scan observation only. It does not authorize a distinct-coordinate restriction in another dimension or prime.

## 5.4 Infinite obstruction to universal axial forcing

For every odd prime `p≥11`, put

```text
N=(p+1)/2,
n=N-1,
M=Np,
v=(1,2,...,N-2,N)
```

in the displayed order.

The tuple is admissible:

* no coordinate is divisible by `p`;
* deleting a coordinate other than `1` leaves the coordinate `1`;
* deleting `1` leaves both `2` and `3`, whose gcd with `M` is one.

Every `p`-axis candidate `r=pt` is bad because the coordinate `N` satisfies

```text
r*N = p*t*N = M*t,
rho_M(r*N)=0.
```

For the `N`-axis,

```text
p=2N-1,
floor((p-1)/N)=1.
```

The residues

```text
1,2,...,N-2,N
```

represent every sign pair in `F_p^*`, because `N≡-(N-1) mod p`. For each nonzero `s`, some coordinate `v_i` satisfies

```text
s*v_i == +1 or -1 mod p.
```

Hence

```text
rho_M(N*s*v_i)=N<p.
```

The case `s=0` is also bad. Thus no axial candidate is safe.

**Exact rejected claim:** there is an absolute prime cutoff beyond which the two axial families work for every dimension and every admissible tuple.

This does not reject fixed-`n` eventual forcing and does not refute the high factorial interval in `INTERVAL-PRIME-FORCING-SUPPLY`.

## 5.5 `N`-axis alone is insufficient

Take

```text
n=3, N=4, p=7, M=28,
v=(1,2,3).
```

Every deletion gcd is one and no coordinate is divisible by `7`. The sign classes of `1,2,3` exhaust `F_7^*/{±1}`, so for every `s` some coordinate has

```text
rho_7(s*v_i)=1,
rho_28(4*s*v_i)=4<7.
```

Thus the entire `N`-axis fails.

Nevertheless, `r=p=7` is safe:

```text
rho_28(7*(1,2,3))=(7,14,7).
```

**Exact rejected claim:** the `N`-axis by itself always supplies the forcing witness.

This is not a failure of `PrimeForcing(3,7)`.

## 5.6 Fixed third-order Bonferroni does not certify all admissible tuples

Let

```text
n=5, N=6,
v=(1,1,1,1,1)
```

for any prime `p`. This repeated tuple satisfies every deletion-gcd premise.

All five bad sets are the same set `B`, with

```text
|B|=2p-1.
```

The third-order Bonferroni upper expression is

```text
5|B| - binom(5,2)|B| + binom(5,3)|B|
  = 5(2p-1)
  > 6p=M
```

for every `p≥2`, even though the actual union has size only `2p-1<M`.

**Exact rejected claim:** the fixed third-order Bonferroni deficit inequality uniformly certifies noncoverage for all admissible repeated tuples.

This rejects only the sufficient condition, not `PrimeForcing` or the uniform supply target.

## 5.7 Structural-progress tests

`INTERVAL-PRIME-FORCING-SUPPLY` is not literal finite-cover enumeration because

```text
|Ax(n,p)| <= N+p-1 < Np
```

for `N,p≥2`.

`OBSTRUCTION-EXTRACTION-SUPPLY` is not dimension-by-dimension enumeration because its bounded templates, obstruction integers, and fixed `D_n` must be chosen independently of `p`.

The complete `n=4` interval result remains `computed finite evidence`. It cannot establish either named uniform lemma.

---

# 6. Verifier plan and frozen execution

## 6.1 Literal verifier

**Implementation:** C++20.

For each case `(n,p)`:

1. Enumerate all ordered tuples in `[0,M)^n`.
2. Use lexicographic order with the last coordinate changing fastest.
3. Check `p∤v_i` for every coordinate.
4. For every deletion index `k`, compute the gcd beginning with `M` and all surviving coordinates.
5. For each premise tuple, test `r=0,1,…,M-1`.
6. For each `r`, test coordinates in increasing index order using strict badness `rho<p`.
7. Stop only the `r` scan for the current tuple after finding its first safe witness.
8. Never stop the tuple enumeration after a failure.

The verifier emits:

```text
255  for a nonpremise tuple,
254  for a forcing failure,
r    for a success whose first witness is r.
```

This gives one byte for every ordered tuple.

For every failure, it additionally emits:

```text
8-byte little-endian tuple ordinal,

followed by M one-byte coordinate indices,

where byte r is the first strictly bad coordinate at residue r.
```

Thus every success has an explicit first witness, and every failure has a complete modular-cover certificate.

## 6.2 Independent orbit/bitset verifier

**Implementation:** Python 3.13.5.

This verifier does not import or invoke the C++ code.

1. Enumerate nondecreasing tuples using `combinations_with_replacement`.
2. Preserve all repeated-coordinate orbits.
3. Give each representative exact orbit weight

   ```text
   n! / product multiplicity!.
   ```
4. Precompute the strict bad-set bitmask of each possible coordinate value.
5. Test failure by taking the bitwise union of the coordinate masks.
6. Find the first safe witness as the first clear bit.
7. Independently expand every accepted orbit to all ordered coordinate permutations.
8. Reconstruct the full ordered one-byte outcome map.
9. For every failed ordered tuple, independently reconstruct the complete first-bad-coordinate cover stream.

The quotient is sound because:

* all premise conditions are invariant under coordinate permutation;
* repeated coordinates are retained through exact orbit sizes;
* the bad-set union and first safe `r` are permutation invariant;
* strict `<p` is used in every bitmask;
* full ordered expansion restores the original tuple ordering and count.

## 6.3 Frozen cross-verifier result

For all five cases, the implementations matched on:

```text
scope,
n, N, p, M,
full tuple count,
premise count,
failure and success counts,
first failure,
first-failure cover vector,
all first-failure distance rows,
first-witness histogram,
boundary-witness count,
outcome encoding,
failure-certificate encoding,
tuple order,
global early-stop status.
```

They also produced:

```text
five byte-identical full ordered outcome maps,

five byte-identical complete failure-cover streams.
```

The bundle was extracted into a fresh directory, both sources were rerun, the C++ binary rebuilt to the same SHA-256, and the emitted JSON transcripts reproduced byte-for-byte.

## 6.4 Tool versions and runtime

```text
Linux:  6.12.13 x86_64
CPU:    AMD EPYC 9V74, 5 online vCPUs visible
g++:    Debian 14.2.0-19
Python: 3.13.5
```

| Verifier            | Wall time | Maximum RSS | Exit |
| ------------------- | --------: | ----------: | ---: |
| Literal C++         |    0.13 s |    6,432 KB |    0 |
| Orbit/bitset Python |    1.39 s |  114,464 KB |    0 |

Runtime is operational information, not evidence of theorem status.

## 6.5 Artifact hashes

| Artifact                 | SHA-256                                                            |
| ------------------------ | ------------------------------------------------------------------ |
| Literal C++ source       | `92cdbe0666f6fdcb17d4deebdfc102656af8bf97c8390670ae4af08f0cce4fe3` |
| Literal binary           | `267aa17b5cc198ae5757a757420de92e69f7cc2b52a6b74c57c60b006431acdd` |
| Literal JSONL            | `ce2d6861d1a14a758e314f62c1294c45f2989b430cf7e74d18675f8d158478c1` |
| Literal timing           | `e7b7ec382d316f6149b714dedc0e1798fc2964783372fe29d618554031ce13e8` |
| Orbit/bitset source      | `8f8ba8e5b1178ed91788cf7a72ce485e7ebfa76e0819a4647b1fa80471b84332` |
| Orbit/bitset JSONL       | `657dbc0fcb1e51cc37addc12514bbc9854739ebf5c20c47100f0a82c6c4947f1` |
| Orbit/bitset timing      | `6bb0f30e8135996679e931327cd17e8e57c6dbc4110d091bc1e376b3976dcd5c` |
| Cross-verifier source    | `71a1ab9d7b28426383706efef8b5bc9f072cc075951d39b3dfe7b87e5bf65f42` |
| Cross-verifier report    | `c75f8a4f5c1b9aa000f7a0179b9984e5ba56178774a0b89a67d2fed08ad11d2d` |
| Execution manifest       | `fb23bdd68c14970bb05c1a92f824c033145757f9c0585576b1e0f520475e8e8e` |
| Complete verifier bundle | `fd41143f944bdd22117b6048fab0905c4cba6d44101167d8105db0d74dfc537b` |

Outcome-map hashes, identical between verifiers:

| Case      | SHA-256                                                            |
| --------- | ------------------------------------------------------------------ |
| `n=3,p=5` | `cf48ec10efc22ff7c6670bc542622c5d34f33c7c8e63efc681f26d521b78dcf2` |
| `n=4,p=2` | `a471a64c86fdd8353aa8bf7fcb05dfe3e6ac0950c14d8868c1174c3d3dfd39d6` |
| `n=4,p=3` | `21375085d6421a6f93053d21b66865a72872cbab751526fa06624d151807c6c1` |
| `n=4,p=5` | `badd4dcfd949e209b7772b972ec33de44a41e27fdc9c2954e6dfcbffb37ec030` |
| `n=4,p=7` | `76edf68d3b04e9d5e66a3b3ac7a1d8ab5da3ad34314ac28e1586568285f9b838` |

Nonempty failure-cover stream hashes:

```text
n=3,p=5:
483457e1547fd45f767a4170f74c08a08d93b88f078b823089ccb0a21a700f39

n=4,p=7:
e39103f40fb55e5bc03e37e4ef73eecd8b4e70c2308091893e65e064eb842ba2
```

The failure streams for the three zero-failure cases are empty files with the standard empty-file SHA-256.

## 6.6 Replay commands

After extracting the bundle:

```bash
g++ -O3 -std=c++20 -Wall -Wextra -pedantic \
  p67_literal_v1.cpp -o p67_literal_v1

P67_CERT_DIR=. /usr/bin/time \
  -f 'wall_seconds=%e\nmax_rss_kb=%M\nexit_status=%x' \
  -o p67_literal_v1.time \
  ./p67_literal_v1 > p67_literal_v1.jsonl

P67_CERT_DIR=. /usr/bin/time \
  -f 'wall_seconds=%e\nmax_rss_kb=%M\nexit_status=%x' \
  -o p67_orbit_bitset_v1.time \
  python3 p67_orbit_bitset_v1.py > p67_orbit_bitset_v1.jsonl

python3 p67_cross_compare_v1.py > p67_cross_compare_v1.json

sha256sum \
  p67_literal_v1.cpp \
  p67_literal_v1 \
  p67_literal_v1.jsonl \
  p67_literal_v1.time \
  p67_orbit_bitset_v1.py \
  p67_orbit_bitset_v1.jsonl \
  p67_orbit_bitset_v1.time \
  p67_cross_compare_v1.py \
  p67_cross_compare_v1.json \
  p67_outcomes_*.bin \
  p67_failure_covers_*.bin
```

Artifacts:

* [Complete Prompt 67 verifier bundle](sandbox:/mnt/data/prompt67_verifier_bundle.tar.gz)
* [Execution manifest](sandbox:/mnt/data/p67_execution_manifest.json)
* [Literal C++ verifier](sandbox:/mnt/data/p67_literal_v1.cpp)
* [Independent orbit/bitset verifier](sandbox:/mnt/data/p67_orbit_bitset_v1.py)
* [Cross-verifier report](sandbox:/mnt/data/p67_cross_compare_v1.json)

## 6.7 Optional single Lean prototype

No Lean prototype was attempted or compiled. No new claim is `proved-lean`.

The one admissible prototype selected for later work is only:

```text
from a supplied PrimeForcing(n,p) function,

a positive injective primitive speed tuple,

and every exact deletion-gcd-one hypothesis,

prove p divides the positive speed product.
```

The proof would reduce speeds modulo `Np`, invoke the supplied forcing witness, convert `r/(Np)` into a stationary witness under the assumption that `p` divides no speed, and derive a contradiction.

It would not formalize MSS, the threshold contradiction, the distinct-prime assembly, or both wrappers at once. Until such a declaration compiles and passes an axiom audit, its status is `open`.

---

# 7. Final boundary statement

### `proved-lean`

Existing repository results only:

```text
BASE-01,
BASE-02,
common-scale normalization,
the positive-integer formulation declarations,
RED-01 real/integer equivalence.
```

No new Lean theorem was compiled.

### `proved-math`

This memo establishes:

```text
PrimeForcing(n,p) for every prime p<=n+1,

the strict insufficiency of the product of all such small primes,

the exact T_n cross-multiplication equivalence,

the bad-cover reformulation,

the local deletion-gcd characterization,

the exact single-coordinate bad-set cardinality,

the factorial-interval prime-product bound,

the Euclidean distinct-prime extraction conditional on a fixed obstruction integer,

the complete conditional implication chain from uniform supply
through the external MSS theorem to unrestricted LRC.
```

The last chain is conditional because its uniform supply premise and external MSS formal interface are not proved in the repository.

### `computed finite evidence`

The complete `n=3,p=5` baseline and the complete `n=4`, prime interval `[2,7]` scans, including repetitions, all deletion-gcd filters, closed boundaries, every collision pattern, full outcome maps, and complete failure-cover streams.

No computation is promoted to a theorem.

### `rejected`

At exact scope:

```text
PrimeForcing(3,5),

PrimeForcing(4,7),

universal N-axis forcing,

an absolute-cutoff all-dimension axial forcing claim,

uniform certification by fixed third-order Bonferroni.
```

None of these rejections refutes `UniformPrimeForcingSupply` or unrestricted LRC.

### `conjectural` and `open`

```text
INTERVAL-PRIME-FORCING-SUPPLY,

the finite bounded obstruction-signature classification,

OBSTRUCTION-EXTRACTION-SUPPLY,

UniformPrimeForcingSupply,

the missing assembled Lean C2 route,

unrestricted positive-integer LRC,

unrestricted LRC.
```

### `literature`; `external-unformalized`

The Malikiosis–Santos–Schymura subset-gcd theorem and strict product upper bound. `VER-C2-DEPENDENCY-038` is only a `verified external dependency audit`; it does not convert MSS into a repository `proved-math` or `proved-lean` theorem.

**Final disposition: PIVOT to `OBSTRUCTION-EXTRACTION-SUPPLY`.** The exact small-prime theorem is useful but provably threshold-insufficient. The interval attack has an exact product mechanism but no surviving uniform forcing proof. A prime-independent finite obstruction classification is the sole route here that both differs materially from direct cover enumeration and automatically yields a product-large set of distinct prime-forcing primes.

[1]: https://arxiv.org/html/2604.23906v1 "https://arxiv.org/html/2604.23906v1"
[2]: https://arxiv.org/html/2509.14111v2 "https://arxiv.org/html/2509.14111v2"
