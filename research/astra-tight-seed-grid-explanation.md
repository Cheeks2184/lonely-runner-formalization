# A uniform elementary explanation of the twelve positive controls

This manuscript result explains why the twelve fixed controls in
`astra-tight-seed-controls-plan.md` are comparatively easy for Q. It does not
prove Q for arbitrary tuples. No Lean theorem is claimed here.

Let N>=4 and let v be N-1 distinct positive integer speeds containing 1 and
N-1. Suppose every other speed has residue in {2,...,N-2} modulo N and
2 max(v) <= (N-1)^2. Write delta=1/N, gamma=1/(N-1), and

    h = 1/[N(N-1)^2],       s = 1/N - h.

Delete the speed p=1. Then s is an own-margin seed for that deletion,
its exact protected radius is h, and its score is exactly delta. In particular
Q succeeds and its protected interval reaches the full witness t=1/N.

Indeed at t=1/N the speed q=N-1 has fractional phase 1-delta. At s its phase
is 1-delta-(N-1)h=1-gamma. Since N>=4 this is between 1/2 and 1, so its
norm is gamma. Its contribution to the protected radius is
(gamma-delta)/(N-1)=h.

Every other retained speed d has norm at least 2 delta at t. Lipschitz
continuity gives norm(d s)>=2 delta-d h. The height assumption yields
2 d h<=delta. Thus this norm is at least 3 delta/2, which is at least
gamma since N>=3. It is also at least delta+d h. Consequently all retained
speeds meet the own-margin condition and their radius contributions are
at least h. The q contribution gives equality, so rho=h.

Finally 0<s<delta<=1/4, hence the deleted speed's norm at s is s=delta-h.
The score norm(s)+rho is delta, and the right endpoint s+rho is t=1/N.
All inequalities are closed: score equality supplies the required witness.

All twelve exact inputs satisfy these assumptions: they contain 1 and N-1,
have no additional residue 1 or N-1, and their maximum speed obeys the stated
quadratic bound. The fixed checks therefore do not probe the core remaining
uniform obstruction. In particular no speed is divisible by N, so each input
also fails the necessary small-denominator cover condition for a genuine
missing-witness tuple. This is a limitation of the sample, not of the exact
all-real checker or of the still-open statement Q.

This argument is elementary to formalize using rational arithmetic, the
existing distance-to-integers Lipschitz lemma, and a min-radius definition.
Its principal value at this stage is explaining the controls and preventing
their successful checks from being overinterpreted. Formalizing this restricted
family alone would not remove the arbitrary-N supply obligation.
