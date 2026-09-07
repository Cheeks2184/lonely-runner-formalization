# Independent review of the uniform harmonic-fold obstruction

Task `/root/harmonic_fold_uniform_review`, reviewer handle
`/root/coordinate_cancellation_review`; requested `gpt-6-astra` / `xhigh`.
Source checkpoint: `27309c7e0a0d93c8f9ce90245cec013a3ffcd5d8`.
Only this review is owned. The complete frozen author was read.

**Verdict: accepted as an exact uniform auxiliary counterexample, without
corrections.** Every original maximizing choice violates the proposed
recurrence for every moving dimension `d>=3`. The examples satisfy LRC;
the argument does not address a recurrence restricted to strict minimal
failures. The hand proof is independent of the numerical checker.

## Exact contract and the hypothetical induction implication

The rejected assertion quantifies over primitive positive distinct
mixed-parity integer tuples `v` of moving count `d`. It requires some
global maximizing ordinary time `0<t<1/2` for which

    n_i=2 floor(v_i*t)+1,  w_i=v_i-2n_i,
    V=primitive positive deduplication of the nonzero |w_i|,
    q=|V|,
    mu(v)>=mu(V)/(1+(d-q)*mu(V)).

The existential choice of maximizing time is essential: one bad choice
would not refute this contract. The author checks every such choice.

The author's conditional induction claim is valid. For any such time,
`1<=n_i<=v_i`, with `n_i<=v_i-1` when `v_i` is even. Hence
`|w_i|<=v_i`, strictly at each even coordinate. Mixed parity gives an
even coordinate, so the full absolute sum strictly decreases. An odd
original coordinate leaves an odd nonzero fold, ensuring `q>=1`.
Deleting zeros, deduplicating and dividing the gcd do not increase sum,
and `q<=d`. Strong induction on positive integer sum is therefore available.

Primitive all-odd tuples are handled directly at time `1/2`; other
primitive tuples are mixed parity. Nonprimitive scaling preserves `mu`.
For a mixed tuple, `mu>0`, while both endpoints of `[0,1/2]` have zero
margin, so a normalized global maximizer exists in its interior.
If the proposed recurrence were true, induction would give
`mu(V)>=1/(q+1)`. The function `x/(1+(d-q)x)` is increasing for
`x>=0`, and its value at `1/(q+1)` is `1/(d+1)`. This proves the
conditional ordinary integer LRC implication; it does not assume the
false recurrence or furnish an unrestricted formal theorem.

## Complete maximizing-time set in every dimension

Let `H` be any finite set of distinct positive integers, including the
empty set, and append `198h+1` to the base `(1,6,12)`. There are
`d=3+|H|` positive distinct speeds, with gcd one and mixed parity.

For `x in [0,1)`, the inequalities `||x||>=1/3` and
`||2x||>=1/3` force exactly `x=1/3` or `x=2/3`: the first confines
`x` to `[1/3,2/3]`, and the second permits only its endpoints.
At both endpoints the minimum is exactly `1/3`. Applied to `x={6t}`,
this proves the global upper bound from the pair `(6,12)`.

Periodicity and reflection reduce all real times to `[0,1/2]`. Speed
`1` forces `t>=1/3` for margin at least `1/3`, so `6t in [2,3]`.
The two permitted fractional parts leave precisely

    t_1=7/18,  t_2=4/9.

Both attain margin `1/3` on the base. For every appended index,

    (198h+1)t_1=77h+7/18,
    (198h+1)t_2=88h+4/9.

Both appended distances exceed `1/3`, so the same two times remain
maximizers and no other normalized maximizer can appear. Thus
`mu(v_H)=1/3` and the complete normalized maximum set is exactly the
author's pair. Equivalently, all maximizing times modulo one are
`7/18,4/9,5/9,11/18`; neither excluded endpoint is a maximizer.

## Exact raw folds and folded global margins

Taking the floors at the two times gives respectively

    n_1=(1,5,9), appended 154h+1;
    w_1=(-1,-4,-6), appended -110h-1;
    n_2=(1,5,11), appended 176h+1;
    w_2=(-1,-4,-10), appended -154h-1.

All absolute entries are nonzero and distinct, and each fold contains
`1`, so its gcd is one. Appended absolute speeds are at least `111`
or `155`, respectively, and cannot collide with the base or one another.
Therefore `q=d` for both folds. Each appended absolute speed decreases
by `88h` or `44h`; the base decreases too. No normalization loss explains
the counterexample, and both folded tuples remain mixed parity.

