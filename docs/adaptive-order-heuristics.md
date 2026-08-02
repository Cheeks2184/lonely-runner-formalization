# Adaptive fiber-credit ordering heuristics

## 1. Scope and exact model

This note audits tractable ordering rules for the additive fiber-credit
recurrence.  For a fixed pivot and an already inserted parent set `P`, write

\[
c(b,P)=|B_b|-L(b,P),
\]

where `L` is the sum, over child fibers, of the largest intersection with one
parent in `P`.  The literal strict-boundary masks and fibers are imported from
`scripts/search_fiber_hall.py`; full-union intersections are never substituted
for `L`.

The four state-local rules tested are:

1. **Minimum increment:** minimize `c(b,P)`.
2. **Maximum credit:** maximize `L(b,P)`.
3. **Normalized credit:** maximize `L(b,P)/|B_b|`, with `0/0` defined as zero.
4. **One-step lookahead:** minimize
   `c(b,P) + min_d c(d,P union {b})`.

Ties are treated adversarially in favor of the heuristic: a backward subset
DP minimizes the final additive total over every order allowed by tied scores.
Thus the failures below cannot be repaired by choosing a different fixed
tie-breaker.

Every claim here is finite computational evidence.  No heuristic is asserted
to work in arbitrary dimension or at arbitrary speeds.

## 2. Exact fixed-pivot failures

Each rule can fail at a pivot where unrestricted additive optimization
succeeds:

| rule | tuple | pivot | `|R|` | optimal order / costs | best rule-admissible order / costs |
|---|---|---:|---:|---|---|
| minimum increment | `(1,5,6,7)` | 6 | 24 | `(1,5,7)` / `(8,10,4)`, total 22 | `(1,7,5)` / `(8,6,10)`, total 24 |
| one-step lookahead | `(1,5,6,7,8)` | 7 | 35 | `(1,6,8,5)` / `(10,13,6,4)`, total 33 | `(1,8,5,6)` / `(10,9,6,10)`, total 35 |
| normalized credit | `(4,6,7,10,17)` | 10 | 50 | `(4,6,7,17)` / `(18,12,8,6)`, total 44 | `(4,7,17,6)` / `(18,10,10,12)`, total 50 |
| maximum credit | `(6,8,11,14,17)` | 14 | 70 | `(6,8,11,17)` / `(24,18,12,10)`, total 64 | `(6,11,17,8)` / `(24,16,14,16)`, total 70 |

The bounded-first search enumerates runner count, tuple maximum,
lexicographic tuple, and pivot index in that order.  In the run through five
runners and maximum speed 20, these examples appeared after respectively
`3,344`, `21,925`, `49,090`, and `50,985` fixed-pivot instances.  “First” means
first in this finite schedule only.  In particular, dimensions two and three
were exhausted only through speed 20, so no global minimality is claimed.

## 3. Cross-pivot evidence

A local ordering failure can be rescued by another pivot.  All four rules
succeeded at some pivot of every primitive increasing tuple in these complete
boxes:

| runners | maximum speed | tuples |
|---:|---:|---:|
| 4 | 20 | 4,619 |
| 5 | 15 | 2,981 |
| 6 | 12 | 923 |
| 7 | 11 | 330 |

This leaves a precise falsifiable survivor for a rule `h`:

\[
\Phi_h(a)=\max_p\bigl(n a_p-U_h(a,p)\bigr)>0,
\]

where `U_h(a,p)` is the best total among the rule-admissible tie choices at
pivot `p`.  The displayed finite boxes satisfy this inequality.  There is no
proof that it holds outside them.

## 4. GCD-rate exponential clocks

A separate biased random ordering assigns nonpivot child `i` an independent
exponential clock of rate

\[
d_i=\gcd(a_i,(n+1)A).
\]

For one child fiber and a tail level `t`, let `Lambda_t` be the sum of rates of
parents whose intersection with that fiber has size at least `t`.  The chance
that one of those parents precedes the child is exactly

\[
\frac{\Lambda_t}{d_i+\Lambda_t}.
\]

