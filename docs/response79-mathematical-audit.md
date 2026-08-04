# Prompt79 independent mathematical audit

Task: `VER-P79-MATHEMATICAL-AUDIT-234`

Base: `9a5ebc29ce91531d674a51908c4fcbedfd0aab6b`

Audited response: `research/sol-pro/responses/response79.md`, SHA-256
`269c92db5246906da09ceb5b5260c94771d3d98372c67b509666cd7d13c69d9c`
(31,073 bytes).

## Verdict

The response's **STOP** boundary is mathematically correct.
`OBSTRUCTION-EXTRACTION-DISTINCT-PRIME-SUPPLY` was neither proved nor
refuted. The first unsupported arrow is

```text
canonical minimal-cover/private-point data
  -> uniformly bounded projective p-components
  -> a finite p-independent signature set with nonzero fixed obstructions.
```

The private-point construction does produce, for each failure and each pair
of selected owners, a nonzero integer divisible by the current prime. That
integer is formed only after the prime, tuple, cover, and private residues are
known. Its existence has quantifier order

```text
for every bad (p,v), there exists Theta(p,v) with Theta != 0 and p | Theta,
```

whereas the frozen bridge requires

```text
there exists one finite Sigma_n fixed before p and v such that
for every bad (p,v), some fixed nonzero Delta_sigma is divisible by p.
```

The former does not imply the latter. The two zero fixtures invalidate two
specific obstruction choices; they do not disprove the frozen bridge itself.
Accordingly, the bridge remains `open`, and this route is `stopped`, not
mathematically `rejected`.

No recovered Prompt79 attachment or output was executed, imported, or used.
The response-authored exhaustive counts and replay claims remain unverified.

## Exact frozen definitions and boundary audit

Fix `n >= 3`, set `N = n + 1`, let `p` be prime, and set `M = Np`. For an
integer `x`, let

```text
rho_M(x) = min(x mod M, M - (x mod M)),
B_i(v) = {r mod M : rho_M(r v_i) < p}.
```

`PrimeForcing(n,p)` quantifies over every possibly repeated `n`-tuple of
residues `v_i` satisfying

```text
p does not divide v_i                              for every i,
gcd(M, {v_i : i != k}) = 1                        for every k,
```

and asserts the existence of `0 <= r < M` with
`rho_M(r v_i) >= p` for every owner. Badness is strict; equality is safe.
Repeated residues, coincident bad sets, nonunits, primes dividing `N`, and all
deletion premises remain within the quantified domain.

Thus a `BadPrime(n,p)` failure is precisely an admissible tuple for which
`union_i B_i(v)` is the whole residue circle. Its canonical selected cover
first minimizes owner-subset cardinality and then the increasing owner-index
list; owners remain labelled even when original bad sets coincide.

The obstruction target has quantifiers

```text
for every n >= 3,
  there exist H_n and finite Sigma_n, fixed before p and v,
    such that every BadPrime(n,p) failure v realizes some sigma in Sigma_n
    and p divides the fixed nonzero integer Delta_sigma.
```

Neither `H_n`, `Sigma_n`, nor `Delta_sigma` may be chosen after observing the
bad prime or failure tuple.

## Independently derived local claims

The following claims are `proved-math` at the stated scope only; none is a
Lean theorem in this audit.

### Symmetry and minimal covers

- `rho_M(-x) = rho_M(x)`, so independent owner signs preserve every bad set
  and every gcd premise.
- If `u` is a unit modulo `M`, then
  `B_i(uv) = u^{-1} B_i(v)`. Multiplication by `u` bijects the residue circle,
  so every fixed owner subset covers before scaling iff it covers afterward.
  Thus the cardinality minimum and lexicographic owner list are unchanged.
- A cardinality-minimal selected cover is inclusion-minimal. Removing a
  selected owner must expose a residue covered by no other selected owner;
  hence every selected owner has a private residue.
- Two selected owners cannot have coincident bad sets: either would be
  removable. Coincident sets remain permitted among the original owners.

