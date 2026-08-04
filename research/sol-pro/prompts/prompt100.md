---
owner: GPT-5.6 Sol High top-level desktop orchestrator
supervising_authority: /root
launch_runtime: original browser-capable desktop Codex session
role: GPT-5.6 Sol / Pro mathematical research agent
task_id: SOL-P100-PRO-TWO-LOWER-OWNER-NONCOVER-319
base_commit: 64d5a6a62df3cdc963aacc809600bd7d9d10a9ed
admission: LAUNCH-READY
review_id: P100-INDEPENDENT-CONTRACT-REVIEW-322
route_classification: P95 supporting contract; not an independent third Pro cell
prompt_encoding: ASCII
prompt_line_endings: LF
prompt_hash_scope: bytes from the line "# Prompt 100:" through EOF
prompt_sha256: f353ac34583d2223276dd08f87acaac6afc996d4507040624c9141cb6386d344
---

# Prompt 100: TWO-LOWER-OWNER-NONCOVER

You are GPT-5.6 Sol running at Pro effort in a genuinely new ChatGPT
conversation. Act as the mathematical research agent. This is the actual
research turn, not a request to review prompt admission, prepare another
contract, or describe a plan. Attack the exact theorem below now.

Use one major turn. Prove the exact unrestricted arithmetic statement at all
frozen quantifiers, give a fully reproducible theorem-domain counterexample,
or isolate one strictly narrower successor lemma with a complete implication
to the target. Fail closed. Do not claim the Lonely Runner Conjecture.

## Evidence discipline

Use only these labels in the response:

- `proved-math`: a complete proof supplied in the response and surviving all
  stated fixtures and objections;
- `computed finite evidence`: a completed, reproducible finite domain only;
- `conditional`: a conclusion whose exact premise remains open;
- `conjectural`: an unsupported proposed lemma or proof step;
- `refuted`: a statement with a checked theorem-domain counterexample;
- `open`: not established or refuted in this turn; and
- `rejected`: invalid reasoning, malformed computation, or an excluded route.

Nothing in this prompt is `proved-lean`. A response-authored program is not an
independent checker. A bounded search is not a proof of the universal target.
Do not silently weaken a quantifier, change strictness, discard a residue, or
replace the theorem after it fails.

## Frozen arithmetic semantics

All variables below are ordinary integers in the displayed finite ranges.
For positive `M`, define

```text
u_M(x) = the unique representative of x modulo M in {0,...,M-1},
rho_M(x) = min(u_M(x), M-u_M(x)).
```

For positive integers `N,p`, put

```text
M = N*p,
R(N,p) = {r in {0,...,M-1} : N does not divide r},
B_d(N,p) = {r in R(N,p) : rho_M(r*d) < p}.
```

Representatives are canonical. Badness is strict. Equality
`rho_M(r*d)=p` is safe. Keep both cyclic sides, zero modular products,
antipodes, nonunit candidates, gcd-degenerate multiplication fibers, and
distinct candidate labels whose products collide. Never cancel a nonunit.
Never merge distinct owners merely because a modular image or bad subset
coincides. Residues divisible by `N`, including zero, are excluded from `R`;
no other residue is excluded. Thus

```text
|R(N,p)| = (N-1)*p.
```

## Sole theorem target

Prove or refute exactly:

```text
TWO-LOWER-OWNER-NONCOVER:

For every integer N>=4, every integer p>=1, and all distinct positive
integers b<c<p,

  B_b(N,p) union B_c(N,p) != R(N,p).

Equivalently, there exists r with

  0 <= r < N*p,
  N does not divide r,
  rho_(N*p)(r*b) >= p,
  rho_(N*p)(r*c) >= p.
```

The ordering `b<c` is only a canonical ordering of the two distinct labelled
owners. It may not be replaced by coprimality, primality, a height bound, a
condition on `p`, or a condition on `gcd(N,p,b,c)`. The cases `p=1,2` are
vacuous because no such pair exists, but remain inside the universal theorem.

First prove the displayed equivalence literally, including the strict/closed
boundary complement. Then attack the theorem.

