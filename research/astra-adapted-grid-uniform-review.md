# Independent review of the ordinary adapted-grid audit

**Verdict: accepted as a manuscript audit, with the existential candidate
unresolved.** The conditional endpoint-lattice statement, bounded-image
restrictions, exact boundary counts, tightness implication, deficient-fiber
formula and recursive positive control are correct. None supplies an
arbitrary-N grid witness or an actual grid counterexample.

Date: 2026-09-06. Task `/root/adapted_grid_uniform_review`, using the existing
`/root/uniform_screen_review` session with requested Astra/xhigh routing.
This reviewer authored neither the audit nor its control receipt. Observed
runtime model/effort, total elapsed time and token accounting are not exposed
independently and remain null. Parent-supplied current checkpoint:
`600287d55a01d3c8c2d3bf4e4114eee4f9c1271e`. The manuscript records its earlier
task checkpoint; acceptance below binds the actual file, rather than assuming
those two checkpoint labels are identical. Only this review is worker-owned.

## Inputs and contract

The complete manuscript was read, together with its bounded-control receipt.
Its earlier finite-grid audit was already read and independently reviewed in
this session; its current binding was rechecked. All three actual hashes match:

| Artifact | SHA-256 |
| --- | --- |
| `research/astra-adapted-grid-uniform-audit.md` | `ed38f7cb6c07f0d476ceac661154fbddda7fe4757af2be6ec90be71fc01f5ef8` |
| `research/astra-finite-grid-stronger-margin-audit.md` | `9ec0f7087231f67be09680c228826683da51c1af8c19c101581eb62fec2cdb6b` |
| `research/astra-adapted-grid-control.json` | `4b5145ae2b52c96f2a84e13b77e0cbd96dd00a268977f1daca95b4a1ca064d36` |

The candidate has N>=3, n=N-1 distinct positive integer speeds, ordinary
phases and zero interval origin. Its actual time is

`t(k)=sum_i k_i/(N*v_i)`, with `0<=k_i<N`.

Every label is evaluated at this same time. The desired norms are closed,
at least 1/N. A common positive scaling multiplies each time inversely and
preserves all phases; this does not introduce independent phase choices.
For integer speeds the good property is periodic modulo one. Counting below
is on assignments unless an explicitly proved injectivity statement is used.

## Ambient lattice and bounded digits

With L=lcm(v_i), d_i=L/v_i and S(k)=sum_i k_i*d_i, all candidates lie in the
lattice of a/(N*L) modulo one. If a full witness exists, periodicity places
one in [0,1]. The closed good set there is compact; its first point lies in
(0,1), since both integer endpoints are bad. At least one label has norm
exactly 1/N, or continuity would allow an earlier good point. Accordingly
the first point is `(N*z+1)/(N*v_i)` or `(N*z-1)/(N*v_i)` and lies in that
lattice. The reverse implication is immediate. This is conditional on
nonemptiness, not a proof of nonemptiness or bounded-digit representability.

For the special class C, every two speeds are coprime and every speed is
at least N. Then L is their product. Modulo v_j, every d_i except d_j
vanishes, and d_j is invertible. If two candidate times agree modulo one,
their numerator difference is divisible by N*L, hence
`k_j-k'_j=0 mod v_j`. Its absolute value is at most N-1<v_j, so it is zero.
This proves injectivity of all N^n assignments modulo one. Reducing an
equation `S(k)=p*L mod N*L` similarly forces every digit to vanish; p must
then be zero modulo N. Thus every nonzero p/N is omitted, regardless of
whether p is a unit modulo N. Primality of N is unnecessary here. The
lower bounds on the speeds are essential to this bounded-digit argument.

If a grid point contacts the canonical boundary at label i, then
`N*v_i*t=S(k)/d_i` is an integer. Therefore d_i divides S(k). For j!=i,
v_j divides d_i, so reduction modulo v_j forces k_j=0. The remaining phase
is k_i/N, with boundary precisely at k_i=1 or N-1. Those digits are distinct
for N>=3. Conversely both axis assignments have the stated contact. A
second boundary label would force the first nonzero digit to vanish. Hence
there are exactly 2n boundary assignments, each with exactly one contacting
label. This does not say those assignments satisfy all other constraints.

## Why the tightness implication needs opposing contacts

Let f(t)=min_i norm(v_i*t). Under the additional hypothesis
`max_[0,1] f=1/N`, compactness supplies a full witness. At any such witness,
an active lower contact, with fractional phase 1/N, has local norm slope
+v_i; an active upper contact at 1-1/N has slope -v_i. These slopes are
nonzero because 0<1/N<1/2 and all speeds are positive. All noncontacting
labels have positive slack. A sufficiently small common perturbation
preserves their strict inequalities. If all contacts had the same slope
sign, perturbing in the improving direction would make every norm strictly
larger, contradicting tightness. Both signs, hence at least two contacts,
are required. Integer times are bad, so the [0,1] endpoints cause no issue.

A grid witness in C with no contact already contradicts tightness. One
with a contact has exactly one, contradicting the preceding local argument.
The claimed implication from C plus tightness to grid failure is therefore
valid. No tuple satisfying both hypotheses is supplied. It cannot be
promoted to an actual grid counterexample or to a classification of tight
tuples. Conversely, a grid witness in C implies that some full time has
strictly better margin; that improved time need not itself be in the grid.

## Exact fibers and the overlap obligation

