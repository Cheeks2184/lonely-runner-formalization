# Independent review of two restricted ideal-row selections

**Accepted as two manuscript lemmas, with no correction required.** Both
arguments supply a closed-good regular pair under their exact hypotheses.
They neither settle arbitrary real slopes nor supply an automatic forward
selection or finite-M transfer. Their proofs use common slopes across rows;
an integer centre may be selected separately for the row eventually chosen.

Review date: 2026-09-06. Task `/root/ideal_row_selection_review`, in the
requested existing Astra/xhigh session. Review source checkpoint:
`15ef35a75c255f3fcdaafe8fb289f1fe6d97ee30`.
The complete frozen file reviewed is
`research/astra-ideal-row-selection-audit.md`, SHA-256
`20752d3a362a153d4cdaa2f30373c01002fa0dd3ed708b3bf1d1b4a4d67c77b7`.
Its recorded author checkpoint remains
`4227fef76e8a2081460c27b3af627bc6dcb501d4`.

The contextual bindings, whose mathematics is not needed as a premise of
these self-contained proofs, were also checked against the actual files:

* `research/astra-general-slow-cluster-audit.md`:
  `07d42aa0e48e2daa62d4799049b317eee526af42ecb025fcd0e6515a7cfa6478`.
* `research/astra-cluster-grid-rescue.md`:
  `edc948e31d6939132dd44dec7fe84612912ab952ceb8e98140a6b9cb2e9b5f9c`.
* `research/astra-cluster-grid-rescue-review.md`:
  `99caba49dd2b5b20475d89901d39fd6ce24fbbb5a060b949ab7707f52a6b569e`.

## 1. Exact selection convention

For a circle of circumference N, an integer centre h modulo N satisfies
`d_N(k x_i,h)>=1` for every slope exactly when the digit
`ell=-h mod N`, represented in `{0,...,N-1}`, gives

`fract((k x_i+ell)/N) in [1/N,1-1/N]` for every i.

Indeed, with `y=(k x_i-h) mod N` in `[0,N)`, its distance from zero is
`min(y,N-y)`, which is at least one exactly when `1<=y<=N-1`.
Consequently a row fails precisely when its **open** radius-one arcs cover
all integer centres. A centre at distance exactly one remains good.
The lemmas below select a row `1<=k<=N-2`; neither needs the exceptional
pair `(N-1,0)` of the wider proposed claim.

## 2. Punctured equally spaced slopes

The first statement assumes a prime `q>=5`, sets `N=q+1`, and has exactly
`q-1=N-2` slopes

`x_j=alpha+N j/q`, for `1<=j<=q-1`, with any real alpha.

This is a prime-q statement; N itself is not assumed prime. Every allowed
row `1<=k<=N-2=q-1` is a unit modulo q. Multiplication by k permutes the
nonzero residues j, so its row points are the same punctured q-grid,
translated by `k alpha` on the circumference-N circle.

Put `g=N/q=1+1/q`. Removing its nominal zero point creates one gap of
length `2g`; all other gaps have length g. For a centre inside any gap,
the first point reached in each circular direction is one of its bordering
points. If both directional distances to the borders are at least one,
then every other point also has distance at least one. Thus a gap of length
G supplies exactly its closed middle segment after removing length one at
each end, or supplies nothing when `G<2`.

Here `g<2`, so only the double gap contributes. Around its omitted point
`k alpha`, the surviving segment is exactly

`[k alpha-(g-1), k alpha+(g-1)] = [k alpha-1/q,k alpha+1/q] mod N`.

Because N is an integer, an integer centre modulo N lies in this segment
if and only if some ordinary integer lies within `1/q` of `k alpha`.
This proves the author's exact equivalence

`row k selects iff ||k alpha||<=1/q`.

For existence, consider `0,alpha,...,(q-1)alpha` modulo one. Coincident
points yield a nonzero index difference of absolute value in `{1,...,q-1}`
and norm zero. Otherwise their q cyclic gaps have sum one, so a gap is at
most `1/q`. The distance of its endpoints is at most that gap; the absolute
index difference again gives an allowed positive k because circle norm is
unchanged by negating the difference. This covers the wraparound gap too.

Equality is deliberately retained. It can put a neighbouring row point at
distance exactly one from the selected centre. The result therefore proves
the stated closed selection without silently establishing a forward one.

## 3. Small perturbations of distinct residues

The second statement assumes prime `N>=5`, a set R of exactly `N-2`
distinct residues, and fixed real perturbations

`x_r=r+epsilon_r`, with `|epsilon_r|<1/(N-2)`.

Representatives may change by multiples of N without changing the slopes
on the circle. For every allowed positive k,

`|k epsilon_r|<1`.

Writing the nominal integer centre as `kr`, the open arc about the actual
point covers precisely `kr,kr+1` when epsilon_r is positive, precisely
`kr-1,kr` when it is negative, and only kr when it is zero. No other integer
centre is within distance one. This statement is valid across the cut at
zero. In the zero case the adjacent centres are at distance exactly one,
so openness is essential.

