# Arithmetic winding exchanges and the missing primitive step

Task `/root/arithmetic_winding_exchange`; requested `gpt-6-astra/xhigh`.
Observed model, effort, elapsed time and usage: `null`. Assignment checkpoint:
`9aa78b83ad709d611fc0100fa8cb4f8f33b89223`. Only this manuscript is owned.
Status: bounded hand derivation awaiting independent review; no kernel theorem.

**Outcome.** Minimum-cost subcovers satisfy the exact complete-grid block
exchange inequality (4). Winding and determinants also force every small
reduced rational to be a selected center, but this only recovers divisibility
of an actual speed by its denominator. Unit determinants would upgrade that
divisibility to equality and yield a contradiction. No permitted exchange
producing that upgrade was derived. The proposed unrestricted optimal-cover
uncrossing rule is false in the explicitly checked complete family `(1,5,8)`.
That control is supercritical and does not refute the rule restricted to an
actual hypothetical strict failure. This bounded attempt stops at that gap;
it neither revives (E) nor claims a new uniform LRC mechanism.

## Strict-failure setting and an actual cyclic chain

Assume a positive distinct primitive integer tuple of n moving speeds is a
strict failure, chosen first by least count and then least speed sum. Write

    N=n+1,  alpha=1/N,  mu=max_t min_i ||v_i t||,
    mu<delta<alpha.

The established smaller-count results allow `n>=3`; this weaker bound suffices
for the geometry below. Count minimality supplies each deletion's margin
`1/n`, but no further minimal-height implication is used. The COMPLETE open
arc family is

    A_(v,k)={t mod 1: dist_T(t,k/v)<delta/v},  0<=k<v.

It covers because `delta>mu`. Choose a subcover S minimizing
`cost(S)=sum_(A_(v,k) in S) 1/v`; existence follows from finiteness. Every
selected arc is indispensable, since its cost is positive. In particular
no selected arc is contained in another selected arc. Unselected arcs remain
available for exchanges, including contained ones: pruning the complete
family on geometric containment need not preserve its minimum cost.

Here every three distinct original arc indices have sum of reciprocal speeds
at most `1+1/2+1/2=2`. Thus their total length is at most `4delta<1`. If three
selected arcs shared a point, cut outside their union and regard them as real
intervals. Either one is contained in another, or the interval with middle
left endpoint is contained in the union of the other two. Removing it would
preserve coverage, contradicting minimal cost. Hence no three selected arcs
have a common point. Also any three arcs have total length less than one,
so the cover has at least four arcs.

Order their distinct centers cyclically and choose lifts

    c_j=k_j/a_j,  c_(j+m)=c_j+1,
    ell_j=(k_j-delta)/a_j,  r_j=(k_j+delta)/a_j,

where `a_j` is an ORIGINAL speed, and adding one to a center adds `a_j` to
its numerator. Absence of containment makes both endpoint sequences strictly
increasing with the centers. Coverage and absence of triple intersections give

    ell_(j+1)<r_j,       r_(j-1)<=ell_(j+1).                 (1)

The first inequality is strict because the arcs are open. Equality in the
second is possible: the middle selected arc can have a single private point.
These statements include the transition across the origin using the periodic
lifts; no line endpoint is mistaken for a second circle point.

## An exact block exchange using every original grid

Remove any nonempty proper consecutive block `p,...,q` of selected arcs in
the lifted cyclic order. The remaining arcs leave exactly the closed gap

    G=[r_(p-1),ell_(q+1)],
    g=ell_(q+1)-r_(p-1)>=0,  z=(ell_(q+1)+r_(p-1))/2,
    C=sum_(j=p)^q 1/a_j.                                  (2)

For a block of one arc, g can be zero; for a longer block it is positive.
If only one selected arc remains, the next endpoint is its lift one period
later. In all cases `g<1`, and the remaining arcs cover the complement of G.

