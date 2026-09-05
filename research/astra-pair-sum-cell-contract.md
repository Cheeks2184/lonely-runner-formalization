# Finite floor-cell contract for pair-sum completeness

2026-09-05. Independent Astra/xhigh semantic task
`/root/cluster_limit_review-pair-sum-cell-contract`, assigned at
`dcee411946aff78931147df421e1095d25dbb948`. Runtime model/effort metadata were
not independently exposed. Current project instructions, workflow, policy and
state were read, and `python3 -B scripts/validate_workflow.py` passed. Only this
contract and small temporary exact-control artifacts were written.

**Disposition: the root-proposed finite minimum argument is valid, with no
additional mathematical premise required. The specification below is settled
for implementation.** It proves that an existing witness has a pair-sum
certificate for each fixed positive natural speed tuple with at least two
indices. Repetitions are allowed. It also preserves a balanced pair and a
common margin at least the supplied threshold. This is a manuscript contract,
not a compiled Lean theorem, uniform certificate supply, a global-maximizer
claim, or an unrestricted LRC proof.

## Complete finite argument

Let W_i be positive integers indexed by Fin n, n>=2. Suppose lambda>0 and
||t W_i||>=lambda for every i, with t any real number. Let tau=fract(t), so
0<=tau<1. Integer speeds make ||tau W_i||=||t W_i||. Define the cell index
z_i=floor(tau W_i); it is an integer with 0<=z_i<W_i.

For any integer z, distance to the nearest integer is at most |x-z|. Applying
this at the floor z_i and at z_i+1, using z_i<=tau W_i<z_i+1, gives

```text
z_i+lambda <= tau W_i <= z_i+1-lambda.
```

This argument does not presuppose a formula for the fractional part's circle
norm or require lambda<=1/2 as an extra hypothesis. That bound will follow
from the finite minimum. Exact integer phases cannot satisfy a positive
threshold, so no exceptional positive-margin floor endpoint is lost.

For every ordered pair, including the diagonal, define

```text
C_ij = (W_i*(z_j+1)-W_j*z_i)/(W_i+W_j),
L_i(m)=(z_i+m)/W_i,     R_j(m)=(z_j+1-m)/W_j.
```

All denominators are positive. Clearing them gives the exact equivalence

```text
m <= C_ij  iff  L_i(m) <= R_j(m).
```

The input bands give L_i(lambda)<=tau<=R_j(lambda), hence every C_ij is at
least lambda. The nonempty finite set of ordered index pairs has a minimizing
pair (p,q). Write M=C_pq. Then lambda<=M, and C_ii=1/2 for any index i
shows M<=1/2. No continuity, compactness, supremum or limit is used.

Set T=(z_p+z_q+1)/(W_p+W_q). Direct algebra gives

```text
L_p(M)=T=R_q(M).
```

For arbitrary i, minimality at pair (i,q) gives L_i(M)<=R_q(M)=T.
Minimality at pair (p,i) gives T=L_p(M)<=R_i(M). These are the required
index orientations. Multiplying by W_i gives every closed band

```text
z_i+M <= T W_i <= z_i+1-M.
```

Since 0<M<=1/2, all original circle distances are at least M>=lambda.
The active equations are T W_p=z_p+M and T W_q=z_q+1-M.

If p and q are distinct, retain them. If p=q, the diagonal value gives
M=1/2, and every displayed band collapses to T W_i=z_i+1/2. Choose any
two distinct indices a,b, possible because n>=2. The same time now satisfies
T(W_a+W_b)=z_a+z_b+1, and both balanced identities remain true for a,b.
Thus the replacement still supplies a distinct pair of original indices,
even when their speeds are equal. It does not deduplicate the input tuple.

For the final distinct pair a,b, put r=z_a+z_b+1 and D=W_a+W_b. The integer
floor bounds give 1<=r<=D-1, hence 0<r<D and 0<T=r/D<1. The margin M,
all original closed bands, and the two balanced equations are unchanged.
Each active circle norm is exactly M, so M is an attained common margin.
The construction provides no assertion that it is a maximum over other
floor cells or over all times; none is needed for witness completeness.

## Exact domain and scope

