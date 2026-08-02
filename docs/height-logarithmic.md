# An elementary logarithmic height gain

## Theorem

Let `N,t>=1`, put

```text
K=Nat.log 2 N=floor(log_2 N),
D_N=4*(K+1)+1,
```

and assume `D_N*t<=N`. Every `(N-1)`-element set of distinct positive integer
speeds contained in `[1,N+t]` has a time at closed circular distance at least
`1/N` from zero.

Consequently, for

```text
u_N=N div (4*(Nat.log 2 N+1)+1),
T_N=max(4,u_N),
```

the separately proved five-hole theorem and the result above imply that every
speed set bounded by `N+T_N` is lonely. A positive-integer counterexample
would therefore satisfy

```text
max A>=N+T_N+1.
```

The gain `u_N` is asymptotic to `N/(4*log_2 N)`. This is a bounded-height
partial theorem, not the unrestricted Lonely Runner Conjecture.

## Missing-height construction

Let `H=N+t`. There are `t+1` holes in `[1,H]`, while only `t` heights exceed
`N`. Choose a missing `c<=N`.

If `2c>H`, then `c` is the only positive multiple of `c` in `[1,H]`; the
reciprocal `1/c` is a witness. Otherwise consider

```text
I=[N+c+t+1,2N],          L=|I|=N-c-t.
```

The size hypothesis gives `N>=5t`. Together with `2c<=N+t`, this implies
`L>=1`. Every `q` in `I` satisfies

```text
q>H,       q-c>H,       q<=2N.
```

If some `q` in `I` is coprime to `c`, take `r*c=1 (mod q)`. No selected speed
can have transformed residue `0,+1,-1`: these would correspond respectively
to `q`, the missing `c`, or `q-c>H`. Thus every cyclic residue is at least two
and

```text
N*rho_q(r*a)>=2N>=q.
```

The equality case `q=2N` is valid at the conjecture's closed boundary.

## Elementary totient bound

Let the distinct prime divisors of `c` be
`p_1<...<p_k`, where `k=omega(c)`. Then `p_i>=i+1`, and the function
`x/(x-1)` decreases for `x>1`. Hence, in the rationals,

```text
c/phi(c)
  = product_i p_i/(p_i-1)
  <= product_i (i+1)/i
  = k+1.
```

Also `2^k<=rad(c)<=c<=N`, so `k<=K`. Clearing the positive denominator gives
the integer inequality

```text
c<=(K+1)*phi(c).
```

If `L>=c`, the interval already contains a complete residue system modulo
`c`. Suppose instead that `L<c` and that `I` contains no unit residue. Its
`L` residues are distinct, so all `phi(c)` units lie in a complement of size

```text
c-L=2c+t-N<=2t.
```

The totient bound now gives `c<=2t*(K+1)`. But the short-interval assumption
gives `N<2c+t`, and therefore

```text
N<2c+t<=(4*(K+1)+1)*t<=N,
```

a contradiction.

It is important not to claim that the size condition alone forces `L>=c`.
For `N=21,t=1,c=11`, the condition is sharp and `L=9<c`. What is impossible
is the conjunction of a short interval and absence of a coprime denominator.

## Exact audit

An independent adversarial reviewer accepted every endpoint and integer-log
step. `scripts/verify_logarithmic_height.py` additionally checks:

- 553,106 nonreciprocal arithmetic-core triples through `N=500`, including
  15,955 short intervals;
- all 361,220 admissible hole configurations through `N=60`, verifying every
  reciprocal or inverse witness with exact integer inequalities.

Reproduce it with:

```bash
bash scripts/audit_logarithmic_height.sh
```

The finite audit is corroborating evidence; the theorem outside its range is
proved by the deductive argument above.

## Formalization status

`LonelyRunner/LogarithmicHeight.lean` kernel-checks the full theorem. Its
declarations prove `2^omega(c)<=c`, `omega(c)<=Nat.log 2 c`, the unconditional
sharp product `c<=(omega(c)+1)*phi(c)`, the complete-period and short-interval
coprime selectors, missing-height extraction, the reciprocal branch, and the
inverse-residue branch with `q<=2N`. The declarations
`logarithmicHeight_family_witness` and
`logarithmicHeight_stationary_witness` expose the exact quantified theorem;
`logarithmicHeightGain_stationary_witness` specializes it to
`N div (4*(Nat.log 2 N+1)+1)`, while
`logarithmicHeightGain_positiveInteger_witness` states the same result with
exactly the `UnitCircle` norm of the positive-integer conjecture. Their axiom
probes use only Lean's standard
`propext`, `Classical.choice`, and `Quot.sound`. This bounded-height result is
therefore `proved-lean`; the unrestricted conjecture remains open.
