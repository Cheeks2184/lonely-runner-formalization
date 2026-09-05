# Independent formal review: dense two-cluster witnesses

Disposition: **accept both frozen modules at their stated restricted scope**.
No source defect, missing witness premise, count substitution, or boundary
change was found. Fresh elaboration of both complete bodies and independent
kernel controls passed. This is a family of canonical LRC instances, including
odd total counts; it does not resolve `LonelyRunner.Conjecture`.

The assignment requests Astra/xhigh; that routing is recorded, not independently
attested runtime metadata. Assignment source checkpoint:
`7a5d0d69520a1d290c1dd6c85902488283394d1e`. The project configuration, workflow
documentation, policy, and state were read, including after compaction.
`python3 -B scripts/validate_workflow.py` passed. State remains `research` /
`in_progress`, with no canonical completion. This validator checks records,
not mathematics.

## Frozen inputs and dependency boundary

| Input | SHA-256 |
| --- | --- |
| `LonelyRunner/TwoClusterWitness.lean` (8,384 bytes) | `ba53de4431417ea6b3989aff2e078acef12997b9000b408629a1f329052bb301` |
| `LonelyRunner/TwoClusterFamily.lean` (11,101 bytes) | `05eb795185e08ee7d64aea351764781f7a8d493af1a3000c0cd2826141653915` |
| Accepted `research/astra-dense-paired-blocks.md` | `004ef46bce4e9062fff7e0a78fbba97ea7c732d134214249a04ac993a344c16e` |
| Accepted `research/astra-two-cluster-review.md` | `50ea188ace7ef31ad766146d165b584a0ec19397ec993e293defbff1cd946b5c` |
| `lean-toolchain` | `8e3538e0ab5f81a3ee04927d8838c8c674e0e112838b4b3ce87ec218143276af` |
| `lake-manifest.json` | `887450bc75a38effdae452a14b60f6d225bc10b48c71b3827e3479b800f41218` |

Lean is pinned to `leanprover/lean4:v4.32.1`; mathlib is pinned at
`520045ab14e26149ee970e2e617ca04b09bde5d6`. The core imports the existing
`StructuredClasses` module; the family imports the core. The combined probe
below removes that family import and freshly elaborates both frozen bodies.
It imports no object for either reviewed module. Pinned dependency objects
remain dependencies; this is not a separate rebuild of mathlib or the project.

Only this review was written in the repository. Generators and probes use
distinct `/tmp/endpoint-two-cluster-*` paths. The reviewer did not edit Lean
sources, state, Git, root imports/audit, or shared cache, and did not restore
or clean dependencies. Parent integration/build evidence remains separate.

## Core contract and proof

`twoClusterPhaseCellWitness N M P` assumes exactly

\[
4\le N,\qquad 1\le M<N-2,\qquad M+1\le P,\qquad
M(N-1)\le P(N-2-M).
\]

It supplies a **positive** real time with the **closed** bound
`(N : ℝ)⁻¹ ≤ circleNorm` for `P` and, for every natural `1≤i≤M`, both `i`
and the actual natural speed `P-i`. There is no parity restriction, supplied
witness, minimality, induction, pivot coverage, gcd, or search premise.
At this layer `N` is a threshold parameter, not an assertion that all the
listed low/high speeds have cardinality `N`. The family supplies actual count.

The complete source was inspected. Its helpers have these exact roles:

- `twoClusterPhaseBand` takes `M≤P`, `0≤δ≤1/2`, `δ≤t`, integer phase
  `Pt=k+y`, and `Mt+δ≤y≤1-δ`. Nonnegative time puts every low representative
  `it` and high representative `y-it` in the required closed band. The
  existing integer-band lemma then supplies the circle norm inequalities.
  The proof establishes `i≤P` before casting natural subtraction `P-i`.