Fix ANY original speed u with `1/u<C`. Its full grid contains a replacement
arc covering G exactly when an integer h satisfies

    u ell_(q+1)-delta < h < u r_(p-1)+delta.                (3)

Indeed these inequalities put both closed endpoints of G strictly inside the
open arc `((h-delta)/u,(h+delta)/u)`. They also handle `g=0`. Conversely, an
arc containing this connected gap has a lift satisfying (3). Integers h
parametrize precisely the original grid modulo u, so no new phase or speed
has been introduced. A replacement already outside the removed block cannot
satisfy (3), since the remaining family by definition omits G.

Such a replacement would reduce the total cost. Optimality therefore proves

    ||u z|| >= max(0,delta-u g/2)
       for every original u with 1/u<C.                   (4)

There is no assertion when costs are equal. Equivalently, the open interval
in (3) contains no integer. In terms of the two retained boundary arcs with
speeds a,b and numerators k,l, its conditions are the exact signed determinant
inequalities

    a h-u k < delta(a+u),  u l-b h < delta(u+b).

The interval in (3) has length `2delta-u g<=2delta<1` when nonempty. Thus
positive overlap room never by itself guarantees an available integer h.
Formula (4) is a genuine grid-compatible exchange constraint; it is weaker
than a full delta-witness at z and does not supply the desired larger margin
alpha. No simultaneous integer choice from these intervals was obtained.

## Winding, denominators and the tested sharper implication

For consecutive selected centers `k/a<l/b`, put `D=a l-b k`. Then

    D is a positive integer,
    center gap=D/(ab),  D<delta(a+b),
    sum_over_cycle D/(ab)=1.                              (5)

The last equality uses the lifted endpoint one period later. Suppose a reduced
rational `h/q` is strictly inside this center gap. The positive integers
`U=a h-k q` and `V=l q-b h` satisfy

    D q=b U+a V >= a+b.

Combining with (5) gives `q>1/delta>N`. Consequently every reduced rational
with denominator at most N must be a SELECTED center. The determinant argument
for general D was supplied by root and independently checked here.

This does not force its actual speed label to equal q: that speed can be any
multiple of q. The same old divisibility profile follows directly at `h/q`:
if q does not divide v, then `||v h/q||>=1/q>=1/N>delta`; a covering arc must
therefore come from a divisible speed and be centered exactly at `h/q`.
Neither version gives a new contradiction from n labels.

The sharper exchange implication tested here was: can one choose a minimum-cost
cover whose every consecutive ACTUAL determinant D equals one, by exchanging
arcs only within the complete original family? This would be sufficient. A
common divisor of k and a divides `a l-b k`, so `D=1` forces each center's
pair `(k,a)` to be primitive, including the center at zero. Every selected
representation of `1/q` must then have actual speed exactly q. Applying this
to `q=1,...,N` would require N distinct original speeds, whereas only `n=N-1`
are present. The center at zero is necessarily selected: at zero only
zero-centered original arcs contain the point, and primitive representation
would force its speed to be one.

This conditional Farey argument is complete, but the unit-determinant
exchange premise is not proved. The interval obstruction in (3) is precisely
where an attempted local uncrossing can require an unavailable grid point or
an absent denominator. Minimum height among failures does not authorize adding
that denominator: changing a speed would still require a proof that the full
original failure is transported. No such transport is available here.

## Complete-grid optimality does not generally give unit transitions

Take the distinct positive primitive tuple `v=(1,5,8)` and `delta=17/50`.
Its complete family has fourteen original arcs. The following four are forced
in every subcover, as shown by points at which all other original labels have
norm strictly greater than delta:

| Forced arc | Private point t | `(||t||,||5t||,||8t||)` |
| --- | --- | --- |
| speed 1, center 0 | `3/10` | `(3/10,1/2,2/5)` |
| speed 5, center `2/5` | `21/50` | `(21/50,1/10,9/25)` |
| speed 8, center `4/8` | `1/2` | `(1/2,1/2,0)` |
| speed 5, center `3/5` | `29/50` | `(21/50,1/10,9/25)` |

