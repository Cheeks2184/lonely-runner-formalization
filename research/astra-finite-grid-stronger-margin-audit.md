# Limits of the finite-grid count at the canonical margin

**Result.** At N>=3 total runners, with n=N-1 moving labels and target
delta=1/N, the exact independent fiber caps minus one anchor-fiber saving
cannot force a survivor, for any uniform or mixed positive grid sizes.
Actual common-origin structure does provide additional incidence savings,
but the prescribed q=n grids are themselves incomplete: for every prime
N>=3, the ordinary tuple `(1,...,N-1)` has no full target witness in either
the zero-offset grid or any of the root-aligned weak-margin grids.
The tuple nevertheless has the immediate full witness 1/N.

These are exact limits of a specified counting argument and specified grids.
They do not refute other grid sizes, offsets, joint counting methods, or LRC.
The weak-margin horizon theorem at 1/(2n) is not contradicted.

Date: 2026-09-06. Task `/root/finite_grid_stronger_margin_audit`, using the
existing `/root/uniform_affine_phase_screen` session, requested Astra/xhigh.
Source checkpoint: `8b9ea58d8a477a0fad733c3cf6674c307c1f9782`.
Only this report is owned. Project config, workflow, policy and focused active
state were read, and startup workflow validation passed. No mathematical
program, search, Lean check, cache, Git or shared-state operation was used.
This is a manuscript method audit; independent final review remains required.

## 1. Bound root source and exact grid setting

The complete root candidate was read in
`research/astra-finite-grid-horizon.md`. Its final bound version has SHA-256

`1cd85650cc5ba679ad016c6b30f3604787c84e3bf86a4a90f11a82b9f653d865`.

This supersedes the initially supplied hash `5aa924b8...`; the only intervening
change clarified the optimal-tail wording. The root argument uses b-grid
fibers for b fast labels at weak margin 1/(2b), with at most one bad point
per fiber and one completely safe anchor fiber. Another reviewer owns its
full theorem review. This audit checks what happens when all n=N-1 moving
labels are instead tested at the larger canonical margin 1/N.

More generally, fix positive integers q_i, positive real frequencies w_i,
arbitrary phases theta_i, and a real offset h. Put

`Omega=product_i {0,...,q_i-1}`, `Q=product_i q_i`,
`t(k)=h+sum_i k_i/(q_i*w_i)`,
`Bad_i={k in Omega : ||theta_i+w_i*t(k)||<1/N}`.

For a fixed i and fixed coordinates other than k_i, the actual i-th phases
form one translated q_i-grid with increment 1/q_i. This common-time identity
does not make the different bad sets independent. All counting below is on
the one assignment set Omega, even if distinct assignments yield the same
real time.

## 2. Exact strict-bad count in one translated fiber

For a q-grid at target 1/N, let `x=2q/N` and `c=ceil(x)`. Since N>=3,
the strict bad arc has length 2/N<1. Lifting that arc and multiplying phases
by q identifies its grid points with the integers in an open interval of
length x<q. Distinct such integers represent distinct grid residues.

If x is not an integer, the possible counts are `floor(x)` and `ceil(x)`.
If x is an integer m, the possible counts are m-1 and m: both endpoints
being integers excludes both of them, while a nonintegral translate contains
exactly m integers. These alternatives are attainable by translations.
Thus, in all cases,

`the exact possible fiber counts are c-1 and c`.       (1)

This includes q=1, when c=1 and the singleton is either good or bad.
The maximum is therefore exactly `ceil(2q/N)`, not a rounded strict bound
of a different sign. The best translated fiber saves exactly one point
relative to its maximum, never more. An empty best fiber occurs only when
c=1; at larger c the best fiber still contains c-1 bad assignments.

In particular, aligning one fiber with a closed good boundary can save one
incidence, but it does not make that entire fiber safe when `ceil(2q/N)>1`.
The root weak-margin case has precisely c=1, which is why its one-fiber
argument has a different count.

## 3. Uniform and mixed caps both fail after one saving

Write `c_i=ceil(2q_i/N)`. There are Q/q_i fibers for label i, so the summed
independent cap is the integer

`S=sum_i c_i*(Q/q_i)`.

Because `c_i>=2q_i/N` and n=N-1,

`S >= [2(N-1)/N]*Q > Q`.                              (2)

