# Prompt77 independent mathematical audit

Task: `OPS-P77-MATH-AUDIT-204`

Base commit: `33badb893e0cb82d054ef08f479e2314792f8a65`

Audited response: `research/sol-pro/responses/response77.md`

Immutable response SHA-256:
`c758c5e8759e2b61cb5fc15e4c056e85b9c3551480660006f349944ee72f8835`

## Recommended PI disposition

**Accept the infinite primitive family as a manuscript-level counterexample
to `PRIMITIVE-DEGREE-2N-SIGNED-GRAM-GAP`; stop that bridge; do not change the
status of unrestricted LRC.**

For every pair of integers

\[
6\le u<v,\qquad \gcd(u,v)=1,
\]

the tuple

\[
a=(u,v,4uv)
\]

is positive, injective, and primitive, while its frozen literal six-mode
blocks satisfy

\[
K_1\preceq0,\qquad K_2\preceq0,\qquad K_3=0.
\]

Consequently every block vector has nonpositive signed energy. This directly
refutes the universal primitive signed-Gram gap.

This is not a Lonely Runner counterexample. In fact, every member of the
family has an exact pivot certificate at its third pivot. For the first family
member `(6,7,168)`, `r=29` is an explicit certificate and `t=29/672` is an
exact closed-boundary Lonely Runner witness. No repository evidence label is
promoted by this audit; Sol High retains promotion authority.

## Frozen definitions reconstructed

Here `n=3`, `N=4`, and the pivot moduli are

\[
(M_1,M_2,M_3)=(4u,4v,16uv).
\]

For pivot `j`, reconstruction used exactly

\[
R_j=\{0\le r<M_j:4\nmid r\},\qquad
B_i^j=\{r\in R_j:\rho_{M_j}(ra_i)<a_j\},
\]

where

\[
\rho_M(x)=\min(x\bmod M,M-(x\bmod M)).
\]

The inequality is strict, so equality at the threshold is safe. Put
`mu_j(r)=#{i != j:r in B_i^j}` and `w_j(r)=1-mu_j(r)`. With literal modes
`0,...,5`, the exact matrix entries are

\[
K_j[m,\ell]=\frac1{M_j}\sum_{r\in R_j}w_j(r)
 \exp\!\left(\frac{2\pi i(\ell-m)r}{M_j}\right).
\]

This preserves the full-modulus normalization, candidate exclusion, owner
multiplicity, strict boundary, and literal frequency aliases in the Prompt77
contract.

## Exact family proof

Primitivity is the common-gcd condition, not pairwise coprimality of all three
speeds:

\[
\gcd(u,v,4uv)=\gcd(u,v)=1.
\]

Also `u<v<4uv`, so the tuple is positive and injective.

At pivot `u`, the third speed is a multiple of the entire modulus:

\[
4uv=vM_1.
\]

It is therefore bad at every candidate: `rho_(M_1)(r*4uv)=0<u`. The only
other owner is `v`, so

\[
w_1(r)=-\mathbf1_{B_v^1}(r)
\]

and, for the character-evaluation matrix
`V_M(S)[r,m]=exp(2*pi*i*m*r/M)`, one has

\[
K_1=-\frac1{M_1}V_{M_1}(B_v^1)^*V_{M_1}(B_v^1)\preceq0.
\]

The identical argument with `4uv=uM_2` gives

\[
K_2=-\frac1{M_2}V_{M_2}(B_u^2)^*V_{M_2}(B_u^2)\preceq0.
\]

At pivot `4uv`, multiplication by an owner factor scales cyclic distance
exactly:

\[
\rho_{16uv}(ru)=u\rho_{16v}(r),\qquad
\rho_{16uv}(rv)=v\rho_{16u}(r).
\]

Thus `B_u^3` has period `16v` repeated `u` times, `B_v^3` has period
`16u` repeated `v` times, and `R_3` has period four repeated `4uv` times.
Within one period of `B_u^3`, the strict band
`rho_(16v)(r)<4v` contains `8v-1` residues. Exactly `2v-1` of them are
multiples of four, leaving `6v` candidates. Therefore

\[
|R_3|=12uv,\qquad |B_u^3|=|B_v^3|=6uv.
\]

