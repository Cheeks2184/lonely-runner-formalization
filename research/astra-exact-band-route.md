# Exact cyclic bands and weighted affine avoidance

Status: manuscript proofs and exact small controls, 2026-09-05. This pass changes
only this note. It supplies a stronger sufficient affine lemma and an arithmetic
bridge that handles the tuple excluded by the earlier coarse contracts. It does
not prove unrestricted normalization supply or the Lonely Runner Conjecture.
The new cyclic transport and weighted lemma are not yet Lean declarations.

## 1. Source scope and the question

The frozen obstruction in `research/astra-union-obstruction.md` proves that

\[
 p=7,\qquad V=(2,3,4,7,14,9)
\]

has no normalization in the earlier A/B/coarse-C/robust-multiple-zero union,
allowing all admitted moduli, common units, signs, and lifts. Its strict witness
is nevertheless \(t=1/5\), with minimum distance \(1/5\). The obstruction concerns
those sufficient contracts only.

The present question is whether row-dependent exact correction bands support a
new **a priori** choice of an affine pair. Merely checking exact bands after a
pair has been supplied does not answer this question. The result below uses a
single set for each row that contains its bad residues for **every** prescribed
rounding choice. Two cardinality bounds then supply a pair.

Source SHA-256 values inspected for this pass:

| Source | SHA-256 |
| --- | --- |
| `LonelyRunner/AffineAvoidance.lean` | `9fb78dc2b12694f096ac423c04835f3f961e0769dc6d5ae6180033d6004f22c0` |
| `LonelyRunner/AffineGridArithmetic.lean` | `0be8553d88fed2346895abcaeb961d0fb2967ee8db356feff8877ceb8b49b079` |
| `LonelyRunner/AffineGrid.lean` | `ea7f4c3058f486dd29c3624d914251d37b9f85d24cca2a7152e0e796a9dc46a8` |
| `research/astra-union-obstruction.md` | `3e6a7dc493a649ce786fe49d0ec8d94dd7555c75a11c21da6cbd8253e9238578` |
| `research/astra-pass8-review.md` | `600dfe2cbb7ccbf4cf6395d88403a187ed88302fb7a632fec764f359bbeecaa9` |

No external mathematical claim or literature novelty claim is needed here.

## 2. Weighted homogeneous avoidance

**Lemma.** Let \(p\) be an odd prime, \(I\) a finite index set, and let
\(a_i,v_i\in\mathbb F_p\). For every \(i\), prescribe a subset
\(F_i\subseteq\mathbb F_p\) containing zero. Define

\[
 D=\{z\in\mathbb F_p^*: \exists i,\ a_i+zv_i=0\},\qquad
 W=\sum_{i\in I}(|F_i|-1).
\]

If \(|D|\le p-2\) and \(W\le p-2\), there exist
\(r_0,s\in\mathbb F_p^*\) such that

\[
 r_0a_i+sv_i\notin F_i\quad\text{for every }i\in I.
\]

**Proof.** Choose \(z\in\mathbb F_p^*\setminus D\), and put
\(\ell_i=a_i+zv_i\ne0\). Among the \(p-1\) nonzero scales \(r_0\), row \(i\)
forbids exactly the \(|F_i|-1\) scales \(f/\ell_i\),
\(f\in F_i\setminus\{0\}\). Their union has size at most \(W\le p-2\).
Choose a remaining scale and set \(s=zr_0\). Then
\(r_0a_i+sv_i=r_0\ell_i\notin F_i\). Both parameters are nonzero. \(\square\)

In particular, \(|I|\le p-2\) and \((a_i,v_i)\ne(0,0)\) for every row imply
the direction bound: each row excludes at most one nonzero ratio. This includes
repeated slopes and repeated offsets. If every offset is zero and every slope
is nonzero, \(D\) is empty. A row with slope zero and offset nonzero also excludes
no nonzero ratio.

Both bounds matter. A row with both coefficients zero cannot avoid a set
containing zero; then \(D=\mathbb F_p^*\), and the stated hypothesis fails.
Even with no such row, many singleton sets \(F_i=\{0\}\) can have weight zero
while their excluded ratios exhaust \(\mathbb F_p^*\). For example the forms
\(a_z=-z,v_z=1\), indexed by every \(z\ne0\), do this.