- `twoClusterPhaseSupply` takes `M<P`, `0<δ≤1/2`,
  `Pδ≤k+1-δ`, and `Mk≤P(1-2δ)-M(1-δ)`. With
  `A=(k+δ)/(P-M)` and `B=(k+1-δ)/P`, those inequalities give `δ≤B` and
  `A≤B`. Both divisors are positive. Thus `t=max δ A` is positive and at
  most `B`, and `y=Pt-k` satisfies the first helper. These exposed arithmetic
  premises are discharged in the natural wrapper, not hidden witness inputs.

The wrapper uses `q=P/N`, `r=P%N`, `δ=N⁻¹`. It proves `Nq+r=P`, `r<N`,
`Pδ=q+rδ`, and `Pδ≤q+1-δ`. Multiplying the uniform budget by `δ>0` gives

\[
M(1-\delta)\le P(1-2\delta-M\delta).
\]

Together with `q≤Pδ`, this gives `Mq≤P(1-2δ)-M(1-δ)`, the other supply
premise. Bounds justify casts of `N-1` and `N-2-M` before real subtraction
is used. `M+1≤P` makes every high speed positive. Quotient, remainder, and
real division are kept distinct.

This source exports the manuscript's **sufficient uniform condition**, not
the general-`a0` interval iff, exact residue iff, zero-width classification,
or a named-time correctness theorem. The proof constructs a time and the
controls check fixed times; no additional public named-time theorem is
claimed. Failure of the uniform condition does not exclude other phase cells
or LRC witnesses.

## Finite family and canonical bridge

For finite positive offset sets `A,B⊆{1,...,M}`, the definition is

\[
T=(\{0\}\cup A)\cup\{p-b:b\in\{0\}\cup B\}.
\]

`card_twoClusterSpeeds` needs only those offset bounds and `2M+1≤p`.
Neither offset set contains zero. The reflection is injective on `{0}∪B`
because its offsets are at most `p`; the natural subtraction involution
is applied with that bound. Lower speeds are at most `M`, and upper speeds
are at least `p-M≥M+1`, so the actual clusters are disjoint. The result is
`|T|=|A|+|B|+2`. Offset overlap `A∩B` is permitted. The theorem does not
assume the cardinality it proves.

`twoClusterLowerRunner` keeps independent parameter `N` and only requires
the reference `r≤M`, deliberately without requiring `r∈T`. Its uniform
budget is `M(N-1)≤(p-M)(N-2-M)`. Setting `P=p-r` gives
`P≥p-M≥M+1`, and the positive factor `N-2-M` preserves the budget.
For every **original** `s∈T`, `s≠r`, a low difference has nonzero magnitude
at most `M`; an upper speed `p-b` contributes `P-b`, or `P` for `b=0`.
The source handles negative differences through `circleNorm_neg` and proves
all natural-subtraction cast bounds. Repeated absolute magnitudes are not
deduplicated; the denominator remains `N`.

`twoClusterRunnerWitness` takes an actual original runner `r∈T`. For upper
`r`, reflection gives `p-r≤M` in the **swapped** family
`twoClusterSpeeds B A p`. The source does not identify unequal `A,B`.
Membership proves `s,r≤p`, so reflection preserves distinctness, and the
real relative phase changes sign:

\[
(p-s)-(p-r)=-(s-r).
\]

Evenness of the circle norm returns the original signed comparison. This
argument does not mistake a changed distinguished runner for a stationary
witness for a different configuration.

`twoClusterLonelyAt` uses `N=A.card+B.card+2` in its domain and assumptions.
For **any** injective `speeds : Fin N → ℕ` with all values in `T`, and
**every** runner, it supplies positive time satisfying the existing
`LonelyAt (fun i => (speeds i : ℝ)) runner t`. The definitions and proof of
`lonelyAt_iff_relativeLonelyAt` were read: they keep the same `Fin N`, all
other labels, and the closed metric threshold. Natural injectivity implies
real cast injectivity. No supplied witness or extra count hypothesis enters.

The generic kernel probe `endpointReview_clusterNonvacuous` constructs an
enumeration from `Finset.equivFinOfCardEq` using the source card theorem.
It proves natural and real injectivity, membership, **surjectivity onto the
entire original set**, then applies the canonical theorem. Thus the labelling
contract is not vacuous. Fixed odd counts include `5,7,9,1001`. The accepted
manuscript's every-`N≥4` examples use `M=N-3`, `A={1,...,M}`, `B={1}`,
`p=N(N-3)`; the probe checks the large `N=1001` instance without claiming
the source exports a separate universal example theorem.

