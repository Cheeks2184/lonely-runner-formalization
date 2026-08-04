# Response84 independent mathematical audit

Audit task: `P84-MATHEMATICAL-AUDIT-247`

Base: `f9d0b865bb4d7ebafcacdc91fe6665734ecfd7f0`

Audited prompt: `research/sol-pro/prompts/prompt84.md`, SHA-256
`de9084eba8918366ba7ce8ac5bd5f7ea3580a50256ce0080a1d6382e7d2e33cb`
(16,374 bytes).

Audited response: `research/sol-pro/responses/response84.md`, SHA-256
`8791ce6cd5d78d6a461d5e333e39f819879629b9d3a5b85aeddaab222a23d9d6`
(38,108 bytes).

## Verdict

Response84's **STOP** disposition is mathematically correct. The exact target
`DYADIC-VALUATION-FORCING` is false already in dimension `n=4`. In fact, the
response's symbolic counterfamily admits the following independently proved
strengthening:

```text
For every integer q >= 8 with 4 | q,
PowerForcing(4,q) is false.
```

The proof uses only `4 | q`; it does not use that `q` is a power of two. This
stronger negative is `proved-math-qualified`: it is a self-contained
manuscript proof, not a Lean theorem. Taking `q=q_4=2^32` refutes the frozen
universally quantified target.

The same positive injective tuple has an ordinary canonical pivot certificate
with equality at the pivot coordinate. It is therefore not an LRC
counterexample. The counterfamily rejects only the fixed-grid prime-power
forcing theorem and any implication requiring that theorem. It does not
reject distinct-prime supply, Prompt67's open uniform supply route, Prompt79's
open finite prime-independent obstruction, or unrestricted LRC.

No response-authored checker, scan, count, manifest, or finite output was
executed or accepted in this audit. In particular, the reported `2,304`
failures at `(n,q)=(4,8)`, all premise counts, the claimed two-checker
agreement, first-failure enumeration, fixture table, and bad-set listings
remain **unverified response-authored computation**, not accepted computed
finite evidence. None is needed for the symbolic STOP proof.

## Claim table

| Response claim | Independent disposition | Exact boundary |
| --- | --- | --- |
| `T_4=3,906,250,000`, `E_4=32`, `q_4=2^32` | `proved-math-qualified` | Exact natural arithmetic below |
| Every power of two `q>=8` has the displayed `n=4` failure | `proved-math-qualified` | Strengthens to every `q>=8` with `4|q` |
| All four deletion gcds are one | `proved-math-qualified` | Direct divisor proof, no pairwise-coprime substitution |
| No displayed coordinate is divisible by `q` | `proved-math-qualified` | Exact remainders `1,4,q/2-1,q/2` |
| The four strict bad sets cover every numerator | `proved-math-qualified` | Exhaustive even/odd proof; equality endpoints remain safe |
| Exact target instance at `q_4` | `proved-math-qualified` | Direct substitution into the symbolic family |
| The same tuple has an ordinary pivot certificate | `proved-math-qualified` | Exact candidate range, exclusion, distances, and safe equality |
| General threshold existence/minimality argument | `proved-math-qualified` | Elementary well-ordering and `m<=2^m`; no Lean promotion |
| Attack A fiber and valuation calculations | consistent local algebra | They do not prove a lift; the target counterexample stops this route |
| Noncoprime CRT and deletion-prime characterization | consistent local algebra | No fixed-grid forcing conclusion follows |
| Fixed-grid forcing-to-product-to-MSS chain | `conditional` | Its dyadic forcing antecedent is false; MSS remains external-unformalized |
| Universal dyadic lifting implication | not established or independently refuted as a standalone implication | The route to the frozen target is stopped; do not infer every conceivable lift theorem is false |
| Response-authored scans, counts, and two-checker agreement | unverified | Not executed or accepted here |
| Distinct-prime supply, Prompt67, and Prompt79 open bridges | `open`, unaffected | Prime-power fixed-grid failure is not a distinct-prime obstruction theorem |
| Unrestricted LRC | `open` | The tuple has an explicit ordinary pivot certificate |