For `(1,4,6)`, time `2/5` gives three distances `2/5`. If a larger
margin existed, reflection and speed `1` would force `2/5<t<=1/2`.
Then `8/5<4t<=2`, whose distance to `2` is strictly below `2/5`.
This is an upper bound over every real time. Appended speeds satisfy
`(110h+1)(2/5)=44h+2/5`, so their distances also equal `2/5`.
Consequently the full first folded margin is exactly `2/5`.

For `(1,4,10)`, time `4/11` gives distances `(4/11,5/11,4/11)`.
A larger margin would force `t>4/11` and `t<=1/2`. Since
`4t in (16/11,2]`, the speed-4 constraint further forces `t<9/22`.
It follows that `40/11<10t<45/11`. Every number in this interval
has distance to `4` strictly less than `4/11`, contradicting the
speed-10 constraint. Appended speeds satisfy
`(154h+1)(4/11)=56h+4/11`. Hence the full second folded margin is
exactly `4/11`. These global upper bounds and matching witnesses do not
depend on an enumeration theorem or a finite sample.

## Falsification and the first unresolved implication

Because `q=d`, the recurrence's two right sides are exactly `2/5`
and `4/11`, both strictly greater than the original `1/3`. Equivalently,
the reciprocal discrepancies are `3-5/2=1/2` and `3-11/4=1/4`.
Every maximizing choice fails. Choosing a larger dimension or requiring
that folding preserve every coordinate does not repair the assertion.

The original tuple has `mu=1/3>1/(d+1)` for every `d>=3`, and its
odd-coset radius is `1-2mu=1/3<(d-1)/(d+1)`. The folded tuples are
also LRC-good. The family thus refutes the unconditional induction rule
while giving no counterexample to LRC or to a strict-failure-only rule.

The first unresolved implication remains a reverse transfer of a smaller
folded tuple's witness, using an additional invariant or the full strict
minimal-failure hypotheses. Height decrease and an improved folded margin
alone do not provide it. This review proposes no replacement approach or
Lean implementation and establishes no unrestricted proof or disproof.

## Frozen bindings, numerical provenance and actual checks

The current config, workflow, policy and focused task state were read.
The validator was fully read in the immediately preceding review; its
hash is unchanged. The state permits research: `research` / `in_progress`,
with explicit start authorization from 2026-09-05 and this exact review
active. All following file hashes were read back and matched:

| File | SHA-256 |
| --- | --- |
| `research/astra-harmonic-fold-obstruction.md` | `a5037d4b8f33d493b26ee1a7854bd654d7ea373e500c364cad10070954e2ca9a` |
| `.codex/config.toml` | `28212a53cf42cdc377df1f7dab040732d657e59d7bb97ee78791256d01d4bb2c` |
| `docs/project-workflow.md` | `2b42a133352b6b53ba2106fc73882733f176e04a0deffbb183b4c16eefd9cd67` |
| `research/workflow-policy.json` | `833c397b61d1ffdb994fb115019f6d60d6c1a62ff85f19cdd2c9f8ac3a979c8b` |
| `scripts/validate_workflow.py` | `250a3ce2a080f5835ac4fd2e4b2803568424c777cda5d421f9fe92efd34d5383` |
| `research/astra-harmonic-fold-control-initial.json` | `0e50da097bbd3999b2f1bb956b4ebe0f93ee9cd410b93f98a2faba6658769a32` |

The complete archived initial receipt was read. Hashing its embedded
`execution.source_utf8` reproduces the author's original source hash
`55ec97ee965cebd6e0fe31d836b78f416be3bd27f71592f63b04622808dc9a1c`.
The receipt reports the same base, both times, both folds and both margins.
The embedded source explicitly excludes `1/2` for multiple speeds, which
confirms the described generic all-odd endpoint omission. Neither folded
tuple in this family is all odd. The historical receipt is provenance
only; its claim of being the first searched counterexample is not adopted.
The changing repaired source and receipt were not used or executed.

Actual command in `/home/joshua/lonely-runner-formalization`:

    python3 -B scripts/validate_workflow.py

Exit status `0`; complete output:

    workflow structural validation passed; it cannot certify mathematical validity.

Administrative Python checks also verified the archived receipt and its
embedded-source hashes; final readback verifies the six bound file hashes,
newline and trailing whitespace, and reports this review's SHA separately.
The preceding coordinate review remains at
`9d53e7f9426a9ae828462e66f045a35ef39580b519bf3910ac3070d484d0b258`.
All mathematical verification was exact hand algebra. No mathematical
program, search, Lean/cache/dependency operation, external/browser model,
extra agent, Git/state write or other-file edit was used. No mathematical
or command errors occurred, and no owned process remains. Requested route
is Astra/xhigh; observed model, effort, elapsed time and usage are null.