The core accepts arbitrary lambda>0 and real input time; it produces a positive
rational time. For the existing certificate instantiate lambda=(N:real)^-1
with N>0. No N>=2 premise is necessary: N=1 has a false witness premise,
since the argument forces 1<=M<=1/2. N=2 is included at the exact half
boundary and uses the same diagonal-or-distinct handling. N is not required
to equal n+1 in the fixed-instance theorem. Positivity of every speed and
n>=2 remain explicit; injectivity is deliberately absent.

The restriction n>=2 is essential for the existing certificate, which demands
distinct indices: one positive speed can have a witness but has no such pair.
N>0 is also essential for the stated natural certificate equivalence. Lean's
inverse of zero is zero, making the analytic threshold trivial, whereas a
positive pair denominator cannot satisfy D<=0*cyclicResidueDistance.

Certificate existence already implies a witness by the frozen
`pairSumCertificate_circleNorm`. The new reverse therefore gives exact
fixed-instance equivalence, and can add the missing reverse implication in
the two positive-integer conjecture formulations. This certifies completeness
of a finite search for each supplied tuple. It does not prove that a search
succeeds, solve all retained finite families, or supply the unrestricted
canonical conjecture. No new real-to-integer reduction is part of this change.

## Checked source interfaces and recommended implementation

The following bodies were inspected at these SHA-256 values:

| Source | SHA-256 |
| --- | --- |
| `LonelyRunner/PairSumGeometry.lean` | `3bc47a6f1a77950577edc54b571e9809bb03bffd37575ebc10bae0fcfcab9384` |
| `LonelyRunner/PivotBoundary.lean` | `0e56cab74d30ef8b537ed4ec24503aae875bd8aadc369d26da99ba882cc3603f` |
| `LonelyRunner/StructuredClasses.lean` | `5328a7a88d2b42f86ffc3f0f0418ca22c761219e8fa3e5822bda5a18ac286e8c` |
| `LonelyRunner/FastRunnerInsertion.lean` | `dda82d1f8830d961499292656c3dfac884a471ad5ef38bd925b1a25c403603a5` |
| `LonelyRunner/BHKAdjacentPair.lean` | `3d36d812db7ed18db8fce521b2505d5904a8387d8e315c6e7d08d9eb7dc75708` |
| `LonelyRunner/SimultaneousApproximation.lean` | `144aec242a3f4d06853fed110bf8ee20f1cabf88b925acda889fe08cfe57c729` |
| `LonelyRunner/Formulations.lean` | `0c3328e975bee236ff66862d3a5cadeb58fbc7c804fa953e53701ba466b9d788` |

Recommended new module: `LonelyRunner/PairSumCompleteness.lean`, importing
`PairSumGeometry`, `PivotBoundary`, `StructuredClasses`,
`Mathlib.Data.Finset.Max`, and `Mathlib.Algebra.Order.Floor.Ring` as needed.
The use of `PivotBoundary` is solely for its elementary integer-period identity
`circleNorm_fract_mul_nat`; no boundary or continuity theorem is invoked.
No existing certificate definition should be changed.

Use **natural floors** for the implementation after normalization:

```lean
let tau : ℝ := Int.fract time
let z : Fin n → ℕ := fun i => ⌊tau * (speeds i : ℝ)⌋₊
```

These equal the proposed integer floors because each phase is nonnegative,
and allow the final numerator to be the natural expression z a+z b+1 without
an integer-to-natural conversion. This changes no mathematical hypothesis.
`Nat.floor_le` on the nonnegative phase, `Nat.lt_floor_add_one`, and
`Nat.floor_lt` are used in the inspected `SimultaneousApproximation.lean`.
The upper speed bound follows from tau<1 and speed positivity. In particular,
`(Nat.floor_lt hphase_nonneg).mpr hphase_lt_speed` supplies z_i<speeds_i.
The time normalization is exactly `circleNorm_fract_mul_nat time (speeds i)`.

The first two small helper signatures below make the floor-to-band step
explicit. They are proposed declarations, with proof bodies deliberately
absent; none of these new signatures has been Lean-compiled in this task.

```lean
theorem circleNorm_le_abs_sub_int (x : ℝ) (z : ℤ) :
    circleNorm x ≤ |x - (z : ℝ)|

theorem int_band_of_circleNorm_ge (z : ℤ) (x δ : ℝ)
    (hlower : (z : ℝ) ≤ x) (hupper : x ≤ (z : ℝ) + 1)
    (hgood : δ ≤ circleNorm x) :
    (z : ℝ) + δ ≤ x ∧ x ≤ (z : ℝ) + 1 - δ
```

