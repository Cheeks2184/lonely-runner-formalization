# Direct proof screen for five total runners

2026-09-06. Assigned Astra/xhigh research screen by
`/root/mss_published_bound_audit`; requested routing is not independently
attested. Current project configuration, workflow, policy and active state
were read; the structural validator passed. Base:
`a9050d209eacb78dfe32b435d67a7e115819f3e9`. Only this manuscript is owned.
No formalization, tuple search, tool installation, Lean/build/cache command,
source/Git/state change or retained PDF is part of this screen.

**Recommendation:** pursue a separate contract review of the modulo-five
carry lemma and the decomposition-based filtering interface below. This is
a materially better candidate for a complete ordinary five-total-runner
proof than expanding an undiscovered height-1000 partition certificate.
The new lemmas are still unformalized; this is a research recommendation,
not an accepted kernel proof, resource estimate or full LRC result.

## Primary proof actually read

Barajas and Serra, *The lonely runner with seven runners*, Electronic Journal
of Combinatorics 15 (2008), R48: Section 1 fixes the count convention; Section 2,
Lemma 2 and Corollary 3, pp. 3–4, prove prime filtering; the unnumbered Section 3
argument on p. 5 proves the case of four positive integer speeds, hence five
total runners, with the closed margin 1/5. I read these proofs, not only the
abstract. Their modulus is a prime power, not the runner count. Filtering
handles lower five-adic levels of size at most two. The remaining pattern
has three units and one entry of maximal valuation; its argument uses
modulo-five compression and multipliers 1, 2, 3. The highest-valuation entry
is not necessarily the fastest. No height-bounded speed enumeration or
seven-runner case analysis is needed for this section.
[Publisher PDF, Sections 1–3](https://www.combinatorics.org/ojs/index.php/eljc/article/download/v15i1r48/pdf).

A second published candidate is Bienia, Goddyn, Gvozdjak, Sebő and Tarsi,
*Flows, View Obstructions, and the Lonely Runner*, JCTB 72 (1998), 1–9,
DOI 10.1006/jctb.1997.1770. The publisher abstract identifies an elementary
proof for four moving speeds and describes the earlier Cusick–Pomerance
proof as using electronic case checking. The full publisher PDF returned
403 here, so I do not rank that proof's detailed Lean cost or claim to have
audited its body.
[Publisher record](https://www.sciencedirect.com/science/article/pii/S0095895697917706).

## Our proposed Lean decomposition

The following is an independently derived implementation plan, not existing
Lean declarations. It bypasses graph chromatic numbers and their liminf
definition: construct a residue multiplier and use the existing exact
circle-norm bridge directly.

1. Normalize a positive Fin 4 family using
   `exists_scaleSpeeds_primitive`, whose factorization theorem has no Prompt95
   premise. Obtain positive g and b with v_i=g*b_i. Primitivity supplies some
   b_i not divisible by 5. Establish certificates
   `b_i=5^ell_i*u_i`, `5∤u_i`, `ell_i<=m`, with minimum 0 and attained maximum m.
   A small natural induction suffices for these certificates; no p-adic field,
   valuation topology or general prime-filtering framework is required.
2. Put R=5^m, P=5R, and define the highest digit
   `digit(x)=((x / R) mod 5)` with integer division when x is signed.
   At a level j<m, multiplying by `1+k*5^(m-j)` fixes residues modulo P
   of all higher levels and changes a level-j digit by
   `k*(x/5^j) mod 5`. The nonzero coefficient is a unit modulo 5.
   Prove these identities before introducing the avoidance induction.
3. At each lower level with at most two labels, every label excludes at most
   two choices of k in Fin 5. Their union has size at most four, so one
   choice remains. Descending induction preserves all previously good higher
   levels. The top level is already at cyclic distance at least R for every
   unit multiplier. Handle m=0 separately by time 1/5; Corollary 3's positive
   level-index premise should not be forced onto that base case.
4. With four labels, minimum level zero and maximum m>0, a lower level of
   size at least three must be level zero, with exactly three labels and one
   top label. Discharge this pattern using the finite carry contract below.
5. Conclude `R<=cyclicResidueDistance P (lambda*b_i)` for all original labels.
   `circleNorm_nat_div_ge` gives the closed fifth margin at lambda/P.
   Choose a positive multiplier, or its positive unit representative modulo P,
   then divide the time by g. No maximum-speed cutoff is used.

The existing code search found no five-adic or prime-filtering formal module;
this is new proof work. The elementary factorization/level contracts above
make its scope explicit and allow use of a suitable Mathlib valuation lemma
later without coupling the core argument to a new valuation API.

## Highest-risk finite contract

Normalize unit signs first, preserving circle norms and reducing their
nonzero residues modulo 5 to 1 or 2. Then define the signed integer digits
afresh. For a unit x, the lower remainder z in `x=R*q+z` satisfies
`0<z<R` when m>0. If digits are transported through sign change, the correct
identity is `digit(-x)=-digit(x)-1 (mod 5)`, not simple negation.

Our convenient carry representation is

```text
a = floor(2*z/R),    b = floor(3*z/R),
a in {0,1},         a <= b <= a+1,
(a,b) in {(0,0),(0,1),(1,1),(1,2)}.
digit(2*x) = 2*digit(x)+a  (mod 5)
digit(3*x) = 3*digit(x)+b  (mod 5).
```

The compatibility comes from comparing the two floors with the same
z/R in [0,1); it is not a pair of independent carry choices. Multiplication
by 1+kR leaves z unchanged. After dilation j, its digit translation is
`k*j*(x mod 5)`. These facts provide a finite-state formulation with actual
arithmetic realizability, rather than an arbitrary table of phase shifts.

The intended proof obligations are two compression cases: three equal unit
residues can be placed inside three consecutive digit classes; a repeated
residue pair can be placed inside two. Prove them using the compatible
double/triple carries and small Fin 5 case splits. For the pair case, select
two permissible translations separated by the inverse of its residue s.
The third residue r is not ±s; its two forbidden translations are separated
by ±r inverse and therefore cannot occupy both selected choices.

This is the delicate new semantic obligation to audit next. In particular,
one must prove the normalization of cyclic digit configurations, keep the
carry correlation through prior translations, and restore original signs.
Finite residue and carry cases remain essential, but their domain is fixed
and does not grow with the speeds. I performed no enumeration of those states
and claim no compiled Boolean completeness lemma or measured checking cost.

## Exact ordinary contract and canonical bridge

The natural theorem needed by the current project is:

```text
forall speeds : Fin 4 -> Nat,
  Function.Injective speeds ->
  (forall i, 0 < speeds i) ->
  exists time : Real, forall i,
    (5 : Real)^(-1) <= circleNorm (time * (speeds i : Real)).
```

A positive-time conclusion is available from the proposed multiplier
construction, but is unnecessary for this bounded lower-count interface.
There is no sort, height or primitive hypothesis in the final theorem:
normalization and scale transport must discharge those internally.

Combine this new d=4 theorem with the existing
`lowerCountPositiveIntegerHypothesis_five` for d=1,2,3 to prove H6.
Then `LonelyRunner.lonelyAt_of_lowerCount (m:=4)` returns the canonical
ordinary statement for any injective `Fin 5 -> Real` speeds and any chosen
label. Its threshold is 1/5, with quantifier order forall runner, exists time.
The existing bounded real/signed reduction supplies the arbitrary signs,
irrational speeds and repeated absolute relative speeds. No all-dimensional
positive-integer conjecture premise is needed. H5 alone is not H6.

This would prove only the ordinary five-total-runner case. It would not
prove strict existence, the separate fastest-quarter mixed condition, K5,
the shifted conjecture or unrestricted LRC.

## Cost comparison with the current finite route

| Route | Already reusable | Remaining substantial obligation |
| --- | --- | --- |
| Height-1000 checking/partition | H5, sharper large-height theorem, normalization, rational rows, completeness interfaces | A complete finite coverage certificate or small complete partition, including every residual row |
| Decomposition and filtering | Normalization, modular arithmetic, finite counting, exact residue-to-circle bridge, H6-to-canonical bridge | Level identities, descending two-label avoidance, and the fixed compatible-carry compression lemma |

The existing finite design counts `choose(1000,4)=41,417,124,750` raw increasing
rows before its distinct filters. It supplies no proven small complete
partition for the remainder. The direct route substitutes a symbolic
induction over the exponent for that discovery/coverage obligation.
Its modulus can grow with the input; avoiding tuple enumeration does not mean
every witness is on a universal fixed grid. The present two-leaf box pilot
can still validate reusable infrastructure without becoming the main proof
search. C4 mixed and buffered insertion remain useful established classes,
but this direct route does not require a new global mixed-supply theorem.

Next bounded step: independently settle the concrete decomposition and
compatible-carry lemma contracts, then assign their implementation separately.
No direct-proof code should be inferred from this screen as already verified.

## Source/read provenance

Primary retrieval used web search followed by the actual publisher PDF,
including the complete Lemma 2 proof, Corollary 3 and Section 3 argument; the duplicate
Charles University copy was not treated as a separate mathematical source.
Only publisher/institutional primary records support the literature statements.
No PDF or large artifact was saved. Source inspection used `rg` and `sed`;
no Lean, build, resource pilot or tuple search was run. The following local
hash receipt binds the interfaces and cost document used, without executing
any mathematical search or changing files.

```python
from hashlib import sha256
from pathlib import Path
guards = {
    'LonelyRunner/PrimitivePrompt95.lean':'d1d6cf01650c809da0cb19ed722754071df070831e02e22a3c4b2c3dc28afb04',
    'LonelyRunner/LowerCountSupply.lean':'0705291adc53011fb72fc718a7260876512b092741442d6a6cceb4b76eb5ccf4',
    'LonelyRunner/FourRunnerOrdinary.lean':'2fb2f5c9c0742daa3278ee0ddeacd8643e1e22f8c885de95f5f38e10734b29f6',
    'LonelyRunner/BoundedRealReduction.lean':'7eae68d2c46041b39c3e18f9a1e105c75680352f8e4b4edf65e0dd2a92becb72',
    'LonelyRunner/PivotResidues.lean':'362da5ab923f22e900ae7ac821dd4cf4aab91dfe70889987bc9e5a05d19c276a',
    'LonelyRunner/StructuredClasses.lean':'5328a7a88d2b42f86ffc3f0f0418ca22c761219e8fa3e5822bda5a18ac286e8c',
    'LonelyRunner/RationalMarginCertificates.lean':'ffe31ce9636281f6c4b8fc2cdf618043a6c02b0195bf75ff6e0aee65c317c1d9',
    'LonelyRunner/FiniteHeightReduction.lean':'cb41059260b943411e2ab5360b84b59cd13f2ddf352c3c50a0b3715b9b9987d6',
    'research/astra-five-runner-certificate-design.md':'cc7990790d3ca8ddd50d36dc64d80af74b1f82d45b64ba20e31fbbc0b78fc403',
    'lean-toolchain':'8e3538e0ab5f81a3ee04927d8838c8c674e0e112838b4b3ce87ec218143276af',
    'lake-manifest.json':'887450bc75a38effdae452a14b60f6d225bc10b48c71b3827e3479b800f41218',
}
for path,digest in guards.items():
    assert sha256(Path(path).read_bytes()).hexdigest() == digest, path
print('source_guards=11 passed; Lean_execution=none; tuple_search=none')
```

The guard receipt completed with terminal exit 0, tool chunk `3d8d41`:
all eleven hashes passed. Program SHA-256:
`46c85f5879d0ef723039c0798ac7ea415513b30dc185f379ccae76f9f7f48846`.
Raw stdout SHA-256:
`e564d7f6c0f485751d0aeabfdad706c1bb9b5354ca65ae44cdab39388c952549`.
The final workflow validator also exited 0. Its result certifies only record
consistency. Exact receipt command, from the repository root:

```sh
python3 -B - <<'PY'
from pathlib import Path
from hashlib import sha256
from contextlib import redirect_stdout
import re,io
f=chr(96)*3
s=Path('research/astra-five-total-direct-proof-screen.md').read_text()
b=re.findall(rf'^{f}python\n(.*?)^{f}[ \t]*$',s,re.M|re.S)
assert len(b)==1
out=io.StringIO()
with redirect_stdout(out):
 exec(compile(b[0],'<five-total-direct-screen-guards>','exec'),{})
print(out.getvalue(),end='')
print('program_sha256='+sha256(b[0].encode()).hexdigest())
print('stdout_sha256='+sha256(out.getvalue().encode()).hexdigest())
PY
```

Screen disposition: recommend the decomposition/filtering route for the next
bounded mathematical contract review. Its published ordinary scope is verified;
the proposed Lean contracts, carry compression and assembly still need their
own proofs and independent review. No implementation is started here. All
commands are stopped at handoff, and the unrestricted goal remains unresolved.
