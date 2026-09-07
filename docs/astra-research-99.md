# Pass 99: bounded relations from the complete bad-set cover

PR #97 merged `76a0ee0f467161e1b6a14794381333fdf2b95850` from
`3c71f4dc668896ff37169570f81bb9c87c899627`. Its recorded publication evidence
includes both successful hosted checks, 3,731 build jobs, 710 trust reports,
and 23 remote file hashes plus ancestry. This pass changes research records;
it adds no Lean declaration or unrestricted LRC proof.

For n >= 6 moving speeds, the global measure manuscript proves that absence
of a nonzero integer relation on at most five labels, with every coefficient
bounded by D_n = 90n sum_(j=0)^4 binom(n-1,j) - 2, implies that more than
1/30 of the circle consists of strict native-good times. Since
D_n <= 90n^5 - 2, any hypothetical minimal failure therefore has a primitive
relation supported on two to five labels with that polynomial coefficient
bound. The proof combines the complete fifth Bonferroni polynomial with a
normalized square of the Fejer kernel; all moments and approximation errors
refer to the same original time and all original labels.

The bound restricts relation patterns, not the largest speed. It supplies
no count or sum descent. The native-good tuple {1,3,...,19}, at margin 1/11,
has fifth-functional integral at most -45/209 despite its strict witness
t = 1/2. Thus universal positivity of this fixed functional is false.
Analytic Lean implementation is deferred until the relation has a concrete
use in a global proof.

The unit-coefficient diagnostic rules out a further shortcut. Fix n = 5000
and any integer H >= D_n; take B = 30H + 1 and speeds
{2B^j, 3B^j : 0 <= j < 2500}. This tuple satisfies the complete negative
Fourier inequality derived from failure, and every one-deletion gcd is one.
Nevertheless every relation whose coefficients have magnitude at most H
has no coefficient +1 or -1, even with unrestricted support. Its common
norm is 2/5 at t = 1/5. The signature and deletion gcds therefore cannot
supply a unit relation with a coefficient bound depending only on n.
Actual strict failure and minimality are absent from this control. A
separate follow-up is checking the additional finite-height premise.

The same-parity pair manuscript is included with its independent review.
Replacing a < b of the same parity by (b-a)/2 and (b+a)/2 lowers the sum,
but its derived comparison bounds the new maximum by mu times
1 + M(1/a + 1/b), where mu is the original maximum and M is the largest
new speed. The guaranteed lower-count margin does not make that
comparison contradictory. Its whole-component two-core argument and the
retained odd-speed obstruction remain available; no failure transport is
claimed.

Correlation-to-arithmetic methods have prior literature. Perarnau and Serra
use Hunter's pair-intersection inequality in Section 2.1 of
[their 2016 paper](https://www.combinatorics.org/ojs/index.php/eljc/article/download/v23i1p50/pdf/).
Tao's [Proposition 3.3](https://arxiv.org/pdf/1701.02048) derives bounded
three-speed relations from a large triple-intersection hypothesis. These
source comparisons do not supply the missing descent, and no novelty claim
is made here.

The source manuscripts, independent reviews and hash-bound verification
receipt record the exact scope. No local build or cache restoration was
needed. Unrestricted LRC remains unresolved.
