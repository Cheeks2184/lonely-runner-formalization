# Pass 90: exact maximum-speed gaps and limits of centering

The maximum-speed deletion geometry is now explicit. In a hypothetical
minimum-count, minimum-sum canonical strict failure, each attained private
portion of a maximum-speed arc is one closed interval. Every lower-speed
bad arc meeting it must cover one of its endpoints: the lower arc is
longer, and containment of the maximum arc would eliminate its private
point. The extreme endpoint covers determine the whole private interval,
including possible singleton portions.

In the zero-only branch the two endpoint owners have speeds a+b=m and
lifted indices l+r=k. With alpha=1/(n+1) and D=ar-bl, the portion is

`[(l+alpha)/a, (r-alpha)/b]`.

It contains the collision center k/m. If the portion contains a stronger
deletion witness at beta=1/n, then `D>=beta*m`, and both parent speeds
exceed m/n. At the center both parents remain beta-good. Every nonparent
speed v satisfies `||v*k/m||>=alpha*(1+v/m)`, so speeds at least m/n also
remain beta-good.

A small speed can lose the stronger margin during centering only by
crossing an exact rational beta boundary. Set `g=gcd(m,v)`, `M=m/g`,
`Vv=v/g`, and let `d_n(M)` be the distance to nZ when n does not divide M,
and n otherwise. Any center blocker must satisfy

`Vv >= d_n(M)/(n*mu_m)`,

where `mu_m=mu-m*(alpha-mu)/max(V\{m})` is the contracted private radius.
In particular such a blocker is a small nondivisor of m. This is a
necessary condition; it does not exclude all the remaining speeds.

The exact local control `V={2,5,7,22,27,49}` at alpha=1/7 has a zero-only
maximum-speed portion around 4/49 with beta-witness 1/12. Centering fails
on speed 2: `8/49<1/6`. The original tuple itself has a full witness at
1/6, so this only refutes local geometry plus a stronger seed implying
successful centering. It does not refute a statement using all actual
minimal-failure hypotheses, nor the Lonely Runner Conjecture.

The uniform gap is simultaneous control of the small nondivisor blockers,
and then a justified escape or descent. Even a centered deletion witness
has maximum-speed phase zero. Independent review and the integration
receipt determine the acceptance status of these manuscript results;
none is presented as a new kernel-checked theorem or unrestricted proof.

Pass 89 merged through PR88 at `07d39f4feb40f5fdf7fd26b900d70c7a553e8709`.
Both required CI checks passed, and fetched main passed twenty-one file
hash checks and head/parent ancestry checks. This manuscript checkpoint
requires no local Lean build or cache restoration.
