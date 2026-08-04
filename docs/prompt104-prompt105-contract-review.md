# Prompt104/105 launch-candidate audit

Task: `374`

Base commit: `c5a493195ba48aedaeaa14ed66de96faa135d238`

Scope: documentation and prompt preparation only. This memo records no Sol Pro
launch, response, theorem, computed finite evidence, or evidence promotion.

## Decision summary

| Candidate | Audited disposition | Exact target | Distance boundary |
| --- | --- | --- | --- |
| Prompt104 | `LAUNCH-CANDIDATE` | proper-subset two-fold expansion of the whole-private-set exchange graph for every minimal internal cover | Unrestricted structural narrowing: Task366 density then forces the only surviving Hall defect to be the full owner set. It does not eliminate that full-core circuit or prove LRC. |
| Prompt105 | `LAUNCH-CANDIDATE` | `4*gcd(a) <= sum_j |Q_j|` for every positive injective tuple with `n>=3` | One quantitative unrestricted edge; it implies an ordinary pivot certificate, with `n<=2` handled by accepted base cases. |

Only GPT-5.6 Sol High in the original browser-capable desktop session may
approve or launch either prompt. Preparation does not imply launch.

## Prompt104 unrestrictedness and tautology audit

The first draft was conditional on singleton private sets and two omitted
exchange neighbors per owner. That draft was rejected before commit: neither
premise is known for every minimal internal cover, so proving its Hall wrapper
would only classify a conditional family.

The replacement removes both premises. For every labelled inclusion-minimal
internal complete cover `C`, it uses the exact private sets

```text
Priv(C,i) = B_i^j \ union_(k in C, k!=i) B_k^j
```

and an omitted covered label `h` is adjacent to `i` only when it covers the
**entire** private set. This is precisely the condition making replacement of
`i` by `h` preserve the cover. The target quantifies over every nonempty proper
`S subset C` and asserts `2|S|<=|Gamma(S)|`.

The full set is excluded deliberately. From Task366 density,
`N+1<3|C|`; from `F(a) subset Fin n`, `|C|+|O|<=N-2`. Hence
`|O|<2|C|`, so full-set two-fold expansion is impossible for every
hypothetical cover. If Prompt104 holds, every counterexample is therefore a
full-core two-fold Hall circuit: all proper subsets expand and only `C` itself
is deficient.

This is not a restatement of Prompt95. It is compatible with a hypothetical
full-core circuit and therefore does not imply no internal cover. Conversely,
using no-internal-cover to prove it would be vacuous circularity, which the
prompt marks `STOP`. Arbitrary minimum-degree or Hall bookkeeping does not
prove the target because whole-private-set exchange neighborhoods can have
proper deficiencies.

Verdict: the replacement is genuinely unrestricted and materially narrows the
open edge, while preserving the exact remaining obstruction. It is suitable
for PI launch consideration.

## Prompt105 stopped draft and replacement audit

The original product-weighted mass proposal was exactly falsified and is not a
launch candidate:

```text
n=2, N=3, a=(1,3):               Q=(0,2),       product=3, weighted sum=2
n=3, N=4, a=(1,2,8):             Q=(0,0,6),     product=16, weighted sum=12
n=4, N=5, a=(1,3,4,5):           Q=(0,0,2,2),   product=60, weighted sum=54
n=6, N=7, a=(1,2,3,4,5,7):       Q=(0,0,0,0,2,2), product=840, weighted sum=576
```

These are exact strict-boundary computations. They refute only the discarded
inequality, not LRC and not the replacement target. The false theorem is
preserved in Prompt105 solely as a prohibited route and regression fixture.

The replacement target is

```text
GLOBAL-FOUR-GCD-UNCOVERED-MASS:
  n>=3 -> 4*gcd(a) <= sum_j |Q_j|.
```

