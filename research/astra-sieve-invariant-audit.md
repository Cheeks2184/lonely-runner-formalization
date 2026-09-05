# Audit of the lifting invariant in arXiv:2604.23906v2

Status: a displayed projection equality is refuted by an exact finite example;
the complete-lift algorithm has a sufficient repaired invariant. This is neither
a counterexample to the proposition's final inclusion nor an independent
verification or disproof of the paper's finite-runner theorem. The unrestricted
canonical LRC goal remains unresolved.

Primary source: Sungkawichai and Trakulthongchai,
[Eleven, twelve, and thirteen lonely runners, version 2, 1 September 2026](https://arxiv.org/html/2604.23906v2),
read 5 September 2026. This audit concerns Definitions 2.1/2.3, Proposition 3.1,
and the lifting/projection mechanism. It does not audit every result in the paper.

## 1. Exact predicates and the disputed operation

Write

\[
X_l=\{x\in\mathbb Z/(lp):p\nmid x\}^{k},\qquad
P_l:X_l\longrightarrow X_1,
\]

and let \(I_l\) be the improper tuples. Properness means either an omission gcd
\(\gcd(l,v_1,\ldots,\widehat v_i,\ldots,v_k)>1\), or a common closed
\(1/(k+1)\) witness on the \(1/(lp)\) grid. Thus
\(J=\bigcap_{l\ge1}P_l(I_l)\). Proposition 3.1 assumes only
\(J\subseteq P_l(S)\) and filters all lifts of \(S\) by improperness.
[Definitions 2.1/2.3 and Proposition 3.1](https://arxiv.org/html/2604.23906v2).

For \(L=cl\), let \(\rho:X_L\to X_l\). The disputed step is

\[
P_L(\rho^{-1}(S)\cap I_L)
\stackrel{?}{=}P_l(S)\cap P_L(I_L).                 \tag{1}
\]

The general set-theoretic relation is only inclusion from left to right. A point
on the right can have one representative above \(S\) and a different improper
representative, with no common representative satisfying both requirements.
Membership in \(J\) supplies an improper representative at each level; it does
not make an independently chosen representative usable.

## 2. A concrete failure with the actual predicates

Take \(k=4,p=7,l=2,c=2\), so the source modulus is 14 and target modulus 28. Set

\[
E=\{2,4,6,8,10,12\}\subset\mathbb Z/14,
\qquad S=E^4.
\]

Reduction of \(E\) modulo 7 is a bijection onto \(\mathbb F_7^*\). Consequently
\(|S|=6^4=1296\), \(P_2(S)=X_1\), and the stated premise
\(J\subseteq P_2(S)\) holds without any assumption about \(J\).

Every lift of every member of \(S\) to modulus 28 has all coordinates even.
For any omitted coordinate its gcd with level 4 is at least 2. All
\(2^4\cdot1296=20736\) lifts are therefore proper, so

\[
\rho^{-1}(S)\cap I_4=\varnothing.                 \tag{2}
\]

On the other hand, \(w=(1,2,3,4)\in X_4\) is improper. Its four omission gcds
with 4 are all 1. Direct integer evaluation of all 28 times gives

\[
\max_{0\le n<28}\min_{1\le i\le4}
  \min(ni\bmod28,-ni\bmod28)=5,
\]

attained at \(n=5,11,17,23\). Hence its maximum minimum grid distance is
\(5/28<1/5\). The base point \((1,2,3,4)\bmod7\) is on the right of (1),
whereas (2) makes the left side empty. This refutes (1) even under the
proposition's stated premise.

It does **not** establish that this base point is in \(J\). Therefore it is
not a counterexample to the final assertion \(J\subseteq P_L(S')\).
Indeed the integer tuple itself has a closed witness at \(1/5\), which this
particular denominator-28 grid misses. That observation also does not decide
eventual properness of its entire base fiber.

## 3. Why arbitrary representatives demand much more

Fix any \(k\ge2\) and prime \(p\). Choose a prime \(q\ne p\). For each
\(b\in X_1\), choose its coordinatewise CRT representative \(v_b\) modulo
\(pq\) satisfying

\[
v_b\equiv b\pmod p,\qquad v_b\equiv0\pmod q.
\]

Let \(S=\{v_b:b\in X_1\}\) at level \(l=q\). Then \(P_q(S)=X_1\).
Every coordinate of every lift to level \(cq\), for every positive \(c\),
is divisible by \(q\). Since \(k-1\ge1\), every omission gcd is divisible by
\(q\), so no such lift is improper. The filtered lift is empty.

Thus the arbitrary-\(S\) lifting assertion, if valid for this \(k,p\) over
all levels and sets, forces \(J(k,p)=\varnothing\). Conversely, if \(J\) is
empty, every asserted inclusion of \(J\) is automatic. We have proved the
precise logical equivalence

\[
\begin{split}
&\text{the Proposition 3.1 lifting conclusion for all admissible }l,S,c\\
&\hspace{35mm}\Longleftrightarrow J(k,p)=\varnothing.
\end{split}                                                    \tag{3}
\]

The forward direction needs only \(l=q,c=2\); it does not exploit an identity
lift. This is an overreach diagnostic, not a known instance of nonempty \(J\).
If the general assertion were independently established for every \(k,p\),
the paper's prime-divisibility reduction, inductively, would rule out every
positive integer counterexample: its nonzero speed product cannot be divisible
by every prime. The finite product-bound version yields the same consequence.
This conditional observation supplies no missing proof of the assertion.

## 4. A sufficient invariant, with proof

All claims in this section follow directly from the predicates, without (1).
For \(l\mid L\), properness at level \(l\) survives every lift to level \(L\):

* A divisor of \(l\) and the non-omitted coordinates also divides \(L\) and
  those coordinates after adding multiples of \(lp\).
* A witness \(n/(lp)\) remains on the finer grid; changing a coordinate by a
  multiple of \(lp\) changes its phase by an integer.

Taking contrapositives gives

\[
I_L\subseteq\rho^{-1}(I_l),\qquad P_L(I_L)\subseteq P_l(I_l).    \tag{4}
\]

An exact reachable-state invariant is

\[
J\subseteq B\subseteq X_1,
\qquad S_l=I_l\cap P_l^{-1}(B).                               \tag{5}
\]

It holds initially at level 1 with \(B=X_1\) and \(S_1=I_1\).
For a complete lift followed by filtering, (4) gives the exact equality

\[
\begin{split}
S_L&=\rho^{-1}(S_l)\cap I_L\\
   &=\rho^{-1}(I_l)\cap P_L^{-1}(B)\cap I_L\\
   &=I_L\cap P_L^{-1}(B).                                    \tag{6}
\end{split}
\]

Every \(b\in J\) has an improper representative in \(I_L\), by the
definition of \(J\); (5) retains every such representative. Thus
\(J\subseteq P_L(S_L)\). No intersection-of-images identity is used.

On projecting back to level 1, set

\[
B'=P_l(S_l)=B\cap P_l(I_l).
\]

Then \(J\subseteq B'\), and (4) with source level 1 gives \(B'\subseteq I_1\).
The new state is \(S'_1=B'=I_1\cap B'\), so (5) holds again. Arbitrarily
interleaved complete lifts and complete projections preserve (5). Skipping a
proposed lift preserves the previous state and is also safe. One may also
discard a base orbit proved disjoint from \(J\) by replacing \(B\) with the
remaining base set; that separate proof is essential.

In fact (1) is valid on states of form (5), because both its sides equal
\(B\cap P_L(I_L)\), using the second inclusion in (4). The error is extending
that identity to arbitrary states with only the projected inclusion.

A weaker sufficient condition is

\[
I_l\cap P_l^{-1}(J)\subseteq S_l.                            \tag{7}
\]

Every improper target representative over \(J\) descends, by (4), to a
member of the left side of (7), so it survives the lift. This proves (7) at
the new level. Projection retains \(J\); at level 1 this is precisely (7),
since \(J\subseteq I_1\). Proper extra representatives do no harm when this
completeness condition is present. One representative per base point does
not supply it.

## 5. Algorithm repair and implementation boundary

Section 5.2 starts at \(I_1\). Its \(k=11\) diagram lifts through levels
\(2,4,8,16,48,144\); the \(k=10,12\) diagrams lift to level 8 and then
project. These are complete-lift chains, interpreted before symmetry reduction.
[Verification algorithms, Section 5.2](https://arxiv.org/html/2604.23906v2).

By (6), the first chain computes \(I_{144}\), and the other chains compute
\(P_8(I_8)\) after projection. Each contains \(J\) under the appropriate
projection. Thus their symbolic preservation argument is repaired. This
requires no arbitrary-\(S\) assertion. If states are stored as symmetry
representatives, the invariant is about their full represented orbit sets:
one must justify the initial orbit coverage, the lift enumeration modulo
symmetries, and subsequent orbit removal. It is not an invariant for an
arbitrary raw list of chosen representatives.

I also inspected the linked C++ lifting paths. The historical
[driver from the branch named `for-k-12`](https://github.com/vzsky/13-lonely-runners/blob/bd4fb465b874db1fe29b73ee3e7b3811674c00a5/main.cpp)
passes `fullRange=true` to both lift calls, enumerates through the lift helper,
and projects the surviving state. Its optional accepted/skipped lifts fit the
state-preserving operations above; `Squeeze` keeps projected supersets when it
stops. The
[historical lifting helper](https://github.com/vzsky/13-lonely-runners/blob/bd4fb465b874db1fe29b73ee3e7b3811674c00a5/src/lift.h)
constructs all coordinate children for that full-range setting, then filters
using grid coverage and omission gcds. It does not arbitrarily retain only one
lift above each base point. The pinned driver actually has active `K=10`, `P={463}`, and a configuration
using `Squeeze(2)`, `Squeeze(3)`, and `Print`; the branch name does not establish
an executed twelve-speed configuration. These are source observations, not
execution proof.

The current
[lifting helper](https://github.com/vzsky/13-lonely-runners/blob/755b116b2e6090cd4a83187a696f863388b7d746/src/lift.h)
and [strategy code](https://github.com/vzsky/13-lonely-runners/blob/755b116b2e6090cd4a83187a696f863388b7d746/src/lift_strategy.h)
likewise retain enumerated surviving children and implement projection. The
[gcd helper](https://github.com/vzsky/13-lonely-runners/blob/755b116b2e6090cd4a83187a696f863388b7d746/src/speedset.h)
uses all-but-one prefix/suffix gcds; the
[driver](https://github.com/vzsky/13-lonely-runners/blob/755b116b2e6090cd4a83187a696f863388b7d746/src/driver.h)
starts from the cover generator's result. This limited inspection supports the
repair's relevance, but does not certify initial enumeration, pruning,
symmetry reduction, compiler behavior, historical configuration, logs, or the
separate analytic deletion argument. None of the large computations was rerun.

Source byte hashes fetched on 5 September 2026, without cloning or retaining a
second source tree:

| Commit | File | SHA-256 |
| --- | --- | --- |
| `bd4fb465b874db1fe29b73ee3e7b3811674c00a5` | `main.cpp` | `d25a8d9913dbe317744296e0b920c8a2b43a723bba2dd8bacb2fd2ef65228db9` |
| same | `src/lift.h` | `41cae42a6e0d2bf9a6843ecb723e3dabd6a5d821b61f9822386942eff60a50ef` |
| `755b116b2e6090cd4a83187a696f863388b7d746` | `src/lift.h` | `77918f1dab8ef102dd3aef6997039094bcb6f940a29947832eeacb1b3f872e3e` |
| same | `src/lift_strategy.h` | `304813d865c31427a4a5aef5b63d43274cd4ac6be0f7e2cd6b75fd7572b51730` |
| same | `src/speedset.h` | `7b9a59169671bc03b29dd6ee3d450d0b5ac3729f1c4b09b8f75e7e6af078cebc` |
| same | `src/driver.h` | `c349529ef581aeb033b43b8c2f482822872ab2de3a3ac12206e2c3311ddd6788` |

## 6. Compact independent reproducer

The standard-library program below imports no project solver and uses no
floating-point arithmetic. It checks the concrete failed equality and 92
finite instances of (4)–(6), including empty base subsets, nontrivial subsets,
and projection back to level 1. These finite controls support the written
general proof; they do not replace it or decide \(J\).

```python
from functools import lru_cache
from itertools import product
from math import gcd


def project(v, modulus):
    return tuple(x % modulus for x in v)


def proper(k, p, level, v):
    if any(gcd(level, *(v[:i] + v[i + 1:])) > 1 for i in range(k)):
        return True
    modulus = p * level
    return any(
        all((k + 1) * min(n * x % modulus, -n * x % modulus) >= modulus
            for x in v)
        for n in range(modulus)
    )


S = set(product(range(2, 14, 2), repeat=4))
assert len(S) == 1296
assert {project(v, 7) for v in S} == set(product(range(1, 7), repeat=4))
lift_count = 0
for v in S:
    assert proper(4, 7, 2, v)
    for shifts in product(range(2), repeat=4):
        w = tuple(x + 14 * a for x, a in zip(v, shifts))
        assert proper(4, 7, 4, w)
        lift_count += 1
assert lift_count == 20736
w = (1, 2, 3, 4)
assert all(x % 7 for x in w)
assert [gcd(4, *(w[:i] + w[i + 1:])) for i in range(4)] == [1] * 4
assert not proper(4, 7, 4, w)
scores = [min(min(n * x % 28, -n * x % 28) for x in w) for n in range(28)]
assert max(scores) == 5
assert [n for n, score in enumerate(scores) if score == 5] == [5, 11, 17, 23]
assert project(w, 7) in {project(v, 7) for v in S}
assert all(5 * min(x % 5, -x % 5) >= 5 for x in w)  # witness 1/5


@lru_cache(None)
def improper(k, p, level):
    values = [x for x in range(p * level) if x % p]
    return frozenset(v for v in product(values, repeat=k)
                     if not proper(k, p, level, v))


checks = 0
for k, p, levels in [(2, 3, (1, 2, 4, 6, 12)), (3, 5, (1, 2, 3, 6))]:
    base = set(product(range(1, p), repeat=k))
    for level in levels:
        for target in levels:
            if target % level:
                continue
            old = improper(k, p, level)
            new = improper(k, p, target)
            assert {project(v, p * level) for v in new} <= old
            for B in [base, set(), {v for v in base if sum(v) % 2},
                      {project(v, p) for v in old}]:
                S = {v for v in old if project(v, p) in B}
                lifted = {v for v in new if project(v, p * level) in S}
                assert lifted == {v for v in new if project(v, p) in B}
                projected = {project(v, p) for v in S}
                assert projected <= improper(k, p, 1)
                assert projected == {v for v in improper(k, p, 1)
                                     if v in projected}
                checks += 1
assert checks == 92
print("passed: 1296 source representatives; 20736 proper lifts; "
      "improper w with max grid numerator 5; 92 invariant controls")
```

Run from the project root, without writing an extracted script:

`python3 -c 'from pathlib import Path; s=Path("research/astra-sieve-invariant-audit.md").read_text(); exec(s.split("```python\n",1)[1].split("```",1)[0])'`

This command and `python3 scripts/validate_workflow.py` passed. No Lean build,
cache restoration, source patch to the paper, external message, or publication
was performed by this audit.

## 7. Disposition

The projection-of-intersection step is false, with a complete finite
certificate. The universal arbitrary-state conclusion remains unproved by that
argument; this audit does not refute it. Complete reachable states satisfy a
stronger invariant that rigorously repairs the symbolic algorithm. The paper's
finite computational theorem has not been independently verified or refuted
here. No claim about an unrestricted LRC resolution follows.