## Frozen definition

For `n=4`, put `N=5`. For a positive integer `q`, let `M=5q` and

```text
rho_M(x) = min(x mod M, M-(x mod M)).
```

`PowerForcing(4,q)` quantifies over every possibly repeated tuple
`v : Fin 4 -> {0,...,M-1}` satisfying

```text
gcd(M, {v_i : i != k}) = 1       for every deletion k,
q does not divide v_i             for every i,
```

and asserts that some `0<=r<M` has `rho_M(r*v_i)>=q` for all four owners.
Badness is the strict reverse `rho_M(r*v_i)<q`; equality is safe. There is no
pivot-candidate exclusion in this fixed-grid definition.

## Strong symbolic counterfamily

### Construction and representative range

Let `q>=8` and `4|q`. Write `q=4m`, so `m>=2`, and set

```text
M = 5q = 20m,
h = M/2 = 5q/2 = 10m,
v = (1,4,h-1,h).
```

Then

```text
0 <= 1 < 4 < h-1 < h < M,
```

because `h-1=10m-1>=19`. Thus all four coordinates are canonical
representatives. They are also positive, injective, and primitive, although
`PowerForcing` does not require those extra properties.

### Every deletion gcd

If any coordinate other than the first coordinate `1` is deleted, the
surviving list still contains `1`, so its common gcd with `M` is one.

If `1` is deleted, any common divisor of

```text
M, 4, h-1, h
```

divides both consecutive integers `h-1` and `h`, and hence is one. Therefore
all four deletion-gcd premises hold exactly. No coordinate was cancelled and
the condition was not weakened to total gcd one.

### Exact `q`-nondivisibility

Since `q>=8`, neither `1` nor `4` is divisible by `q`. Also

```text
h     = 2q + q/2,
h - 1 = 2q + (q/2 - 1).
```

The remainders `q/2` and `q/2-1` lie strictly between zero and `q`.
Consequently `q` divides none of the four coordinates.

### Exhaustive strict cover

Fix an arbitrary representative `0<=r<M`.

If `r` is even, write `r=2s`. The half-modulus owner gives

```text
h*r = (M/2)*(2s) = M*s,
```

so `rho_M(h*r)=0<q`. Every even numerator is strictly bad.

Now suppose `r` is odd. If `rho_M(r)<q`, owner `1` is strictly bad. Otherwise,
because `0<=r<5q`, closed safety for owner `1` is exactly

```text
q <= r <= 4q.                                      (1)
```

For odd `r`, `h*r` is congruent to `h` modulo `M`, so

```text
(h-1)*r = h*r-r = h-r mod M.
```

If `rho_M(h-r)<q`, owner `h-1` is strictly bad. Otherwise, on interval (1),

```text
|h-r| <= 3q/2 < M/2,
```

so there is no cyclic wrap in this distance. The closed inequality
`|h-r|>=q`, with `h=5q/2`, gives exactly

```text
r in [q,3q/2] union [7q/2,4q].                     (2)
```

On the first interval in (2), `4r` lies in `[4q,6q]`, hence its distance to
the multiple `5q` is at most `q`. Equality occurs only at

```text
r=q or r=3q/2.
```

On the second interval, `4r` lies in `[14q,16q]`, hence its distance to the
multiple `15q` is at most `q`. Equality occurs only at

```text
r=7q/2 or r=4q.
```

Because `q=4m`, these four equality endpoints are respectively

```text
4m, 6m, 14m, 16m,
```

all even. The current numerator is odd, so it cannot be an equality endpoint.
Therefore `rho_M(4r)<q`, and owner `4` is strictly bad.

