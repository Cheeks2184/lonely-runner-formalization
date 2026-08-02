# Response 43 audit

## Status

Response 43, produced in the signed-in GPT-5.6 Sol Pro conversation after
49 minutes 6 seconds, explicitly reports no proof or counterexample to LRC.
Most of it restates the accepted Response 42 Chebyshev/CRT identity, finite
searches, two-hole height theorem, divisor cover, and signed descent.

It also repeats one substantive error despite the Prompt 43 correction:
fixed-dimension primitive sum minimality does not imply
`a_n<n*a_(n-1)`. Deleting the largest speed first needs LRC in dimension
`n-1`. The residual-class theorem in Response 43 Section 4 is therefore
rejected as stated. It becomes valid only after choosing the least
counterexample dimension, or under an explicit lower-dimensional hypothesis.

No new attachments were supplied; the three linked files and hashes are the
already downloaded and reproduced Response 42 artifacts.

## Accepted new observation

The Chebyshev score certifies the following pivot class. Suppose a pivot speed
is one and no other speed is divisible by `N=n+1`. The candidates `r=1` and
`r=N-1` are both safe. For the stated Chebyshev degree,

```text
T_r(n/(n-2)) >= 2*n*N,
eta = 2/(T_r(n/(n-2))-1) <= 2/(2*n*N-1).
```

There are `n` pivot candidates, so its score is at least

```text
2 - (n-2)*eta > 0.
```

The hyperbolic identity

```text
arcosh(n/(n-2)) = 2*artanh(1/sqrt(n-1))
```

and `artanh(x)>=x` give the displayed growth estimate. The argument is
correct for `n>=3`. This class is elementary rather than a new LRC family:
the same nondivisibility hypothesis already makes `t=1/N` a direct
small-denominator witness.

## What remains open

The exact Newton/CRT score computation is noncircular, but Response 43 gives
no inequality forcing its global score—or any pivot score—to be positive for
every tuple. The reproduced finite searches do not imply uniformity. The
corrected least-dimension residual conditions remain mutually compatible.

While Response 43 ran, independent work proved the stronger computer-assisted
max-speed `n+4` theorem and extended the exact Chebyshev stress domains. Those
results are audited separately in `docs/height-n-plus-4.md` and
`docs/response42-audit.md`; they are not attributed to Response 43.
