# Prompt75 independent mathematical audit

Task: `VER-P75-MATH-AUDIT-186`

Base commit: `b40872423d9e6aac3610f058a859600126740365`

Audited response: `research/sol-pro/responses/response75.md`

Response SHA-256:
`4fa46783c1e67477d56fc79f04a6b249c995aa2a095578852c2396f872fdd156`

## PI disposition

**MIXED mathematical memo; STOP every claimed global synthesis; preserve only
the independently checked local lemmas at their prior scope.**

Prompt75 does not prove an unrestricted bridge. The collective bounded-
hyperplane selector and the simultaneous-cover common-prime theorem are each
equivalent to unrestricted LRC after the already verified pivot equivalence,
normalization, and the accepted bounded-annihilator consequence are unfolded.
They do not shorten the proof obligation.

The multiowner compensation core is a genuine non-tautological sufficient
bridge, but Prompt75 gives no proof. Its first missing edge remains an
owner-indexed injection into actual safe destination sets with correct
multiplicity. The `(1,3,4)` calculation rejects the proposed nearest-boundary
map, not the compensation inequality itself. No proved unrestricted bridge
survives.

The local A1--A4, B1--B6, scaling, singleton, and `n=2` results agree with the
repository's earlier independent mathematical audits and were reconstructed
again here. One sentence in Prompt75's `n=2` proof is false: for general source
speed `u`, the safe residues at pivot `v=3mu` are not one interval
`[3mu,6mu]` with multiples of three removed. The count `G_v=2mu` and the
compensation theorem remain valid after reducing modulo `9m` and taking `u`
lifts. This is a proof repair, not a theorem refutation.

Prompt75's reported scan totals are not promoted. The response had no source
attachments, did not execute the recovered artifacts, and the outstanding
artifact audits remain deferred. The explicit small fixtures recomputed in
this audit are manuscript-level finite calculations, not acceptance of the
larger scans.

## Source identity and provenance boundary

The exact Prompt75 response hash matches the integrated recovery record, so
the audit did not stop for source mismatch. The three earlier source blobs are
now present and reproduce the hashes supplied in the Prompt75 contract:

| Source | SHA-256 |
| --- | --- |
| Response68 | `d8b3b8fbf4037690a53f6a79318e18d5cc7ea8ec00a8d93bb89072567ef27cc0` |
| Response69 | `9ade57c8530b89bb3fc60b48b740d619245f6eafb9b21801de11735ba51abdf1` |
| Response70 | `d8ec6af6c38fa49b938778b8114567bad8eb04a34738da25740a525d35cfadd9` |

This post-recovery hash check binds Prompt75's line references to the intended
repository sources. It does not alter the historical runtime fact recorded by
Prompt75 itself: those blobs were unavailable in its connected repository or
File Library while it generated the response. Statements that Prompt75
"inspected" Response69 or Response70 artifacts are therefore unsupported as
runtime provenance. At most, it inspected the contract's supplied summaries.
The mathematics below was checked independently rather than accepted from that
wording.

## Claim table