## Fresh compilation and controls

All commands ran from `/home/joshua/lonely-runner-formalization`:

```sh
python3 -B scripts/validate_workflow.py
/home/joshua/.elan/bin/lake env lean LonelyRunner/TwoClusterWitness.lean
/home/joshua/.elan/bin/lake env lean /tmp/endpoint-two-cluster-core-review.lean
/home/joshua/.elan/bin/lake env lean LonelyRunner/TwoClusterFamily.lean
/home/joshua/.elan/bin/lake env lean /tmp/endpoint-two-cluster-family-review.lean
```

Every command exited zero. Direct source compilations and the core probe
had no warnings/errors. The combined probe emitted only unused
`Finset.mem_insert` simp-argument warnings in reviewer-generated singleton
proofs. No reviewed source warning, error, or missing proof was reported.
Those successful probe bytes are bound below; no warning was suppressed
and no reviewed source was changed to pass a probe.

The core probe starts with the complete 8,384-byte source. It checks a generic
honest-contract wrapper, ten fixed parameter instances, 45 exact original-speed
phase bounds, seven uniform-budget equalities, and six invalid-hypothesis
exclusions. Cases include `N=4`, `P=M+1`, odd counts, `N=1001`, and two
21-digit `P` values with different residues. Two additional helper controls
use `N=5,M=2,P=6`: the uniform budget fails but the real supply succeeds,
and `t=3/10,y=4/5` attains both phase-cell bounds at equality. These show
that the sufficient condition is not silently promoted to necessity.

The fresh combined probe checks nine fixed small-offset families with 56
all-runner applications and 310 exact signed original-speed bounds: 155
negative comparisons, 65 threshold equalities, and 19 repeated-magnitude
occurrences within a runner's comparison list. Six of those families have
odd count and eight meet growth at equality. An additional large-cardinality
`N=1001,M=998,p=998998` example checks actual card and a complete canonical
labelling, also at growth equality. These are fixed controls, not tuple
discovery or a substitute for the generic proof.

The reflection control `A={1,2},B={1},p=10` has `2` only in the original
set and `8` only in the swapped set. Dropping separation permits a collision
and changes the expected count. Two below-budget controls are arithmetically
excluded. Invalid-hypothesis controls assert failure of assumptions, never
failure of LRC.

Every `#print axioms` report is exactly
`[propext, Classical.choice, Quot.sound]`:

- Core probe: the three core theorems and `endpointReview_fullCore` (four).
- Combined probe: those three source theorems, `twoClusterSpeeds`,
  `card_twoClusterSpeeds`, `twoClusterSpeeds_member_le`,
  `twoClusterSpeeds_reflect_mem`, `mem_twoClusterSpeeds_reflect_iff`,
  `twoClusterLowerRunner`, `twoClusterRunnerWitness`, `twoClusterLonelyAt`,
  and `endpointReview_clusterNonvacuous` (12).

All controls use ordinary `omega`, `norm_num`, and checked theorem application.
No `sorry`, `admit`, custom axiom, or unchecked computation is introduced.
Python constructs exact rational fixtures and Lean text; it supplies no
trusted proof result to Lean. All generic source bodies and control assertions
are freshly elaborated by Lean.

## Exact standalone replay generators

The first block generates the core probe with required SHA-256
`07a2ad3a6e640cb18007eee6016d430c525f526fecff905f6b6aa89f8f226cc8`.

