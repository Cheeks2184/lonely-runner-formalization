### 1. Disposition

**MIXED**

The following local results survive independent mathematical reconstruction:

* Response68 A1, the (N)-divisible-coordinate theorem.
* Response68 A2, the exact CRT fiber and capacity formulas, but not the determinant or finite-signature inference.
* Response68 A3, the bounded-annihilator theorem with the explicit sufficient constant
  [
  H_n=2n,5^{,n-1}4^n+1.
  ]
* Response68 A4, the finite bounded-hyperplane necessity theorem for a fixed positive-integer counterexample.
* Response70 B1 through B6, including divisor forcing, singleton-cover rigidity, the multiowner-pivot consequence, and the exact Fourier pullback formula.
* Response69’s common-scaling identity, singleton case, and (n=2) case.

No qualifying unrestricted bridge survives. The collective bounded-hyperplane exclusion scheme and Response70’s common-prime theorem are each equivalent to unrestricted LRC after the audited dependencies are unfolded. Response69’s quantitative compensation statement is non-tautological, but its proof stops exactly where destination safety and owner-indexed charge multiplicity are needed.

The strongest formal synthesis is the multiowner restriction of Response69’s compensation inequality. Response70 proves that any simultaneous full-cover obstruction would contain such a pivot. That restriction is genuinely smaller than Response69’s original all-covered-pivot statement, but neither Response68 nor Response70 supplies the missing destination-safe charge. Continuing it would merely rename the fatal Response69 arrow, which triggers the contract’s stop rule.

The three exact Markdown blobs were not available through the connected repository history or File Library. Their supplied SHA-256 values and literal line numbering therefore were not independently rehashed. The mathematical statements below were reconstructed from the frozen definitions and line-specific descriptions in this contract. Exact attribution to the immutable blob text remains conditional on those descriptions. No attachment was executed.

---

### 2. Independent claim audit

| Response/lines                  | exact reconstructed claim                                                                                      | independent verdict                | proof or least counterexample                                                                 | evidence label                                                    | dependencies                                                                |               |                                              |
| ------------------------------- | -------------------------------------------------------------------------------------------------------------- | ---------------------------------- | --------------------------------------------------------------------------------------------- | ----------------------------------------------------------------- | --------------------------------------------------------------------------- | ------------- | -------------------------------------------- |
| R68, 321–357, A1                | An admissible PrimeForcing failure has (1\le                                                                   | {i:N\mid v_i}                      | \le n-2)                                                                                      | Valid                                                             | Evaluate the full-group residue (r=p); use deletion gcd for the upper bound | `proved-math` | Full-group cover, (p\nmid v_i), deletion gcd |
| R68, 361–452, A2                | Exact CRT decomposition and (                                                                                  | B_i                                | =d_i(2\lfloor(p-1)/d_i\rfloor+1)) for (p>N)                                                   | Valid                                                             | Signed target (t), CRT, linear-congruence fiber count                       | `proved-math` | (p>N), hence ((p,N)=1)                       |
| R68, 473–485                    | CRT capacity yields a fixed nonzero determinant or finite signature divisible by (p)                           | Unsupported                        | Residue ratios vary with (p); choosing (\Delta=p) is circular                                 | `rejected`                                                        | No fixed integer quantity established                                       |               |                                              |
| R68, 493–680, A3                | Full strict bad cover of (\mathbb F_p) gives a nonzero bounded integer annihilator                             | Valid with explicit (H_n) below    | Independent tent-function proof                                                               | `proved-math`                                                     | None beyond displayed hypotheses                                            |               |                                              |
| R68, 682–732, A4                | Every fixed positive-integer LRC counterexample lies on one of finitely many bounded rational hyperplanes      | Valid                              | Apply A3 for all sufficiently large primes, stabilize (c), pass congruence to equality        | `proved-math`                                                     | A3; infinitely many primes                                                  |               |                                              |
| R68, 734–752                    | One bounded relation implies a cofinite-prime contradiction or LRC                                             | Does not follow                    | One relation is only a necessary condition; every finite-field vector has relations           | `rejected`                                                        | Would require a second independent relation or subtorus exclusion           |               |                                              |
| R70, 71–86, B1                  | Full cover at all pivots is exactly absence of every pivot certificate                                         | Valid                              | Pivot coordinate is automatically safe on (R_j)                                               | `proved-math`; canonical global equivalence remains `proved-lean` | Frozen pivot definitions                                                    |               |                                              |
| R70, 127–169, B2                | A divisor (q\mid N) absent from the pivot divides some owner; simultaneous covers force an (N)-divisible speed | Valid                              | Use (r=(N/q)a_j)                                                                              | `proved-math`                                                     | (q\ge2,\ q\mid N,\ q\nmid a_j)                                              |               |                                              |
| R70, 127–169, B2 limitation     | One (N)-divisible speed blocks the same (q=N) candidate at every non-(N)-divisible pivot                       | Valid                              | At pivot (k), (r=a_k) gives product divisible by (Na_k)                                       | `proved-math`                                                     | Existence of one (N)-divisible coordinate                                   |               |                                              |
| R70, 215–294, B3                | A single owner covers all of (R_j) iff (Na_j\mid a_i)                                                          | Valid for (n\ge2)                  | Reduction by (\gcd(a_j,a_i)), then a residue-class capacity argument                          | `proved-math`                                                     | (N=n+1\ge3)                                                                 |               |                                              |
| R70, 298–325, B4                | Simultaneous full covers force at least one pivot with no singleton owner                                      | Valid                              | Singleton owners define a finite functional graph with strictly increasing speeds             | `proved-math`                                                     | B3                                                                          |               |                                              |
| R70, 327–357, B5                | At pivot (2) of ((1,2,3,5)), three coprime owners partition (R_j) exactly                                      | Valid                              | Direct enumeration                                                                            | `proved-math`                                                     | Frozen strict boundary                                                      |               |                                              |
| R70, 541–571, B6                | Common-modulus pullback preserves each separate Fourier equation                                               | Valid                              | Normalized Fourier coefficient calculation on (L=\operatorname{lcm}M_j)                       | `proved-math`                                                     | Finite cyclic Fourier transform                                             |               |                                              |
| R70, 541–571, proposed coupling | Pullback forces independent relations, common support, rank growth, or a common prime                          | Does not follow                    | The pullback only embeds each local spectrum in its own sublattice                            | `rejected`                                                        | No coupling identity                                                        |               |                                              |
| R70, 807–812, B7                | Simultaneous-full-cover common-prime theorem is equivalent to LRC                                              | Valid logical assessment           | It implies LRC after primitive normalization; LRC implies it vacuously                        | `proved-math` equivalence; theorem itself `open`                  | B1 and scaling/normalization                                                |               |                                              |
| R69, line 5 and line 31         | `STOP`; finite evidence promotes no universal statement                                                        | Correct                            | Reported finite scan is not proof                                                             | `computed finite evidence` only                                   | None                                                                        |               |                                              |
| R69, 18–20                      | Common scaling preserves pivot membership and scales (G_j) linearly                                            | Valid                              | Reduce scaled residues modulo the original pivot modulus                                      | `proved-math`                                                     | Positive common scale                                                       |               |                                              |
| R69, 18–20                      | One-owner full cover characterization                                                                          | Valid                              | Same theorem as R70 B3                                                                        | `proved-math`                                                     | B3 proof                                                                    |               |                                              |
| R69, 18–20                      | Compensation inequality for (n=2)                                                                              | Valid                              | Singleton rigidity gives (v=3mu), then the other pivot has (G=2mu)                            | `proved-math`                                                     | B3                                                                          |               |                                              |
| R69, 382–472                    | Nearest-boundary transport produces a safe point at another pivot                                              | False as a proof rule              | ((1,3,4)) gives transported candidates excluded from the destination or bad for another owner | `rejected`                                                        | Destination safety absent                                                   |               |                                              |
| R69, around 544                 | Local tokens can be summed into the weighted compensation bound                                                | Unsupported                        | No injection into actual (Q_k), and no exact multiplicity cap                                 | `rejected` proof arrow                                            | Requires an owner-indexed safe charge                                       |               |                                              |
| R69, 24–29 and final chain      | Universal weighted compensation implies LRC                                                                    | Conditional on the open inequality | If every (G_k=0), a covered pivot would give (2a_j\le0)                                       | `conditional` theorem, `proved-math` implication                  | Universal compensation inequality                                           |               |                                              |

