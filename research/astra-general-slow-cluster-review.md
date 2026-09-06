# Independent review of the general-slow cluster audit

**Accepted as a bounded manuscript audit, with no correction required.**
The exact admissible rows, both failed proof transfers, and the alternate
forward witness are valid. The displayed family is not a counterexample to
the two-digit existence claim. General closed supply under the stated
separation hypothesis remains unresolved in this audit, as does its stronger
forward version. Nothing here changes the accepted unit-speed theorem or
resolves unrestricted LRC.

Review date: 2026-09-06. Task `/root/general_slow_cluster_review`, in the
requested existing Astra/xhigh session. Review source checkpoint:
`4227fef76e8a2081460c27b3af627bc6dcb501d4`.

The complete reviewed author file is
`research/astra-general-slow-cluster-audit.md`, SHA-256
`07d42aa0e48e2daa62d4799049b317eee526af42ecb025fcd0e6515a7cfa6478`.
Its recorded author checkpoint is
`737ac0634c02c21025bcafebacc97c9152f04bf4`; the review binds the actual frozen
file above, rather than silently replacing that provenance.
Its accepted inputs, previously read in full in this reviewer session and
unchanged on current hash readback, are:

* `research/astra-cluster-grid-rescue.md`:
  `edc948e31d6939132dd44dec7fe84612912ab952ceb8e98140a6b9cb2e9b5f9c`.
* `research/astra-cluster-grid-rescue-review.md`:
  `99caba49dd2b5b20475d89901d39fd6ce24fbbb5a060b949ab7707f52a6b569e`.

## 1. Contract and exact slow-admissible pairs

The hypotheses are integer `N>=5`, positive integers a and M, a set C of
exactly `N-2` distinct nonnegative integer offsets containing zero, and

`H=max C`, with `M>(N-1)max(H,a)`.

They give `a<M`, so the actual `N-1` moving speeds a and `M+c`, for c in C,
are positive and distinct. The ordinary candidate time is exactly

`t(k,ell)=k/(N a)+ell/(N M)`, for `0<=k,ell<=N-1`.

Its slow phase is `k/N+e`, where

`e=a ell/(N M)`, `0<=e<1/N`, and `e=0` if and only if `ell=0`.

The phase is strictly less than 1 even at `k=N-1`, so there is no wrap.
For k=0 it is below the closed lower threshold. For `1<=k<=N-2`, it is
at least `1/N` and strictly below `(k+1)/N<=(N-1)/N`. For `k=N-1`, it
equals the upper threshold exactly when ell=0 and exceeds it otherwise.
Thus the author's pruning is exact:

* Forward-admissible pairs: `1<=k<=N-2`, all `0<=ell<=N-1`.
* Closed-admissible pairs: those same pairs plus `(N-1,0)`.

These are counts and classifications of assignments; injectivity of the
map to times is unnecessary. The extra pair is only slow-admissible: it
must still pass every fast constraint to be a full closed witness. It is
never a forward witness because its slow phase is the upper face.

Scaling speeds by `1/a` and time by a preserves all actual phases and maps
the candidate time to `k/N+ell/(N(M/a))`. However, `M/a` and `c/a` need not
be integers. The accepted integer residue theorem therefore cannot be
invoked solely by performing this scaling.

## 2. Exact family and the two failures

For every integer `N>=5` and integer `a>N`, set

`M=Na-1`, `C={0,1,...,N-4} union {a}`.

The interval contributes `N-3` distinct offsets. Since `a>N>N-4`, its union
with `{a}` has exactly `N-2` elements and maximum H=a. The zero offset is
present, and

`M-(N-1)max(H,a)=a-1>0`.

This is an actual ordinary integer tuple with the full required arity and
separation. It is not an independently assigned phase system.

For the anchor c=0 and `1<=k<=N-2`, the inequality `0<k/a<1` yields

`A_0(k)=floor(k M/a)=floor(kN-k/a)=kN-1`.

This is always minus one modulo N. In contrast,
`k A_0(1)=k(N-1)` is minus k modulo N. At k=2 these residues differ by
one, so the proposed linearization fails even modulo N. The example
specifically refutes replacing this changing floor by k times its first
row value; it does not rule out every possible treatment of row arithmetic.

For the independent carry issue, take c=a and `(k,ell)=(1,N-2)`. Then

`(M+a)/a=N+1-1/a`, so `A_a(1)=N` and `beta_a(1)=1-1/a`.

The integer part `A_a(1)+ell=2N-2` has the favorable residue `N-2` used
in the unit-speed construction. The remaining numerator is nevertheless

