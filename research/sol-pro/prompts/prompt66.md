# Prompt 66: ALL-PIVOT-MODULAR-WHOLE-BLOCK-PACKING

Start a **new GPT-5.6 Sol conversation with Pro effort**. This is
`SOL-P66-PRO-B-001`, one isolated unrestricted PRO-B research cell. Work only
on the stronger modular whole-block packing lemma specified below. Do not run
Prompt64 bounded scans, do not resume Prompt65 verifier work, and do not open a
simultaneous top-two cell.

Unrestricted Lonely Runner remains open. This prompt is a research contract,
not a proof, computation, submission, or status promotion. Preserve the
labels `proved-lean`, `proved-math`, `computed finite evidence`, `conditional`,
`conjectural`, `rejected`, and `open` exactly.

## Existing bridge and the sole new lemma

The existing `PositiveIntegerPivotCertificateConjecture` is already
Lean-equivalent to the positive-integer Lonely Runner formulation and hence,
through the verified real/integer reduction, to unrestricted LRC. Merely
restating it, its exact bad-set union noncoverage, or an equivalent integer
program is tautological as a bridge and is not progress.

The sole new research lemma is the strictly stronger

```text
ALL-PIVOT-MODULAR-WHOLE-BLOCK-PACKING.
```

It asserts that every positive injective integer tuple has at least one pivot
whose exact modular bad-set instance admits a capacity-respecting selection of
whole fiber blocks with enough strict credit to force noncoverage. The proof
must exploit arithmetic modular-coset structure. General hypergraph
integrality, fractional duality, and exact-cover restatements are forbidden.

Top-two pivot coverage remains the smallest currently named thin-API
alternative if this stronger packing lemma fails. It is not part of this cell:
Prompt62 already attacked top-two integral transversals and Prompt64 already
isolated the large-ratio top-two branch.

## Exact unrestricted definitions

Let `n>=1`, `N=n+1`, and let

```text
a : Fin n -> Nat
```

be positive and injective. Fix a pivot index `j`, put `p=a_j`, and let
`M=N*p`. Write

```text
rho_M(x) = min(x mod M, M-(x mod M)).
```

The canonical pivot grid is

```text
R_j = {r : 0 <= r < M and N does not divide r}.
```

It has exactly `n*p` residues. For each nonpivot owner `i!=j`, define its
strict bad set

```text
B_i^j = {r in R_j : rho_M(r*a_i) < p}.
```

The boundary is deliberate: badness is strict `<p`; safety is closed `>=p`.
For `r in R_j`, the pivot coordinate is automatically safe, but any use of
that fact must cite or prove the canonical pivot equivalence.

For an owner `i!=j` and a target residue `u` attained on `B_i^j`, define the
complete strict target fiber

```text
F(i,u) = {r in R_j : r*a_i == u (mod M)}.
```

Only nonempty fibers with `F(i,u) subset B_i^j` are tokens. For a distinct
nonpivot parent `k!=i,j`, its selectable whole block is

```text
Q((i,u),k) = F(i,u) intersect B_k^j.
```

Empty intersections are not choices. A selection `chi` chooses at most one
parent `k` for each token `(i,u)`. Put

```text
mu_j(r) = #{i!=j : r in B_i^j},
use_chi(r) = #{tokens e : r in Q(e,chi(e))},
S_j = sum_(i!=j) |B_i^j|,
credit(chi) = sum_(selected tokens e) |Q(e,chi(e))|.
```

The selection is capacity-respecting when

```text
use_chi(r) <= mu_j(r)-1
```

for every `r in R_j`, with natural subtraction interpreted exactly. Use the
subtraction-free strict threshold

```text
|R_j| + credit(chi) > S_j.
```

This is equivalent over the integers to
`credit(chi)>S_j-|R_j|`; do not interpret the latter with truncated natural
subtraction when `S_j<|R_j|`.

The sole new lemma is fully quantified as follows:

```text
For every n>=1 and every positive injective a : Fin n -> Nat,
there exist a pivot j and a partial token-parent selection chi such that
  (1) every selected parent is a nonpivot index distinct from the token
      owner,
  (2) chi selects at most one whole block per token,
  (3) use_chi(r) <= mu_j(r)-1 for every canonical residue r, and
  (4) |R_j|+credit(chi) > S_j.
```

Condition (1) means the parent index is distinct from the token's owner, not
that different tokens must choose different parents. Do not silently impose a
stronger injective-parent restriction.

