# Independent review of the stronger-margin finite-grid audit

**Verdict: accepted as a manuscript method audit.** The exact fiber counts,
uniform and mixed cap barriers, deficiency/overlap identity, common-origin
savings, and actual prime consecutive-speed obstruction are correct. The
last obstruction applies to the specified origin-based grids. It does not
refute the weak-margin horizon theorem, ordinary LRC, or arbitrary grids.

Date: 2026-09-06. Review task `/root/finite_grid_stronger_margin_review`,
in the existing `/root/uniform_screen_review` session, requested Astra/xhigh.
The reviewer authored neither input. Observed runtime model/effort, elapsed
time and token accounting are not independently exposed and remain null.
Parent-supplied checkpoint: `8b9ea58d8a477a0fad733c3cf6674c307c1f9782`.
Only this review is owned and written. Current project config, workflow,
policy and focused state were read; structural validation passed.

## Bound inputs and review scope

The complete audit and the root candidate were read. Actual SHA-256 bindings:

| Input | SHA-256 |
| --- | --- |
| `research/astra-finite-grid-stronger-margin-audit.md` | `9ec0f7087231f67be09680c228826683da51c1af8c19c101581eb62fec2cdb6b` |
| `research/astra-finite-grid-horizon.md` | `1cd85650cc5ba679ad016c6b30f3604787c84e3bf86a4a90f11a82b9f653d865` |

The audit's final revision explicitly fixes interval origin A=0, ordinary
phases, and the stated offsets for its grid counterexample. This clarification
addresses the review concern that arbitrary translated origins can introduce
the missing witness denominator. The counting and packing arguments were
unchanged. The root's full weak-margin theorem has a separate reviewer;
here its source is used to identify the actual aligned candidate set.

## Strict fibers and the cap barrier

Take N>=3, n=N-1, positive real w_i, positive integers q_i, arbitrary phases
and offset, with Q=product q_i. Count assignments in the product grid, even
when different assignments give the same real time. On an i-fiber the phase
increment is exactly 1/q_i. The bad condition is strict: norm <1/N.

For a q-fiber, lift the open circular bad arc and scale by q. Its length is
x=2q/N<q, so the integers it contains represent different grid residues.
For nonintegral x the possible counts are floor(x) and ceil(x). For integral
x=m, integral endpoints give m-1 and a nonintegral translate gives m. Thus
the exact alternatives are c-1 and c, where c=ceil(2q/N); both are attainable.
This proves the endpoint and wraparound claims, including q=1. One selected
fiber can save at most one incidence. It need not become entirely safe when
c>1, and this statement does not bound the combined savings of many fibers.

Put c_i=ceil(2q_i/N) and S=sum_i c_i Q/q_i. Then

`S >= 2(N-1)Q/N > Q`.

S and Q are integers, so S-1>=Q for every positive choice of the q_i.
This proves the mixed inequality, including small products, and its uniform
specialization `(N-1)ceil(2q/N)q^(N-2)-1 >= q^(N-1)`.
It proves that this upper bound cannot force a survivor; it does not assert
that all individual caps are jointly attained by some actual tuple.

## Exact saving and genuine common-origin information

Let m_i(f) be the actual count on a fiber. Deficiency and redundancy are

`D=sum_(i,f)(c_i-m_i(f))=S-sum_i |Bad_i|`,

`R=sum_k max(r(k)-1,0)`, where `r(k)=#{i:k in Bad_i}`.

Each fiber deficit is zero or one. A point of bad multiplicity r contributes
r-1 to R if r>0, so R equals total bad incidences minus union size. It is
not the sum of pairwise intersections. Consequently

`#survivors=Q-S+D+R`,

and a survivor exists **exactly** when `D+R>=S-Q+1`. If an anchor supplies one
unit of D, the equivalent residual target is `(D-1)+R>=S-Q`. Integrality also
gives `S-Q>=ceil((N-2)Q/N)`. These identities supply no lower bound by themselves.

With ordinary phases and h=0, the zero assignment is bad for every label,
giving R>=n-1. On each zero-other-coordinate fiber the count is

`z_i=1+2#{r:1<=r<q_i/N}=2ceil(q_i/N)-1`.

