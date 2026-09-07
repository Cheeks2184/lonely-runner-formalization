# Global translations of an active-zero contact

Task `/root/zero_contact_global_escape`, existing handle
`/root/fold_zero_restoration_resume`, requested Astra/xhigh. Assignment
source `a1bb6a4196ef55d46b81846d767a887c747b15d9`. Only this manuscript
is owned; the predecessor remains frozen. Current config, workflow, policy
and focused state were read; research is authorized and validation passed.
The predecessor's independent review arrived during this task and was read
in full before adopting its accepted manuscript conclusions.

**Author result, pending independent review.** Translation among the deleted
speeds' common half-time centres has an exact alternative. In the fixed-phase
case every translated central cell is blocked by the same contact pair.
Otherwise there are explicit times on the grid `1/(z+b)` at which all
deleted speeds and the contact speed have margin strictly above `1/3`.
The best such times form, up to reflection, one arithmetic orbit, with a
primitive residue property and an exact sufficient counting test for an
original canonical witness. Neither the fixed-phase case nor the remaining
orbit blockers are excluded uniformly. This is one bounded translation
attempt, not an unrestricted proof or a proposed new count ladder.

## Retained full hypotheses

Assume a positive distinct primitive ordinary integer failure, least by
moving count `d=N-1>=6`, then natural sum. Let

    alpha=1/(d+1),   mu=max_t min_i ||v_i t||<alpha,
    r=1-2mu,        n=s_0*v+e,    0<s_0<1,
    n odd,          ||e||_infty=r,    1<=n_i<=v_i.

The lift is globally closest in the full odd coset. Write `w=v-2n` and
`Z={i:w_i=0}`, nonempty. The largest deleted speed `z` is active, and
an opposite active coordinate of original speed `b` has `|w_b|=2`.
The accepted predecessor gives

    z=2 mod 4,   b=0 mod 4,   D=z+b=2 mod 4,
    mu=b/(2D),   r=z/D,       (d-1)b/2<z<(d-1)b,
    t_*=s_0/2=1/4-sigma/(2D)=m_*/D,
    sigma in {+1,-1},         m_*=(D-2sigma)/4.             (1)

Every deleted speed is `2 mod 4`, but that congruence alone does not
make a coordinate deleted. Put

    gcd_(i in Z) v_i=2g,      v_i=2g A_i (i in Z),
    A=z/(2g),                b=4B.

Here `g`, all `A_i`, and `A` are positive odd integers,
`gcd_i A_i=1`, and `A_i<=A`. Define

    c=gcd(g,B),    h=g/c,    B_0=B/c,
    Q_0=hA+2B_0,            D=2c Q_0.                     (2)

The integers `c,h,Q_0` are odd, and `gcd(h,B_0)=1`. Subscripts in
`B_0,Q_0` are merely arithmetic notation, not the quotient norm's body.

## Exact translated cells and their pair-maximizing times

The common half-time centres of all deleted speeds, modulo one, are exactly

    C_l=1/4+l/(2g),       0<=l<2g.                        (3)

To check completeness, if every `2g A_i t` is half-integral, put
`x=4gt`. Then each `A_i x` is an odd integer. Bezout and `gcd A_i=1`
make `x` an integer, and any odd `A_i` then makes `x` odd. Conversely
odd integral `x` works. Since `g` is odd, (3) lists precisely these times.

On `J_l={C_l+u: |u|<=1/(2z)}`, the deleted minimum is
`1/2-z|u|`. Put `f_l={b C_l}` and `a_l=||b C_l||`. Lipschitz continuity
of circle distance bounds the contact speed by `a_l+b|u|`, so

    max_(t in J_l) min(min_(i in Z)||v_i t||,||bt||)
      =(b/2+z a_l)/D=mu+r a_l.                           (4)

Equality is constructive. The time

    T_l=C_l+(1/2-f_l)/D                                  (5)

lies in the cell. At it the contact phase moves toward its nearest half
and the largest deleted speed moves away from its half, meeting at the
value (4). Explicitly `|T_l-C_l|=(1/2-a_l)/D`, and the contact phase
is `(z f_l+b/2)/D`; taking its distance verifies both signs and endpoints.
When `f_l=0`, both choices `C_l+/-1/(2D)` attain (4). Formula (5)
selects the plus choice only; it is not asserted to equal the chosen old
maximum in (1). At `f_l=1/2` the maximizing time is the centre itself.

