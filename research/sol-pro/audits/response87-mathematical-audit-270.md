# Response87 independent mathematical audit

Audit task: `P87-MATHEMATICAL-AUDIT-270`

Base: `df86424e7e0d7c7f1daeda95c872deeb47de3c07`

Audited prompt: `research/sol-pro/prompts/prompt87.md`, SHA-256
`0a9456c26579ee3e092b8d5e73dae16334226f4ed482d43759a049df8617bbff`.

Audited response: `research/sol-pro/responses/response87.md`, SHA-256
`228e51affc27c39981cdf3f5f086a17d2ddcef2d1c1a528c74a9ca281a566d5c`.

Recovery package: `research/sol-pro/artifacts/prompt87/README.md`, SHA-256
`a8659211652f69254c2f48b272665cb96cd2eed1337b82c585d7949af1138997`.
The tracked response independently measures 34,477 UTF-8 bytes, 34,463
characters, 1,034 LF separators, no CR, and a terminal LF, exactly matching
the recovery record.

Accepted comparison audit: `docs/response84-mathematical-audit.md`, SHA-256
`c9821bc9534a95ef0917b9a2f891b93658f78f29acf0befae1598dcd110cff7e`.

## Provisional disposition: `PROMISING`

`PROMISING` has a deliberately narrow meaning here. Response87 correctly
rederives the all-`q` counterfamily, correctly separates coordinatewise
divisibility from aggregate product divisibility, and states a genuinely
weaker, noncircular residue lemma whose truth would give a conditional C2
induction step. The aggregate lemma itself is unproved. This audit promotes
neither that lemma nor C2, any pivot certificate theorem, or unrestricted
Lonely Runner.

The response's self-label `PIVOT` remains an unpromoted response claim. All
prior evidence labels remain unchanged. In particular, the MSS product edge
remains `literature` / `external-unformalized`, and unrestricted LRC remains
`open`.

## Claim table

| Response87 claim | Independent disposition | Exact boundary |
| --- | --- | --- |
| The family works for every integer `q>=8` with `4|q` | `proved-math-qualified` | Independently rederived below; agrees with the accepted Prompt84 audit |
| Every deletion gcd is one | `proved-math-qualified` | Common deletion gcd, not pairwise coprimality |
| No coordinate is divisible by `q` | `proved-math-qualified` | Exact remainders checked below |
| The labelled strict bad sets cover all residues | `proved-math-qualified` | Both cyclic sides and all equality endpoints checked |
| `PowerForcing(4,q)` and Prompt84's exact dyadic target fail | `proved-math-qualified` | The target contains `n=4`, `q_4=2^32`; no broader LRC negative follows |
| The `q=8` residue compression is exact | `proved-math-qualified` | Transparent finite arithmetic independently replayed; no response-authored scan promoted |
| `r=31` is an ordinary pivot modulo `95` | `proved-math-qualified` | Distances are exactly `(31,29,19,45)` and equality at `19` is safe |
| The product is `10q(5q/2-1)` and is divisible by `q` | `proved-math-qualified` | For dyadic `q=2^E`, its exact 2-adic valuation is `E+1` |
| The family does not refute aggregate product forcing | correct logical consequence | The family satisfies the aggregate conclusion; this does not prove it universally |
| `AGGREGATE-DYADIC-C2-COVER-DIVISIBILITY` is exact, weaker, and noncircular | accepted as an `open` conjectural edge | Quantifiers are sound after expanding the frozen definition of `T_n`; no counterexample premise is used |
| The aggregate lemma alone proves C2/LRC | rejected if read unconditionally | It gives an induction step only with lower-dimensional LRC, primitive/deletion normalization, and the external MSS strict-product theorem |
| The only unresolved repository edge is the aggregate lemma | too strong | It is the sole new arithmetic edge in this proposal, but the MSS theorem and several C2/Lean assembly wrappers remain external or open |
| A hidden zero residue defeats the aggregate route | rejected | A zero residue makes `q` divide the residue product automatically; the contrapositive excludes it |
| Distinct-prime supply and Prompt79 are refuted | rejected | The counterfamily supplies no new bad odd prime or prime-independent obstruction |
| Unrestricted LRC is resolved | rejected | It remains open |

