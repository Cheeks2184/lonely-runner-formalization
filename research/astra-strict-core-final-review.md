# Strict core contraction: independent final source review

Accepted without corrections for the two public declarations in the frozen
source below. The entire source, including both private helpers, and the complete
implementation receipt were read. The main theorem exactly preserves the
accepted contract; the corollary implements the separately reviewed immediate
domain consequence. Neither theorem resolves unrestricted LRC.

Task: `/root/strict_core_final_review`. Assigned checkpoint:
`7147fd8d9d12bfb3599f931a117f8e27d84f24af`. Requested route: existing in-session
`gpt-6-astra`, `xhigh`. Observed model, effort, task elapsed time and usage:
`null`. Only this review is owned and written by the reviewer.

## Exact declaration and proof comparison

`strict_core_bound_of_global_minimum` takes a natural-speed family on `Fin n`,
arbitrary `anchor i : Fin n`, real `alpha mu Q`, positive target speed and `Q`,
and the retained bounds `(v j : Real)<=Q` for every `j!=i`. Its remaining
hypotheses are exactly `mu<alpha<=1/2`, an all-real upper bound `F(s)<=mu` on
the full finite minimum, and `ComplementSafe v i alpha t` at the supplied real
time. Its conclusion is the accepted weak inequality

`circleNorm(t*v_i) + v_i*(alpha-mu)/Q <= mu`.

The anchor is not identified with the target. The source adds no positivity
assumption on retained speeds or `mu`, no injectivity/minimality/primitive
condition, and no maximum-attainment, deletion-set existence, interior, or
time-normalization premise. Natural retained speeds are nonnegative. The checked
`ComplementSafe` definition quantifies over all retained labels at the closed
width; `minimumCircleNorm` is the actual nonempty finite minimum. Their unchanged
source APIs and the full contract proof were verified in the bound prior review.

The private `circleNorm_time_shift_lower` correctly applies the one-sided
Lipschitz inequality to phases `t*a` and `(t+s)*a`. Its explicit factorization
proves `|t*a-(t+s)*a|=a*|s|` using the nonnegative natural cast. It therefore
allows arbitrary signed shifts and times without replacing a natural speed
bound by an unjustified bound on a signed real speed.

The radial helper sets `x=t*a`, `e=x-round(x)` and uses the exact identity
`circleNorm(t*a)=|e|`. Its hypotheses imply `r>0` and `a>0`. In the branch
`e>=0`, the shift is `(r-e)/a>0`; in particular `e=0` uses the positive direction.
The other branch has `e<0` and uses `(-r-e)/a<0`. In both cases its proved
absolute shift is `(r-circleNorm(t*a))/a`. The two exact new phases are
`round(x)+r` and `round(x)-r`; integer periodicity and `r<1/2` give new norm
exactly `r`. The negative branch explicitly rewrites subtraction as addition
of `-r`. No assumption about the sign of `t`, the next rounded integer, or
remaining in a fundamental time interval is introduced.

In the main proof, put `q=circleNorm(t*v_i)`. A minimizing coordinate at `t`
must be the target: any other coordinate has norm at least `alpha>mu`, contrary
to `hglobal t`. Thus `q<=mu`, and norm nonnegativity implies `mu>=0` without a
new premise. Suppose the desired weak inequality fails. Both `1/2` and
`q+v_i*(alpha-mu)/Q` then exceed `mu`, so the source's

`c=min(1/2,q+v_i*(alpha-mu)/Q)`, `r=(mu+c)/2`

satisfy `q<=mu<r<c<=1/2`. In particular the helper receives `q<r` and `r<1/2`.
Its returned shift satisfies `|s|<(alpha-mu)/Q`: the source explicitly
reassociates division, subtracts `q` from `r<c`, and divides by the positive
target speed. This also handles a proposed escape beyond the antipode.

Every retained coordinate at `t+s` obeys

`norm((t+s)*v_j) >= alpha-v_j*|s| >= alpha-Q*|s| > mu`.

The final strict comparison uses `Q>0` and the strict shift bound. The proof
then invokes the global minimum bound at `t+s` and an actual minimizing label
there. That label must again be the target; its norm is consequently at most
`mu`, contradicting the radial helper's norm `r>mu`. Crucially, the shifted
time is never assumed to remain `ComplementSafe` at width `alpha`. Its retained
norms need only exceed `mu`. This preserves the all-real full-minimum domain
that a constrained coordinate maximum would not supply.

The contradiction proves the exact weak endpoint. No limit, component argument
or strengthening to a strict final inequality is hidden. The accepted sharpness
check still applies: speeds `(1,2)` have actual maximum `1/3`; with target `1`,
`alpha=2/5`, `Q=2`, and safe endpoint `t=3/10`, the left side is
`3/10+(2/5-1/3)/2=1/3`. Thus strictness would be false in this generality.
This is a hand-checked control above its native width, not a canonical failure.

## Exact maximizer-exclusion corollary

`not_complementSafe_of_global_maximum` keeps all per-index hypotheses above,
replaces the safe-time premise by `F(t)=mu`, and concludes precisely
`not ComplementSafe v i alpha t`. Under a hypothetical safe time, contraction
and positivity of `v_i*(alpha-mu)/Q` give `circleNorm(t*v_i)<mu`. The finite
minimum comparison, rewritten using `F(t)=mu`, gives the contradictory
`mu<=circleNorm(t*v_i)`. The rewrite directions and positivity factors are
correct in the actual proof.

