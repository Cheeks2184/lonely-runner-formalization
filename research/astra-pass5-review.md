# Independent Astra pass 5 review

**Accept the final multiple-zero source and value-audit manuscript at their
stated scopes. No mathematical or theorem-contract correction is required.**
The simultaneous Nat witness, including all original zero coordinates and
the empty ordinary case, is kernel checked. The normalization implications,
all-modulus obstruction for the all-zero subclass, and strictness distinctions
are independently accepted manuscript mathematics. None establishes uniform
supply for the enlarged union or resolves unrestricted LRC.

Reviewed 2026-09-05 under the recorded Astra Extra High assignment at source
checkpoint `df8d71f`. Separate runtime model/effort metadata is unavailable.
Current project configuration, workflow, policy and state were read; the
structural validator passed. The state remains `research` / `in_progress`.
This worker changed only this report, used temporary targeted probes, and
made no source, shared-state, Git, publication, or cache-cleanup changes.

## 1. Accepted compiled contract

`affine_avoidance_card_le_sub_two` assumes odd prime `N`, a finite index type
`I` with `card I <= N-2`, nonzero slopes in `ZMod N`, and arbitrary offsets.
It returns **both** nonzero field scalars and avoidance of `0` and `-1`
for every supplied row. There is no ordinary-row nonemptiness or nonzero
offset premise.

The padding type is exactly

```text
I ⊕ Fin (N-2-card I).
```

Its cardinality is `N-2`, using the supplied inequality before cancelling
natural subtraction. Dummy slopes are `1` and dummy offsets are `0`.
The field theorem is applied to this full type, and its conclusion is
restricted along `Sum.inl`. This remains valid for `I = Fin 0`: the dummy
rows are algebraic constraints, never invented original runner coordinates.

The public `affine_grid_multiple_zero_witness` has the following exact scope:

- `N` is an odd prime; `M,L,H` are positive naturals.
- `I,J` are finite types, `J` is nonempty, and
  `card I + card J = N-1`.
- Every zero row satisfies `L <= A_j <= H`, `N|A_j`, `N|U_j`, and
  `U_j == A_j (mod M)`.
- Every ordinary row satisfies `0<a_i<L`, `N` does not divide `a_i`,
  and `u_i == a_i (mod M)`.
- The only coarse range/size conditions are

```text
H < (N-1)*L,
N*H*L <= ((N-1)*L-H)*M,
N*a_i*L <= (L-a_i)*M                 for every ordinary i.
```

The conclusion supplies natural `s,r`, with `0<s<N`, and at the **same**
time `s/N+r/M` proves the closed bound

```text
1/N <= circleNorm(time * U_j)        for every original zero row j,
1/N <= circleNorm(time * u_i)        for every original ordinary row i.
```

This retains exactly `N-1` labelled moving coordinates. The index types need
not be nonempty simultaneously; the all-zero case has `I` empty and
`card J=N-1`. No coordinate is dropped to obtain the cardinality bound.

The formal statement slightly generalizes the manuscript's use of actual
minimum and maximum: `L,H` may be any valid positive bounds. It does **not**
require either `N|L` or `N|H`, nor that the bounds are attained. There is no
product condition or nonzero-offset premise. The closed conclusion does not
assert a canonical theorem for arbitrary real speeds or every chosen runner.

## 2. Independent arithmetic and endpoint review

Nonempty `J` and the full cardinality equation imply `card I<=N-2`.
Nonempty `J` also supplies `L<=H`. The shifted-rounding helper gives

```text
N*r = M*r0 + beta,
M <= L*beta < M+N*L.
```

Put `D=(N-1)*L-H`. The span hypothesis makes natural subtraction exact.
Since `D<N*L`, the range inequality gives

```text
(N*L)*H <= D*M < (N*L)*M,
```

so `H<M`. This is derived inside the source: the generic residue helper's
base-below-modulus premise is **not added** to the public theorem. Every
zero base is at most `H`; each ordinary base is below `L<=H`.

Adding `H*M` to the size inequality gives

