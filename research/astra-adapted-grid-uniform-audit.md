# Analytical audit of the ordinary adapted N-grid

Date: 2026-09-06. Task `/root/adapted_grid_uniform_audit`, in the requested
Astra/xhigh session `/root/uniform_seed_coupling`.
Task source checkpoint: `8b9ea58d8a477a0fad733c3cf6674c307c1f9782`.
Only this report is worker-owned. No mathematical program was run.

**Disposition: the existential candidate remains unresolved.** The two
structural approaches below establish an exact arithmetic distinction
between the ambient lattice and the bounded grid, and identify the precise
remaining overlap obligation in a realizable primitive class. They supply
neither a grid counterexample nor an arbitrary-N survivor proof.

Let N>=3, n=N-1, and let the `v_i` be distinct positive integers. The
candidate asks for a closed `1/N` common witness in

```text
G_N(v)={sum_i k_i/(N v_i) : k_i in {0,...,N-1}}.
```

The interval origin and every starting phase are zero. All norms in an
assignment are evaluated at its one common time. A common rescaling of
the speeds rescales every candidate time inversely and preserves the
candidate property. No independent phase choices are introduced below.

## 1. Ambient lattice, bounded image and boundary rigidity

Put `L=lcm_i(v_i)`, `d_i=L/v_i`, and `S(k)=sum_i k_i d_i`. Modulo one,
the adapted grid is the bounded image `S(k)/(NL)` inside the full lattice

```text
Lambda_N={a/(NL) mod 1 : a in Z}.
```

For an actual integer tuple, the full closed good set is nonempty if and
only if it contains a point of Lambda_N. For the nontrivial implication,
take its first point t in [0,1]. The set is compact, and 0 and 1 are bad,
so `0<t<1`. Some label must have norm exactly `1/N` there; otherwise
continuity permits an earlier good point. Thus

```text
t=(Nz+1)/(N v_i) or (Nz-1)/(N v_i)
```

for an integer z. Multiplying by NL gives an integer. This proves the
lattice statement, but supplies neither a witness nor a representation
of that witness with all digits below N. A denominator obstruction that
only places full-good endpoints outside Lambda_N cannot work here.

There is a sharp bounded-image distinction in the following actual
arithmetic class:

```text
gcd(v_i,v_j)=1 for i!=j,       v_i>=N for every i.     (C)
```

Here `L=product_i v_i`. Reduction modulo v_j kills every d_i except d_j,
and d_j is invertible modulo v_j. It follows that:

* The assignment-to-time map modulo one is injective. Indeed equality of
  two times modulo one forces `k_j=k'_j mod v_j` for every j, and the
  differences have absolute value below N<=v_j.
* The only member of G_N lying in `(1/N)Z` modulo one is zero. A proposed
  equality `S(k)=pL mod NL` similarly forces every k_j to be zero, and
  then p must be zero modulo N.
* If a grid time has a canonical boundary contact at label i, every other
  digit is zero. Such a contact implies `N v_i t=S(k)/d_i` is an integer.
  For j!=i, the divisor v_j of d_i therefore divides S(k); reduction
  modulo v_j forces k_j=0. The remaining contact requires
  `k_i in {1,N-1}`. Conversely these two axis assignments do have that
  contact. Neither can have a contact at another label, by the same
  argument. Thus the grid has exactly 2n canonical-boundary assignments,
  each with exactly one boundary label.

These are statements about actual common-time integer velocities, not a
synthetic assignment of phases or residue conditions to separate labels.

One conditional obstruction now follows. If a tuple satisfying (C) were
**tight**, meaning

```text
max_(t in [0,1]) min_i ||v_i t|| = 1/N,               (T)
```

then G_N would contain no full closed witness. A grid witness with every
norm strictly larger would contradict (T) immediately. A grid witness
with a boundary contact has exactly one such label. Since `1/N<1/2`,
that label's norm has a nonzero linear slope locally; move in its improving
direction while preserving all other strict inequalities. This again
contradicts (T). Compactness makes (T) a nonempty closed-witness hypothesis.

No actual tuple satisfying both (C) and (T) was established in this audit.
This is a precisely stated additional hypothesis, not a realizable grid
counterexample and not a disproof of LRC. Classifying tight tuples or proving
strict loneliness throughout (C) has not been supplied here.

### An actual control of bounded-image omission, with its grid witness

For every N>=3, define n=N-1 speeds recursively by

```text
v_1=N+1,
v_i=N product_(j<i) v_j+1,        2<=i<=n.             (E)
```

These are increasing, at least N, pairwise coprime, and all equal to 1
modulo N. Consequently each nonzero `p/N`, `1<=p<N`, is a common closed
witness, with every phase congruent to p/N. Nevertheless none of these
witnesses belongs to G_N modulo one, by the bounded-image result above.
Thus even actual supplied common witnesses need not be sampled.

This family is also explicitly positive for the grid candidate: take
**every digit equal to one**, so `t=sum_j 1/(N v_j)`. For label i and j<i,

```text
v_i/(N v_j) = product_(h<i) v_h/v_j + 1/(N v_j),
```

