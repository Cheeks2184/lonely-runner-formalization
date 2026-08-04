# Response83 mathematical audit

Audit task: `P83-MATHEMATICAL-AUDIT-243`

Base: `efc6bb80aa4f6b08cb1a8eb00ce2146f6a0426eb`

Audited response: `research/sol-pro/responses/response83.md`, SHA-256
`ea582cc4b47d6c5cb047afb80c5e63f36d66f4b2b3a1b9fdb23c2277525ccb15`.

Frozen contract: `research/sol-pro/prompts/prompt83.md`, SHA-256
`3b794b85ed375d25ce3db696eb84aad93dc45e402a8142decdc2150d862bc62e`.

## Verdict

Response83's **STOP** disposition is correct. No surviving Prompt76--80
lemma meets all four frozen selection criteria, so selecting no declaration
and no implementation candidate follows from the contract rather than from a
bare assertion.

The response correctly preserves these route dispositions:

- the Prompt76 global private-demand inequality is `rejected`;
- the Prompt77 primitive literal six-mode signed-Gram gap is `rejected`;
- the Prompt78 sparse and canonical owner-escape statements are `rejected`;
- the Prompt79 prime-independent finite obstruction remains `open`, and that
  route is stopped rather than refuted;
- the Prompt80 universal strict-divisor-block conclusion is `rejected`;
- exact unrestricted pivot-certificate existence and unrestricted LRC remain
  `open`.

Two presentation qualifications are required, but neither changes the
disposition or any arithmetic conclusion used by the synthesis:

1. Prompt79's displayed fixture matrices use the original owner columns, not
   the independently sign-normalized columns described by the contract. The
   necessary column sign changes preserve zero determinants, absolute privacy
   inequalities, and nonzero divisibility of the cross-minors; one affected
   minor changes sign only.
2. The displayed Prompt80 implication chain places the unrestricted
   strict-block-and-survivor selector after `DIVISOR-BLOCK-WITNESS-LIFT`.
   Dependency runs the other way: the selector supplies the lift hypotheses,
   and the orbit bound proves the lift. The response's dependency map and
   first-open-arrow discussion use the correct dependency, so this ordering
   defect does not support a false conclusion.

No response-authored program, attachment, output, manifest, or scan was run,
imported, or used in this audit.

## Evidence reconciliation

The exact base already contains independent mathematical audits for Responses
76--80. Response83 was written before the Prompt79 and Prompt80 audits were
integrated, so its conservative label `response-authored/rederived` is not an
overclaim. At the present base the recommended labels can be sharpened as
follows.

| Material | Current audited scope | This audit's conclusion |
| --- | --- | --- |
| Prompt76 tuple, covers, private demand `100`, capacity `98`, and certificate | Integrated independent audit | `proved-math-qualified` at the displayed scope; global inequality `rejected` |
| Prompt77 family block signs, first-member counts, and certificate | Integrated independent audit with symbolic family proof | `proved-math-qualified`; literal six-mode gap `rejected` |
| Prompt78 cover, private sets, blocker, good counts, and certificate | Integrated independent audit | `proved-math-qualified`; sparse and canonical escape `rejected` |
| Prompt79 local cover, normalization, CRT, cross-minor, fixtures, and conditional extraction | Integrated independent audit | `proved-math-qualified` at exact stated scopes; finite prime-independent obstruction `open` |
| Prompt80 tuple, all deletion rows, all six capacity rows, witness lift, and local fixtures | Integrated independent audit | `proved-math-qualified`; universal strict-block theorem `rejected` |
| Prompt80 infinite family `(1,3,L)` | Left unverified by the earlier Prompt80 audit | Independently proved below; recommend `proved-math-qualified` |
| Response-authored bounded scans, mutation counts, first-failure ordering, dual runs, sources, outputs, manifests, hashes, and timings | Not independently replayed | `unverified`; unused |
| Accepted Lean equivalences and named small cases | Project dependency, not replayed here | retain exact existing `proved-lean` scope |
| Exact unrestricted pivot selector and unrestricted LRC | No proof supplied | `open` |

