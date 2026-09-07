# Pass 96: one strict failure margin and native endpoint cycles

`LonelyRunner/MinimalFailureDeletion.lean` connects the uniform minimal-failure
normal form to every deletion-good set. It proves that the moving count is at
least two and that deleting any speed gives a stronger lower-count witness at
margin `beta=1/n`. With `alpha=1/(n+1)` and the exact maximum retained speed Q,
the whole open interval of radius `(beta-alpha)/Q` around that witness is
deletion-good at alpha. The result uses the original tuple with a checked
deletion reindexing.

The final declaration selects one attained actual global maximum mu, with
`0<mu<alpha`, before quantifying over all deleted indices. For each speed v,
it establishes a strictly positive radius `mu/v-(alpha-mu)/Q` and the bound
`circleNorm(t*v)+v*(alpha-mu)/Q<=mu` on the entire closed deletion-good set.
Every time attaining the global maximum is excluded from every such set.
The private interval argument handles a zero center phase by a short positive
shift and does not assume that the initial witness has positive target norm.

The exact module hash is
`2c9b11be2996fec5ef56278d6df0acda3723669a30f4003be374300d4a10342c`.
The focused compile and three axiom probes passed; every reported axiom is
`propext`, `Classical.choice`, or `Quot.sound`. Root's subprocess receipts
preserve source snapshots, commands, raw diagnostics and kernel cgroup readings.
The successful full module compile peaked at 486,891,520 bytes with zero swap
under the aggregate 4 GiB RAM / 512 MiB swap cap. Root import and all three
mandatory audit probes are included in this checkpoint. Full integration is
performed by the required hosted publication checks.

Terra initially escalated the interval helper, which Astra implemented and
checked. Terra then attempted the complete adapter, exhausted its two repair
rounds, and returned the failed sources. Astra repaired the remaining casts,
reciprocal normalization and directed arithmetic. The delivery records separate
the 46-line helper from 16 changed line spans in the final assembly (15 added,
11 removed lines). This is a substantial Astra repair contribution, not a
first-check Terra success. Worker output provenance was corrected explicitly;
the successful root checks use independently captured raw subprocess output.
The next routine delivery must use a supplied recorder for each attempt.

Two accompanying manuscripts advance the uniform endpoint approach. The full
endpoint graph has positive lifted steps; every simple cycle covers the circle,
contains all original forced arcs, and winds once. Unique original covers receive
the deletion-depth contribution; multiply covered endpoints do not. The
all-zero parent branch supplies distinct compulsory parent transitions.

At native alpha, integer endpoint spacing permits the auxiliary global bound
`mu_hat=max(mu,alpha-1/(N*m))`, where `N=n+1` and m is the largest speed.
Its endpoint graph is exactly the full original alpha endpoint graph. Therefore
the minimum cycle cost equals the minimum alpha-subcover cost, which allows
the earlier completion upper bound to be applied to that cycle class. This
equality is not asserted for the graph at the actual maximum mu.

Minimum-cost cycle exchanges exclude contained selected cores and force
positive center determinants. The exact residue correction gives
`N<=2*f_C-Gamma_C` with `Gamma_C>0`. Combining this with the completion bound
only gives `f_F-1-S_c-B_c>=Gamma_C`; it does not supply a contradiction.
The explicit odd-label control has actual maximum 1/2 and is native-good.
It limits local arithmetic and unconditional outer-cost estimates, and is
not a counterexample to the strict-failure hypotheses.

The manuscripts and independent reviews are recorded in
`research/astra-forced-parent-global-cycle*.md` and
`research/astra-native-endpoint-cycle-arithmetic*.md`. Their new cycle results
are manuscript mathematics, not yet Lean declarations. The final Lean source
review is `research/astra-minimal-failure-deletion-final-review.md`.

The preceding checkpoint was delivered through
[PR #94](https://github.com/Cheeks2184/lonely-runner-formalization/pull/94):
head `eded4ca55ca867517f10d3ed30c2ef0a0eba2062` merged as
`1e4a89034bcab452949734f0d0d689d7de5e27f2` on 2026-09-07 at 11:07:35 UTC.
Both required checks passed, including 3,730 build jobs and 707 allowed theorem
reports. Remote-main verification checked 38 hashes and checkpoint ancestry.

Unrestricted LRC remains unresolved. The next mathematical step must use
compatible cycle closure and failure minimality to obtain an opposing cost
bound or an actual positive injective smaller tuple with full failure
transport. Conditional normal forms and necessary cost restrictions do not
meet the full proof-or-disproof goal.