## All-`q` counterfamily audit

Let `q=4h` with `h>=2`. Then `N=5`, `M=20h`, and

```text
v = (1, 4, 10h-1, 10h).
```

The representative inequalities are strict:

```text
0 < 1 < 4 < 10h-1 < 10h < 20h.
```

The last two coordinates have remainders `2h-1` and `2h` modulo
`q=4h`; these lie strictly between zero and `q`. Also `q` divides neither
`1` nor `4` because `q>=8`. Thus the whole-`q` nondivisibility premise holds.

For deletion of coordinate `1`, `2`, or `3`, the surviving coordinate
`v_0=1` makes the common gcd one. After deleting `v_0`, every common divisor
of

```text
20h, 4, 10h-1, 10h
```

divides `4` and the odd integer `10h-1`, so it is one. This verifies all
four separately quantified deletion gcds. The argument neither assumes nor
proves pairwise coprimality.

Fix the canonical representative `0<=x<20h` of a residue `r`. Since the
modulus is even, parity is well-defined. If `x` is even, owner `v_3=10h`
has residue zero and hence strict distance `0<4h`.

Now let `x` be odd and suppose every owner is safe. Owner `v_0` first gives

```text
4h <= x <= 16h.                                  (1)
```

For odd `x`, multiplication by the half modulus gives `10h` modulo `20h`,
so

```text
x(10h-1) = 10h-x mod 20h.
```

On (1), `|10h-x|<=6h<10h=M/2`; therefore its cyclic distance is exactly
`|10h-x|`. Safety for owner `v_2` leaves precisely

```text
x in [4h,6h] union [14h,16h].                    (2)
```

On `[4h,5h]`, the distance of `4x` is `20h-4x`, which is at least `4h`
only at `x=4h`. On `[5h,6h]`, it is `4x-20h`, which is at least `4h`
only at `x=6h`; at the split `x=5h` it is zero. The reflected interval
`[14h,16h]`, split at `15h`, similarly leaves only `x=14h` and `x=16h`.
Equivalently, reflection by `x' = 20h-x` reduces it to the first interval.

The four possible equality endpoints are

```text
4h, 6h, 14h, 16h.
```

All are even and therefore cannot be the current odd representative. Hence
owner `v_1=4` is strictly bad for every odd residue that survived the first
two owners. Equality `rho=q` remains safe throughout; the equality endpoints
are covered only in the even case by owner `v_3`, at distance zero. This is a
complete strict labelled cover and proves

```text
not PowerForcing(4,q)
```

for every `q>=8` divisible by four. The power-of-two statement is only the
corollary `q=2^E`, `E>=3`. In particular, `q=2^32` kills Prompt84's frozen
universal target. The proof says nothing about `q=4`, where coordinate `4`
violates nondivisibility, or about odd prime powers, where the half-modulus
parity mechanism is unavailable.

## Literal `q=8` and ordinary pivot

For `M=40` and `v=(1,4,19,20)`, the four deletion gcds, in deletion order,
are

```text
gcd(40,4,19,20) = 1,
gcd(40,1,19,20) = 1,
gcd(40,1,4,20)  = 1,
gcd(40,1,4,19)  = 1.
```

The response's owner compression partitions the residues exactly:

- all even residues use owner `20` at distance zero;
- `1,3,5,7,33,35,37,39` use owner `1` at distances
  `1,3,5,7,7,5,3,1`;
- `9,11,29,31` use owner `4` at distance `4`; and
- `13,15,17,19,21,23,25,27` use owner `19` at distances
  `7,5,3,1,1,3,5,7`.

The four equality rows are

```text
r=8:  (8,8,8,0),
r=12: (12,8,12,0),
r=28: (12,8,12,0),
r=32: (8,8,8,0).
```

Thus the endpoint distance `8` is safe, while owner `20` still gives strict
badness. The response's last owner-table cell is split by an unescaped
Markdown `|`; this is a presentation defect only, because the surrounding
formula and the exact values are unambiguous.

