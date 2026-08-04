---
owner: GPT-5.6 Sol High top-level desktop orchestrator
supervising_authority: /root
launch_runtime: original browser-capable desktop Codex session
role: Research Pipeline Medium Lead - self-contained reserved synthesis contract only
task_id: PIPE-P83-SELF-CONTAINED-SYNTHESIS-CONTRACT-217
base_commit: 906644f28336d259b38e89c2ef00581bc3066a54
admission: LAUNCH-READY
---

# Prompt 83: SELF-CONTAINED ADVERSARIAL SYNTHESIS OF PROMPTS 76--80

This is the corrected reserved-cell synthesis turn after Prompt81 returned
`INPUT-NOT-FROZEN`. Every mathematical input needed for this turn is written
below. Do not access or request GitHub, commits, local paths, attachments,
browser state, prior chats, or external files. Do not return an immutable-input
readback. The hashes in this prompt are provenance notes only, not resources
you must retrieve.

This is not a new unrelated proof route. Compare the stopped or rejected
unrestricted bridges from Prompts 76--80 and select at most one genuinely
surviving declaration-level lemma closest to unrestricted Lonely Runner, or
conclude that none honestly narrows the open edge. A rigorous `STOP` is a
successful outcome.

Only GPT-5.6 Sol High under `/root`, using the original signed-in
browser-capable desktop session, may launch this prompt in a genuinely new
ChatGPT conversation with GPT-5.6 Sol and Pro effort. Sol Medium prepared the
contract. Luna must not perform this synthesis. Prompt preparation or launch
creates no proof, computation, counterexample, evidence promotion, or status
change.

## Self-contained provenance and evidence boundary

The Prompt76--78 facts below come from independently audited tracked
manuscript proofs and may be used at the exact `proved-math-qualified` scopes
stated here. The Prompt79 and Prompt80 facts come from immutable raw response
captures with decoded-byte SHA-256 values

```text
Prompt79: 392edbd90667e06bf48867274ae8bd745f7ad6c761d4d4c63c74f679622c118b
Prompt80: 9acde390ad319a0007c0b8a8a9b50b7800b3e4ed071953d21f678a1bb8f5fd5a
```

Those two responses have not yet received independent recovery and
mathematical audits. Treat their mathematical arguments as
`external-unformalized response claims` until you rederive them inside this
turn. Treat every response-authored finite scan, first-failure claim, source
hash, output hash, timing, and attachment claim from Prompts 76--80 as
unverified computation. Do not execute or rely on such computation.

Accepted project dependencies, at their existing exact scopes, are:

- `proved-lean`: the standard real LRC is equivalent to the positive-integer
  formulation, preserving positivity, injectivity, all quantifiers, and the
  closed threshold;
- `proved-lean`: positive-integer LRC is equivalent to exact finite pivot
  certificate existence as defined below;
- `proved-lean`: the one- and two-moving-speed cases;
- `proved-lean`: common-gcd normalization and the coefficient-three
  bounded-height theorem; and
- `proved-lean` or previously audited at its named hypotheses: a selected
  deletion certificate satisfying its exceptional-coordinate inequality
  lifts to a full witness.

None of these accepted dependencies proves the unrestricted pivot selector.
Unrestricted LRC remains open.

## Canonical unrestricted bottleneck

For `n>=1`, put `N=n+1`. Let `a : Fin n -> Nat` be positive and injective.
For pivot `j`, write

```text
p_j = a_j,
M_j = N*p_j,
rho_M(x) = min(x mod M, M-(x mod M)),
R_j = {r in {0,...,M_j-1} : N does not divide r},
B_i^j = {r in R_j : rho_(M_j)(r*a_i) < p_j}  for i != j,
mu_j(r) = #{i != j : r in B_i^j},
Q_j = {r in R_j : mu_j(r)=0},
G_j = |Q_j|.
```

Badness is strict `<p_j`; equality is safe. Retain both cyclic sides,
excluded `N`-multiples, nonunits, gcd degeneracies, coincident modular sets,
reflection fixed points, and owner labels.

The exact kernel-checked bottleneck is

```text
for every positive injective a, there exist j and r in Q_j.
```