The positive and negative residues are disjoint since q_i/N<q_i/2. Hence
`D>=sum_i [ceil(2q_i/N)-2ceil(q_i/N)+1]`, with each bracket zero or one.
For q_i=n, c_i=2 and z_i=1, so D>=n and R>=n-1. These are different terms
of the exact identity and may be added without double-counting. But S=2Q,
Q=n^n, and `2n-1<Q+1` for n>=2, leaving the stated additional requirement
Q-2n+2. These origin bounds cannot be transferred to an arbitrary nonzero h.

## Actual prescribed-grid failure

For every N>=3, the tuple (1,...,N-1) is distinct, positive and primitive.
Its closed 1/N witness set modulo one is precisely

`{p/N : gcd(p,N)=1}`.

Indeed, at a witness the N circle points 0,t,...,(N-1)t are pairwise at
distance at least 1/N, because all positive differences of their indices
are among the constrained speeds. They are distinct. Every successive
cyclic gap is at least 1/N, and the N gaps sum to one; therefore every gap
equals 1/N. Since zero is included, the point set is the N-grid and t=p/N.
Distinctness forces p to be a unit modulo N. Conversely, multiplication
by such a p permutes the nonzero residues and gives the required closed
distances. This argument needs neither primality nor a global-maximality
premise; equality at the threshold is essential.

Now let N>=3 be prime, n=N-1 and L=lcm(1,...,n). Then N is coprime to 2nL.
Fix A=0, ordinary phases and q=n. The root source's alignment
`fract(1/2-n*theta_j)/(n*w_j)` becomes `1/(2n*j)` for this tuple. Thus both
prescribed candidate sets, for all anchors j, consist of times

`sum_i k_i/(n*i)` or `1/(2n*j)+sum_i k_i/(n*i)`, with `0<=k_i<n`.

Every candidate has denominator dividing 2nL. If its fractional part were
p/N with p a unit, cross-multiplication would force N to divide 2nL.
Therefore neither prescribed grid contains any full witness. This is an
actual obstruction at unbounded prime counts, although 1/N is a witness.
Duplicates of candidate times do not affect the argument.

The N=3 hand control is also correct: the zero-offset candidates are
0,1/4,1/2,3/4; the two bad counts are 3 and 2. With Q=4 and S=8, D=3 and
R=1, so D+R=4. Generally the proved absence of survivors and S=2Q imply
D+R=Q on either prescribed grid throughout the prime family. No stronger
truthful correlation estimate can make this same quantity reach Q+1 there.

## Limits and remaining obligation

Changing to q=N and h=0 includes 1/N by setting k_1=1 and all other
coordinates zero. Arbitrary offsets or interval translations can also
insert a witness. Neither these alternatives nor all intersection arguments
are refuted. The consecutive tuple has no N-divisible speed and therefore
does not satisfy all small-denominator profiles of a hypothetical minimal
counterexample. No survival of those additional profiles is asserted.

The weak 1/(2n) horizon is consistent with this obstruction at the larger
target 1/N. For other sampled sets, the remaining task is a justified
universal selection or saving theorem that actually supplies a survivor,
possibly after arithmetic reductions or through another route. The exact
D+R reformulation does not establish that theorem. This is an accepted
manuscript limitation, with no new Lean theorem or unrestricted LRC result.

## Actual check receipts

All mathematical verification above was by hand proof and source reading.
No mathematical program, enumeration, external source retrieval, Lean,
Git, shared-state edit or cache operation was performed. After rereading
the current workflow following context compaction, this command ran in
`/home/joshua/lonely-runner-formalization`:

```sh
python3 -B scripts/validate_workflow.py
```

Exit 0; full output:

```text
workflow structural validation passed; it cannot certify mathematical validity.
```

Source readback command:

```sh
sha256sum research/astra-finite-grid-stronger-margin-audit.md research/astra-finite-grid-horizon.md
```

Exit 0; full output:

```text
9ec0f7087231f67be09680c228826683da51c1af8c19c101581eb62fec2cdb6b  research/astra-finite-grid-stronger-margin-audit.md
1cd85650cc5ba679ad016c6b30f3604787c84e3bf86a4a90f11a82b9f653d865  research/astra-finite-grid-horizon.md
```

Owned-file whitespace check:

```sh
rg -n '[ \t]+$' research/astra-finite-grid-stronger-margin-review.md
```

Exit 1 with empty output: no trailing-whitespace matches. The final review
SHA-256 is returned separately after freezing the file, avoiding a
self-referential hash claim.