For a label i, fixing other digits leaves phases a+k_i/N. Scaling the
strict bad arc by N produces an open interval of length two. Its count is
one when its endpoints are integral, equivalently N*a is integral, and
two otherwise. N>=3 ensures distinct counted residues. Thus aligned
fibers have one bad assignment, and every other fiber has two; equality
at a good endpoint must not be counted as bad.

Since `N*a=sum_(j!=i) k_j*v_i/v_j`, integrality is equivalent to
`d_i divides sum_(j!=i) k_j*d_j`. Let D_i count these aligned fibers.
There are N^(n-1) fibers, so

`|Bad_i|=2*N^(n-1)-D_i`.

In C, reduction modulo each v_j for j!=i forces every fixed digit to zero.
That fiber is indeed aligned. Hence D_i=1 for every label, and D=n. No
further divisibility or primality hypothesis is hidden in this conclusion.

For r(k) bad labels at assignment k, define
`R=sum_k max(r(k)-1,0)`. This measures incidences beyond the first, not
pairwise intersections. The exact union identity gives

`#survivors=D+R-(N-2)*N^(N-2)`.

Substituting D=N-1 and requiring at least one survivor yields exactly

`R >= (N-2)*(N^(N-2)-1)`.

The final unit in this integer threshold is correct. The common zero
assignment only guarantees R>=N-2, strictly below the target for every
N>=3. Injectivity and the marginal counts provide no proof of the missing
overlap bound. The displayed equivalence is a remaining obligation, not
an estimate that supplies witnesses.

## Recursive family and small boundary control

The recursion v_1=N+1 and `v_i=N*product_(j<i) v_j+1` produces increasing
speeds at least N, each congruent to one modulo N and coprime to every
earlier speed. It therefore belongs to C. Every nonzero p/N is a full
closed witness, and all are omitted from the bounded grid as proved above.

Nevertheless the all-ones assignment is strictly good. For j<i,
`v_i/(N*v_j)` is an integer plus `1/(N*v_j)` by the recursion. Its own
contribution is 1/N. Each later contribution `v_i/(N*v_j)` is strictly
between zero and 1/N because v_j>v_i. There are exactly N-2 off-diagonal
contributions in total, including the positive earlier remainders. Thus
after removing the integer part, the phase is strictly between 1/N and
(N-1)/N. No further wrap occurs, and both distances to the adjacent integers
exceed 1/N. The construction is uniform in N>=3 and does not rely on a
search. Omitting supplied witnesses therefore does not refute the
existential candidate. This family also does not realize tightness.

The N=3 boundary check is correct even for positive real speeds. After
scaling and ordering to 1,r, for 1<=r<=2 the digit choice t=2/(3r) gives
the fast phase 2/3 and a slow phase in [1/3,2/3]. For r>=2, the three
choices `1/3+l/(3r)` keep the slow phase in that closed interval; the
fast phases form a translated three-grid, which intersects it. The endpoint
r=2 satisfies both constructions. N=2 uses the sole nonzero digit. These
checks do not supply the missing general correlation argument.

## Evidence limits and disposition

The control receipt records all 1,140 increasing triples from 1..20 at
N=4 and all 1,820 increasing quadruples from 1..16 at N=5 as bounded
nonfindings. The retained source constructs the exact bounded residue image
modulo N*L and uses an integer comparison for the closed target. Its
additional Fraction check runs only if a grid failure is found; no such
failure occurred. This review reads that evidence without replaying its
execution or claiming that every branch ran. These finite controls are not
used in the proofs above and imply no unbounded conclusion.

No correction is needed to the frozen manuscript. The unresolved requirement
is genuine ordinary-frequency coupling supplying a grid survivor, or an
actual admissible tuple whose entire adapted grid fails. Conditional lattice
access and exact deficient-fiber arithmetic establish neither. This review
adds no Lean result and no unrestricted LRC conclusion.

## Actual review receipts

Current config, workflow, policy and focused state were read. This command
ran in `/home/joshua/lonely-runner-formalization`:

```sh
python3 -B scripts/validate_workflow.py
```

Exit 0; full output:

```text
workflow structural validation passed; it cannot certify mathematical validity.
```

Actual source readback commands:

```sh
sha256sum research/astra-adapted-grid-uniform-audit.md
sha256sum research/astra-finite-grid-stronger-margin-audit.md research/astra-adapted-grid-control.json
```

Both exited 0; their complete outputs, respectively:

```text
ed38f7cb6c07f0d476ceac661154fbddda7fe4757af2be6ec90be71fc01f5ef8  research/astra-adapted-grid-uniform-audit.md
```

```text
9ec0f7087231f67be09680c228826683da51c1af8c19c101581eb62fec2cdb6b  research/astra-finite-grid-stronger-margin-audit.md
4b5145ae2b52c96f2a84e13b77e0cbd96dd00a268977f1daca95b4a1ca064d36  research/astra-adapted-grid-control.json
```

All mathematical checks were hand derivations and source reading. No
mathematical program, enumeration, Lean, Git, cache operation, other-file
edit or shared-state mutation was performed by this review.

Owned-file whitespace check:

```sh
rg -n '[ \t]+$' research/astra-adapted-grid-uniform-review.md
```

Exit 1 with empty output: no trailing-whitespace matches. The frozen review
hash is returned separately so that the file does not claim to contain its
own SHA-256.