It is permutation symmetric and homogeneous under positive common scaling.
It is stronger than ordinary pivot positivity: reflection of one non-fixed
certificate supplies only a pair, not four residues. Fixed antipodes require a
separate parity and cross-pivot audit. If such an audit proves that ordinary
positivity always forces the displayed bound, the prompt requires
`STOP / EQUIVALENT` rather than promotion as a new bridge.

A disposable preparation scan used literal canonical residues, strict `<p`
badness, and seed `104105`. No failure was found in these complete domains:

| Dimension | Speed ceiling | Tuples completed | Minimum margin `sum|Q|-4g` |
| ---: | ---: | ---: | ---: |
| 3 | 25 | 2,300 | 0 at `(1,3,4)`, counts `(0,2,2)` |
| 4 | 16 | 1,820 | 0 at `(1,2,3,5)`, counts `(0,0,2,2)` |
| 5 | 12 | 792 | 4 at `(1,3,4,5,6)` |
| 6 | 10 | 210 | 0 at `(1,2,3,4,5,7)`, counts `(0,0,0,0,2,2)` |
| 7 | 9 | 36 | 4 at `(1,2,3,4,5,7,8)` |

An additional 300 deterministic random tuples in each dimension `3..8`, with
distinct speeds in `1..120`, also found no failure. These scans are audit
support only: the ephemeral implementation is not an artifact, was not
independently replayed, and is not `computed finite evidence`.

Verdict: the replacement survives bounded falsification, has one exact
quantitative edge, and is suitable for PI launch consideration.

## Duplication comparison

| Prior route | Prompt104 distinction | Prompt105 distinction |
| --- | --- | --- |
| Prompt98 nondivisible maximum pivot | no divisibility branch; studies exchanges among all covered labels | no maximum pivot or divisibility predicate |
| Prompt102 upper-half pivot | no speed-rank selector | sums every pivot without rank restriction |
| Prompt103 squarefree-gcd pivot | no numerator gcd stratum | uses only the common speed gcd for homogeneous normalization, not certificate gcd |
| Prompt66 packing/radial descent | no blocks, tokens, phases, or packing optimum | no packing object or radial order |
| Coefficient-two Gamma | no bounded height or matching of Gamma intervals | no coefficient-two or SDR hypothesis |
| Prompt95 | narrows hypothetical covers to a proper-subset expansion/full-core obstruction rather than asserting redundancy | bypasses covered-pivot/internal-cover language entirely |
| Prompt101 scalar weights | exchange graph, not a weight matrix | unweighted uncovered counts plus common gcd; the refuted positive subcritical weight premise is forbidden |

The two new prompts do not duplicate each other. Prompt104 assumes a
hypothetical simultaneous-cover obstruction and studies its private-set
exchange graph. Prompt105 works directly with uncovered counts for every pivot
and would prove a certificate without choosing a maximum covered pivot.

## Contract-completeness check

Both prompts contain:

- exact domains, definitions, strict boundary conventions, and conclusions;
- unrestricted-height classification;
- an explicit implication chain and exact remaining boundary;
- one named unresolved lemma per cell;
- known logical and arithmetic obstructions;
- strict-boundary, collision, scaling, malformed-input, synthetic-negative,
  and mutation falsification requirements;
- one-turn budget and fail-closed stop rules; and
- a fixed response schema and evidence vocabulary.

No repository status, task ledger, promotion registry, Lean source, browser
state, or Sol Pro lifecycle record is changed by Task374.

## Frozen payload hashes

Hash scope is the UTF-8 LF byte sequence from each `# Prompt ...:` line
through EOF:

```text
prompt104.md  85aac6fa484b2b9e0003caf23968c79daa0ab5d2ebd57ee7df86d5a3ea8361b3
prompt105.md  b85a89b554d449651b2ff1eeef91e4a38662041e35536fe366fa897b54e1cc04
```

The header hash fields must be revalidated after any body edit. A mismatch
returns the candidate to `REVISE`; it must not launch.