This covers every representative: owner `h` covers all evens, while owners
`1`, `h-1`, and `4` cover the exhaustive odd cases. Equality was never made
bad. Indeed, the only potential equality endpoints in the final owner-`4`
step are diverted to the already covered even case. This proves

```text
not PowerForcing(4,q)
```

for every integer `q>=8` divisible by four.

The response's relative-private-residue table uses the stronger dyadic fact
`8|q` to make `q/4+1` odd. That table is valid at its stated dyadic scope but
is not needed for the stronger `4|q` cover proof and is not extended here to
all multiples of four.

## Exact threshold and target arithmetic

For `n=4`,

```text
N = 5,
C_4 = binom(5,2) = 10,
C_4^(4*(4-1)) = 10^12 = 1,000,000,000,000,
4^4 = 256.
```

The exact division is

```text
256 * 3,906,250,000 = 1,000,000,000,000.
```

For the preceding natural number,

```text
256 * 3,906,249,999 = 999,999,999,744 < 10^12.
```

Thus the least threshold is

```text
T_4 = 3,906,250,000.
```

Furthermore,

```text
2^31 = 2,147,483,648 < T_4
     < 4,294,967,296 = 2^32,
```

so

```text
E_4=32,
q_4=2^32=4,294,967,296.
```

This `q_4` is at least eight and divisible by four. Substitution into the
family gives

```text
M = 5q_4 = 21,474,836,480,
v = (1,4,10,737,418,239,10,737,418,240).
```

The symbolic proof already checks its representative range, all four
deletion gcds, all four nondivisibility premises, and the full strict cover.
Hence this one exact target instance refutes
`DYADIC-VALUATION-FORCING`.

The response's general existence arguments for `T_n` and `E_n` are also
correct at manuscript scope: take the positive target power itself as a
member of the `T_n` set, use well-ordering, prove `T_n>0`, and use the direct
induction `m<=2^m` to make the `E_n` set nonempty. Those observations do not
repair the false forcing theorem.

## Ordinary pivot certificate and LRC separation

Continue with `q=4m`, `m>=2`. The same tuple, now regarded as positive speeds,
is

```text
a = (1,4,10m-1,10m).
```

Choose pivot speed

```text
p = 10m-1,
P = 5p = 50m-5,
r = 15m+1.
```

This is a canonical pivot candidate: `0<r<P` because
`P-r=35m-6>0`, and `5` does not divide `r` because `r=15m+1`.

The exact centred distances modulo `P` are

```text
rho_P(r*1)       = 15m+1,
rho_P(r*4)       = 10m+9,
rho_P(r*(10m-1)) = 10m-1,
rho_P(r*(10m))   = 25m-5.
```

For the first row, `2r<P` because `P-2r=20m-7>0`. For the second,
`4r=P+(10m+9)` and `2(10m+9)<P` because `30m-23>0`. For the pivot row,
`r` is `1 mod 5`, so multiplication by `p` has phase exactly `p`. Finally,

```text
r*(10m) - 25m = 15m*(10m-1) = 3m*P,
```

and phase `25m` has centred distance `P-25m=25m-5`.

Every displayed distance is at least `p=10m-1`. The pivot coordinate attains
exact equality, which is safe under the closed loneliness threshold. Thus
`r` is an explicit ordinary pivot certificate and time `r/P` gives circle
distance at least `p/P=1/5` for every speed.

At the exact target `q_4`, `m=1,073,741,824`; the certificate data are

```text
p = 10,737,418,239,
P = 53,687,091,195,
r = 16,106,127,361,
distances =
  (16,106,127,361,
   10,737,418,249,
   10,737,418,239,
   26,843,545,595).
```

This proves directly that the fixed `5q_4`-grid failure is not an LRC
counterexample and does not refute the existing pivot-certificate theorem.

## Attack and implication audit

