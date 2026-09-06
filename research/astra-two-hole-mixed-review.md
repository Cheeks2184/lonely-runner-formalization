# Independent review: direct-or-mixed supply through height N+1

Date: 2026-09-05. Reviewer task: `/root/mss_published_bound_audit`, requested
Astra/xhigh, independent of the manuscript author. Runtime model/effort
metadata is not independently exposed. This assignment owns only this review.
The workflow records source checkpoint `cdd7f2c1e6a077726ee45a71b98ddd8591c97bf3`;
the author's assigned mathematical baseline is
`5e7d690e6606ad096bf4a2319be0328f9c6d2e68`.

**Verdict: accepted as a complete manuscript proof at the stated restricted
scope. No actionable mathematical finding.** The alternatives need not be
exclusive: the proof supplies either a direct reciprocal certificate or a
common witness with the stronger fastest-coordinate margin. It does not
prove unrestricted direct-or-mixed supply or unrestricted LRC.

## Source guard and exact claim

Reviewed author file: `research/astra-two-hole-mixed-supply.md`.
Reviewed SHA-256:
`2bbc12481c164bf5e4eaf30ea7ca966cb0b2614524d9bea779034a2ebf115ccb`.
The guard was checked before the exact arithmetic controls and at final freeze.
Any change to these bytes requires reassessment.

For every integer `N>=4` and set `W` of exactly `N-1` distinct positive integer
moving speeds, with `H=max(W)<=N+1`, the proof establishes:

- there is an integer `2<=d<=N` dividing no member of `W`; or
- there is a positive rational `T<1` with `||kT||>=1/N` for every `k in W`
  and `||HT||>=1/(N-1)` at that same time.

The chosen runner is stationary at zero. The first alternative gives an
ordinary witness `T=1/d`, without asserting the stronger fastest margin.
All distance inequalities are closed. Primitivity is not assumed or needed.

## Independent derivation

Cardinality and positivity force `H>=N-1`; hence the three height cases are
exhaustive. At `H=N-1`, `W={1,...,N-1}` and `d=N` is direct. At `H=N`, there
is exactly one omitted `a<N`. At `H=N+1`, there are exactly two omitted
values `1<=c<d<=N`, since the maximum is retained. An omitted value above
`H/2` has no retained positive multiple, proving the claimed direct cases
with the required denominator range.

For `H=N`, the omitted `a=1` gives `T=1/(2N)` and retained phases in
`[1/N,1/2]`, including fastest phase `1/2`. Otherwise the nondirect branch
has `a>=2` and `N>=2a`.

- If `N>=2a+1`, use `epsilon=1/(2aN)` and `T=1/a-epsilon`.
  A retained multiple has `k>=2a` and
  `0<k*epsilon<=1/(2a)<=1/4`, so its exact norm is `k*epsilon>=1/N`.
  A nonmultiple has norm at least `1/a-N*epsilon=1/(2a)>=1/(N-1)`.
  If the endpoint is a multiple, its norm is exactly `1/(2a)` and also
  meets the stronger target.
- If `N=2a`, use `epsilon=1/[N(N-1)]`. The only retained multiple is `N`,
  with norm `1/(N-1)<=1/3<1/2`. Other retained speeds are nonmultiples
  at most `N-1`, so their norm is at least
  `1/a-(N-1)*epsilon=1/N`.

These estimates use `||x-y||>=||x||-|y|` and the elementary nonmultiple
bound `||k/a||>=1/a`. Each perturbation satisfies `0<epsilon<1/a`.

For `H=N+1`, after the direct larger-hole case is removed, `2d<=N+1`
and therefore `2c<=N-1`. If `N>=2c+3`, the inclusive interval
`[N+2,2N-c-2]` has `N-c-3>=c` integers. With
`L=N+2`, `e=(1-L) mod c`, and `u=L+e`, one has
`0<=e<c`, `u` in that interval, and `u congruent to 1 mod c`.
This includes `c=1`. Define `q=c+u`; then

```text
gcd(c,q)=1,     0<c<q,     q-c=u>H,
H<q<=2(N-1).
```

Let `1<=r<q` satisfy `cr congruent to 1 mod q`. For a retained
`0<k<=H<q`, residues `rk mod q` equal to `0`, `1`, or `q-1` would force,
respectively, `k=0`, `k=c`, or `k=q-c`. Each is excluded. Thus the residue
lies in `[2,q-2]`, and `T=r/q` gives every retained coordinate the stronger
bound `||kT||>=2/q>=1/(N-1)`. The inverse and denominator bounds also prove
`0<T<1`. In particular, the argument does not silently use `q<=2N` when
the stronger target requires `q<=2(N-1)`.