Such `(j,r)` gives time `t=r/(N*a_j)` and closed circle distance at least
`1/N` for every speed. Conversely every positive-integer witness yields such
a pivot certificate. Therefore merely asserting that not all pivot grids are
covered is LRC-equivalent, not a narrowing.

## Prompt76: false global private-deficit Hall bridge

For a covered pivot, a complete owner set `C` satisfies

```text
C subset {i : i != j},
union_(i in C) B_i^j = R_j.
```

Order complete covers by `(cardinality, increasing speed list)` and call the
least cover `C_j`. Define relative owner-labelled privacy

```text
Priv(j,i) = B_i^j \ union_(h in C_j, h != i) B_h^j.
```

An omitted owner may still cover a point in `Priv(j,i)`. Put

```text
F(a) = {j : G_j=0},
PrivateDemand(a) = sum_(j in F(a)) sum_(i in C_j) |Priv(j,i)|,
w(j,k) = a_k/gcd(a_j,a_k),
ExternalCapacity(a)
  = sum_(j in F(a)) sum_(k notin F(a)) w(j,k)*G_k.
```

The rejected bridge was

```text
GLOBAL-CANONICAL-PRIVATE-DEFICIT-HALL:
if F(a) is nonempty, then PrivateDemand(a) <= ExternalCapacity(a).
```

The independently audited counterexample is

```text
a=(1,4,5,6,7,11), n=6, N=7,
G=(0,0,0,2,2,0), F(a)={1,4,5,11},
PrivateDemand=100, ExternalCapacity=98.
```

The canonical covered-pivot rows are:

```text
pivot 1:  owners {7},          private sizes 6,             demand 6
pivot 4:  owners {1,5,6,7,11}, private sizes 6,4,2,6,4,     demand 22
pivot 5:  owners {1,4,6,7,11}, private sizes 4,4,4,6,4,     demand 22
pivot 11: owners {1,4,5,6,7},  private sizes 12,8,10,10,10, demand 50
```

The uncovered sets are `Q_6={13,29}` and `Q_7={15,34}`. Capacity rows are
`26,20,26,26`, retaining the nonunit weight
`w(4,6)=6/gcd(4,6)=3`. At pivot `6`, numerator `13` has cyclic distances
`(13,10,19,6,7,17)` modulo `42`, all at least `6`. Thus this is not an LRC
counterexample.

Surviving unrestricted local facts, all elementary:

1. the complete-cover family at a covered pivot is finite and nonempty;
2. injective speeds make the stated key strict, so the canonical cover is
   unique;
3. least cardinality implies inclusion-minimality;
4. inclusion-minimality gives every selected owner a nonempty relative
   private set; and
5. the two finite reindexings of `ExternalCapacity` agree.

These facts define the two counts but compare neither. Any transport or
uncrossing that implies `100<=98` is rejected.

## Prompt77: false primitive six-mode signed-Gram gap

For `n=3`, `N=4`, pivot `j`, candidate set `R_j`, and strict bad sets as
above, define

```text
w_j(r)=1-#{i != j : r in B_i^j}
```

and, for literal modes `m,l in {0,...,5}`,

```text
K_j[m,l]
  = (1/M_j) * sum_(r in R_j)
      w_j(r)*exp(2*pi*i*(l-m)*r/M_j).
```

The rejected bridge asserted a positive signed-energy gap at some pivot for
every primitive tuple. The independently audited infinite counterfamily is

```text
a=(u,v,4*u*v), 6<=u<v, gcd(u,v)=1.
```

It is positive, injective, and primitive because
`gcd(u,v,4uv)=gcd(u,v)=1`. At pivot `u`, speed `4uv` covers every candidate,
so

```text
K_1=-(1/(4u))*V(B_v)^*V(B_v) <= 0.
```

Similarly `K_2<=0`. At pivot `4uv`, `R_3`, `B_u^3`, and `B_v^3` have
repetition counts `4uv`, `u`, and `v`, all greater than the largest retained
nonzero frequency `5`; all nonzero literal coefficients vanish. Their zero
frequency signed count is `12uv-6uv-6uv=0`, hence `K_3=0` exactly.

The first family member is `(6,7,168)`. Its exact good-count vector is
`G=(0,0,126)`. At pivot `168`, numerator `29` gives cyclic distances
`(174,203,168)` modulo `672`; equality for the pivot is safe. It is therefore
not an LRC counterexample.