```python
from pathlib import Path
from hashlib import sha256
from fractions import Fraction as F
from math import floor
src=Path('LonelyRunner/TwoClusterWitness.lean').read_bytes()
assert sha256(src).hexdigest()=='ba53de4431417ea6b3989aff2e078acef12997b9000b408629a1f329052bb301'
parts=[src.decode(),'\nopen LonelyRunner\n']
for name in ['twoClusterPhaseBand','twoClusterPhaseSupply','twoClusterPhaseCellWitness']:
    parts.append(f'#print axioms LonelyRunner.{name}\n')
parts.append('''
def EndpointReviewCoreContract (N M P : ℕ) : Prop :=
  ∃ t : ℝ, 0 < t ∧ (1 / (N : ℝ)) ≤ circleNorm (t * (P : ℝ)) ∧
    ∀ i : ℕ, 1 ≤ i → i ≤ M →
      (1 / (N : ℝ)) ≤ circleNorm (t * (i : ℝ)) ∧
      (1 / (N : ℝ)) ≤ circleNorm (t * ((P-i : ℕ) : ℝ))

theorem endpointReview_fullCore (N M P : ℕ) (hN : 4 ≤ N) (hM : 1 ≤ M)
    (hwidth : M+2 < N) (hP : M < P)
    (hgrowth : M*(N-1) ≤ P*(N-(M+2))) : EndpointReviewCoreContract N M P := by
  have hsub : N-2-M = N-(M+2) := by omega
  simpa [EndpointReviewCoreContract, one_div] using
    twoClusterPhaseCellWitness N M P hN hM (by omega) (by omega)
      (by simpa [hsub] using hgrowth)
#print axioms endpointReview_fullCore

def EndpointReviewCoreAssumptions (N M P : ℕ) : Prop :=
  4 ≤ N ∧ 1 ≤ M ∧ M < N-2 ∧ M+1 ≤ P ∧ M*(N-1) ≤ P*(N-2-M)
''')
fixtures=[(4,1,3),(5,1,2),(5,2,8),(5,2,10),(6,3,15),
          (7,4,24),(9,6,48),(1001,997,498500),
          (7,4,7*10**20+4),(7,4,7*10**20+6)]
phases=equalities=0
for N,M,P in fixtures:
    assert 4<=N and 1<=M<N-2 and M<P and M*(N-1)<=P*(N-2-M)
    k=P//N
    t=max(F(1,N),(F(k)+F(1,N))/(P-M))
    parts.append(f'''\nexample : EndpointReviewCoreContract {N} {M} {P} :=
  endpointReview_fullCore {N} {M} {P} (by omega) (by omega)
    (by omega) (by omega) (by omega)
''')
    if M*(N-1)==P*(N-2-M):
        parts.append(f'example : ({M} : ℕ)*({N}-1) = {P}*({N}-2-{M}) := by norm_num\n')
        equalities+=1
    for a in sorted({1,M,P-M,P-1,P}):
        q=floor(a*t)
        parts.append(f'''example : (1 / {N} : ℝ) ≤ circleNorm (({t.numerator} / {t.denominator} : ℝ)*{a}) := by
  apply circleNorm_ge_of_int_band {q}
  all_goals norm_num
''')
        phases+=1
invalid=[(3,1,10),(5,0,10),(5,3,9),(7,4,4),(5,2,6),(5,4,1000)]
for N,M,P in invalid:
    parts.append(f'''example : ¬ EndpointReviewCoreAssumptions {N} {M} {P} := by
  norm_num [EndpointReviewCoreAssumptions]
''')
parts.append('''
-- The real supply may apply even when the sufficient uniform budget fails.
example : EndpointReviewCoreContract 5 2 6 := by
  have h := twoClusterPhaseSupply (M := 2) (P := 6) (by omega)
    (1/5 : ℝ) 1 (by norm_num) (by norm_num) (by norm_num) (by norm_num)
  simpa [EndpointReviewCoreContract] using h
-- Both phase-cell edges are attained in this exact residue-boundary control.
example : (1/5 : ℝ) ≤ circleNorm ((3/10 : ℝ)*6) ∧
    ∀ i : ℕ, 1 ≤ i → i ≤ 2 →
      (1/5 : ℝ) ≤ circleNorm ((3/10 : ℝ)*(i : ℝ)) ∧
      (1/5 : ℝ) ≤ circleNorm ((3/10 : ℝ)*((6-i : ℕ) : ℝ)) := by
  exact twoClusterPhaseBand (by omega : 2 ≤ 6) (3/10) (1/5) (4/5) 1
    (by norm_num) (by norm_num) (by norm_num) (by norm_num)
    (by norm_num) (by norm_num)
''')
path=Path('/tmp/endpoint-two-cluster-core-review.lean')
path.write_text(''.join(parts))
assert sha256(path.read_bytes()).hexdigest()=='07a2ad3a6e640cb18007eee6016d430c525f526fecff905f6b6aa89f8f226cc8'
print({'source_bytes':len(src),'fixtures':len(fixtures),'phase_controls':phases,
       'uniform_equalities':equalities,'invalid_hypothesis_controls':len(invalid),
       'probe_sha256':sha256(path.read_bytes()).hexdigest()})
```

