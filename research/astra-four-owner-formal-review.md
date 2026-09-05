# Independent formal review: four lower owners at denominator nine

Task `/root/affine_grid-four-owner-formal-review`, requested Astra/xhigh,
2026-09-05. Root reported main
`8a3a407f729163316a11ffbb863ca9dddf249d36` and an active continuation goal.
The current project configuration, workflow, policy, and research state were
read; structural validation passed. Only this review note was edited. Lean
commands began after root's explicit shared-dependency-ready signal. No
source, Git, state, root-import, restoration, or cleanup changes were made.

Review bindings:

```text
cf11f4738d51c4455e1c9fbe18810023d21794c8bb047414b793c048adbd1c5d  LonelyRunner/FourLowerOwnerNine.lean
321049a3e6863c9b67dba3c2f3a0f0582e7e001ee8da90a8c58b93851a1d5157  research/astra-four-owner-formalization.md
a51e581cdf4dc7b37a9b7481e930af00f0605fb4aa0a8aa06d848845fdb99f8f  research/astra-sparse-owner-supply-audit.md
0aacc39cf9dba3147b8002c2b0266309d0a2c57214b38645b246e20718f27684  research/astra-sparse-owner-supply-review.md
```

I read all 1,089 implementation lines, the entire author note, and both
accepted mathematical manuscripts above. I authored the original mathematical
draft, which received the separate independent review bound above; I did not
implement or edit this Lean source. This review is independent of the formal
implementation, not independent authorship of the original mathematical idea.

**ACCEPT without implementation or author-note correction**, at the exact
hashes above. The full source review, fresh source compilation, final
type/axiom replay, and independent exact controls all passed.

## 1. Full public contract and boundary

The only public declarations are
`LonelyRunner.fourLowerOwner_noncover_nine` and
`LonelyRunner.fourLowerOwner_circleNorm_witness_nine`.
Each has arbitrary natural inputs p,a,b,c,d and exactly these hypotheses:

```text
0<a<b<c<d<p.
```

They imply p>=5. There is no upper height bound, coprimality or divisibility
hypothesis on the original tuple, supplied witness, omitted owner, or
probabilistic premise. The first returns r in the original candidate row
`pivotCandidates 9 p` avoiding all four literal bad sets. The second retains
that residue and establishes the five closed inequalities

```text
1/9 <= circleNorm((r/(9*p))*v),       v=p,a,b,c,d.
```

The natural product 9*p is cast to the reals in the denominator. The pivot
is the original p throughout, and its positivity follows from the ordered
hypotheses. The result protects four lower speeds and their pivot; it is not
a statement about eight arbitrary moving speeds or unrestricted LRC.

The existing definitions and adapters match this reading. Candidates are
`0<=r<9p` with `9` not dividing r, **not** units modulo nine. Badness is
`min(rd mod9p,9p-(rd mod9p))<p`. Its negation retains equality at p as good.
Candidate membership protects the original pivot, and the existing
bad-set-to-circle adapter divides the actual integer distance by positive
9p. No speeds or times are independently replaced between these steps.

## 2. Uniform scalar reduction and exhaustive classification

`nine_normalize` uses the actual h=gcd(d,p), proves h>0, p=hP, d=hD,
`0<D<P`, and `Coprime D P`, and invokes the exact normalized count theorem.
It classifies k=gcd(D,9) as 1,3,9 using divisibility by nine. There is no
incorrect finite-field assumption at composite N=9.

Writing b=normalizedBadCount 9 k P, the scalar proofs establish:

- k=1: `9b<=16P` for P>0;
- k=3: `b<=2P` for P>0;
- k=9: P>=10 for a normalized lower owner, `5b<=12P`, and `b<=2P`
  unless P=10,11,19.

At those three exceptional denominators, positivity, D<P, and 9|D leave
exactly `(P,D)=(10,9),(11,9),(19,9),(19,18)`. They correspond to the four
actual speed equations defining `NineStar`. The proof does not infer a
bound on the original p from these reduced denominators.

The star budgets are encoded as positive integer cross-products:

| Star (S,Ds) | Exact density | (u,v) | Other-row threshold v/u |
| --- | --- | --- | --- |
| (10,9) | 24/10 | (15,28) | 28/15 |
| (11,9) | 24/11 | (33,64) | 64/33 |
| (19,9) | 40/19 | (57,112) | 112/57 |
| (19,18) | 40/19 | (57,112) | 112/57 |

An other row below its raw budget immediately satisfies the required strict
remainder bound by inclusion. Otherwise `vP<=ub`. The existing uniform
scalar inequality `9b<=16P+7(k-1)` gives

```text
(9v-16u)*P <= 7u*(k-1).                         (1)
```

All three coefficients on the left are positive. For k=1, (1) contradicts
P>0; for k=3 and k=9 it gives the following integer maxima:

| (u,v) | k=3 | k=9 |
| --- | ---: | ---: |
| (15,28) | 17 | 70 |
| (33,64) | 9 | 38 |
| (57,112) | 8 | 33 |

Thus P<71 is a proved necessary condition for the raw-exception branch.
The Lean proof splits all three budgets and all three kernel sizes. It
does not add any of these bounds to the public theorem.

Within that cap, four kernel-checked classifiers quantify over every
`P,D : Fin 71`. Their antecedents retain `0<D<P`, `Coprime D P`, raw density
**at least** the threshold, and inequality of the two slopes. P=0 or D=0
has a false antecedent, so total natural division at zero introduces no
unhandled arithmetic case. Since D<P, the proved P cap also bounds D.

I independently regenerated each classifier set, and checked the parsed
source lists and all associated numeric certificates against it. Their sizes
are exactly **37,13,9,9**, totaling 68. The identical star is excluded by
`S*D != Ds*P`; equal reduced slope at fixed p would mean the same original
owner. The opposite denominator-19 star is not excluded: both `(19,18)`
against `(19,9)` and its reverse are explicitly present. Each literal
remainder has size 16 at pivot 19, but the two remainder sets are different.

`nineRemainderCount` is proved equal to the actual difference cardinality.
Its single filtered range includes all three necessary conditions: r%9 is
nonzero, the other row is strictly bad, and the star is closed-good. Every
one of the 68 numeric bounds is checked by kernel `decide`. The wrappers
then normalize the lcm and divisions before using the corresponding theorem.
The table generation process is not a proof dependency: both membership
completeness and every bound have checked Lean proofs.

## 3. All-height lifts and the final union

The generic lift takes L=lcm(S,P). The actual star equation implies S|p
in each of the four fixed cases; normalization gives P|p. Thus L|p and
t=p/L is a positive integer. The proof explicitly establishes

```text
p=tL,  h=t(L/P),  d=t((L/P)D),  s=t((L/S)Ds).
```

It uses positive S and P to cancel products, and exact division only where
the relevant divisibility has already been proved. Both owners and the
original pivot are scaled together.

`nine_difference_scale` identifies the scaled bad-set difference with the
filter on `range(t*(9L))` whose predicate is membership after reduction
modulo 9L. The existing scaling equivalence includes the necessary range
conjunct; the range-period helper supplies exactly t copies. This proof
requires no `Coprime 9 p`, `Coprime 9 L`, or restriction on the exponent of
three in t. In particular it handles every original power of three without
silently dropping kernel-three owners. The analogous row scaling gives the
star's exact count from base counts 24,24,40,40.

For each star, its exact count satisfies

```text
u*|B_star| + 3*v*p = 8*u*p,
u*|B_other \ B_star| < v*p for every different lower owner.
```

Three strict remainders plus the star bound give a union strictly smaller
than 8p. The ordered input's four possible star positions are all handled;
other stars are permitted among the remaining owners. If no star exists,
all four raw counts are at most 2p and their first two sets share candidate
1. This already yields a strict saving; the manuscript's stronger shared
pair is unnecessary. Positivity and each genuine lower-owner bound justify
that common candidate. The union lies in the 8p-element candidate row, so
its complement supplies r avoiding **every** listed bad set.