For the separate ordinary pivot, `p=19`, `Np=95`, and `r=31` satisfy
`0<31<95` and `5` does not divide `31`. Direct reduction gives

```text
rho_95(31*1)  = 31,
rho_95(31*4)  = 29,
rho_95(31*19) = 19,
rho_95(31*20) = 45.
```

All four distances are at least `19`, with safe equality at the pivot. At
time `31/95`, all normalized distances are at least `19/95=1/5`. Therefore
this exact positive tuple is not an LRC counterexample. That modulus-`95`
witness does not create a safe residue on the unrelated modulus-`40` grid.

Unit scaling modulo `M` and coordinate permutation preserve deletion gcds,
whole-`q` nondivisibility, and full coverage: a unit is invertible modulo
both `M` and `q`, and `r -> ru` permutes the residue ring. These symmetries
do not enlarge the theorem beyond the same fixed-modulus orbit.

## Product identity and aggregate distinction

The exact product is

```text
1 * 4 * (5q/2-1) * (5q/2)
  = 10q(5q/2-1).
```

It is therefore divisible by `q`. If `q=2^E`, then `5q/2-1` is odd and

```text
nu_2(product) = 2 + (E-1) + 0 = E+1.
```

Consequently the family refutes the coordinatewise conclusion
`exists i, q|v_i`, but it does not refute `q|product_i v_i`. Satisfaction of
the latter conclusion is not evidence that the aggregate implication holds
for every tuple.

## Exact aggregate lemma audit

Expanding the previously accepted C2 threshold makes the proposal precise.
For each `n>=3`, put

```text
N   = n+1,
C_n = binom(N,2),
T_n = min {T in Nat : n^n*T >= C_n^(n*(n-1))},
E_n = min {E in Nat : E>=3 and 2^E>T_n},
q_n = 2^E_n,
M_n = N*q_n.
```

The sets defining `T_n` and `E_n` are nonempty by the accepted elementary
threshold argument. The proposed open lemma says that for every possibly
repeated `v : Fin n -> {0,...,M_n-1}`, if

```text
for every k<n, gcd(M_n,{v_i:i!=k})=1,
```

and

```text
for every 0<=r<M_n, there exists i<n with rho_M_n(r*v_i)<q_n,
```

then

```text
q_n divides product_(i<n) v_i.
```

This freezes every dimension, residue, deletion, owner, and strict endpoint.
It assumes neither distinct residues, units, pairwise coprimality, nor
`gcd(N,q_n)=1`. Its exact contrapositive, under the deletion premises, is

```text
q_n does not divide product_i v_i
  -> exists r, for every i, q_n <= rho_M_n(r*v_i).
```

The negation of the finite full cover is exactly this common safe residue, so
no owner quantifier is lost.

The lemma is genuinely weaker than `PowerForcing(n,q_n)`. Product
nondivisibility implies coordinatewise nondivisibility, but the converse
fails for composite `q_n`. The `n=4` counterfamily witnesses the strict gap:
it has a full cover and no coordinate divisible by `q_n`, while its product
is divisible by `q_n`. The lemma is also noncircular: its premises concern
only a residue tuple and a labelled cover, never an LRC counterexample or the
absence of an ordinary pivot.

There is no hidden zero-product problem. If some `v_i=0`, the asserted
product divisibility is automatic. In the contrapositive, product
nondivisibility forces every coordinate to avoid zero modulo `q_n`. Likewise,
if the lemma yields product divisibility and `a_i` reduces to `v_i` modulo
`M_n`, then `a_i=v_i mod q_n` for each `i`, so polynomial congruence gives
`product_i a_i = product_i v_i mod q_n`.

The response's definition uses `2^E>T_n`, whereas the earlier Prompt84
coordinatewise route used `T_n<=2^E`. The strict choice can select a larger
power only when `T_n` itself is a power of two. It is not optimal, but it is
well-defined and makes the proposed implication valid. It must not be
silently identified with Prompt84's earlier minimal exponent.