These are actual contact-grid times:

    D T_l=z C_l+floor(b C_l)+1/2 is an integer.             (6)

Indeed `z C_l` is half-integral. Formula (4) applies to the entire deleted
family, not merely its maximum, because the smaller deleted speeds lose
no more distance than `z` at the same displacement.

The contact phases in (3) run through

    {2B_0 l/h} mod 1,

each of the `h` residues occurring `2c` times. If `h=1`, all phases
are zero. Under (1), every `J_l` then has pair ceiling `mu<alpha`.
Thus **every** cell centred at a common deleted half-time is blocked,
not only the original quarter cell. This does not describe all other
components where the deleted speeds can simultaneously be good.

If `h>1`, its oddness gives `h>=3`. A centre has
`a_l=(h-1)/(2h)`, and (5) gives all deleted speeds plus `b` margin

    lambda=mu+r*(h-1)/(2h)=1/2-r/(2h)>1/3>alpha.           (7)

This is a genuine simultaneous witness for that subset outside the blocked
quarter cell. It uses no shifted LRC premise or lower-count time selection.
For a single deleted speed, `g=z/2`, so
`h=g/gcd(g,B)>=g/B=2z/b>d-1`: the fixed-phase obstruction is then
impossible. More generally `h>=4g/b`, so `g>b/4` suffices for (7).
These inequalities alone do not control any remaining original speed.

## The best-seed orbit retains arithmetic, but not all margins

Suppose `h>1`. The maximal phases are `(h-1)/(2h)` and `(h+1)/(2h)`.
Their centre indices are two opposite classes modulo `h`. Choose one
class, a time `T=T_l`, and write `T=K/D`. Translating `l` by `h`
translates `T_l` by `1/(2c)`. Reflection of the opposite phase class
gives the same vectors of circle distances. Thus, for simultaneous norm
questions, all best seeds are represented by the single orbit

    O={T+j/(2c): 0<=j<2c}.                               (8)

For the reflection assertion, `C_{-l}=1/2-C_l` modulo one and, since
these phases are nonzero, `f_{-l}=1-f_l`. Hence
`T_{-l}=1/2-T_l`; half a unit is already an orbit shift in (8), and
reflection `t -> -t` preserves every integer-speed distance.

At a maximal phase `1/2-f_l=+/-1/(2h)`. Multiplying (5) by `2hD`
therefore gives the useful retained congruence

    2hK=Q_0(ch+2l)+/-1,
    2hK=+/-1 mod Q_0,             gcd(K,Q_0)=1.             (9)

The old numerator has `gcd(m_*,D) in {1,2}`: writing `D=2Q` with
odd `Q`, the equality `2m_*=Q-sigma` shows `gcd(m_*,Q)=1`.
Consequently no original speed is divisible by
`D/gcd(m_*,D)`, since that would vanish at the actual old optimum.
In particular, no original speed is divisible by `D`.

For any integer speed `a`, (8)--(9) imply exactly

    ||a t||=0 for every t in O   iff   D divides a.         (10)

The forward implication first gives `2c|a` by subtracting consecutive
orbit phases. Write `a=2c s`; vanishing at `T` gives `Q_0|sK`, hence
`Q_0|s` by (9). The converse is immediate. Thus an actual original
coordinate cannot vanish on the entire best-seed orbit.

Being nonzero does not make its margin canonical. For example, when
`a=2c s`, its phase is constant on (8). Congruence (9) and
`2m_*=-sigma mod Q_0` give

    ||a t_*||=||h aT|| <= h||aT||,
    ||aT|| >= mu/h.                                      (11)

This retains an actual consequence of global old optimality, but
`mu/h<alpha`. It leaves a nonempty possible interval of nonzero bad
phases. No existence of a full failure realizing such phases is claimed.
Odd remaining speeds have complementary norms across the half-period
pairs of (8), so one can block at most half the orbit when `alpha<=1/4`.
Several odd speeds may block different halves. The already-known exclusion
of exactly one odd speed by lower-count supply and a half shift is not
counted as a new result here.

## All admissible phase orbits and an actual persistent blocker