```text
N*H*L + H*M <= (N-1)*L*M.
```

Multiplying the strict rounding upper bound by positive `H` and cancelling
positive `L` proves `H*beta<(N-1)*M`. Thus, for every actual zero row,

```text
M <= L*beta <= A_j*beta <= H*beta < (N-1)*M.
```

Both `A_j` and `U_j` are zero modulo `N`, so its affine residue really is
zero. Its combined residue is `A_j*beta`, not an unaccounted bad coordinate.

For an ordinary row, multiplying `L*beta<M+N*L` by positive `a_i` and
using its coarse inequality gives `a_i*beta<M`. Its finite-field avoidance
implies `1<=h_i<=N-2`, and therefore

```text
M < h_i*M+a_i*beta < (N-1)*M.
```

The source correctly weakens these strict inequalities to the closed
inequalities expected by `circleNorm_ge_of_affine_grid_residue_band`.
The residue identity preserves the actual quotients of `u_i,U_j` modulo
`M`; it does not replace a speed by its base at the real-time level.

The only potentially attained endpoint is the lower endpoint of a zero
row. The span equality `H=(N-1)*L` is excluded by this robust theorem.
The manuscript's separate zero-width alignment mechanism is not silently
included in the formal contract.

## 3. Normalization and strictness

The value audit uses positive Nat representatives

```text
W_i = e_i*b*V_i + N*M*k_i,
e_i in {1,-1}, gcd(b,M)=1.
```

At the exact grid time `t=n/(N*M)`, independent lift terms contribute
integers. Consequently `circleNorm(W_i*t)=circleNorm(V_i*(b*t))` for every
original label. This also works for negative signs and arbitrary common
integer lifts `b`, including lifts divisible by `N`. Adding sufficiently
large multiples of `N*M` makes each representative positive. The witness
time returned by the Nat theorem has this grid form with `n=s*M+N*r`.

If `N` does not divide `M`, no zero product `A_j*beta` can equal `M`,
because `N|A_j`. The ordinary residues are already strictly interior.
Thus the **same grid time**, followed by multiplication by `b`, gives a
strict original witness. This argument does not need an extra divisibility
premise on the formal bounding parameter `L`.

For a primitive all-zero input, primality and the original gcd condition
force `N|b`; the unit condition then forces `N` not to divide `M`.
The all-zero subclass therefore implies a strict original witness.

The audit correctly refuses to extend this strictness proof to arbitrary
mixed certificates with `N|M`. Its complete boundary control is valid:

```text
N=5, M=25, b=1,
V=(1,2,5,20), W=(1,2,5,105),
ordinary bases=(1,2), zero bases=(5,5),
r0=1, s=2, r=6, beta=5, t=16/25.
```

All four original labels satisfy the coarse contract and the closed bound.
The original zero phases are `1/5` and `4/5`: either sign of sufficiently
small original-time perturbation makes one bad. Both positive transformed
zero phases are `1/5`, so their forward perturbation instead works. This
shows why an off-grid perturbation of independently lifted representatives
does not transport. It does not deny another strict original witness;
this tuple has one at `1/3`.

## 4. All-zero characterization and scope of the obstructions

For primitive input, write `b=N*q` in an all-zero certificate and
`A_i=N*B_i`. The range inequality implies

```text
N*H < (N-1)*M,
0 < B_i/M < (N-1)/N^2 < 1/2.
```

Since `N` is invertible modulo `M`, the congruences identify each `B_i`
with the positive absolute residue of `q*V_i`. With their minimum `l`
and maximum `h`, cancellation gives exactly

```text
N does not divide M, all d_i>0,
((N-1)*l-h)*M >= N^2*h*l.
```

Conversely this inequality forces `h<(N-1)l` and the same small-residue
bound. Choosing the realizing signs, `b=N*q` and `A_i=N*d_i`, then
positive Nat lifts, recovers the all-zero contract. Both directions retain
the modular-unit condition. This is a recurrence criterion, not a proof
that the requisite residues always exist.