This is a complete all-height argument for the displayed five-speed scope.
The accepted N=15 counterexample to a different general per-row budget does
not enter or weaken this proof. No conclusion about all N is inferred.

## 4. Kernel evidence and semantic probes

The fresh-source command is

```sh
/usr/bin/time -f 'elapsed_seconds=%e peak_kib=%M' timeout 240s \
  env PATH="$HOME/.elan/bin:$PATH" lake env lean LonelyRunner/FourLowerOwnerNine.lean
```

The direct compile passed with exit 0 and no Lean diagnostics in 82.63
seconds, with `/usr/bin/time` reporting peak 3,613,856 KiB. The author note's
older timings are not substituted for these independent measurements.

For a second check, concatenate the entire frozen source, a newline, and the
following block, then send it to the same timed command with `--stdin`
instead of the source filename. This replays the complete source rather
than trusting only an imported compiled artifact. The block contains exact
type and axiom probes plus 17 semantic examples, including independent
uniform cap proofs directly from the old scalar inequality.

```lean
#check LonelyRunner.fourLowerOwner_noncover_nine
#check LonelyRunner.fourLowerOwner_circleNorm_witness_nine
#print axioms LonelyRunner.fourLowerOwner_noncover_nine
#print axioms LonelyRunner.fourLowerOwner_circleNorm_witness_nine
open LonelyRunner Finset
set_option maxRecDepth 10000
set_option maxHeartbeats 1000000
example : (pivotBadResidues 9 10 9).card=24 := by decide
example : (pivotBadResidues 9 11 9).card=24 := by decide
example : (pivotBadResidues 9 19 9).card=40 := by decide
example : (pivotBadResidues 9 19 18).card=40 := by decide
example : (pivotBadResidues 9 19 18 \ pivotBadResidues 9 19 9).card=16 := by decide
example : (pivotBadResidues 9 19 9 \ pivotBadResidues 9 19 18).card=16 := by decide
example : 12 ∈ pivotBadResidues 9 76 57 ∧
    12 ∉ pivotBadResidues 9 76 36 ∧ ¬Nat.Coprime 12 9 := by decide
example : 5 ∈ pivotCandidates 9 5 ∧ 5 ∉ pivotBadResidues 9 5 1 ∧
    cyclicResidueDistance 45 5=5 := by decide
example : (9:ℝ)⁻¹ ≤ circleNorm (((5:ℝ)/45)*1) := by
  simpa using outside_pivotBadResidues_circleNorm_ge (N:=9) (pivot:=5) (r:=5) (other:=1)
    (by decide) (by decide) (by decide) (by decide)
example : ∃ r ∈ pivotCandidates 9 2090,
    r ∉ pivotBadResidues 9 2090 990 ∧ r ∉ pivotBadResidues 9 2090 1710 ∧
      r ∉ pivotBadResidues 9 2090 1881 ∧ r ∉ pivotBadResidues 9 2090 1980 := by
  exact fourLowerOwner_noncover_nine _ _ _ _ _
    (by decide) (by decide) (by decide) (by decide) (by decide)
example (t:Nat) (ht:0<t) : ∃ r ∈ pivotCandidates 9 (2090*t),
    r ∉ pivotBadResidues 9 (2090*t) (990*t) ∧
      r ∉ pivotBadResidues 9 (2090*t) (1710*t) ∧
      r ∉ pivotBadResidues 9 (2090*t) (1881*t) ∧
      r ∉ pivotBadResidues 9 (2090*t) (1980*t) := by
  exact fourLowerOwner_noncover_nine _ _ _ _ _
    (by omega) (by omega) (by omega) (by omega) (by omega)
example (p a b c d:Nat) (ha:0<a) (hab:a<b) (hbc:b<c) (hcd:c<d) (hdp:d<p) :
    ∃ t:ℝ, (9:ℝ)⁻¹ ≤ circleNorm (t*(p:ℝ)) ∧
      (9:ℝ)⁻¹ ≤ circleNorm (t*(a:ℝ)) ∧ (9:ℝ)⁻¹ ≤ circleNorm (t*(b:ℝ)) ∧
      (9:ℝ)⁻¹ ≤ circleNorm (t*(c:ℝ)) ∧ (9:ℝ)⁻¹ ≤ circleNorm (t*(d:ℝ)) := by
  obtain ⟨r,_,hp,ha',hb,hc,hd⟩ := fourLowerOwner_circleNorm_witness_nine p a b c d ha hab hbc hcd hdp
  exact ⟨(r:ℝ)/((9*p:Nat):ℝ),hp,ha',hb,hc,hd⟩
example : pivotBadResidues 9 5 0=pivotCandidates 9 5 := by decide
example : pivotBadResidues 9 5 45=pivotCandidates 9 5 := by decide
example (P D:Nat) (hP:71≤P) :
    15*normalizedBadCount 9 (Nat.gcd D 9) P < 28*P := by
  have hb := normalizedBadCount_ownerKernel_bound 9 (Nat.gcd D 9) P
    (by omega) (by omega) (Nat.gcd_pos_of_pos_right D (by omega)) (Nat.gcd_dvd_right D 9)
  have hk : Nat.gcd D 9 ≤ 9 := Nat.le_of_dvd (by omega) (Nat.gcd_dvd_right D 9)
  omega
example (P D:Nat) (hP:39≤P) :
    33*normalizedBadCount 9 (Nat.gcd D 9) P < 64*P := by
  have hb := normalizedBadCount_ownerKernel_bound 9 (Nat.gcd D 9) P
    (by omega) (by omega) (Nat.gcd_pos_of_pos_right D (by omega)) (Nat.gcd_dvd_right D 9)
  have hk : Nat.gcd D 9 ≤ 9 := Nat.le_of_dvd (by omega) (Nat.gcd_dvd_right D 9)
  omega
example (P D:Nat) (hP:34≤P) :
    57*normalizedBadCount 9 (Nat.gcd D 9) P < 112*P := by
  have hb := normalizedBadCount_ownerKernel_bound 9 (Nat.gcd D 9) P
    (by omega) (by omega) (Nat.gcd_pos_of_pos_right D (by omega)) (Nat.gcd_dvd_right D 9)
  have hk : Nat.gcd D 9 ≤ 9 := Nat.le_of_dvd (by omega) (Nat.gcd_dvd_right D 9)
  omega
```