If a set of period `P` inside modulus `M=hP` is summed at frequency
difference `d`, its repeated-fiber factor is

\[
\sum_{q=0}^{h-1}\exp(2\pi i dq/h),
\]

which vanishes unless `h` divides `d`. Every nonzero difference of literal
modes `0,...,5` has `1<=|d|<=5`. The three repetition counts are `4uv`, `u`,
and `v`, all greater than five. Hence the nonzero Fourier coefficients of
`R_3`, `B_u^3`, and `B_v^3` all vanish in the matrix's literal difference
range. At zero frequency the signed count is

\[
12uv-6uv-6uv=0.
\]

Every entry of `K_3` is therefore exactly zero. No numerical eigenvalue or
floating-point calculation enters this argument.

## The first family member and its exact blocks

Under the stated parameter ordering—`u` first and then `v`—the least admissible
pair is `(6,7)`. Thus the first member of this proved family is

\[
(6,7,168),\qquad (M_1,M_2,M_3)=(24,28,672).
\]

This is only first within the displayed family. Neither the response nor this
audit proves that it is the globally first primitive signed-Gram
counterexample.

Literal strict-set enumeration gives

\[
B_7^1=\{3,7,10,11,13,14,17,21\}
\]

and

\[
B_6^2=\{1,5,9,10,13,14,15,18,19,23,27\}.
\]

Consequently the first two exact blocks are

\[
K_1=-\frac1{24}V_{24}(B_7^1)^*V_{24}(B_7^1),\qquad
K_2=-\frac1{28}V_{28}(B_6^2)^*V_{28}(B_6^2).
\]

Each evaluation matrix has full column rank: if its six columns were linearly
dependent, a nonzero polynomial of degree at most five would vanish at eight,
respectively eleven, distinct roots of unity. Hence

\[
K_1\prec0,\qquad K_2\prec0.
\]

For completeness, the response's coordinate formulas also check exactly.
Writing `K_1[m,l]=alpha_|l-m|` gives

\[
\begin{aligned}
\alpha_0&=-\frac13,&
\alpha_1&=\frac{-\sqrt2+\sqrt3+\sqrt6}{24},&
\alpha_2&=-\frac1{24},\\
\alpha_3&=\frac{\sqrt2}{24},&
\alpha_4&=\frac1{24},&
\alpha_5&=\frac{\sqrt2-\sqrt3+\sqrt6}{24}.
\end{aligned}
\]

The second block has the exact real cyclotomic coordinates

\[
\beta_d=-\frac1{28}\left((-1)^d+
2\sum_{s\in\{1,5,9,10,13\}}\cos\frac{\pi ds}{14}\right),
\quad 0\le d\le5.
\]

The `(-1)^d` term is the single antipode `r=14`, not a doubled reflection
pair. Finally, the periodic-fiber argument above gives

\[
K_3=0_{6\times6}.
\]

## Exact good counts

At the first two pivots, speed `168` covers every candidate, so `G_1=G_2=0`.
At the third pivot, grouping the 504 candidates by their nonzero residue
class modulo four, and then by residue modulo 16, gives the exact table:

| `s mod 16` | `#{mu=0}` per class | `#{mu=1}` per class | `#{mu=2}` per class |
| --- | ---: | ---: | ---: |
| `1,2,3,13,14,15` | 12 | 21 | 9 |
| `5,6,7,9,10,11` | 9 | 21 | 12 |

There are six classes in each row, so the full multiplicity histogram is