Taking \(F_i=\{0,-1\}\) and at most \(p-2\) nonzero forms recovers the
current two-value sufficient bound. The weighted statement allows larger sets
when other rows leave enough capacity. It is an elementary extension of that
sufficient bound, with no distinctness or product-of-slopes assumption.
It does not replace the separate full-size product argument in all its cases.

## 3. Exact cyclic bad residues, including endpoints

For \(p\ge2\), integers \(M>0\), \(a,\beta\ge0\), write

\[
 a\beta=Mk+e,\qquad 0\le e<M.
\]

Define a subset of \(\mathbb Z/p\mathbb Z\) by

\[
 B(a,\beta)=
 \begin{cases}
 \{-k\},&e=0,\\
 \{-k,-k-1\},&e>0.
 \end{cases}                                                    \tag{3.1}
\]

For an integer representative \(h\in\{0,\ldots,p-1\}\), the exact equivalence is

\[
 \left\|\frac{hM+a\beta}{pM}\right\|\ge\frac1p
 \quad\Longleftrightarrow\quad [h]_p\notin B(a,\beta).            \tag{3.2}
\]

Indeed, reduce \(h+k\) modulo \(p\). If \(e=0\), the good residues are
\(1,\ldots,p-1\): the endpoints both attain the closed threshold. If \(e>0\),
the good residues are \(1,\ldots,p-2\), since the additional fractional part is
strictly between zero and one. This proves (3.2), including when \(k\ge p\).
In particular, an exact integer correction forbids **one**, not two, residues.

For transport, let \(u\equiv a\pmod M\), \(0\le a<M\), and suppose

\[
 pr=Mr_0+\beta,\qquad h=(su+r_0a)\bmod p.
\]

Writing \(u=a+Md\), direct arithmetic gives

\[
 u\left(\frac{s}{p}+\frac rM\right)
 =\left\lfloor\frac{su+r_0a}{p}\right\rfloor+rd
  +\frac{hM+a\beta}{pM}.                                      \tag{3.3}
\]

Thus (3.2) transfers exactly to the speed \(u\). Integer periodicity permits
cyclic wrapping. The compiled
`circleNorm_ge_of_affine_grid_residue_band` proves the sufficient **unwrapped**
condition \(M\le hM+a\beta\le(p-1)M\). It must not be cited as already proving
the more general cyclic equivalence (3.2). Equation (3.3) supplies the manuscript
proof of the cyclic extension. The specific controls in Section 5 also satisfy
the unwrapped condition.

## 4. A priori rounding-envelope bridge

Here is a complete arithmetic corollary with all \(p-1\) coordinates retained.
Let \(p\) be an odd prime and \(M>0\). Let disjoint finite sets \(I,J\) satisfy
\(|I|+|J|=p-1\). For \(i\in I\), take positive actual speeds \(u_i\) and bases
\(0\le a_i<M\) with \(u_i\equiv a_i\pmod M\). For \(j\in J\), take positive
actual speeds \(U_j\) and bases \(0\le A_j<M\) such that

\[
 U_j\equiv A_j\pmod M,\qquad p\mid U_j,\qquad p\mid A_j.
\]

**Before selecting any affine pair**, prescribe functions \(R,\beta\) from
\(\{1,\ldots,p-1\}\) to the nonnegative integers such that, for every \(r_0\),

\[
 pR(r_0)=Mr_0+\beta(r_0).                                      \tag{4.1}
\]

Require, for every \(j\in J\) and every \(r_0\in\{1,\ldots,p-1\}\),

\[
 M\le (A_j\beta(r_0)\bmod pM)\le(p-1)M.                       \tag{4.2}
\]

Prescribe the constant envelopes

\[
 F_i=\{0\}\ \cup\!!\bigcup_{r_0=1}^{p-1}B(a_i,\beta(r_0)).   \tag{4.3}
\]

Compute \(D\) from the forms \(([a_i]_p,[u_i]_p)\) as in Section 2. If

\[
 |D|\le p-2,\qquad \sum_{i\in I}(|F_i|-1)\le p-2,             \tag{4.4}
\]

there exist integers \(1\le r_0,s\le p-1\) such that at

\[
 t=\frac{s}{p}+\frac{R(r_0)}{M}
\]

every one of the \(p-1\) actual speeds has circle distance at least \(1/p\).