Discarding the nonmaximal phases would lose valid candidates. Write
`q=2B_0 l mod h` in `0,...,h-1` and `k_l=D T_l`. Directly from (5),

    2h k_l=Q_0(ch+2l)+h-2q,
    lambda(q)=1/2-r*|h-2q|/(2h).                          (12)

Since `gcd(2h,Q_0)=1`, choose the best representative `K` with
`2hK=1 mod Q_0`. Formula (12) identifies every phase orbit, up to
reflection, with

    O_a={aK/D+j/(2c): 0<=j<2c},
    a positive odd,          a<=h*(1-2alpha)/r.            (13)

These and only these common-centre maximizing orbits meet the subset
target `alpha`. In fact `1-2alpha<r`, so `a<h<Q_0`; the zero phase
is excluded, and the positive indices in (13) give disjoint orbits.
The representative is multiplied by `a`; the full orbit is then added.
This does not assume multiplication by `a` permutes an orbit when
`gcd(a,2c)>1`. The corresponding subset margin is
`lambda_a=1/2-r*a/(2h)`, with equality at the target permitted.

There is a concrete obstruction to obtaining a universal conclusion from
these centres. If the original tuple contains the retained speed `4g`,
then (9) gives its distance exactly `1/Q_0` throughout the best orbit.
Strict failure says `mu=B_0/Q_0<1/N`, hence `Q_0>N B_0>=N`, so
this nonzero distance is below `alpha`. It blocks every best seed despite
the exclusion (10) of coordinates vanishing throughout that orbit.

This is not automatically forbidden by the old nearest lift. If `A>=3`,
then at `t_*` the speed `4g` has norm `h/Q_0` and normalized odd lift
`2g-sigma`, with folded value `2sigma`. Its old margin is at least `mu`
exactly when `B_0<=h`. In the present case `h>1` and coprimality makes
this `B_0<h`. These are coordinatewise compatibility checks, not a claim
that a full strict minimal failure with this speed exists.

Moreover, `4g C_l` is integral at every common centre. The exact pair
ceiling throughout every `J_l`, using `z` and `4g`, is therefore

    (4g)/[2(z+4g)]=1/(A+2).

If `A>d-1`, this is below `alpha`. Consequently every common-centre
cell, including all of (13) and their displacements inside those cells,
is blocked. The accepted old global ratio bound for this original speed
only gives `A<2(d-1)`. These established constraints do not exclude the
explicit subcase

    original speed 4g present,   d-1<A<2(d-1),   B_0<h.    (14)

This is a conditional obstruction with all original hypotheses retained.
It asserts neither existence of (14) nor a counterexample. Ruling out
this subcase requires additional global minimal-failure information, or
one must use deleted-speed good components outside all the cells `J_l`.

## A sufficient count test and the remaining selection problem

Let `R` denote the original coordinates outside `Z` and `b`, and let
`F` be the positive odd indices in (13). For `i in R` and `a in F` put

    E_i=gcd(v_i,2c),    L_i=2c/E_i,
    theta_(i,a)={L_i v_i aK/D},
    H_(i,a)=ceil(alpha L_i-theta_(i,a))
            +ceil(alpha L_i+theta_(i,a))-1.               (15)

Precisely `E_i H_(i,a)` times in `O_a` are bad for this coordinate,
meaning the strict inequality `||v_i t||<alpha`. To verify the formula,
its phases form one equally spaced `L_i`-point grid, repeated `E_i`
times. Counting integers in the open interval
`(-alpha L_i-theta_(i,a),alpha L_i-theta_(i,a))` gives (15). Its length
is strictly less than `L_i`, so reduction modulo `L_i` introduces no duplicate.
The ceiling formula handles exact boundary equality as good, as required.

Therefore the explicit arithmetic condition

    sum_(i in R) sum_(a in F) E_i H_(i,a) < 2c*|F|          (16)

constructively certifies an original canonical witness among the disjoint
orbits (13). The subset already meets its target; the finite union bound
leaves at least one seed good for all remaining coordinates. Under full
failure the reverse weak inequality is necessary. The single-best-orbit
test `sum_i E_i H_(i,1)<2c` is also sufficient. Condition (16) is
only sufficient, not a restatement equivalent to the original goal, and
no numerical test or finite-domain experiment was run.

