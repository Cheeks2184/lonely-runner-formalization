# Independent review of the subset-gcd profile screen

Date: 2026-09-06. Reviewer: `/root/uniform_screen_review`, requested
Astra/xhigh; runtime model, effort and usage are not independently exposed.
Only this review is owned. Other agents' work was preserved.

**Accepted at manuscript scope.** The published condition is represented
correctly, and the new consecutive-family bound holds for every `N>=5`.
There is no mathematical correction required in the frozen manuscript.
The result leaves the stated collection of necessary arithmetic conditions
compatible; it neither resolves LRC nor rules out different proof mechanisms.

The following actual file hashes were checked with `sha256sum` (exit 0):

```text
979fb69005f60f4e0f4b350a272ac7234917695b7df085ab858a7bf9324456f9  research/astra-subset-gcd-profile-screen.md
8c4b6ee094f0f311f360d3abf371e95f731e28cee997d3810dd3218ff6f25746  research/astra-uniform-divisor-minimality.md
4694285c064e53697343c9d04cbe05cac9714eb40be5799010e6058d1776af91  research/astra-uniform-screen-review.md
cb41059260b943411e2ab5360b84b59cd13f2ddf352c3c50a0b3715b9b9987d6  LonelyRunner/FiniteHeightReduction.lean
```

**Primary-source contract.** In the published MSS article, Theorem A assumes
ordinary LRC for `n` total runners and gives the stationary `1/(n+1)` witness
for `n` positive integral moving speeds with full gcd one when the all-subset
gcd sum exceeds `choose(n+1,2)^(n-1)`. The article explicitly sets the empty
subset value to zero after Lemma 2.2; Corollary 2.3 identifies this sum with
the lattice-point count. Lemma 2.5 and its use in section 3.2 retain a strict
count threshold. Theorem B separately adds lower-count shifted LRC and the
Lonely Vector Property through `n`; those are not assumptions of ordinary
Theorem A. These statements and the cited proof locations were checked in
the [published article](https://www.cambridge.org/core/journals/forum-of-mathematics-sigma/article/linearly-exponential-checking-is-enough-for-the-lonely-runner-conjecture-and-some-of-its-variants/A51A991DE89B8C9C2E2FF13FBD4501DA),
accessed 2026-09-06. This is source-contract verification, not a new audit of
the entire geometric proof.

Thus, with `N=n+1`, the manuscript's definitions are exactly

```text
F(v) = sum_(nonempty S subset {0,...,N-2}) gcd(v_i : i in S),
B_N  = choose(N,2)^(N-2).
```

The sum has `2^(N-1)-1` terms. It includes all singleton terms and the full
set; it does not add a further constant for the empty set. Under the stated
lower-count hypothesis, failure forces `F(v)<=B_N`. A tuple with equality is
not excluded by this criterion alone. This stationary statement does not
authorize re-anchoring at another label while retaining the same profile.

**Independent algebra check.** Put `L_N=lcm(2,...,N)` and
`v_i=L_N+i`, for `0<=i<=N-2`. Every nonempty subset gcd is a positive divisor
of each member, hence is at most `L_N+N-2`. Since `L_N` divides `N!`,

```text
F(v) <= (2^(N-1)-1)(L_N+N-2)
     <= (2^(N-1)-1)(N!+N-2)
      < 2^(N-1)(N!+N-2) = K_N.
```

The last inequality is strict even if `L_N=N!`: the positive quantity
`N!+N-2` is multiplied by one additional unit. The bound needs no estimate
for individual nonsingleton gcds and no enumeration of subsets.

At `N=6`, direct integer arithmetic gives
`K_6=32*724=23168<50625=15^4=B_6`. For the induction write
`A_N=N!+N-2` and `C_N=choose(N,2)`. The exact difference is

```text
(N+1)A_N - A_(N+1) = N^2-2N-1 >= 0                 (N>=6).
```

Consequently `K_(N+1)<=2(N+1)K_N`. Also `C_(N+1)>=C_N`, so

```text
B_(N+1) = C_(N+1)^(N-1)
         >= C_(N+1) C_N^(N-2)
          = C_(N+1) B_N
         >= 2(N+1) B_N.
```

The final inequality is equivalent to `N(N+1)/2>=2(N+1)` and already holds
for `N>=4`. Multiplication by the positive factor `2(N+1)` preserves the
inductive strict gap:

```text
K_(N+1) <= 2(N+1)K_N < 2(N+1)B_N <= B_(N+1).
```

This proves `F(v)<B_N` for every `N>=6`, without extrapolation from samples.

The remaining `N=5` case is also correct. For `(60,61,62,63)`, the singleton
sum is 246. In lexicographic order the six pair gcds are
`1,2,3,1,1,1`, summing to 9. Each of the four triples has gcd one, and the
full gcd is one. Hence `F=246+9+4+1=260<10^3=B_5`. These are exact scalar
and gcd checks performed algebraically, not output from an executed search.
No claim below `N=5` is needed or inferred.

**Compatibility and limits.** The bound applies to precisely the family in
the prior accepted divisor report and its independent review, whose hashes
are bound above. Their relevant arguments were read again: two disjoint
consecutive pairs give every deletion gcd one; `L_N` covers every denominator
`2..N`; the exceptional-coordinate counts give all reciprocal-orbit capacity
inequalities, with the separate small cases retained. The same family is
primitive, has height at most `B_N`, and has maximum/minimum ratio below two,
so it also satisfies the stated fast-speed exclusion. No condition was
silently transferred from the different factorial affine-control family.

In particular, `t=1/(2L_N)` has exact norms `1/2-i/(2L_N)` and is a full
witness. Since `N(N-1)` divides `L_N`, its minimum norm is even greater than
`1/(N-1)` for `N>=5`, so every deletion has an own-margin seed at that time.
The family therefore demonstrates compatibility of the listed necessary
arithmetic conditions, including the new subset-gcd bound. It does not
satisfy a no-witness hypothesis or the corresponding simultaneous geometric
trapping conclusions.

The inspected current declaration
`primitive_sorted_largeHeight_stationary_lonelyAt` in
`LonelyRunner/FiniteHeightReduction.lean` consumes a strict maximum-height
inequality, with `m=N-2`; it does not consume `F(v)>B_N`. The manuscript
refinement is not a newly checked Lean declaration. Formalizing it could
reduce a finite domain, but this argument proves it cannot by itself make
the present listed arithmetic constraints inconsistent for arbitrary `N`.
It establishes no general limitation on other arithmetic or geometric ideas.

**Actual verification.** Project config, workflow, policy and focused active
state were read at startup. The command
`python3 -B scripts/validate_workflow.py` exited 0 with the complete output:

```text
workflow structural validation passed; it cannot certify mathematical validity.
```

The frozen manuscript was read in full. Source-contract verification used
the primary article's HTML, including the displayed mathematical statements.
The prior family proof, relevant independent-review passages and current
height declaration were inspected; the four bindings above matched.
All new numerical identities were checked algebraically as displayed here.
No mathematical Python reproducer, enumeration, Lean command, dependency
restoration, Git command or shared-state/cache write was performed. Only
this Markdown review was created.