### Small primes and the forced anchor

If `p <= N`, then `r = N` is a universal witness. Because `p` does not divide
`v_i`, write `b_i = v_i mod p` with `1 <= b_i < p`. Then

```text
rho_(Np)(N v_i) = N min(b_i, p-b_i) >= N >= p.
```

This includes primes dividing `N` and uses neither units nor deletion gcds.
Consequently every bad prime satisfies `p > N`.

At `r = p`, write `a_i = v_i mod N`. Directly,

```text
rho_(Np)(p v_i) = p min(a_i, N-a_i).
```

Therefore `p` is strictly bad for owner `i` iff `N | v_i`. A complete cover,
and hence its canonical selected subcover, contains an `N`-divisible owner.

For such an owner `v_j = Nw`, admissibility gives `p` not dividing `w`.
Since a bad prime has `p > N`, `gcd(N,p)=1`. CRT supplies the unique unit

```text
u = 1 mod N,
u = w^(-1) mod p,
```

and then `u v_j = N mod Np`. Any further common unit preserving this anchor
must be `1 mod p`, so it cannot change the other projective `p`-components.

### CRT bad-set fibers

For a normalized owner with `alpha = x mod p != 0` and `beta = x mod N`,
write a residue as `(a mod N, b mod p)` and put
`y = alpha b mod p` in `{0,...,p-1}`. The product lies in the open bad arc
exactly when

```text
beta a = y mod N,
```

or, if `y > 0`,

```text
beta a = y-p mod N.
```

If `d = gcd(beta,N)`, either congruence has no solution or exactly `d`
solutions. No nonunit was cancelled. For the anchor `x=N`, `beta=0`, so each
admissible `b`-fiber is either covered in all `N` values of `a` or not covered
at all. The permutation `b -> alpha b` is still an arbitrary permutation of
`F_p`; this normal form supplies no prime-independent bound on `alpha`.

### Private-point minors

Let selected private residues be `r_s`, normalized selected owners be `x_t`,
and take the unique centered lift

```text
r_s x_t = M q_st + h_st,
-M/2 < h_st <= M/2.
```

Then `rho_M(r_s x_t)=|h_st|`. Privacy gives

```text
|h_ss| < p,
|h_st| >= p for s != t.
```

Modulo both `p` and `N`, the matrix `H=(h_st)` is the outer product of the
private-residue column with the owner-value row. Hence every `2 x 2` minor is
divisible by both `p` and `N`, and therefore by `Np` because `p>N`.

For distinct selected owners `s,t`, define

```text
D_st = h_ss h_tt - h_st h_ts.
```

The first product has absolute value strictly below `p^2`, while the second
has absolute value at least `p^2`; thus `D_st != 0`. A one-owner cover cannot
occur here: if `d=gcd(x,M)`, then `d|N`, and the image of multiplication by
`x` contains a residue at cyclic distance
`d floor(M/(2d)) >= p` for `N>=4` and `p>N`. Thus every minimal failure cover
has at least two owners. It follows that

```text
Theta_st = D_st / N
```

is a nonzero integer and `p | Theta_st` for every failure.

This is a valid unrestricted local theorem. It is not a frozen obstruction:
`r_s`, `h_st`, and `Theta_st` depend on `p` and the failure, with only bounds
of order `Np`. Factoring `Theta_st` after observing `p` would reverse the
required quantifiers.

## Fresh exact fixture arithmetic

The following calculations were reconstructed directly from the definitions
with fresh integer arithmetic. No recovered verifier or output was read as an
executable input.

### `(n,p,v)=(3,5,(1,3,4))`

Here `N=4`, `M=20`. The deletion gcds are `(1,1,1)`. The three bad-set sizes
are `(9,9,12)`. The only covering owner subset is the full set `(0,1,2)`, and
its private sets are

```text
P_0 = {2,3,17,18},
P_1 = {7,8,12,13},
P_2 = {5,9,10,11,15}.
```

The least private residues are `(2,7,5)`. Using the original owner columns,
the centered matrix is