#### A1. Complete (N)-divisible-coordinate theorem

Let (n\ge2), (N=n+1), let (p) be prime, and let (M=Np). Let
[
v=(v_1,\ldots,v_n)\in(\mathbb Z/M\mathbb Z)^n
]
with repetitions allowed. Assume:

1. (v_i\not\equiv0\pmod p) for every (i).
2. For every deletion (k),
   [
   \gcd!\left(M,{\bar v_i:i\ne k}\right)=1,
   ]
   where (\bar v_i) are arbitrary integer representatives.
3. The full-group bad sets
   [
   B_i(v)={r\in\mathbb Z/M\mathbb Z:\rho_M(rv_i)<p}
   ]
   cover (\mathbb Z/M\mathbb Z).

Then
[
1\le#{i:N\mid v_i}\le n-2.
]

For every integer (x),
[
(px\bmod Np)=p(x\bmod N),
]
and hence
[
\rho_{Np}(px)=p,\rho_N(x).
]

The residue (r=p) is always a valid element of the full group. It satisfies (0<p<Np) for (N\ge2). This remains true when (p\mid N); neither (p>N) nor ((p,N)=1) is used.

Since the bad sets cover (r=p), some (i) satisfies
[
p\rho_N(v_i)=\rho_{Np}(pv_i)<p.
]
Thus (\rho_N(v_i)=0), so (N\mid v_i).

If at least (n-1) coordinates were (N)-divisible, delete the unique possible non-(N)-divisible coordinate, or delete any coordinate if all are divisible. Every survivor would then be divisible by (N), contradicting the deletion gcd (1). This proves the upper bound.

Consequences:

* For (n=2), the bounds would read (1\le s\le0), so no admissible PrimeForcing failure exists.
* If (p\mid N), the lower-bound conclusion (N\mid v_i) contradicts (p\nmid v_i). Thus no admissible failure exists in that case either.
* No pivot candidate restriction is used. In particular, (r=p) must not be discarded because (N\mid r).
* The conclusion concerns a prime-dependent modular tuple (v). It does not turn (v) into a fixed positive injective integer speed tuple.

#### A2. Exact CRT formula

Assume (n\ge3), (N=n+1), and (p>N) prime. Then ((p,N)=1). For a fixed coordinate (v_i), define

[
b_i=v_i\bmod p\in\mathbb F_p^\times,
\qquad
c_i=v_i\bmod N\in\mathbb Z/N\mathbb Z.
]

Let (\bar c_i\in{0,\ldots,N-1}) be the canonical representative and put
[
d_i=\gcd(N,\bar c_i).
]

Changing (\bar c_i) by a multiple of (N) leaves this gcd unchanged. If (\bar v_i) is any integer representative of (v_i), then
[
d_i=\gcd(N,\bar v_i).
]
No multiplication by (b_i^{-1}) modulo (N) is involved or permitted.

Under the CRT isomorphism
[
\mathbb Z/Np\mathbb Z\cong\mathbb Z/N\mathbb Z\times\mathbb F_p,
\qquad
r\longmapsto(x,y),
]
strict badness is equivalent to the existence of a unique integer
[
t\in{-(p-1),\ldots,p-1}
]
such that
[
c_i x\equiv t\pmod N,
\qquad
b_i y\equiv t\pmod p.
]

Therefore
[
\operatorname{CRT}(B_i)
=======================

\bigsqcup_{\substack{t\in\mathbb Z\ |t|<p\d_i\mid t}}
\left{x\in\mathbb Z/N\mathbb Z:c_i x\equiv t\pmod N\right}
\times
\left{b_i^{-1}t\right}.
]

The endpoint values (t=\pm p) are excluded because equality (\rho=p) is safe. The value (t=0) is included.

For each allowed (t), the congruence in (x) has exactly (d_i) solutions. Distinct (t)-pieces are disjoint. Indeed, equality of both CRT coordinates would give
[
t\equiv u\pmod N,\qquad t\equiv u\pmod p,
]
so (Np\mid t-u). But
[
|t-u|\le2p-2<Np,
]
forcing (t=u).

Thus
[
|B_i|
=====

d_i\left(2\left\lfloor\frac{p-1}{d_i}\right\rfloor+1\right).
]

Additional exact counts:

* A single signed-target fiber has (d_i) points.
* The column (x=0) contains exactly
  [
  2\left\lfloor\frac{p-1}{N}\right\rfloor+1
  ]
  bad points.
* If (N\mid v_i), then (d_i=N), and (B_i) is the union of
  [
  2\left\lfloor\frac{p-1}{N}\right\rfloor+1
  ]
  full CRT columns, each of size (N).

The disjointness is within one owner’s decomposition over different (t). Pieces belonging to different owners may overlap arbitrarily.

