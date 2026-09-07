# A smaller fold forces a witness outside the closest plane

Pass74 merged through PR73 at
`6dc1d74935093041cb00e18773893f169aff9331`. Both CI jobs passed; fetched main
matched the reviewed head, three frozen source files, the verification
receipt and eleven dependencies.

For a hypothetical ordinary LRC failure minimal by count and then speed
sum, normalize a globally closest odd lift as `n=s_0*v+e`, with
`0<s_0<1` and `||e||<1`. Then `1<=n_i<=v_i`. The integer fold `w=v-2n`
satisfies `|w_i|<=v_i`, with strict inequality at every even original
speed. Mixed parity therefore gives a strictly smaller absolute speed sum.
Saturation of the original closest plane makes the fold primitive and
nonzero. Removing zeros and duplicate absolute speeds produces a genuinely
smaller positive tuple, for which minimality supplies a witness.

If the fold has no zero entries, that witness can be restored to the full
signed tuple at one common time. Every odd vector in the original real
plane has folded gauge at least the old global minimum: modulo the fold
it is an odd multiple of `n`, with unchanged pair minors and smaller gauge
denominators. Under strict original failure, every supplied witness must
therefore use an odd vector outside that plane. This does not justify
iteration or rank growth; the smaller tuple is good and its new odd vector
need not be nearest for the original speeds.

If the fold has zeros, its full raw odd residual minimum is exactly one.
Deleting those entries changes the problem. The corresponding original
speeds are half-integral at ordinary time `1/4`, but speeds divisible by
four can remain bad, and no simultaneous correction has been supplied.

An exact distance identity describes the projected nearest-coset ray, but
optimizes one time parameter freely. Folded trajectories tie both parameters
to the same time. The audit keeps that distinction in all joint-direction
and fractional-candidate calculations. Neither case yet transports a
witness to the original tuple or supplies a smaller failure.

Independent review accepted the full manuscript without corrections. Root
read both reports and checked their eight dependency bindings; administrative
receipts are in `research/astra-pass75-verification.json`. No Lean source,
mathematical program or dependency cache changed. The next investigation
uses the additional outside-plane vector's arithmetic; its unfinished
manuscript is excluded from this checkpoint. Unrestricted LRC remains open
in the project.
