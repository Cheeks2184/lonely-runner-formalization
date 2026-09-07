# Independent review: full deletion-set contraction contract

Accepted without corrections. The complete frozen contract and its proposed
proof were read, and the invoked Lean definitions and norm/minimum APIs were
checked in source. The theorem is valid with exactly its displayed hypotheses.
This is acceptance of a mathematical contract for implementation, not a claim
that its new declaration has been elaborated or kernel checked.

Task: `/root/strict_core_kernel_contract_review`. Assigned checkpoint:
`490f7530987390cee87e2e61611af46c29a2851c`. Requested route: existing in-session
`gpt-6-astra`, `xhigh`; observed model, effort, elapsed time and usage: `null`.
Only this review is owned. The author and all other sources remain unchanged.

## Exact scope and interfaces

Let `v : Fin n -> Nat`, let `anchor` and `i` be arbitrary elements of `Fin n`,
and let `alpha, mu, Q` be real. The exact hypotheses are

- `v_i > 0` and `Q > 0`;
- `v_j <= Q` for every `j != i`, after casting speeds to the reals;
- `mu < alpha <= 1/2`;
- `F(s) <= mu` for every real `s`, where `F` is the actual finite minimum of
  all coordinate norms, with the supplied `anchor`;
- at the supplied real `t`, every retained norm is at least `alpha`.

The conclusion is

`circleNorm(t*v_i) + v_i*(alpha-mu)/Q <= mu`.

`ConstrainedMaximizer.lean` defines `ComplementSafe` as exactly the last, closed
deletion predicate: it quantifies over every other label. `minimumCircleNorm`
in `PivotBoundary.lean` uses the nonempty finite infimum, and its minimizing-label
theorem returns an actual label whose norm equals that minimum. The anchor
supplies nonemptiness and may differ from the target. No change-of-anchor lemma
is required.

Natural speeds provide the nonnegativity used in the shift estimate. Retained
positivity, injectivity, primitivity, count/sum minimality, and nonemptiness or
interior of the deletion set are not extra hypotheses. Positivity of `mu` and
attainment as the actual maximum are not required hypotheses. A larger positive
retained-speed bound `Q` is valid and gives a weaker contraction. The conclusion
applies to each supplied safe point, including closed endpoints and singleton
portions. Existence of safe points remains a separate obligation.

## Independent derivation and delicate endpoints

Put `m=v_i>0`, `q=circleNorm(t*m)`, and `delta=(alpha-mu)/Q>0`. Whenever all
retained norms at a real time `u` exceed `mu`, a minimizing label for `F(u)<=mu`
cannot be retained and must be `i`. Its target norm is therefore at most `mu`.
At the original safe time the retained norms are at least `alpha>mu`, so
`0<=q<=mu<alpha<=1/2`. In particular `mu<1/2`. This extraction also works when
the retained set is empty; no unstated retained-label existence is used.

For a real shift `s` with `|s|<delta`, the checked one-sided norm Lipschitz
lemma gives, for each `j!=i`,

`circleNorm((t+s)*v_j) >= circleNorm(t*v_j)-v_j*|s|`

`                         >= alpha-Q*|s| > mu`.

Indeed, `|t*v_j-(t+s)*v_j|=v_j*|s|` since `v_j>=0`, and multiplying the strict
shift inequality by the positive `Q` gives `Q*|s|<alpha-mu`. Thus

`|s|<delta  implies  circleNorm((t+s)*m)<=mu`.                    (1)

The shifted time need not be deletion-safe at width `alpha`: retained norms
are only known to exceed `mu`. This is precisely why the global bound on the
full minimum is required. The existing oriented constrained maximum bounds
one coordinate on deletion-safe times and cannot replace this premise.

Suppose contrary to the conclusion that `mu<q+m*delta`. Define
`c=min(1/2,q+m*delta)` and `r=(mu+c)/2`. Both entries defining `c` exceed `mu`,
so

