# Anchor-star double-averaging audit

This note independently reconstructs and checks Sol Pro Response 28.  It
concerns a sufficient three-anchor fiber certificate.  It is not a proof of
the Lonely Runner Conjecture, and failure of the certificate would not be a
counterexample to that conjecture or to unrestricted additive ordering.

## Exact functional

Fix a pivot `j`.  Write `I` for the nonpivot indices, `B_i` for their literal
strict bad-residue masks, `m=|I|`, and `S=sum_i |B_i|`.  For a nonempty anchor
set `H` of size at most three, the audited functional is

```
U_j(H) = | union_(h in H) B_h |
         + sum_(i in I \\ H) (|B_i| - L2(i,H)).
```

The prefix term is the exact anchor union (equivalently, inclusion-exclusion
for at most three sets).  To compute `L2(i,H)`, distinguish an anchor `h` and
partition every strict target fiber of `i` by the full residue `a_h r mod M`.
Subfibers whose `h`-image is a strict bad target are credited completely.  On
every other subfiber, credit the largest intersection with one member of
`H\{h}`.  Then maximize over the distinguished anchor `h in H`.  This is the
corrected anchored residual-subfiber construction, not a literal union credit.

Define

```
D_j(h)       = sum_(i != h) |B_h intersect B_i|,
E_j(q | h)   = sum_(i != h,q) |B_q intersect B_i \\ B_h|,
G_j(r | h,q) = U_j({h,q}) - U_j({h,q,r}),
Gbar_j(h,q)  = (1/(m-2)) sum_(r != h,q) G_j(r | h,q),
Xi_j(h)      = D_j(h)
               + (1/(m-1)) sum_(q != h) (E_j(q | h)+Gbar_j(h,q)).
```

These averages require `m>=3`.  Direct set algebra gives

```
U_j({h})   = S - D_j(h),
U_j({h,q}) = S - D_j(h) - E_j(q | h).
```

Adding the third anchor cannot reduce any available two-level credit, and the
cost of moving that anchor from the tail into the exact prefix union cancels.
Therefore every `G_j(r|h,q)` is nonnegative.  Averaging over ordered distinct
`q,r` gives the exact identity

```
average_(q,r) U_j({h,q,r}) = S - Xi_j(h).
```

Consequently `Xi_j(h) > S-n*A` implies that some triple has `U_j(H)<n*A`.
Strictness is essential.  The tests also verify the auxiliary identity

```
sum_(q != h) E_j(q|h) = 2(P-D_j(h)-T_h),
```

where `P` is the sum of all unordered pair intersections and `T_h` is the sum
of all unordered triple intersections containing `h`.

## Exact stress reproduction

Every returned rational and certificate reproduces exactly:

| case | pivot | first anchor | `S-nA` | `Xi` | surplus | triple | `U` / threshold |
|---|---:|---:|---:|---:|---:|---|---:|
| RF `(2,3,7,9,10,12,15,16,19)` | 3 | 15 | 15 | `328/21` | `13/21` | `(15,16,2)` | `25/27` |
| clock failure `(8,15,35,40,48,56,63,75,78)` | 15 | 75 | 102 | `726/7` | `12/7` | `(75,48,35)` | `129/135` |
| simpler clock failure `(6,8,15,21,28,35,40,48,75)` | 28 | 8 | 106 | `2312/21` | `86/21` | `(8,15,48)` | `238/252` |
| `(1,2,3,5)` | 3 | 1 | 0 | `2` | `2` | `(1,2,5)` | `10/12` |
| hard A `(1,2,5,7,9,11,12,13)` | 7 | 12 | 26 | `132/5` | `2/5` | `(12,2,5)` | `52/56` |
| hard B `(1,5,7,8,9,11,13,15)` | 8 | 5 | 28 | `144/5` | `4/5` | `(5,11,15)` | `58/64` |

The exact step vectors are respectively

```
(12,3,2,0,0,4,2,2)
(60,15,8,10,12,10,4,10)
(52,40,38,26,22,12,28,20)
(4,2,4)
(14,10,8,4,6,6,4)
(14,12,8,6,6,6,6).
```

## Zero-target divisor contribution

The number of candidate residues simultaneously mapping to zero for speeds
`a_h,a_i` is

```
Z_(j;h,i) = gcd(N*a_j,a_h,a_i) - gcd(a_j,a_h,a_i)
           = d * (gcd(N,a_h/d,a_i/d)-1),
d = gcd(a_j,a_h,a_i).
```

The first gcd counts all simultaneous zero residues modulo `N*a_j`; the
second counts exactly those divisible by `N`, which are excluded candidates.
Summing cyclically over the three choices of pivot produces the claimed
three-pivot sum identity.  If `N=p` is prime and
`alpha_k=a_k/d`, then this cyclic sum is `d(p-1)` exactly when precisely two
of the three normalized speeds are divisible by `p`, and is zero otherwise.
All three cannot be divisible because their gcd is one.  The test suite checks
the residue count literally and the normalized prime characterization.

## Deterministic search boundary

No all-pivot failure of either `ANCHOR-STAR-UNIF` or `3-ANCHOR-UNIF` was found
in these complete primitive boxes:

| runners | maximum speed | tuples checked |
|---:|---:|---:|
| 4 | 12 | 479 |
| 5 | 15 | 2,981 |
| 6 | 12 | 923 |

These are finite observations only.  They neither establish either uniform
statement nor assert an unbounded minimality result.

Reproduce the exact values and finite scans with:

```sh
python3 scripts/audit_anchor_star.py
python3 scripts/audit_anchor_star.py --scan-runners 4 --max-speed 12
python3 scripts/audit_anchor_star.py --scan-runners 5 --max-speed 15
python3 scripts/audit_anchor_star.py --scan-runners 6 --max-speed 12
python3 -m unittest tests.test_anchor_star -v
```
