# Independent review of global active-zero translations

Task `/root/zero_contact_global_review`, reviewer handle
`/root/coordinate_cancellation_review`; requested `gpt-6-astra` / `xhigh`.
Assignment source: `5aecd6775dd9480e3e4eaa8e8ec7fe76ebd80665`.
Only this review is owned. The complete frozen author was read.

**Verdict: accepted at the stated manuscript scope, without corrections.**
The translated-cell maxima, phase orbits, primitive residue property,
strict counting formula and conditional all-cell obstruction are sound.
The good control refutes only unconditional placement of a remaining
tuple's own canonical witness on the designated seeds. The full strict
minimal-failure selection problem remains unresolved.

## Retained hypotheses and arithmetic

The application retains a positive distinct primitive ordinary integer
failure, minimal by moving count `d=N-1>=6` and then natural sum, with
`alpha=1/(d+1)`, `0<mu<alpha` and `r=1-2mu`. The odd lift `n` is
globally closest at normalized doubled time `0<s_0<1`, with residual
maximum `r` and `1<=n_i<=v_i`. Its fold is `w=v-2n`. The zero set
`Z` is nonempty, its largest speed `z` is active, and an opposite active
coordinate of speed `b` has folded absolute value two.

The accepted predecessor gives exactly

    z congruent 2 mod 4, b congruent 0 mod 4, D=z+b,
    mu=b/(2D), r=z/D, (d-1)b/2<z<(d-1)b,
    t_*=1/4-sigma/(2D)=m_*/D,
    m_*=(D-2sigma)/4, sigma in {+1,-1}.

Thus `D congruent 2 mod 4` and `m_*` is integral. The author does
not assume reflection about quarter time preserves the original tuple.
Writing the deleted gcd as `2g` gives positive odd `g,A_i,A`, where
`v_i=2gA_i`, `gcd A_i=1`, `A_i<=A=z/(2g)`. With
`b=4B`, `c=gcd(g,B)`, `h=g/c`, `B_0=B/c`, the quantities
`c,h,Q_0=hA+2B_0` are odd, `gcd(h,B_0)=1`, and `D=2cQ_0`.
In particular `gcd(2h,Q_0)=1` and `Q_0>h`.

## Every common centre and its exact maximum

If every deleted speed is half-integral at a time `t`, then with `x=4gt`
all `A_i x` are odd integers. Bezout makes `x` integral; oddness of any
`A_i` makes it odd. The converse is immediate. Hence the complete common
half-time centres modulo one are `C_l=1/4+l/(2g)`, `0<=l<2g`.

On the corresponding closed cell `|t-C_l|<=1/(2z)`, the exact deleted
minimum is `1/2-z|t-C_l|`. Put `f={bC_l}`, `a=min(f,1-f)` and
`x=|t-C_l|`. The contact norm is at most `a+bx`. Intersecting this
increasing affine bound with `1/2-zx` gives maximum

    (b/2+za)/D=mu+ra

at distance `x=(1/2-a)/D`. This is attained at
`T_l=C_l+(1/2-f)/D`. Indeed, its contact phase modulo one is
`(zf+b/2)/D`, which lies on the appropriate side of one half. Its
distance equals the displayed maximum for both `f<=1/2` and `f>=1/2`.
The deleted maximum loses exactly `zx`, and every smaller deleted speed
loses no more. The same time therefore handles all deleted coordinates.
At `f=0` both displacements `+/-1/(2D)` work; the author selects the
plus sign without identifying it with the old maximizing choice. At
`f=1/2` the centre itself works.

Also `DT_l=zC_l+floor(bC_l)+1/2` is integral, because `zC_l` is
half-integral. Thus these are actual grid times, with one common phase.

The phases are `{2B_0l/h}`. Since `2B_0` is invertible modulo odd `h`,
each of the `h` phases occurs `2c` times. If `h=1`, every phase is zero
and every such cell has ceiling `mu<alpha`. This excludes witnesses from
those cells only. If `h>1`, then `h>=3`, and the maximal phase distance
is `(h-1)/(2h)`. The resulting subset margin is

    lambda=mu+r(h-1)/(2h)=1/2-r/(2h)>1/3>alpha.

These times witness the deleted coordinates and `b`, not yet the full
tuple. For a single zero, `g=z/2` and
`h>=g/B=2z/b>d-1`, excluding the fixed-phase case. More generally
`h>=g/B=4g/b`; consequently `g>b/4` ensures `h>1`.

## Best seeds, reflection and the numerator restrictions

The two maximal phases correspond to opposite centre-index classes modulo
`h`. Within one class, increasing `l` by `h` increases `T_l` by
`1/(2c)`. Choose a best time `T=K/D`. Its class gives the orbit

    O={T+j/(2c):0<=j<2c}.