## Exact consequence for the Prompt95 route

The target is useful only through this finite owner-count bridge. Reprove all
local facts needed for the bridge; do not cite their project labels as proof.

Fix `n>=2`, set `N=n+1`, and let

```text
a : Fin n -> Nat
```

be positive and injective. For pivot label `j`, put `p_j=a_j`, define
`R_j=R(N,p_j)`, and for `i!=j` put

```text
B_i^j = B_(a_i)(N,p_j),
Q_j = R_j \ union_(i!=j) B_i^j,
F(a) = {j : Q_j is empty}.
```

If `F(a)` is nonempty, let `j_star` be its unique maximum-speed label. A
labelled set `C subset Fin n \ {j_star}` is a complete cover at `j_star` if

```text
R_j_star = union_(i in C) B_i^j_star.
```

It is internal if `C subset F(a) \ {j_star}`, and inclusion-minimal if no
proper labelled subset is complete.

Prove this complete chain:

1. `R_j_star` is nonempty.
2. Every internal owner has `0<a_i<a_j_star`, by positivity, injectivity, and
   maximality of `j_star` inside `F(a)`.
3. For `N>=3`, a positive owner `d<p` cannot singleton-cover `R(N,p)`.
   Supply a proof of the needed singleton rigidity or a direct proof; do not
   assume it.
4. If `N>=4`, an internal inclusion-minimal complete cover at `j_star` has at
   least three labelled owners: sizes zero and one fail by steps 1 and 3, and
   size two fails by `TWO-LOWER-OWNER-NONCOVER` after ordering its two distinct
   speeds as `b<c<p`.
5. The remaining theorem-domain case `N=3` means `n=2`. There is at most one
   nonpivot owner, so an internal complete cover is impossible by steps 1 and
   3. This uses owner count; it does not extend the arithmetic target to
   `N=3`.
6. If `|F(a)|<=3`, any internal complete cover can be finitely deleted to an
   internal inclusion-minimal complete cover with at most two owners. Steps 4
   and 5 contradict this. Therefore no internal complete cover exists.
7. Consequently the Prompt95 redundancy statement holds whenever
   `|F(a)|<=3`: for every internal complete `C`, some owner can be deleted
   while retaining completeness. This conclusion is vacuous because step 6
   excludes every such `C`; spell this out rather than claiming a selected
   redundant owner was constructed.

This does not prove Prompt95 for `|F(a)|>=4`, the unrestricted pivot theorem,
integer LRC, the real-to-integer reduction's arithmetic premise, or
unrestricted Lonely Runner. With more than three covered labels, the target
only says an internal minimal cover has at least three owners.

## Why `N>=4` is necessary

The local two-owner theorem is false at `N=3`, even though the `n=2` pivot
application cannot supply two nonpivot owners. Recompute these exact exclusion
controls:

```text
N=3, p=3, b=1, c=2:
R = {1,2,4,5,7,8},
B_1 = {1,2,7,8},
B_2 = {1,4,5,8},
B_1 union B_2 = R.

N=3, p=5, b=2, c=3:
R = {1,2,4,5,7,8,10,11,13,14},
B_2 = {1,2,7,8,13,14},
B_3 = {1,4,5,10,11,14},
B_2 union B_3 = R.
```

These are theorem-boundary controls, not counterexamples to the `N>=4`
target and not speed tuples proving or refuting LRC.

## Mandatory semantic fixtures

Recompute every fixture from the literal definitions before trusting a proof
calculation or verifier. A mismatch is a specification failure.

### `N=4` edge and boundary controls

1. For `(N,p,b,c)=(4,3,1,2)`,

   ```text
   R = {1,2,3,5,6,7,9,10,11},
   B_1 = {1,2,10,11},
   B_2 = {1,5,6,7,11},
   R \ (B_1 union B_2) = {3,9}.
   ```

   At `r=3`, `rho_12(3*1)=3=p`, so equality is safe. The candidate is a
   nonunit and must remain. Reflection gives the second witness `r=9`.

