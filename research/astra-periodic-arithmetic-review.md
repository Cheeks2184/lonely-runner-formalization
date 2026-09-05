# Independent review: periodic counts and N=7 arithmetic helpers

Task `/root/affine_grid-periodic-arithmetic-review`, requested Astra/xhigh,
2026-09-05. Source base reported by the orchestrator:
`a25799bfbbb41b4c31f222b25060a4d6e0e5d117`.
The current project workflow/policy/state were read and the structural validator
passed. Only this review note was edited; no cache restoration/cleanup, source,
Git, state, or root-import changes were made.

**ACCEPT, without source correction**, these exact frozen files:

```text
a6199b77071b81868abffe0959c1b5aa4e64a06369adb93eddbc2fa7b6c90b7e  LonelyRunner/PeriodicPivotCounts.lean
1f05a8f42c2d49b86e3d234cbd72b01e9b3b30d75549b133aad030f51a61455a  LonelyRunner/ThreeOwnerSevenArithmetic.lean
```

I read both complete files, independently compiled each exact source, checked
the eight exported types and their axiom dependencies, and ran the controls
below. These are three generic counting theorems and five arithmetic helpers.
They do **not** constitute the full three-owner theorem, which is being
implemented separately and was not inspected here. They supply neither a
universal owner certificate nor LRC.

## 1. Generic periodic counts: full contract and proof audit

All declarations have namespace `LonelyRunner` and natural-number inputs.

1. `card_filter_range_mul_mod_coprime`: for `L>0`, `Coprime L a`, and
   `S subset range L`,
   `card{r<L : (r*a)%L in S}=card S`. There is no bound on a, and a=0 is
   valid when L=1. Multiplication modulo L permutes the range: the source uses
   the existing exact image-of-multiplication theorem for surjectivity and
   cancellation modulo `L/gcd(L,a)` for injectivity. It restricts this
   bijection to the preimage of S. The subset premise is retained correctly.
2. `card_filter_range_mod_mem`: for any `g:Nat`, `L>0`, and the same S,
   `card{r<gL : r%L in S}=g*card S`. The proof invokes the existing complete-
   block bijection and identifies the first block with S. Zero blocks and an
   empty set are included; no positivity assumption on g is added.
3. `card_filter_pivotCandidates_mod_mem`: for `N>0`, `L>0`, `L divides p`,
   `Coprime L N`, and `S subset range L`,

   ```text
   card{r in pivotCandidates N p : r%L in S}
       = (N-1)*(p/L)*card S.                            (1)
   ```

The last theorem has **no p>0 or Coprime p N premise**. Let m=p/L. The source
counts A, all relevant residues below Np, as `N*m*card S`. Its deleted set D
is exactly the image under `q -> N*q` of

```text
Q={0<=q<p : (q*N)%L in S}.
```

The map is injective because N>0, and the strict upper ranges correspond
exactly. The periodic-block count and invertibility of N modulo L give
`|Q|=m*|S|`. Hence D has that cardinality. The literal filtered candidate set
is A\D, and natural subtraction yields `(N-1)*m*|S|`, including N=1 and m=0.
No unsupported projection/intersection identity or assumption about p's
coprimality is used.

Important edge scopes are preserved:

- N=1 excludes every residue and gives zero on both sides.
- p=0 is allowed since every positive L divides zero; both ranges are empty.
- L=1, including S={0}, recovers `(N-1)*p`.
- S=empty gives zero.
- For N=7,p=56,L=8,S={0,1,7}, (1) gives 126 despite `gcd(N,p)=7`.
- Composite N and arbitrary coprime periods are admitted: N=6,p=70,L=5
  gives 210 for S={0,2,4}; N=4,p=6,L=3 gives 12 for S={0,2}.

The helper counts a **supplied** periodic predicate. A later overlap proof
must still establish the residue pattern S, `L divides p`, and `Coprime L N`.
This review does not infer those premises for arbitrary bad-set remainders.

## 2. Arithmetic helper audit

Write `b_k(P)=normalizedBadCount 7 k P`, with the source's natural
subtractions. The five complete public contracts are:

| Declaration | Exact hypotheses and conclusion |
| --- | --- |
| `normalizedBadCount_seven_seven` | Every P, including zero: `b_7(P)=6*(2*((P-1)/7)+1)`. |
| `normalizedBadCount_seven_one_bound` | P>0: `7*b_1(P)<=12*P`. |
| `normalizedBadCount_seven_seven_bound` | P>=8: `4*b_7(P)<=9*P`. |
| `normalizedBadCount_seven_seven_le_two` | P>=9: `b_7(P)<=2*P`. |
| `normalizedBadCount_seven_seven_lt_remainder_budget` | P>=9 and P different from 9,15,16,22: `8*b_7(P)<15*P`. |

The first identity is total: at P=0, both sides equal 6. This value is not an
actual lower-owner cardinality claim; an application of the normalized-count
adapter must supply its separate arithmetic hypotheses. None of these five
lemmas assumes `7 does not divide P`, a normalized owner D, or coprimality.
The stronger arithmetic domains are sound.

The source uses only simplification and `omega`. An independent quotient
check explains the inequalities. For P>0 let `P-1=7q+s`, `0<=s<=6`.
Then `b_1=12q+2s`, proving its bound by `2s<=12`. Also
`b_7=12q+6`. When P>=8, q>=1 and
`4(12q+6)<=9(7q+1)<=9P`. For the twice-P bound, q=1 is handled by
P>=9; for q>=2, `12q+6<=2(7q+1)`.
For the strict budget, q=1,2,3 need respectively P>=10,17,23 after the
listed exclusions; q>=4 gives `96q+48<105q+15` because `33<9q`.

The exclusions matter separately. At P=9,15,22 the forbidden strict
comparison fails; at P=16 it is **equality**, `8*b_7(16)=15*16=240`.
The coarse bound is also equality at P=8, and the twice-P bound is equality
at P=9 and P=15. These are retained, not perturbed or rounded away.

## 3. Independent kernel and axiom evidence

Fresh source checks were run separately, using the already available shared
pinned dependencies:

```sh
PATH="$HOME/.elan/bin:$PATH" lake env lean LonelyRunner/PeriodicPivotCounts.lean
PATH="$HOME/.elan/bin:$PATH" lake env lean LonelyRunner/ThreeOwnerSevenArithmetic.lean
```

Both exited 0 with no output. A separate stdin import checked all eight types
and printed their axioms. The three periodic theorems use exactly
`[propext, Classical.choice, Quot.sound]`; each of the five arithmetic theorems
uses exactly `[propext, Quot.sound]`. No `sorryAx`, custom axiom, `native_decide`,
or other computational trust extension appears. The source scan likewise
found no sorry/admit/custom-axiom/unsafe declaration in either reviewed file.
The local uses of `classical` are ordinary permitted classical reasoning.

The following 20 semantic probes also compiled, exit 0. Linter suggestions
occurred in the disposable probe (mostly simplifications of degenerate cases),
not errors or warnings in either frozen source. The literal finite probes use
kernel `decide`, not `native_decide`.