The analytic all-modulus obstruction for
`V7=(2,3,4,30,7,14)` is correct. Its strict witness `1/9` has distances
`(2,3,4,3,2,4)/9`. An all-zero certificate would give all six absolute
distances below `epsilon=6/49`. Writing the multiplier's absolute residue
as `x*M`, with `0<x<=1/2`, the speed-2 and speed-3 conditions force
`x<epsilon/3`. Then `14*x<4/7<1-epsilon`, so the speed-14 condition
forces `14*x<epsilon`. Hence `30*x<90/343<1/2`, and every distance is
unwrapped. Their ratio is `30/2=15`, contradicting `h/l<6`. The modulus-one
case cannot have positive residues. This proof covers all allowed moduli
and common units; finite scanning is not its basis.

For every odd prime `N`, the tight tuple `(1,...,N-1)` cannot have a
robust mixed certificate. Any nonempty zero set forces `N|b`, hence
`N` does not divide `M`, and would imply strict loneliness. The `N`
circle points `0,t,...,(N-1)t` always have a cyclic gap at most `1/N`,
so some listed speed has distance at most `1/N`. Coincidences only make
the distance zero. These tuples do have closed witnesses at `1/N`.

This obstruction concerns robust multiple-zero normalization **alone**.
Theorem A covers the tight tuple using its nonzero-offset branch. Similarly,
failure of the all-zero subclass on `V7` does not imply failure of the mixed
contract or of the enlarged union. These distinctions are maintained
throughout the audited manuscript.

## 5. Complete positive controls

The mixed `V7` certificate has exactly six original speeds for `N=7`:

```text
M=257, b=35, gcd(b,M)=1,
V:       2    3    4     30      7      14
sign:    +    +    +      +      -       -
W:      70  105  140   1050   1554    1309
base:   70  105  140     22     12      24
kind:    Z    Z    Z      O      O       O
```

All offsets vanish modulo `7`, but the ordinary slopes do not. With
`L=70,H=140`, the zero range test is `71960>=68600`; the largest ordinary
base gives `11822>=11760`, and smaller ordinary bases satisfy the test.
Taking `r0=s=1` gives ordinary affine residues `(1,5,3)` and

```text
r=38, beta=9, n=523, N*M=1799,
W*n mod 1799 = (630,945,1260,455,1393,987).
```

All six are strictly between `257` and `1542`. Original-time transport is
`45/257`, with minimum distance `58/257>1/7`. Thus the mixed theorem does
extend the previously reviewed A/B/coarse-C normalization union, while
the elementary witness `1/9` already established this instance of LRC.

A separate Lean instantiation used `N=5`, `M=151`, `I=Fin 0`, `J=Fin 4`,
`A=U=(10,15,20,25)`, and bounds `L=9,H=26`. Both bounds are nondivisible
by `5` and unattained; all public hypotheses still hold. The conclusion
retains all four zero rows. Together with the common multiplier `5`, this
is a complete all-zero normalization of the primitive tuple `(2,3,4,5)`.

The manuscript's simpler sufficient ratio condition
`max V < (N-1)*min V` is also correct. Taking `b=N`, `A_i=N*V_i` and a
sufficiently large `M` coprime to `N` supplies the all-zero certificate.
It has a simpler direct strict witness in the nonempty interval
`1/(N*min V)<t<(N-1)/(N*max V)`; the audit accurately limits its novelty.

## 6. Verification evidence

Reviewer-run checks:

- `python3 scripts/validate_workflow.py`: passed.
- `lake env lean LonelyRunner/AffineGridMultipleZero.lean`: passed cleanly.
- Independent import, declaration prints, and `#print axioms` probes:
  both new public declarations depend only on
  `[propext, Classical.choice, Quot.sound]`.
- Targeted Lean examples for the empty padding family, the all-zero
  four-coordinate fixture above, and the complete six-coordinate `V7`
  fixture: passed. Temporary probe `/tmp/lrc-pass5-probe.lean` and log
  `/tmp/lrc-pass5-probe.log` record these checks; one unused-variable
  warning in the probe does not affect source compilation.
