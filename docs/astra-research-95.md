# Pass 95: uniform contraction on every deletion-good set

`LonelyRunner/StrictCoreContraction.lean` now proves the reviewed contraction
directly from a global bound on the actual full minimum. Let the distinguished
natural speed be m>0, let Q>0 bound every other speed, and suppose the full
minimum is at most mu at every real time, with mu<alpha<=1/2. At every time
when all other runners have norm at least alpha, the theorem gives

`circleNorm(t*m) + m*(alpha-mu)/Q <= mu`.

The result covers the entire closed deletion-good set, including endpoints
and singleton portions. Its final inequality is weak and sharp. The proof
uses the nearest-integer residual and a short signed shift to contradict the
global minimum bound. A zero residual shifts in the positive direction.
Retained norms after the shift need only exceed mu; the proof never assumes
that the shifted time remains good at alpha.

The second theorem excludes a time attaining that global bound from every
deletion-good set satisfying the per-index hypotheses. The contraction puts
the distinguished norm strictly below mu there, whereas the full-minimum
comparison at an attainer puts it at least mu. This prevents a global maximum
from being silently used as a deletion-good seed.

Both public declarations compiled under the project's aggregate 4 GiB RAM
and 512 MiB swap cap with one Lean thread. Terra used the initial attempt
and two permitted repair rounds; the final compile and focused two-theorem
axiom probe passed. The probes use only `propext`, `Classical.choice`, and
`Quot.sound`. Independent Astra source review accepted both declarations
without corrections. Root checked the current source, input bindings and
receipts without repeating the successful focused compile. Full integration
and mandatory axiom probes are included in the hosted publication checks.

The reviewed source hash is
`b26dbff907c02e5874dbf635fdd5f9406e7d080045238818090d6b7149c91daf`;
the final review is `research/astra-strict-core-final-review.md`, hash
`1fcb97cf90eeacc4d4d5765d1310e255fb146efa4f7e2fd01827a3aac3b62834`.
Actual kernel memory peaks were unavailable for these short runs; service
summaries are labelled as such and are not treated as accurate peak readings.

The preceding minimal-counterexample and endpoint checkpoint was delivered
through [PR #93](https://github.com/Cheeks2184/lonely-runner-formalization/pull/93).
Head `490f7530987390cee87e2e61611af46c29a2851c` merged as
`7147fd8d9d12bfb3599f931a117f8e27d84f24af` at 2026-09-07 10:37:32 UTC.
Both required CI jobs passed, including 705 accepted theorem reports.
Remote-main verification checked all eighty recorded file hashes and both
checkpoint-head and parent ancestry.

The scheduled thirty-delivery assessment is recorded in
`docs/astra-delegation-review-30.md` and its reproducible metric snapshot.
Routing remains Astra for mathematics/review and Terra High for settled
implementation with bounded repair. Per-model token savings remain unknown.

Unrestricted LRC remains unresolved. This theorem supplies a reusable
conditional consequence of hypothetical strict failure; it neither constructs
a failure nor contradicts one. The next assembly connects a single attained
global margin from `MinimalCounterexample` to all deletion sets, using the
stronger lower-count witnesses to prove those sets have interior. Parallel
research examines whether the accepted endpoint relations imply a global
selection or descent mechanism. These unfinished investigations are separate
from this checked contraction checkpoint.