The audit documents used for comparison have SHA-256 values:

| Audit | SHA-256 |
| --- | --- |
| Response76 | `87013715fa8e3c4c7729a6b723ee215ab22d8f6a81f7eb34be08141b89d818da` |
| Response77 | `bdbd4fbdc15920f4f966016e713fdd68b1ff8ef5ad50c41c748581822a84fc84` |
| Response78 | `16ba2b8b617dcbc50b97a2c3c029ac67485daeace11d6bae7be13e765052b78a` |
| Response79 | `cdd53b3518f98e5129a0d9e32f347e2b5eb20118b2407730d1bd304259c60449` |
| Response80 | `43bf7af3ac4a2cade46b310d1ccbf79a94f609f7fd718c93af6a601b141c767d` |

## Route claim table and exact counterchecks

| Route | Response83 claim | Independent countercheck | Disposition |
| --- | --- | --- | --- |
| 76 | `(1,4,5,6,7,11)` has `PrivateDemand=100>98=ExternalCapacity`, with row failure `22>20` at pivot `4` | Exact integrated table has `G=(0,0,0,2,2,0)`, canonical row demands `6,22,22,50`, capacities `26,20,26,26`, and pivot-6 certificate `r=13` | Claim matches; global bridge `rejected` |
| 77 | Every `(u,v,4uv)`, `6<=u<v`, `gcd(u,v)=1`, has `K_1,K_2<=0`, `K_3=0`; first member has `G=(0,0,126)` and certificate `r=29` | Symbolic periodicity and exact first-member arithmetic match the integrated audit | Claim matches; literal six-mode gap `rejected` |
| 78 | `(6,7,12,24,144)` has canonical cover `{6,12,24}`, each selected owner pivot blocked by `144`, `G_144=160`, certificate `r=25` | Cover classification, labelled coincidence `B_24^7=B_144^7`, inclusion-exclusion, and distances `(150,175,300,264,144)` match | Claim matches; both escape statements `rejected` |
| 79 | Private centered lifts yield nonzero `Np`-divisible cross-minors, but no fixed prime-independent finite obstruction | General proof and both fixtures match after the normalization qualification below | Local lemma survives; uniform obstruction remains `open` |
| 80 | `(1,3,16)` satisfies every hard canonical-failure premise but has no strict divisor block; local lift survives | All three canonical rows, all six exceptional subsets, equality safety, and witness `5/11` match | Universal block existence `rejected`; local lift survives |

### Prompt76--78 boundary checks

The Response83 numbers agree with the integrated exact audits rather than
merely with the raw responses.

- Prompt76 retains the nonunit term
  `6/gcd(4,6)=3`; no modular inverse is used. At pivot `6`, `r=13` gives
  distances `(13,10,19,6,7,17)`, including safe equality at the pivot.
- Prompt77's periodic proof uses full-modulus normalization. At the third
  pivot, `|R|=12uv` and both bad-set sizes are `6uv`, so the zero-frequency
  signed count is zero. Repetition counts `4uv,u,v` exceed every nonzero
  literal difference `1,...,5`, so the retained nonzero Fourier coefficients
  vanish. For `(6,7,168)`, `r=29` gives `(174,203,168)`.
- Prompt78 keeps coincident sets owner-labelled. At pivot `7`, each of the
  three private class pairs contributes `2*5=10` candidates. The omitted
  speed `144` is a full blocker at pivots `6,12,24`. At pivot `144`, `r=25`
  gives safe equality at the pivot coordinate.

These controls support the stated route rejections but do not produce an LRC
counterexample; every displayed tuple has an exact certificate.

## Prompt79 normalization and cross-minor audit

Fix `n>=3`, `N=n+1`, a bad prime `p`, and `M=Np`. The integrated audit and
Response83 correctly establish:

1. `p>N`: if `p<=N`, then `r=N` is safe because
   `rho_(Np)(Nv_i)=N*rho_p(v_i)>=N>=p`.