## Exact implication chain and current status

The intended chain is

```text
ALL-PIVOT-MODULAR-WHOLE-BLOCK-PACKING
  -> PART-45 capacity inequality
  -> |union_(i!=j) B_i^j| + credit(chi) <= S_j
  -> |union_(i!=j) B_i^j| < |R_j|
  -> an uncovered r in R_j
  -> PositiveIntegerPivotCertificateConjecture
  -> PositiveIntegerConjecture
  -> verified real/integer reduction
  -> unrestricted LRC.
```

Do not assume the first implication has already been formalized at the modular
level. Cite the repository boundary exactly:

- `PART-45` is `proved-lean`: `OverlapCapacity.lean` proves the abstract
  incidence Fubini identities and capacity inequality. It does not prove that
  a modular instance has a threshold-beating selection.
- `PART-46` is `proved-math`: the exact multiple-choice hypergraph
  b-matching model and its abstract fractional obstruction are audited, not
  Lean-formalized as the desired modular existence theorem.
- `PACK-08` is `proved-math`: exempt-owner coloring characterizes the packing
  optimum. It does not imply pivot noncoverage.
- The `COMP-10` verifier/certificate-accounting argument is `proved-math` at
  its exact hypotheses. The eleven fixed-instance packing outcomes are only
  `computed finite evidence`; they have no unbounded consequence.

A proof must instantiate every finite type, token, block, point-use capacity,
and strict credit inequality needed by `PART-45`; it may not cite the status
labels as though they proved the new lemma.

## Known obstructions that must be confronted

1. **Abstract nonintegral triangle.** With unit capacities and blocks
   `{x,y}`, `{y,z}`, `{z,x}`, the integer optimum is `2` while the fractional
   optimum is `3`. General LP integrality is false.
2. Ordinary max flow is exact only when every choice block is a singleton.
   Trimming a nonsingleton whole block is invalid.
3. Pairwise feasibility and aggregate neighborhood-capacity inequalities do
   not characterize the integer packing optimum.
4. Whole-block packing is stronger than literal noncoverage. For tuple
   `G=(15,21,40,48,56,105,126,280,1200)`, pivot `48` has packing optimum
   `412<=424` even though the literal bad-set union leaves candidates.
5. Other exact fixed-pivot failures include `G` pivots `15`, `21`, `40`, and
   `126`; equality does not meet the strict threshold.
6. Fractional top-two duality fails at `(N,A,B)=(7,98,187)`. It cannot be
   imported as an integral packing theorem.
7. Additive order, ranked-fiber, GCD-clock, relocation, three-anchor,
   anchor-star, dispersion/range-sum, top-cycle, and CHAIN3 uniform criteria
   all have exact non-LRC counterexamples. Repackaging one is not a new lemma.

## Frozen mandatory falsification domain

The acceptance domain is finite and completely ordered. Do not add an
implicit tracked family, primitive box, random sample, or Prompt64 scan.

First evaluate the abstract nonintegral triangle as preflight case `0`. It is
a method-sanity obstruction, not by itself a lemma-refutation hit. Then use
the following eleven positive injective base tuples, in exactly this order:

```text
F     = (8,15,35,40,48,56,75,132,147)
G     = (15,21,40,48,56,105,126,280,1200)
RF    = (2,3,7,9,10,12,15,16,19)
GCD1  = (8,15,35,40,48,56,63,75,78)
GCD2  = (6,8,15,21,28,35,40,48,75)
hardA = (1,2,5,7,9,11,12,13)
hardB = (1,5,7,8,9,11,13,15)
small = (1,2,3,5)
D     = (10,37,45,51,54,56,61,71,91)
C     = (8,15,35,40,48,56,68,75,78)
E     = (5,28,35,40,68,88,108,148,165)
```

The displayed literals are the authoritative audit input; do not reload them
from a mutable repository source at execution time. Their provenance is the
fixed `F`, `G`, and `STRESS_CASES` collection in
`scripts/audit_whole_block_packing.py` at the recorded launch commit.