**Proof.** Apply the weighted lemma to (4.3). For its chosen \(r_0,s\), each
ordinary residue avoids its particular set \(B(a_i,\beta(r_0))\), so (3.2)
and (3.3) apply. Every \(J\)-row has homogeneous residue zero regardless of
the pair; (4.2) and (3.3) give its bound. \(\square\)

There is no condition \(p\nmid M\). Ordinary actual offsets may all vanish;
the direction bound still holds when their slopes are nonzero. The \(J\)-rows
are not dropped: they have a uniform correction guarantee. The quantifier over
**all** prescribed \(r_0\) in (4.2) and (4.3) is essential. Freezing a bad set
at a convenient correction and subsequently finding an incompatible affine
pair would not prove the bridge.

For a normalization of original positive speeds \(V_k\), a sufficient precise
transport contract is: a common positive integer \(b\) with \(\gcd(b,M)=1\),
signs \(\epsilon_k\in\{-1,1\}\), and positive actual representatives \(W_k\)
satisfying

\[
 W_k\equiv\epsilon_k bV_k\pmod{pM}.                           \tag{4.5}
\]

Use the \(W_k\) as the actual speeds above. Since
\(t=(sM+pR(r_0))/(pM)\), (4.5) gives
\(\|W_kt\|=\|bV_kt\|\); hence \(bt\) is a common original-speed witness.
Independent signs and additions of \(pM\) do not change these distances on
this grid. Congruence only modulo \(M\) does **not** suffice for (4.5), and
no off-grid perturbation is being used. The unit restriction is preserved,
although this last phase identity itself needs only (4.5).

## 5. The former obstruction tuple now has an a priori certificate

Take \(p=7\), \(M\ge89\), ordinary bases \((2,3,4,9)\), and zero bases
\((7,14)\). Initially let the actual speeds equal these bases. Prescribe

\[
 R(r_0)=\left\lceil\frac{Mr_0}{7}+\frac{M}{49}\right\rceil,
 \qquad \beta(r_0)=7R(r_0)-Mr_0.
\]

Uniformly in \(r_0=1,\ldots,6\),

\[
 \frac M7\le\beta<\frac M7+7.
\]

Consequently

\[
 M\le7\beta<M+49,\quad 2M\le14\beta<2M+98\le6M,
\]
\[
 0<a\beta<M\quad(a=2,3,4),\qquad M<9\beta<2M.                 \tag{5.1}
\]

For the last upper bound use \(9\beta<9M/7+63\le2M\), valid for integer
\(M\ge89\). The other bounds are weaker at this cutoff. Thus

\[
 F_2=F_3=F_4=\{0,-1\},\qquad F_9=\{0,-1,-2\},
\]

with weight \(1+1+1+2=5=p-2\). There are only four ordinary rows, each with a
nonzero slope, so the direction condition holds even for arbitrary actual
offsets. All six rows satisfy the bridge. This argument chooses the envelopes
and proves their bounds without assuming or using the known witness \(1/5\).

The same hypotheses permit positive ordinary lifts congruent to the four bases
modulo \(M\), and positive zero actual speeds divisible by 7 and congruent to
7 and 14 modulo \(M\). Original-speed transport additionally needs (4.5).

Concrete exact controls, in the original order \((2,3,4,7,14,9)\):

| \(M,b\) | \((r_0,s,R,\beta)\) | Positive actual representatives modulo \(7M\) | Original time modulo 1 | Minimum distance |
| --- | --- | --- | --- | --- |
| \(101,1\) | \((2,6,31,15)\) | \((2,3,4,7,14,9)\) | \(116/707\) | \(15/101\) |
| \(98,1\) | \((2,6,30,14)\) | \((2,3,4,7,14,9)\) | \(8/49\) | \(1/7\) |
| \(101,203\) | \((1,1,17,18)\) | \((406,609,105,7,14,413)\) | \(17/101\) | \(18/101\) |

The middle example has \(7\mid M\) and attains the closed boundary. In the
last example \(\gcd(203,101)=1\), \(203\equiv1\pmod{101}\), and every actual
speed is divisible by 7. The ordinary slopes are still \((2,3,4,2)\), including
a repeated slope. These controls test precisely the regimes that a claim
requiring nonzero actual offsets or \(7\nmid M\) would incorrectly omit.

