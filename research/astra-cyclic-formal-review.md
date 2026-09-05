# Independent review of the exact affine cyclic-band equivalence

Verdict: **accepted without source corrections**, 2026-09-05.

Reviewed the complete frozen `LonelyRunner/AffineGridCyclic.lean`, SHA-256
`b4b42a0dd0f00730c2fbd45814a362a7e30248c97c234fd4d7ed72c7bf521e4b`.
The imported exact rational-distance bridge was also inspected in
`LonelyRunner/PivotResidues.lean`, SHA-256
`362da5ab923f22e900ae7ac821dd4cf4aab91dfe70889987bc9e5a05d19c276a`.
Only this review note was written. The reviewed Lean file and the frozen supply
manuscript were not edited.

## 1. Full contract accepted

The public declaration is
`LonelyRunner.circleNorm_affine_grid_iff_modular_band`. For **all natural numbers**
\(N,M,s,r_0,r,\beta,a,u\), it assumes exactly

\[
 N\ge2,\qquad M>0,\qquad u\equiv a\pmod M,\qquad
 Nr=Mr_0+\beta,\qquad a<M.
\]

With

\[
 t=\frac{s}{N}+\frac rM,\quad
 H=su+r_0a,\quad X=(H\bmod N)M+a\beta,
\]

its conclusion is the equivalence

\[
 \|tu\|\ge\frac1N
 \quad\Longleftrightarrow\quad
 M\le X\bmod(NM)\le(N-1)M.                                  \tag{1.1}
\]

Both inequalities are closed. There is no primality, parity, correction bound,
nonzero-offset, or \(N\nmid M\) hypothesis. Neither grid parameter is required
to be positive or less than \(N\). Actual speed zero and base zero are allowed.
The speed in the norm is the actual \(u\), not a replacement by its base.

This is a single-coordinate arithmetic equivalence. It neither supplies a grid
pair nor proves that a tuple admits suitable normalizations. It does not yet
state the explicit one/two bad-residue characterization after dividing
\(a\beta\) by \(M\), or the weighted whole-envelope bridge.

## 2. Independent derivation and source audit

Since \(0\le a<M\) and \(u\equiv a\pmod M\), let \(q=u/M\). Then
\(u=Mq+a\) exactly in the natural numbers. Define
\(Y=(sM+Nr)u\). Direct expansion gives

\[
\begin{aligned}
Y
 &=Msu+Nr(Mq+a)\\
 &=M(su+r_0a)+NM\,rq+a\beta\\
 &=NM\bigl(\lfloor H/N\rfloor+rq\bigr)
   +(H\bmod N)M+a\beta.
\end{aligned}                                                \tag{2.1}
\]

The private helper proves this equality before reducing modulo \(NM\).
In particular, the staged substitution of \(u=Mq+a\) applies to the second
summand of \(Msu+Nru\); the first \(su\) is retained in \(H\). This is essential
when \(M\) is not divisible by \(N\). It would be invalid to replace \(su\)
by \(sa\) merely from congruence modulo \(M\).

The phase identity is simply \(tu=Y/(NM)\), with positive denominator.
The imported `circleNorm_nat_div_eq` computes its distance exactly as

\[
 \frac{\min(z,NM-z)}{NM},\qquad z=Y\bmod(NM)=X\bmod(NM).
\]

Since \(1/N=M/(NM)\), (1.1) is equivalent to
\(M\le\min(z,NM-z)\). For \(0\le z<NM\) and
\(NM=(N-1)M+M\), this is precisely
\(M\le z\) and \(z\le(N-1)M\). This establishes necessity as well as
sufficiency. The source implements exactly this chain of equivalences, ending
with the natural-number subtraction bounds; there is no one-way estimate
hidden in place of equality.

Reducing the **whole** \(X\) is indispensable: no estimate on the number of
wraps is used. At \(N=2\) the two endpoints coincide, and (1.1) correctly
requires \(z=M\). When \(u=0\), the hypotheses force \(a=0\), and both sides
are false. When \(a=0<u\), the actual \(su\) term remains available, as it must.

No `sorry`, `admit`, `native_decide`, or custom `axiom` occurs in the source.
The proof uses exact arithmetic tactics and the existing kernel-checked
rational-distance equality. No semantic defect or weakened quantifier was found.

## 3. Fresh compilation, interface, and trust checks

Executed independently from the repository root:

```sh
export PATH="$HOME/.elan/bin:$PATH"
lake env lean LonelyRunner/AffineGridCyclic.lean
```

