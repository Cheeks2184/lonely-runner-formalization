# Quantitative fast-runner insertion

This is an independently checked mathematical partial result, formalized as
`LonelyRunner.fastRunnerInsertion`. Its metric and phase ingredients are
`LonelyRunner.abs_circleNorm_sub_circleNorm_le` and
`LonelyRunner.exists_small_shift_circleNorm_ge`.

Write `d(x) = ||x||_(R/Z)` for distance to the nearest integer.

## Theorem

Let `n : N`, `u : Fin n -> R`, and `V,t0 : R`. Assume:

1. `V != 0`;
2. `d(t0*u_i) >= 1/(n+1)` for every `i`;
3. `(n+1)*|u_i| <= |V|` for every `i`.

Then there is a real `t` such that

\[
 |t-t_0|\le \frac{1}{(n+2)|V|},
\]

\[
 d(tV)\ge\frac1{n+2},
 \qquad
 d(tu_i)\ge\frac1{n+2}\quad\hbox{for every }i.
\]

Thus, if `M` bounds every `|u_i|`, it is sufficient that
`|V| >= (n+1)M`. With `k=n+1` final relative speeds, the factor is `k`.
Equality is sufficient because the target boundary is closed.

## Proof

Set `delta = 1/(n+2)`. We first use the elementary phase-adjustment lemma:
for every real `x` and `0 <= delta <= 1/2`, there is an `s` with
`|s| <= delta` and `d(x+s) >= delta`.

To see this, take the fractional part `q` of `x`. If
`q in [delta,1-delta]`, use `s=0`. If `q<delta`, use `s=delta-q`; and if
`q>1-delta`, use `s=(1-delta)-q`. The adjusted fractional part is in the
closed good interval in every case.

Apply the lemma to `x=t0*V` and put `h=s/V`, `t=t0+h`. Then
`tV=t0V+s`, so the new coordinate is good and

\[
 |t-t_0|=|h|=|s|/|V|\le\delta/|V|.
\]

Distance to a closed set is one-Lipschitz, hence

\[
 d(tu_i)\ge d(t_0u_i)-|hu_i|.
\]

The speed hypothesis gives

\[
 |hu_i|=\frac{|s||u_i|}{|V|}
 \le \frac{\delta}{n+1}
 =\frac1{(n+1)(n+2)}.
\]

Consequently

\[
 d(tu_i)\ge
 \frac1{n+1}-\frac1{(n+1)(n+2)}
 =\frac1{n+2}.
\]

## Endpoint and sharpness audit

Negative `V` is harmless because the construction divides by `V` and all
estimates use `|V|`. No division by the auxiliary maximum `M` is required.
For `n=1`, `u=1`, `V=2`, and `t0=1/2`, the construction can give `t=2/3`,
where both distances equal `1/3`; this confirms that equality at the speed
factor and at the loneliness threshold must be retained.

The factor `2` is sharp for the universal fixed-witness/local lemma when
`n=1`. Let `q>=1`, `u=1`, `t0=(2q+1)/2`, and
`V=4q/(2q+1)<2`. The old coordinate is initially at distance `1/2`, while
`V*t0` is integral. Throughout the old coordinate's `1/3`-good component
`|t-t0|<=1/6`, the new distance is at most `V/6<1/3`. These ratios tend to
`2` from below. This does not say the factor is necessary for the global
two-coordinate LRC; it is sharp only for this insertion mechanism around the
given witness.