| ID | Exact proposition or assertion | Independent disposition | Reason and boundary |
| --- | --- | --- | --- |
| A1 | An admissible full-group PrimeForcing failure has between one and `n-2` coordinates divisible by `N=n+1`. | **Confirmed existing `proved-math`.** | `rho_(Np)(p*x)=p*rho_N(x)` makes `r=p` force one `N`-divisible coordinate; deletion gcd forbids `n-1`. No `p>N` or CRT premise is used. |
| A2 | For `p>N`, an owner's strict full-group bad set has the displayed disjoint CRT decomposition and cardinality `d*(2*floor((p-1)/d)+1)`, `d=gcd(N,v_i)`. | **Confirmed existing `proved-math`.** | Signed targets satisfy `|t|<p`; each soluble `N`-congruence has `d` fibers; two targets cannot differ by `Np`. Equality `rho=p` is safe. |
| A2-Delta | CRT capacity yields a fixed nonzero determinant or finite signature divisible by `p`. | **Rejected.** | The CRT ratios vary with `p`; no fixed integer is constructed. Setting the integer equal to `p` is circular. |
| A3 | A strict finite-field bad cover yields a nonzero annihilator `c` with `||c||_infinity <= H_n`, where `H_n=2*n*5^(n-1)*4^n+1`; if `p>H_n`, support has size at least two. | **Confirmed existing `proved-math` with the corrected constant.** | The periodic tent has positive set `(1/N,1-1/N)`, absolutely summable Fourier coefficients, and tail below its positive zero-frequency term. A support-one relation contradicts `b_i != 0`. |
| A4 | Every fixed positive injective integer counterexample lies on one of finitely many mixed-sign integer hyperplanes with coefficients bounded by `H_n`. | **Confirmed existing unrestricted necessary `proved-math` theorem.** | Sample at `x/p`, use A3 for infinitely many large primes, stabilize one bounded `c`, and conclude the fixed integer `c dot a` is zero. This is necessary only. |
| A4-to-proof | One bounded relation yields a cofinite-prime contradiction or a pivot certificate. | **Rejected.** | A relation is only the A4 necessary condition. No second relation or subtorus exclusion follows. |
| B1 | Simultaneous full pivot covers are exactly absence of every pivot certificate. | **Mathematically valid; existing global wrapper retains its prior `proved-lean` label.** | At each pivot, `Q_j` is the candidate grid minus the strict bad-set union. This audit did not rerun Lean. |
| B2 | If `q>=2` divides `N`, `q` does not divide pivot `a_j`, and pivot `j` is full, some owner is divisible by `q`. | **Confirmed existing `proved-math`.** | Candidate `r=(N/q)*a_j` is bad precisely for owners divisible by `q`. |
| B2-global | Simultaneous covers force at least one `N`-divisible speed; one such speed blocks the `q=N` coarse candidate at every non-`N`-divisible pivot. | **Confirmed existing `proved-math`.** | This is a necessary restriction only and does not propagate to a common divisor. |
| B3 | A single owner covers the entire pivot grid iff `N*a_j` divides the owner speed, for `n>=2`. | **Confirmed existing `proved-math`.** | The residue-class capacity argument rules out reduced pivot modulus greater than one; testing `r=1` then forces the remaining factor `N`. Exhaustive bounded checks also passed. |
| B4 | Simultaneous full covers force at least one pivot with no singleton owner cover. | **Confirmed existing `proved-math`.** | Choosing singleton owners would create a finite functional graph with speeds strictly increasing along every edge. |
| B5 | At pivot `2` of `(1,2,3,5)`, owners `1,3,5` partition the grid into `{1,9}`, `{3,7}`, and `{2,4,6,8}`. | **Independently recomputed finite `proved-math` fact.** | The partition is exact and all three owners are coprime to the pivot. It rejects private-point-to-gcd propagation only. |
| B6 | Pullback from each pivot modulus to their common lcm preserves that pivot's normalized Fourier transform on its embedded frequency subgroup. | **Confirmed existing `proved-math`.** | Summing over quotient fibers gives the formula. It creates no relation between different pivots. |
| B6-coupling | Common-modulus pullback forces independent annihilators, common support, rank growth, or a common prime. | **Rejected as an inference.** | Separate spectral embeddings have no cross-pivot identity. |
| B7 / CP | Every simultaneous full cover has a common prime divisor. | **Open and exactly LRC-equivalent, not a narrower bridge.** | It rules out primitive simultaneous covers after gcd normalization; LRC makes its antecedent false in the reverse direction. |
| C1 | Common scaling satisfies `G_k(d*a)=d*G_k(a)` and leaves the compensation weights invariant. | **Confirmed existing `proved-math`.** | Reduction modulo the unscaled pivot has exactly `d` lifts and preserves candidate and badness membership. |
| C2 | Weighted compensation holds for `n=2`. | **The theorem is valid; Prompt75's interval description requires correction.** | Singleton rigidity gives `v=3mu`. Modulo `9m`, the closed safe interval has `2m` candidates, each with `u` lifts, so `G_v=2mu`. |
| C2-interval | At pivot `v=3mu`, the actual safe residues modulo `9mu` are the single interval `[3mu,6mu]` with multiples of three removed. | **False for `u>1`.** | For `(u,v)=(2,6)`, actual `Q_v={4,5,13,14}`, while that interval gives `{7,8,10,11}`. The two sets have the same size but are disjoint. |
| C3 / WC | Universal weighted compensation holds at every covered pivot. | **Open.** | Finite reports do not prove it. Destination safety, owner labels, and multiplicity remain missing. If proved, it would imply LRC. |
| C4 | The Response69 nearest-boundary exchange always lands in some actual `Q_k`. | **Rejected exact map.** | `(1,3,4)` sends the source tokens only to bad destination candidates; it does not refute every possible injection or WC. |
| S1 / FH | Every positive injective tuple on every bounded mixed-sign A4 hyperplane has a pivot certificate. | **Exactly LRC-equivalent as a collective scheme.** | A4 sends every counterexample into the finite family; LRC certifies every member in the reverse direction. An individual fixed hyperplane remains a restricted open subproblem. |
| S2 / MC | Weighted compensation holds for every full pivot having no singleton owner. | **Open non-tautological sufficient bridge.** | B4 selects such a pivot in any simultaneous obstruction, but Prompt75 supplies no safe-charge injection. It is not proved progress. |
| S2-injection | There is an injection of `2*a_j` source tokens into the owner-weighted disjoint union of actual `Q_k` slots. | **Single unresolved lemma, unsupported.** | Neither private points, divisor forcing, a bounded relation, nor separate Fourier pullbacks establish destination membership or collision control. |
| S3 | Deletion minimality supplies a second stabilized bounded integer relation. | **Unsupported/open speculation.** | Prime-dependent modular relations do not stabilize twice without a new theorem. |
| S4 | A fixed A4 hyperplane excludes simultaneous covers. | **Open individual LRC subproblem.** | The finite conjunction is S1 and hence equivalent to LRC; no exclusion proof is supplied. |
| Scan69 | 2,429 primitive tuples, 806 covered rows, and no WC failure in the declared box. | **Reported computation; unaccepted here.** | Prompt75 had no artifact and performed no replay; artifact audit 152 remains deferred. |
| Scan70 | 2,384 primitive tuples and no simultaneous cover in the declared box. | **Reported computation; unaccepted here.** | Same provenance limitation; artifact audit 153 remains deferred. |
| PrimeForcing scans | First reported failures at `(n,p)=(3,5)` and `(4,7)` and the declared smaller-prime outcomes. | **Reported computation; unaccepted here.** | Artifact audit 151 remains deferred. These are modular full-group failures, not fixed integer LRC counterexamples. |
| MIXED / STOP | Prompt75's overall self-assessments. | **Not promoted as evidence labels.** | The independently reached route disposition agrees that the memo is mixed and no global synthesis succeeds, but status authority remains Sol High. |

