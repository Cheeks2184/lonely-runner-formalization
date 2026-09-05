# Independent review: exact cyclic bad residues

Status: **accepted without source corrections**, 2026-09-05. This review is
bound to `LonelyRunner/AffineCyclicBadResidues.lean`, SHA-256
`5c5ec03de4c5363987098055aa0df170579156bd390206655e417c34f7a2a9bd`
(137 lines), with imported `LonelyRunner/AffineGridCyclic.lean` SHA-256
`b4b42a0dd0f00730c2fbd45814a362a7e30248c97c234fd4d7ed72c7bf521e4b`.
The latter's independent review is `research/astra-cyclic-formal-review.md`.
The entire current source and its transport dependency were inspected. Project
policy/state were read and `python3 scripts/validate_workflow.py` passed.
Only this review file was written.

## Exact scope

The definition `LonelyRunner.affineCyclicBadResidues N M a beta` is a
`Finset (ZMod N)`. Put `k = a*beta / M`, `e = a*beta % M`. It is the singleton
`{-k}` when `e=0` and the pair `{-k,-k-1}` otherwise. Quotient `k` is cast into
`ZMod N`; complete wraps are retained correctly.

The three public declarations have precisely these contracts:

* `not_mem_affineCyclicBadResidues_iff`: for arbitrary natural `N,M,a,beta`
  and `h : ZMod N`, nonmembership is equivalent to
  `h+k ≠ 0 ∧ (e=0 ∨ h+k ≠ -1)`. This is purely a ring/Finset identity, so
  no positive-modulus assumption is needed, even for `N=0,1` or `M=0`.
* `affineCyclicBadResidues_not_mem_iff_modular_band`: for natural
  `N,M,a,beta,h`, assuming only `2≤N` and `0<M`, nonmembership of the cast of
  `h` is equivalent to
  `M ≤ (h*M+a*beta) % (N*M) ≤ (N-1)*M`.
  In particular, `h<N`, `a<M`, primality, parity and correction bounds are
  absent. Both inequalities are closed.
* `circleNorm_affine_grid_iff_not_mem_bad_residues`: for natural
  `N,M,s,r0,r,beta,a,u`, assuming `2≤N`, `0<M`, `u ≡ a [MOD M]`,
  `N*r=M*r0+beta`, and `a<M`,
  `1/N ≤ circleNorm ((s/N+r/M)*u)` is equivalent to nonmembership of
  `s*u+r0*a` in the bad set. The original speed is `u`; replacing `s*u`
  by `s*a` is invalid. Zero actual offsets, zero bases, `N|M`, and large
  corrections remain allowed. The natural inputs and `a<M` hypothesis of
  this last theorem are retained; the unrestricted local band theorem does
  not silently enlarge the actual-phase theorem's contract.

No declaration supplies affine parameters, an envelope, a normalization, or an
LRC witness. These are exact arithmetic equivalences, not a global supply result.

## Independent proof audit

For `M>0`, write `a*beta=M*k+e`, `0≤e<M`, and set `d=(h+k)%N`.
Euclidean division of `h+k`, followed by `0≤d*M+e<N*M`, gives

`(h*M+a*beta)%(N*M) = d*M+e`.

This holds for every natural `h,a,beta`, regardless of their heights. The source
first proves this identity for arbitrary `x=a*beta`, using an exact natural
equality and a strict remainder bound; it does not assume that a raw numerator
has not wrapped.

The lower band inequality holds exactly when `d≠0`: if `d=0`, then `e<M`,
while `d≥1` gives `d*M+e≥M`. For the upper inequality, all `d≤N-2` work;
`d=N-1` works exactly when `e=0`. Therefore the complete band condition is

`d≠0 ∧ (e=0 ∨ d≠N-1)`.

Transporting these two equalities through natural casts and `ZMod.val` yields
exactly the singleton/pair definition. In particular, an integral correction
keeps the upper endpoint, so always using a two-element set would be false.
For `N=2`, the nonintegral pair is the entire residue ring and the good band
is empty; the integral case retains the midpoint. For `M=1`, the remainder
is always zero and the singleton formulation still works.

The actual-phase theorem composes the already reviewed numerator equivalence
with this local result at `h=(s*u+r0*a)%N`, then uses the natural-cast-of-mod
identity. It loses neither the actual offset nor the converse implication.
The code's only nonconstructive ingredients are the standard axioms below;
there is no field assumption or computational trust shortcut.

## Kernel checks and exact controls

Under pinned `leanprover/lean4:v4.32.1`, fresh source compilation passed:

```sh
export PATH="$HOME/.elan/bin:$PATH"
lake env lean LonelyRunner/AffineCyclicBadResidues.lean
```

The following batch also compiles the source text afresh, then checks all public
types, prints axioms, and proves 13 independent edge examples. The three axiom
outputs are respectively `[propext, Quot.sound]`,
`[propext, Classical.choice, Quot.sound]`, and
`[propext, Classical.choice, Quot.sound]`. A source scan for `sorry`, `admit`,
`axiom`, `native_decide`, and `unsafe` found no occurrences. No full root build
or cache mutation was performed by this review.