The response correctly identifies the first direct-lift obstruction. At an
upper scale `2q`, a coordinate of exact 2-adic valuation `v_2(q)` is allowed
by `2q`-nondivisibility but reduces to a `q`-divisible coordinate, outside the
lower forcing premise. Its displayed numerator-fiber formula also retains
the simultaneous binary-lift conflict. These are valid local observations,
but no standalone universal lift theorem is proved or independently refuted
by them. What is decisively stopped is the lift route to the false frozen
target.

The noncoprime CRT decomposition in the response is correctly formulated by
separating the full 2-primary part of `N`. Likewise, the every-deletion gcd
condition is prime-wise equivalent to having at least two coordinates not
divisible by each prime divisor of `M`. Neither fact forces noncoverage; the
explicit family meets the premises and covers the ring.

The proposed downstream implication remains valid only as a conditional
wrapper:

```text
DYADIC-VALUATION-FORCING
  -> one speed divisible by q_n
  -> product of speeds >= q_n >= T_n
  -> weak threshold product inequality
  -> contradiction with the supplied MSS strict reverse inequality.
```

The modular-to-circle equality in this chain must be written as distance to
the nearest integer,

```text
dist(r*a_i/(N*q_n), Z) = rho_(N*q_n)(r*a_i)/(N*q_n),
```

not as the ordinary absolute value of `r*a_i/(N*q_n)`. With that correction,
the endpoint and congruence transfer are sound. The chain still proves
nothing because its first forcing premise is false, and the MSS consequence
remains `literature` / `external-unformalized` rather than `proved-lean`.

## Exact route boundary

The counterexample has these consequences and no stronger ones:

- `DYADIC-VALUATION-FORCING` is `rejected` by its `n=4` target instance.
- `PowerForcing(4,q)` is false for every integer `q>=8` with `4|q`.
- The proposed single-prime-power replacement for the C2 product-supply edge
  is stopped.
- A proof requiring this exact fixed-grid dyadic theorem cannot establish
  the C2 assembly or unrestricted LRC.

It does **not** establish any of the following:

- failure of `PrimeForcing(n,p)` for all or sufficiently many distinct
  primes;
- failure of Prompt67's `UniformPrimeForcingSupply`, interval supply, or
  obstruction-extraction alternatives;
- failure of Prompt79's finite prime-independent obstruction theorem, which
  remains open after its separate quantifier-order audit;
- failure of `PowerForcing(3,q_3)` considered separately;
- failure of the ordinary positive-integer pivot certificate; or
- a counterexample to unrestricted LRC.

In particular, the phrase “the unrestricted dyadic lift route is rejected”
is safe only when it means this route to the frozen universal target is
stopped. It must not be promoted to a theorem that every possible dyadic
lifting implication is false.

## Evidence boundary and recommendation

`proved-math-qualified` in this audit:

- exact `T_4`, `E_4`, and `q_4` arithmetic;
- the stronger symbolic counterfamily for all `q>=8` with `4|q`;
- all representative, deletion-gcd, nondivisibility, parity-cover, and strict
  endpoint checks;
- the exact ordinary pivot certificate and safe equality; and
- rejection of the frozen forcing target at `n=4`.

`conditional`:

- the forcing-to-product-to-MSS implication chain, with the forcing premise
  false and the MSS result external-unformalized.

Unverified response-authored computation:

- every scan domain, premise/failure count, first-failure enumeration,
  checker implementation/agreement claim, finite bad-set listing, fixture
  execution, and altered-count test in Response84.

`open` and unchanged:

- Prompt67's uniform distinct-prime supply and its two proposed attack
  lemmas;
- Prompt79's finite prime-independent obstruction bridge;
- the C2 distinct-prime assembly at its remaining open supply edge;
- all other unrestricted pivot routes; and
- unrestricted Lonely Runner.

No `proved-lean` promotion is made. The recommended Sol High disposition is
**STOP / REJECT THE EXACT DYADIC FIXED-GRID TARGET**, preserve the stronger
`4|q` symbolic negative at qualified manuscript scope, and do not spend a Pro
or Luna slot extending Response84's finite scans.
