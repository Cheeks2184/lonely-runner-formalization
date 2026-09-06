# The subset-gcd refinement does not close the arithmetic-only route

The project has formalized the MSS maximum-height cutoff, not the paper's
stronger subset-gcd condition. This is a manuscript scope screen of that
additional condition, with an elementary extension of an existing obstruction.
It proposes no Lean change or dependency restoration.

For N total runners and n=N-1 positive primitive integer moving speeds, define
F(v) as the sum of gcd(v_i : i in S) over all nonempty index subsets S. With
the convention gcd(empty)=0, this is the sum in Theorem A of the
[published Malikiosis--Santos--Schymura article](https://www.cambridge.org/core/journals/forum-of-mathematics-sigma/article/linearly-exponential-checking-is-enough-for-the-lonely-runner-conjecture-and-some-of-its-variants/A51A991DE89B8C9C2E2FF13FBD4501DA).
The theorem supplies the N-runner conclusion, assuming the lower-count LRC,
when F(v)>B_N, where B_N=choose(N,2)^(N-2). Equality remains on the unchecked
side. Thus a minimal-count counterexample would also need F(v)<=B_N.
The ordinary theorem does not add the shifted variant's LVP hypothesis.
Root read the published Theorem A, Corollary 2.3, Lemma 2.5 and section 3.2
on 2026-09-06. The full geometric proof is not claimed to have been formalized
or newly independently audited here.

The condition can exclude additional finite tuples: singleton terms already
give F(v)>=sum_i v_i>=max_i v_i. This does not establish a uniform mechanism.
In fact the existing consecutive-block example satisfies the stronger bound
as well, for EVERY N>=5.

Let L_N=lcm(2,...,N), and take

    v = (L_N, L_N+1, ..., L_N+N-2).

The preceding accepted report `astra-uniform-divisor-minimality.md` proves that
this family is primitive, satisfies the deletion-gcd and small-denominator
profile, all reciprocal-orbit capacity inequalities, the height cutoff, and
the stated fast-speed exclusion. It also has an explicit full witness, so it
is an obstruction to an arithmetic-only contradiction, never to LRC.

Here is the additional bound. Each nonempty subset gcd is at most max(v), so

    F(v) <= (2^(N-1)-1)(L_N+N-2)
          < 2^(N-1)(N!+N-2) = K_N.

The last comparison uses L_N<=N!, and all quantities are positive. For N=6,

    K_6 = 32*(720+4) = 23168 < 15^4 = 50625 = B_6.

For N>=6,

    (N+1)!+N-1 <= (N+1)(N!+N-2),
    K_(N+1) <= 2(N+1) K_N,
    B_(N+1) >= choose(N+1,2) B_N >= 2(N+1) B_N.

The first inequality reduces to N^2-2N-1>=0. The first B inequality follows
from monotonicity of choose(N,2) in the expression
choose(N+1,2)^(N-1); the second uses N>=4. Induction gives K_N<B_N for every
N>=6, so in particular F(v)<B_N throughout this range.

For N=5 the tuple is (60,61,62,63). Its singleton gcds sum to 246, its six
pair gcds are (1,2,3,1,1,1), its four triple gcds are all 1, and the full gcd
is 1. Therefore F(v)=246+9+4+1=260<1000=B_5. This completes the arbitrary-N
argument without a search or extrapolation from sampled counts.

The stronger necessary subset-gcd bound therefore leaves the existing uniform
arithmetic obstruction intact. Implementing the full published refinement
might further reduce a finite family, but is not justified as a way to solve
the current arbitrary-N supply gap. Its geometric infrastructure is absent
from the current coordinate cutoff implementation. The elementary comparison
above is easy ordered arithmetic to formalize if subsequently needed; doing
so alone would not advance the canonical completion gate. Independent review
of this exact scope and new family bound remains pending.