For the first, rewrite `circleNorm_eq_abs_sub_round` and apply `round_le x z`.
The exact nearest-integer inequality is already used in `FastRunnerInsertion`.
For the second, apply the first helper to z and z+1; use the signs supplied
by the two band endpoints to remove absolute values, then `linarith`.
It needs no positivity or half-bound premise on δ. Apply it to `(z i : ℤ)`
and simplify casts when deriving the natural-floor bands.

Retain balance in this one core helper. It uses natural cell indices, an
arbitrary supplied margin, and returns the same cell bands at an improved
margin; no norm theorem or global optimization premise occurs in its type:

```lean
theorem exists_balanced_pairSum_cell_peak {n : ℕ}
    (hn : 2 ≤ n) (speeds z : Fin n → ℕ)
    (hspeeds : ∀ i, 0 < speeds i)
    (hzlt : ∀ i, z i < speeds i)
    (δ time : ℝ) (hδ : 0 < δ)
    (hlower : ∀ i, (z i : ℝ) + δ ≤ time * (speeds i : ℝ))
    (hupper : ∀ i, time * (speeds i : ℝ) ≤ (z i : ℝ) + 1 - δ) :
    ∃ p q : Fin n, p ≠ q ∧ ∃ (r : ℕ) (M T : ℝ),
      0 < r ∧ r < speeds p + speeds q ∧
      T = (r : ℝ) / ((speeds p + speeds q : ℕ) : ℝ) ∧
      δ ≤ M ∧ M ≤ (1 : ℝ) / 2 ∧
      T * (speeds p : ℝ) = (z p : ℝ) + M ∧
      T * (speeds q : ℝ) = (z q : ℝ) + 1 - M ∧
      ∀ i, (z i : ℝ) + M ≤ T * (speeds i : ℝ) ∧
        T * (speeds i : ℝ) ≤ (z i : ℝ) + 1 - M
```

Implementation sequence for that helper:

1. Define real L, R and C locally, with C indexed by `Fin n × Fin n`.
   Establish `m ≤ C (i,j) ↔ L i m ≤ R j m` by positive-denominator
   cross multiplication; `div_le_div_iff₀`, `le_div_iff₀`, and ring
   normalization expose the same inequality. This local fact prevents an
   index reversal in either use of minimality.
2. Use the input bands to obtain δ<=C(i,j) for every ordered pair.
   Construct a concrete nonempty univ witness from `(0,0)`, using hn to
   build each `Fin n`; no implicit `Nonempty` inference needs to be guessed.
   `Finset.exists_min_image Finset.univ C hnonempty` is used with this exact
   argument shape in `BHKAdjacentPair.lean`. Its returned comparison is
   `C chosen ≤ C candidate` for each candidate in univ.
3. With the chosen pair p,q, set M=C(p,q) and
   T=((z p:ℝ)+(z q:ℝ)+1)/((speeds p:ℝ)+(speeds q:ℝ)).
   Prove the diagonal value and the two active equalities using positivity,
   `field_simp` and `ring`. Obtain M<=1/2 from any diagonal candidate.
4. Apply minimality to `(i,q)` and `(p,i)` to obtain every closed M-band.
   Retain the active equations rather than discarding them after norm bounds.
5. Split only on p=q. In the distinct case use r=z p+z q+1. In the diagonal
   case show M=1/2, derive T*speeds_i=z_i+1/2 for every i, and use distinct
   indices 0 and 1. Add their two equalities to obtain T=r/D and balance for
   the replacement pair. Positivity of D justifies division.
6. For either final pair, `omega` from its two natural floor bounds proves
   0<r and r<speeds_p+speeds_q. Normalize casts with `push_cast` or `norm_num`;
   no arithmetic reduction of r modulo D is needed.

The public generic witness wrapper should have this exact hypothesis scope:

```lean
theorem exists_pairSum_time_of_witness {n : ℕ}
    (hn : 2 ≤ n) (speeds : Fin n → ℕ)
    (hspeeds : ∀ i, 0 < speeds i)
    (δ time : ℝ) (hδ : 0 < δ)
    (hwitness : ∀ i, δ ≤ circleNorm (time * (speeds i : ℝ))) :
    ∃ p q : Fin n, p ≠ q ∧ ∃ r : ℕ,
      0 < r ∧ r < speeds p + speeds q ∧
      ∀ i, δ ≤ circleNorm
        (((r : ℝ) / ((speeds p + speeds q : ℕ) : ℝ)) *
          (speeds i : ℝ))
```