## Independent proof checks

### A1 and A2

For every integer `x`, reduction in the subgroup of multiples of `p` gives

```text
rho_(N*p)(p*x)=p*rho_N(x).
```

At the full-group residue `r=p`, strict coverage therefore forces `N|v_i`
for some owner. If at least `n-1` coordinates were `N`-divisible, deleting the
only possible exception would leave survivor gcd at least `N`, contradicting
the premise. This also proves impossibility for `n=2` and, when `p|N`, clashes
with `p`-nonzero coordinates.

For A2, strict badness gives a unique signed target
`t in {-(p-1),...,p-1}`. Solvability of `c_i*x=t mod N` is exactly
`d_i|t` and then has `d_i` solutions; the field coordinate is unique. Distinct
targets cannot share a CRT pair because their difference has absolute value
less than `Np`. Counting the multiples of `d_i` proves the formula. Direct
enumeration independently checked it for `4<=N<=8`, primes
`p in {5,7,11,13}` with `p>N`, and every residue nonzero modulo `p`.

### A3 and A4

With `beta=1/2-1/N`, the periodic tent centered at `1/2` has positive set
`(1/N,1-1/N)`, zero boundary values, constant coefficient `beta`, and for
nonzero frequency `k`

```text
fhat(k)=(-1)^k*beta*(sin(pi*beta*k)/(pi*beta*k))^2.
```

For `n>=3`, `beta>=1/4`; its Fourier `l1` norm is below `5` and the tail
outside `[-H,H]` is at most `2/H`. The strict cover makes every sampled
product zero. Orthogonality retains precisely congruence annihilators. If no
nonzero annihilator lay in the `H_n` cube, the total nonconstant tail would be
strictly below `4^-n <= beta^n`, so it could not cancel the positive constant
term.

For a fixed counterexample, apply A3 modulo every sufficiently large prime.
Only finitely many bounded coefficient vectors exist, so one recurs for
infinitely many primes. Those primes divide the fixed integer `c dot a`, which
must therefore be zero. Positivity forces both signs. The argument supplies
one relation, not an exclusion theorem.

### Singleton, scaling, and `n=2`

The singleton theorem was exhaustively checked for `3<=N<=8`,
`1<=p<=10`, and `1<=q<=8*N*p`: full coverage occurred exactly when
`N*p|q`.

The common-scaling law and weight invariance were checked on every explicit
fixture below for scales `1,2,3,5`. For `n=2`, direct enumeration checked
`1<=u<=7` and `1<=m<=5`: `v=3mu` always gave `G_v=2mu` and the weighted
inequality. The correct set proof works in the quotient modulo `9m`; the
response's full-modulus interval sentence is not usable.