## Conditional C2 and LRC arrows

The complete conditional chain needs the following explicit induction
context. Fix `n>=3`, assume the positive-integer LRC statement in every
smaller moving dimension, and suppose an injective positive integer
counterexample exists. Apply the accepted primitive/minimal normalization so
that every deletion gcd of the speeds is one.

1. Reduce each speed `a_i` modulo `M_n` to `v_i`.
2. If `d` divides `M_n` and every surviving `v_i`, then it divides every
   corresponding `a_i=v_i+t_iM_n`; the integer deletion gcd is one, so
   `d=1`. Thus every modular deletion gcd is one.
3. Counterexamplehood at each grid time `r/M_n` says exactly that some owner
   has circle distance `<1/N`, equivalently
   `rho_M_n(r*v_i)<q_n`. Hence the full strict labelled cover holds.
4. The aggregate lemma gives `q_n|product_i v_i`, and congruence gives
   `q_n|product_i a_i`.
5. Positivity yields `product_i a_i>=q_n>T_n`.
6. The external MSS strict-product consequence, under the lower-dimensional
   induction hypothesis, gives `product_i a_i<T_n` for such a primitive
   counterexample. Explicitly, if `P=product_i a_i` and `P>=T_n`, then the
   defining inequality for `T_n` gives
   `n^n*P>=C_n^(n*(n-1))`, contradicting the external strict reverse
   inequality. This is the contradiction.
7. The induction step rules out the positive-integer counterexample. With
   the accepted base cases and frozen Lean equivalences, the exact positive
   integer pivot-certificate and real-speed statements follow.

Every modular arrow is valid. The strict MSS inequality and its induction
indexing remain `literature` / `external-unformalized`; local Lean wrappers
for normalization and C2 assembly also remain absent. Response87 mentions
the external edge but its Section 7 chain does not explicitly repeat the
lower-dimensional hypothesis or base-case induction. The chain is therefore
sound only with the qualification above, not as a standalone unconditional
proof.

## Immediate falsification and finite sanity boundary

No symbolic counterexample or zero-product defect emerged from the preceding
quantifier audit. A small exact in-memory probe additionally searched all
product-nondivisible, deletion-gcd tuples at

```text
(n,q) = (3,2), (3,4), (3,8), (3,16),
        (4,2), (4,4), (4,8).
```

It found no full strict cover. The respective premise-tuple counts were
`64`, `1,280`, `13,312`, `118,784`, `608`, `29,184`, and `856,064`.
These scales are not the defined `q_n` instances and the probe is not tracked
as an artifact. It is only a direct search for an immediate small-pattern
counterexample, not evidence for the universal aggregate lemma.

The independent literal replay also recovered all four `q=8` deletion gcds,
the full strict cover, the four equality rows, and the modulus-`95` distance
vector. No response-authored count, scan, or verifier output was promoted.

## Remaining gaps and evidence boundary

The central gap is exact and substantial:

```text
AGGREGATE-DYADIC-C2-COVER-DIVISIBILITY
```

is wholly open for the prescribed `q_n` in every `n>=3`. Response87 gives no
proof of it. Its being weaker and noncircular makes it an admissible research
pivot, not an accepted theorem.

Additional qualifications are:

- the response refers to the “exact MSS threshold” without restating its
  natural-number formula; this audit froze the formula above;
- its implication chain requires the lower-dimensional LRC induction
  hypothesis and accepted base cases explicitly;
- the MSS strict-product theorem and C2 assembly remain external/unformalized;
- the low-scale probe cannot be extrapolated to the enormous target powers;
  and
- the malformed pipe in one Markdown table should not be mistaken for a
  missing arithmetic value.

The all-`q` counterfamily, `q=8` compression, ordinary pivot, and product
identity are accepted here only at `proved-math-qualified` manuscript scope.
Prompt84's exact dyadic forcing target remains rejected. Distinct-prime
supply, Prompt79's prime-independent obstruction, the aggregate lemma, C2
assembly, all other unrestricted routes, and unrestricted LRC remain open.