This excludes an attained global-maximum time from the specified full deletion
set. It neither asserts that any deletion set is nonempty nor identifies two
coordinates having equal norms. It does not transfer global maximizers into
a deletion domain. Canonical specialization, deletion-seed supply, and any
further selection or descent argument remain separate units.

## Verification receipt and its limits

The frozen implementation receipt binds the accepted contract, its independent
review, the dependency receipt, and the successful final source. All three
receipt inputs match current bytes. Its recorded focused compile uses the pinned
Lake/Lean invocation with `-j1`, the shared-cache lock, and resource caps. The
three recorded attempts have exits `1,1,0`: initial chunk `16a2c2`, repair-one
chunk `f1b288`, and successful repair-two chunk `78b604`. The final attempt's
source digest is exactly the reviewed digest. Its retained combined output has
successful process exit and no Lean diagnostic. The receipt reports two worker
repair rounds and zero Astra repairs; no separate stderr stream or measured
worker-task usage is inferred from its combined output or command timings.

The recorded focused axiom probe imports this module and names exactly the two
public declarations reviewed here. Chunk `715535` exits `0`, and its retained
raw output reports exactly `[propext, Classical.choice, Quot.sound]` for each.
The reviewer checked both report names, both axiom sets, the probe text and the
successful source binding. The dependency receipt separately records successful
compilation of the unchanged `ConstrainedMaximizer.lean` source. These complete
focused receipts are reused; no Lean execution or cache access is repeated.

The receipt preserves failed-attempt source digests and raw diagnostics, but
does not itself include those historical source snapshots. This review does
not reconstruct or certify their full bytes. Its source acceptance concerns
the final compiled artifact. The discarded malformed whitespace check is
explicitly marked unusable in the receipt; an independent current-source
whitespace check passed. A direct source-token scan found no admitted proof,
custom axiom, unsafe declaration, or computational trust shortcut. Root owns
the separate root import and full hosted build/trust integration; the focused
receipts are not presented as those full checks.

The current project configuration, workflow, policy and focused task were read;
research is authorized and the unrestricted goal remains in progress. Workflow
validation passed at startup and handoff. The full review was read back; all
fifteen direct bindings below, all twelve contract bindings, all fifteen prior
review bindings, and source/review whitespace and final-newline checks passed.
The only reviewer write was this file. No Lean run, mathematical program, new
agent, Git operation, shared-state/memory edit, or cache/build change occurred.

No semantic correction or falsifier was found for either exact declaration.
The first unresolved mathematical implication is the additional uniform
selection, saving or descent step needed to contradict canonical strict failure.
The two checked conditional statements do not supply that implication or resolve
unrestricted LRC.

## Frozen bindings

| Input | SHA-256 |
| --- | --- |
| `LonelyRunner/StrictCoreContraction.lean` | `b26dbff907c02e5874dbf635fdd5f9406e7d080045238818090d6b7149c91daf` |
| `research/astra-strict-core-implementation.json` | `83888493901b9f0208bdadeca550ac5600e95970573385cf339eca3ed41a42c1` |
| `research/astra-strictcore-dependency-verification.json` | `11efb1004bd004ccfb02ff2952c28780b01041b1e94035756f41dfba1a2ff99f` |
| `research/astra-strict-core-kernel-contract.md` | `2e531b5a040bdd4d48c6a4f2237c27d485b6f08ffb6ac83841da936cb643de8c` |
| `research/astra-strict-core-kernel-contract-review.md` | `f9b8bf75a66df74e1b8d95fd957d4f8dab145dd0fbc36d825ba23bb2e13ea75e` |
| `LonelyRunner/ConstrainedMaximizer.lean` | `2ef07e6b83b8675a22184571c31d2a71dab9d5c072e3cd165cb8382957b46e92` |
| `LonelyRunner/PivotBoundary.lean` | `0e56cab74d30ef8b537ed4ec24503aae875bd8aadc369d26da99ba882cc3603f` |
| `LonelyRunner/FastRunnerInsertion.lean` | `dda82d1f8830d961499292656c3dfac884a471ad5ef38bd925b1a25c403603a5` |
| `.codex/config.toml` | `28212a53cf42cdc377df1f7dab040732d657e59d7bb97ee78791256d01d4bb2c` |
| `docs/project-workflow.md` | `2b42a133352b6b53ba2106fc73882733f176e04a0deffbb183b4c16eefd9cd67` |
| `research/workflow-policy.json` | `833c397b61d1ffdb994fb115019f6d60d6c1a62ff85f19cdd2c9f8ac3a979c8b` |
| `scripts/validate_workflow.py` | `250a3ce2a080f5835ac4fd2e4b2803568424c777cda5d421f9fe92efd34d5383` |
| `lean-toolchain` | `8e3538e0ab5f81a3ee04927d8838c8c674e0e112838b4b3ce87ec218143276af` |
| `lakefile.toml` | `bdcbaaa18d518409619215e8acf7892452c1fa5c6e80ba742ce67f7380682a26` |
| `lake-manifest.json` | `887450bc75a38effdae452a14b60f6d225bc10b48c71b3827e3479b800f41218` |