Both S and Q are integers. Consequently `S>=Q+1`, and hence

`sum_i ceil(2q_i/N)*(Q/q_i)-1 >= Q`                    (3)

for every choice of positive integers q_i. No finite small-product cases
are needed: strict positivity followed by integrality proves the last unit
of the bound even when `(N-2)Q/N<1`.

For a uniform q this specializes to the proposed exact inequality

`(N-1)*ceil(2q/N)*q^(N-2)-1 >= q^(N-1)`.

Alternatively, `n*ceil(2q/N)-q` is a positive integer because it is at least
`(N-2)q/N>0`; multiplying by q^(n-1) yields the same result. Thus neither
uniform nor mixed sizes repair the cap-only argument by changing q alone.
An upper bound at least Q does not force a point outside the union. This
statement concerns the information in the bound, not joint attainability
of every cap for every actual tuple.

## 4. Exact additional saving that a joint argument would need

For label i and each of its fibers f, let m_i(f) be its actual bad count.
By (1), each deficit `c_i-m_i(f)` is either zero or one. Define

`D=sum_(i,f) [c_i-m_i(f)] = S-sum_i |Bad_i|`,
`r(k)=#{i:k in Bad_i}`,
`R=sum_(k in Omega) max(r(k)-1,0)`.

Here D counts deficient fibers, while R is the actual overlap redundancy
of the bad sets. R is not the sum of all pairwise intersection counts; a
point of multiplicity r contributes r-1, rather than choose(r,2).
The exact identities are

`|union_i Bad_i| = S-D-R`,
`number of surviving assignments = Q-S+D+R`.

Therefore a survivor exists exactly when

`D+R >= S-Q+1`.                                      (4)

This identity locates the missing quantitative input; it is not itself a
new supply theorem. If one anchor fiber already gives one unit of D, a
sufficient additional lower bound is

`(D-1)+R >= S-Q`.                                    (5)

The excess to be removed satisfies

`S-Q >= ceil((N-2)Q/N)`.

Thus one unit does not address the order-Q excess of the canonical-margin
union bound at large grids. A valid new argument needs actual additional
deficient fibers or overlap redundancy, not an assumption that independently
maximal fibers can all be made favorable simultaneously.

## 5. Genuine common-origin savings, with their limitations

Now take ordinary phases theta_i=0, offset h=0, and positive integer speeds
v_i. The zero assignment has t=0 and belongs to every Bad_i. Hence

`R>=n-1`.

There are also separate incidence savings beyond this shared point. On the
i-th fiber with all other coordinates zero, the phases are exactly k_i/q_i.
Since N>=3, their strict-bad count is

`z_i=1+2*#{r in Z:1<=r<q_i/N}=2*ceil(q_i/N)-1`.

The initial 1 is the zero residue; every other bad residue is paired with
its negative. These two sides do not meet because q_i/N<q_i/2. Thus the
common origin guarantees the additional fiber deficit

`D >= sum_i [ceil(2q_i/N)-2*ceil(q_i/N)+1]`.            (6)

Each bracket is zero or one, consistently with (1). This is a justified
actual-phase bound beyond knowing a single common bad point.

For the natural grid q_i=n=N-1, one has `c_i=2` and `z_i=1`, because
`1/n>1/N`. Every label's zero-other-coordinate fiber saves one incidence,
so D>=n and R>=n-1. These count different terms in the exact identity (4),
and can be combined without double-counting:

`D+R>=2n-1`.

But here `Q=n^n`, `S=2Q`, and (4) requires `D+R>=Q+1`.
Since n>=2 implies `n^n>=2n`, the displayed common-origin bound is still
insufficient. Beyond it, the required additional saving is
`Q-2n+2`.

These origin statements must not be silently added to an argument using a
general nonzero alignment offset h: such an offset need not leave any
assignment at a common zero. The next actual obstruction treats the origin
and the root's particular weak-margin alignment separately.

## 6. An actual fixed-grid obstruction for unbounded N

This construction and its proposed proof were supplied by root during the
audit and independently verified here. It strengthens the counting-method
limit to a failure of the prescribed grids themselves.

First, for every N>=3, consider the distinct positive primitive tuple

`v=(1,2,...,n)`, where `n=N-1`.

Its full closed-margin witnesses are exactly

`t=p/N (mod 1)`, with `gcd(p,N)=1`.                   (7)