- The final value manuscript's embedded exact `Fraction` reproducer:
  passed, including the signed boundary control and `V7` time transport.
- Independent seeded integer checks: 1,632 full-size coarse certificates,
  including 240 empty-ordinary cases and 83 attained-boundary cases;
  every combined band equalled the actual original Nat residue and lay
  in the closed good interval. The strict version held whenever `N` did
  not divide `M`.
- Exact signed transport was checked at all 125 grid numerators of the
  boundary fixture, together with its opposing original perturbations.
- An additional scan through `2<=M<=600` checked 54,750 absolute modular
  unit representatives and found no all-zero `V7` certificate, as predicted
  by the analytic proof. This is regression evidence only.

The seeded check used `Random(20260905)`, primes `(3,5,7,11,13)`, every
ordinary count `m=0,...,N-2`, and twelve samples each. It chose
`q=randrange(2,10)`, `N-1-m` zero bases `N*randrange(q,(N-1)*q)`, and
ordinary bases independently from positive values below the resulting
minimum not divisible by `N`. For each sample it used the least integral
`M` satisfying all coarse size inequalities, then offsets `0,1,2,3` above
that minimum. Zero-speed lifts were `A+M*N*randrange(4)`; ordinary lifts
were `a+M*randrange(5)`. It enumerated the first nonzero field pair satisfying
all avoidances and checked the exact rounded residues for every label.
This finite test does not replace either the field proof or the source proof.

The parent separately reports a full 3,606-job integration build and a
346-report trust audit passed, with logs `/tmp/lrc-astra-pass5-build.log`
and `/tmp/lrc-astra-pass5-trust.log`. This reviewer did not repeat the full
build. Full-build/publication ownership remains with the parent.

## 7. Source binding and remaining limits

Final reviewed SHA-256 values, rechecked after the probes:

```text
LonelyRunner/AffineGridMultipleZero.lean
  225d6c6adcaa1d85309325b2bb4712a48f0adb13019c8e645d4a6699a73f1aca
research/astra-multiple-zero-value.md
  ef3619bfdf74e5b2794f8d4737623e8d3e9cedf62dd21039f9169465e4dd8090
research/astra-vanishing-slope.md
  f3e2c58177b5f3033afd0d164fbb688eacd30e5f42f39a7bc6ccaec5e82f599e
research/astra-grid-supply-audit.md
  7caa2b660942cacb92382bc9cd661b83647af85f212b71589d162e6734bb22c1
LonelyRunner/AffineShiftArithmetic.lean
  a883b84e19096d0a1b3a007216c42edcbce72f1d527969d0f88ff41a52a37a0d
LonelyRunner/AffineGridArithmetic.lean
  0be8553d88fed2346895abcaeb961d0fb2967ee8db356feff8877ceb8b49b079
LonelyRunner/AffineAvoidance.lean
  9fb78dc2b12694f096ac423c04835f3f961e0769dc6d5ae6180033d6004f22c0
lean-toolchain
  8e3538e0ab5f81a3ee04927d8838c8c674e0e112838b4b3ce87ec218143276af
lake-manifest.json
  887450bc75a38effdae452a14b60f6d225bc10b48c71b3827e3479b800f41218
```

The two new Lean declarations prove the smaller-cardinality field helper
and the full conditional Nat grid witness. The value audit's signed
normalization transport, strictness refinements, recurrence equivalence,
all-modulus obstructions and ratio-supply claims remain manuscript proofs;
this review does not label them new Lean declarations.

The formal result does not supply a normalization for arbitrary input,
prove distinctness or primitivity from its hypotheses, or export a wrapper
with the unrestricted canonical runner/speed quantifiers. No strict-witness
sufficiency theorem for the mixed contract is proved. Whether arbitrary
mixed certificates with `N|M` imply another strict original witness is
also left open. No example in this audit escapes the whole enlarged
A/B/C/multiple-zero union, and no theorem proves that union universal.
The canonical full proof/disproof objective remains unresolved.