The final full-source replay and all 17 probes passed with exit 0 and no Lean
diagnostics, in 82.26 seconds with reported peak 3,610,108 KiB. The exact
printed types match Section 1. The axiom outputs were exactly:

```text
'LonelyRunner.fourLowerOwner_noncover_nine' depends on axioms: [propext, Classical.choice, Quot.sound]
'LonelyRunner.fourLowerOwner_circleNorm_witness_nine' depends on axioms: [propext, Classical.choice, Quot.sound]
```

For a reproducible extraction of the exact final probe block:

```sh
python3 - <<'PY' | /usr/bin/time -f 'elapsed_seconds=%e peak_kib=%M' \
  timeout 240s env PATH="$HOME/.elan/bin:$PATH" lake env lean --stdin
from pathlib import Path
import re
note=Path('research/astra-four-owner-formal-review.md').read_text()
blocks=re.findall(r'```lean\n(.*?)\n```',note,re.S)
assert len(blocks)==1
print(Path('LonelyRunner/FourLowerOwnerNine.lean').read_text())
print(blocks[0])
PY
```

The initial appended endpoint probe exceeded the default heartbeat allowance
while inferring natural parameters from a real-literal goal. With the parameters
explicit, the probe also needed `simpa` to normalize the natural product/casts.
The corrected isolated probe passed, and the final block uses explicit r and
other plus a larger local heartbeat allowance. These were disposable probe
corrections; the frozen implementation and its theorem contracts were unchanged.
The initial failed combined probe run is not counted as a successful replay.

The local `maxHeartbeats 0`, increased recursion limit, and disabled
asynchronous elaboration control resource usage; they do not replace kernel
proof checking. The source has no custom axiom, sorry/admit, native_decide,
unsafe declaration, or opaque trust escape. Only the two displayed theorems
are public; every support declaration is private.