`beta_a(1)+a(N-2)/M = 1+epsilon`,
`epsilon=a(N-2)/M-1/a`.

For positivity, `a>N` and `N-2>=3` imply `a(N-2)>N`; multiplying by a
gives `a^2(N-2)>Na>Na-1=M`. For the upper bound,

`a(N-2)/M < (N-2)/(N-1) < 1`,

using `M>(N-1)a`. Hence `0<epsilon<1`. The actual fast phase is

`1+(N-1+epsilon)/N` before taking fractional part,

and `(N-1+epsilon)/N` afterwards. It is strictly above the closed upper
face and strictly below 1. Since it also exceeds one half, its circle norm
is exactly `(1-epsilon)/N<1/N`. The slow label remains forward-good by the
row classification. This verifies failure of the claimed implication from
a favorable floored residue to an actual good phase, at an actual candidate
of an admissible integer tuple.

The two defects are distinct: the first concerns the dependence of the
integer floor on k; the second concerns a carry from the sum of the
fractional remainder and the column correction. Bounding each summand by
one does not bound their sum by one.

## 3. The alternate forward witness, including N=5

The same family has the allowed assignment `(k,ell)=(1,2)`. Here `2<=N-1`,
and `M>(N-1)a>=4a` gives `2a<M`. The slow phase is therefore

`1/N+2a/(N M) in (1/N,2/N)`.

For every c in C, direct expansion gives

`(M+c)t(1,2)=1+B(c)/N`,
`B(c)=2+(c-1)/a+2c/M`.

The function B is increasing in c. Since `0<=c<=a`,

`B(0)=2-1/a>1`,
`B(a)=3-1/a+2a/M<4`.

Thus `1<B(c)<4<=N-1<N`. There is no unrecorded wrap: the actual
fractional fast phase is `B(c)/N`, which lies strictly between `1/N` and
`(N-1)/N`. At N=5, the inequality `B(c)<4` is strict, so the upper
forward boundary is still excluded. The slow phase is also strictly inside
the forward band because `2<N-1`.

Every moving label therefore passes at this one common two-digit time
for all parameters in the family. The family demonstrates a failed proof
transfer and a failed selected assignment, not absence of all closed or
forward assignments. No existential counterexample is supplied.

## 4. Coupled rows and the remaining obligation

For the general tuple, the author's exact numerator is

`X_c(k,ell)=k(M+c)/a+ell(1+c/M)`.

The fast phase equals `X_c/N`. It is closed-good precisely when there
exists an integer z with

`Nz+1 <= X_c(k,ell) <= Nz+N-1`.

For forward-good the right inequality is strict. This equivalence follows
by taking `z=floor(X_c/N)` in the good case, and conversely noting that
the remainder lies between 1 and N-1, strictly below N. It includes every
possible integer carry and both target endpoints.

With E_c^F(k) and E_c^C(k) defined as the failing columns, forward existence
is exactly an uncovered column in at least one row `1<=k<=N-2`. Closed
existence additionally permits simultaneous fast success at `(N-1,0)`.
Both formulations require a single common k and ell for all c; the integers
z may of course differ between labels, as ordinary fractional parts do.
The closed bad-column sets are subsets of the forward bad-column sets,
which is consistent with the additional allowed upper face.

These formulas are exact obligations, not a bound on their unions. The
accepted residue lemma concerns multiplication of a fixed set in `Z/N`
followed by a common translation. It does not immediately govern these
changing floors and column-dependent corrections. No estimate preventing
every admissible row from being covered is proved in the audit. This
review neither supplies such an estimate nor infers its impossibility.

The accepted unit-speed theorem remains valid. The general two-digit
closed and forward existence claims remain open within this audit's scope,
and there is no reduction of unrestricted LRC to the stated cluster class.
No general theorem is ready for Lean implementation on this evidence alone.

## 5. Verification record

Verification consisted of independent hand algebra for the exact hypotheses,
cardinality, row pruning, floor identity, strict carry bounds, alternate
witness, and coupled inequalities, plus current source-hash readback.
No defect or required correction was found. The project configuration,
workflow, policy, and focused active state were read. The command
`python3 scripts/validate_workflow.py` exited 0 with complete output:

```text
workflow structural validation passed; it cannot certify mathematical validity.
```

No mathematical program, enumeration, solver, external theorem lookup, Lean
restoration or check, Git operation, shared-state edit, cache mutation, or
delegation was performed. Only this review file was written; the author and
other agents' files were preserved. Administrative JSON reading and workflow
validation are not mathematical verification. Per-task elapsed time, token
usage, and independently observed runtime model metadata are unavailable and
remain null. No owned process or dependency-cache requirement remains.