`q<=mu<r<c<=1/2`, and `r<q+m*delta`.

Hence `r>0` and `r<1/2`, even if the hypothesized escape distance reaches or
passes the antipode. Let `z=round(t*m)` and `e=t*m-z`. The exact source formula
gives `|e|=q`. Choose `sigma=1` when `e>=0`, otherwise `sigma=-1`. Then
`e=sigma*q` and `|sigma|=1`; in particular a zero residual uses direction `+1`,
not zero. Set `h=(r-q)/m` and `s=sigma*h`. Positivity of `m` gives
`h>0` and `|s|=h<delta`. Direct real algebra now yields

`(t+s)*m = z+sigma*r`.

Integer periodicity and the exact norm formula on `[-1/2,1/2]` give
`circleNorm((t+s)*m)=|sigma*r|=r>mu`, contradicting (1). These identities hold
for negative initial times, either residual sign, and shifts crossing an integer
time. The integer lift is the original rounded phase; no continuity of rounding
or assertion about the new rounded integer is required.

Consequently `q+m*delta<=mu`, exactly the displayed theorem after reassociating
multiplication and division. Every shift used in the contradiction is strictly
shorter than `delta`. There is no endpoint limit or hidden connected-component
argument. The final sign is weak, although the positive added term also gives
`q<mu` at every supplied safe time. Dividing by `m>0` gives the claimed
nonnegative radius `mu/m-delta>=0`. Positivity of that radius would need more,
for example an interval in the full deletion set; it does not follow merely
from having one safe point.

One immediate domain consequence, checked separately at root's request, is that
`F(t)=mu` excludes `ComplementSafe v i alpha t` under these same per-index
hypotheses: otherwise the contraction gives `q<mu`, while the minimum comparison
gives `mu=F(t)<=q`. This does not assert deletion-set nonemptiness or equality
of two coordinate norms, and adds no declaration to the frozen contract.

The proposed two private helpers have sufficient hypotheses. The time-shift
lower bound is the existing Lipschitz lemma plus absolute-value algebra. For
the radial-shift helper, `circleNorm(t*a)<r` already implies `r>0`; `a>0`
permits division, and `r<1/2` permits the same residual construction. Neither
helper needs an additional positivity premise, period choice or maximizer.
The stated import supplies the relevant declarations transitively. Actual Lean
assembly and its compile/trust checks remain future work.

## Canonical application and sharpness control

The frozen minimal-counterexample source, already independently reviewed at the
bound hash, supplies a positive injective family under `not Conjecture`, its
least-count and all-admissible least-sum properties, and an actual attained
margin `0<mu<1/(n+1)` with the all-real minimum bound. Since `1<=n`, the native
width is at most `1/2`. The same `mu` and anchor work for every target in this
new contract. Nothing in this application replaces `mu` by a deletion maximum.

Deletion-set nonemptiness is a separate adapter. For `n>=2`, deletion and
`succAbove` reindexing preserve positivity and injectivity; the stored smaller
count theorem at `n-1` supplies retained norms at least `1/n>1/(n+1)`. Finitely
many continuous strict inequalities then give an interval of safe times.
The cited fixed-count module demonstrates this reindexing pattern only; its
fixed-count theorem is not invoked as a uniform result. The existing one-moving
base theorem rules out a positive count-one failure by the antipodal time.
These facts justify the application discussion without adding nonemptiness to
the generic contraction's signature or claiming this adapter is implemented.

The endpoint control is exact. For speeds `(1,2)`, write `x=||t||` in `[0,1/2]`.
Then `||2t||=min(2x,1-2x)`: this follows by doubling either signed nearest-integer
residual and reducing its norm. If `x<=1/3`, the first speed bounds the minimum
by `1/3`; if `x>1/3`, `1-2x<1/3` bounds it. Time `1/3` attains `1/3`, proving
the claimed all-real maximum. At target speed `1`, `Q=2`, `alpha=2/5`, and
`t=3/10`, the retained norm is exactly `2/5`, and