## Explicit fixture recomputation

The strict bad-set definition was reimplemented literally in memory; no
recovered verifier or artifact was used.

| Tuple | Independently recomputed `G` | Consequence |
| --- | --- | --- |
| `(1,2,3,5)` | `(0,0,2,2)` | Pivot `2` is the exact coprime three-owner partition B5. |
| `(1,2,3,4,5,7)` | `(0,0,0,0,2,2)` | Four full pivots do not force a common prime. |
| `(1,3,4,5,7,18)` | `(0,0,2,2,0,4)` | Pivot `7` is full although every owner is a unit modulo `49`. |
| `(4,5,9)` | `(2,2,4)` | At pivot `4`, two bad sets each have size six but overlap at `{7,9}`, leaving `{1,15}`. |
| `(1,3,4)` | `(0,2,2)` | The displayed nearest-boundary map fails while WC is not refuted. |
| `(1,2,3)` | `(2,2,2)` | The small mixed-sign relation `1+2-3=0` does not encode obstruction. |
| `(1,3)` | `(0,2)` | Exact strict/equality boundary in the `n=2` singleton case. |

For the all-but-one family

```text
a=(1,2,...,n-1,(n+1)*lcm(1,...,n-1)),
```

the proof is valid for every `n>=2`: the last speed singleton-covers each of
the first `n-1` pivots, while `r=L+1` is safe at the last pivot. Exact
enumeration for `2<=n<=10` reproduced precisely that full-pivot pattern.

The boundary fixtures also agree: `rho=p-1` is bad, `rho=p` is safe, and the
`N=2` antipode is a candidate exactly when the pivot speed is odd.

## Tautology and implication audit

Let `Cert(a)` be the exact pivot-certificate predicate and let `C_n` be the
finite set of nonzero mixed-sign integer vectors bounded by `H_n`. A4 proves

```text
not Cert(a) -> exists c in C_n, c dot a = 0.
```

Therefore the collective assertion that every positive injective tuple on
every such hyperplane has `Cert(a)` implies LRC, while LRC implies that
assertion pointwise. It is an exact reformulation after A4, not a new bridge.

Likewise, a common-prime conclusion for every simultaneous full cover implies
LRC after primitive normalization and scaling invariance. LRC makes the
simultaneous-cover antecedent impossible, so the reverse implication is
vacuous. This target is also exactly LRC-equivalent.

WC and MC are different. WC constrains every covered pivot, including tuples
with certificates elsewhere. MC restricts to multiowner full pivots. B4 makes
MC sufficient for LRC, but LRC does not erase MC's premise: `(1,2,3,5)` is a
non-counterexample having such a pivot. Thus MC is non-tautological, but it is
still merely an open sufficient lemma.

Claims that the response found the unique or sole possible synthesis are not
mathematical theorems; the audit accepts only the named implication and the
failure of the named mechanisms.

## Surviving and stopped routes

- **Survives as reusable unrestricted structure:** A4, B2, B3, B4, and the
  exact scaling/Fourier identities. These are necessary or local theorems, not
  a proof bridge.
- **Open but not advanced:** WC and its weaker MC core.
- **Exact first open edge:** construct an owner-aware, collision-free injection
  into actual `Q_k` slots with the prescribed capacities.
- **Stopped by counterexample:** nearest-boundary exchange, private-point gcd
  propagation, full-pivot nonunit-owner propagation, nearly-all-pivot common
  prime, and total-mass-equals-cover arguments.
- **Stopped by anti-tautology:** collective bounded-hyperplane exclusion and
  simultaneous-cover common-prime selection.
- **Unsupported provenance:** all broad finite scan totals and statements that
  Prompt75 inspected artifacts unavailable to its runtime.

## Final evidence boundary

This audit confirms previously accepted manuscript mathematics and adds only
the explicit correction to Prompt75's `n=2` proof description plus independent
small-fixture recomputation. It does not create a Lean theorem, replay a
certificate, accept a response-authored label, or promote a finite scan.

Recommended disposition to Sol High:

- accept the claim table as an independent audit document;
- retain existing local `proved-math` labels only where prior audits and the
  present proof check agree;
- record the C2 interval sentence as rejected but the C2 theorem as valid;
- keep WC, MC, S3, and individual hyperplane exclusions open;
- freeze the rejected mechanisms and both LRC-equivalent syntheses; and
- conclude that Prompt75 supplies no proved unrestricted LRC bridge.