Normalize, build the natural-floor bands, and apply the balanced helper.
`circleNorm_ge_of_int_band (z i : ℤ)` from `StructuredClasses` converts each
output band to norm>=M, using 0<=M from 0<δ<=M and M<=1/2. Transitivity
returns δ. The positive numerator also gives a positive time less than one
if a caller needs that conclusion; it is not a new caller premise.

The main requested reverse implication and its direct equivalence are:

```lean
theorem pairSumCertificate_of_witness {n N : ℕ}
    (hn : 2 ≤ n) (speeds : Fin n → ℕ)
    (hN : 0 < N) (hspeeds : ∀ i, 0 < speeds i)
    (time : ℝ)
    (hwitness : ∀ i,
      (N : ℝ)⁻¹ ≤ circleNorm (time * (speeds i : ℝ))) :
    PairSumCertificate N speeds

theorem exists_witness_iff_pairSumCertificate {n N : ℕ}
    (hn : 2 ≤ n) (speeds : Fin n → ℕ)
    (hN : 0 < N) (hspeeds : ∀ i, 0 < speeds i) :
    (∃ time : ℝ, ∀ i,
      (N : ℝ)⁻¹ ≤ circleNorm (time * (speeds i : ℝ))) ↔
    PairSumCertificate N speeds
```

Instantiate δ=(N:ℝ)^-1, whose positivity follows from hN. Apply the existing
`pairSumCertificate_iff_pair_time speeds hN hspeeds` in its reverse direction,
discarding only the extra 0<r field. This retains exactly the certificate's
original distinct-index requirement, natural numerator bound, and integer
cyclic-residue inequality; it does not redefine certificate success.
For the displayed iff, the other direction is the already-proved
`pairSumCertificate_circleNorm speeds hN hspeeds`.

A small formulation corollary is consequently settled as well, without a new
supply premise or a changed one-moving-runner case:

```lean
theorem positiveIntegerConjecture_iff_pairSumCertificateConjecture :
    PositiveIntegerConjecture ↔ PositiveIntegerPairSumCertificateConjecture
```

The forward direction applies the new fixed-instance theorem at N=n+1 for
n>=2, simplifying `circleNorm` to the existing UnitCircle norm. The reverse
is the existing
`positiveIntegerPairSumCertificateConjecture_imp_positiveIntegerConjecture`,
which already handles one moving runner. This corollary asserts equivalence
of unsupplied propositions, not either proposition. It may be included with
the wrapper if desired; no additional mathematical work is required.

After implementation, register the new module and declarations in the normal
root import/axiom audit, update the PairSumGeometry documentation to reflect
proved fixed-instance completeness, and run the appropriate source build,
axiom check and independent exact-body review. Acceptance must preserve the
N>0 and n>=2 scope, repeated-speed cases, closed endpoints, positive numerator,
and balanced helper fields. These implementation and verification steps remain
pending; no Lean or cache operation was performed in this contract task.

## Fixed exact controls and durable reproducer

The fixed control domain is eight literal speed/time/margin triples printed
in the program, with integer time shifts {-3,0,5}; every minimizing ordered
pair is checked, including all ties. It includes both orientations of (1,2),
the supplied (1,3,4) witness 5/12, repeated speeds (1,1), (5,5), (2,4,4),
the odd half-phase tuple (1,3,5), and a numerator D-1 example (2,3) at 4/5.
No tuple or time discovery loop is used. The (1,3,4) cell outputs T=3/7,
M=2/7 from lambda=1/4, illustrating a local margin improvement only.

All exact controls passed. There are 24 normalized instances, 57 input floor
bands, 141 ordered-pair bounds, 69 selected-minimizer outputs (21 diagonal
and 48 distinct), 174 output-coordinate checks and 138 balanced output
equalities. All 69 outputs have 0<r<D and positive T<1; 18 have r=D-1.
There are 168 natural certificate inequalities, eight negative input times,
nine repeated-speed instances, and three strict margin improvements. Explicit
one-index, N=0, N=1 and integer-time controls record the boundary of the
contract rather than broadening it.