```lean
import LonelyRunner.PeriodicPivotCounts
import LonelyRunner.ThreeOwnerSevenArithmetic
open LonelyRunner Finset
#check card_filter_range_mul_mod_coprime
#check card_filter_range_mod_mem
#check card_filter_pivotCandidates_mod_mem
#check normalizedBadCount_seven_seven
#check normalizedBadCount_seven_one_bound
#check normalizedBadCount_seven_seven_bound
#check normalizedBadCount_seven_seven_le_two
#check normalizedBadCount_seven_seven_lt_remainder_budget
#print axioms card_filter_range_mul_mod_coprime
#print axioms card_filter_range_mod_mem
#print axioms card_filter_pivotCandidates_mod_mem
#print axioms normalizedBadCount_seven_seven
#print axioms normalizedBadCount_seven_one_bound
#print axioms normalizedBadCount_seven_seven_bound
#print axioms normalizedBadCount_seven_seven_le_two
#print axioms normalizedBadCount_seven_seven_lt_remainder_budget

example (N p : Nat) (hN : 0 < N) :
    ((pivotCandidates N p).filter fun r => r % 1 ∈ ({0} : Finset Nat)).card =
      (N-1)*p := by
  simpa using card_filter_pivotCandidates_mod_mem N p 1 hN (by decide)
    (one_dvd p) (by simp) {0} (by decide)
example (p L : Nat) (hL : 0 < L) (hLp : L ∣ p)
    (S : Finset Nat) (hS : S ⊆ range L) :
    ((pivotCandidates 1 p).filter fun r => r % L ∈ S).card = 0 := by
  simpa using card_filter_pivotCandidates_mod_mem 1 p L (by decide) hL hLp
    (by simp) S hS
example (N L : Nat) (hN : 0 < N) (hL : 0 < L)
    (hcop : Nat.Coprime L N) (S : Finset Nat) (hS : S ⊆ range L) :
    ((pivotCandidates N 0).filter fun r => r % L ∈ S).card = 0 := by
  simpa using card_filter_pivotCandidates_mod_mem N 0 L hN hL (dvd_zero L)
    hcop S hS
example (N p L : Nat) (hN : 0 < N) (hL : 0 < L) (hLp : L ∣ p)
    (hcop : Nat.Coprime L N) :
    ((pivotCandidates N p).filter fun r => r % L ∈ (∅ : Finset Nat)).card = 0 := by
  simpa using card_filter_pivotCandidates_mod_mem N p L hN hL hLp hcop ∅
    (empty_subset (range L))
example : ((pivotCandidates 7 56).filter fun r => r % 8 ∈ ({0,1,7} : Finset Nat)).card = 126 := by
  simpa using card_filter_pivotCandidates_mod_mem 7 56 8 (by decide) (by decide)
    (by decide) (by decide) {0,1,7} (by decide)
example : ((pivotCandidates 6 70).filter fun r => r % 5 ∈ ({0,2,4} : Finset Nat)).card = 210 := by
  simpa using card_filter_pivotCandidates_mod_mem 6 70 5 (by decide) (by decide)
    (by decide) (by decide) {0,2,4} (by decide)
example : ((pivotCandidates 4 6).filter fun r => r % 3 ∈ ({0,2} : Finset Nat)).card = 12 := by decide
example : ((range 1).filter fun r => r*0 % 1 ∈ ({0} : Finset Nat)).card = 1 := by
  simpa using card_filter_range_mul_mod_coprime 1 0 (by decide) (by decide)
    {0} (by decide)
example : ((range (0*5)).filter fun r => r % 5 ∈ ({1,4} : Finset Nat)).card = 0 := by
  simpa using card_filter_range_mod_mem 0 5 (by decide) {1,4} (by decide)
example : ((range (3*5)).filter fun r => r % 5 ∈ ({1,4} : Finset Nat)).card = 6 := by decide
example : normalizedBadCount 7 7 0 = 6 := by simpa using normalizedBadCount_seven_seven 0
example : normalizedBadCount 7 7 8 = 18 := by decide
example : 4*normalizedBadCount 7 7 8 = 9*8 := by decide
example : normalizedBadCount 7 7 9 = 2*9 := by decide
example : normalizedBadCount 7 7 15 = 2*15 := by decide
example : 8*normalizedBadCount 7 7 16 = 15*16 := by decide
example : ¬8*normalizedBadCount 7 7 9 < 15*9 := by decide
example : ¬8*normalizedBadCount 7 7 15 < 15*15 := by decide
example : ¬8*normalizedBadCount 7 7 22 < 15*22 := by decide
example : 8*normalizedBadCount 7 7 23 < 15*23 := by
  exact normalizedBadCount_seven_seven_lt_remainder_budget 23
    (by decide) (by decide) (by decide) (by decide) (by decide)
```

This block can be sent to `PATH="$HOME/.elan/bin:$PATH" lake env lean --stdin`.
The orchestrator separately reported the targeted 3,010-job build; that was
not rerun or substituted for these independent exact-source checks.

## 4. Independent exact arithmetic controls

The self-contained standard-library block below uses literal residue lists
and histograms, without importing a project checker. It covers every subset
of periods L=1..10, all unit multipliers `0<=a<2L+4`, block counts g=0..6,
and candidate parameters N=1..12 with `gcd(L,N)=1`, p=L*m, m=0..6.
The histogram is formed by enumerating the actual candidate residues before
checking each subset. The arithmetic domain is P=0..10000 plus seven values
around `7*10^100`. Six false generalizations and all four strict exceptional
denominators are tested independently.