2. For `(N,p,b,c)=(4,4,1,3)`, the uncovered set is exactly `{7,9}`.
   This tests the first nonvacuous even `p` edge.

3. For `(N,p,b,c)=(4,5,2,3)`, the uncovered set is exactly
   `{3,5,15,17}`. Candidates `5` and `15` are retained nonunits.

4. For `(N,p,b,c,r)=(4,6,1,5,6)`, the two owner products have the same
   canonical residue `6` modulo `24`, and both have `rho_24=6=p`. This is a
   labelled cross-owner collision at equality; `r=6` is safe against both.

5. For `(N,p,b,c)=(4,15,5,10)`, obtained by scaling the first edge by five,
   the uncovered set is

   ```text
   {3,9,15,21,27,33,39,45,51,57}.
   ```

   Prove the exact scaling/projection relation before using scaling in an
   argument. Do not simply identify the moduli `12` and `60`.

### Fiber and malformed-input controls

6. At `N=4,p=5,d=2`, candidates `r=1` and `r=11` have the same product
   residue `2` modulo `20` and are both bad. They remain two candidate
   representatives in the same multiplication fiber.
7. Reject as malformed any record with `N<4`, `p<1`, `b<=0`, `c<=0`,
   `b>=c`, or `c>=p`. The valid `N=3` exclusion controls are out of target,
   not malformed arithmetic.
8. A deliberately altered expected uncovered set for `(4,3,1,2)`, such as
   `{3}` instead of `{3,9}`, must make each verifier fail closed.

### Prompt95 route tuples

Using the full labelled pivot definitions above, independently recompute these
controls. They validate only the consequence chain.

1. For `(1,6,11,12,13)`, `N=6`, the covered speeds are `{1,6}` and the
   maximum covered pivot has speed `6`. Its only internal lower owner is speed
   `1`, which does not cover the row.
2. For `(6,7,12,24,144)`, `N=6`, the covered speeds are `{6,7,12,24}` and
   the maximum covered pivot has speed `24`. Each of the internal pairs
   `{6,7}`, `{6,12}`, and `{7,12}` fails to cover its row. The three-owner
   set `{6,7,12}` also fails, but that extra fact is only a fixture and is not
   a consequence of the target.
3. For `(1,4,5,6,7,11)`, `N=7`, the covered speeds are `{1,4,5,11}` and the
   maximum covered pivot has speed `11`. Each internal pair from `{1,4,5}`
   fails. The three-owner set `{1,4,5}` also fails, again only as a fixture.
4. Permute every tuple and preserve owner labels. Compare by speed-labelled
   sets. Then scale every speed by `5` and prove the exact correspondence of
   candidate rows and badness before comparing results.

No displayed finite tuple is evidence for the universal theorem.

## Required mathematical attack

Spend a strict majority of the turn on uniform mathematics. The central job
is to exploit the fact that two lower multipliers must simultaneously leave a
candidate outside two strict neighborhoods of zero.

### Lane A: common-overlap capacity

Derive exact formulas or sharp upper bounds for

```text
|B_b(N,p)|,
|B_c(N,p)|,
|B_b(N,p) intersection B_c(N,p)|,
```

with all gcd-dependent fibers retained. Seek an inequality

```text
|B_b union B_c| < (N-1)*p.
```

An estimate that separately bounds both bad sets but loses their forced
overlap is unlikely to close. If using a lattice count, define the lattice,
fundamental domain, boundary convention, multiplicities, and error terms
exactly. Strict equality points belong outside each bad set.

### Lane B: `t*p` and `t*p +/- 1` slices

For `0<=t<N`, establish the exact identity

```text
rho_(N*p)(t*p*d) = p*rho_N(t*d).
```

Hence, when `N` does not divide `t*p`, the candidate `t*p` is bad for owner
`d` exactly when `N` divides `t*d`. Treat the candidate condition separately;
do not cancel `p`, `t`, or `d` without a unit hypothesis.

