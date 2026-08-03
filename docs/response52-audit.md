# Response 52 audit: critical Gamma cores and an asymptotic coefficient-two theorem

Status: **accepted as substantial partial mathematics**. The response proves
an asymptotic coefficient-two bounded-height theorem using Pomerance's
published coprime-matching theorem. It does not prove the exact all-dimension
coefficient-two theorem, unrestricted top-two, or unrestricted Lonely Runner.

## Recovery and provenance

Prompt 52 was submitted in the signed-in Chrome conversation with GPT-5.6 Sol
and Pro explicitly selected. Its composer SHA-256 was
`7de150ba85aa4220aa6bd87b21862cfcc37135da2e58243c14c10cf031182155`.

The recovered response begins `Status corrections`, has 21,862 PowerShell
characters and 21,986 UTF-8 bytes, and has raw clipboard SHA-256

```text
e356b9c4acfdb11ea39d8e81e9dc62625bf0645176f58355ff383fc34bb647db
```

Its LF-normalized text has 20,908 characters and SHA-256
`3b2da4acd21c4d28a4f7251f2da428408d33721527d07196f21348a700185717`.
No attachment or computational artifact was supplied.

## Accepted critical-core structure

For an inclusion-minimal Hall-deficient `A`, the response correctly proves

```text
|Gamma(A)|=|A|-1,
Gamma(A\{c})=Gamma(A) for every c in A,
```

no right vertex is private, the induced incidence graph is connected, and
deleting any left vertex leaves a perfect matching onto `Gamma(A)`. The
monotone raw endpoints give the stated overlap and extreme private-strip
restrictions. These statements constrain a counterexample but do not exclude
one; the response explicitly stops at the cross-candidate prime-synchrony
gap.

An independent degree audit strengthens this reduction. Under `not Auto(c)`,
Gamma is the coprime part of an extended interval of length `N-max(c,t)`, so
Kanold blocks give an exact lower bound. The only empty row is `(8,4,6)`, and
the complete 22-row singleton classification has `N<=19`. Outside the four
repaired failures, a new minimal core must have `N>=20`, at least three left
vertices, deficiency one, connected incidence, and minimum degree two on both
sides. The expanded public verifier reproduces the bounded classification.

## Accepted two-rectangle theorem

For the generic coefficient-two band, put

```text
a=floor(3*(N-t)/4)+1,
b=floor((N+t)/2),
q=floor(t/4),
ell=2*q,
a0=max(t-ell,b-2*ell+1).
```

When `t>=16` and `2*t<=N`, the two adjacent left intervals

```text
C0=[a0,a0+ell-1],
C1=[a0+ell,a0+2*ell-1]
```

cover the whole generic candidate interval `[a,b]`. The two disjoint extra
intervals `D0=[N+1,N+ell]` and `D1=[N+ell+1,N+2*ell]` lie below `H=N+t`.
Every pair in `C0 x D1` and `C1 x D0` satisfies the exact strict/closed Gamma
sum band `H<c+d<=2N`. The endpoint proof uses `2*ell<=t`,
`2*ell>=t-3`, and the definition of `a0`; all natural-floor boundaries audit
correctly.

Each interval has even length `ell=2*q`. Pomerance proves that sufficiently
long equal even intervals in a sufficiently large ambient range have a
coprime bijection. Applying that theorem to `(C0,D1)` and `(C1,D0)` and
combining the disjoint right images gives a Gamma selector for every generic
candidate. Since `t>N/3` on the active branch, `q>N/12-1`, while all values
are at most `3N/2`. Thus the published logarithmic threshold is met for all
sufficiently large `N`.

All 22 nongeneric triples have `N<=18`. Consequently there exists an
existential `N0` such that every `N>=N0` and `t` with `2*t<=N` has the
coefficient-two bounded-height witness: use the Lean-verified coefficient-
three theorem when `3*t<=N`, and the rectangle selector otherwise. This is a
complete asymptotic manuscript proof.

The imported input is precisely Pomerance's coprime interval-matching theorem
and its unspecified absolute constant/cutoff:
[Pomerance, *Coprime matchings*](https://arxiv.org/abs/2111.07157).
[Bohman--Peng](https://arxiv.org/abs/2109.09860) gives an earlier weaker
threshold. Neither paper directly states the triangular Gamma theorem.

## Effective-cutoff audit

The primary proof does not supply enough numerical data to compute `N0`. Its
first hard stop is the sentence importing an absolute constant `c1` from
Iwaniec's interval-sieve estimate. Pomerance next uses an unspecified `c2` in
`omega(s_m)*log(omega(s_m))<=c2*log(n)` and sets the theorem constant to
`3*c1*c2^2`; later steps introduce `c3,c4,c5`, asymptotic `O`, `o`, and
`Omega` bounds, and further sufficiently-large thresholds. The numerical
zeta-product estimate in Lemma 3 does not remove these dependencies.

No inherently ineffective ingredient was identified. A numerical cutoff may
be possible after a substantial explicit reworking of Iwaniec's estimate and
the later prime-counting, Mertens-product, and tail bounds, but it is not
present in the published proof. Conditionally, if explicit Pomerance constants
`(cP,nP)` were supplied, any `N0>=max(45,nP)` for which
`N/12-1>cP*(log(3*N/2))^2` holds thereafter would suffice for this rectangle
application.

## Other accepted lemmas

The critical pair-energy inequality is an exact Cauchy--Schwarz identity on
right degrees. The Mobius inclusion-exclusion formula correctly evaluates
each Gamma intersection over the overlap of two monotone raw intervals. The
proposed `ENERGY-EXCLUSION` comparison is now independently refuted at
`(N,t,A)=(14,6,{6,8,9,10})`: all proper subsets are Hall-good, but
`m=4,e=9,p=9` gives equality `e^2=(m-1)*(e+2*p)=81`. The full set is
Hall-good, so this rejects the energy closure only, not the selector.

The common-denominator criterion is sound: a `q` in the displayed common
range, coprime to the product of all holes, maps `c` injectively to `q-c` in
`Gamma(c)`. Kanold gives a valid sufficient interval-length corollary, but the
combined prime support may make it too weak uniformly.

Response 52 restated the common-`g` top-two class as proved mathematics and
not yet Lean-compiled. Independently and concurrently,
`simultaneousTopTwo_of_commonPivotBadCount` was formalized in
`CommonPivotBadCount.lean`; its exact source compiles and its axiom probes use
only standard foundations. The response's stale formal label is therefore
corrected by the tracked implementation, not promoted on the strength of the
response alone. An independent adversarial replay found no count, boundary,
coprimality, scaling, or axiom gap. It did note that the declaration accepts an
arbitrary lower family: distinctness and numerical ordering below the two
proposed pivots belong to an outer sorted-family instantiation.

## Remaining exact gap

Pomerance's theorem gives no explicit `N0` in the form used here, and neither
the rectangle reduction nor the asymptotic corollary has been formalized in
Lean. The exact Gamma selector for every finite `N` remains conjectural. A
new proof must exclude connected arithmetic critical cores, exploit candidate
pruning, or provide an effective finite cutoff and reproducible completion.