## 5. Independent exact regression and source-table replay

The self-contained block below uses integer/Fraction arithmetic and literal
sets, without importing a project checker. It regenerates the finite
antecedent classifications independently, then checks all source table
entries and each certificate's lcm, speeds, multipliers, and exact inequality.
It also verifies full-set common scaling at factors 3,9,27 for all 68 pairs,
scalar inequalities at 30,027 (P,k) cases including huge P, normalized counts
for 4,950 literal rows, and all 201,376 increasing four-owner sets at p=5..32.
The latter scan is a finite regression, not an all-height proof. The branch
vector records no star, then the selected star in positions a,b,c,d, matching
the source's preference for the last star.

```python
from pathlib import Path
from math import gcd,lcm,comb
from fractions import Fraction as F
from itertools import combinations
import re

src=Path('LonelyRunner/FourLowerOwnerNine.lean').read_text()
def dist(M,x):
    q=x%M
    return min(q,M-q)
def R(p):
    return {r for r in range(9*p) if r%9}
def B(p,d):
    return {r for r in R(p) if dist(9*p,r*d)<p}
def b(P,D):
    k=gcd(D,9)
    return k*(2*((P-1)//k)+1)-(2*((P-1)//9)+1)

classes=[('ten',10,9,15,28),('eleven',11,9,33,64),
         ('nineteen_a',19,9,57,112),('nineteen_b',19,18,57,112)]
counts=[]; maxima=[]; scales=0
for name,S,Ds,u,v in classes:
    parsed=re.search(r'private theorem nine_pair_membership_'+name+
        r' :\s*NinePairMembership \d+ \d+ \d+ \d+\s*\{(.*?)\} :=',src,re.S)
    assert parsed
    written={tuple(map(int,p)) for p in re.findall(r'\((\d+),(\d+)\)',parsed.group(1))}
    expected={(P,D) for P in range(71) for D in range(71)
              if 0<D<P and gcd(P,D)==1 and v*P<=u*b(P,D) and S*D!=Ds*P}
    assert written==expected
    rows=re.findall(r'private theorem nine_pair_'+name+
        r'_(\d+)_(\d+) :\s*(\d+) \* nineRemainderCount (\d+) (\d+) (\d+) < (\d+)\*(\d+)',src)
    assert {(int(row[0]),int(row[1])) for row in rows}==expected
    assert len(rows)==len(expected)
    ratios=[]
    for ptxt,dtxt,utxt,ltxt,bdtxt,bstxt,vtxt,rtxt in rows:
        P,D=int(ptxt),int(dtxt)
        L=lcm(P,S); d=D*(L//P); star=Ds*(L//S)
        assert tuple(map(int,(utxt,ltxt,bdtxt,bstxt,vtxt,rtxt)))==(u,L,d,star,v,L)
        Bs,Bd=B(L,star),B(L,d); rem=Bd-Bs
        assert len(Bd)*P==b(P,D)*L
        assert u*len(rem)<v*L
        ratios.append(F(len(rem),L))
        for t in (3,9,27):
            actual=B(t*L,t*d)-B(t*L,t*star)
            assert actual=={r for r in range(9*t*L) if r%(9*L) in rem}
            assert len(actual)==t*len(rem)
            scales+=1
    counts.append(len(expected)); maxima.append(str(max(ratios)))
assert counts==[37,13,9,9]
assert maxima==['84/55','96/55','168/95','168/95']
assert scales==204

rawtests=0
for P in list(range(1,10001))+[9*10**100+i for i in range(1,10)]:
    for D in (1,3,9):
        k=gcd(D,9); n=b(P,D)
        assert 9*n<=16*P+7*(k-1)
        if k==1:
            assert 9*n<=16*P
        if k==3:
            assert n<=2*P
        if k==9 and P>=10:
            assert 5*n<=12*P
            if P not in (10,11,19):
                assert n<=2*P
        for _,S,Ds,u,v in classes:
            if v*P<=u*n:
                assert P<71
        rawtests+=1
assert rawtests==30027

rowchecks=0
for p in range(2,101):
    for d in range(1,p):
        h=gcd(p,d); P=p//h; D=d//h; bb=B(p,d)
        assert len(bb)==h*b(P,D)
        if not any(S*d==Ds*p for _,S,Ds,_,_ in classes):
            assert len(bb)<=2*p
        assert 1 in bb
        rowchecks+=1
quadchecks=0; branches=[0]*5
for p in range(5,33):
    full=sum(1<<r for r in R(p))
    masks={d:sum(1<<r for r in B(p,d)) for d in range(1,p)}
    for ds in combinations(range(1,p),4):
        cover=0
        for d in ds:
            cover|=masks[d]
        assert cover!=full
        safe=full^cover; r=(safe&-safe).bit_length()-1
        assert min(dist(9*p,r*d) for d in ds+(p,))>=p
        pos=next((i+1 for i in reversed(range(4))
                  if any(S*ds[i]==Ds*p for _,S,Ds,_,_ in classes)),0)
        branches[pos]+=1; quadchecks+=1
assert rowchecks==4950 and quadchecks==comb(32,5)==201376
assert branches==[194764,57,301,1446,4808]

p=2090; ds=(990,1710,1881,1980)
bs=[B(p,d) for d in ds]; safe=R(p)-set().union(*bs)
assert list(map(len,bs))==[4400,4560,5016,4400]
assert (len(safe),min(safe))==(5376,3)

# The opposite same-denominator star must remain; direction matters as a set.
forward=B(19,18)-B(19,9); reverse=B(19,9)-B(19,18)
assert len(forward)==len(reverse)==16 and forward!=reverse
# Composite candidates include nonunits; a unit filter would lose this point.
assert 12 in B(76,57)-B(76,36) and gcd(12,9)!=1
# Equality is safe, whereas zero/upper owners and removal of stars change scope.
assert 5 in R(5) and 5 not in B(5,1) and dist(45,5)==5
assert B(5,0)==R(5) and B(5,45)==R(5)
assert len(B(10,9))==24>20
print(dict(pair_counts=counts,pair_maxima=maxima,scales=scales,
           scalar_cases=rawtests,rows=rowchecks,four_owner_cases=quadchecks,
           branches=branches,all_star_safe=len(safe)))
```