Then analyze the neighboring canonical residues `t*p-1` and `t*p+1` when
they lie in the row. Determine whether a fiber/gcd classification forces one
of these slices to be safe against both `b` and `c`. Track wraparound, `r=0`,
`r=N*p`, excluded `N`-multiples, equality, and simultaneous congruences.

### Lane C: gcd fibers or explicit witness

Classify the multiplication maps by

```text
gcd(b,N*p), gcd(c,N*p), gcd(b,c,N*p),
gcd(b,N), gcd(c,N), gcd(p,N).
```

Seek either a uniform explicit witness `r=r(N,p,b,c)` or a finite exhaustive
case partition with a proved witness in every case. Any CRT step must state
compatibility, modulus, representative range, and why the selected residue is
not divisible by `N`. A real-interval or torus argument must recover an
integer canonical residue with both closed safety inequalities.

### Adversarial obligations

Attack every proposed key lemma on:

- `b=1,c=p-1` and adjacent lower owners;
- `N|b`, `N|c`, or both when possible;
- large common gcd with `p`;
- `p` divisible by `N` and `p` coprime to `N`;
- equality-only witnesses;
- nonunit candidates and many-to-one multiplication fibers;
- the `N=4` edge;
- the false `N=3` controls; and
- common scaling of `p,b,c`.

State the first unsupported transition if no lane closes. Do not convert a
numerically observed pattern into a lemma without proof.

## Independent finite falsifiers

Finite work is for fast falsification and proof debugging only. Supply clear
pseudocode for two genuinely separate implementations. Execution is optional
and must not displace the mathematical majority.

### Falsifier A: literal canonical enumeration

Enumerate in this exact order:

```text
N = 4,...,18;
p = 1,...,160;
b = 1,...,p-1;
c = b+1,...,p-1;
r = 0,...,N*p-1.
```

Construct `R`, `B_b`, and `B_c` literally as finite labelled lists. Stop at
the lexicographically first `(N,p,b,c)` whose union equals `R`, or return
`first_failure=null` only after completing the full domain.

### Falsifier B: independent congruence-fiber implementation

Independently build each bad-set bitset by solving multiplication fibers,
without calling Falsifier A's residue loop or set constructor. For owner `d`,
put `g=gcd(d,M)`. Enumerate strict target product residues in the exact order

```text
0,1,...,p-1,M-p+1,M-p+2,...,M-1.
```

For each target `x`, declare `d*r = x (mod M)` soluble exactly when `g|x`.
When soluble, reduce by `g`, invert `d/g` modulo `M/g`, enumerate the `g`
canonical solutions `r=r_0+k*(M/g)` for `k=0,...,g-1`, and retain precisely
those with `N` not dividing `r`. Deduplicate repeated solution visits only
inside the output bitset; never change candidate or owner labels. Prove that
the two strict target intervals are exactly `rho_M(x)<p`, including `x=0`
and excluding equality residues `p` and `M-p`.

Use the exact domain and order

```text
N = 4,...,24;
p = 1,...,240;
b = 1,...,p-1;
c = b+1,...,p-1.
```

For each pair compute the least uncovered canonical residue, if any. Compare
the two implementations on their common domain. An optimization is accepted
only after its equivalence to the literal strict predicate is proved or
checked pointwise over the common domain.

Both implementations must run the mandatory success, false-`N=3`, equality,
collision, nonunit, scaling, malformed-input, and deliberately altered-value
fixtures before a full scan. Freeze domains before execution. Do not enlarge
them after seeing the results.

If executed, attach deterministic source, machine-readable manifest, and
machine-readable result files separately. Record exact source and result
SHA-256 hashes, interpreter/compiler and version, exit status, domain counts,
fixture results, deterministic order, source/result binding, and first
failure. A partial run, stale output, missing attachment, hash mismatch, or
failed fixture is `rejected operational output`, not computed finite evidence.

A theorem-domain counterexample must include at least:

```text
N, p, b, c, M, |R|, |B_b|, |B_c|,
the complete canonical uncovered list,
the complete or hash-bound canonical B_b and B_c lists,
and independent reproduction by both methods.
```