Within one label the arcs are disjoint, so these tests force the indicated
arc index, not merely the label. They inspect the whole fourteen-arc family.
In cyclic order these centers are `0,2/5,1/2,3/5,1`. Their actual determinants
are `2,4,4,2`, with transition thresholds

    1/3, 4/13, 4/13, 1/3 < 17/50.

Thus the four OPEN arcs form a cover. Since every subcover must contain all
four and every other arc has positive cost, they form the unique minimum-cost
subcover, of cost `1+2/5+1/8=61/40`. No exchange involving any unused original
arc can give a different cover of equal or smaller cost. In particular, this
is a check of global optimality, not merely local irredundancy. The two outer
transitions already have primitive center fractions and determinant two.

At center `4/8=1/2`, the radius is `delta/8`, not `delta/2`. Treating its
reduced center denominator as a new speed 2 would quadruple the radius, change
the cost from `1/8` to `1/2`, and introduce a speed absent from the original
tuple. It is not an allowed uncrossing operation.

This control has actual maximum `mu=1/3`. At `t=1/3` all three norms equal
`1/3`. At width `1/3`, the same four CLOSED arcs cover: the outer transitions
touch and the inner ones overlap strictly. This proves the matching upper
bound. The same time also supplies every deletion's own margin `1/3`.
However `mu=1/3>alpha=1/4`, and its open cover uses `delta>mu`. It does NOT
satisfy the actual strict-failure hypothesis or its least-count/least-height
profile. The example refutes a general optimal-cover uncrossing rule, not
unit-transition supply under those additional hypotheses.

## First unresolved implication and evidence

The proved exchange window (3)--(4) does not force a replacement integer.
The complete winding inequalities recover denominator divisibility but do
not make the selected center owners primitive. A new implication using actual
strict failure would have to bridge that exact gap, or extract a different
contradiction from the complete set of permitted exchanges. No such implication
was derived. Selection optimality, graph connectivity, Euler identities and
the winding-cycle equivalence are not promoted to uniform supply. This task
ends here, without another roadmap or a hypothesis-complete failure example.

The six assigned manuscripts/reviews were read at the following frozen hashes.
The current strategy and prime-progression results were under separate review;
they were used to delimit this task, not promoted by accepting their status.

| Input | SHA-256 |
| --- | --- |
| `research/astra-uniform-strategy-after-energy.md` | `ee253b7ade891196bdf213250badac0ddf5992937eba32b625dbc9adb79f506e` |
| `research/astra-prime-progression-cover-cost.md` | `e5e26e0cffff1031dd1b14cd88f127ac5b624c2c798d22b0d0baa51e89a7ccd7` |
| `research/astra-uniform-colour-critical-cover.md` | `84b7f417a73dd8e580300390a3e1081f61904ad1860215487f03f7c1a51e578f` |
| `research/astra-uniform-colour-critical-review.md` | `49e42ed76159de73c3e2fd568021c82942913f76d976a596544323e1ef1caed9` |
| `research/astra-uniform-endpoint-euler-screen.md` | `00f37303fc266b1843964293500a1be112e3a9d8439d3dcad65a662d60be1b25` |
| `research/astra-uniform-endpoint-euler-review.md` | `b3dd8f9923bd77814cff6c8171ca1a930df5058cbf123cdfe165ec9591102aec` |

Read current config, workflow, policy and focused state. The gate was
`research/in_progress`, with explicit 2026-09-05 start authorization and this
task recorded. `python3 -B scripts/validate_workflow.py` exited zero:
`workflow structural validation passed; it cannot certify mathematical validity.`
Hashes were checked with `sha256sum`. All mathematics above was checked by
hand. No mathematical program, numerical search, build, cache operation,
external model, additional agent, Git mutation, shared-state edit or memory
write was used. All other files were preserved. Independent review is pending.
