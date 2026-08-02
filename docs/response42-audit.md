# Response 42 audit: CRT Chebyshev scores and bounded height

## Status

Response 42 does not prove or disprove the Lonely Runner Conjecture. It gives
one new constructive theorem, an exact noncircular way to evaluate a
Chebyshev pivot certificate, and finite searches for that certificate. The
constructive theorem has passed independent proof review. The searches were
recompiled and their outputs reproduced byte-for-byte.

One claimed minimal-counterexample consequence was rejected: fixed-dimension
sum minimality does not imply `a_n < n * a_(n-1)`. Deleting the largest speed
and inserting a fast runner first needs the conjecture in dimension `n-1`.
The comparison is valid only for a least counterexample dimension, or under
an explicit lower-dimensional LRC hypothesis.

## 1. Exact Chebyshev CRT score

For `n >= 3`, `N=n+1`, and `r>=1`, Response 42 uses

```text
P_(n,r)(k) = (T_r((n-2k)/(n-2)) - 1)
             / (T_r(n/(n-2)) - 1).
```

It has `P(0)=1` and `P(k)<=0` for `1<=k<=n-1`. Writing it in the forward
Newton basis evaluates the score from the intersection moments
`H_0,...,H_min(r,n-1)`. Each moment is then evaluated by the previously
audited direct generalized-CRT subset formula. This computation does not use
`D_0`, a safe-residue enumeration, or the full multiplicity histogram.
Strict positivity of one pivot score is a sufficient certificate.

The identity is accepted; uniform positivity remains open. The pivot-speed-1
specialization additionally needs the strict growth condition
`T_r(n/(n-2)) > n-1`. Degree one does not suffice in general: at `n=5` and
speeds `(1,3,9,15,21)`, its exact pivot-1 score is `-3`. In any case, the
speed-1 class is already solved directly by `t=1/N`.

## 2. Exact finite searches

The C++ box scanner uses exact `cpp_int` arithmetic after selecting a degree.
It checks every strictly increasing tuple in precisely these domains:

```text
(n,max speed) = (15,20), (16,20), (17,21), (18,22), (20,24).
```

The tuple counts are respectively `15504, 4845, 5985, 7315, 10626`; `n=19`
is not scanned. Every tuple in these boxes is automatically primitive. Each
tuple has at least one pivot with positive exact score.

The mutation scanner checks exactly 4,276 deduplicated one-coordinate
replacements of `(1,...,14,210)`, with the replacement in `1..300`. Each has
some positive pivot score. It does not cover multi-coordinate mutations.

These conclusions mean only that the sufficient pivot-polynomial certificate
succeeds on the enumerated tuples. They do not say that every pivot works,
that a sum over pivots is positive, or that arbitrary real velocities are
covered. A scanner failure would reject this certificate, not disprove LRC.
The floating-point degree selector is safely separated from an integer for
the five reported dimensions, but is not an exact general degree algorithm.

The Python reference independently checks all 28 nonempty pivot/subset
intersections for `(1,2,3,5)`, compares Newton and literal scores on the
named stresses, and tests the bounded-height construction. Stress moments in
that program are obtained by literal enumeration rather than the direct CRT
routine, so their scope is recorded separately.

## 3. Two-hole bounded-height theorem

Let `N>=3`, and choose `N-1` distinct positive integer speeds from
`{1,...,N+1}`. Exactly two values `c<d` are missing. A reusable two-hole
lemma says that if

```text
N < q <= 2N,  0 < c < q,  gcd(c,q)=1,
```

and neither `c` nor `q-c` is a speed, then an inverse representative
`0<r<q` gives circular residue at least `2` for every speed. Therefore
`t=r/q` has distance at least `2/q >= 1/N`.

The two missing values always supply either an immediate reciprocal witness
or such a denominator:

- If `d=N+1`, use `1/N` when `c=N`, use `1/c` when `2c>N`, and otherwise
  choose `u congruent 1 (mod c)` in `[N+1,2N-c]`, then set `q=c+u`.
- If `d<=N`, use `1/d` when `2d>N+1`, and otherwise choose
  `u congruent 1 (mod c)` in `[N+2,2N-c]`, then set `q=c+u`.

The interval lengths guarantee the required representative, and all closed
endpoints have been checked. Consequently every distinct positive-integer
`n`-tuple with maximum at most `n+2` is lonely. Any positive-integer
counterexample would therefore have maximum at least `n+3`.

The executable audit checks all 1,530 two-hole cases for `N=4..20`; the proof
is independent of that finite test. `LonelyRunner/BoundedHeight.lean`
kernel-checks the interval selector, inverse representative, exclusion of
residues `0,+/-1`, the reusable denominator witness, all four hole cases, and
the finite-family extraction. Its final theorem covers the nontrivial range
`n>=3`; the smaller dimensions are already covered by the base-case modules.

## 4. Corrected residual counterexample restrictions

For a least counterexample dimension, followed by primitive sum minimality,
the fast-runner insertion theorem does imply

```text
a_n < n * a_(n-1).
```

In that corrected setting, divisor cover, the bounded-height theorem, the
lcm restriction, and comparable signed-descent irreducibility all apply.
They are mutually compatible and currently give no contradiction. At fixed
dimension alone, the displayed comparison and everything depending on it
must retain an explicit `LRC(n-1)` hypothesis.

The divisor-cover consequence also gives the exact necessary chain

```text
lcm(2,...,N) divides lcm(a_1,...,a_n)
                 divides product(a_1,...,a_n) <= a_n^n.
```

This is a quantitative restriction, not a solution.

## Reproduction

From the repository root under WSL:

```bash
bash scripts/audit_response42.sh
PYTHONPATH=scripts python3 -m unittest -v tests/test_response42.py
```

The shell audit recompiles both exact C++ programs and compares all three
outputs byte-for-byte with the files in `certificates/`. Independent review
also compared the downloaded attachment hashes and inspected candidate
enumeration, strict endpoints, sign normalization, and overflow behavior.

## Remaining obstruction

No arithmetic inequality is known that forces one Chebyshev pivot score to
be positive for every tuple. The constructive height theorem covers only
maximum `n+2`; extending it requires controlling more than two holes. The
corrected least-dimension restrictions do not presently conflict. These are
the three live routes returned to Sol Pro in Prompt 43.