One checked theorem-domain counterexample immediately refutes and stops the
target. Do not search for a weakened replacement in the same outcome.

## Route independence and prohibited substitutions

This cell is the local two-owner edge below Prompt95. It is not Prompt98's
maximum-covered nondivisible-pivot branch and must not assume Prompt98 or any
Prompt99 result. Do not use either as a premise.

Also exclude as premises or renamed solutions:

- whole-block packing or radial descent;
- prime forcing or prime-interval supply;
- unit-stratum, Mobius-deficit, or divisor-selected deficit arguments;
- height compression, bounded coefficients, or finite-height reduction;
- coefficient-two Gamma matching;
- owner-aware multishift unchanged;
- a tautological restatement that two sets fail to cover exactly when an
  uncovered residue exists; or
- the unrestricted pivot certificate or LRC itself.

A proof may use elementary number theory, exact lattice counting, CRT,
Fourier analysis, or additive combinatorics, but every imported result must be
stated precisely with verified hypotheses. If the target is shown equivalent
to an already open unrestricted pivot theorem rather than proved by a
strictly narrower argument, return `STOP`, not `PIVOT`.

## Mutually exclusive final outcomes

End with exactly one outcome.

### `PROVE`

Use only if the response contains a complete proof of
`TWO-LOWER-OWNER-NONCOVER`, survives all adversarial cases, and proves the
entire `|F(a)|<=3` consequence chain at exact quantifiers. Mark each step
`proved-math` or identify any remaining conditional premise; if any central
premise remains open, this outcome is unavailable.

### `STOP`

Use if you give a reproducible theorem-domain counterexample, find a semantic
inconsistency in the frozen target, or show that the proposed route is only a
tautological/equivalent reformulation of an existing open unrestricted edge.
State exactly what is refuted or why the contract cannot advance.

### `SEPARATION`

Use only if the target remains open but you prove one nontrivial uniform lemma
strictly narrower than it. State its exact quantifiers, prove it completely,
show the implication edge it closes, identify exactly one remaining lemma,
and give falsification tests. A restated slice identity, finite observation,
conditional overlap bound, or bounded-height theorem does not qualify.

The outcomes are mutually exclusive. Never write `PROVE` merely because a
finite search found no counterexample.

## Required response structure

Return these sections in order:

1. **Outcome** - exactly `PROVE`, `STOP`, or `SEPARATION`.
2. **Frozen definitions and equivalence** - restate the exact target and
   verify strict/closed complements.
3. **Fixture audit** - recompute every mandatory fixture and report any
   mismatch before using further claims.
4. **Main theorem or refutation** - complete proof, exact counterexample, or
   first unsupported edge.
5. **Common-overlap analysis** - exact counts/bounds and gcd dependencies.
6. **Slice analysis** - `t*p` and `t*p +/- 1`, including candidate status.
7. **Adversarial review** - all listed stress regimes and failed approaches.
8. **Prompt95 consequence** - the seven-step owner-count chain, at its actual
   evidence status.
9. **Finite falsifiers** - pseudocode, frozen domains, and `not-run` unless
   actually executed with complete artifacts.
10. **Proof-obligation ledger** - claim, dependencies, label, falsifier,
    first open edge, and downstream owner.
11. **Declaration-level plan** - only for proved statements surviving audit.
12. **Final evidence table** - separate response proof, finite computation,
    conditional claims, refutations, and open claims.

## One-turn budget and fail-closed rules

Use at most 15 percent of the turn on definitions, equivalence, and fixtures;
at least 35 percent on overlap/fiber mathematics; at least 25 percent on
slice, explicit-witness, and adversarial analysis; and at most 25 percent on
finite methods, the consequence ledger, and final packaging. A strict
majority must address novel uniform mathematics.

Return `STOP` immediately on a fully checked theorem-domain counterexample or
semantic inconsistency. Otherwise do not stop at a plan. Do not use `sorry`,
`admit`, new axioms, `unsafe`, `native_decide`, or an opaque external oracle.
Do not claim `proved-lean`. Do not claim unrestricted LRC. Preserve every open
edge at its exact scope.