If the modular size condition fails, `2c+1<=N<2c+3`, so `N=2c+1` or
`N=2c+2`. The inequalities `c<d` and `2d<=N+1` then force `d=c+1`.
These are exactly the two central families:

- **Even:** `N=2a`, `c=a-1`, `d=a`. At `a=2`, the separate witness
  `T=1/10` for `{3,4,5}` has norms `3/10,2/5,1/2`. For `a>=3`, set
  `epsilon=1/(2cN)` and `T=1/c-epsilon`. Here `c>=2` and
  `H*epsilon<1/2`, since `cN-H=(c-1)N-1>0`. Retained multiples start at
  `2c` and have exact norm `k*epsilon>=1/N`. Nonmultiples have norm at
  least `(N-1)/[N(N-2)]>1/(N-1)`, because
  `(N-1)^2-N(N-2)=1`. If the endpoint is a multiple, its exact norm
  also exceeds the stronger target: `H(N-1)-2cN=2N-1>0`.
- **Odd:** `N=2a+1`, `c=a`, `d=a+1`, `a>=2`. With
  `epsilon=1/(2aN)` and `T=1/a-epsilon`, one has
  `H*epsilon<=3/(2N)<=3/10<1/2`. Retained multiples again start at
  `2a`, so their norms are at least `1/N`; nonmultiples have the same
  lower bound `1/a-H*epsilon=1/N`. The endpoint phase is
  `HT=2+f`, where `f=(3a+1)/[a(2a+1)]`. At `a=2`, `f=7/10` and the
  norm is `3/10>=1/4`. For `a>=3`,
  `a(2a+1)-2(3a+1)=(a-3)(2a+1)+1>0` gives `f<1/2`, while
  `2(3a+1)-(2a+1)=4a+1>0` gives `f>1/(2a)=1/(N-1)`.

In both central perturbation branches `0<epsilon<1/c` or `1/a`,
respectively, so the claimed times are positive and below one. Every use
of the exact multiple norm is supported by a shift strictly below `1/2`.
The two exceptions correctly avoid extending the wrong linear piece of
the circle norm.

## Existing-source scope and small independent checks

I inspected `twoHoleDenominator_family_witness` in
`LonelyRunner/BoundedHeight.lean`: its complete contract is satisfied by
the modular construction with target parameter `N-1`, independently of
the moving count. Its strict speed upper bound and both avoided residues
are present. I also checked `boundedHeight_stationary_witness`; setting
its moving count to `n=N-1` gives `n>=3` and height `n+2=N+1`.
Consequently this entire domain already has an ordinary closed `1/N`
witness in Lean. This manuscript supplies the stated certificate-or-margin
classification; no new ordinary coverage or Lean proof is claimed.
The inspected source SHA-256 is
`681c38dae0158ffd4162fa471c429dea4e8b90e27ee6e3a6fdf7b3cbd6e47ecc`.
The earlier one-deletion note's reported hash matched, but the present
one-deletion argument was reviewed self-containedly.

Five fixed witness checks used only Python standard-library `Fraction`,
with `norm(x)=min(x-floor(x),1-(x-floor(x)))`. The exact times were
computed from the displayed formulas. Each check verified the literal
domain, `0<T<1`, every ordinary bound, and the fastest stronger bound:

| N, H, holes | T | Minimum ordinary norm | Fastest norm |
| --- | --- | --- | --- |
| `4,4,{2}` | `5/12` | `1/4` | `1/3` |
| `4,5,{1,2}` | `1/10` | `3/10` | `1/2` |
| `5,6,{2,3}` | `9/20` | `1/5` | `3/10` |
| `7,8,{2,3}` | `6/11` | `2/11` | `4/11` |
| `8,9,{3,4}` | `5/16` | `1/8` | `3/16` |

The modular check independently obtained `u=9,q=11,r=6`. Two range
guards confirmed that shift `5/8` has norm `3/8`, and endpoint correction
`7/10` has norm `3/10`; neither equals the unreflected correction.
All five checks and both guards passed. They are supplemental arithmetic
checks, not a tuple search or substitutes for the quantified proof.
The author's separate sixteen-row routine-control suite was not executed
by this reviewer and remains a separately owned acceptance item.

The workflow, task record, policy, and relevant validator routing logic were
read; `python3 scripts/validate_workflow.py` passed. Other commands were
focused source reads, hashes, the five `python3 -B` exact checks, and writing
this file. No Git, shared-state, Lean, dependency, or cache operation was
performed. This review is excluded from current PR 28/29 material and is
available for a future checkpoint after the root's remaining controls.
Only the owned review was written; all commands are stopped at freeze.