Exit status 0, no diagnostics. The source hash was checked before and after
the review and remained the frozen value above. This was a fresh source
compilation; the parent's earlier targeted build is not being substituted for
this review check.

The following separate stdin invocation checked the exported type, axiom set,
and both directions on concrete boundary/failure examples:

```sh
export PATH="$HOME/.elan/bin:$PATH"
lake env lean --stdin <<'LEAN'
import LonelyRunner.AffineGridCyclic
#check LonelyRunner.circleNorm_affine_grid_iff_modular_band
#print axioms LonelyRunner.circleNorm_affine_grid_iff_modular_band
#check LonelyRunner.circleNorm_nat_div_eq
example : (2 : ℝ)⁻¹ ≤ LonelyRunner.circleNorm
    (((1 : ℝ) / 2 + (3 : ℝ) / 3) * (1 : ℕ)) := by
  have hh := (LonelyRunner.circleNorm_affine_grid_iff_modular_band
    2 3 1 0 3 6 1 1 (by decide) (by decide) (by rfl)
    (by norm_num) (by decide)).mpr (by norm_num)
  simpa only [Nat.cast_ofNat, Nat.cast_zero, Nat.cast_one] using hh
example : ¬ (5 : ℝ)⁻¹ ≤ LonelyRunner.circleNorm
    (((1 : ℝ) / 5 + (0 : ℝ) / 3) * (5 : ℕ)) := by
  intro h
  have hiff := LonelyRunner.circleNorm_affine_grid_iff_modular_band
    5 3 1 0 0 0 2 5 (by decide) (by decide) (by rfl)
    (by norm_num) (by decide)
  norm_num only [Nat.cast_ofNat, Nat.cast_zero, Nat.cast_one] at hiff h
  have hb := hiff.mp h
  norm_num at hb
LEAN
```

The final invocation exited 0. Its `#check` output has exactly the hypotheses
and equivalence in Section 1. The public declaration depends on precisely

```text
[propext, Classical.choice, Quot.sound]
```

Initial versions of these review probes required normalization of natural
numeral casts to real numerals; the shown final probes resolve that elaboration
issue without any modification of the reviewed source.

## 4. Independent arithmetic edge controls

The oracle below uses `Fraction` phases directly, independent of project
definitions. It checks both the full integer identity (2.1) and the equivalence
(1.1), with positive and negative outcomes. Its 25,515 cases include 10,493
wrapped numerators, 4,579 with at least ten wraps, 1,768 lower-endpoint cases,
1,737 upper-endpoint cases, 6,156 cases with \(N\mid M\), and 6,642 zero actual
offsets modulo \(N\). These categories overlap.

Focused fixtures list parameters in the order \((N,M,s,r_0,r,\beta,a,u)\):

| Parameters | \(X\) | \(X\bmod NM\) | Exact norm | Purpose |
| --- | --- | --- | --- | --- |
| `(2,3,1,0,3,6,1,1)` | 9 | 3 | 1/2 | Coincident closed endpoints after wrapping |
| `(5,3,1,0,0,0,2,5)` | 0 | 0 | 0 | Actual zero offset; substituting the base is false |
| `(5,3,0,0,4,20,2,2)` | 40 | 10 | 1/3 | Good only after reducing the whole numerator |
| `(4,8,2,1,3,4,3,11)` | 20 | 20 | 3/8 | Even composite \(N\), \(N\mid M\), positive lift |
| `(4,5,1,0,5,20,1,1)` | 25 | 5 | 1/4 | Wrapped lower boundary |
| `(4,5,1,0,5,20,3,3)` | 75 | 15 | 1/4 | Wrapped upper boundary |
| `(4,5,0,0,1,4,1,1)` | 4 | 4 | 1/5 | One integer below the lower band |
| `(4,5,0,0,4,16,1,1)` | 16 | 16 | 1/5 | One integer above the upper band |
| `(3,1,1,5,2,1,0,1)` | 1 | 1 | 1/3 | \(M=1\), zero base, positive actual speed |
| `(4,8,1,0,1,4,4,4)` | 16 | 16 | 1/2 | Zero homogeneous form rescued by correction |

The second and third rows also detect two concrete incorrect modifications.
Replacing \(su\) by \(sa\) would classify the second row as good: its incorrect
residue is 6, although the actual phase is the integer 1. Omitting the outer
modulus would classify the third row as bad, although its exact norm is \(1/3\).
Thus the controls exercise the two essential transport decisions.