For the opposite class, `C_{-l}=1/2-C_l` modulo one and
`f_{-l}=1-f_l`, since the maximal phases are nonzero. Therefore
`T_{-l}=1/2-T_l`. A half-period already belongs to the orbit's shift
group, so the opposite orbit equals `-O` modulo one. Reflection preserves
every integer-speed distance. This proves representation of all best-seed
distance vectors by one orbit; it does not claim the two sets of times
are identical.

At a maximal phase, direct multiplication gives

    2hK=Q_0(ch+2l)+/-1.

Hence `2hK=+/-1 mod Q_0` and `gcd(K,Q_0)=1`. Independently, putting
`D=2Q` with odd `Q` gives `2m_*=Q-sigma`, so `gcd(m_*,Q)=1`
and `gcd(m_*,D)` is one or two. Positivity of the old global margin
excludes every original speed divisible by `D/gcd(m_*,D)`, in particular
every original multiple of `D`.

For any integer speed `a`, vanishing at every orbit time implies
`a/(2c)` is integral by comparing consecutive times. Write `a=2cs`.
Vanishing at `T` then means `Q_0|sK`, hence `Q_0|s` and `D|a`.
The converse follows at once. This verifies the exact all-orbit vanishing
criterion, including the otherwise relevant factors of `c`.

For an original speed `a=2cs`, the orbit phase is constant. The congruences
`2m_*=-sigma mod Q_0` and `2hK=+/-1 mod Q_0` show that the old
phase agrees up to sign with `h aT` modulo one. Thus
`mu<=||a t_*||=||h aT||<=h||aT||`, proving the stated lower bound
`||aT||>=mu/h`. This bound lies below `alpha`; nonvanishing does not
supply a canonical margin. For odd speeds, paired times differing by one
half have complementary norms summing to `1/2`. At `alpha<=1/4` a
strictly bad coordinate occupies at most one member of each pair, but
different coordinates can occupy different halves.

## Every admissible maximizing orbit

For `q=2B_0l mod h` chosen in `0,...,h-1`, let `k_l=DT_l`.
Direct substitution gives

    2h k_l=Q_0(ch+2l)+h-2q,
    lambda(q)=1/2-r|h-2q|/(2h).

Choose the best representative with `2hK=1 mod Q_0`. Invertibility of
`2h` modulo `Q_0` gives `k_l=(h-2q)K mod Q_0`. Congruence modulo
`Q_0` corresponds exactly to a shift by an integer multiple of `1/(2c)`
in ordinary time. Positive and negative signed values of `h-2q` have
reflected orbits and the same vectors of distances.

Consequently all common-centre maximizing orbits meeting the subset target
are represented, up to reflection, by

    O_a={aK/D+j/(2c):0<=j<2c},
    a positive odd, a<=h(1-2alpha)/r.

The target equality is included. Strict failure gives `1-2alpha<r`,
so every admitted index is less than `h<Q_0`, excluding the zero phase.
Distinct admitted positive indices yield distinct residues modulo `Q_0`
after multiplication by `K`, so their orbits are disjoint. The positive
index one is admitted by the strict subset margin already proved.
This is an additive full orbit based at `aK/D`; the author correctly
does not assume that multiplication by `a` permutes the first orbit.

## The conditional persistent blocker

If the original tuple contains speed `4g=4ch`, its best-orbit phase is
`2hK/Q_0`, of distance exactly `1/Q_0`. The phase is constant across
the orbit. Since `mu=B_0/Q_0<1/N`, one has `Q_0>NB_0>=N`, so that
nonzero distance is below the canonical target. The nonvanishing criterion
therefore does not rule out a coordinate blocking the entire best orbit.

For `A>=3`, its old phase is `g-sigma*h/Q_0`, with `h/Q_0<1/2`.
Its normalized nearest odd lift is `2g-sigma`, and its folded value is
`2sigma`. Its old norm is at least `mu` exactly when `B_0<=h`, which
becomes `B_0<h` for `h>1` by coprimality. These are coordinatewise
compatibility conditions, not a construction of a full minimal failure.

At every common centre, `4gC_l=g+2l` is integral. Applying the exact
zero-phase pair ceiling to speeds `z=2gA` and `4g` therefore gives
`1/(A+2)` throughout each cell. If `A>d-1`, this is below `alpha`
and excludes original witnesses from all common-centre cells, including
their seed displacements. The accepted old ratio bound for this speed
gives only `A<2(d-1)`. The displayed subcase
`d-1<A<2(d-1)`, `B_0<h`, with original speed `4g` present, is thus
a conditional obstruction with all original hypotheses retained. The
manuscript neither claims its existence nor claims to exclude it.

## Strict counting and the unresolved common choice

Let `R` be the remaining original coordinates and `F` the admitted positive
odd indices. For a coordinate `i`, put `E=gcd(v_i,2c)`, `L=2c/E`
and `x=v_i aK/D`. The phases on `O_a` are an equally spaced `L`-point
grid repeated `E` times: dividing out the gcd makes the step invertible
modulo `L`. With `theta={Lx}`, this grid is represented by
`(theta+m)/L`, `m mod L`.

