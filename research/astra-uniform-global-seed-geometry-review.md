# Independent review of global protected-seed geometry

Date: 2026-09-06. Registered task `/root/uniform_global_seed_geometry_review`,
executed by `/root/uniform_screen_review`; requested Astra/xhigh. Runtime
model, effort and usage are not independently exposed. Root supplied source
checkpoint `9004e69f7afe90ea5ba60509938aae2e88d60b6a`.

**Accepted at manuscript scope.** The global identity, its component and
wasted-shell estimates, the stronger endpoint charge, the measure-zero
lemma, and the explicit prime family are valid. No mathematical correction
to the frozen author report is required. The distinction between exact and
almost-everywhere disjointness is essential and is correctly retained.
Neither Q nor unrestricted LRC is resolved.

The entire author report was read. Its hash and all four source bindings
were compared with actual file bytes and matched:

```text
3a4a825f3f801282eb39b469571bbd4cac3a4e1f768d58542b7c1555cd725524  research/astra-uniform-global-seed-geometry.md
b2b6acd00dae3c8ed777bc3da4227fab0254016eec035c2c100f8d346a398f1b  research/astra-uniform-all-deletion-seed-screen.md
b52f92b8dca3de5b0ba9f41c24c2dc6bd83a27329a035d40a1273a0401f215ea  research/astra-uniform-seed-coupling.md
537c008719aa858c9d97ab46acb5b5cd197b873a78d0266aeae6c05950c7c0bb  research/astra-uniform-seed-coupling-review.md
0ba5e0aaeedd556eecf24eb2986123e6a81369291d3547e48c42d709e2e5595a  research/astra-tight-seed-grid-explanation.md
```

The relevant definitions and geometric proofs in those inputs were inspected.
The reviewer did not author the present mathematical report. Its attribution
of the measure-zero suggestion to root is explicit and appropriate.

**Components and endpoints.** Retain `n=N-1>=3`, `delta=1/N`, `gamma=1/n`,
and `eta=gamma-delta=1/(nN)`. All complements are nonempty and have positive
integer speeds. Their weak and strong sets are finite unions of closed
intervals and points, with neighborhoods of both 0 and 1 excluded. Thus
counting components on `[0,1)` loses no component through a periodic cut.

Within one weak component `[L,R]`, each retained coordinate has a fixed
integer phase band. Imposing gamma in these same bands is one interval
intersection, possibly empty or a singleton. This proves at most one strong
component per weak component. A nonempty strong component is strictly inside
its weak component because gamma exceeds delta. Distinct weak components
are separated; protected intervals from different strong components of one
deletion cannot meet.

For a seed `s`, the exact radius is `min(s-L,R-s)`. The ball endpoints are
`max(L,2s-R)` and `min(R,2s-L)`, both continuous and nondecreasing. The union
over `[l,r]` is therefore exactly
`[max(L,2l-R),min(R,2r-L)]`. Since `rho>=eta/M_p>0`, it contains
`[l-eta/M_p,r+eta/M_p]`, including when `l=r`. The claimed increase in length
is at least `2eta/M_p` per component; no singleton is discarded.

**Global identity under Q failure.** A pivot's maximum norm on its protected
ball is `min(1/2,||v_p s||+v_p rho_p(s))`. Since `delta<1/2`, Q failure is
equivalent to each such ball, and hence each protected component, being
strictly bad for its own pivot. This gives exact disjointness of different
`B_p` and `B subset U_delta`. There is no full gamma witness; otherwise Q
would hold immediately. Thus the exactly disjoint `S_p` partition `U_gamma`,
and their strictly delta-bad pivots give
`U_gamma subset B subset U_delta`.

Each coordinate shell `delta<=||v_i t||<gamma` has length `2eta` in a unit
period: each of its `v_i` full periods contributes `2eta/v_i`. Therefore
`integral D=2n eta=2/N`. For `J=U_delta\U_gamma`, monotonicity of bad counts
gives `K_gamma>=2` wherever `K_delta=1` and `K_gamma!=1`. Consequently
`D-1_J>=0` pointwise. With `R=integral(D-1_J)`,

```text
E = mu(B)-mu(U_gamma),
mu(J) = E + mu(U_delta\B),
R = 2/N-mu(J),
E + mu(U_delta\B) + R = 2/N.
```

This derives the identity without assuming that the full-good set `H` is
empty. Full witnesses outside `B` are allowed. In particular, neither the
uncovered uniquely bad region nor the surplus shell multiplicity has been
silently removed. Component expansion gives
`2eta sum_p c_p/M_p<=E<=2n eta`.

Let `M>M_2` be the two largest speeds. The proposed interval starts at
`delta/M` and ends at `min(gamma/M,delta/M_2)`. Its positive length is
`epsilon=min(eta/M,delta(1/M_2-1/M))`. Inside it the fastest phase is strictly
between delta and gamma, and all other phases remain below delta. Hence
`K_delta=n-1>=2`, `D=1` and `1_J=0`. Reflection in an integer preserves the
norms and supplies a disjoint interval near 1. This proves `R>=2epsilon`
with the stated strict endpoints, and then
`sum_p c_p/M_p<=n-epsilon/eta<n`.

**Endpoint charge.** A strong component's left endpoint is the maximum of
its retained lower gamma-band endpoints. An owner therefore exists even for
a singleton or a tie. Choose one event `(i,k)`, at `(k+gamma)/v_i` with
`0<=k<v_i`. No event can be used twice: that would put two distinct strong
components at the same point, contradicting either same-deletion component
separation or cross-deletion seed disjointness. Tied owners need no uniqueness
assumption; choosing one still gives this injection.