```text
[ 2,  6, 8]
[ 7,  1, 8]
[ 5, -5, 0].
```

Its determinant is

```text
2(40) - 6(-40) + 8(-40) = 0,
```

and its first `2 x 2` minor is `2*1 - 6*7 = -40`; division by `N` gives
`-10`, divisible by `p=5`.

The listed normalization `epsilon=(1,-1,1)` gives
`c=(1,1,0)` modulo `4` and `z=(1,2,4)` modulo `5`. The displayed bounded
annihilator evaluates exactly to

```text
-2*1 - 1*2 + 1*4 = 0.
```

### `(n,p,v)=(4,7,(1,3,4,5))`

Here `N=5`, `M=35`. The deletion gcds are `(1,1,1,1)`. Bad-set sizes are
`(13,13,13,15)`. Again the full owner set is the only covering subset. Its
private sets are

```text
P_0 = {3,4,5,30,31,32},
P_1 = {11,12,23,24},
P_2 = {9,16,17,18,19,26},
P_3 = {7,14,15,20,21,28}.
```

The least private residues are `(3,11,9,7)`, giving the original-column
centered matrix

```text
[ 3,   9, 12,  15]
[11,  -2,  9, -15]
[ 9,  -8,  1,  10]
[ 7, -14, -7,   0].
```

One fraction-free elimination step with pivot `3` gives

```text
[-105, -105, -210]
[-105, -105, -105]
[-105, -105, -105],
```

whose final two rows coincide, so the determinant is zero. The first minor is
`3*(-2)-9*11=-105`; division by `N` gives `-21`, divisible by `p=7`.

The listed normalization `epsilon=(1,1,-1,1)` gives
`c=(1,3,1,0)` modulo `5` and `z=(1,3,3,5)` modulo `7`. Its displayed bounded
annihilator is exactly

```text
-1 + 3 + 3 - 5 = 0.
```

### Normalization qualification

The response's two displayed matrices use the original owner columns, while
Section 6 defines `H` using the sign-normalized columns `x_t`. For the first
fixture the second column should be negated after applying its listed sign;
for the second fixture the third column should be negated. This is a
presentation mismatch, not a mathematical rescue: column sign changes leave
both determinants zero, preserve all absolute-value privacy inequalities, and
change the affected minor only by sign. The zero-annihilator calculations use
the normalized `z` values and are correct.

The equality fixture also checks directly:
`rho_25(5*1)=5=p`, so it is safe. The displayed deletion-edge tuples have
deletion gcd lists `(2,1,1)` and `(5,1,1,1)` respectively and therefore are
outside the admissible domain.

The response-authored exhaustive tuple counts, first-failure claims beyond
the two displayed fixtures, repeated/coincident-set counts, source hashes,
and replay claims were not reproduced and remain unverified finite claims.

## What the zero fixtures do and do not establish

Both full private-point determinants are zero, including after the required
column-sign normalization. Therefore the full determinant is not an
always-nonzero obstruction choice.

Both displayed bounded annihilators lift to exact integer relations of value
zero. Therefore those annihilator values cannot be used as the required
nonzero `Delta_sigma`.

These are decisive negative audits of the two proposed constructions. They do
not prove that every possible determinant, resultant, annihilator selection,
or finite signature system must vanish. In particular, they do not refute
`OBSTRUCTION-EXTRACTION-DISTINCT-PRIME-SUPPLY`.

## Conditional distinct-prime extraction

This section is valid only under the exact frozen obstruction hypothesis: a
finite `Sigma_n` fixed before `p,v`, every `Delta_sigma != 0`, and every bad
prime dividing one of those fixed integers.

Let

```text
D = product_{sigma in Sigma_n} |Delta_sigma| > 0,
C = binom(n+1,2),
T = least positive Q with n^n Q >= C^(n(n-1)).
```

Set `R_0=1`, `E_j=D R_j+1`; let `q_j` be the least divisor of `E_j` greater
than one, and set `R_(j+1)=R_j q_j`.