Together with the prior all-modulus obstruction, this is a strict gain over
the old **union of sufficient contracts**, at the manuscript level. It is not
a claim that any member of the old union was false, or that arbitrary tuples
now have these envelopes.

## 6. A uniform consequence, with three times and two divisibility cases

The same cyclic calculation gives a clean family without any finite-height
bound. In fact, the elementary family proof works for every **odd integer**
\(N\ge5\) and every \(v>0\). The \(N-1\) speeds

\[
 (2,3,\ldots,N-3,v,N,2N)                                      \tag{6.1}
\]

have a witness at closed threshold \(1/N\). When \(N\nmid v\), a witness is
among the three times

\[
 t_k=\frac{k}{N}+\frac1{N^2},\qquad
 k\in K=\left\{1,\frac{N+1}{2},N-1\right\}.                  \tag{6.2}
\]

For a core speed \(a\in\{2,\ldots,N-3\}\), its correction \(a/N\) lies
strictly between zero and one. Every \(k\in K\) is a unit modulo \(N\), with
inverse respectively \(1,2,-1\). Thus \(ak\ne0\), and the other forbidden
residue \(ak=-1\) would require \(a=N-1,N-2,1\), respectively. All are absent
from the core. Therefore every core row is good at all three times. This
argument does not require every nonzero residue modulo \(N\) to be a unit.

Write \(v/N=q+\theta\), where \(0<\theta<1\). Its exact bad residues for
\(vk\) are the two adjacent residues \(\{-q,-q-1\}\) modulo \(N\). The
images \(v,-v\) are distinct because \(N\) is odd and \(N\nmid v\). If either
is good, we are done. If both are bad, adjacency implies \(2v=1\) or \(-1\)
modulo \(N\), so \(v\) is a unit. Consequently all three images \(vk\),
\(k\in K\), are distinct; the third cannot be in the same two-element set.
This proves the nondivisible case. Speeds \(N,2N\) have distances \(1/N,2/N\)
at all three times, respectively.

For the two remaining cases set \(t_0=(N+1)/N^2\). If \(N\mid v\) but
\(N^2\nmid v\), then \(vt_0\) has a nonzero residue with denominator \(N\),
so its distance is at least \(1/N\). All other rows are already good at \(t_0\).
If \(N^2\mid v\), take instead

\[
 t=t_0+\frac1{Nv}.                                            \tag{6.3}
\]

Then \(vt\) is an integer plus \(1/N\). Since \(v\ge N^2\), a core speed
\(2\le a\le N-3\) has its phase strictly between

\[
 \frac1N < \frac{2(N+1)}{N^2}\le at,
 \qquad
 at<1-\frac2N-\frac3{N^2}+\frac1{N^2}<1-\frac1N.
\]

The zero rows have fractional parts \(1/N+1/v\) and \(2/N+2/v\), both in
\([1/N,1-1/N]\). For the larger upper bound use
\(2/N+2/N^2\le1-1/N\), equivalently \(3N+2\le N^2\), true for \(N\ge5\).
This proves the remaining cases with the original speeds directly; there is
no off-grid transfer from separately lifted signed representatives.

For **prime** \(N=p\) with \(p\nmid v\), the three-time case is also literally
an instance of the envelope bridge: choose a multiple
\(M\) of \(p^2\) exceeding every speed, take the bases equal to the speeds,
and set

\[
 R(r_0)=\frac{Mr_0}{p}+\frac{M}{p^2},\qquad \beta=M/p.
\]

All corrections are constant. The core contributes weight \(p-4\), the
extra row contributes at most 2 after adjoining zero, and \(D=\{-1\}\).
The zero rows are automatically good. Reducing the resulting time gives
\(k/p+1/p^2\). This application uses cyclic transport when \(v\) is large;
the unwrapped Lean helper alone does not justify it.

The proof holds even if \(v\) duplicates a core or zero speed. For distinctness,
exclude \(v\in\{2,\ldots,N-3,N,2N\}\). Primitivity follows already from the
core speed 2 and the odd speed \(N\). This includes the former escaping family
\(v=(N-2)(N-1)\), and Section 5's \(v=9,N=7\). It is a uniform sufficient
family, not universal supply; no literature novelty is asserted. The general
weighted lemma remains a field result: composite-modulus division in its proof
is unavailable. For example modulo 9 the single form \(3r_0\) and forbidden
set \(\{0,3,6\}\) fail its conclusion despite the analogous cardinality bounds.