The second block generates the fresh combined-source family probe with SHA-256
`87b0d9e3641f5d8cda65f988e00157e54d0322cbd40258fc5b778c753349ac04`.

```python
from pathlib import Path
from hashlib import sha256
from fractions import Fraction as F
from math import floor
core=Path('LonelyRunner/TwoClusterWitness.lean').read_bytes()
family=Path('LonelyRunner/TwoClusterFamily.lean').read_bytes()
assert sha256(core).hexdigest()=='ba53de4431417ea6b3989aff2e078acef12997b9000b408629a1f329052bb301'
assert sha256(family).hexdigest()=='05eb795185e08ee7d64aea351764781f7a8d493af1a3000c0cd2826141653915'
assert family.startswith(b'import LonelyRunner.TwoClusterWitness\n')
# Lean imports must precede both declaration bodies. Retain the full core,
# adding the probe-only import immediately after its original import.
parts=[core.decode().replace('import LonelyRunner.StructuredClasses\n',
 'import LonelyRunner.StructuredClasses\nimport Mathlib.Data.Fintype.EquivFin\nimport Mathlib.Order.Interval.Finset.Nat\n',1),
 family[len(b'import LonelyRunner.TwoClusterWitness\n'):].decode(),'\nopen LonelyRunner\n']
names=['twoClusterPhaseBand','twoClusterPhaseSupply','twoClusterPhaseCellWitness',
 'twoClusterSpeeds','card_twoClusterSpeeds','twoClusterSpeeds_member_le',
 'twoClusterSpeeds_reflect_mem','mem_twoClusterSpeeds_reflect_iff',
 'twoClusterLowerRunner','twoClusterRunnerWitness','twoClusterLonelyAt']
for name in names:
    parts.append(f'#print axioms LonelyRunner.{name}\n')
parts.append('''
def EndpointReviewClusterLabelledProperty (A B : Finset ℕ) (p : ℕ) : Prop :=
  ∃ speeds : Fin (A.card+B.card+2) → ℕ,
    Function.Injective speeds ∧
    Function.Injective (fun i => (speeds i : ℝ)) ∧
    (∀ i, speeds i ∈ twoClusterSpeeds A B p) ∧
    (∀ s, s ∈ twoClusterSpeeds A B p → ∃ i, speeds i = s) ∧
    ∀ runner, ∃ t : ℝ, 0 < t ∧ LonelyAt (fun i => (speeds i : ℝ)) runner t

theorem endpointReview_clusterNonvacuous (A B : Finset ℕ) (M p : ℕ)
    (hA : ∀ a, a ∈ A → 1 ≤ a ∧ a ≤ M)
    (hB : ∀ b, b ∈ B → 1 ≤ b ∧ b ≤ M)
    (hN : 4 ≤ A.card+B.card+2) (hM : 1 ≤ M)
    (hMN : M < (A.card+B.card+2)-2) (hp : 2*M+1 ≤ p)
    (hg : M*((A.card+B.card+2)-1) ≤
      (p-M)*((A.card+B.card+2)-2-M)) :
    EndpointReviewClusterLabelledProperty A B p := by
  classical
  let e : twoClusterSpeeds A B p ≃ Fin (A.card+B.card+2) :=
    Finset.equivFinOfCardEq (card_twoClusterSpeeds A B M p hA hB hp)
  let speeds : Fin (A.card+B.card+2) → ℕ := fun i => (e.symm i).val
  have hinj : Function.Injective speeds := by
    intro i j hij
    apply e.symm.injective
    apply Subtype.ext
    exact hij
  have hreal : Function.Injective (fun i => (speeds i : ℝ)) := by
    intro i j hij
    apply hinj
    change (speeds i : ℝ) = (speeds j : ℝ) at hij
    exact_mod_cast hij
  have hmem : ∀ i, speeds i ∈ twoClusterSpeeds A B p := by
    intro i
    exact (e.symm i).property
  have honto : ∀ s, s ∈ twoClusterSpeeds A B p → ∃ i, speeds i = s := by
    intro s hs
    refine ⟨e ⟨s, hs⟩, ?_⟩
    simp [speeds]
  exact ⟨speeds, hinj, hreal, hmem, honto,
    twoClusterLonelyAt A B M p hA hB hN hM hMN hp hg speeds hinj hmem⟩

#print axioms endpointReview_clusterNonvacuous
''')
def fs(xs):
    return '({' + ','.join(map(str,xs)) + '} : Finset ℕ)'
def oldproof():
    return '(by intro a ha; simp only [Finset.mem_insert, Finset.mem_singleton] at ha; omega)'
fixtures=[(1,(1,),(1,),4), (2,(1,2),(1,),10), (2,(1,),(1,2),10),
 (3,(1,3),(2,3),18), (4,(1,2,4),(1,3),28), (2,(1,2),(1,2),7),
 (3,(1,2,3),(1,3),12), (6,(1,2,3,4,5,6),(1,),54),
 (4,(1,2,4),(1,3),7*10**20+4)]
c=dict(families=len(fixtures),runners=0,signed_pairs=0,negative_pairs=0,
       closed_equalities=0,duplicate_magnitudes=0,odd_families=0,growth_equalities=0)
for M,A,B,p in fixtures:
    N=len(A)+len(B)+2
    T=sorted({0,*A,*(p-b for b in B),p})
    assert len(T)==N and 4<=N and M<N-2 and 2*M+1<=p
    assert M*(N-1)<=(p-M)*(N-2-M)
    c['odd_families']+=N%2
    c['growth_equalities']+=M*(N-1)==(p-M)*(N-2-M)
    sa,sb=fs(A),fs(B)
    bounds=oldproof()+' '+oldproof()
    parts.append(f'''\nexample : (twoClusterSpeeds {sa} {sb} {p}).card = {N} := by
  simpa using card_twoClusterSpeeds {sa} {sb} {M} {p} {bounds} (by omega)
example : EndpointReviewClusterLabelledProperty {sa} {sb} {p} := by
  exact endpointReview_clusterNonvacuous {sa} {sb} {M} {p} {bounds}
    (by norm_num) (by omega) (by norm_num) (by omega) (by norm_num)
''')
    for r in T:
        c['runners']+=1
        u=r if r<=M else p-r
        P=p-u
        t=max(F(1,N),(F(P//N)+F(1,N))/(P-M))
        assert t>0
        parts.append(f'''example : ∃ t : ℝ, 0 < t ∧ ∀ s : ℕ,
    s ∈ twoClusterSpeeds {sa} {sb} {p} → s ≠ {r} →
    (1 / {N} : ℝ) ≤ circleNorm (t * ((s : ℝ)-{r})) := by
  simpa using twoClusterRunnerWitness {sa} {sb} {N} {M} {p} {bounds}
    (by omega) (by omega) (by omega) (by omega) (by omega) {r}
    (by norm_num [twoClusterSpeeds])
''')
        ds=[s-r for s in T if s!=r]
        c['duplicate_magnitudes']+=len(ds)-len(set(map(abs,ds)))
        for d in ds:
            x=t*d
            norm=min(x%1,(-x)%1)
            assert norm>=F(1,N),(M,A,B,p,r,d,t,norm)
            c['signed_pairs']+=1
            c['negative_pairs']+=d<0
            c['closed_equalities']+=norm==F(1,N)
            parts.append(f'''example : (1/{N} : ℝ) ≤ circleNorm (({t.numerator}/{t.denominator} : ℝ)*({d})) := by
  apply circleNorm_ge_of_int_band ({floor(x)})
  all_goals norm_num
''')
# Large-cardinality boundary fixture: total N=1001 (odd), M=N-3, p=N*M.
parts.append('''
example : (twoClusterSpeeds (Finset.Icc 1 998) {1} 998998).card = 1001 := by
  have h := card_twoClusterSpeeds (Finset.Icc 1 998) {1} 998 998998
    (by intro a ha; exact Finset.mem_Icc.mp ha)
    (by intro a ha; simp only [Finset.mem_singleton] at ha; omega) (by omega)
  simpa using h
example : EndpointReviewClusterLabelledProperty (Finset.Icc 1 998) {1} 998998 := by
  apply endpointReview_clusterNonvacuous (Finset.Icc 1 998) {1} 998 998998
  · intro a ha; exact Finset.mem_Icc.mp ha
  · intro a ha; simp only [Finset.mem_singleton] at ha; omega
  all_goals norm_num
-- Swapping unequal offset sets changes the set; reflection changes roles.
example : 2 ∈ twoClusterSpeeds ({1,2} : Finset ℕ) {1} 10 ∧
    2 ∉ twoClusterSpeeds ({1} : Finset ℕ) {1,2} 10 ∧
    8 ∈ twoClusterSpeeds ({1} : Finset ℕ) {1,2} 10 ∧
    8 ∉ twoClusterSpeeds ({1,2} : Finset ℕ) {1} 10 := by
  norm_num [twoClusterSpeeds]
-- Removing separation can create collisions and lose the expected count.
example : (twoClusterSpeeds ({1,2} : Finset ℕ) {2} 4).card = 4 := by
  norm_num [twoClusterSpeeds]
example : ¬ (2*2+1 ≤ (4 : ℕ)) := by omega
-- Growth below the uniform boundary is excluded, not a counterexample.
example : ¬ ((2 : ℕ)*(5-1) ≤ (9-2)*(5-2-2)) := by omega
example : ¬ ((1 : ℕ)*(4-1) ≤ (3-1)*(4-2-1)) := by omega
''')
path=Path('/tmp/endpoint-two-cluster-family-review.lean')
path.write_text(''.join(parts))
assert sha256(path.read_bytes()).hexdigest()=='87b0d9e3641f5d8cda65f988e00157e54d0322cbd40258fc5b778c753349ac04'
print(dict(c,large_labelled_fixtures=1,source_family_bytes=len(family),
           probe_sha256=sha256(path.read_bytes()).hexdigest()))
```

