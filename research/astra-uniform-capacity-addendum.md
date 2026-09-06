# Short affine rescue remains false after orbit-capacity screening

Root-authored mathematical addendum, 2026-09-06, following the canonical N6
checkpoint on main `76d51525dddaac5613e1bb613b7bb9dc7605dabe`.
This is a manuscript result about a proposed uniform mechanism, not a Lean
proof or a resolution of LRC. Independent review is recorded separately.

The strengthened divisor screen gives a necessary condition for a primitive
least-count counterexample, whenever a nonempty proper subset is divisible by
an integer ell >= 2. For each remaining speed v_i put

```
r_i = ell / gcd(ell,v_i),
O_ell(v) = sum_(ell does not divide v_i) ceil(2*r_i/N)/r_i.
```

The condition is `O_ell(v) >= 1`. The N9 short-affine control in the phase
report fails this stronger screen at ell=3: it has only two exceptions, each
of orbit size three, and O_3=2/3. Its stated basic-profile counterexample
remains valid, but it cannot represent all presently known consequences of
minimal failure.

The following strengthens the screening result: the factorial short-affine
family from that report satisfies **every** O_ell condition for **every N>=28**.
Thus adding these capacity inequalities does not prove the proposed local
short-affine rescue rule either. No global-maximum assumption is included in
that rule; this distinction is essential.

## The family and the additional capacity proof

Let `P={p prime : p<N}`, `k=|P|`, `L=N!`, and `h=N-k-4`. Use the N-1 speeds

```
pivot N;
N*L/p for each p in P;
(N-1)*L;
L+j for j=1,...,h;
L+N-1.
```

At `t=1/(N*L)`, the prime coordinates have phases 1/p, and the designated
upper coordinate has phase 1-1/N. These coordinates are all divisible by N.
Every integer dilation 2<=alpha<N has a prime divisor p<N, so that coordinate
becomes an integer, independently of an additional shift beta/N. At alpha=1,
every beta/N preserves the actual upper endpoint, preventing the simultaneous
half-open forward bands `[1/N,1-1/N)`.

The phase report proves positivity, distinctness, the label count, primitive
and deletion gcd conditions, small-denominator cover, the common-time phase
relations, strict local maximality of the bad pivot on the closed complement,
and a separate strict complement seed just to its left. Its optional strict
complement seed is not the displayed boundary time itself. This addendum
uses exactly that family and adds the all-ell capacity assertion.

For N>=28 the odd numbers 1,9,15,21,25,27 are six distinct nonprimes below N.
There are floor(N/2) odd positive integers below N, and 2 is the sole even
prime. Hence

```
k <= floor(N/2)-5,
h = N-k-4 >= ceil(N/2)+1,
h < N.
```

Fix any integer ell>=2. A nondivisible speed with g=gcd(ell,v_i) contributes

```
g*ceil(2*ell/(N*g))/ell >= g/ell >= 1/ell,
```

and also contributes at least 2/N. Split into three exhaustive cases.

1. **ell<=N/2.** All indices 1,...,ell-1 and ell+1 occur among the consecutive
   fillers, since h>=ceil(N/2)+1. As ell divides L, these are ell different
   nondivisible coordinates. Each contributes at least 1/ell, so O_ell>=1.

2. **N/2<ell<=N.** Again ell divides L. Since h<N<2*ell, the indices 1,...,h
   contain at most one multiple of ell. At least h-1>=ceil(N/2) fillers are
   nondivisible. For each such filler, if g=1, then ceil(2*ell/N)=2; if g>=2,
   the positive ceiling is at least one. In either case its contribution is
   at least 2/ell. Thus O_ell>=2*ceil(N/2)/ell>=N/ell>=1.

3. **ell>N.** The pivot N is not divisible by ell. The entire filler block
   has diameter N-2<ell, so at most one filler is divisible by ell. There are
   only k prime coordinates and one upper coordinate. Consequently the total
   divisible count is at most k+2, and the number of exceptions is at least
   N-k-3 >= ceil(N/2)+2. Each contributes at least 2/N, so O_ell>1.

This proves the capacity assertion for every ell, including those with no
nonempty divisible subset; only the appropriate subset cases are needed by
the necessary-condition theorem. No enumeration of the factorial-sized
speeds or of their divisors is involved.

## The sharper height cutoff also holds

The maximum speed is `(N-1)*N!`. For every N>=5,

```
(N-1)*N! <= choose(N,2)^(N-2).
```

The base is 480<=1000 at N=5. From N to N+1 the left side is multiplied
by `N*(N+1)/(N-1)`, at most `choose(N+1,2)` since N-1>=2. The right side
is multiplied by at least `choose(N+1,2)`, because its binomial base
increases. Induction proves the bound. Thus the short-affine obstruction
also lies inside the inclusive MSS cutoff; height does not remove this
family from the relaxed rule's domain.

## Scope and next implication

For all N>=28, therefore, the local short-affine rescue rule fails despite
common-time realizability, all basic divisor constraints, and every elementary
orbit-capacity condition above. No globally bad complement maximum has been established for the general
family. These are counterexamples to a proposed sufficient lemma,
not to LRC. The phase report's N9 example explicitly has both an ordinary
full witness and an improving dilation alpha=11, outside its rejected short
range. No statement about all affine transformations is refuted here.

The capacity inequalities remain valid useful necessary conditions. A next
mechanism must use information they discard: the actual arrangement and overlap
of bad orbit residues, a global comparison of complement-safe times, or another
justified source of a common witness. Merely strengthening the arithmetic
profile by these union bounds cannot supply the rejected phase lemma.