Let u and v be the omitted residues. Since k is invertible, every nominal
occupied centre is covered by its own label, and the only potentially
uncovered centres are ku and kv. For either hole h and `d=k^(-1)`, its
centre kh is covered if and only if

`epsilon_(h-d)>0 OR epsilon_(h+d)<0`,

omitting an alternative whose label is a hole. These are exactly the two
possible adjacent nominal centres. In particular, using the row with
residue minus k does not negate a perturbation: that row is represented
by the positive integer `N-k`, which preserves its sign and still obeys
the magnitude bound. This fixed sign information couples different rows.

Assume that every regular row fails, so both holes must obey this coverage
clause in every such row. Translating the original slopes by the integer
minus u permutes integer centres in each row and relabels residues, with
the same perturbations. Hence the first hole may be set to zero without
assigning new row points or new signs independently.

For nonadjacent holes `0,d`, where `d!=0,1,-1`, the positive representatives
of `k=d^(-1)` and `N-k` both lie in `{1,...,N-2}`. If either excluded row
N-1 or its partner 1 arose, d would be plus or minus one. The label minus d
is present: it is neither zero nor d, since the prime N is odd.
In row k the holes are 0 and 1, and coverage of zero requires
`epsilon_(-d)>0`. In row `N-k` the holes are 0 and minus one, and coverage
of zero requires `epsilon_(-d)<0`. This contradicts failure of both rows.

For adjacent holes, order them so that their difference is plus one and
then translate; no reflection of the perturbations is needed. The holes
are now 0 and 1. Failure of row 1 forces

`epsilon_(-1)>0` and `epsilon_2<0`.

For each `e!=0,1,-1`, both inverse rows for e and minus e are allowed.
Their two coverage clauses at hole zero are

```
epsilon_(-e)>0 OR epsilon_e<0,
epsilon_e>0 OR epsilon_(-e)<0.
```

They imply equal, nonzero signs for the labels e and minus e. If one sign
were zero, the clauses would require both strict signs from the other
label; if the signs were opposite, one clause would fail. Applying the
same reasoning at hole one gives equal, nonzero signs for `1-e` and `1+e`.

To verify every edge used in the resulting path, write `N=2h+1` and take
`1<=j<h`. The edge `2j -> -2j` uses reflection about zero with distance
`e=2j`, whose representative is between 2 and `N-3`, so it is not
0, 1, or minus one. The edge `-2j -> 2(j+1)` uses reflection about one
with signed distance `e=2j+1`, between 3 and `N-2`, again avoiding all
three excluded residues. Thus every edge of

`2,-2,4,-4,...,2(h-1),-2(h-1),2h=-1`

is justified by an available pair of inverse rows. Its positive even
entries are `2,4,...,N-1`, and its negative even entries have ordinary
representatives `N-2,N-4,...,3`. These are disjoint and together are all
labels `2,...,N-1`, so the path visits R exactly once. It forces epsilon_2
and epsilon_(-1) to have equal signs, contrary to row 1.

At the smallest permitted prime N=5, this path is simply `2,3,4`:
reflection about zero joins 2 to 3, and reflection about one joins 3 to 4.
The inverse rows used are 2 and 3, both allowed. The contradiction with
row 1 remains valid. Zero perturbations are never assumed away; under the
all-rows-fail hypothesis the paired clauses would force them nonzero, which
is exactly why they cannot evade the contradiction.

Both hole cases therefore prove a closed selection in a regular row.
Primality, distinct nominal residues, and the strict perturbation bound
are actual hypotheses. They are not inferred for arbitrary real slopes.

## 4. Scope and verification

No arbitrary-real-slope selection theorem or counterexample is established.
The proof in the second family relies on the extra covered integer centre
being determined by one fixed perturbation sign through every positive
allowed multiplier. Larger perturbations can cross integer centres, and
slopes need not admit the required distinct nominal residues. These cases
are outside the proof, with no reduction to the proved cases asserted.

Both conclusions are closed ideal selections. They may use equality at an
upper face; a positive finite-M correction can destroy that equality.
Neither forward success nor success of the corresponding finite-M cluster
candidate follows automatically. The exceptional pair is unnecessary in
the proved families but remains part of the broader unresolved closed claim.

Verification was independent hand circle geometry, cyclic pigeonhole,
inverse-row algebra, sign logic, and the explicit path including N=5.
No mathematical program, replay, solver, numerical domain, external theorem
lookup, or new approach was used. The current project configuration,
workflow, policy, and focused active state were read. The command
`python3 -B scripts/validate_workflow.py` exited 0 with complete output:

```text
workflow structural validation passed; it cannot certify mathematical validity.
```

The four source bindings were checked with `sha256sum`; the author and review
files passed trailing-whitespace and final-newline checks. Only this review
was written. There was no Git operation, shared-state mutation, cache change,
Lean work, or delegation. Structural and file checks are administrative
evidence, separate from mathematical review. Per-task elapsed time, token
usage, and independently observed runtime model metadata are unavailable
and remain null. No owned process or dependency-cache requirement remains.
