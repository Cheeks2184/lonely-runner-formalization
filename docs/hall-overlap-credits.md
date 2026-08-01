# Capacitated Hall accounting for pivot bad-set overlaps

This note gives the exact Hall/max-flow interface for ordered modular-pivot
certificates. It repairs the invalid step “add the pairwise intersections” but
does not prove the Lonely Runner Conjecture: the remaining arithmetic problem
is to establish the necessary higher-union cuts uniformly.

## 1. The correct network and cuts

Fix a pivot, a child bad set `B_i`, and selected earlier parent bad sets
`B_j`, `j in P_i`. For each directed parent edge prescribe an integer quota
`w_ij >= 0`. Its eligible residues are

\[
E_{ij}=B_i\cap B_j.
\]

Clone parent `j` into `w_ij` quota units. Join every clone to every residue of
`E_ij`, and give every residue node capacity one. An integral matching that
saturates all clones assigns each promised unit to a distinct child residue,
so no residue is credited twice at the same insertion step.

Finite Hall gives the exact feasibility condition:

\[
\boxed{
  \sum_{j\in Q}w_{ij}
  \le
  \left|\bigcup_{j\in Q}(B_i\cap B_j)\right|
  \quad\text{for every }Q\subseteq P_i .
}
\]

Necessity follows by restricting an allocation to the quota clones over
`Q`. Sufficiency is ordinary Hall applied to all clones. Although Hall is
usually quantified over subsets of clones, it is enough to check parent
subsets: an arbitrary clone subset has size at most the sum of the full quotas
of the parents it represents, and it has the same neighborhood union as those
represented parents.

This equivalence is kernel-checked as
`LonelyRunner.capacitatedHall_iff_existsInjective` in
`LonelyRunner/HallCredits.lean`. The codomain injection returned by the theorem
is the integral unit-capacity flow.

## 2. Sound ordered credit

Let `C_i` be the union of bad sets inserted before child `i`. If every selected
parent lies in `C_i`, the full Hall cut gives

\[
W_i:=\sum_{j\in P_i}w_{ij}
\le \left|B_i\cap\bigcup_{j\in P_i}B_j\right|
\le |B_i\cap C_i|.
\]

Therefore

\[
|C_i\cup B_i|+W_i\le |C_i|+|B_i|.
\]

Summing this inequality along an order gives

\[
\left|\bigcup_i B_i\right|+\sum_i W_i
\le \sum_i |B_i|.
\]

Thus a candidate remains whenever

\[
\sum_i |B_i| < |R|+\sum_i W_i.
\]

The one-step implications are kernel-checked as
`sum_weight_le_card_inter_covered_of_capacitatedHall` and
`card_union_add_sum_weight_le` in `LonelyRunner/HallCredits.lean`. They compose
with the already checked ordered-union induction in
`LonelyRunner/ModularCertificates.lean`.

An important economy is easy to miss: for the scalar ordered-union bound, only
the full-parent cut is used. The smaller cuts are necessary and sufficient
only when the proof insists that specified *edge-by-edge* quotas be realized
as disjoint credits. If one can directly lower-bound the full higher-order
union, Hall machinery adds nothing.

## 3. Exactness and its limitation

For a fixed order, define the actual insertion overlap

\[
O_i=B_i\cap C_i.
\]

Assign every residue of `O_i` to one earlier parent containing it, for example
the earliest such parent. The resulting edge quotas satisfy every Hall cut,
and their total is exactly `|O_i|`. Consequently

\[
\left|\bigcup_iB_i\right|+
\sum_i|O_i|=\sum_i|B_i|.
\]

This identity is kernel-checked for arbitrary ordered finite-set lists as
`card_orderedFinsetUnion_add_orderedOverlapCredit`; the definitions
`orderedFinsetUnion` and `orderedOverlapCredit` make the insertion convention
explicit.

So unrestricted full-history Hall certificates are an exact representation
of the bad union. This is useful as a proof interface, but it is not a new
existence theorem: computing or bounding all the cut capacities can require
the same higher-order overlap information as computing the union itself.

In particular, singleton cuts are merely the pairwise bounds
`w_ij <= |B_i cap B_j|`. They do not control collisions between credits from
different parents. Checking cuts only through some fixed size also has no
formal justification.

## 4. Exact arithmetic counterexamples to truncated cuts

The script `scripts/search_hall_credits.py` constructs the genuine pivot bad
sets using exact integer bitmasks, checks every Hall cut, and independently
computes the maximum integral flow by augmenting paths. It finds the following
lexicographically first examples in the stated search boxes.

### Singleton cuts do not imply the two-parent cut

- speeds `(1,2,3,4)`, `N=5`;
- pivot speed `4`, child speed `1`, parents `2,3`;
- eligible residue sets `({1,19},{1,19})` modulo `20`, hence sizes `(2,2)`,
  with quotas `(1,2)`;
- both singleton cuts pass, but total demand `3` exceeds union capacity `2`;
- maximum flow is `2`.

### Singleton and pair cuts do not imply the triple cut

- speeds `(1,2,3,4,5)`, `N=6`;
- pivot speed `5`, child speed `1`, parents `2,3,4`;
- eligible residue sets `({1,2,28,29},{1,29},{1,29})` modulo `30`, hence
  sizes `(4,2,2)`, with quotas `(3,1,1)`;
- every cut of size at most two passes;
- total demand `5` exceeds triple-union capacity `4`;
- maximum flow is `4`.

The same phenomenon continues immediately:

| cuts checked | tuple | pivot | child | parent speeds | quotas | full demand / capacity |
|---:|---|---:|---:|---|---|---:|
| through 3 | `(1,2,3,4,5,6)` | 5 | 2 | `(1,3,4,6)` | `(3,1,1,2)` | `7/6` |
| through 4 | `(1,2,3,4,5,6,7)` | 7 | 2 | `(1,3,4,5,6)` | `(3,2,1,1,3)` | `10/9` |

These are failures of proposed accounting shortcuts, not Lonely Runner
counterexamples. Each family consists of the arithmetic sets
`B_i cap B_j` from the repository's exact strict-boundary pivot model.

Reproduce them with:

```sh
python3 scripts/search_hall_credits.py --checked-cut-size 1 --max-runners 5 --max-speed 8 --max-weight 3
python3 scripts/search_hall_credits.py --checked-cut-size 2 --max-runners 6 --max-speed 12 --max-weight 3
python3 scripts/search_hall_credits.py --checked-cut-size 3 --max-runners 7 --max-speed 10 --max-weight 4
python3 scripts/search_hall_credits.py --checked-cut-size 4 --max-runners 7 --max-speed 10 --max-weight 5
python3 -m unittest tests.test_hall_credits -v
```

The test suite also exhausts every family of at most three subsets of a
three-element universe and every quota vector with entries in `{0,1,2}`. In
all cases, the complete Hall condition agrees exactly with saturation by the
independent matching implementation.

## 5. Remaining arithmetic obligation

A productive Hall route must prove lower bounds for

\[
\left|B_i\cap\bigcup_{j\in Q}B_j\right|
\]

for every relevant `Q`, strong enough that the accumulated feasible quota
exceeds `sum_i |B_i|-|R|` at some pivot. Exact formulas for the individual
`|B_i|` and pair intersections alone cannot establish those cuts. The small
arithmetic examples above show that even all cuts one size below the full cut
may miss the obstruction.

No uniform number-theoretic estimate of these higher unions is currently
proved. Therefore this lane supplies an exact, independently verified proof
interface and rules out several shortcuts, but does not close the positive-
integer conjecture.