A full cover proves only the union-bound capacity inequality
[
Np
\le
\sum_{i=1}^n
d_i\left(2\left\lfloor\frac{p-1}{d_i}\right\rfloor+1\right).
]

It proves no fixed determinant, rank, signature, or integer (\Delta). The first unsupported arrow is the conversion of prime-dependent CRT ratios into a fixed nonzero integer quantity divisible by (p). Taking that quantity to be (p) is circular.

#### A3. Bounded-annihilator theorem

The exact typography of Response68 line 511 could not be checked. The following explicit theorem is independently proved and matches the constant described by the subsequent inequalities:

> For (n\ge3), (N=n+1), prime (p), and
> [
> b=(b_1,\ldots,b_n)\in(\mathbb F_p^\times)^n,
> ]
> suppose
> [
> \forall x\in\mathbb F_p\ \exists i,\qquad
> \rho_p(xb_i)<\frac pN.
> ]
> Put
> [
> H_n=2n,5^{n-1}4^n+1.
> ]
> Then there is (c\in\mathbb Z^n\setminus{0}) such that
> [
> |c|_\infty\le H_n,
> \qquad
> \sum_i c_i b_i\equiv0\pmod p.
> ]
> If (p>H_n), then (c) has support of size at least two.

Set
[
\beta=\frac12-\frac1N.
]
For (n\ge3), (\beta\ge1/4). Define the (1)-periodic tent
[
f(t)=
\max\left(0,1-\frac{|t-\frac12|}{\beta}\right),
\qquad 0\le t<1.
]

Its positive set is exactly
[
\frac1N<t<1-\frac1N.
]
It is zero at both endpoints. Consequently, strict modular badness makes the corresponding factor zero; equality at the safe boundary also makes the tent zero, which is harmless because only the forward implication is used.

The Fourier coefficients, normalized by
[
\widehat f(k)=\int_0^1 f(t)e^{-2\pi ikt},dt,
]
are
[
\widehat f(0)=\beta,
]
and for (k\ne0),
[
\widehat f(k)
=============

(-1)^k\beta
\left(\frac{\sin(\pi\beta k)}{\pi\beta k}\right)^2.
]

Hence
[
|\widehat f(k)|\le\frac4{\pi^2k^2}.
]
In particular,
[
S:=\sum_{k\in\mathbb Z}|\widehat f(k)|<5,
]
and
[
T_H:=\sum_{|k|>H}|\widehat f(k)|\le\frac2H.
]

The Fourier series is absolutely and uniformly convergent. Therefore the (n)-fold product may be expanded and averaged termwise over (\mathbb F_p). The cover hypothesis gives
[
\prod_{i=1}^n f!\left(\frac{xb_i}{p}\right)=0
\quad\text{for every }x.
]
Finite-field orthogonality then gives
[
0
=

\sum_{\substack{m\in\mathbb Z^n\
\sum_i m_i b_i\equiv0\pmod p}}
\prod_i\widehat f(m_i).
]

Suppose there were no nonzero annihilator with (|m|*\infty\le H_n). The zero-frequency contribution is (\beta^n), while every other congruence solution lies outside the cube. Thus
[
\beta^n
\le
nT*{H_n}S^{n-1}
<
\frac{2n5^{n-1}}{H_n}
<
4^{-n}
\le
\beta^n,
]
a contradiction.

If the resulting (c) had only one nonzero coordinate, then
[
c_jb_j\equiv0\pmod p.
]
Since (b_j\ne0), this forces (p\mid c_j), impossible when
[
0<|c_j|\le H_n<p.
]

#### A4. Finite bounded-hyperplane necessity

Let (a=(a_1,\ldots,a_n)) be a fixed positive injective integer counterexample at the closed threshold (1/N). Thus
[
\forall t\in\mathbb R/\mathbb Z\ \exists i,
\qquad
|ta_i|_{\mathbb R/\mathbb Z}<\frac1N.
]

For every prime
[
p>\max{H_n,a_1,\ldots,a_n},
]
put (b_i=a_i\bmod p). Then (b_i\in\mathbb F_p^\times), and sampling the obstruction at (t=x/p) gives the A3 hypothesis.

For each such prime choose
[
c(p)\in\mathbb Z^n\setminus{0},
\qquad
|c(p)|_\infty\le H_n,
\qquad
c(p)\cdot a\equiv0\pmod p.
]

There are finitely many possible (c(p)) and infinitely many eligible primes. Some fixed (c) therefore recurs for infinitely many primes. The integer (c\cdot a) is divisible by all those primes, so
[
c\cdot a=0.
]

No deletion-gcd hypothesis, PrimeForcing hypothesis, or identification with a pivot cover is used.

Because all (a_i>0), a nonzero (c) satisfying (c\cdot a=0) must contain at least one positive and at least one negative coefficient. Zero coordinates are allowed.

This is only a necessary condition. It gives no second independent relation and no exclusion theorem for the corresponding rational subtorus.

#### B2–B6 local proofs

For (q\mid N), (q\ge2), and (q\nmid a_j), define
[
r=\frac Nq,a_j.
]
Then (r\in R_j), and for (i\ne j),
[
\rho_{Na_j}(ra_i)
=================

a_j,\rho_N!\left(\frac Nq a_i\right).
]
This is (<a_j) exactly when (q\mid a_i). Hence a full cover at (j) forces such an owner.