`delta=(2/5-1/3)/2=1/30`,  `q+delta=3/10+1/30=1/3=mu`.

Thus a strict final inequality is actually false under this contract. The
example is LRC-good at its native width `1/3`; its larger working width is
essential to the control's stated scope. It is no canonical strict-failure
counterexample. No falsifier was found for the exact weak theorem.

## Checks, disposition and bindings

The author plus all twelve of its input hashes matched. The accepted contraction
and its earlier review were consulted only for the invoked contraction and scope;
the proof above independently checks the new residual argument. The complete
minimal-counterexample source and its accepted final review remain unchanged.
Current project rules and the focused active task were read; state is authorized
`research/in_progress`. `python3 -B scripts/validate_workflow.py` passed at startup
and handoff. Full review readback, all fifteen bindings below, final newline and
trailing-whitespace checks passed. These administrative checks do not certify
mathematics. No Lean execution, cache/build operation, mathematical program,
additional agent, Git/state/memory write, or edit outside this review occurred.

The exact contract is ready for bounded implementation. Its first remaining
formal step is a checked declaration with these unchanged quantifiers and weak
endpoint. Beyond that unit, deriving a contradiction or the needed uniform
candidate/saving/descent implication remains unresolved. This contraction
supplies none of those conclusions and does not resolve unrestricted LRC.

| Input | SHA-256 |
| --- | --- |
| `research/astra-strict-core-kernel-contract.md` | `2e531b5a040bdd4d48c6a4f2237c27d485b6f08ffb6ac83841da936cb643de8c` |
| `research/astra-strict-core-shell-supply.md` | `5cc9866b3c8a516494ad998355265335a5edd15158cf9701c7d814843b97210e` |
| `research/astra-strict-core-shell-review.md` | `dd733c2910f1f4579846c1c945ecac8e83d140eb29917b81dc11d2b1b119b95f` |
| `LonelyRunner/MinimalCounterexample.lean` | `b0c13b2212abd6bca49fe59f16b0c9d5b124e07e85226e35c14378baa1ffd539` |
| `research/astra-minimal-counterexample-final-review.md` | `ea2ecd4b04cf2f5db060be84087619bdc9b6712ed2c8fd508bbe48fdc1a7ddbf` |
| `LonelyRunner/ConstrainedMaximizer.lean` | `2ef07e6b83b8675a22184571c31d2a71dab9d5c072e3cd165cb8382957b46e92` |
| `LonelyRunner/PivotBoundary.lean` | `0e56cab74d30ef8b537ed4ec24503aae875bd8aadc369d26da99ba882cc3603f` |
| `LonelyRunner/FastRunnerInsertion.lean` | `dda82d1f8830d961499292656c3dfac884a471ad5ef38bd925b1a25c403603a5` |
| `LonelyRunner/FiniteFamilyEquivalence.lean` | `475a46b9e10226f3de30628e595073a9765a8c03cb0ab071bdcc10acb6446be3` |
| `LonelyRunner/OneSixthComplementMaximizer.lean` | `5a7011ca680b8a2b26c7bad466a8ee4008cf47507eb8b700846f296894bb90a1` |
| `LonelyRunner/BaseCases.lean` | `31e2c328e060c077c6c9928e3fb431601326e4e54a949ee5148aed5cd3687d1f` |
| `.codex/config.toml` | `28212a53cf42cdc377df1f7dab040732d657e59d7bb97ee78791256d01d4bb2c` |
| `docs/project-workflow.md` | `2b42a133352b6b53ba2106fc73882733f176e04a0deffbb183b4c16eefd9cd67` |
| `research/workflow-policy.json` | `833c397b61d1ffdb994fb115019f6d60d6c1a62ff85f19cdd2c9f8ac3a979c8b` |
| `scripts/validate_workflow.py` | `250a3ce2a080f5835ac4fd2e4b2803568424c777cda5d421f9fe92efd34d5383` |