For each base tuple, first test every pivot in increasing speed order. This
is `92` fixed pivot instances. Next construct mutations in base-tuple order,
then original zero-based coordinate-index order `0,...,m-1`, then delta order
`(-3,-2,-1,+1,+2,+3)`: replace that coordinate by its old value plus the
delta, discard a construction if the result is nonpositive or noninjective,
and otherwise sort the resulting tuple increasingly. Construction
descriptors are not deduplicated even if two descriptors yield the same
sorted tuple. Test every pivot of each retained mutation in increasing speed
order before advancing to the next descriptor. This yields exactly `461`
retained mutation tuples and `4,057` mutation pivot instances: respectively
`54/486`, `54/486`, `33/297`, `52/468`, `52/468`, `25/200`, `27/216`,
`8/32`, `50/450`, `52/468`, and `54/486` mutation-tuples/pivot-instances in
the displayed base order. Thus the frozen audit contains `4,149` modular
packing instances and `4,150` total cases including preflight case `0`, below
the `10,000` cap.

Use exact integer/rational arithmetic, preserve every tie, and compare any
optimized implementation with a structurally separate literal replay. Record
the SHA-256 hashes of this prompt, every executed solver/replay source, and
the emitted transcript. A finite success is only `computed finite evidence`.

For a proposed uniform sufficient sublemma, process this order sequentially
and stop at its first failing case. The required transcript then runs only
through that early-stop case; do not execute or claim the remainder. A failed
single pivot refutes only a fixed-pivot or local subcriterion. A
lemma-refutation hit requires exact failure at every pivot of one tuple, so
finish that tuple's complete pivot bundle before making that claim. If all
`4,150` cases are exhausted, report the first obstruction in the declared
order. Say "smallest" only when an explicitly declared total order and its
entire finite domain were exhausted.

### Exact hit meaning

- A **lemma-refutation hit** is one positive injective tuple for which exact
  integer optimization proves `|R_j|+credit<=S_j` for every pivot `j`. It
  refutes only `ALL-PIVOT-MODULAR-WHOLE-BLOCK-PACKING`; it is not an LRC or
  all-pivot-certificate counterexample.
- A **packing witness** is a replayable selection satisfying every capacity
  and strict-credit condition at one pivot. It proves only that finite
  instance unless accompanied by a complete uniform argument.
- An uncovered residue is direct finite instance evidence, not a uniform
  theorem.
- Equality at the credit threshold is failure because noncoverage requires a
  strict cardinality inequality.

## Prohibited substitutions

- Do not restate exact bad-set union noncoverage, the exact integer packing
  program, or `PositiveIntegerPivotCertificateConjecture` as the new lemma.
- Do not assume general hypergraph or LP integrality.
- Do not restart or enlarge Prompt64's bounded domain or scanners.
- Do not resume Prompt65 transfer/reindex verifiers.
- Do not open a simultaneous top-two, DPLP, prime-forcing, height-compression,
  coefficient-two, or bounded-height cell.
- Do not turn finite stress success into a theorem claim.

## Stop condition and maximum budget

Maximum budget:

- exactly one major Sol Pro turn;
- only the frozen `4,150`-case audit above (`4,149` modular packing instances
  plus one abstract preflight), with declared sources, output, and hashes;
- at most one Lean prototype, and only after a non-tautological mathematical
  lemma survives the entire frozen mandatory domain.

Stop immediately if:

1. an exact lemma-refutation hit is found;
2. the argument needs general hypergraph integrality or a fractional
   relaxation contradicted by the triangle;
3. the proposed condition is equivalent to literal exact union computation;
4. the work duplicates Prompt62 top-two, Prompt64 bounded/large-ratio, or
   Prompt65 first-blocker work;
5. no implication strictly narrower than the stated packing lemma survives
   the maximum budget.

On stop, report the first exact obstruction in the declared order and leave
unrestricted pivot coverage and LRC open. Report a smallest obstruction only
after exhausting an explicitly ordered finite comparison domain.

## Required output

Return:

1. an exact status table with no promotion by self-label;
2. the fully quantified packing lemma and every intermediate definition;
3. at least two genuinely modular-coset proof attacks, not generic packing
   relaxations;
4. complete proofs of every new `proved-math` claim;
5. exact certificates for every rejected criterion and any hit;
6. the exact frozen-domain transcript through the first early-stop case, or
   through all `4,150` cases if no earlier stop occurs;
7. one first unsupported implication after the turn;
8. at most one proposed Lean declaration, only if the mathematics survives;
9. an explicit stop/continue decision;
10. no theorem, counterexample, finite-evidence, Lean, axiom, or unrestricted
    status promotion without independent review.

## Execution blocker

This cell is **waiting**. Browser/ChatGPT-control is unavailable in the current
runtime, so the required external signed-in Sol Pro conversation cannot yet be
launched. The tracked prompt is queued packaging only.
