# Thirty-seventh Astra checkpoint: exact box certificates

This checkpoint proves soundness of rational-margin certificates for natural
speed boxes and finite trees of derived splits. Its two-leaf pilot covers the
stated twelve-row region. It does not supply a certificate for every normalized
five-runner tuple or settle unrestricted LRC.

## Leaf and partition contracts

A box has coordinate bounds `lo` and `hi`. A leaf stores positive natural
`p,q` and a natural band index `k_i` for each coordinate. For margin `A_i/B_i`,
it checks positive denominators and the additive natural inequalities

```text
B_i*k_i*q + A_i*q <= B_i*p*lo_i
B_i*p*hi_i + A_i*q <= B_i*(k_i+1)*q.
```

These inequalities imply the original closed circle margins at the same
positive time `p/q` for every row contained in the box. The proof uses a
closed integer band, so zero-margin integer upper endpoints are valid even
when the band index differs from the actual floor. Zero speeds, repeated
speeds and zero margins remain permitted. No extra half-margin premise is
needed: it follows from the inequalities for each contained row.

A split at coordinate `i` and natural cut `c` derives its children by setting
the left upper bound to `c` and the right lower bound to `c+1`. The checker
requires `lo_i<=c<hi_i` and both children to pass. Natural discreteness places
every parent row in a child, and structural induction selects a passing leaf.
Thus the tree yields a positive rational witness for each contained row;
different leaves may use different times. Children cannot name unrelated
bounds or omit a branch. The public checker also requires a well-formed root;
raw leaf soundness retains its valid vacuous scope on empty boxes. `Fin 0`
is allowed and its acceptance proof uses no axioms.

## The fixed pilot

The root is `(2,3,5,6)..(3,4,5,8)` with margins
`(1/5,1/5,1/5,1/4)`. Splitting the last coordinate at 7 gives:

| Last speed | Time | Band indices |
| --- | --- | --- |
| 6 or 7 | 1/10 | (0,0,0,0) |
| 8 | 5/32 | (0,0,0,1) |

The first lower fifth and the second leaf's fastest quarter include equality.
Named theorems prove acceptance, the two-leaf count, and positive witnesses
for every contained row. The root has `2*2*1*3=12` rows by multiplication;
no tuple enumeration or certificate discovery is involved. Controls reject
an unsplit candidate that fails at the highest speed, invalid cuts, a failing
child, wrong bands, zero time/denominators, and above-half margins. They also
check both split boundaries, repeated coordinates, zero margins, empty raw
versus public boxes, and the empty index type.

## Verification and measured limits

The full source build passed with 3,651 jobs, including cached targets.
The trust audit accepted 497 axiom-dependency reports. Two declarations
explicitly report no axioms: the existing `normalizedBadCount` and the new
`Fin 0` control. The permitted dependency set
remains `propext`, `Classical.choice`, and `Quot.sound`.

The whole pilot source, including its acceptance, soundness applications and
controls, is 5,646 bytes. It has two certificate leaves. The root replay of
the complete guarded resource command passed in 1.87 seconds with a GNU-time
peak of 3,311,716 KiB. The online monitor sampled the sum of descendant RSS
at 4,109,700 KiB and would kill the process group after a sampled breach.
These are different measurements; both passed the 4 GiB gate. The whole-check
time cap is 60 seconds, with 256 leaves and 64 KiB of explicit data allowed.
Bounding the entire source by 64 KiB is stronger than bounding only its data.

This establishes a small working certificate mechanism. It does not predict
compression or runtime for a certificate covering the full five-runner domain.
The mathematical plan and its independent review passed guarded root replays.
Final independent source review and guarded root replay passed 21 kernel
examples, 11 permitted-dependency reports, one axiom-free control and
14 source/report/dependency guards. No source correction was required.

See the [plan](../research/astra-rational-margin-box-pilot-plan.md),
[plan review](../research/astra-rational-margin-box-pilot-plan-review.md),
[implementation and complete resource command](../research/astra-rational-margin-box-pilot-implementation.md),
and [verification record](../research/astra-pass37-verification.json).

The [final source review](../research/astra-rational-margin-box-formal-review.md)
preserves its exact probe and source hashes.