The sole Python block below checks the seven frozen source hashes and all
exact controls. Its temporary copy is `/tmp/astra-pair-sum-cell-controls.py`,
4,632 bytes, SHA-256
`69b26db3b7ccb8d84394925434437efeaf8394dcdb83ead553e79a1fe20d356c`.
The complete JSON with trailing newline is
`/tmp/astra-pair-sum-cell-controls.json`, 4,188 bytes, SHA-256
`8ec157f9c70a493facec877dc680ee24ccfc6515f6822fbc1bb031b9f629fa59`.

```python
from collections import Counter
from fractions import Fraction as F
from hashlib import sha256
from itertools import product
from pathlib import Path
import json

ROOT=Path('/home/joshua/lonely-runner-formalization')
FROZEN={
 'LonelyRunner/Formulations.lean':'0c3328e975bee236ff66862d3a5cadeb58fbc7c804fa953e53701ba466b9d788',
 'LonelyRunner/PairSumGeometry.lean':'3bc47a6f1a77950577edc54b571e9809bb03bffd37575ebc10bae0fcfcab9384',
 'LonelyRunner/PivotBoundary.lean':'0e56cab74d30ef8b537ed4ec24503aae875bd8aadc369d26da99ba882cc3603f',
 'LonelyRunner/StructuredClasses.lean':'5328a7a88d2b42f86ffc3f0f0418ca22c761219e8fa3e5822bda5a18ac286e8c',
 'LonelyRunner/FastRunnerInsertion.lean':'dda82d1f8830d961499292656c3dfac884a471ad5ef38bd925b1a25c403603a5',
 'LonelyRunner/BHKAdjacentPair.lean':'3d36d812db7ed18db8fce521b2505d5904a8387d8e315c6e7d08d9eb7dc75708',
 'LonelyRunner/SimultaneousApproximation.lean':'144aec242a3f4d06853fed110bf8ee20f1cabf88b925acda889fe08cfe57c729',
}
for name,digest in FROZEN.items():
 assert sha256((ROOT/name).read_bytes()).hexdigest()==digest,name

def floor(x): return x.numerator//x.denominator
def norm(x):
 x=F(x)-floor(F(x));return min(x,1-x)
def cyclic(D,x):
 r=x%D;return min(r,D-r)

# Fixed supplied/analytically chosen cases, never a tuple-discovery loop.
fixtures=(
 ((1,2),F(1,3),F(1,3),'lower_upper_order'),
 ((1,2),F(2,3),F(1,3),'reversed_order'),
 ((1,3,4),F(5,12),F(1,4),'improved_margin'),
 ((1,1),F(1,2),F(1,2),'repeated_half'),
 ((5,5),F(7,10),F(1,2),'repeated_nonzero_floor'),
 ((1,3,5),F(1,2),F(1,2),'distinct_odd_half'),
 ((2,4,4),F(1,6),F(1,3),'repeated_nonhalf'),
 ((2,3),F(4,5),F(2,5),'last_numerator'),
)
counts=Counter();records=[]
for (W,time,lam,label),shift in product(fixtures,(-3,0,5)):
 t=time+shift;tau=t-floor(t);n=len(W)
 assert n>=2 and all(w>0 for w in W) and lam>0 and 0<=tau<1
 z=tuple(floor(w*tau) for w in W)
 for i,w in enumerate(W):
  assert norm(w*t)==norm(w*tau)>=lam
  assert 0<=z[i]<w and z[i]+lam<=w*tau<=z[i]+1-lam
  counts['normalized_floor_bands']+=1
 C={(i,j):F(W[i]*(z[j]+1)-W[j]*z[i],W[i]+W[j]) for i,j in product(range(n),repeat=2)}
 assert all(c>=lam for c in C.values())
 assert all(C[i,i]==F(1,2) for i in range(n))
 counts['ordered_pair_bounds']+=len(C)
 M=min(C.values())
 assert lam<=M<=F(1,2)
 # Test every minimizer, so tie handling is not hidden in a selection rule.
 for (p,q),c in C.items():
  if c!=M: continue
  T=F(z[p]+z[q]+1,W[p]+W[q])
  L=lambda i:F(z[i]+M,W[i])
  R=lambda i:F(z[i]+1-M,W[i])
  assert L(p)==T==R(q)
  for i in range(n):
   assert M<=C[i,q] and M<=C[p,i]
   assert L(i)<=R(q)==T==L(p)<=R(i)
   assert z[i]+M<=W[i]*T<=z[i]+1-M
   assert norm(W[i]*T)>=M
   counts['peak_coordinate_checks']+=1
  if p==q:
   assert M==F(1,2)
   assert all(W[i]*T==z[i]+F(1,2) for i in range(n))
   a,b=0,1
   counts['diagonal_minimizers']+=1
  else:
   a,b=p,q
   counts['distinct_minimizers']+=1
  r=z[a]+z[b]+1;D=W[a]+W[b]
  assert a!=b and 0<r<D and T==F(r,D) and 0<T<1
  assert W[a]*T==z[a]+M and W[b]*T==z[b]+1-M
  counts['balanced_output_equalities']+=2
  assert all(norm(w*T)>=M>=lam for w in W)
  counts['positive_pair_times']+=1
  counts['strict_numerator_boundary']+=int(r==D-1)
  counts['improved_peak_instances']+=int(M>lam)
  if lam.numerator==1:
   N=lam.denominator
   assert all(D<=N*cyclic(D,r*w) for w in W)
   counts['natural_certificate_checks']+=n
  if shift==0:
   records.append({'case':label,'input':str(time),'z':z,'minimum_pair':(p,q),'M':str(M),'output_pair':(a,b),'r':r,'D':D,'T':str(T)})
 counts['normalized_instances']+=1
 counts['negative_input_times']+=int(t<0)
 counts['repeated_speed_instances']+=int(len(set(W))<n)

# Essential-domain controls; no inference of universal positive-threshold supply.
assert norm(F(1,2))>=F(1,2) and not [(p,q) for p,q in product(range(1),repeat=2) if p!=q]
counts['one_index_control']=1
# N=1 has no input witness: distance is at most 1/2; check the stated controls.
assert all(min(norm(w*t) for w in W)<=F(1,2)<1 for W,t,lam,label in fixtures)
counts['N1_false_premise_controls']=len(fixtures)
# Lean's inverse of 0 is 0, so N>0 cannot be dropped from certificate completeness.
assert all(norm(w*F(0))>=0 for w in (1,2))
assert 1+2>0*cyclic(3,0)
counts['N0_exclusion_control']=1
assert all(norm(w*F(1))==0 for w in (1,2))
counts['integer_time_boundary_control']=1
assert counts['diagonal_minimizers']>0 and counts['distinct_minimizers']>0
assert counts['strict_numerator_boundary']>0 and counts['improved_peak_instances']>0
print(json.dumps({'source_hashes':FROZEN,'counts':dict(sorted(counts.items())),'unshifted_outputs':records},sort_keys=True,separators=(',',':')))
```