Surviving unrestricted local facts:

1. **Balanced overlap for this family.** At the third pivot,

   ```text
   |Q_3| = |R_3|-|B_u^3|-|B_v^3|+|B_u^3 intersect B_v^3|
         = |B_u^3 intersect B_v^3| >= 1,
   ```

   since numerator `1` belongs to both bad sets.
2. **Periodic annihilation.** If a signed support in modulus `M` is periodic
   with repetition count exceeding the largest retained nonzero literal
   frequency and its total signed weight is zero, its literal truncated Gram
   block vanishes.

The first lemma certifies only this explicit family. The second explains a
spectral obstruction and is not a positive pivot-selection theorem.

## Prompt78: false sparse minimal-cover owner escape

For any labelled complete cover `C`, define

```text
Priv(j,C,i) = B_i^j \ union_(h in C, h != i) B_h^j.
```

The rejected theorem required every qualifying sparse inclusion-minimal cover
to contain an owner `i` whose own pivot has `Q_i` nonempty; its canonical-cover
restriction made the same claim for the least cover.

The independently audited counterexample is

```text
a=(6,7,12,24,144), n=5, N=6.
```

At pivot `7`, modulo `42`, owner bad classes modulo `7` are

```text
speed 6:   {0,1,6}
speed 12:  {0,3,4}
speed 24:  {0,2,5}
speed 144: {0,2,5}.
```

The complete covers are exactly `{6,12,24}`, `{6,12,144}`, and
`{6,12,24,144}`. The first two alone are inclusion-minimal, and the unique
canonical cover is `C={6,12,24}`. Its three owner-labelled private sets each
have size `10`. Nevertheless

```text
36=6*6 divides 144,
72=6*12 divides 144,
144=6*24 divides 144,
```

so the omitted speed `144` covers every candidate at each owner pivot and
`Q_6=Q_12=Q_24=empty`. The exact good-count vector is
`G=(0,0,0,0,160)`. At pivot `144`, numerator `25` gives cyclic distances
`(150,175,300,264,144)` modulo `864`, so the tuple is not an LRC
counterexample.

Surviving unrestricted local facts:

1. a finite labelled cover is inclusion-minimal iff every relative
   owner-labelled private set is nonempty;
2. the frozen least complete cover exists uniquely for injective speeds and
   least cardinality implies inclusion-minimality; and
3. **Divisible singleton blocker:** if `N*p` divides a nonpivot speed `c`,
   then `B_c^p=R_p` and `Q_p=empty`. More generally, if one omitted `c`
   satisfies `N*a_i | c` for every owner `i` in a proposed escape cover, none
   of those owners can be the escaping pivot.

The blocker is a necessary obstruction to owner-escape strategies, not a
positive LRC bridge.

## Prompt79: obstruction extraction stopped before prime-independent data

These are response-authored claims that you must rederive before accepting.
Let `n>=3`, `N=n+1`, `p` prime, and `M=N*p`. `PrimeForcing(n,p)` means every
possibly repeated residue tuple `v : Fin n -> {0,...,M-1}` satisfying

```text
p does not divide v_i                         for every i,
gcd(M,{v_i : i != k})=1                      for every k
```

has `0<=r<M` with `rho_M(r*v_i)>=p` for every `i`. Define `BadPrime(n,p)` as
prime `p` for which this fails. A failure's strict sets

```text
B_i(v)={r mod M : rho_M(r*v_i)<p}
```

cover all residues. Select a canonical inclusion-minimal subcover by least
cardinality and then owner indices.

The attempted obstruction theorem asked, for every `n>=3`, for `H_n>=1` and
a finite `Sigma_n`, fixed before `p` and `v`, such that every bad-prime
failure realizes data

```text
sigma=(m,c,z,Delta),
1<=m<=n,
c_s in {0,...,N-1},
z_s in Int with |z_s|<=H_n,
Delta in Int with Delta != 0,
p divides Delta.
```

Realization permits the canonical selected owners, one common unit modulo
`N*p`, and independent signs, with normalized congruences `c_s mod N` and
`z_s mod p`. `Sigma_n`, `H_n`, and every nonzero `Delta` must be independent
of the prime and failure tuple.