The supplied hypotheses have not been shown to force (16), or to force
an uncovered seed when that simple count is inconclusive. In particular,
even coordinates can have nonzero bad phases constant on the orbit,
and several odd coordinates can have conflicting half-period choices.
The positive margin in (7) gives each best seed a protected interval for
`Z` and `b`, of radius `(lambda-alpha)/z` since (1) implies `z>b`.
No argument controlling all remaining coordinates in these intervals was
obtained; the proof does not silently replace them by independent times.

A small exact control shows that lower-count supply for the remaining
coordinates cannot automatically be placed on these seeds. Use
`v=(1,3,4,6,7)` with `t_*=1/5` and `n=(1,1,1,3,3)`. The core
`(1,3,4,7)` has global margin `1/5`: if every distance exceeded `1/5`,
reflection would put `t in [0,1/2]`; speeds one and three force
`t in (1/5,4/15) union (2/5,1/2]`, and speed four reduces this to
`(2/5,9/20)`, where speed seven has distance below `1/5`. Time `1/5`
attains the bound, also on speed six. Thus this is a global closest lift,
with `r=3/5`, zero `z=6`, contact `b=4`, `g=h=3`, `c=1`, and
`D=10`. Its plane is saturated: minors from speeds one with three and
four are `-2,-3`.

All best seeds are `{1/10,2/5,3/5,9/10}`, with subset margin `2/5`.
The remaining tuple `(1,3,7)` is all odd and has its own canonical
`1/4`-witness at `1/2`. None of those four seeds is such a witness:
speed one has norm `1/10` at the first and last, while speed three has
norm `1/5` at the middle pair. This refutes that unconditional seed
selection rule. The original tuple is good at its actual canonical
margin `1/6`; it has neither strict failure nor minimal-failure status.
It does not refute (16), a failure-only supply rule, or unrestricted LRC.

The bounded attempt stops at an explicit global choice obligation:
for `h=1`, or for the explicit case (14), leave all common-centre cells
or exclude the configuration; elsewhere, force an original witness using
the full retained orbit arithmetic or control all remaining coordinates
in a common protected interval. The fixed-phase case is impossible with
a single zero, but that does not settle its remaining orbit blockers.
Neither required global step follows from lower-count witness existence
or (9)--(12). No reverse invariant or smaller failing tuple was constructed.
The unrestricted canonical goal remains unresolved.

## Frozen inputs and actual checks

Root supplied the old numerator restriction, single-zero specialization,
half-period caution, all-phase congruence and the best-orbit `4g` blocker;
the exact seed, orbit, all-cell obstruction and count were checked here.
The complete frozen predecessor and its accepted review were read.
The present report itself has author-manuscript status.

| Input | SHA-256 |
| --- | --- |
| `.codex/config.toml` | `28212a53cf42cdc377df1f7dab040732d657e59d7bb97ee78791256d01d4bb2c` |
| `docs/project-workflow.md` | `2b42a133352b6b53ba2106fc73882733f176e04a0deffbb183b4c16eefd9cd67` |
| `research/workflow-policy.json` | `833c397b61d1ffdb994fb115019f6d60d6c1a62ff85f19cdd2c9f8ac3a979c8b` |
| `scripts/validate_workflow.py` | `250a3ce2a080f5835ac4fd2e4b2803568424c777cda5d421f9fe92efd34d5383` |
| `research/astra-fold-zero-restoration.md` | `70bbf19a595c63f7940c02ae62b815125731131f27aeade818c9a1fa1ab3507a` |
| `research/astra-fold-zero-restoration-review.md` | `559deadd612ca99a4ebc99d8fba104f2e5243ae412785d3572b70633af7ac59e` |

Actual command in `/home/joshua/lonely-runner-formalization`:

    python3 -B scripts/validate_workflow.py

Exit status 0; complete output:

    workflow structural validation passed; it cannot certify mathematical validity.

Mathematical verification was the displayed hand algebra. Administrative
readback binds all six source hashes, checks the owned final newline and
trailing whitespace, and reports the frozen output hash separately. No
mathematical program, numerical search, solver, browser model, external
mathematical source, extra agent, Lean/dependency/cache operation,
Git/shared-state edit or other-file write was used. No owned process remains.
Observed runtime model, effort, elapsed time and usage remain null.
