# Response 50 audit: finite affine transversals and coefficient two

Status: **accepted as partial mathematics and reproducible finite evidence**.
Nothing in this note proves the top-two pivot conjecture, the coefficient-two
bounded-height theorem, or unrestricted Lonely Runner.

## Recovery and provenance

The signed-in Chrome conversation was explicitly set to GPT-5.6 Sol Pro when
Prompt 50 was submitted. The recovered response begins `Status corrections`
and has 15,210 characters, 15,224 UTF-8 bytes, and SHA-256

```text
45a11b57d8f8068db6ea0e6a8f23b00f65f8061a32ccebca80d418e7127b032c
```

The supplied verifier and expected output are preserved in
`research/sol-pro/artifacts/`. Their exact SHA-256 values are

```text
source: 1ef6cf0ec355b10ee452f40f7c716eac5566d3426b45f55f8ea77ef24b8ac733
output: 04bde9dec49adce42db9024599819153101eedfd9b44969afc844620e4469b57
```

The unchanged verifier exited successfully in 5.33 seconds with empty stderr
and output identical to the attachment. The public audit command is

```bash
bash scripts/audit_response50.sh
```

That command also runs `scripts/audit_prompt50_transversal.py`, an independent
implementation which enumerates both numerator coordinates directly instead
of solving the affine congruence as the supplied verifier does.

## Accepted finite certificate

For the fixed hard pair

```text
N=7, A=98, B=187,
```

the following ordered set of affine shifts is deterministic:

```text
128273, 80, 71, 151, 128210, 150, 25,
1156, 114, 87, 149, 2946, 24, 128252.
```

After retaining pairs that are candidates and mutually good for the two top
runners, the per-shift pair counts are

```text
5,5,5,4,5,4,5,4,4,5,4,4,5,5,
```

giving 64 two-sided constraints. Both implementations reject every one of
the `C(97,4)=3,464,840` four-speed subsets. The displayed five-speed set

```text
{7,63,70,77,84}
```

meets both sides of all 64 constraints. Since transversality is upward
closed, rejection of every four-set also rejects all sets of size at most
four. Thus the exact transversal number for this fixed shift family is

```text
tau_H=5>N-3=4.
```

This proves that no choice of four lower speeds can jointly cover both robust
top endpoints on all fourteen selected fibers. Therefore, for the fixed top
pair and every four-speed lower set, at least one selected robust pair gives a
certificate at pivot `A` or pivot `B`. This is a finite hard-pair certificate,
not a theorem for arbitrary top speeds.

The individual robust grids have 420 and 804 residues. Exact set-cover
searches give

```text
kappa_A=6 with cover {9,31,40,49,58,89},
kappa_B=6 with cover {9,18,27,36,45,54}.
```

The independent implementation retains duplicate and dominated masks, unlike
the supplied optimized search, and obtains the same lower bounds and covers.

## Accepted formulas and boundaries

The affine inclusion-exclusion formula is the corrected formula recorded in
`docs/top-two-affine-fibers.md`: when both numerator divisibilities occur,
their intersection contributes `g`, not `g*N`. The phase identity and scaled
cyclic triangle inequality preserve the strict bad-set boundary. Restricting
to robust endpoints is essential because it prevents the other top runner
from serving as the spoiler.

The quotient-slice counts for the hard pair are exactly `(70,...,70)` on the
`A` side and `(134,...,134)` on the `B` side, each repeated six times. These
counts and the corresponding image/fiber calculation were independently
checked. They do not provide the missing cross-pivot cover transport.

Response 50 also gives the coefficient-two family

```text
N=2m, S=[1,2m] without {m}, pivot P=m+1, numerator r=2m+1.
```

The direct residue calculation is valid for every `m>=2`; the independent
script checks it through `m=500`. This is a witness family showing that a
simple missing-to-extra obstruction can still be lonely. The sharper local
Hall-collision family in `docs/coefficient-two-frontier.md` remains the more
informative obstruction to the proposed proof architecture.

## Exact remaining gap

No argument constructs, for every pair `(N,A,B)`, a finite shift set `H`
with `tau_H(A,B)>N-3`. Establishing such a uniform theorem, or finding a top
pair for which it fails, is the exact next obligation for this affine route.
The quotient route still lacks cross-pivot cover transport, and the
coefficient-two route still lacks an internal-blocker charging theorem. These
are acknowledged obstructions, not suppressed transitions.