Its charge `1/M_p` is at most the available event weight `1/v_i`. Summing
all `v_i` events of each speed gives total capacity `n`. At the first rising
event of the largest speed, `gamma/M`, all other speeds are strictly
gamma-bad. Every deletion retains at least one of those other speeds because
`n>=3`, so this event belongs to no seed. Its weight `1/M` is unused. Thus
`sum_p c_p/M_p<=n-1/M`. Since `epsilon/eta<=1/M`, this dominates
the preceding wasted-shell count estimate. The comparison does not collapse
the more detailed identity to the count estimate.

**The measure-zero case.** Assuming only `mu(H)=0`, a full gamma point would
have an open full delta-good neighborhood. Two distinct deletion seeds would
give a full gamma point, so the seed sets remain exactly disjoint. At any
seed, every retained norm is strictly greater than delta. If the pivot norm
were greater than delta, there would be an open full-good interval. If it
equaled delta, its norm could be increased in one direction while all old
norms remain strict: `0<delta<1/2` excludes a cusp maximum or an integer.
This again gives an open full-good interval. Hence the pivot is strictly
delta-bad at every seed, as claimed.

Always `B_p subset W_p`, so `B_p intersect B_q subset H` for distinct pivots.
Under the null-set hypothesis this is disjointness almost everywhere,
not exact disjointness. Similarly `B\U_delta subset H`. These facts are
exactly sufficient for the measure decompositions used above; no set equality
modulo a null set is promoted to literal equality.

For `|t-s|<rho_p(s)`, Lipschitz continuity leaves every retained norm strictly
above delta. If `F_p(s)>delta`, the pivot's exact ball maximum exceeds delta,
and continuity gives such a point in the ball interior, contradicting
`mu(H)=0`. Therefore the valid conclusion is `F_p(s)<=delta`. An interior
point of a protected component also lies in the interior of its weak
component, where every retained band inequality is strict. A full witness
there could again be perturbed to a strict full witness. Full witnesses
inside `B_p` can therefore occur only at protected-component endpoints.
The length identity and both count bounds survive unchanged, while equality
of a score with delta remains possible.

**Prime family.** For `v=(1,...,N-1)`, a full delta-good time gives `N`
distinct circle points `0,t,...,(N-1)t`, with all pairwise distances at least
`1/N`. Their cyclic gaps sum to one and are each at least `1/N`, so all gaps
are equal. This forces precisely the unit times `a/N` modulo one. Conversely
a unit permutes the nonzero grid residues. The characterization holds for
composite `N` as well, and proves that `H` is nonempty and finite.

For prime `N>=5` and deleted speed `p<N-1`, the inverse `a` exists. The speed
`q=N-p>=2` is retained: `q=p` would imply `2p=N`, impossible for an odd prime.
At `t=a/N`, only `p` and `q` have residues `+1` and `-1`. With
`h=1/(N n q)` and `s=t-h`, one has `0<s<1`. The q phase decreases from
`1-1/N` to `1-1/n`, with no wrap, and its norm is gamma. Every other retained
norm is at least `2/N-nh>=3/(2N)>=1/n`. For the omitted pivot `p=n`, the
seed `1/n` works for all retained speeds `1,...,n-1`. Thus every deletion
seed exists at an explicitly supplied actual time. This construction uses
primality and supplies an unbounded family, rather than a sequence of sampled
counts or a lower-count theorem assumed without proof.

For `p=1`, `a=1`, `q=n`, and `h=1/(N n^2)`, the construction gives
`s=delta-h`. Every radius contribution is at least `eta/n=h`, while speed
`n` has norm exactly gamma and attains equality. Therefore
`rho_1(s)=h`, `F_1(s)=s+h=delta`, and the right ball endpoint is the full
witness `1/N`. The deleted norm equals `s` since `0<s<delta<1/2`.
Lemma 2 excludes a score greater than delta, while allowing this successful
closed equality. All hypotheses needed for the claimed limitation of the
aggregate bounds are present in the family.

**Exact remaining obligation.** Under nonemptiness of every `S_p`, Q asks
for some `p,s` with `F_p(s)>=delta`, equivalently `H intersect B` nonempty.
When `mu(H)=0`, this is necessarily protected-endpoint contact. For general
tuples it is still protected-witness supply, and endpoint contact is one
sufficient avenue. Alternatively one needs a new consequence that actually
rules out simultaneous strict trapping. The present identities and displayed
count inequalities alone do not do this: they also hold for the prime
family's equality cases. This does not rule out arguments using additional
equality structure or other information about lengths and components.

**Actual checks and implementation scope.** Config, workflow, policy and
focused current state were read. The required startup command
`python3 -B scripts/validate_workflow.py` reported:

```text
workflow structural validation passed; it cannot certify mathematical validity.
```

The startup shell batch exited 0. The `sha256sum` checks above exited 0.
All mathematical checks in this review were algebraic and are displayed
here; no mathematical program or old/new enumeration was run. No Lean or Git
command, dependency/cache operation, or shared-state mutation was performed.
Only this owned Markdown file was created. These finite-interval and endpoint arguments
are plausible formalization targets; this review supplies no checked Lean
declaration and no missing uniform supply theorem.