2. Every complete cover contains an `N`-divisible owner: at `r=p`, strict
   badness is exactly `N|v_i`.
3. Since `p>N`, `gcd(N,p)=1`; an `N`-divisible selected owner `Nt`, with
   `p` not dividing `t`, can be normalized to `N` by a common CRT unit.
4. A cardinality-minimal labelled cover has at least two owners and gives a
   private residue for each selected owner.
5. For centered lifts
   `r_s*x_t=M*q_st+h_st`, the matrix `H=(h_st)` is rank at most one modulo
   both `N` and `p`. Thus each cross-minor is divisible by `Np`.
6. Privacy gives `|h_ss|<p` and `|h_st|>=p` for `s!=t`. Hence
   `D_st=h_ss*h_tt-h_st*h_ts` is nonzero because its two products have
   strictly different absolute-size ranges.

Consequently `Theta_st=D_st/N` is a nonzero integer divisible by `p`. Its
quantifiers remain

```text
for every bad (p,v), there exists Theta(p,v) != 0 with p | Theta(p,v),
```

not the required prime-independent finite-signature quantifiers.

For `(n,p,v)=(3,5,(1,3,4))`, the original-column matrix is

```text
[2,  6, 8]
[7,  1, 8]
[5, -5, 0].
```

Its third column is the sum of its first two, so its determinant is zero. The
first minor is `2*1-6*7=-40`, hence the original-column quotient is `-10`.
The required independent sign normalization negates the second column. It
therefore changes that minor and quotient to `40` and `10`, but preserves
nonzeroness, divisibility by `20` and `5`, and determinant zero. The bounded
normalized relation remains exactly `-2-2+4=0`.

For `(n,p,v)=(4,7,(1,3,4,5))`, the original-column first minor is
`3*(-2)-9*11=-105`, so `Theta=-21`; the required sign change is on the third
column and does not affect this first minor. Fraction-free elimination gives
two equal final rows, hence determinant zero. The normalized bounded relation
is `-1+3+3-5=0`.

Thus Response83 uses no conclusion stronger than the integrated Prompt79
audit. Full determinants and the two displayed bounded annihilators are
rejected as universally nonzero choices. The existence of some finite fixed
prime-independent obstruction is not refuted and remains `open`. Conditional
Euclidean prime extraction is valid only after a fixed nonzero integer `D`
containing every bad-prime divisor has been supplied.

## Prompt80 exact hypotheses, equality safety, and family

For `(1,3,16)`, `n=3`, `N=4`, Response83's canonical deletion rows match the
integrated audit:

| Deleted speed | Canonical pivot and numerator | Exceptional distance | Lift test |
| ---: | --- | ---: | --- |
| `1` | pivot `3`, `r=2`, modulus `9` | `2` | `4*2=8<9` |
| `3` | pivot `1`, `r=1`, modulus `3` | `0` | `4*0=0<3` |
| `16` | pivot `3`, `r=4`, modulus `9` | `1` | `4*1=4<9` |

The pivot coordinate remains among the survivor checks, the deletion modulus
uses `n` rather than `N`, and the lift comparison uses `N`. Every canonical
failure is strict.

All nonempty proper exceptional sets have capacity at least the survivor gcd:

```text
S={1}:    1=d       S={3}:    1=d       S={16}:   1=d
S={1,3}:  8+8=16=d S={1,16}: 2+2=4>3   S={3,16}: 1+1=2>1.
```

Equality is not a strict block and cannot be weakened: the open-arc orbit
bound is only an upper bound, and a union of capacity `d` may exclude all
`d` shifts. The independent witness `t=5/11` has distances
`5/11,4/11,3/11`, all above `1/4`, so this rejects only the structural lemma.

The local lift has the exact surviving scope stated in Response83 and the
integrated audit. For a nonempty proper strict block `S`, nonempty complement
`T`, survivor gcd `d`, and a witness for the divided survivor tuple at
threshold `1/(|T|+1)`, each exceptional coordinate excludes at most