The response gives these exact local arguments. Every complete cover contains
an `N`-divisible owner by evaluation at `r=p`. Every bad prime satisfies
`p>N`, because `r=N` proves prime forcing for `p<=N`. CRT then normalizes one
selected `N`-divisible owner exactly to `N`.

For least private residues `r_s` and normalized selected values `x_t`, choose
centered lifts

```text
r_s*x_t = N*p*q_st+h_st,   -N*p/2 < h_st <= N*p/2.
```

Privacy gives `|h_ss|<p` and `|h_st|>=p` for `s!=t`. Modulo both `N` and `p`,
the matrix `H=(h_st)` has rank at most one. Thus, for `s!=t`,

```text
D_st=h_ss*h_tt-h_st*h_ts
```

is divisible by `N*p` and is nonzero because the diagonal product has
absolute value `<p^2` while the cross product has absolute value `>=p^2`.
Therefore `Theta_st=D_st/N` is a nonzero integer divisible by `p`.

Fatal defect: `Theta_st`, the private residues, and the centered lifts depend
on `p` and the failure tuple and have bounds proportional to `N*p`. This is a
prime-dependent determinant, not a finite obstruction.

The first exact fixtures are:

```text
(n,p,v)=(3,5,(1,3,4)), N=4,
H=[[2,6,8],[7,1,8],[5,-5,0]], det(H)=0,
first cross-minor=-40, Theta=-10, 5 divides Theta,
bounded relation -2*1-1*2+1*4=0;

(n,p,v)=(4,7,(1,3,4,5)), N=5,
H=[[3,9,12,15],[11,-2,9,-15],[9,-8,1,10],[7,-14,-7,0]],
det(H)=0,
first cross-minor=-105, Theta=-21, 7 divides Theta,
bounded relation -1+3+3-5=0.
```

Thus both the full determinant and bounded exact annihilator give zero on the
first fixtures; the universally nonzero minors remain prime-dependent. The
response returns `STOP`: no finite `p`-independent obstruction set is proved
or refuted.

One conditional arithmetic lemma survives if a fixed integer `D>0` containing
all bad-prime divisors is already supplied. Starting with `R_0=1`, let
`E_j=D*R_j+1`, choose the least prime divisor `q_j` of `E_j`, and put
`R_(j+1)=R_j*q_j`. Then `gcd(D,E_j)=1`, the `q_j` are distinct and avoid `D`,
and a finite prefix crosses any fixed product threshold. This extraction is
elementary but does not construct `D`.

## Prompt80: deletion-block existence rejected; local lifting survives

These are response-authored claims that you must rederive before accepting.
For a positive injective `n`-tuple `a`, put `N=n+1`. For deletion `k`, pivot
`j!=k`, and `0<=r<n*a_j`, define `DelCert(a;k,j,r)` by

```text
n does not divide r,
rho_(n*a_j)(r*a_i)>=a_j for every i!=k,
```

including the pivot coordinate. Order certificates lexicographically by
`(a_j,j,r)` and take the least `(j_k,r_k)`. Its lift is safe when

```text
N*rho_(n*a_(j_k))(r_k*a_k) >= n*a_(j_k).
```

Canonical failure is the strict reverse inequality.

For nonempty proper exceptional `S`, let `T=Fin n \ S` and

```text
d=gcd(a_i : i in T),
g_k=gcd(d,a_k),
q_k=d/g_k,
cap_N(d,a_k)=g_k*ceil(2*q_k/N).
```

A strict divisor block satisfies

```text
sum_(k in S) cap_N(d,a_k) < d.
```

Equality is not enough. Repeated orbit phases count with multiplicity `g_k`.
The rejected bridge asserted that primitive hard canonical-failure data always
contains such a block.

Exact response-authored counterexample:

```text
a=(1,3,16), n=3, N=4.
```

Its canonical centered exceptional equations are

```text
delete 1:  2*1  = 0*9+2,   4*2<9;
delete 3:  1*3  = 1*3+0,   4*0<3;
delete 16: 4*16 = 7*9+1,   4*1<9.
```

