# First endpoint blocker and the width dichotomy

Author: root Astra/high, 2026-09-05. Source checkpoint:
`b246af6f15198b5aee95ad5c5b4d84f4cc6ffd83`.
Status: manuscript derivation pending independent Astra/xhigh review.
No Lean declaration or unrestricted resolution is claimed.

## Exact finite reduction for one old set

Let N>=4 and let V be a nonempty finite set of positive integers, with no
cardinality restriction in this section. Write

    S = G_N(V) = {t in [0,1] : ||v*t|| >= 1/N for every v in V}.

Assume S is nonempty. It is a finite union of disjoint closed interval
components contained in (0,1); isolated points are retained as intervals of
width zero. Let E be the set of all component endpoints and W the maximum
component width. Each endpoint is a phase-band boundary of some old speed,
so its denominator divides T=N*lcm(V). Thus the following integer exists:

    b = min {q>=1 : ||q*e|| < 1/N for every e in E}.

In particular T is a blocker and b<=T. It need not be the least period of E
or make the endpoint phases integral. No reference speed p or covered-row
premise occurs in this definition or in the following result.

For a fixed positive integer q whose endpoints are all strictly q-bad,
every component I=[L,R] has both endpoints in open bad arcs

    ((j-1/N)/q, (j+1/N)/q), j integer.

If its endpoints belong to the same arc, its width is strictly below
2/(N*q). If they belong to different arcs, it contains the closed good band
between those arcs and its width is strictly greater than (N-2)/(N*q).
The strictness follows from the strict badness of both attained endpoints.
This includes singleton components in the first case.

Apply this at q=b. Since N>=4, 2/N <= (N-2)/N. Either every component has
width below 2/(N*b), or at least one component has width greater than
(N-2)/(N*b). Hence exactly one of the following holds:

    low:  b*W < 2/N;
    high: b*W > (N-2)/N.

No equality or intervening value is possible. In the low case a component
cannot join different bad arcs, since their intervening good band has width
at least 2/(N*b). All of S is then b-bad and G_N(V union {b}) is empty.

In the high case select a component of width W. For any integer q>=b,

    W > (N-2)/(N*b) >= 2/(N*b) >= 2/(N*q).

A closed interval this wide cannot lie inside one open q-bad arc. If it
were entirely q-bad, connectedness would put it inside one such arc.
Consequently it contains a q-good point. For 1<=q<b, the definition of b
already gives a q-good old endpoint. Therefore the high case supplies a
common closed witness for V union {q} for every positive integer q.

We obtain the exact equivalences

    G_N(V union {b}) is nonempty
      iff G_N(V union {q}) is nonempty for every integer q>=1
      iff b*W > (N-2)/N.

Thus b is a canonical finite test of whether this fixed old set can be
extended by every positive integer speed at the same threshold. The
reduction is nontrivial as a finite criterion, but it has not established
that the high case always holds at the canonical runner count. It is not
an induction step by itself. Empty S is excluded explicitly; W=0 is allowed
and necessarily gives the low case.

## A uniform bound that is equivalent to the unrestricted problem

Consider the following property U, over all N>=4 and all nonempty distinct
positive integer old sets V with |V|=N-2 and G_N(V) nonempty:

    b(E_N(V)) > max(V).

Together with the established cases of at most two positive moving speeds,
U is equivalent to the unrestricted positive-integer lonely runner
conjecture. Applying the existing global BHK equivalence then makes it an
equivalent condition for the project's real-speed canonical conjecture.
This uses the global equivalence, not a count-preserving reduction.

For the forward direction, assume unrestricted positive-integer LRC. For
any such V and any fresh q>0 the set V union {q} has N-1 moving speeds, so
LRC supplies its witness at threshold 1/N. If q is already in V, a witness
for V suffices. The fixed-set equivalence above implies
b*W>(N-2)/N. Put a=max(V). Every component of S lies in a single closed
a-good band, whose width is (N-2)/(N*a). Hence

    W <= (N-2)/(N*a),
    b*W > (N-2)/N,

and therefore b>a. The stronger canonical witness for V also ensures the
nonemptiness premise, although U itself states it explicitly.

For the reverse direction, suppose unrestricted positive-integer LRC
fails. Choose a failure A of least moving count n. The established small
cases give n>=3, and set N=n+1>=4. Delete the smallest speed a=min(A),
and let V=A minus {a}. There are N-2 distinct old speeds. Count minimality
supplies a witness for V at its own stronger threshold 1/(N-1), hence S
and E at threshold 1/N are nonempty. Since A fails, a is strictly bad at
every e in E, so b<=a. But a<max(V), contradicting U. This direction
requires no speed-sum minimum and does not delete the largest speed.

For one fixed V, no assertion that b>max(V) alone implies all extensions
is being made. The equivalence concerns U quantified over all canonical
old sets and counts. Proving U may be a valid route, but calling it an
already established arithmetic estimate would simply conceal the full
unrestricted bottleneck.

The prior minimal-count/minimal-sum manuscript deletes the largest speed
p instead. In that hypothetical minimum its endpoint blocker is b=p and
its full tuple fails, so the dichotomy additionally gives p*W<2/N. This
is consistent with its covered-row width bound and supplies no smaller
blocker. Neither minimality nor periodicity proves the contradiction U.

## Exact fixed controls and a false period shortcut

The separately authored `research/astra-first-blocker-controls.json` is bound
to SHA-256
`2aa24ca0d4c50b21bb5c15ab3d12cc0105306d15f65a5248adc70cc50bd5a67e`.
It contains the full Fraction-only reproducer and minimality checks for
exactly three fixed old sets, not a tuple discovery search.

| N | V | W | T=N*lcm(V) | b | b*W |
| --- | --- | --- | --- | --- | --- |
| 4 | (2,5) | 1/10 | 40 | 8 | 4/5 |
| 7 | (1,4,5,6,7) | 3/196 | 2940 | 2940 | 45 |
| 7 | (7,21,28,35,49) | 3/1372 | 20580 | 903 | 387/196 |

All three are in the high case. These controls do not prove U or a uniform
lower bound. They illustrate that the first blocker can be below the
endpoint period and have nonintegral endpoint phases.

For the first fixture the four old components are exactly

    [1/8,3/20], [1/4,7/20], [13/20,3/4], [17/20,7/8].

Their eight endpoints have least common denominator 40. To spoil endpoint
1/4 strictly at threshold 1/4, q must be divisible by 4. The value q=4
fails at endpoint 1/8, whereas q=8 spoils all eight endpoints. Its phases
at 3/20 and 7/20 have norm 1/5, not zero. Thus the unconditional claim
"the first blocker makes every endpoint phase integral" is false.
A full witness for V union {8} is t=3/10, with norms (2/5,1/2,2/5).
This example has the canonical old count but does not assert an additional
covered reference-row premise. It only refutes that unconditional shortcut.

In the third fixture b=903 has no integral endpoint phases. This prevents
mistaking the endpoint-integrality pattern of the second fixture for a
general rule, even among the fixed old sets inherited from actual covered
largest-row examples. The associated covered reference for the third set
is p=58; no assertion that b is below p is made.

## Consequence for the research route

The first-blocker language has a complete geometric interpretation: it
selects either a genuine failing extension or a single longest old
component that handles all sufficiently large speeds, with endpoints
handling every smaller speed. The missing step is a uniform exclusion of
the low case at canonical counts, or equivalently a proof of a condition
such as U. The finite controls and period T do not provide that exclusion.
No formal proof or disproof of unrestricted LRC follows from this audit.