For singleton rigidity, let (p=a_j), (q=a_i), (g=(p,q)), (p=gp'), (q=gq'). Scaling reduces the badness test to modulus (Np') with ((p',q')=1). If (p'>1), the (p') candidates
[
r_k=1+kN,\qquad 0\le k<p',
]
give (p') distinct product residues, all in one residue class modulo (N). A strict bad arc contains at most
[
\left\lfloor\frac{2p'-2}{N}\right\rfloor+1<p'
]
integers in that class because (N\ge3). Therefore (p'=1), so (p\mid q). Testing (r=1) then forces (N\mid q/p), hence (Np\mid q). The converse is immediate.

If every full pivot had a singleton owner (f(j)), singleton rigidity would give
[
a_{f(j)}\ge Na_j>a_j.
]
A finite functional graph contains a directed cycle, contradicting strict increase around the cycle. Thus simultaneous full covers contain a multiowner pivot.

For a common modulus (L), let (M_j\mid L), let (f_j) be a function on (\mathbb Z/M_j\mathbb Z), and set (F_j=f_j\circ\pi_j). With normalized Fourier transforms,
[
\widehat F_j(m)=0
\quad\text{unless}\quad
\frac L{M_j}\mid m,
]
and if (m=(L/M_j)k), then
[
\widehat F_j(m)=\widehat f_j(k).
]
This embeds each local spectrum separately. It supplies no relation between two different (j)’s.

#### Response69 exact surviving content

Let
[
Q_k(a)=R_k\setminus\bigcup_{i\ne k}B_i^k,
\qquad
G_k(a)=|Q_k(a)|.
]
The proposed compensation theorem is
[
\operatorname{FullCover}*j(a)
\Longrightarrow
2a_j
\le
\sum*{k\ne j}
\frac{a_k}{\gcd(a_j,a_k)}G_k(a).
\tag{WC}
]

For a common scale (d\ge1),
[
G_k(da)=dG_k(a),
]
and
[
\frac{da_k}{\gcd(da_j,da_k)}
============================

\frac{a_k}{\gcd(a_j,a_k)}.
]
This follows because reduction modulo (Na_k) gives exactly (d) lifts in the scaled modulus, with candidate membership and every badness relation preserved. The inspected Response69 artifact records these scaling checks and the exact finite scan domain. 

For (n=2), (N=3). If the pivot (u) is covered by the sole owner (v), singleton rigidity gives
[
v=3mu.
]
At the (v)-pivot, the safe residues form the interval from (3mu) through (6mu), with multiples of (3) removed, giving
[
G_v=2mu.
]
The right side of (WC) is
[
\frac v{\gcd(u,v)}G_v
=====================

# 3m\cdot2mu

6m^2u
\ge2u.
]

The nearest-boundary and token constructions fail because preserving one centered congruence does not establish that the destination:

1. lies in (R_k), rather than being (N)-divisible;
2. is safe for every nonpivot owner at (k); or
3. is available with the multiplicity assumed by the charge sum.

The finite audit inspected for Response69 covers primitive strictly increasing tuples of lengths (2) through (6), largest speed at most (12), totaling (2{,}429) tuples and (806) covered pivot rows, with no compensation violation. This remains `computed finite evidence`. 

---

### 3. Pairwise implication matrix

For the comparison, define the three response-level missing targets as follows.

* (F_{68}), **bounded-hyperplane exclusion**: for every bounded mixed-sign (c) supplied by A4, every positive injective (a) with (c\cdot a=0) has a pivot certificate.
* (F_{69}), **weighted compensation**: theorem (WC) for every covered pivot.
* (F_{70}), **common-prime selector**: every simultaneous-full-cover tuple has a prime dividing every coordinate, either directly or after the stated primitive formulation.

The earlier Response68 route-local inference
[
\text{CRT capacity}\Longrightarrow\text{fixed determinant divisible by }p
]
is already `rejected` and is not a coherent global lemma for implication comparison.

| ordered pair       | result    | reason                                                                                                                  |
| ------------------ | --------- | ----------------------------------------------------------------------------------------------------------------------- |
| (F_{68}\to F_{69}) | `unknown` | Hyperplane exclusion gives LRC, but LRC does not supply a quantitative inequality for tuples with only some full pivots |
| (F_{68}\to F_{70}) | `implies` | (F_{68}) plus A4 gives LRC; LRC makes the simultaneous-cover antecedent impossible                                      |
| (F_{69}\to F_{68}) | `implies` | (F_{69}) gives LRC; LRC gives certificates on every bounded hyperplane                                                  |
| (F_{69}\to F_{70}) | `implies` | (F_{69}) gives LRC, hence (F_{70}) vacuously                                                                            |
| (F_{70}\to F_{68}) | `implies` | (F_{70}) gives LRC after primitive normalization; LRC gives (F_{68})                                                    |
| (F_{70}\to F_{69}) | `unknown` | Common-prime exclusion says nothing quantitative about partially covered tuples                                         |

#### Pair ((68,69))

1. **Logical identity:** No. A bounded hyperplane exclusion is a certificate theorem on an algebraic subvariety. Weighted compensation is an inequality for every individually covered pivot.
2. **Implication:** (F_{69}) implies (F_{68}) through LRC. The reverse is unknown.
3. **Shared prerequisite:** for (n\ge3),
   [
   \forall a,
   \left[
   \bigl(\forall j,\operatorname{FullCover}*j(a)\bigr)
   \Longrightarrow
   \exists c\ne0,\
   |c|*\infty\le H_n,\
   c\cdot a=0,\
   c\text{ mixed-sign}
   \right].
   ]
   This follows from B1 and A4.
4. **Equivalent bridge:** The collective (F_{68}) scheme is equivalent to LRC. (F_{69}) is not known to be equivalent because it also constrains partial-cover tuples.
5. **Local closure:** Response68 supplies no destination-safety fact for Response69. Response69 supplies no second relation or subtorus exclusion for Response68.
6. **Counterexample:** ((1,3,4)) decisively stops the proposed nearest-boundary transport, but does not refute (WC).

#### Pair ((68,70))

1. **Logical identity:** No syntactically, but the collective statements are equivalent through accepted dependencies.
2. **Implication:** Both directions hold through LRC.
3. **Shared prerequisite:** the quantified bounded-relation consequence displayed above. Response70 adds
   [
   \forall a,
   \left[
   \bigl(\forall j,\operatorname{FullCover}_j(a)\bigr)
   \Longrightarrow
   \exists i,\ N\mid a_i
   \right]
   ]
   and
   [
   \forall a,
   \left[
   \bigl(\forall j,\operatorname{FullCover}_j(a)\bigr)
   \Longrightarrow
   \exists j\ \forall i\ne j,\ B_i^j\ne R_j
   \right].
   ]
4. **Equivalent bridges:** Both the collective bounded-hyperplane exclusion and the common-prime theorem are equivalent to LRC.
5. **Local closure:** A3/A4 give one bounded relation but do not produce a common prime. B2/B4 restrict hypothetical counterexamples but do not exclude any surviving rational subtorus.
6. **Counterexamples:** ((1,2,3,5)) rejects private-point-to-gcd propagation; ((1,3,4,5,7,18)) rejects “full pivot implies a nonunit owner”; the all-but-one family rejects “(n-1) full pivots imply a common prime.”

#### Pair ((69,70))

1. **Logical identity:** No. Response69 requires safe destinations with quantitative multiplicity. Response70 requires global divisibility or rank coupling.
2. **Implication:** (F_{69}) implies (F_{70}) through LRC. The reverse is unknown.
3. **Shared weaker prerequisite:** B4:
   [
   \forall n\ge2\ \forall a>0,\qquad
   \left(\forall j,\operatorname{FullCover}_j(a)\right)
   \Longrightarrow
   \exists j,
   \left[
   \operatorname{FullCover}_j(a)
   \land
   \forall i\ne j,\ B_i^j\ne R_j
   \right].
   ]
4. **Equivalent bridge:** (F_{70}) is equivalent to LRC. Response69’s full quantitative theorem is not known to be.
5. **Local closure:** B3 closes Response69’s one-owner characterization. B4 reduces the LRC implication of Response69 to the multiowner case:
   [
   \operatorname{FullCover}_j(a)
   \land
   \forall i\ne j,\ B_i^j\ne R_j
   \Longrightarrow
   \text{(WC at (j))}.
   ]
   No Response70 theorem proves that inequality.
6. **Counterexamples:** The pivot-(2) partition of ((1,2,3,5)) shows that private points and coprimality do not give safe charge destinations. The all-but-one family shows that almost-complete pivot coverage does not give global divisibility.

Response69 and Response70 therefore share more than a verbal resemblance, but not the same missing lemma. An exact Response69 coupling would be an injection
[
{0,\ldots,2a_j-1}
\hookrightarrow
\bigsqcup_{k\ne j}
\left(
Q_k(a)\times
\left{1,\ldots,\frac{a_k}{\gcd(a_j,a_k)}\right}
\right),
]
constructed from the source cover with every image residue actually in (Q_k). Response70 instead needs a divisibility selector or a rank statement forcing a common prime from all pivot covers. Neither private points nor pulled-back Fourier support supplies either conclusion.

---

### 4. Anti-tautology audit

For fixed (n\ge3), define
[
\mathcal C_n=
\left{
c\in\mathbb Z^n:
c\ne0,\
|c|_\infty\le H_n,\
c\text{ has both positive and negative coefficients}
\right}.
]

Let (\operatorname{Cert}(a)) mean that (a) has a pivot certificate.

The collective fixed-hyperplane scheme is
[
\forall c\in\mathcal C_n\ \forall a,\qquad
\left[
a\text{ positive and injective}
\land c\cdot a=0
\right]
\Longrightarrow
\operatorname{Cert}(a).
\tag{FH}
]

A4 proves
[
\neg\operatorname{Cert}(a)
\Longrightarrow
\exists c\in\mathcal C_n,\ c\cdot a=0.
\tag{A4}
]

Therefore:

* LRC implies (FH), because LRC certifies every positive injective tuple.
* (FH) plus A4 implies LRC, because any counterexample would lie on one of the hyperplanes covered by (FH).

Thus the finite conjunction (FH) is a **literal equivalent reformulation of LRC**, conditional only on the independently proved A4 theorem. Restricting (c) to mixed signs or support at least two does not weaken this equivalence, because A4 already supplies those properties.

Each individual fixed-(c) theorem is a restricted subproblem and does not by itself close LRC. The finite family as a whole does.

#### Common-prime theorem

Let
[
\operatorname{CP}_n:
\quad
\forall a,\qquad
\left[
a\text{ positive and injective}
\land
\forall j,\operatorname{FullCover}_j(a)
\right]
\Longrightarrow
\exists\text{ prime }q\ \forall i,\ q\mid a_i.
]

After dividing an alleged obstruction by its global gcd, scaling invariance preserves all full covers. The resulting tuple is primitive, so (\operatorname{CP}_n) gives a contradiction. Hence (\operatorname{CP}_n) implies LRC.

Conversely, LRC makes the simultaneous-full-cover antecedent false. Hence LRC implies (\operatorname{CP}_n) vacuously.

Therefore (\operatorname{CP}_n) is also equivalent to LRC.

#### Extra restrictions supplied by Response70

Response70 does provide independently valid restrictions on a hypothetical primitive counterexample:

1. At least one coordinate is divisible by (N).
2. Not all coordinates are divisible by (N), by primitivity.
3. At least one full pivot is genuinely multiowner.

The first restriction is meaningful only in the primitive formulation. Without primitivity, scaling an arbitrary tuple by (N) makes every coordinate (N)-divisible while preserving the pivot-cover pattern.

These restrictions rule out nonempty classes of arbitrary hyperplane instances. For example, ((1,2,3)) lies on
[
a_1+a_2-a_3=0
]
but, with (N=4), has no (N)-divisible coordinate.

The sharpest non-tautological synthesis is therefore the multiowner compensation core:
[
\begin{aligned}
\forall n\ge3\ \forall a\ \forall j,\quad
& a\text{ positive and injective},\
&\operatorname{FullCover}*j(a),\
&\forall i\ne j,\ B_i^j\ne R_j
[2mm]
&\Longrightarrow
2a_j\le
\sum*{k\ne j}
\frac{a_k}{\gcd(a_j,a_k)}G_k(a).
\end{aligned}
\tag{MC}
]

B4 plus (MC) would imply LRC: under simultaneous full covers, choose the guaranteed multiowner pivot; every (G_k=0), contradicting (2a_j\le0).

Unlike the common-prime theorem and collective hyperplane scheme, (MC) does not become vacuous after unfolding. Tuples such as ((1,2,3,5)) have a multiowner full pivot and certificates at other pivots, so LRC does not simply erase its premise.

Nevertheless, (MC) is not a qualifying positive deliverable. Its only known proof route is the Response69 safe-charge construction, and the first required arrow is precisely the rejected destination-safety assertion. Response68’s bounded relation and Response70’s divisor/private-point data do not repair that arrow. Under the stop rule, restating (MC) as a new research cell would only rename the unresolved charge law.

#### Mandatory proposed assertions

* **Bounded relation forces a singleton cover:** false.
  ((1,2,3)) satisfies (1+2-3=0) and has no full pivot.
* **Bounded relation forces a common prime in a multiowner cover:** false.
  ((1,2,3,5)) satisfies (1+2-3=0), while its pivot-(2) cover is multiowner and all three owners are coprime to (2).
* **Bounded relation supplies Response69 destination safety:** false as an inference.
  ((1,3,4)) lies on (1+3-4=0), yet the nearest-boundary transport fails.
* **Two pivot-local Fourier relations are automatically independent:** rejected.
  The annihilator supplied by A3 is existential and noncanonical. Even two displayed relations may be scalar multiples, such as (c) and (-c). The common-modulus pullback adds no independence condition.
* **Deletion minimality supplies a second stabilized integer relation:** unsupported.
  It is a property of a prime-dependent modular cover and does not stabilize a second relation across primes.
* **A fixed hyperplane excludes simultaneous full covers:** this is exactly the corresponding member of (FH), not an audited consequence.
* **A fixed bounded relation makes a prime divide a fixed nonzero determinant:** rejected.
  One congruence is not a determinant and every finite-field vector already has nonzero annihilators.

---

### 5. Falsification results

#### 5.1 ((1,2,3,5)), exact pivot-(2) partition

Here (n=4), (N=5), (p=2), (M=10), and
[
R_2={1,2,3,4,6,7,8,9}.
]

The three nonpivot bad sets are
[
B_1^2={1,9},
]
[
B_3^2={3,7},
]
[
B_5^2={2,4,6,8}.
]

They are pairwise disjoint and their union is (R_2). Every owner is coprime to the pivot:
[
(1,2)=(3,2)=(5,2)=1.
]

The pivot good counts are
[
(G_1,G_2,G_3,G_5)=(0,0,2,2),
]
with
[
Q_3={4,11},
\qquad
Q_5={6,19}.
]

This is a theorem-domain counterexample to:

* private point (\Rightarrow) owner/pivot common divisor;
* multiowner full cover (\Rightarrow) a nonunit owner;
* a small mixed-sign relation (\Rightarrow) obstruction.

It is not an LRC counterexample.

#### 5.2 ((1,2,3,4,5,7))

Here (n=6), (N=7), and
[
\gcd(1,2,3,4,5,7)=1.
]

The exact good counts are
[
(G_1,G_2,G_3,G_4,G_5,G_7)
=========================

(0,0,0,0,2,2).
]

The nonempty good sets are
[
Q_5={6,29},
\qquad
Q_7={8,41}.
]

Thus four pivots are full, but the tuple is primitive and has certificates at two pivots. This decisively rejects “(n-1) or nearly all full pivots force a common prime.”

The exact counts and strict-boundary fixtures are also recorded by the inspected Response70 audit. 

#### 5.3 ((1,3,4,5,7,18)), full unit-owner pivot

At pivot (7), (N=7), (M=49), and every nonpivot speed is a unit modulo (49):
[
\gcd(1,49)=\gcd(3,49)=\gcd(4,49)=\gcd(5,49)=\gcd(18,49)=1.
]

The bad sets are

[
B_1^7=
{1,2,3,4,5,6,43,44,45,46,47,48},
]

[
B_3^7=
{1,2,15,16,17,18,31,32,33,34,47,48},
]

[
B_4^7=
{1,11,12,13,23,24,25,26,36,37,38,48},
]

[
B_5^7=
{1,9,10,11,19,20,29,30,38,39,40,48},
]

[
B_{18}^7=
{3,8,11,16,19,22,27,30,33,38,41,46}.
]

Their union is all of (R_7), so (G_7=0). The full good-count vector is
[
(0,0,2,2,0,4).
]

This is a theorem-domain counterexample to “a full pivot contains a nonunit owner.” The inspected Response70 artifact reports the same unit checks and bad sets. 

#### 5.4 ((4,5,9)), mass equality with gaps

At pivot (4), (N=4), (M=16),
[
R_4={1,2,3,5,6,7,9,10,11,13,14,15}.
]

The two bad sets are
[
B_5^4={3,6,7,9,10,13},
]
[
B_9^4={2,5,7,9,11,14}.
]

Each has size (6), so the sum of the first bad-set masses is
[
6+6=12=|R_4|.
]
But
[
B_5^4\cap B_9^4={7,9},
]
and therefore
[
Q_4={1,15}.
]

The other exact good sets are
[
Q_5={3,17},
\qquad
Q_9={3,5,31,33}.
]

Hence
[
(G_4,G_5,G_9)=(2,2,4).
]

This rejects any argument that replaces union coverage by equality of total bad-set mass.

#### 5.5 ((1,3,4)), nearest-boundary failure

Here (n=3), (N=4). The exact pivot data are:

At pivot (1),
[
R_1={1,2,3},
\qquad
B_3^1=\varnothing,
\qquad
B_4^1={1,2,3},
\qquad
Q_1=\varnothing.
]

At pivot (3),
[
B_1^3={1,2,10,11},
\qquad
B_4^3={3,6,9},
\qquad
Q_3={5,7}.
]

At pivot (4),
[
B_1^4={1,2,3,13,14,15},
]
[
B_3^4={1,5,6,10,11,15},
\qquad
Q_4={7,9}.
]

Thus
[
(G_1,G_3,G_4)=(0,2,2).
]

The tuple satisfies the small relation
[
1+3-4=0,
]
but that relation does not make the reported nearest-boundary destination safe. This is a counterexample to the proposed transport rule, not to the weighted compensation inequality.

Related elimination records explicitly show both possible failures: a quotient can leave the destination candidate set, and transported badness can fail to match the destination owner structure. 

#### 5.6 Response70 all-but-one family

For every (n\ge2), put
[
N=n+1,
\qquad
\Lambda=\operatorname{lcm}(1,\ldots,n-1),
\qquad
L=N\Lambda,
]
and take
[
a=(1,2,\ldots,n-1,L).
]

For a pivot (k\in{1,\ldots,n-1}),
[
Nk\mid L.
]
By singleton rigidity, the owner (L) covers all of (R_k). Thus the first (n-1) pivots are full.

At the last pivot (L), take
[
r=L+1.
]
Because (N\mid L),
[
r\equiv1\pmod N,
]
so (r\in R_L).

For every owner (1\le k\le n-1=N-2),
[
rk=kL+k\ge L,
]
and
[
NL-(kL+k)=(N-k)L-k\ge L.
]
Therefore
[
\rho_{NL}(rk)\ge L.
]
Hence (r\in Q_L).

The tuple is primitive because it contains (1). Thus exactly the first (n-1) pivots are full, while the last has a certificate. The inspected audit checked numerical members through (n=10), but the argument above proves the family for every (n\ge2). 

#### 5.7 Small mixed-sign hyperplane with certificates

Take
[
a=(1,2,3),
\qquad
c=(1,1,-1).
]
Then
[
c\cdot a=1+2-3=0.
]

Here (N=4), and
[
Q_1={1,3},
\qquad
Q_2={2,6},
\qquad
Q_3={3,9}.
]

In particular, at the (3)-pivot and (r=3),
[
\rho_{12}(3\cdot1)=3,
]
which is safe because equality is not bad.

This shows that a small mixed-sign relation alone does not encode obstruction.

#### 5.8 Boundary cases

* **(n=1):** For (a=(1)), (N=2), (R_1={1}), and there are no nonpivot owners. Thus (G_1=1).
* **(n=2):** For ((1,3)),
  [
  (G_1,G_3)=(0,2),
  \qquad
  Q_3={4,5}.
  ]
  The pivot (1) is singleton-covered because (3=Na_1).
* **(\rho=p-1):** Strictly bad.
* **(\rho=p):** Safe.
* For (N=4,p=3,M=12), owner speed (1):
  [
  \rho_{12}(2)=2=p-1<3,
  ]
  while
  [
  \rho_{12}(3)=3=p.
  ]
* At (N=2), the antipode (r=p) satisfies (\rho_{2p}(p)=p), is reflection-fixed, and is a pivot candidate when (p) is odd.

These boundary conventions are also explicitly asserted by the inspected finite audit. 

#### 5.9 Computation boundary

The Response69 artifact reports no violation of (WC) among:

* primitive strictly increasing tuples;
* (2\le n\le6);
* largest speed at most (12);
* (2{,}429) tuples;
* (806) covered pivot rows.

This is `computed finite evidence`, not a universal proof. 

The Response70 artifact reports no simultaneous-full-cover tuple among primitive strictly increasing tuples with largest speed at most (12) for (3\le n\le6), totaling (2{,}384) tuples. This is also `computed finite evidence`. 

Separate PrimeForcing verifiers report modular failure tuples ((1,3,4)) for (n=3,p=5) and ((1,3,4,5)) for (n=4,p=7), while the declared (n=4) scans at (p=2,3,5) had no failures. Those are full-group modular tuples with repetitions allowed in the search domain, not pivot-cover counterexamples and not fixed positive-integer LRC counterexamples. 

---

### 6. Sole surviving lemma or STOP certificate

**STOP**

The two obvious global syntheses fail the anti-tautology test:

1. The collective bounded-hyperplane exclusion scheme is equivalent to LRC by A4.
2. The simultaneous-full-cover common-prime theorem is equivalent to LRC by B1 and primitive normalization.

The only exact non-tautological narrowing produced by combining Responses69 and 70 is the multiowner compensation core (MC). B4 proves that (MC) would suffice for LRC, and it excludes the already classified singleton-cover case.

Its first unresolved proof obligation is the following exact selection problem. For every multiowner full pivot (j), construct from the owner-indexed cover data an injection
[
\Phi_j:
{0,\ldots,2a_j-1}
\hookrightarrow
\bigsqcup_{k\ne j}
\left(
Q_k(a)\times
\left{1,\ldots,\frac{a_k}{\gcd(a_j,a_k)}\right}
\right).
]

Every image ((k,s,u)) must satisfy:

* (s\in R_k);
* (s\notin B_\ell^k) for every (\ell\ne k);
* owner labels remain distinct when coincident modular bad sets occur;
* no destination slot is used twice.

Response69 proves none of these destination conditions for its proposed nearest-boundary map. Response70’s private points, divisor forcing, singleton rigidity, and Fourier pullback provide no replacement. The pivot-(2) partition of ((1,2,3,5)) rules out deriving the needed map from private-point gcd data, and ((1,3,4)) rules out the nearest-boundary transport.

Thus the first fatal arrow is:

[
\text{source full-cover token or private point}
\quad\Longrightarrow\quad
\text{an actually safe destination in some }Q_k.
]

No audited theorem establishes it. Restating it as “cross-pivot coupling,” “charge conservation,” “exchange,” or “rank transfer” would not alter the obligation.

No sole surviving lemma is promoted.

---

### 7. Proof-obligation ledger

| ID   | exact statement                                                  | source/dependency    | status                                      | evidence                                | first open arrow                        | falsification                                     | implication to unrestricted LRC           | recommended next owner                 |
| ---- | ---------------------------------------------------------------- | -------------------- | ------------------------------------------- | --------------------------------------- | --------------------------------------- | ------------------------------------------------- | ----------------------------------------- | -------------------------------------- |
| A1   | PrimeForcing failure implies (1\le#{i:N\mid v_i}\le n-2)         | R68 A1               | `proved-math`                               | Direct (r=p) proof                      | None                                    | (n=2) makes failure impossible                    | None by itself                            | Sol Medium declaration specification   |
| A2   | Exact CRT decomposition and cardinality formula                  | R68 A2               | `proved-math`                               | Independent CRT proof                   | None                                    | No failure found in premises                      | None by itself                            | Sol Medium declaration specification   |
| A2-Δ | CRT capacity gives fixed nonzero determinant/signature           | R68 after A2         | `rejected`                                  | Ratios remain (p)-dependent             | A fixed integer (\Delta)                | Choosing (\Delta=p) is circular                   | Would have supported cofinite forcing     | Stop                                   |
| A3   | Full finite-field bad cover gives bounded annihilator with (H_n) | R68 A3               | `proved-math`                               | Complete tent/Fourier proof             | Exact original line-511 typography only | None                                              | Necessary condition only                  | Sol Medium theorem formalization       |
| A4   | Fixed counterexample lies on a bounded mixed-sign hyperplane     | A3                   | `proved-math`                               | Infinite-prime stabilization            | Exclusion of each surviving hyperplane  | ((1,2,3)) shows relation alone is harmless        | Collective exclusion is equivalent to LRC | Formalize locally; freeze global route |
| B1   | Simultaneous full cover iff no pivot certificate                 | Frozen definitions   | `proved-math`; global wrapper `proved-lean` | Pivot-coordinate identity               | None                                    | None                                              | Exact obstruction equivalence             | Existing repository owner              |
| B2   | Divisor forcing and existence of an (N)-divisible coordinate     | R70                  | `proved-math`                               | Candidate (r=(N/q)a_j)                  | Propagation beyond one owner            | One (N)-divisible speed blocks all coarse tests   | Restricts counterexamples only            | Sol Medium local declaration           |
| B3   | (B_i^j=R_j\iff Na_j\mid a_i)                                     | R70                  | `proved-math`                               | Residue-class capacity proof            | None                                    | Exact fixtures agree                              | Solves singleton case only                | Sol Medium local declaration           |
| B4   | Simultaneous covers force a multiowner pivot                     | B3                   | `proved-math`                               | Strict-growth functional graph          | Quantitative use of multiowner cover    | None                                              | Reduces compensation route to (MC)        | Sol Medium local declaration           |
| B5   | ((1,2,3,5)) pivot-(2) exact coprime partition                    | R70                  | `proved-math`                               | Hand enumeration                        | None                                    | Refutes private-point gcd propagation             | Prevents claimed common-prime proof       | Freeze as regression theorem           |
| B6   | Common-modulus pullback formula                                  | R70                  | `proved-math`                               | Direct Fourier calculation              | Any equation coupling different pivots  | Separate spectra may coincide or remain dependent | None by itself                            | Sol Medium local declaration           |
| B7   | Common-prime theorem is equivalent to LRC                        | B1 and normalization | `proved-math` equivalence; theorem `open`   | Two-direction logical proof             | Proof of LRC itself                     | Local propagation claims refuted                  | Exactly equivalent                        | Stop route                             |
| C1   | (G_k(da)=dG_k(a)), weights invariant                             | R69                  | `proved-math`                               | Direct scaling proof                    | None                                    | Exact fixtures agree                              | Normalization only                        | Sol Medium declaration                 |
| C2   | Weighted compensation for (n=2)                                  | B3                   | `proved-math`                               | (v=3mu), (G_v=2mu)                      | None                                    | Exact ((1,3)) boundary                            | Small dimension only                      | Sol Medium declaration                 |
| C3   | Universal weighted compensation (WC)                             | R69                  | `open`                                      | Finite scan only                        | Safe destination and multiplicity       | No finite violation in declared box               | Would imply LRC                           | Freeze                                 |
| C4   | Nearest-boundary map lands in (Q_k)                              | R69                  | `rejected`                                  | ((1,3,4))                               | Destination safety                      | Candidate exclusion and other-owner badness       | Was intended to prove C3                  | Stop                                   |
| S1   | Collective bounded-hyperplane pivot theorem                      | A4                   | `rejected` as narrower bridge               | Anti-tautology proof                    | LRC on each hyperplane                  | Relation-only assertions refuted                  | Equivalent to LRC                         | Stop                                   |
| S2   | Multiowner compensation core (MC)                                | B4 plus R69          | `open`; not promoted                        | Mandatory fixtures and finite scan pass | Exact safe-charge injection             | Existing transport mechanisms fail                | Would imply LRC                           | Freeze, no new Pro cell                |
| S3   | A second independent relation follows from deletion minimality   | Proposed synthesis   | `open` but unsupported                      | No stabilization theorem                | Cross-prime second relation             | Modular failure tuples are prime-dependent        | Could potentially narrow A4               | No owner assignment                    |
| S4   | Fixed hyperplane excludes simultaneous covers                    | Proposed synthesis   | `open`                                      | None beyond A4 necessity                | Hyperplane-specific LRC                 | No counterexample known without refuting LRC      | Finite conjunction gives LRC              | Stop as synthesis                      |

---

### 8. Recommended route disposition

| Response   | disposition | precise reason                                                                                                                                                                                                    |
| ---------- | ----------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Response68 | `continue`  | Continue only the declaration-level formalization of A1–A4. The global determinant, cofinite-prime, and collective hyperplane-exclusion routes are rejected or equivalent to LRC.                                 |
| Response69 | `freeze`    | The compensation inequality remains compatible with finite evidence, but its nearest-boundary and token-charge proofs fail before destination safety. No replacement coupling law survives.                       |
| Response70 | `stop`      | The common-prime target is equivalent to LRC, and the proposed local propagation mechanisms are decisively refuted by the partition, unit-owner, and all-but-one examples. Retain B2–B6 as local library results. |

A downstream Sol Medium declaration-level audit is worthwhile for:

* A1 with all modular domains and the (p\mid N) boundary;
* A2 with canonical representatives and strict endpoints;
* A3 with the explicit constant (H_n);
* A4 with the exact infinite-prime stabilization;
* B2, B3, B4, and B6;
* Response69’s scaling and (n=2) theorems.

That audit should first obtain the immutable response blobs and verify their supplied SHA-256 values and literal line text. It should not reopen the global proof search. No Luna novel proof search is warranted.

---

### 9. Final evidence boundary

#### Repository `proved-lean` inputs

* The canonical pivot-certificate equivalence at the frozen strict/closed boundary.
* The positive-integer normalization and common-scaling wrapper.
* The established equivalence between absence of all pivot certificates and the positive-integer LRC obstruction.

No new declaration was checked in this audit.

#### Independently established `proved-math`

* A1, including:
  [
  \rho_{Np}(px)=p\rho_N(x)
  ]
  and
  [
  1\le#{i:N\mid v_i}\le n-2.
  ]
* A2’s exact CRT set equality, disjoint signed fibers, and cardinality formula.
* A3 with
  [
  H_n=2n5^{n-1}4^n+1.
  ]
* A4’s bounded mixed-sign rational-hyperplane necessity theorem.
* B1 through B6.
* The equivalence of Response70’s common-prime theorem with LRC.
* Response69’s scaling identity, singleton characterization, (n=2) case, and the implication
  [
  \text{universal compensation}\Longrightarrow\text{LRC}.
  ]
* All explicit hand enumerations in Section 5.

#### `computed finite evidence`

* Response69 scan: (2{,}429) primitive increasing tuples, (2\le n\le6), maximum speed (12), (806) covered rows, no compensation violation. 
* Response70 scan: primitive increasing tuples, (3\le n\le6), maximum speed (12), no simultaneous-full-cover tuple. 
* PrimeForcing modular scans and reported first failures at ((n,p)=(3,5)) and ((4,7)). 
* These artifacts were inspected but not executed in this audit.

#### `conditional`

* Literal attribution of the displayed (H_n) formula to Response68 line 511, because the immutable blob was unavailable.
* The universal Response69 weighted compensation inequality.
* Any proof of the multiowner compensation core.
* Any hyperplane-specific exclusion theorem not already known independently.
* Any second-relation or rational-subtorus exclusion mechanism.

#### `rejected`

* CRT capacity (\Rightarrow) fixed determinant or finite signature.
* One bounded relation (\Rightarrow) cofinite-prime contradiction.
* Private point (\Rightarrow) owner/pivot common prime.
* (n-1) full pivots (\Rightarrow) common prime.
* Full pivot (\Rightarrow) nonunit owner.
* Nearest-boundary token (\Rightarrow) safe destination.
* Common-modulus Fourier pullback (\Rightarrow) coupled or independent annihilators.
* Bounded relation (\Rightarrow) singleton cover.
* Bounded relation alone (\Rightarrow) obstruction.
* Collective bounded-hyperplane scheme as a theorem narrower than LRC.
* Response70 common-prime theorem as a theorem narrower than LRC.

#### Remaining `open`

* Unrestricted Lonely Runner.
* Response69’s universal weighted compensation inequality.
* The multiowner compensation core.
* Any exact owner-indexed safe-charge injection proving that inequality.
* Any independently derived second bounded relation.
* Any non-tautological exclusion theorem for the surviving bounded rational subtori.
* Any cross-pivot Fourier rank or divisibility coupling stronger than the separate pullback identity.
* Exact immutable-blob provenance and line-level verification for Responses68–70.

No result here proves unrestricted LRC or promotes a prior response label merely because it appeared in a recovered response or finite computation.