```python
from pathlib import Path
import subprocess
src = Path('LonelyRunner/AffineCyclicBadResidues.lean').read_text()
probes = r'''
open LonelyRunner
#check affineCyclicBadResidues
#check not_mem_affineCyclicBadResidues_iff
#check affineCyclicBadResidues_not_mem_iff_modular_band
#check circleNorm_affine_grid_iff_not_mem_bad_residues
#print axioms not_mem_affineCyclicBadResidues_iff
#print axioms affineCyclicBadResidues_not_mem_iff_modular_band
#print axioms circleNorm_affine_grid_iff_not_mem_bad_residues

-- Both integral endpoints: composite N, a>=M, h>=N, and complete wraps.
example : (5 : ZMod 4) ∉ affineCyclicBadResidues 4 3 5 6 := by
  apply (affineCyclicBadResidues_not_mem_iff_modular_band 4 3 5 6 5
    (by norm_num) (by norm_num)).mpr
  norm_num
example : (7 : ZMod 4) ∉ affineCyclicBadResidues 4 3 5 6 := by
  apply (affineCyclicBadResidues_not_mem_iff_modular_band 4 3 5 6 7
    (by norm_num) (by norm_num)).mpr
  norm_num
-- A nonintegral correction crosses the upper boundary, not the lower one.
example : (5 : ZMod 4) ∈ affineCyclicBadResidues 4 7 5 15 := by
  classical
  by_contra h
  have := (affineCyclicBadResidues_not_mem_iff_modular_band 4 7 5 15 5
    (by norm_num) (by norm_num)).mp h
  norm_num at this
example : (7 : ZMod 4) ∉ affineCyclicBadResidues 4 7 5 15 := by
  apply (affineCyclicBadResidues_not_mem_iff_modular_band 4 7 5 15 7
    (by norm_num) (by norm_num)).mpr
  norm_num
-- N=2: the nonintegral pair fills the ring; the integral midpoint survives.
example : (7 : ZMod 2) ∈ affineCyclicBadResidues 2 3 4 1 := by
  classical
  by_contra h
  have := (affineCyclicBadResidues_not_mem_iff_modular_band 2 3 4 1 7
    (by norm_num) (by norm_num)).mp h
  norm_num at this
example : (7 : ZMod 2) ∉ affineCyclicBadResidues 2 3 6 1 := by
  apply (affineCyclicBadResidues_not_mem_iff_modular_band 2 3 6 1 7
    (by norm_num) (by norm_num)).mpr
  norm_num
-- M=1, even composite N, large local base and quotient.
example : (10 : ZMod 6) ∉ affineCyclicBadResidues 6 1 13 7 := by
  apply (affineCyclicBadResidues_not_mem_iff_modular_band 6 1 13 7 10
    (by norm_num) (by norm_num)).mpr
  norm_num
example : (11 : ZMod 6) ∈ affineCyclicBadResidues 6 1 13 7 := by
  classical
  by_contra h
  have := (affineCyclicBadResidues_not_mem_iff_modular_band 6 1 13 7 11
    (by norm_num) (by norm_num)).mp h
  norm_num at this
-- Zero base preserves the closed upper endpoint.
example : (3 : ZMod 4) ∉ affineCyclicBadResidues 4 7 0 100 := by
  apply (affineCyclicBadResidues_not_mem_iff_modular_band 4 7 0 100 3
    (by norm_num) (by norm_num)).mpr
  norm_num
-- Zero actual offset and N|M; the actual phase is 3/2.
example : (4 : ℝ)⁻¹ ≤ circleNorm (((1 : ℝ) / 4 + (1 : ℝ) / 8) * 4) := by
  have hh : ((1*4+0*4 : ℕ) : ZMod 4) ∉ affineCyclicBadResidues 4 8 4 4 := by
    apply (affineCyclicBadResidues_not_mem_iff_modular_band 4 8 4 4 4
      (by norm_num) (by norm_num)).mpr
    norm_num
  have he := (circleNorm_affine_grid_iff_not_mem_bad_residues 4 8 1 0 1 4 4 4
    (by norm_num) (by norm_num) (by rfl) (by norm_num) (by norm_num)).mpr hh
  simpa only [Nat.cast_ofNat, Nat.cast_one] using he
-- Actual speed cannot be replaced by its congruent base in s*u.
example : ¬ (5 : ℝ)⁻¹ ≤ circleNorm (((4 : ℝ) / 5 + (3 : ℝ) / 7) * 9) := by
  intro h
  have hh := (circleNorm_affine_grid_iff_not_mem_bad_residues 5 7 4 1 3 8 2 9
    (by norm_num) (by norm_num) (by decide) (by norm_num) (by norm_num)).mp h
  have := (affineCyclicBadResidues_not_mem_iff_modular_band 5 7 2 8 38
    (by norm_num) (by norm_num)).mp hh
  norm_num at this
-- The ring identity alone also supports degenerate modulus cases.
example : (7 : ZMod 0) ∉ affineCyclicBadResidues 0 0 2 3 := by
  rw [not_mem_affineCyclicBadResidues_iff]
  norm_num
example : (0 : ZMod 1) ∈ affineCyclicBadResidues 1 0 2 3 := by
  classical
  by_contra h
  rw [not_mem_affineCyclicBadResidues_iff] at h
  simp at h
'''
subprocess.run(['lake', 'env', 'lean', '--stdin'],
               input=src + probes, text=True, check=True)
```

