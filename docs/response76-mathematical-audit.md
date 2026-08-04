# Prompt76 independent mathematical audit

Task: `OPS-P76-MATH-AUDIT-199`

Base commit: `8c82bd24a73bd44354db2ae4529caf2e03577929`

Audited response: `research/sol-pro/responses/response76.md`

## Recommended PI disposition

**Accept the explicit tuple as a manuscript-level counterexample to
`GLOBAL-CANONICAL-PRIVATE-DEFICIT-HALL`; stop this bridge; do not change the
status of unrestricted LRC.**

The frozen universal inequality is false for

```text
a = (1,4,5,6,7,11),  n = 6,  N = 7.
```

An independent literal implementation of the contract definitions gives

```text
G = (0,0,0,2,2,0)
F(a) = {1,4,5,11}
PrivateDemand(a) = 100
ExternalCapacity(a) = 98.
```

Thus `100 <= 98` is false. This rejects the proposed inequality and every
universal Hall injection or terminal-capacity uncrossing that would imply it.
No repository evidence label is promoted by this document; Sol High retains
promotion authority.

## Independent recomputation

The audit used a fresh ignored Python 3.14.4 script implementing only the
tracked contract definitions. It did not import, invoke, or copy either
recovered Python program. For pivot speed `p`, it enumerated exactly

```text
R_p = {r : 0 <= r < 7p and 7 does not divide r},
B_s^p = {r in R_p : min((rs mod 7p), 7p-(rs mod 7p)) < p}.
```

Equality was treated as safe. For each covered pivot, every owner subset was
enumerated and ordered first by cardinality and then by its increasing speed
list. The resulting least complete covers are

| Pivot | Canonical owner speeds | Private-set sizes | Row demand |
| ---: | --- | --- | ---: |
| 1 | `{7}` | `6` | 6 |
| 4 | `{1,5,6,7,11}` | `6,4,2,6,4` | 22 |
| 5 | `{1,4,6,7,11}` | `4,4,4,6,4` | 22 |
| 11 | `{1,4,5,6,7}` | `12,8,10,10,10` | 50 |

Every selected owner's relative private set was nonempty. The recomputation
also matched every individual private residue set displayed in the response,
not only its cardinality.

The only uncovered pivots are speeds `6` and `7`, with

```text
Q_6 = {13,29},  Q_7 = {15,34},  G_6 = G_7 = 2.
```

Using `w(j,k)=a_k/gcd(a_j,a_k)`, the capacity rows are

| Covered pivot `j` | Through `Q_6` | Through `Q_7` | Row capacity |
| ---: | ---: | ---: | ---: |
| 1 | `2*6` | `2*7` | 26 |
| 4 | `2*3` | `2*7` | 20 |
| 5 | `2*6` | `2*7` | 26 |
| 11 | `2*6` | `2*7` | 26 |

The nonunit term is retained: `w(4,6)=6/gcd(4,6)=3`. Summing gives
`98`, independently reproducing the strict two-slot deficit.

## Exact mathematical scope

This is not a Lonely Runner counterexample. At pivot speed `6`, residue `13`
belongs to `Q_6`. The cyclic distances for speeds `(1,4,5,6,7,11)` modulo
`42` are respectively

```text
(13,10,19,6,7,17),
```

all at least `6`; equality for the pivot runner is safe. Hence the tuple has
an exact pivot certificate. It refutes only a stronger quantitative condition
imposed even on tuples that already have uncovered pivots.

Cardinality alone stops Attack A: the declared source has 100 elements and
the complete destination slot type has 98. For any proposed Hall relation,
the full source subset has at most 98 neighbors. Attack B is likewise stopped
at its terminal-capacity step, because any permitted universal telescoping
argument would derive the false inequality on this tuple.

The response's claim that this is the first failure in its full bounded scan
was not audited. Neither recovered program was executed, and no broad finite
evidence or response-authored status label is accepted here.

## Surviving narrower statements

The following elementary unrestricted facts survive independently of the
false inequality:

- at a covered pivot, the complete-cover family is finite and nonempty;
- injective speeds make the declared cover key a strict total order, hence the
  canonical cover is unique;
- minimum cover cardinality implies inclusion-minimality;
- every selected owner then has a nonempty relative private set; and
- the two displayed formulas for external capacity agree by finite reindexing.

These facts define the source and destination counts but provide no comparison
between them. A direct per-pivot private-demand repair also fails here: at
pivot `4`, demand `22` exceeds row capacity `20`. The separate Response69
bound with source `2a_j` happens to hold on all four covered rows, but this
single tuple neither proves nor refutes that open universal conjecture. The
response supplies no other unrestricted lemma that narrows the LRC bottleneck.

## Remaining gaps and evidence boundary

| Claim | Audit disposition |
| --- | --- |
| Explicit `100>98` calculation | Independently verified; recommend `proved-math` at this tuple only |
| `GLOBAL-CANONICAL-PRIVATE-DEFICIT-HALL` | Recommend `rejected` by the explicit tuple |
| Universal Hall transport and terminal-capacity uncrossing | Recommend `rejected`; target cardinality is false |
| First failure in the declared bounded ordering | Unverified recovered computation |
| Other mandatory fixtures and symbolic families | Not audited in this task |
| New Lean theorem | None |
| Exact pivot selector and unrestricted LRC | `open`; no status change |

The conditional implication from the universal inequality to a pivot
certificate remains logically correct, but its premise is false and therefore
does not advance LRC.

## Verification record

The independent command was:

```text
python3 tmp/p76_math_audit_199.py
```

The ignored verifier SHA-256 during review was
`1140f2f530b99cc034a4aada14238745e5cbe9be4dea1f2422e985155acd7745`.
Its assertions fixed the complete `G`, `F`, `Q_6`, `Q_7`, canonical-cover,
individual-private-set, row-demand, weight, row-capacity, strict-boundary, and
pivot-safety data above. The script is operational review material, not a
tracked certificate or promoted finite-evidence artifact.