## 7. Why unrestricted shifted-pair avoidance is false

Take \(p=7\), five rows, every slope 1 and every actual offset zero. For
shifts \(k=(0,1,2,3,5)\), their forbidden pairs are

\[
 \{0,6\},\ \{6,5\},\ \{5,4\},\ \{4,3\},\ \{2,1\}.
\]

They cover the field. Every row's form equals \(r_0\), so there is no pair
\((r_0,s)\in\mathbb F_7^2\) avoiding all five, even when zero parameters are
allowed. Thus the old \(p-2\)-row statement cannot simply replace its common
pair by arbitrary translated pairs.

These shifts can occur in real arithmetic correction bands. Set

\[
 M=101,\quad\beta=15,\quad a=(1,8,15,22,36),\quad
 u=(203,210,217,224,238).
\]

Every base is less than \(M\) and congruent to 1 modulo 7; every actual
speed is zero modulo 7 and congruent to its base modulo \(M\). Moreover
\(\lfloor a_i\beta/M\rfloor=(0,1,2,3,5)\), with all remainders positive.
Compatibility \(7r=101r_0+15\) forces \(r_0=2\) in the field; for its
representative 2 take \(r=31\). Every time \(s/7+31/101\), \(s=0,\ldots,6\),
fails at least one of these actual speeds.

One may retain a full six-coordinate control by adding \(A=U=7\), whose
correction is safely \(105\) between \(M\) and \(6M\). Taking common unit
\(b=7\) gives original speeds \((29,30,31,32,34,1)\), a primitive distinct
tuple, and all actual representatives equal seven times the original speeds.
This only refutes supply at the stated fixed correction; it does not exclude
different rounding functions, moduli, or original witness times.

Adjoining zero to the five displayed forbidden pairs gives weight
\(1+2+2+2+2=9>5\). Thus there is no conflict with the weighted lemma. Arithmetic
origin alone does not prevent translated pairs from covering the field.

## 8. Exact controls and the remaining mathematical gap

The following standard-library Python reproducer checks 53,848 weighted field
cases, 9,504 exact cyclic signs including integer corrections and wrapping,
the three original-speed controls, the translated-pair obstruction, and 1,335
family controls, including composite moduli and both divisibility cases. The
last controls are only tests of the uniform
proof in Section 6; the proof is not inferred from them.

Run from any directory with Python 3; no Lean build or dependency cache is needed.

