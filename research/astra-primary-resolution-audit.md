# Bounded primary-source resolution audit

Date: 2026-09-05. Local source binding: `b246af6f15198b5aee95ad5c5b4d84f4cc6ffd83`.
Owner: Astra xhigh research subagent. This manuscript is a retrieval and semantic
screening artifact, not a mathematical proof or a Lean verification result.

The current project configuration, workflow policy, and state were read before
the screen. `python3 scripts/validate_workflow.py` passed before writing this
artifact. Its structural validation does not certify mathematical validity.
Only this manuscript was written; no state, Git, Lean source, or caches were
changed, and no external computations were run.

## Disposition and search boundary

No inspected candidate supplies an unrestricted proof, disproof, or complete
formal proof of the project's canonical lonely-runner statement. This is a
bounded nonfinding, not evidence that no other artifact exists. The useful
route information is a recent finite-runner computer-assisted result with
public author code and an explicit branch split that matters for any audit.
It does not discharge the unrestricted target.

The four initial web queries were:

1. `site:arxiv.org "lonely runner conjecture" proof 2026`
2. `site:arxiv.org "lonely runner conjecture" "proof" full`
3. `site:github.com "LonelyRunner.Conjecture" Lean`
4. `site:github.com/google-deepmind/formal-conjectures "lonely"`

The first two were repeated only to recover truncated tool output, with no new
search terms. Exactly three candidates were selected below. Follow-up retrieval
was limited to their primary pages, linked author code, and the official
FormalConjectures entry. One repository-scoped file lookup for `lonely` located
that entry. GitHub branch and file reads used the integration; no repository
was cloned. This was not an exhaustive literature review or a survey of every
Lean repository.

## 1. Recent finite result and its implementation boundary

Touch Sungkawichai and Tanupat Trakulthongchai's
[Eleven, twelve, and thirteen lonely runners, arXiv:2604.23906v2](https://arxiv.org/abs/2604.23906v2)
was revised on 2026-09-01. Theorem 1.3 claims LRC for `k ≤ 12` nonzero moving
speeds, hence at most thirteen total runners after including the stationary
runner. The threshold is closed: distance at least `1/(k+1)`. The stated
real-speed formulation quantifies over every chosen runner. It does not assert
the result for arbitrary `k`.

The proof combines a counterexample product bound, prime-by-prime elimination,
and a finite computation. Proposition 2.7 and Section 6 require eventual
improper-tuple sets `J(k,p)` to be empty for the primes in Table 1, together with
the requisite prime-product inequality and the previous smaller-count case.
The computation is a central dependency not independently checked here. The
paper also proves a restricted congruence family, not an arbitrary-count
resolution. See the [versioned paper, Theorem 1.3, Proposition 2.7, and Section 6](https://arxiv.org/html/2604.23906v2).

The paper links the authors' `vzsky/13-lonely-runners` repository. The retrieved
branch heads were:

| Branch | Immutable revision | Stated role |
| --- | --- | --- |
| `main` | [`755b116b2e6090cd4a83187a696f863388b7d746`](https://github.com/vzsky/13-lonely-runners/tree/755b116b2e6090cd4a83187a696f863388b7d746) | Polished code, checked for `k ≤ 10` according to its README. |
| `for-k-12` | [`bd4fb465b874db1fe29b73ee3e7b3811674c00a5`](https://github.com/vzsky/13-lonely-runners/tree/bd4fb465b874db1fe29b73ee3e7b3811674c00a5) | Earlier code used for `k = 11,12`. |

The [pinned main README](https://github.com/vzsky/13-lonely-runners/blob/755b116b2e6090cd4a83187a696f863388b7d746/README.md)
lists source, results, and a log-summary script; it describes that script as a
sanity check conditional on correctly generated logs. The
[pinned older-branch README](https://github.com/vzsky/13-lonely-runners/blob/bd4fb465b874db1fe29b73ee3e7b3811674c00a5/README.md)
explicitly distinguishes its implementation from the paper's idealized
description, including equivalence handling after lifting. Its
[build guide](https://github.com/vzsky/13-lonely-runners/blob/bd4fb465b874db1fe29b73ee3e7b3811674c00a5/run.sh)
invokes C++23 compilation and a native executable. These inspected materials
are not a Lean proof certificate.

If this finite result becomes a project input, independently audit the paper's
reduction, the older branch's exhaustive enumeration and equivalence handling,
and the exact logs supporting every required prime. Match the run provenance
to pinned source before treating replay as evidence. This screening neither
finds a defect nor validates those computations. Even a successful audit would
need a kernel-checked derivation and canonical bridge before promotion into the
project's allowed-axiom theorem chain.

## 2. A title claiming the full conjecture, explicitly withdrawn

Oleksiy Kurganskyy's
[A proof of the lonely runner conjecture, arXiv:1209.3920v5](https://arxiv.org/abs/1209.3920v5)
is marked withdrawn by its author; the official comment attributes withdrawal
to an error. Its latest listed revision is 2017-12-14. The landing page does
not identify the erroneous inference. No error location is inferred here,
and no prior version was adopted as a proof. This candidate supplies no usable
resolution.

## 3. Official FormalConjectures: exact open statement, explicit placeholder

The official repository's `main` resolved to
[`8323e878b83fcd7f4a448256069352a265460d75`](https://github.com/google-deepmind/formal-conjectures/commit/8323e878b83fcd7f4a448256069352a265460d75)
(commit date 2026-09-04). The complete inspected file is
[FormalConjectures/Wikipedia/LonelyRunnerConjecture.lean](https://github.com/google-deepmind/formal-conjectures/blob/8323e878b83fcd7f4a448256069352a265460d75/FormalConjectures/Wikipedia/LonelyRunnerConjecture.lean).

`LonelyRunnerConjecture.lonely_runner_conjecture` quantifies over every natural
total count `n`, an injective real speed assignment `Fin n ↪ ℝ`, and a chosen
runner `r`. Its hypothesis defines loneliness by all other runners having
`UnitAddCircle` distance at least `1/n`; its conclusion gives a real time
`t ≥ 0`. Thus its intended real-speed, chosen-runner, closed-boundary scope is
relevant. However, the declaration is tagged `research open` and its body is
`by sorry`. There is no linked `formal_proof` attribute on this declaration.
This explicit placeholder alone prevents accepting it as a complete proof.

The same file's Tao-2017 variant concerns a weaker asymptotic lower bound for
the infimum of loneliness over distinct nonzero integer tuples. It is tagged
`research solved`, but its body also contains `sorry`; the tag is not a proof
artifact. No Lean build or `#print axioms` was run here, and no actual axiom
report is claimed. The unrestricted declaration would have to be replaced by
a complete proof and checked against the project's permitted axioms
`propext`, `Classical.choice`, and `Quot.sound`, with the exact canonical
implication independently verified.

## Frozen restart point

The three candidates are exhausted for this bounded screen. None removes the
local unrestricted arithmetic bottleneck. The recent finite computation is an
optional, separately scoped audit opportunity; the withdrawn claim and the
explicit formal placeholder are not resolution inputs. No additional search,
code execution, or project completion claim follows from this manuscript.