Execution and replay commands (both exact-control executions exited 0):

```bash
python3 -B /tmp/astra-pair-sum-cell-controls.py > /tmp/astra-pair-sum-cell-controls.json
python3 -B - <<'PY' > /tmp/astra-pair-sum-cell-replay.json
from pathlib import Path
from hashlib import sha256
import re
p=Path('research/astra-pair-sum-cell-contract.md')
blocks=re.findall(r'^```python\n(.*?)^```[ \t]*$',p.read_text(),re.M|re.S)
assert len(blocks)==1
assert sha256(blocks[0].encode()).hexdigest()=='69b26db3b7ccb8d84394925434437efeaf8394dcdb83ead553e79a1fe20d356c'
exec(compile(blocks[0],str(p),'exec'),{})
PY
```

The JSON and embedded replay agree byte for byte. The initial program also
passed before adding explicit balanced-output assertions and the final source
guard; no mathematical assertion failed. Other commands were configuration,
state and source reads, source/name searches, workflow validation, and hashing.
One optional import search included an absent `lakefile.lean` and exited 2;
its existing-file results were readable, and an existing-file-only follow-up
exited 0. The unused-proposed-name search returned no matches, exit 1.
Neither event was a Lean or mathematical failure.

No source, Git or state edit, dependency restoration or cache operation was
performed by this task. The root separately owns the shared cache and later
implementation. All owned commands completed before freeze; no process from
this task remains running. The final contract hash is reported externally.
The proof/signatures are ready for Terra implementation under the project
workflow; kernel acceptance and independent source review remain required.