Summing this tail probability over every fiber and child gives an exact
rational expected credit and hence an expected additive upper bound.  The
program also derandomizes it by conditional expectation.  After a prefix is
fixed, it evaluates the exact remaining exponential race and chooses a next
child minimizing the conditional bound.  At every step it independently
checks that the current value equals the rate-weighted average of the child
conditional values.

The reported examples reproduce exactly:

| tuple | pivot | expected bound | conditional-expectation order | costs / final bound |
|---|---:|---:|---|---|
| `(2,3,7,9,10,12,15,16,19)` | 3 | `17614883/664020` | `(15,10,16,2,7,9,12,19)` | `(12,5,2,2,0,0,2,2)` / 25 |
| `(1,2,5,7,9,11,12,13)` | 7 | `254/5` | `(12,1,2,5,9,11,13)` | `(14,10,4,8,6,4,4)` / 50 |
| `(1,5,7,8,9,11,13,15)` | 8 | `398/7` | `(15,1,5,7,9,11,13)` | `(14,12,8,8,6,4,4)` / 56 |
| `(1,2,3,5)` | 3 | `10` | `(1,2,5)` | `(4,2,4)` / 10 |
| `(1,2,5,6,8)` | 5 | `23` | `(1,2,6,8)` | `(8,5,4,6)` / 23 |

Those bounded boxes do not establish `GCD-CLOCK-UNIF`.  The exact primitive
nine-speed tuple

```text
(8,15,35,40,48,56,63,75,78)
```

fails the strict expectation at every pivot.  For pivot speeds in tuple order,
the margins `9*A - expected_cost` are

```text
-306535/6748764
-45774477372115417671047/11080678499995494450060
-10092964235504317757/1440523581046830280
-3193009367893/203795336745
-302891714608332136588331/5467133235691463095760
-4794129545369388453438975200557/115115210899045744802513047950
-3327760206087107597795619165287/65752240224785488917083991450
-4670513694295489/330094903238100
-1059497781243660599/16137451462532400
```

All are negative.  This rejects the fixed GCD-rate uniform premise, not the
generic exponential-race identity.  It also does not reject the deterministic
additive route: at pivot `8`, order `(75,48,40,15,78,35,63,56)` has costs
`(14,6,28,8,4,8,2,0)` and total `70<72`.  The explicit time `t=13/80` gives
distances `(3/10,7/16,5/16,1/2,1/5,1/10,19/80,3/16,13/40)`, all at least
`1/10`.  The regression suite independently recomputes the fractions, order,
and witness from the strict pivot model.

## 5. Reproduction

Evaluate the four local counterexamples with:

```sh
python3 scripts/search_adaptive_orders.py fixed 1 5 6 7 --pivot-speed 6
python3 scripts/search_adaptive_orders.py fixed 1 5 6 7 8 --pivot-speed 7
python3 scripts/search_adaptive_orders.py fixed 4 6 7 10 17 --pivot-speed 10
python3 scripts/search_adaptive_orders.py fixed 6 8 11 14 17 --pivot-speed 14
```

Re-run the bounded-first search and representative cross-pivot scans with:

```sh
python3 scripts/search_adaptive_orders.py first-failures --max-runners 5 --max-speed 20
python3 scripts/search_adaptive_orders.py cross-pivot --runners 4 --max-speed 20
python3 scripts/search_adaptive_orders.py cross-pivot --runners 7 --max-speed 11
```

Reproduce the GCD-clock fraction and scan with:

```sh
python3 scripts/search_adaptive_orders.py gcd-clock 2 3 7 9 10 12 15 16 19 --pivot-speed 3
python3 scripts/search_adaptive_orders.py gcd-clock 8 15 35 40 48 56 63 75 78 --pivot-speed 8
python3 scripts/search_adaptive_orders.py gcd-clock-box --runners 4 --max-speed 20
python3 -m unittest tests.test_adaptive_orders -v
```

The tests also compare the tie-optimized subset DP with explicit enumeration
of every heuristic-admissible permutation on small exact instances.