\[
(\#\{\mu=0\},\#\{\mu=1\},\#\{\mu=2\})=(126,252,126).
\]

Therefore

\[
G=(0,0,126),
\]

exactly as claimed.

## Exact pivot certificate and LRC boundary

At the third pivot choose `r=29`. It is a candidate because `4` does not
divide `29`. The literal cyclic distances modulo `672` are

\[
\bigl(\rho_{672}(29\cdot6),
      \rho_{672}(29\cdot7),
      \rho_{672}(29\cdot168)\bigr)
=(174,203,168).
\]

All are at least the pivot threshold `168`; the pivot coordinate attains
equality and is safe. Thus `(pivot=168,r=29)` is an exact canonical pivot
certificate. At time

\[
t=\frac{29}{672},
\]

the three circle distances are `29/112`, `29/96`, and `1/4`, all at least
`1/4`. The tuple satisfies the standard closed-boundary LRC inequality.

The logical distinction is therefore exact:

- `PRIMITIVE-DEGREE-2N-SIGNED-GRAM-GAP` is false;
- the conditional implication from positive signed energy to an uncovered
  pivot candidate remains valid;
- the pivot-certificate theorem is not refuted; and
- positive-integer and unrestricted real LRC remain open.

## Surviving narrower lemma

The counterexample family itself has a useful exact balance identity. At its
third pivot, inclusion-exclusion and the proved counts give

\[
|Q_3|
=|R_3|-|B_u^3|-|B_v^3|+|B_u^3\cap B_v^3|
=|B_u^3\cap B_v^3|.
\]

Moreover `r=1` belongs to both bad sets: it is a candidate and
`u<4uv`, `v<4uv`. Hence

\[
|Q_3|=|B_u^3\cap B_v^3|\ge1.
\]

So every member `(u,v,4uv)` of the family has a third-pivot certificate even
though its entire literal degree-six signed Gram matrix is nonpositive. This
`balanced overlap` lemma is recommendable as `proved-math`. It is narrower
than unrestricted LRC and exposes the precise limitation of low-frequency
signed energy: positive uncovered mass can be exactly balanced by doubly
covered mass at every retained frequency.

The periodic annihilation calculation also yields a reusable algebraic lemma:
if every signed support is periodic with repetition count greater than the
largest retained nonzero frequency and the total signed weight is zero, its
literal truncated Gram block vanishes. This explains the obstruction but does
not supply a replacement unrestricted bridge.

## Independent clean-room check

The audit used a fresh ignored Python 3.14.4 integer-only script implementing
only the frozen definitions. It did not import, execute, or copy either
recovered Prompt77 Python program. It independently asserted the exact sets,
all three multiplicity histograms, `G`, the modulo-16 table, the `r=29`
certificate, and the family period/count/balance identities on 780 coprime
parameter fixtures. The symbolic family proof above, not that bounded loop,
establishes the universal statement.

Command:

```text
python3 tmp/p77_math_audit_204.py
```

Ignored verifier SHA-256 during review:
`1b10049676b94cf677fc876a4dfea7c0ea7fe1b635cc19ea03f8db360134b894`

Output:

```text
family fixtures: 780
G: (0, 0, 126)
pivot-168 certificate: r=29; distances=(174,203,168)
all exact integer assertions passed
```

This is operational audit material, not a tracked certificate or promoted
finite-evidence artifact. Prompt77's separate 6,330-tuple bounded search was
not executed, replayed, or promoted.

The audit diff passes `git diff --check`. The already tracked immutable
response line `response77.md:688`, whose exact content is `=======` inside a
displayed formula, was not modified; its documented false-positive conflict
marker is therefore outside this audit diff. A targeted credential, private
path, browser-session, and personal-data scan of this document was clean.

## Evidence table and remaining gaps

| Claim | Recommended disposition |
| --- | --- |
| Family primitivity and exact three-block signs | `proved-math` |
| `(6,7,168)`, exact blocks, and `G=(0,0,126)` | `proved-math` |
| `r=29` pivot certificate for `(6,7,168)` | `proved-math` |
| Family balanced-overlap certificate existence | `proved-math` |
| `PRIMITIVE-DEGREE-2N-SIGNED-GRAM-GAP` | `rejected` |
| Response-authored 6,330-tuple scan | unverified; no promotion |
| New Lean theorem | none |
| Replacement primitive spectral bridge | `open` |
| Exact unrestricted pivot selector and LRC | `open`; no status change |

The remaining mathematical gap is not a repair to the frozen degree-six
lemma: the exact primitive family has the opposite matrix signs. Any surviving
spectral route must change the invariant materially—for example by retaining
scale-sensitive higher frequencies or by preventing the periodic support
annihilation—then independently prove that its new condition holds
uniformly. This audit supplies no such replacement theorem.