1. `E_j>=2`; its least divisor greater than one is prime, since a proper
   factor of a composite least divisor would be a smaller divisor.
2. `gcd(D,E_j)=1`, because every common divisor divides
   `E_j-D R_j=1`. Thus `q_j` does not divide `D`.
3. If `i<j`, then `q_i|R_j`. Equality `q_i=q_j` would make that prime divide
   both `D R_j` and `D R_j+1`, impossible. Hence the `q_j` are distinct.
4. Since every `q_j>=2`, `R_j>=2^j`; therefore a least `m_n` with
   `R_(m_n)>=T` exists.
5. In the finite graph joining `j<m_n` to prime divisors of `E_j`, the map
   `j -> q_j` is an edge-respecting injection. For every left subset `S`, its
   image has size `|S|` and lies in the neighborhood, proving Hall's
   inequality without counting prime powers.
6. If a matched `q_j` were bad, the frozen obstruction hypothesis would give
   `q_j|Delta_sigma|D`, contradicting step 2. Thus each matched prime satisfies
   `PrimeForcing(n,q_j)`.
7. Induction gives `R_m=product_{j<m} q_j`; at `m_n` these are distinct primes
   and the threshold inequality holds.

The later divisor argument is also conditional. Given a primitive
hypothetical counterexample with every deletion gcd one, if a matched good
prime `q` did not divide the speed product, reduction modulo `Nq` would meet
every `PrimeForcing` premise and produce a `1/N` witness, contradiction.
Therefore every matched prime divides the product, and their distinct product
does too. This uses the accepted deletion-gcd reduction and does not remove
the frozen obstruction hypothesis.

The subsequent MSS product wrapper is `external-unformalized`; it was not
formalized or independently audited here.

## Anti-quantifier and normalization conclusions

- A `p`-dependent nonzero minor is not a fixed obstruction merely because
  `p` divides it.
- A rank-one congruence modulo `p` does not by itself give a rational rank gap
  for a matrix drawn from a finite, prime-independent integer set.
- Zero determinants and exact rational dependencies cannot populate a finite
  divisor graph: zero has every prime divisor in the divisibility sense but
  supplies no finite nonzero obstruction.
- Anchor normalization removes common projective scaling but does not bound
  the remaining `F_p` projective components. No uniform `H_n` follows from the
  private equations presented.
- Choosing signatures, factors, or obstruction integers after seeing `p`
  would exchange `exists finite Sigma_n` with `for every p, exists data` and
  is invalid.

## Evidence table

| Claim | Audited disposition |
| --- | --- |
| Frozen `PrimeForcing` domains and strict boundary | `proved-math` at exact stated scope |
| `p<=N` witness `r=N` | `proved-math` |
| Complete cover forces a selected `N`-divisible owner at `r=p` | `proved-math` |
| Anchor normalization to `N` for bad `p>N` | `proved-math` |
| Private points and distinct selected bad sets | `proved-math` |
| CRT fiber description retaining nonunits | `proved-math` |
| Nonzero `p`-divisible private cross-minor | `proved-math`, explicitly `p,v`-dependent |
| Two displayed failure tuples and local arithmetic | `proved-math` by fresh exact calculation |
| Full determinant as an always-nonzero obstruction | candidate construction `rejected` by both fixtures |
| Displayed annihilator value as nonzero obstruction | candidate construction `rejected` by both fixtures |
| Any fixed finite prime-independent obstruction set | not proved; `open` |
| `OBSTRUCTION-EXTRACTION-DISTINCT-PRIME-SUPPLY` | `open`; route `stopped`, not refuted |
| Distinct-prime divisor graph | `proved-math` conditional on the exact frozen obstruction hypothesis |
| Response-authored exhaustive scans and counts | unverified finite claims |
| MSS literature wrapper | `external-unformalized` |
| Existing real/integer equivalence | accepted project dependency; not replayed here |
| Unrestricted LRC | `open` |

No `proved-lean` promotion is made by this audit.
