# Pass 85: divisor replacements and the count obstruction

This pass checks whether a deleted speed with no individually primitive
attained collision can be replaced by several proper divisors. The replacement
preserves coverage of the whole time circle. It increases the number of speeds,
however, and does not establish failure at the enlarged family's native LRC
margin. The proposed descent remains incomplete.

Assume a strict failure with n moving speeds, minimal by count and then
primitive sum, and write `alpha=1/(n+1)`. For a deleted speed m, let P be a
minimal set of prime divisors hitting every attained collision residue.
Collective collision gcd one forces `b=|P|>=2`. Each `m/p` is a fresh speed:
if it were retained, the actual p-divisible collision would make that retained
speed both good and bad. The enlarged family is distinct and primitive.

Replacing m by all `m/p` preserves the open alpha-cover, but changes the count
to `n+b-1`, whose native margin is `1/(n+b)`. Its sum changes by
`m*(sum_(p in P)1/p-1)`. Two primes lower the sum, yet the increased count
prevents use of the minimum-sum hypothesis. For three or more primes even the
sum need not decrease. Transport at alpha does not imply transport at the
full original maximum or at the new native margin.

Assigning each new speed the smaller margin `alpha/p` gives an exact identity:
its bad arcs are the original m-arcs whose collision indices are divisible
by p, with the same centers and radii. This mixed-margin family covers the
whole circle and every label has a private point. The old labels' private
points use all the original deletion witnesses. Hence this mixed cover cannot
be reduced by deleting labels.

At common margin alpha, bundle labels are indispensable if all hitting primes
are at most n. Minimum sum also gives a witness after every admissible removal
of `b-1` old labels that lowers the sum. These witnesses are new holes in the
candidate extractions. With two primes, every old label is therefore also
indispensable at alpha; when both primes are at most n, the entire enlarged
common-margin cover is irredundant. This still gives no native LRC failure.

A proposed generic weighted shortcut is false: `(1,2,3)` has no simultaneous
witness at margins `(13,11,13)/50`, although their sum plus the largest margin
is one. Replacing 11 by 9 gives the same obstruction with budget `24/25<1`.
These exact controls do not have the special divisor-bundle margin pattern
and do not refute ordinary LRC. A theorem using that special pattern would
need additional arithmetic information.

Independent review accepted the full manuscript without corrections and
checked the two-prime corollary supplied by root. Root read the complete
author and review; the integration receipt binds the exact source and checks.
No numerical search, local Lean build or dependency restoration was needed.
There is no new kernel declaration in this checkpoint.

Pass 84 merged through PR83 at `7144d32c867a2fc70504dd0d797a885d5107de77`.
Both remote checks passed, followed by fifteen fetched-main hash checks and
head/parent ancestry checks. The unrestricted canonical goal remains active.