```python
from fractions import Fraction as F
from collections import Counter

stats = Counter()
for N in range(2, 9):
    for M in range(1, 10):
        for a in range(M):
            for q in (0, 1, 7):
                u = a+q*M
                for s in (0, 1, N+2):
                    for r0 in (0, 1, N+1):
                        ceiling = (M*r0+N-1)//N
                        for extra in (0, 1, N*M+3):
                            r = ceiling+extra
                            beta = N*r-M*r0
                            H = s*u+r0*a
                            X = (H % N)*M+a*beta
                            Y = (s*M+N*r)*u
                            D = N*M
                            z = X % D
                            phase = (F(s, N)+F(r, M))*u
                            norm = min(phase % 1, (-phase) % 1)
                            good = norm >= F(1, N)
                            assert Y == D*(H//N+r*(u//M))+X
                            assert phase == F(Y, D)
                            assert Y % D == z
                            assert good == (M <= z <= (N-1)*M)
                            stats['cases'] += 1
                            stats['good' if good else 'bad'] += 1
                            for name, flag in (
                                ('wrapped', X >= D), ('many_wraps', X >= 10*D),
                                ('lower_endpoint', z == M),
                                ('upper_endpoint', z == (N-1)*M),
                                ('N_divides_M', M % N == 0),
                                ('zero_actual', u == 0),
                                ('positive_actual_zero_base', u > 0 and a == 0),
                                ('zero_offset', u % N == 0)):
                                stats[name] += bool(flag)
assert dict(stats) == {
    'cases': 25515, 'bad': 12029, 'wrapped': 10493, 'many_wraps': 4579,
    'lower_endpoint': 1768, 'upper_endpoint': 1737, 'N_divides_M': 6156,
    'zero_actual': 1701, 'positive_actual_zero_base': 3402,
    'zero_offset': 6642, 'good': 13486}

fixtures = (
    ((2,3,1,0,3,6,1,1), 9,3,F(1,2)),
    ((5,3,1,0,0,0,2,5), 0,0,F(0)),
    ((5,3,0,0,4,20,2,2), 40,10,F(1,3)),
    ((4,8,2,1,3,4,3,11), 20,20,F(3,8)),
    ((4,5,1,0,5,20,1,1), 25,5,F(1,4)),
    ((4,5,1,0,5,20,3,3), 75,15,F(1,4)),
    ((4,5,0,0,1,4,1,1), 4,4,F(1,5)),
    ((4,5,0,0,4,16,1,1), 16,16,F(1,5)),
    ((3,1,1,5,2,1,0,1), 1,1,F(1,3)),
    ((4,8,1,0,1,4,4,4), 16,16,F(1,2)))
for params, expected_X, expected_z, expected_norm in fixtures:
    N,M,s,r0,r,beta,a,u = params
    assert N >= 2 and M > 0 and a < M and u % M == a
    assert N*r == M*r0+beta
    X = ((s*u+r0*a) % N)*M+a*beta
    z = X % (N*M)
    phase = (F(s, N)+F(r, M))*u
    norm = min(phase % 1, (-phase) % 1)
    assert (X, z, norm) == (expected_X, expected_z, expected_norm)
    assert (norm >= F(1,N)) == (M <= z <= (N-1)*M)

# Deliberately incorrect formulas are rejected by the selected controls.
N,M,s,r0,r,beta,a,u = 5,3,1,0,0,0,2,5
wrong_X = ((s*a+r0*a) % N)*M+a*beta
assert M <= wrong_X % (N*M) <= (N-1)*M
assert fixtures[1][3] < F(1,N)
N,M,s,r0,r,beta,a,u = 5,3,0,0,4,20,2,2
X = ((s*u+r0*a) % N)*M+a*beta
assert not M <= X <= (N-1)*M
assert M <= X % (N*M) <= (N-1)*M
print(dict(stats))
print('10 focused fixtures and 2 mutation controls passed')
```

Run the exact block from the repository root:

```sh
python3 - <<'PY'
from pathlib import Path
text = Path('research/astra-cyclic-formal-review.md').read_text()
source = text.split('```python\n', 1)[1].split('\n```', 1)[0]
exec(compile(source, 'astra-cyclic-formal-review.md:oracle', 'exec'))
PY
```

The block passed with exit status 0; the counts are asserted in the reproducer.
Workflow structural validation also passed. These finite controls supplement
the unrestricted source proof and trust audit; they do not replace them.

The accepted scope is exactly (1.1). No theorem asserting a common good pair,
weighted-envelope supply, or canonical LRC follows merely from this review.