Every deletion certificate set is nonempty and every canonical lift fails.
Yet no nonempty proper `S` is a strict divisor block. For singleton `S`, the
two survivors have gcd `d=1`, and the capacity is `1=d`. For two-element
`S`, the singleton survivor has speed `d in {1,3,16}`; both exceptions are
coprime to `d`, so the capacity sum is
`2*ceil(d/2)>=d` (equality at `d=16`). The tuple is not an LRC counterexample:
`t=5/11` gives distances `5/11,4/11,3/11`, all above `1/4`.

The response further claims the exact infinite counterfamily

```text
(1,3,L), L>5, 4 divides L, L mod 36 in {4,16,20,32},
```

with hard canonical failures and no strict divisor block. This family and all
finite scans remain unaccepted until independently proved or replayed.

The surviving local theorem is:

```text
DIVISOR-BLOCK-WITNESS-LIFT:
Let S be a strict divisor block, T its nonempty complement, and
d=gcd(a_i : i in T). Write a_i=d*b_i for i in T. If some real t satisfies
circleDist(t*b_i)>=1/(|T|+1) for every i in T, then for some h in {0,...,d-1},
tau=(t+h)/d satisfies circleDist(tau*a_i)>=1/N for every i in Fin n.
```

Proof data: survivor phases are independent of `h`. For exceptional `k`, the
`d` shifts have `q_k` distinct phases, each repeated `g_k` times. The open bad
arc of length `2/N` contains at most `ceil(2*q_k/N)` of the distinct phases,
including the integral endpoint case because the arc is open. Coordinate `k`
therefore excludes at most `cap_N(d,a_k)` shifts. The strict capacity sum
leaves a shift, while `1/(|T|+1)>=1/N` protects survivors. This proves only the
lifting implication; the required block-existence theorem is false.

## Exact synthesis question

Create a dependency map of every surviving local lemma above. Then decide:

```text
Is there one exact, unrestricted, declaration-level lemma from the surviving
Prompt76--80 material that (i) is not already a trivial finite-set fact,
(ii) is not false on a supplied counterexample, (iii) is not merely
conditional on the rejected/open bridge it was meant to replace, and
(iv) removes or strictly narrows one named edge on the route to the exact
unrestricted pivot certificate?
```

Rank by distance to unrestricted LRC first, probability of closing a genuine
edge second, formalizability third, and independent publishability fourth.
Do not select a lemma merely because it is easy to formalize.

There is at most one positive selection. State it with complete quantifiers,
domains, strict/closed boundary rules, and conclusion. Identify its evidence
scope now and the exact stronger status it could receive only after audit or
Lean formalization. If the best surviving fact is only reusable infrastructure
and leaves the same existential premise, say so explicitly. If no fact
strictly narrows an unrestricted edge, return `STOP` and select no
implementation candidate.

## Mandatory dependency, equivalence, and tautology audit

For each serious candidate, give an explicit chain

```text
candidate local lemma
  -> next named arithmetic or selection edge
  -> exact pivot certificate existence
  -> positive-integer LRC
  -> accepted real/integer equivalence
  -> unrestricted real LRC.
```

Mark every arrow `proved-lean`, independently reproved here,
`external-unformalized`, `conditional`, `rejected`, or `open`. Name the first
open arrow. A candidate materially narrows the path only if the new first open
arrow is strictly more specific than the old one and is not just the same
existential statement renamed.

Also unfold and reject as tautological or circular any proposal that:

- concludes only `exists j, Q_j nonempty` without a stronger checkable premise;
- assumes the tuple is not an LRC counterexample or invokes the pivot
  equivalence backward;
- defines a private token as globally safe though privacy is cover-relative;
- defines `Delta` from `p`, the failure tuple, all bad primes, or an unbounded
  centered lift;
- assumes the strict divisor block whose universal existence was refuted;
- treats common gcd one as pairwise coprimality;
- replaces strict badness with weak badness or declares equality bad;
- changes owner-labelled sets into an unlabelled family when multiplicity
  matters;
- turns a response-authored scan into a uniform theorem; or
- weakens a target silently after its counterexample.

Compare whether any two routes secretly require the same missing selection
lemma. In particular test whether "exclude the divisible blocker", "bound the
projective residues", "find a strict divisor block", or "transport all
private demand" simply repackages simultaneous noncoverage.

