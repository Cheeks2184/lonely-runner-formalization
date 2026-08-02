# Top-two pivot search

## Status

**Computed finite evidence only.** This note does not prove the Lonely Runner
Conjecture or the strengthening below. The exact unrestricted pivot
certificate remains the authoritative open positive-integer bottleneck.
A top-two failure would refute only this strengthening unless every other
pivot were also covered; it would not by itself disprove LRC.

## Proposed strengthening

Let `n >= 2`, let `N = n+1`, and let

```text
0 < a_1 < ... < a_n
```

be distinct positive integers. For `A` equal to one of the two numerically
largest speeds `a_(n-1)` or `a_n`, put `M=N*A`. The **top-two pivot
conjecture** asks for an `A` and a residue `r` such that

```text
0 <= r < M,
N does not divide r,
rho_M(r*a_i) >= A for every i,
```

where `rho_M(x)=min(x mod M, M-(x mod M))`.

This is exactly the repository's finite pivot certificate with the pivot
existential restricted to the two largest speeds. It therefore implies the
unrestricted `PositiveIntegerPivotCertificateConjecture`, which Lean proves
equivalent to `PositiveIntegerConjecture`. Together with the Lean-verified
real-to-positive-integer equivalence and the proved one-runner base case, it
would imply the full canonical LRC. The converse restriction is not known. A
fixed-instance certificate at an arbitrary pivot does not by itself locate a
certificate at either top speed.

The two largest speeds are defined after numerical sorting. They are not the
last two indices of an arbitrary presentation.

## Scaling audit

Common multiplication cannot create or destroy a top-two certificate. If all
speeds and the pivot are multiplied by `k>0`, a base safe residue `r` gives
the scaled-instance time

```text
r / (N*k*A),
```

because the multiplied phase reduces to `r*a_i/(N*A)`. Conversely, reducing
a scaled safe residue modulo `N*A` preserves its class modulo `N` and every
cyclic inequality. In fact, the safe-residue count is multiplied by `k`.
Numerical sorting is also preserved by positive scaling.

The artifact checks the exact count identity for both top pivots of five hard
cores and all scales `1,...,64`: 640 checks, zero mismatches. It additionally
primitive-normalizes all structured mutations before scoring them.

## Bounded results

The exhaustive primitive boxes contain 878,245 tuples:

| runners | maximum speed | primitive tuples | top-two failures |
|---:|---:|---:|---:|
| 3 | 30 | 3,472 | 0 |
| 4 | 30 | 25,819 | 0 |
| 5 | 30 | 139,246 | 0 |
| 6 | 30 | 588,559 | 0 |
| 7 | 20 | 77,400 | 0 |
| 8 | 18 | 43,749 | 0 |

The scan separately counts tuples covering every divisor `q=2,...,N`; no
top-two failure occurs in those CRT-structured subdomains. A deterministic
two-coordinate scaled-jitter search adds 86,745 unique primitive tuples in
dimensions `6,8,10,12,15`, of which 27,233 cover every such divisor. It also
finds no top-two failure.

The restriction is sharp in a different direction. For

```text
(1,4,5,6,7,11), N=7,
```

the complete pivot safe-residue profile is

```text
1: []       4: []       5: []
6: [13,29] 7: [15,34]  11: []
```

Thus neither endpoint (slowest or fastest speed) is sufficient. The time
`13/42` is a witness from the interior pivot `6`. This was the only
fastest-pivot failure among the 588,559 primitive six-tuples through speed
30, but that bounded uniqueness is not a global minimality theorem.

Hard top-two rows can have the minimum nonzero size permitted by negation
symmetry. For `(2,6,8,9,10,11,13,14,17,19)`, the top pivots have residues
`[12,175]` modulo `187` and `[10,199]` modulo `209`. For
`(1,2,...,11,13)`, they have `[12,131]` modulo `143` and `[14,155]` modulo
`169`. This makes the surviving conjecture computationally tight, not
numerically separated from failure.

## Reproduction

Run from the repository root:

```bash
bash scripts/audit_top_two_pivot_search.sh
```

The command compiles the exact C++20 enumerator with
`-Wall -Wextra -pedantic`, compares fresh output byte-for-byte with
`certificates/top_two_pivot_search_expected.txt`, and checks both source and
output SHA-256 files. On Ubuntu 26.04 under WSL2 with GCC 15.2.0, the complete
compile-and-audit command took approximately 6.8 seconds. The canonical output
hash is

```text
3a9e7f4534cdebfa916b78b191b23d71aa9e43ba50357b9babea87c35a68cbe8
```

The source hash, recorded in
`certificates/top_two_pivot_search_source.sha256`, is

```text
e5b0bf8495dfb9e780ead0d6b961ced300bbbe1258d16a401809db0568193d92
```

Absence of a bounded failure supplies neither compactness nor an induction
step. The top-two restriction must remain labelled `computed finite evidence`
until a proof or an exact counterexample is found.
