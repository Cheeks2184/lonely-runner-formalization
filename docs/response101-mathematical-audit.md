# Response101 independent mathematical audit

- Task: `VER-P101-MATH-AUDIT-349`
- Audit base: `b12887f1c46d58c03999ef5d82517203ea61a91b`
- Recovered response SHA-256:
  `8313b4a8c083d4c92be66e980029cc04e912fc93db83909e3144c050d44f1174`
- Overall disposition: `REFUTED-EXACT`
- Lonely Runner Conjecture: `open`

This audit independently checks the frozen
`COVERED-PIVOT-SUBCRITICAL-WEIGHTS` theorem against the exact labelled,
strict pivot definitions in Prompt101.  It does not use an attachment or
response-supplied executable.  The recovered response is preserved unchanged;
the copy-corruption corrections below are recorded here rather than silently
editing provenance.

## Frozen statement and exact counterexample

The frozen proposition quantifies over every `n>=2` and every positive
injective `a : Fin n -> Nat`.  For the exact covered-label set `F(a)`, it asks
for a positive rational vector `x` satisfying `A_F*x<x`, where off-diagonal
entry `(j,i)` is the strict labelled cardinality `|B_i^j|/|R_j|`.  Rows and
columns use only covered labels; equal bad sets are not deduplicated.

Take

```text
n = 4,  N = 5,  a = (1,5,25,125).
```

The tuple is positive, injective, and primitive.  At pivots `1`, `5`, and
`25`, the next speed equals the corresponding modulus, so its modular product
is zero on every candidate and the pivot is covered.  At pivot `125`, modulus
`625`, the canonical candidate `r=156` has strict-distance values

```text
owner 1:   rho_625(156)  = 156,
owner 5:   rho_625(780)  = 155,
owner 25:  rho_625(3900) = 150.
```

All are at least `125`; the pivot coordinate has distance exactly `125`,
which is safe because badness is strict.  Thus

```text
F(a) = {speed 1, speed 5, speed 25}.
```

In increasing-speed order, literal strict counts give

```text
      [  0    1    1 ]
A_F = [ 2/5   0    1 ].
      [ 2/5  2/5   0 ]
```

For the positive left vector `w=(2,3,4)`, exact multiplication gives

```text
w^T A_F - w^T = (4/5, 3/5, 1) > 0.
```

If a positive `x` satisfied `A_F*x<x`, multiplication by `w^T` would give
both `w^T*A_F*x < w^T*x` and `w^T*A_F*x > w^T*x`, a contradiction.  The
independent determinant check agrees:

```text
det(I-A_F) = -19/25.
```

This is an exact theorem-domain counterexample to Prompt101.  It is not a
counterexample to a pivot certificate or to the Lonely Runner Conjecture: the
same tuple has the explicit safe last-pivot residue `156`.

## Uniform counterfamily

The response's family is correct at `proved-math-qualified` scope.  For every
`n>=4`, put `N=n+1`, choose `c>0`, and set

```text
a_k = c*N^k,  0 <= k < n.
```

For `j<n-1`, owner `j+1` has speed
`a_(j+1)=N*a_j`, the whole pivot modulus, and hence covers the entire row.
For the last pivot use

```text
r_* = 1 + N + ... + N^(n-1).
```

The response omitted the representative-range inequality.  It is valid:

```text
r_* < N^n <= c*N^n.
```

Also `r_* mod N=1`.  For lower owner `a_k`, put `m=n-k>=2` and
`s_m=1+N+...+N^(m-1)`.  Reduction modulo `c*N^n` gives

```text
r_* * a_k = c*N^k*s_m  (mod c*N^n).
```

The bounds

```text
N^(m-1) <= s_m <= N^m-N^(m-1)
```

show that both cyclic sides are at least `c*N^(n-1)`, the last pivot speed.
Therefore the last pivot is uncovered and

```text
F(a) = {0,...,n-2}.
```

For covered labels the exact normalized matrix is

```text
A_F(j,k) = 0    if j=k,
           1    if k>j,
           2/N  if k<j.
```

At `n=4`, this is the matrix above.  For `n>=5`, write
`m=n-1=N-2`.  Column `k` has sum

```text
c_k = k + (2/N)*(N-3-k),
c_k-1 = ((N-2)*k + N-6)/N >= 0.
```

At least one coordinate is strict.  Hence
`1^T*A_F*x>1^T*x` for every positive `x`, excluding `A_F*x<x`.  This proves
the uniform failure without a floating-point spectral calculation.

Only `c=1` is primitive in this family, but Prompt101 does not assume
primitivity.  The `c=1,n=4` member already supplies the primitive exact
counterexample.