A phase is strictly bad exactly when an integer representative belongs to
`(-alpha L-theta, alpha L-theta)`. The open interval has length
`2alpha L<L`, so no residue is counted twice. The number of integers is

    ceil(alpha L-theta)+ceil(alpha L+theta)-1.

Multiplying by `E` gives precisely author (15), including phases exactly
at either canonical boundary being good. Thus the double sum in (16)
counts bad-coordinate incidences on the disjoint selected seeds. If it
is strictly below `2c|F|`, the finite union bound leaves a seed good for
every remaining coordinate, while `Z` and `b` are already good. This is
an actual sufficient witness certificate. Under full failure, its reverse
weak inequality is necessary. Neither converse sufficiency nor equivalence
with unrestricted LRC is asserted. The one-orbit specialization is valid.

The best subset margin also gives a common protected interval of radius
`(lambda-alpha)/z`: every subset speed is at most `z`, since the retained
failure ratio implies `z>b`, and circle distance is Lipschitz with its
speed. No bound here places all remaining coordinates in their good sets
at one time within that interval.

## Exact good control and disposition

For `(1,3,4,6,7)`, the core `(1,3,4,7)` has global margin `1/5`.
The author's strict interval exclusion verifies the upper bound over all
real times after reflection, and time `1/5` attains it also for speed
six. At doubled time `2/5`, the stated lift has residuals
`(3/5,-1/5,-3/5,3/5,1/5)` and raw fold `(-1,1,2,0,1)`.
Thus `z=6`, `b=4`, `g=h=3`, `c=1`, `D=10`, and `Q_0=5`.
The minors `-2,-3` prove saturation of its nearest-point plane.

The four actual best seeds modulo one are exactly
`1/10,2/5,3/5,9/10`, with subset margin `2/5`. The remaining tuple
`(1,3,7)` is all odd and has a canonical `1/4`-witness at `1/2`.
On the first and last seeds speed one has norm `1/10`; on the middle
two speed three has norm `1/5`. Hence none is a canonical witness for
that remaining tuple. This refutes unconditional placement of its own
lower-count witness on these seeds. It does not refute the sufficient
count test, strict-failure-only supply, or LRC: the original tuple has
margin `1/5>1/6` and is not a minimal failure.

The first unresolved implication is global common-time supply. In the
fixed-phase or conditional `4g` all-cell obstruction, the argument must
exclude the configuration or reach other deleted-speed good components.
Elsewhere it must force an uncovered seed or control every remaining
coordinate in one protected interval. Individual lower-count witnesses,
primitive seed residues and nonvanishing on an orbit do not establish
that quantifier. No new invariant, smaller failing tuple, unrestricted
witness or formal declaration is supplied.

## Frozen bindings and actual checks

The complete author was read. Its predecessor and accepted review were
fully read in the immediately preceding bounded review and remain unchanged;
the validator was also fully read earlier in this session. Current config,
workflow, policy and focused state were read. State is `research` /
`in_progress`, with explicit start authorization from 2026-09-05 and this
exact review active. All seven frozen bindings matched:

| File | SHA-256 |
| --- | --- |
| `research/astra-zero-contact-global-escape.md` | `deff1f1667f885ff793414988889806bf259247fb64c2d4ab264672fa2202d71` |
| `.codex/config.toml` | `28212a53cf42cdc377df1f7dab040732d657e59d7bb97ee78791256d01d4bb2c` |
| `docs/project-workflow.md` | `2b42a133352b6b53ba2106fc73882733f176e04a0deffbb183b4c16eefd9cd67` |
| `research/workflow-policy.json` | `833c397b61d1ffdb994fb115019f6d60d6c1a62ff85f19cdd2c9f8ac3a979c8b` |
| `scripts/validate_workflow.py` | `250a3ce2a080f5835ac4fd2e4b2803568424c777cda5d421f9fe92efd34d5383` |
| `research/astra-fold-zero-restoration.md` | `70bbf19a595c63f7940c02ae62b815125731131f27aeade818c9a1fa1ab3507a` |
| `research/astra-fold-zero-restoration-review.md` | `559deadd612ca99a4ebc99d8fba104f2e5243ae412785d3572b70633af7ac59e` |

Actual command in `/home/joshua/lonely-runner-formalization`:

    python3 -B scripts/validate_workflow.py

Exit status `0`; complete output:

    workflow structural validation passed; it cannot certify mathematical validity.

The mathematical verification is the exact hand algebra above, not the
administrative validator. Final readback checks all seven source bindings,
the earlier frozen reviews, final newline and trailing whitespace, and
reports this review's SHA separately. There were no mathematical errors.
The first file-creation patch was rejected for a missing patch-line prefix;
correcting that formatting produced this owned file. All shell checks
returned zero. No mathematical program, search, build, cache/dependency
operation, external/browser model, extra agent, Git/shared-state write or
other-file edit was used. No owned process remains. Requested route is
Astra/xhigh; observed model, effort, elapsed time and per-task usage are null.