## 6. Dependency and acceptance boundary

The directly used scalar-bound source was read in full. The normalization,
scaling, periodic-range, strict-bad and circle adapters remain at the same
hashes previously inspected in the independent N7/helper reviews:

```text
4a9e242429e601f07559a1482031d84f0cc5677a3c128a15481f4003d4f5333e  LonelyRunner/OwnerKernelBound.lean
a6199b77071b81868abffe0959c1b5aa4e64a06369adb93eddbc2fa7b6c90b7e  LonelyRunner/PeriodicPivotCounts.lean
49131a7f9690042d1b16cbc876417f9d9ce1b53cc6565f87b6d1b53c4e3340cd  LonelyRunner/Prompt99Scaling.lean
ac24bb6cfcf524a08c0ceb2a728b2febf826c595d4aaa72eb7f10d2e5baa96dd  LonelyRunner/Prompt100TwoOwnerCounts.lean
362da5ab923f22e900ae7ac821dd4cf4aab91dfe70889987bc9e5a05d19c276a  LonelyRunner/PivotResidues.lean
8e3538e0ab5f81a3ee04927d8838c8c674e0e112838b4b3ce87ec218143276af  lean-toolchain
887450bc75a38effdae452a14b60f6d225bc10b48c71b3827e3479b800f41218  lake-manifest.json
```

The pinned toolchain is `leanprover/lean4:v4.32.1` and mathlib revision is
`520045ab14e26149ee970e2e617ca04b09bde5d6`. Root owns integration builds,
root imports, trust-audit integration, and publication. This review does not
promote the unresolved general sparse-owner or canonical LRC goal.
All source, manuscript, and dependency hashes were reread after verification
and remained unchanged. The final embedded arithmetic block and workflow
validator passed. No unresolved semantic defect or extra hypothesis was found
in either public theorem; no verification process remains running.