To prove necessity, the N points `0,t,...,nt` on the circle are pairwise
at circular distance at least 1/N: every pairwise difference is kt with
1<=k<=N-1, one of the original constraints. They are therefore distinct.
Put them in cyclic order. Each of the N successive positive gaps is at
least 1/N and their sum is one, so every gap equals 1/N. The set of points
is the equally spaced N-grid containing zero. In particular t is p/N modulo
one. The N orbit points are distinct exactly when p is a unit modulo N.
Conversely, such a p permutes the nonzero N-residues, whose circle distances
are all at least 1/N. This proves (7), including the closed threshold.

Now restrict N to primes at least three and put `L=lcm(1,...,n)`.
The prime N divides neither 2, n nor L, so

`gcd(N,2nL)=1`.

For this obstruction the interval origin is explicitly A=0, all ordinary
phases are theta_i=0, and q=n. The only offsets considered are h=0 and
the root's resulting alignment h=1/(2n*v_j)=1/(2n*j). Every time in the
zero-offset grid has the form

`t=sum_(i=1)^n k_i/(n*i)`, with `0<=k_i<n`.

Every time in the root-aligned weak grid, for any anchor j in 1,...,n, has
the form

`t=1/(2n*j)+sum_(i=1)^n k_i/(n*i)`.

All these rational times have denominator dividing 2nL: each n*i and
2n*j divides that common denominator. None can have fractional part p/N
with gcd(p,N)=1. Cross-multiplication would force N to divide 2nL, a
contradiction. Consequently **neither entire grid contains a full 1/N
witness**, for every anchor in the aligned case. Primes give an unbounded
family of total counts; these are controls of one uniform method, not
successive runner-count milestones.

For the smallest control N=3, the origin grid for v=(1,2) is
`{0,1/4,1/2,3/4}`, while the full witnesses modulo one are 1/3 and 2/3.
The origin-grid bad counts are |Bad_1|=3 and |Bad_2|=2. With Q=4 and S=8,
this gives D=3, R=1 and D+R=4=Q, exactly one unit below the survivor
requirement Q+1. These are hand identities, not an executed search.

More generally, for every prime in the family and either prescribed grid,
no survivor and the exact identity in section 4 imply

`D+R=S-Q=Q`, since q=n makes S=2Q.

No truthful additional-overlap or missing-fiber bound can raise that quantity
to Q+1 on these grids. A general repair must alter the sampled set or add
some other route; it cannot merely prove a stronger count about the same
always-covered assignment set.

The scope restriction is concrete. Changing the zero-offset modulus to q=N
includes the full witness 1/N: choose k_1=1 and every other coordinate zero.
An arbitrary offset or translated interval origin A could also insert a
witness directly. Neither larger moduli, arbitrary offsets nor arbitrary
translated intervals are refuted. The family also misses the
small denominator N (none of its speeds is N-divisible), so it is not a
control satisfying all necessary profiles of a hypothetical minimal
counterexample. No such additional profile claim is made here.

## 7. Disposition and remaining mathematical input

The exact translated-fiber cap and one-unit variation prove the proposed
uniform and mixed inequalities with no exceptions. Common-origin structure
gives a real improvement over one anchor saving, as (6) shows, but the
prime tight-speed family prevents a universal canonical-margin survivor
theorem on the two prescribed q=n grids. It remains compatible with the
root theorem's weaker margin 1/(2n) and with ordinary LRC.

For an altered grid, a sufficient quantitative target is (4) with separately
proved lower bounds for D and R. No universal source of the required bound,
or universal modulus/offset-selection theorem, is established in this audit.
The exact identity alone must not be treated as such a source. In particular,
this report says nothing against every grid method, all intersection methods,
or a method that first applies other justified arithmetic reductions.

Verification consisted of the hand interval-count proof, ordered arithmetic,
the circle-spacing argument, and source SHA-256 readback. The final root
source binding above matched. The required structural validator exited 0
with the complete output

```text
workflow structural validation passed; it cannot certify mathematical validity.
```

No enumeration, mathematical program, external literature claim or new Lean
result was used. Per-task elapsed time and model token usage are unmeasured
and remain null. No correction to the root's weak-margin theorem is implied;
its independent reviewer owns that acceptance decision. Only this report
was written, and this task needs no cache or dependency source.