## Mandatory falsification suite

Use exact hand derivations or transparent pseudocode only. Do not execute or
request recovered attachments.

1. Recheck Prompt76 on `(1,4,5,6,7,11)`: `100>98`, row `22>20`, and pivot-6
   certificate `r=13`.
2. Recheck the Prompt77 family proof (`K_1<=0`, `K_2<=0`, `K_3=0`) and first
   member `(6,7,168)`, where the first two blocks are strictly negative,
   including `G=(0,0,126)` and certificate `r=29`.
3. Recheck Prompt78 on `(6,7,12,24,144)`, including the exact three-owner
   canonical cover, divisible singleton blocker, empty owner good sets,
   `G_144=160`, and certificate `r=25`.
4. Recheck Prompt79's two matrices: both full determinants and bounded
   annihilator values are zero, while the displayed cross-minors are nonzero
   and divisible by `N*p` but depend on `p`.
5. Recheck Prompt80 `(1,3,16)`: all canonical failures, all six proper
   exceptional sets, strict-versus-equality capacity, and witness `t=5/11`.
6. Test any proposed cross-route lemma against all five counterexample
   families or fixtures, not only the route from which it originated.
7. Include boundary controls `rho=p-1` and `rho=p`, a nonunit owner, coincident
   labelled bad sets, repeated residues where the domain permits them,
   common scaling, and permutation/canonical-order behavior.

If you introduce a new finite calculation, give complete pseudocode, exact
domain and deterministic order, malformed-input behavior, first failure, and
the calculation's finite evidence label. A finite calculation cannot promote
the selected lemma.

## Required response format

Return exactly these sections.

1. **Disposition** -- `SELECT-ONE`, `MIXED`, or `STOP`.
2. **Evidence-scope audit** -- separate accepted Prompt76--78 facts,
   independently rederived Prompt79--80 mathematics, unverified computations,
   and open claims.
3. **Counterexample verification** -- premise/conclusion tables for all five
   supplied routes, with strict-boundary checks.
4. **Dependency map** -- every surviving local lemma, its dependencies,
   consumers, and first open downstream arrow.
5. **Equivalence and tautology audit** -- exact unfoldings, shared missing
   lemmas, circularities, and whether any candidate is LRC-equivalent.
6. **Ranked survivor table** -- distance to unrestricted LRC, probability,
   formalizability, falsification status, and disposition.
7. **Exact surviving lemma or no-selection certificate** -- at most one exact
   theorem statement, or a proof that none materially narrows the path.
8. **Complete implication chain** -- every arrow and evidence label through
   unrestricted real LRC, with the single first open arrow highlighted.
9. **Falsification suite** -- supplied fixtures plus any new minimal tests.
10. **Implementation candidate** -- zero or one. If one, give one frozen Lean
    declaration signature or one frozen deterministic verifier definition,
    imports/dependencies, and exact acceptance obligations. Do not implement.
11. **Proof-obligation ledger** -- statement, evidence, dependency, first open
    arrow, stop condition, and recommended owner.
12. **Final evidence boundary** -- `proved-lean`, `proved-math-qualified`,
    response-authored/rederived, computed finite evidence, conditional,
    rejected, and open.

`SELECT-ONE` does not mean the lemma proves LRC. It means exactly one surviving
lemma strictly narrows a named unrestricted edge and survives the full audit.
`MIXED` may preserve useful infrastructure while declining implementation.
Return `STOP` if every survivor is elementary bookkeeping, route-specific
obstruction, conditional infrastructure with the same missing premise, false,
or LRC-equivalent.

## One-turn budget and stop rules

Use one Sol Pro turn. Spend the first quarter on exact counterexample and
evidence-scope verification, the second on the dependency map, the third on
cross-route falsification and tautology audit, and the last on ranking,
declaration statement, implication chain, and ledger.

Stop a candidate immediately at the first false boundary, tuple/modulus
mismatch, owner-label loss, prime-dependent obstruction, zero determinant,
capacity equality, hidden full-witness assumption, unverified computational
dependency, or unchanged LRC-equivalent existential. Do not repair a rejected
bridge, start another broad route, enlarge a finite scan, launch another
agent, edit a repository, or claim unrestricted LRC.
