# Response 44 audit

## Status

Response 44, produced in the signed-in GPT-5.6 Sol Pro conversation after
38 minutes 32 seconds, explicitly reports no proof or counterexample to LRC
or to the uniform pivot-certificate proposition. Its three routes produced
one substantial unconditional advance, one exact finite stress extension,
and a corrected but still compatible minimal-counterexample class.

The response was retrieved through Chrome UI Automation and audited rather
than copied into the project as mathematical authority. Both attached source
files were recovered byte-for-byte from the browser's file viewer. Their
reported hashes match, and their outputs reproduce exactly.

## Accepted constructive theorem

Sol independently verified the previously obtained four-hole argument and
found the same five-hole conclusion: maximum speed at most `n+5` is
sufficient. The repository's stronger local finite partition uses a
deductive proof for `N>=20` plus 134,568 exact configurations for
`N=4,...,19`; an independent clean-room reviewer accepted every step. See
`docs/height-n-plus-5.md`.

Response 44 also supplied a valid unbounded extension. For positive integers
`N,t`, the hypothesis

```text
16*t^2+t<=N
```

ensures that every `(N-1)`-element set of distinct positive integer speeds
bounded by `N+t` is lonely at the closed `1/N` threshold. A second adversarial
review checked the interval cardinality, its nonemptiness, the omitted-residue
count, the inverse witness, and the elementary inequality
`phi(c)>=sqrt(c/2)`. Combined with the accepted five-hole theorem, this gives

```text
T_N=max(4,floor((sqrt(64N+1)-1)/32)),
max A<=N+T_N  ==>  A is lonely.
```

This is an integer bounded-height theorem, not LRC and not yet one Lean
declaration.

The recovered height/residual artifact has SHA-256
`ae713fc899b4f749972c5a5f9f4efe0b488814ea654bf1150b3c7fd3cfac10f5`.
Its canonical output hash is
`a8defd9ec50c92ddfd6821a1dbf4116e2504555423ef9aeafa7ef4701fa9ed24`.
It checks 18,536 small five-hole configurations and 92 exceptional rows.
Its six square-root-height rows are only numerical sanity checks; the proof
is deductive. The global `phi(c)<=8` classification uses the proved bound
`c<=128` together with the artifact's scan through 199.

## Chebyshev route

For the exact Chebyshev score `S_{n,j}`, Response 44 defines

```text
alpha_n = min_{2<=k<=n-1}
          (P_n(k)+k-1) / choose(k,2).
```

Since the chosen Chebyshev polynomial has `-1<P_n(k)<=0` for `k>=1`,
`alpha_n>0`. Its definition gives the pointwise optimal quadratic minorant

```text
P_n(k)>=1-k+alpha_n*choose(k,2),
```

and therefore

```text
S_{n,j}>=H_{j,0}-H_{j,1}+alpha_n*H_{j,2}.
```

This is a sound noncircular sufficient test because the first three moments
have direct generalized-CRT formulas. No argument is given that it is
positive at any pivot uniformly, so the original cross-pivot obstruction
remains.

The exact attached scanner checked 190,488 additional `n=15`, degree-13
tuples in four deterministic domains. It found no tuple with all pivot scores
nonpositive. The source and canonical-output hashes are

```text
f9076573e4bd0b3065fef6c69e529af74f68e271e18effaee68f9fd1c0ec3330
  research/sol-pro/artifacts/prompt44_chebyshev_adversarial.cpp
cb7bec18fcdad744fe30f5e8673e68ff7442d332e11425bd47065845216568e0
  certificates/prompt44_chebyshev_adversarial_expected.txt
```

An independent multi-coordinate search additionally checked 374,850 exact
two-coordinate mutations and 297,847 new divisor-covering three-coordinate
mutations after excluding prior-domain overlap. Again no all-pivot score
failure was found. These scans test only the Chebyshev certificate. A failure
would not disprove LRC, and absence of a failure proves neither uniform score
positivity nor LRC.

## Corrected residual class

Response 44 finally uses the quantifiers correctly: choose the least
counterexample dimension before choosing a primitive sum-minimal
counterexample within that dimension. Only then may deleting the largest
speed invoke the lower-dimensional theorem and fast insertion to give
`a_n<n*a_(n-1)`.

The resulting height, divisor-cover, falling-product, terminal-interval, and
signed-descent restrictions remain compatible. Independent work makes this
sharp with an infinite family. For `N>=5`, let

```text
U_N=(3,4,...,N,N+4).
```

It is primitive, attains the previous max-speed boundary `N+4=n+5`, covers
every divisor `2,...,N`, has deletion gcd one in every coordinate, satisfies
the comparable-top and lcm/product inequalities, and admits no accepted
signed-compatible downward replacement in any coordinate. For odd `N>=7`,
the cross-pivot scaling relation is nonvacuous as well. Nevertheless it is
explicitly lonely at `t=1/(3N)`.

Combining divisor cover with deletion-gcd-one does give the additional exact
restriction

```text
1 <= #{i : d divides a_i} <= n-2       (2<=d<=N).
```

The upper bound follows because deleting a unique nonmultiple would otherwise
leave gcd at least `d`. The family `U_N` satisfies this too. Thus the accepted
arithmetic restrictions cannot contradict one another without genuinely new
input involving total pivot coverage.

## Reproduction

Run:

```bash
bash scripts/audit_response44.sh
bash scripts/audit_response42_cheb_multi.sh
bash scripts/audit_residual_compatibility_family.sh
```

Both compare freshly generated output byte-for-byte with canonical files.