```text
gcd(d,a_k) * ceil(2*(d/gcd(d,a_k))/N)
```

of the `d` shifts. The bad arc is open, so the ceiling remains correct when
`2q/N` is integral and equality at distance `1/N` is safe. Strict total
capacity below `d` leaves a shift. Survivor phases are shift-independent, and
`|T|<=n-1` gives `1/(|T|+1)>=1/n>1/(n+1)=1/N`.

### Infinite family

Response83's additional family claim is independently valid. Let

```text
a=(1,3,L),  L>5,  4|L,  L mod 36 in {4,16,20,32}.
```

Then `L mod 9` is respectively `4,7,2,5`, and `3` does not divide `L`.

- After deleting `1`, pivot `1` is impossible because survivor speed `3` is
  zero modulo `3`. At pivot `3`, the canonical numerator is `1` for residues
  `L mod 9` equal to `4` or `5`, and `2` for residues `7` or `2`. The deleted
  coordinate's centered residue is `1` or `2`, so `4|h|<9`.
- After deleting `3`, pivot `1`, numerator `1`, is canonical because
  `L` is nonzero modulo `3`. The deleted coordinate has centered residue zero,
  so the lift fails strictly.
- After deleting `L`, pivot `1` is again impossible because survivor speed
  `3` is zero modulo `3`. Pivot `3`, numerator `4`, is canonical. The values
  of `4L mod 9`, centered, are `-2,1,-1,2`; each satisfies `4|h|<9`.

For singleton exceptional sets the survivor gcd is one and capacity is
exactly one. For `S={1,3}`, the survivor gcd is `L`; both exceptional speeds
are coprime to `L`, and `4|L` gives
`2*ceil(L/2)=L`. The remaining two two-element sets have capacity strictly
above the survivor gcd. Hence no member has a strict divisor block. This is a
symbolic congruence proof, not a bounded scan; recommend
`proved-math-qualified` at exactly this family scope.

## Selection-criteria audit

The contract asks whether one surviving declaration simultaneously:

1. is not already a trivial finite-set fact;
2. survives the supplied counterexamples;
3. is not merely conditional on the rejected or open bridge it was meant to
   replace; and
4. removes or strictly narrows one named edge toward unrestricted pivot
   certificate existence.

Response83's dependency map includes every survivor explicitly supplied by
the frozen contract. Applying those criteria gives an exhaustive
no-selection certificate:

| Survivor class | Decisive criterion failure |
| --- | --- |
| Prompt76/78 canonical-cover existence, uniqueness, minimality, privacy, and reindexing | Criterion 1: elementary finite labelled-set bookkeeping; rejected consumers supply no inequality or escape |
| Prompt77 balanced overlap | Criterion 4: proves certificates only for the explicit `(u,v,4uv)` family, not an unrestricted selector |
| Prompt77 periodic annihilation | Criterion 4: a negative obstruction to fixed literal modes, not a positive selector |
| Prompt78 divisible singleton blocker | Criterion 4: necessary obstruction only; absence of a blocker has no proved positive converse |
| Prompt79 `p,v`-dependent cross-minor | Criterion 4: the first open arrow remains the same fixed, bounded, prime-independent obstruction problem |
| Prompt79 Euclidean extraction | Criterion 3: assumes the fixed `D` whose construction is the entire open edge |
| Prompt80 divisor-block witness lift | Criterion 3: assumes both a strict block and survivor witness; the proposed unrestricted block selector is false |

No item is omitted from the response's dependency map, and combining the
overlapping Prompt76/78 bookkeeping facts creates no new implication. The
STOP conclusion therefore follows from the selection rule. It is not a claim
that the surviving infrastructure is false or unpublishable; it is the
narrower claim that none qualifies for selection under this contract.

## Corrected implication boundary

The project-level chain remains

```text
for every positive injective tuple a, exists pivot j and r in Q_j
  [open]
-> positive-integer LRC
  [accepted proved-lean equivalence]
-> unrestricted real LRC
  [accepted proved-lean equivalence].
```