Both generators verify their source and resulting probe hashes. Their
printed counts are respectively:

```text
source_bytes=8384; fixtures=10; phase_controls=45;
uniform_equalities=7; invalid_hypothesis_controls=6.
families=9; runners=56; signed_pairs=310; negative_pairs=155;
closed_equalities=65; duplicate_magnitudes=19; odd_families=6;
growth_equalities=8; large_labelled_fixtures=1; source_family_bytes=11101.
```

To extract the generators, run this shell command from the repository,
then the Lean commands above:

```sh
python3 -B - <<'PY'
from pathlib import Path
import re
text=Path('research/astra-two-cluster-formal-review.md').read_text()
blocks=re.findall(r'^```python\n(.*?)^```[ \t]*$',text,re.M|re.S)
assert len(blocks)==2
for i,code in enumerate(blocks):
    exec(compile(code,f'two-cluster-review-generator-{i}','exec'),{})
PY
```

The generators were replayed from this saved manuscript and reproduced the
exact already-successful Lean probe hashes. Source bindings were rechecked
unchanged. At freeze, all reviewer Lean/probe/generator commands had
terminated. No further reviewer build, restoration, cleanup, source edit,
or search is queued. Parent full-project integration and publication remain
separate. The unrestricted LRC proof/disproof goal remains unresolved.