```python
from itertools import product
from fractions import Fraction as F
from math import ceil, gcd

weighted = 0
for p in (3, 5):
    forms = [(a, u) for a, u in product(range(p), repeat=2) if a or u]
    sets = [{0} | {j+1 for j in range(p-1) if mask >> j & 1}
            for mask in range(1 << (p-1))]
    pairs = list(product(range(1, p), repeat=2))
    for rows in product(forms, repeat=2):
        D = {z for z in range(1, p)
             if any((a+z*u) % p == 0 for a, u in rows)}
        if len(D) > p-2:
            continue
        for F0, F1 in product(sets, repeat=2):
            if len(F0)+len(F1)-2 > p-2:
                continue
            assert any(all((r*a+s*u) % p not in bad
                           for (a, u), bad in zip(rows, (F0, F1)))
                       for r, s in pairs)
            weighted += 1
assert weighted == 53848

def norm(x):
    return min(x % 1, (-x) % 1)

cyclic = 0
for p in (3, 5, 7):
    for M in range(1, 9):
        for a in range(M):
            for beta in range(3*p+1):
                k, e = divmod(a*beta, M)
                bad = {(-k) % p} if e == 0 else {(-k) % p, (-k-1) % p}
                for h in range(p):
                    assert (h not in bad) == (norm(F(h*M+a*beta, p*M)) >= F(1, p))
                    cyclic += 1
assert cyclic == 9504

V = (2, 3, 4, 7, 14, 9)
expected = ((F(116, 707), F(15, 101)),
            (F(8, 49), F(1, 7)), (F(17, 101), F(18, 101)))
for data, result in zip(((101, 1, 2, 6), (98, 1, 2, 6),
                         (101, 203, 1, 1)), expected):
    M, b, r0, s = data
    betas = [7*ceil(F(M*k, 7)+F(M, 49))-M*k for k in range(1, 7)]
    assert all(M <= 7*z and 14*z <= 6*M for z in betas)
    assert all(0 < a*z < M for z in betas for a in (2, 3, 4))
    assert all(M < 9*z < 2*M for z in betas)
    U = tuple((b*v) % (7*M) or 7*M for v in V)
    r = ceil(F(M*r0, 7)+F(M, 49))
    beta = 7*r-M*r0
    t = F(s, 7)+F(r, M)
    original_time = (b*t) % 1
    assert gcd(b, M) == 1
    assert all((u-b*v) % (7*M) == 0 for u, v in zip(U, V))
    assert all((u-a) % M == 0 for u, a in zip(U, V))
    assert all(norm(u*t) == norm(v*original_time) for u, v in zip(U, V))
    assert all(M <= ((s*u+r0*a) % 7)*M+a*beta <= 6*M
               for u, a in zip(U, V))
    assert (original_time, min(norm(v*original_time) for v in V)) == result

shifts = (0, 1, 2, 3, 5)
bad_sets = [{(-k) % 7, (-k-1) % 7} for k in shifts]
assert set.union(*bad_sets) == set(range(7))
assert not any(all(r not in bad for bad in bad_sets)
               for r, s in product(range(7), repeat=2))
a = (1, 8, 15, 22, 36)
U = (203, 210, 217, 224, 238)
assert tuple(v*15//101 for v in a) == shifts
assert all(v % 7 == 1 and u % 7 == 0 and (u-v) % 101 == 0
           for v, u in zip(a, U))
assert all(v*15 % 101 for v in a)
for s in range(7):
    t = F(s, 7)+F(31, 101)
    assert min(norm(u*t) for u in U) < F(1, 7)
    assert norm(7*t) >= F(1, 7)

family = 0
for p in (5, 7, 9, 11, 13):
    K = (1, (p+1)//2, p-1)
    core = tuple(range(2, p-2))
    assert all(norm(F(a*(p*k+1), p*p)) >= F(1, p)
               for k in K for a in core)
    for v in range(1, 3*p*p+1):
        V = core+(v, p, 2*p)
        assert len(V) == p-1
        if v % p:
            times = [F(p*k+1, p*p) for k in K]
        elif v % (p*p):
            times = [F(p+1, p*p)]
        else:
            times = [F(p+1, p*p)+F(1, p*v)]
        assert any(all(norm(a*t) >= F(1, p) for a in V) for t in times)
        family += 1
assert family == 1335
print({'weighted': weighted, 'cyclic': cyclic, 'family': family,
       'bridge_controls': 3, 'shift_counterexample': 'passed'})
```

Executed from the repository root on 2026-09-05 by extracting this exact block:

```sh
python3 - <<'PY'
from pathlib import Path
text = Path('research/astra-exact-band-route.md').read_text()
source = text.split('```python\n', 1)[1].split('\n```', 1)[0]
exec(compile(source, 'astra-exact-band-route.md:reproducer', 'exec'))
PY
```

Exit status 0; exact output:

```text
{'weighted': 53848, 'cyclic': 9504, 'family': 1335, 'bridge_controls': 3, 'shift_counterexample': 'passed'}
```

`python3 scripts/validate_workflow.py` also passed structural validation. No
Lean file changed and no Lean build or cache restoration was performed.

The remaining supply question is precise. For an arbitrary primitive distinct
positive \(p-1\)-tuple, can one always find \(M,b,\epsilon,W\) satisfying
(4.5), a partition and bases as in Section 4, and rounding functions satisfying
(4.1), such that (4.2) and the two bounds (4.4) hold? This note neither proves
that statement nor claims it is easier than unrestricted witness existence.
It is a falsifiable sufficient-supply assertion with explicit finite conditions
once its normalization and rounding data are given.

Even a favorable fixed correction can fail, as Section 7 proves. Letting its
bad sets depend on a pair chosen after the fact would remove the a priori
content. A useful next mathematical step is a uniform bound on the cardinality
of the **whole rounding envelopes**, together with uniform availability of
enough automatic zero rows and a nonexhausted ratio set. The family in Section 6
provides those inputs directly; arbitrary tuples currently do not. Expanding
the bridge to arbitrary exact-band feasibility by itself would only restore
witness search and would not settle this gap.