Independent standard-library arithmetic replay passed **39,312 local cases**,
**11,907 actual-phase cases**, and **3 mutation controls**. It compares the bad
set with a direct `Fraction` circle-distance calculation; it imports no project
checker. The local replay includes 24,024 cases with `a≥M`, 22,680 with `h≥N`,
13,224 with quotient at least `N`, 22,466 integral and 16,846 nonintegral
corrections, 1,620 cases at `N=2`, 2,912 at `M=1`, 5,572 with `N|M`, and
4,567/3,971 cases at the lower/upper band endpoint. The actual replay includes
3,186 zero actual offsets, 2,916 cases with `N|M`, 4,032 corrections larger
than `N*M`, 1,134 zero speeds, and 1,632 exact distance equalities. Categories
overlap. These finite controls supplement the universal kernel proof.

```python
from collections import Counter
from fractions import Fraction as Q
from itertools import product

def norm(x):
    f = x - x.numerator // x.denominator
    return min(f, 1-f)

def bad(N, M, a, beta):
    k, e = divmod(a*beta, M)
    return {(-k)%N} if e == 0 else {(-k)%N, (-k-1)%N}

local = Counter()
for N in range(2, 9):
  for M in range(1, 7):
    for a, beta, h in product(range(2*M+2), range(N+3), range(2*N+2)):
      k, e = divmod(a*beta, M)
      d = (h+k)%N
      z = (h*M+a*beta)%(N*M)
      good = norm(Q(h*M+a*beta, N*M)) >= Q(1, N)
      assert z == d*M+e
      assert good == (M <= z <= (N-1)*M) == (h%N not in bad(N,M,a,beta))
      assert good == (d != 0 and (e == 0 or d != N-1))
      assert len(bad(N,M,a,beta)) == (1 if e == 0 else 2)
      local['cases'] += 1
      for label, condition in [('a_ge_M', a>=M), ('h_ge_N', h>=N),
          ('quotient_ge_N', k>=N), ('integral', e==0), ('nonintegral', e!=0),
          ('N_eq_2', N==2), ('M_eq_1', M==1), ('N_divides_M', M%N==0),
          ('lower_equality', z==M), ('upper_equality', z==(N-1)*M)]:
        local[label] += condition

actual = Counter()
for N in range(2, 9):
  for M in range(1, 7):
    for a, q, r0, s, j in product(range(M), (0,1,N+1), (0,1,N),
                                  (0,1,N+2), (0,1,N*M+1)):
      u = a+q*M
      r = (M*r0+N-1)//N+j
      beta = N*r-M*r0
      H = s*u+r0*a
      t = Q(s,N)+Q(r,M)
      good = norm(t*u) >= Q(1,N)
      assert good == (H%N not in bad(N,M,a,beta))
      actual['cases'] += 1
      for label, condition in [('zero_actual_offset', u%N==0),
          ('N_divides_M', M%N==0), ('large_correction', beta>N*M),
          ('s_ge_N', s>=N), ('r0_ge_N', r0>=N), ('u_zero', u==0),
          ('closed_equality', norm(t*u)==Q(1,N))]:
        actual[label] += condition

# Wrong always-pair and always-singleton definitions fail opposite endpoints.
N,M,a,beta,h = 4,3,5,6,5
k,e = divmod(a*beta,M)
assert e==0 and norm(Q(h*M+a*beta,N*M))==Q(1,N)
assert h%N in {(-k)%N,(-k-1)%N} and h%N not in bad(N,M,a,beta)
N,M,a,beta,h = 4,7,5,15,5
k,e = divmod(a*beta,M)
assert e>0 and h%N not in {(-k)%N} and h%N in bad(N,M,a,beta)
# Wrong actual-offset substitution gives a false positive.
N,M,s,r0,r,beta,a,u = 5,7,4,1,3,8,2,9
assert (s*u+r0*a)%N in bad(N,M,a,beta)
assert ((s+r0)*a)%N not in bad(N,M,a,beta)
assert norm((Q(s,N)+Q(r,M))*u)==Q(2,35)<Q(1,N)
assert local['cases'] == 39312 and actual['cases'] == 11907
print('LOCAL', dict(sorted(local.items())))
print('ACTUAL', dict(sorted(actual.items())))
print('MUTATION_CONTROLS', 3)
```

The review accepts the exact frozen source for its stated equivalences. It does
not add a two-bad-residue supply theorem, a weighted envelope bridge, or any
resolution of the unrestricted Lonely Runner conjecture.