whose first term is an integer. Its own contribution is 1/N. Each of the
N-2 remaining fractional contributions is positive and less than 1/N:
earlier ones are `1/(N v_j)`, and later ones are `v_i/(N v_j)` with v_j>v_i.
Their sum with 1/N lies strictly between `1/N` and `(N-1)/N`, so no wrap
occurs and every norm is strictly above the target. The all-one construction
was independently derived here and also supplied by root.

Thus (E) refutes the proposed inclusion of all ordinary witnesses in the
bounded grid while explicitly satisfying the existential grid candidate.
It is not a near-counterexample or evidence for the unrealized tightness
hypothesis (T). No finite enumeration was needed for either conclusion.

## 2. Exact deficient-fiber arithmetic and the missing global bound

For the ordinary N-grid at threshold `1/N`, a fiber for label i fixes the
other n-1 digits and varies k_i over all N choices. Its phases are
`a+k_i/N`, where

```text
N a=sum_(j!=i) k_j v_i/v_j.
```

The exact strict-bad count is one if N a is an integer and two otherwise.
To see the endpoint distinction, multiply phases by N: the strict bad
arc lifts to an open interval of length two. Its integer translates contain
one integer if both endpoints are integers and two otherwise. Because
N>=3, the counted residues are distinct. Equivalently the aligned fiber
has just its zero-phase residue bad; every unaligned fiber has two.

Let D_i be the number of aligned fibers. The exact arithmetic formula is

```text
D_i=#{(k_j)_(j!=i) : d_i divides sum_(j!=i) k_j d_j},
|Bad_i|=2N^(n-1)-D_i.                                (1)
```

Under (C), the same modular reduction as in section 1 forces every other
digit to be zero. Conversely that fiber is aligned. Hence

```text
D_i=1 for every i,           D=sum_i D_i=n.            (2)
```

This is a uniform actual-velocity calculation, including the family (E).
It shows that ordinary arithmetic need not supply more than the original
one aligned fiber per label. The additional survivor saving must come from
inter-label overlap in this class.

For precision, on the assignment set let `r(k)` count bad labels and let
`R=sum_k max(r(k)-1,0)` be overlap redundancy. The exact incidence identity
from the earlier audit specializes to

```text
number of surviving assignments
  = D+R-(N-2)N^(N-2).
```

Thus in class (C) the candidate is equivalent to the additional inequality

```text
R >= (N-2)(N^(N-2)-1).                               (3)
```

The common zero assignment only gives `R>=n-1=N-2`, far below (3) when
N>=3. Neither injectivity nor (1)-(2) proves (3). The identity is an exact
remaining obligation, not a new supply result; the all-one witness in
(E) comes from extra multiplicative relations not present in general (C).
No false independence assumption or product of marginal probabilities is
used to replace this missing correlation bound.

## Boundary check, evidence limits and disposition

Root's supplied N=3 check is sound, including real positive frequencies.
Scale them to 1,r with r>=1. For `1<=r<=2`, the candidate `2/(3r)` has
both norms at least 1/3. For r>=2, candidates `1/3+l/(3r)`, l=0,1,2,
keep the slow phase in [1/3,2/3], and their fast phases form a translated
three-grid, which meets that closed interval. This is a boundary check
of the candidate, not a new fixed-count formalization. N=2 is immediate
from the sole nonzero digit. Neither argument extends the inter-label
correlation proof to arbitrary N.

The prior q=N-1 prime-family obstruction does not apply: q=N directly
samples 1/N for consecutive speeds. The completed Terra receipt records
bounded nonfindings for 1,140 triples from 1..20 at N=4 and 1,820 quadruples
from 1..16 at N=5. Those outputs establish only the stated finite domains.
They were read, not replayed or enlarged, and are not used in any proof here.

This bounded audit stops after the two structural approaches above. It
establishes neither a counterexample to G_N nor an unconditional survivor
bound, and therefore no unrestricted LRC result. No Lean implementation is
recommended solely for these conditional/reformulation facts. The unresolved
input is actual ordinary-frequency coupling sufficient for a grid survivor,
or a genuine integer tuple whose entire bounded grid fails; neither has
been supplied by the endpoint lattice or deficient-fiber calculations.

## Source bindings and verification

Both source artifacts were read at these hashes:

| Artifact | SHA-256 |
| --- | --- |
| `research/astra-finite-grid-stronger-margin-audit.md` | `9ec0f7087231f67be09680c228826683da51c1af8c19c101581eb62fec2cdb6b` |
| `research/astra-adapted-grid-control.json` | `4b5145ae2b52c96f2a84e13b77e0cbd96dd00a268977f1daca95b4a1ca064d36` |

Current config, workflow, policy and focused state were read.
`python3 -B scripts/validate_workflow.py` exited 0 with the full output

```text
workflow structural validation passed; it cannot certify mathematical validity.
```

All new claims use the displayed algebra and finite counting. No mathematical
program, solver, search, Lean invocation, cache restoration or new literature
claim was used. Author sources, shared state and Git data were preserved.
This report is a manuscript derivation requiring independent review.