## Strict cardinality formula

For pivot `p>0`, owner `q>0`, and `N>=3`, put

```text
g = gcd(q,N*p),  d = gcd(q,p).
```

The correct strict count is

```text
|B_q^p|
  = g*(1 + 2*floor((p-1)/g))
    - d*(1 + 2*floor((p-1)/(N*d))).
```

The first term counts the multiplication fibers landing in the strict bad
arc modulo `N*p`.  The second subtracts the bad residues excluded from the
candidate row because they are divisible by `N`.  The use of `p-1` preserves
the safe equality boundary.

Writing `p=d*P`, `q=d*Q`, `gcd(P,Q)=1`, and `h=gcd(Q,N)`, this becomes

```text
|B_q^p|
  = d * (h*(2*ceil(P/h)-1) - (2*ceil(P/N)-1)).
```

The normalized expression gives `1` above the diagonal and `2/N` below the
diagonal for the power family.  Independent literal enumeration agreed with
the formula for every pivot/owner pair in the tested `n=4,c=1`, `n=4,c=3`,
and `n=5,c=1` family instances and all mandatory finite fixtures below.

## Independent fixture checks

Exact rational recomputation gave:

- `(1,4,5,6,7,11)`: covered speeds `{1,4,5,11}`; the response's matrix and
  weights `(1,3,3,3)` have slacks
  `(1,5/4,17/15,12/11)`.
- `(1,4,5,6,7,11,32)`: covered speeds `{1,4,5,6}`; unit weights have slacks
  `(3/7,3/7,1/5,2/7)`.
- `(6,7,12,24,144)`: covered speeds `{6,7,12,24}`; weights `(3,4,3,3)` have
  slacks `(7/15,1/7,7/15,1/6)`.
- On every label of `(1,2,3,5)`, row sums are `(1,1,1,6/5)`, whereas its
  actual covered set is only `{1,2}` and its induced matrix is subcritical.
- At `N=4,p=3,q=1`, residues `3` and `9` have distance exactly `p` and are
  safe; the strict bad set is `{1,2,10,11}`.
- At pivot `3` of `(1,3,13)`, owners `1` and `13` have coincident strict bad
  sets but remain distinct labels.
- At `N=6,p=7,q=6`, the exact bad-set cardinality is `15`, normalized to
  `3/7`, and nonunit zero-product candidates are retained.

These are independently checked finite identities.  No unrestricted result
is inferred from their bounded scope.

## Rejected finite-minimality claim

The response says that `(1,5,25,125)` is the first failing increasing
four-tuple through maximum speed `125`, at ordinal `9,381,634`.  The ordinal
alone is reproducible combinatorially: `9,381,251` four-tuples have maximum
below `125`, and `382` tuples at maximum `125` precede the target.

There is no response-bound source, output, manifest, execution record, or
independent exhaustive replay proving that every preceding tuple passes.
Therefore the first-failure/minimality assertion is `rejected / unpromoted`.
It is unnecessary for the exact analytic refutation.

## Recovered-response copy corruption

The tracked response contains display corruption and must not be quoted as if
its rendered formulas were literal valid equations.  In particular:

- equality bars appear as Markdown lines of `====`;
- the two cardinality formulas lose subtraction signs to Markdown headings or
  horizontal rules;
- the normalized numerator loses its subtraction sign;
- the last-witness equality chain contains a stray heading marker;
- the lower-matrix-entry and column-sum derivations contain stray heading
  markers;
- the determinant expansion should read
  `1 - 3*(2/5) - 2/5 - 4/25 = -19/25`;
- matrix row separators are malformed; and
- the claim-table expression `|B_i^j|` is interpreted as table delimiters.

The original file remains byte-for-byte preserved for provenance.  The
corrected formulas in this audit are independently checked and control the
mathematical disposition.

## Evidence table and remaining status

| Claim | Audit disposition |
| --- | --- |
| Primitive tuple `(1,5,25,125)` refutes Prompt101 | `refuted-exact` |
| Uniform `c*N^k` family and exact matrix | `proved-math-qualified` |
| Strict gcd-sensitive cardinality formula | `proved-math-qualified` |
| Positive dual and determinant at `n=4` | `proved-math-qualified` |
| Column-sum dual for every `n>=5` | `proved-math-qualified` |
| First-failure/minimality scan | `rejected / unpromoted` |
| Prompt101 route proves unrestricted LRC | `rejected` |
| Unrestricted Lonely Runner Conjecture | `open` |

Prompt101 is stopped because its proposed sufficient theorem is false.  The
counterfamily already contains pivot certificates, so it gives no
counterexample to LRC and no evidence against LRC.
