# A finite coupled-carry lemma for the five-adic hard branch

2026-09-06. Requested Astra/xhigh author `/root/mixed_equivalence_freeze`;
routing is requested, not independently attested. Only this manuscript is
owned. Current configuration, workflow, policy and active state were read;
the structural validator passed. Source context is Pass36 checkpoint
`a9050d209eacb78dfe32b435d67a7e115819f3e9`; the reused source files are
hash-guarded below. No Lean execution, source/state/Git/cache edit, speed-tuple
enumeration or certificate discovery is performed. The overall goal remains
active and unresolved.

**Author result:** the exact 40³-state candidate is true, with a short symbolic
proof below. The finite proof permits arbitrary normalized residues and
arbitrary *coupled* carry types; it does not need further realizability
conditions relating these data. The integer adapter still needs the explicit
floor, remainder, sign and norm lemmas stated below. This is supporting work
for one valuation pattern, not a whole five-runner or unrestricted theorem.

## Primary source and scope

J. Barajas and O. Serra, *The lonely runner with seven runners*, Electronic
Journal of Combinatorics **15** (2008), Research Paper R48, published March 18,
2008: [primary PDF, Lemma 2 on p.4 and §3 on p.5](https://www.combinatorics.org/ojs/index.php/eljc/article/download/v15i1r48/pdf).
The source was retrieved directly. Lemma 2 requires a prime p, top valuation m,
and forbidden-set totals at most p−1 below m and p−2 at m. Its translation
mechanism preserves higher valuation levels. Section 3 treats four moving
speeds at p=5 and compresses the three unit residues. The proof below makes
that branch an explicit finite statement. No full paper theorem is imported
as an already proved Lean declaration, and the seven-runner sections are
outside this microtask.

## Exact candidate and four carry types

A state is `(a,r,C)` with `a∈{0,1,2,3,4}`, `r∈{1,2}` and
`C∈{(0,0),(0,1),(1,1),(1,2)}`. Set `c_1=0`, and let `c_2,c_3` be C.
All displayed digit arithmetic is modulo 5. The finite target is

```
for every ordered triple of states (a_i,r_i,C_i),
there are j∈{1,2,3} and k∈{0,1,2,3,4} such that
    j*a_i + c_{j,i} + j*k*r_i ∈ {1,2,3}  for every i.       (T)
```

Repeated states are permitted. There are exactly `5*2*4=40` states and
`40^3=64,000` ordered triples. No fourth multiplier j=4 is needed.

For an actual integer x and `R=5^m`, m≥1, let `z=x mod R`, so `0≤z<R`.
The pair `(floor(2z/R),floor(3z/R))` has precisely the four listed possibilities:

| Range of z/R | Carry pair |
|---|---|
| [0,1/3) | (0,0) |
| [1/3,1/2) | (0,1) |
| [1/2,2/3) | (1,1) |
| [2/3,1) | (1,2) |

For R=5^m the three internal boundaries cannot occur at an integer z, since
2 and 3 are coprime to R. All four types occur when z ranges over 0,...,R−1;
the finite proof only needs membership, not this surjectivity. Fixed m and
fixed normalized r need not realize every abstract state: (T) safely proves
a larger finite domain. Independent choices `c_2∈{0,1}`, `c_3∈{0,1,2}`
would add impossible pairs (0,2) and (1,0) and invalidate the proof mechanism.

## Symbolic proof of (T)

Translation replaces every a_i by `a_i+h*r_i` while leaving C_i unchanged.
If (j,k) works for the translated data, then (j,k+h) works for the original
data. Thus such a translation, followed by relabelling coordinates, is allowed.
For equal r the translation of their a-values is arbitrary because r is a
unit modulo 5. After choosing j, their common translation step j*r is also
a unit. A block of length ell means ell consecutive residues on the 5-cycle.

**All three r-values equal.** If their a-values lie in a block of length 3,
j=1 followed by a translation places them in {1,2,3}. Otherwise all three
a-values are distinct. The five nonconsecutive three-subsets are exactly the
translates of {0,2,3}; the other five three-subsets are consecutive. Translate
and relabel to a=(0,2,3). Under j=2 the three digits belong respectively to

```
{0,1}, {4,0}, {1,2}.
```

If they lie in a block of length 3, translate and finish. Otherwise the second
digit must be 4 (a second digit 0 puts all digits in {0,1,2}), and the third
must be 2 (a third digit 1 puts all digits in {4,0,1}). Hence c_2 for the
original a=2 state is 0, and for the original a=3 state it is 1. Coupled
carries force their respective c_3 values into {0,1} and {1,2}. Under j=3
the three digits therefore lie respectively in

```
{0,1,2}, {1,2}, {0,1},
```

all inside {0,1,2}. A final translation gives the target.

**Two equal r-values s and one different value r.** Then `r/s=±2` modulo 5.
First compress the equal-residue pair into a block of length 2. If j=1 does
so, retain it. Otherwise their a-difference is ±2; translate and swap them
to obtain (0,2). For j=2 the pair lies in {0,1}×{4,0}. Its only failure to
lie in a length-2 block is the pair (1,4). In that case its c_2 values are
respectively 1 and 0; their coupled c_3 values are in {1,2} and {0,1}.
The j=3 digits consequently both lie in {1,2}, completing compression.

For the chosen j put the compressed pair inside a block {u,u+1}, extending
it to such a block if its two digits coincide. There are two translations
of this block into {1,2,3}, namely onto {1,2} and {2,3}. Their k-values
differ by `(j*s)^(-1)`. The singleton's two corresponding digits differ by
`(j*r)/(j*s)=r/s=±2`. They cannot both belong to {0,4}, whose distinct
elements differ by ±1. At least one translation therefore works for all
three coordinates. These two cases exhaust the normalized residue patterns.

Only the constraints `c_2=0 ⇒ c_3∈{0,1}` and
`c_2=1 ⇒ c_3∈{1,2}` were used. All inequalities and finite statements are
closed; the proof has no strict ordinary premise or speed distinctness input.

## Settled finite API and recommended proof route

Proposed Lean data (not declarations implemented by this task):

```lean
structure FiveCarryState where
  top : Fin 5
  residue : Fin 2       -- decoded as residue.val + 1
  carry : Fin 4        -- 0↦(0,0), 1↦(0,1), 2↦(1,1), 3↦(1,2)

-- multiplier u : Fin 3 is decoded as u.val + 1.
def fiveCarryDigit (s : FiveCarryState) (u : Fin 3) (k : Fin 5) : Fin 5

theorem fiveCarryTriple : ∀ s : Fin 3 → FiveCarryState,
  ∃ u : Fin 3, ∃ k : Fin 5, ∀ i,
    (fiveCarryDigit (s i) u k).val ∈ ({1,2,3} : Finset Nat)
```

`fiveCarryDigit` is the natural formula in (T), reduced modulo 5. Define the
carry selector by the four-case lookup; do not expose independent double and
triple carry fields. The three-state theorem has no adapter, positivity,
primitivity or realizability assumptions. Use a finite Boolean form if that
simplifies the existing kernel-checking patterns, with a proved iff to the
displayed existential statement.

Derive `DecidableEq` and `Fintype` for the finite state structure. Present the
universal theorem as a closed forall when attempting `decide`; a free arbitrary
state parameter does not itself reduce to a particular finite numeral.

The domain is sufficiently bounded for a measured attempt at ordinary kernel
`decide`; it is not a measured runtime guarantee. Cap a later whole check at
60 seconds/4 GiB, with no `native_decide`, custom axiom, precomputed external
truth bit or silent budget increase. A direct large `decide` proof is optional:
if it is expensive, implement the symbolic two-case argument and use tiny
Fin5 geometry/carry checks only. No 64,000-entry witness table is necessary.

## Integer adapter obligations

Work over integers with Euclidean division by positive R. Define
`q_R(x)=(x div R) mod 5`. Prove these exact lemmas separately:

1. If `5∤x`, choosing x or −x makes its residue modulo 5 lie in {1,2}.
   For such an x, R≥5 and `5∣R` imply `0<z=x mod R<R`.
   Writing `x=A*R+z`, one has `−x=(−A−1)*R+(R−z)`, hence
   `q_R(−x)=−q_R(x)−1` modulo 5. Norms at x and −x agree by the existing
   `circleNorm_neg`. Normalize the sign **before** extracting the state.
2. The range proof above returns one `Fin 4` carry tag for z, simultaneously
   realizing both floors. Never derive two unrelated carry choices.
3. For j=1,2,3 and k=0,...,4, Euclidean division gives

   `q_R(j*(1+k*R)*x) = j*q_R(x) + floor(j*z/R) + j*k*(x mod 5)` in Z/5.

   Indeed `j*x=j*A*R+j*z`, and the additional term `j*k*R*x` is an integer
   multiple of R. This identity remains valid for signed x. The remainder
   below R does not change on multiplying by `1+kR`, so the translation step
   used in the finite proof preserves the carry pair. Composing two such
   factors reduces to `1+(k+h)R` modulo 5R since `5R∣R²` for m≥1; this also
   explains the single k in (T).
4. A digit in {1,2,3} puts the least nonnegative residue modulo 5R in
   `[R,4R)`, so the norm at rational phase `x/(5R)` is at least 1/5.
   Use Euclidean residue algebra and `circleNorm_add_int` to reduce signed
   x to its nonnegative residue, then `circleNorm_nat_div_eq` or
   `rationalMargin_circleNorm_iff`. This proves a closed margin, not merely
   a top-digit heuristic.
5. For the fourth speed h with `h=R*v` and `5∤v`, every chosen
   `λ=j*(1+kR)` is positive and not divisible by 5. Its residue on h is
   `((j*v) mod 5)*R`, with multiplier digit 1,2,3 or 4, so its norm at
   `t=λ/(5R)>0` is also at least 1/5. This includes digit 4 at its lower
   endpoint. The maximum-valuation speed need not be the fastest speed.

Together these give the precise hard-pattern implication: m≥1, three
5-units x_i, and one h of valuation exactly m admit one positive rational
time with all four norms at least 1/5, after undoing the independent unit
sign choices. No ordering or distinctness is needed for this implication.
The other valuation patterns, their filtering/reduction, and the canonical
all-real five-total bridge remain outside this finite lemma. No complete
five-runner theorem is claimed by this plan.

## Verification status

The symbolic proof and adapter derivation above were saved before execution.
The sole program checks exactly 64,000 ordered triples of the 40 declared
abstract states and all fifteen (j,k) choices on each triple. It counts every
failure and retains only the lexicographically first one; it also retains the
first triple requiring j=3, if any. No speed values, valuations, real times or
integer-speed tuples are enumerated. The source guards concern the local norm
adapters; primary source provenance is the directly retrieved PDF citation.

```python
from hashlib import sha256
from itertools import product
from pathlib import Path
from time import perf_counter_ns

guards = {
    'LonelyRunner/PivotResidues.lean':
        '362da5ab923f22e900ae7ac821dd4cf4aab91dfe70889987bc9e5a05d19c276a',
    'LonelyRunner/StructuredClasses.lean':
        '5328a7a88d2b42f86ffc3f0f0418ca22c761219e8fa3e5822bda5a18ac286e8c',
    'LonelyRunner/RationalMarginCertificates.lean':
        'ffe31ce9636281f6c4b8fc2cdf618043a6c02b0195bf75ff6e0aee65c317c1d9',
}
for path, expected in guards.items():
    assert sha256(Path(path).read_bytes()).hexdigest() == expected, path

carries = ((0,0),(0,1),(1,1),(1,2))
states = tuple(product(range(5),(1,2),range(4)))
choices = tuple(product((1,2,3),range(5)))
assert len(states) == 40 and len(choices) == 15

def good(state,j,k):
    a,r,tag = state
    c = (0,) + carries[tag]
    return (j*a+c[j-1]+j*k*r)%5 in (1,2,3)

def display(triple):
    return tuple((a,r,carries[tag]) for a,r,tag in triple)

started_ns = perf_counter_ns()
rows = attempts = failures = 0
first_failure = first_needs_three = None
first_j_counts = [0,0,0]
min_winners,max_winners = 16,0
for triple in product(states,repeat=3):
    rows += 1
    winners = []
    for j,k in choices:
        attempts += 1
        if all(good(state,j,k) for state in triple):
            winners.append((j,k))
    min_winners = min(min_winners,len(winners))
    max_winners = max(max_winners,len(winners))
    if not winners:
        failures += 1
        if first_failure is None:
            first_failure = display(triple)
    else:
        first_j_counts[winners[0][0]-1] += 1
        if winners[0][0] == 3 and first_needs_three is None:
            first_needs_three = display(triple)
elapsed_ns = perf_counter_ns()-started_ns
assert rows == 64000 and attempts == 960000
assert failures == 0 and first_failure is None
assert sum(first_j_counts) == rows
print('source_guards=3 passed; states=40; ordered_triples=64000')
print('choices_per_triple=15; candidate_attempts=960000')
print('failed_triples=' + str(failures) + '; first_failure=' + str(first_failure))
print('first_j_counts=' + str(tuple(first_j_counts)))
print('winner_count_range=' + str((min_winners,max_winners)))
print('first_needs_j3=' + str(first_needs_three))
print('speed_enumeration=none; Lean_execution=none')
```

Replay from the repository root, without creating a script or output file:

```sh
python3 -B - <<'PY'
from contextlib import redirect_stdout
from hashlib import sha256
from io import StringIO
from pathlib import Path
s = Path('research/astra-five-adic-carry-plan.md').read_text()
assert s.count('```python\n') == 1
program = s.split('```python\n',1)[1].split('```',1)[0]
out, namespace = StringIO(), {}
with redirect_stdout(out):
    exec(compile(program, '<five-adic-carry-contract>', 'exec'), namespace)
print(out.getvalue(), end='')
print('program_sha256=' + sha256(program.encode()).hexdigest())
print('stdout_sha256=' + sha256(out.getvalue().encode()).hexdigest())
print('finite_loop_elapsed_seconds=' + str(namespace['elapsed_ns']/10**9))
PY
```

The exact replay completed with exit 0 and all three source guards passed.
All 64,000 triples passed all-candidate existence testing; the total failed
triple count is **0**, so there is no smallest counterexample. Exactly
960,000 (j,k) candidates were tested. Counts according to the smallest
successful j are `(52,480, 9,600, 1,920)`; the number of successful candidates
per triple ranges from 1 to 9. The first triple requiring j=3 is

```
((0,1,(0,0)), (1,1,(1,1)), (3,1,(0,0))).
```

For this triple j=1 and j=2 both give an untranslated digit set {0,1,3},
which has no containing three-block. At j=3 the set is {0,4}; k=1 moves it
to {3,2}. This is a countercontrol to restricting j to {1,2}, not to (T).

Program SHA-256:
`d11024c4ef750427d3b6826423dc413700fb17582e79cc1a32105122aa6375f4`.
Captured stdout SHA-256:
`03b2a2ec127ba9d22b388a61885b714c3d52d8d1f6b30516644cd6d695855249`.
Program bytes are exactly the sole Python fence contents, including the final
newline. The deterministic stdout hash covers its seven result lines; it
excludes the two hash reports and elapsed-time receipt printed by the wrapper.
The measured finite-loop time was **0.384943562 seconds** on this execution;
it excludes imports/source reads and is not a Lean/kernel benchmark.

`python3 -B scripts/validate_workflow.py` passed as a structural check only.
All commands have stopped; there is no owned running or queued verifier,
Lean, cache-dependent or discovery process. No large output or PDF was saved.

Frozen recommendation: independently review (T) and the integer adapter,
then implement the finite lemma with an enforced kernel resource cap and the
listed arithmetic adapters. This is a concrete bounded alternative to a
speed-height sweep. Whole ordinary five-runner supply still needs the other
valuation cases and the existing canonical bridge to be assembled and checked.