```python
from math import gcd

def subsets(L):
    return [frozenset(r for r in range(L) if mask >> r & 1)
            for mask in range(1 << L)]

def norm(N,k,P):
    x=max(P-1,0)
    return max(k*(2*(x//k)+1)-(2*(x//N)+1),0)

perm=blocks=periodic=0
for L in range(1,11):
    ss=subsets(L)
    for a in range(0,2*L+4):
        if gcd(L,a)!=1:
            continue
        image=[r*a % L for r in range(L)]
        for S in ss:
            assert sum(x in S for x in image)==len(S)
            perm+=1
    for g in range(0,7):
        hist=[sum(r % L==s for r in range(g*L)) for s in range(L)]
        for S in ss:
            assert sum(hist[s] for s in S)==g*len(S)
            blocks+=1
    for N in range(1,13):
        if gcd(L,N)!=1:
            continue
        for m in range(0,7):
            p=L*m
            hist=[0]*L
            for r in range(N*p):
                if r % N:
                    hist[r % L]+=1
            for S in ss:
                assert sum(hist[s] for s in S)==(N-1)*m*len(S)
                periodic+=1

vals=list(range(0,10001))+[7*10**100+s for s in range(1,8)]
for P in vals:
    b=norm(7,7,P)
    assert b==6*(2*(max(P-1,0)//7)+1)
    if P>0:
        assert 7*norm(7,1,P)<=12*P
    if P>=8:
        assert 4*b<=9*P
    if P>=9:
        assert b<=2*P
    if P>=9 and P not in (9,15,16,22):
        assert 8*b<15*P
assert norm(7,7,0)==6
for P in (9,15,16,22):
    assert not 8*norm(7,7,P)<15*P

count=lambda N,p,L,S: sum(r % N!=0 and r % L in S for r in range(N*p))
assert count(6,2,2,{0})==4 != (6-1)*(2//2)  # omitted coprimality L,N
assert count(3,5,2,{0})==5 != (3-1)*(5//2)  # omitted L|p
assert sum(r % 3 in {3} for r in range(3))==0 != 1  # S outside the period
assert count(7,56,8,{0,1,7})==126 != 7*(56//8)*3  # omitted deleted sheet
assert 4*norm(7,7,2)>9*2  # omitted arithmetic lower bound
assert sum((r*2)%4==0 for r in range(4))==2 != 1  # nonunit multiplier
assert (perm,blocks,periodic,len(vals))==(22732,14322,90608,10008)
print({'permutation_subsets':perm,'block_subsets':blocks,
       'candidate_subsets':periodic,'arithmetic_P_values':len(vals),
       'endpoint_exceptions':4,'mutation_controls':6})
```

These finite tests corroborate the independently checked proofs; they are not
the reason the unrestricted helper statements are accepted.

## 5. Dependency bindings and conclusion

The directly inspected predecessor statements in `PivotCounts.lean` are
`card_filter_range_mul_of_block_periodic` and
`image_mul_mod_eq_filter_gcd`. The former uses a quotient/remainder finite
bijection; the latter uses exact modular cancellation and the gcd-image
classification. The normalized definition was read in
`Prompt100TwoOwnerCounts.lean`. Current hashes are

```text
14217d9fa561bdeec9b73ed015d4b09c8e29a83c0c5c6d9974cfd2ad43ae12c8  LonelyRunner/PivotCounts.lean
ac24bb6cfcf524a08c0ceb2a728b2febf826c595d4aaa72eb7f10d2e5baa96dd  LonelyRunner/Prompt100TwoOwnerCounts.lean
8e3538e0ab5f81a3ee04927d8838c8c674e0e112838b4b3ce87ec218143276af  lean-toolchain
887450bc75a38effdae452a14b60f6d225bc10b48c71b3827e3479b800f41218  lake-manifest.json
```

The pinned toolchain is `leanprover/lean4:v4.32.1`; mathlib remains pinned to
`520045ab14e26149ee970e2e617ca04b09bde5d6`.
The reviewed source hashes were reread after all checks and remained unchanged.
All eight contracts are accepted at their displayed scopes with only permitted
axioms. The full N=7 owner theorem, its set-pattern adapters, later wrappers,
and any global existence claim require their own exact-source review.