The route-specific first failures are:

| Route | First failed or open arrow |
| --- | --- |
| 76 | global private demand `<=` external capacity is `rejected` |
| 77 | any positive scale-adaptive/full-spectrum selector is `open`; the literal six-mode selector is `rejected` |
| 78 | a blocker-free positive owner selector is `open`; sparse/canonical escape is `rejected` |
| 79 | private local data to a fixed prime-independent finite obstruction is `open` |
| 80 | unrestricted strict-block-and-survivor selection is unavailable; the proposed strict-block conclusion is `rejected` |

For Prompt80 the correctly directed conditional branch is

```text
unrestricted strict-block-and-survivor selector [rejected as proposed;
                                                 any replacement open]
  + exceptional orbit-capacity bound [proved-math-qualified]
  -> DIVISOR-BLOCK-WITNESS-LIFT [proved-math-qualified]
  -> full witness [conditional]
  -> pivot certificate [accepted proved-lean equivalence].
```

The local lift does not imply its own hypotheses. With no selected lemma, no
new first open arrow replaces exact pivot-certificate existence.

## Surviving local lemmas at exact scope

| Lemma | Exact surviving status | Why it is not selected |
| --- | --- | --- |
| Covered-pivot canonical-cover package | `proved-math-qualified`, unrestricted finite labelled sets | Elementary bookkeeping; no global comparison |
| Prompt77 family balanced-overlap certificate | `proved-math-qualified` for `(u,v,4uv)` only | Family-specific |
| Periodic zero-block lemma | `proved-math-qualified` for the stated repetition/frequency hypotheses | Negative route diagnostic |
| Divisible singleton blocker | `proved-math-qualified`, unrestricted at its divisibility hypothesis | Necessary obstruction, no positive converse |
| Prompt79 private cross-minor | `proved-math-qualified`, unrestricted over bad-prime failures but `p,v`-dependent | Does not supply uniform finite data |
| Conditional Euclidean extraction | `proved-math-qualified` conditional on fixed `D` | Assumes the missing obstruction object |
| `DIVISOR-BLOCK-WITNESS-LIFT` | `proved-math-qualified` at strict-block and survivor-witness hypotheses | Conditional infrastructure; block selector rejected |
| Prompt80 infinite counterfamily | `proved-math-qualified` at displayed congruence classes | Negative structural family, not a selector |

## STOP disposition and remaining gaps

Response83 should retain `STOP`, select no declaration, and admit no
implementation candidate. The response did not implement anything, run a new
finite search, or promote finite evidence.

Remaining mathematical gaps are:

- a materially new unrestricted pivot selector;
- for Prompt79, a genuinely fixed prime-independent bounded signature or
  obstruction, if that route is continued;
- for Prompt80, a replacement structural selector not contradicted by
  `(1,3,16)` or the proved infinite family;
- for the spectral and cover routes, new positive selectors that do not imply
  their rejected frozen bridges.

Recommended final labels are:

| Item | Label |
| --- | --- |
| Response83 disposition | `STOP`, accepted by independent audit |
| Exact integrated Prompt76--80 mathematics at documented scopes | retain `proved-math-qualified` |
| Prompt80 infinite family proof in Response83 | recommend `proved-math-qualified` at exact family scope |
| Prompt76 global inequality | `rejected` |
| Prompt77 literal six-mode gap | `rejected` |
| Prompt78 sparse and canonical owner escape | `rejected` |
| Prompt79 determinant/annihilator candidate choices | `rejected` only for the displayed choices |
| Prompt79 finite prime-independent obstruction theorem | `open`, not refuted |
| Prompt80 universal strict-block conclusion | `rejected` |
| Response-authored scans and execution artifacts | `unverified` |
| Exact pivot selector, positive-integer LRC, unrestricted real LRC | `open` at theorem level |
| New Lean theorem or implementation | none |

This documentation audit changes no source, Lean declaration, theorem status,
browser state, or recovered response artifact.
