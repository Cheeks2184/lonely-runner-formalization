# Pass 94: forced-parent endpoints and the minimal-counterexample bridge

The forced-parent endpoint argument is independently accepted at manuscript
level. For at least five moving runners, the far endpoint of the larger
parent of a zero-only maximum arc is good for both the maximum runner and
the other parent. Under strict full failure, some original runner outside
that triple must cover the endpoint.

With a>b, a+b=m and P=(l-alpha)/a, the controlling quantities are
`X=(D+b*alpha)/a` and `Y=(D+m*alpha)/a`. The determinant window puts
X in (alpha,4alpha) and Y in (2alpha,5alpha). Since alpha<=1/6, both
actual circle norms exceed alpha, including when a phase exceeds 1/2.

Every covering arc satisfies the two-step determinant identity
`a*G=m*T+v*D` and the weak external-tangency bound `G>=alpha*(m+v)`.
A unique original cover makes P a genuine deletion-good point and yields
the stronger strict-core bound. With multiple original covers, P belongs
to no single-deletion good set, so that continuation is unavailable.

Each forced maximum arc has a distinct larger indexed parent. This gives
`|K_m| <= sum_(m/2<v<m) |K_v|`, with the sum over retained labels. It is
an incidence restriction, not a contradiction. The exact local chain
`(16,7)->(11,5)->(4,2)->(11,6)->(16,9)` shows that outward unique-cover
steps need not decrease speed. The example is LRC-good and refutes only
that local shortcut; it supplies no native counterexample.

The associated formalization now targets a shared prerequisite of the
uniform research: selecting a least-count, least-sum positive integer
failure from `Not Conjecture`, proving its gcd is one, and obtaining an
attained positive global maximum strictly below the closed native margin.
The proposed contract minimizes among all admissible same-count failures,
then derives primitivity by division. The contract was independently accepted, and the implementation now compiles.
All five public theorem probes use only `propext`, `Classical.choice` and
`Quot.sound`. Independent final code review accepted the frozen source without correction.
The root import and mandatory audit probes are integrated; hosted full
build, trust audit and exact certificate checks remain publication gates.

The preceding parent-center checkpoint is delivered through
[PR #92](https://github.com/Cheeks2184/lonely-runner-formalization/pull/92).
Head `598f969732186d9ee39641d343d5e79ddeb1eb77` merged as
`ae64785d3e3a61281bd5baaff773916d72383a78` at 2026-09-07 09:51:07 UTC.
Both required CI jobs passed. Remote-main verification checked all 27
recorded hashes and both head and parent ancestry.

Local dependency restoration for the proposed formalization uses a
transient cgroup with 4 GiB aggregate RAM and 512 MiB swap limits. Project
dependencies are compiled serially with one Lean thread. The control was
verified from inside a probe process; no machine-wide settings were changed.
The successful new-module compile had a kernel-reported cgroup peak of
487,964,672 bytes and zero swap. Short-lived systemd exit summaries were
found to underreport peak memory, so exact figures use `memory.peak` read
inside the service. Build caches are retained only for this active batch.

The unrestricted proof or disproof remains unresolved. The endpoint
argument supplies no global propagation potential or common fresh replacement.
The minimal-counterexample bridge, even once implemented, will supply the
starting hypotheses and not the missing contradiction.

Terra High performed the initial compile and two repair rounds, then returned
the remaining local proof-engineering errors under the agreed cap. Root made
two repair rounds with 11 added or changed lines relative to that frozen
worker source; the second compiled without diagnostics. The failure history
and successful root receipts are retained separately. Per-model token usage
and worker elapsed time were not exposed and remain unknown.

Reviewed source: `LonelyRunner/MinimalCounterexample.lean`, SHA-256
`b0c13b2212abd6bca49fe59f16b0c9d5b124e07e85226e35c14378baa1ffd539`.
Final review: `research/astra-minimal-counterexample-final-review.md`, SHA-256
`ea2ecd4b04cf2f5db060be84087619bdc9b6712ed2c8fd508bbe48fdc1a7ddbf`.
The endpoint manuscript and its independent review are separately bound by
`research/astra-pass94-verification.json`, alongside the contract, code,
execution evidence, integration and storage documentation.
