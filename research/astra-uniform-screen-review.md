# Independent review of the uniform divisor and affine screens

Date: 2026-09-06. Task: `/root/uniform_screen_review`; requested Astra/xhigh.
Observed runtime model, effort and token usage are not independently exposed.
Root supplied source checkpoint `a064347`. The reviewer did not author any
of the three source reports. Only this review file is owned; no Lean, Git, shared state or
cache changes were made. Project config, workflow, policy and focused active
state were read, and `python3 -B scripts/validate_workflow.py` exited 0 with:

```text
workflow structural validation passed; it cannot certify mathematical validity.
```

**Disposition: accepted at manuscript scope.** All three reports' mathematical
derivations and exact controls are sound. The consecutive family refutes the
stated arithmetic residual, including its strengthened reciprocal-orbit bounds.
The factorial family refutes the specified short affine rescue disjunction.
The additional root-authored argument in section 4 below shows that this latter
family also satisfies those stronger orbit bounds for every `N>=28`, as well
as the sharper inclusive height cutoff.
None of these results proves or disproves LRC, and none is a new Lean theorem.

## 1. Frozen artifacts

| Report | SHA-256 |
| --- | --- |
| `research/astra-uniform-divisor-minimality.md` | `8c4b6ee094f0f311f360d3abf371e95f731e28cee997d3810dd3218ff6f25746` |
| `research/astra-uniform-affine-phase-screen.md` | `c8b4ab3de95efaab20fa8d691d2e1fce48f0f206c0555df1d3302604b176f25e` |
| `research/astra-uniform-capacity-addendum.md` | `7d0cb2070b455ac2978ee0544a9ebd86ed218fdba3cc6738696bb3b26986b706` |

All three complete reports were read. All nine divisor-report source bindings and
all seven affine-report source bindings were compared with current file bytes
and matched. The relevant exact contracts were independently inspected in
`LowerCountSupply.lean`, `SmallDenominatorWitness.lean`,
`RationalShiftInsertion.lean`, `RationalShiftGcd.lean`, `DivisorInsertion.lean`,
`FiniteHeightReduction.lean`, `FastRunnerInsertion.lean`, and
`ConstrainedMaximizer.lean`. No compilation or repeated Lean import probe was
performed: this task reviews manuscript reasoning and fixed rational controls.

## 2. Divisor report

For `N>=4`, a deletion contains `N-2` moving speeds, so `H_N` supplies their
own margin `1/(N-1)`. If their gcd `D_p` does not divide the deleted speed,
the reciprocal shift preserves the complement and gives the exception margin
`1/4>=1/N`. Thus failure implies `D_p|v_p`, hence `D_p=G`. In the primitive
case this is exactly deletion gcd one, equivalently `C_d<=N-3` for every
`d>=2`. The closed endpoint at `N=4` is valid. The quarter-margin argument
must not be extended to `N=3`; the report explicitly preserves this scope.
One is not entitled to re-anchor at another runner and reuse stationary
failure without an additional argument.

The small-denominator cover is independent of primitivity and lower-count
supply: a missed `q` in `2..N` makes `1/q` a full witness. Covering only prime
powers is insufficient; covering the upper half of `2..N` is sufficient for
the full cover by the doubling argument. The stationary height theorem has
`m=N-2` and its contrapositive has the inclusive bound
`max(v)<=choose(N,2)^(N-2)`, exactly as used.

The stronger necessary condition is

```text
O_ell(v) = sum_(ell does not divide v_i) ceil(2r_i/N)/r_i >= 1,
r_i = ell/gcd(ell,v_i),                    ell>=2.                 (O)
```

For a nonempty proper divisible subtuple, its lower-count witness leaves only
the nondivisible coordinates to block the `ell` shifts. Each reduced orbit
has `r_i` equally spaced points, and its open bad arc hits at most
`ceil(2r_i/N)` of them. The union bound proves (O); its endpoints and ceiling
are correct. The empty divisible-subtuple case is automatic since each of
the `N-1` terms is at least `2/N`. Primitivity excludes the full divisible
subtuple. The prime specialization and the equivalent gcd-sum formula for
`ell<=N/2` are correct. Requiring (O) for every `ell` itself excludes zero or
one exceptional coordinate, and therefore subsumes primitivity and the
deletion-gcd cap. It does not subsume the lower cover.

For every `N>=5`, the block `L,...,L+N-2`, with `L=lcm(2,...,N)`, has two
disjoint consecutive pairs, so every deletion has gcd one. Its first speed
covers every small denominator. The induction
`N!+N-2<=choose(N,2)^(N-2)` starts already at `N=4` and proves the stated
height bound. The family threshold `N>=5` is essential for the deletion
claim: at `N=4`, deleting 13 from `(12,13,14)` leaves gcd two.
The all-`ell` proof of (O), including the separate `N=5,ell=3` case, is sound.

Its speed ratio is below two, and at `t=1/(2L)` its exact norms are
`1/2-i/(2L)`. The stronger estimate using `N(N-1)|L` makes this an
own-margin witness for every deletion as well as a full witness. This is a
family satisfying necessary arithmetic conditions, not a counterexample.

The additional trapped-seed inequality (T) is also accepted. A lower-count
seed has a positive closed Lipschitz buffer of radius
`rho=min_(i!=p)(||tv_i||-1/N)/v_i`. Under full failure this connected closed
interval lies strictly inside one open pivot-bad component. Its endpoints
give `||tv_p||+v_p*rho<1/N`, including the strict sign. Substituting
`rho>=1/(N(N-1)M_p)` gives the displayed (T). This constrains actual supplied
seeds; it supplies neither an escape theorem nor all component geometry.

## 3. Affine report

The actual-time compatibility statement is correct. An upper face forces a
reduced rational time `A/Q` with `N|Q` and `gcd(A,N)=1`; the phase numerator
condition `z_j=A*r_j (mod N)` is necessary and sufficient for positive lifts
with the specified phases and residues. Distinct lifts do not automatically
preserve primitivity. A nonzero bad `N`-divisible pivot requires `Q>N^2`.

For the exact `N=9` tuple

```text
t=1/5670,
v=(9,2835,1890,1134,810,5040,631,632),
```

the `1/2,1/3,1/5,1/7` phases belong to 9-divisible speeds. A prime divisor
of each `2<=alpha<=8` selects a blocker with transformed phase zero for
every integer `beta`. The 9-divisible upper speed 5040 stays at `8/9` for
every `alpha=1` shift. This defeats both the closed-safe dilated alternative
and the undilated forward-safe alternative `[1/9,8/9)`, and therefore also
the stricter undilated variant. All deletion gcds, the denominator counts
`(5,6,2,4,4,4,2,6)`, the explicit left strict seed, the witness `6/13`, and
the `alpha=11,beta=0` positive control agree with exact arithmetic.

The strict seed is a **different time to the left** of the actual upper-face
time. At an original time whose entire complement is strict, `alpha=1,beta=0`
allows a small forward move. The report does not claim to refute that fact.
At the boundary time, a right neighborhood is infeasible and the pivot norm
increases through the feasible left neighborhood, giving a strict local
constrained maximum. The full witness and the larger dilation show directly
that it is not a global constrained maximum and not an obstruction to all
dilations or all rational shifts.

For the factorial construction, `s=N-pi(N-1)-3>=2` for `N>=9` follows by
excluding `1,4,6,8` from the prime count. The blocker/free/upper inequalities
prove distinctness; all phases have the stated strictness except the upper
face. Each `2<=alpha<N` has a represented prime divisor. The upper speed
covers every denominator `2..N`. The deletion-gcd proof is valid; alternatively
the three present labels `N,L+1,L+N-1` are pairwise coprime because
`N|L` and `N-2|L`, so deleting any single label leaves a coprime pair.
No height bound for this factorial family is asserted in the author report.

The exact small `N=9` affine tuple fails the stronger condition (O) at
`ell=3`: its two exceptions each contribute `1/3`, totaling `2/3`.
The factorial `N=9` instance fails for the same reason. Thus the author's
phrase **basic divisor profile** is necessary. The following additional
uniform argument shows that this limitation disappears for a tail of the
same factorial family, without adding a global-maximality premise.

## 4. Root-authored extension: the factorial family satisfies (O) for N>=28

Root supplied this argument after the two agent-authored reports were frozen,
then froze the actual addendum bound in section 1. The reviewer read that
complete artifact and independently checked its inequalities, all three
denominator regimes, and its additional height induction. It is an additional
manuscript proof, not finite extrapolation or a kernel result.

Retain exactly the affine report's factorial family. Write

```text
k=pi(N-1),   h=s-1=N-k-4,   L=N!.
```

The consecutive free labels are `L+j`, `1<=j<=h`, with one additional free
label `L+N-1`. For `N>=28`, the six odd integers `1,9,15,21,25,27` are
nonprime and lie in `1,...,N-1`. Counting odd integers and then adding the
prime 2 gives `k<=floor(N/2)-5`. Consequently
`h>=ceil(N/2)+1`, while `h<N-1`.

* If `2<=ell<=N/2`, the consecutive free indices include
  `1,...,ell-1` and `ell+1`. These are `ell` nonzero residues modulo ell,
  since `ell|L`. Every corresponding orbit has `r<=ell<=N/2`, so its term
  in (O) is `1/r=gcd(ell,j)/ell>=1/ell`. Their sum alone is at least one.
* If `N/2<ell<=N`, again `ell|L`. Because `h<N<2ell`, the indices
  `1,...,h` contain at most one multiple of ell. Thus at least
  `h-1>=ceil(N/2)` of these free labels are exceptions. For each of them,
  put `g=gcd(ell,j)`. Its term is
  `g*ceil(2ell/(N*g))/ell>=2/ell`: if `g=1`, the ceiling is at least two;
  if `g>=2`, the ceiling is at least one. Their sum is at least
  `2ceil(N/2)/ell>=N/ell>=1`.
* If `ell>N`, the complete free-label set has diameter `N-2<ell`, so at
  most one free label is divisible. The pivot N is not divisible. At most
  the `k` blockers, the upper label, and that one free label are divisible,
  yielding `C_ell<=k+2<=floor(N/2)-3`. There are therefore at least
  `ceil(N/2)+2` exceptions. Every term in (O) is at least `2/N`, so their
  sum exceeds one.

This proves (O) for **every integer `ell>=2` and every `N>=28`** in the
factorial family. Together with section 3, the full short affine rescue rule
is false even after imposing these stronger reciprocal-orbit inequalities
and the basic arithmetic profile.

The addendum's height proof is also correct: for `N>=5`,
`(N-1)N!<=choose(N,2)^(N-2)` starts from `480<=1000`. The left-hand
growth factor is `N(N+1)/(N-1)<=choose(N+1,2)`, while the right-hand
growth factor is at least `choose(N+1,2)`. Since the upper-face label is
the largest family speed, this is exactly the inclusive sharper stationary
height cutoff. Thus adding that bound also leaves the relaxed rule false.

It does not follow that the family meets
all other necessary conditions for a minimal counterexample. In particular,
no missing-witness hypothesis or global maximum is proved or assumed here.

## 5. Exact replay receipts

Both sole embedded Python blocks were read and executed directly with
`python3 -B -`; no additional search or parameter-range expansion was run.
The exact inline command for the affine report was:

```sh
python3 -B - <<'PY'
from pathlib import Path
import re, hashlib, contextlib, io
p=Path('research/astra-uniform-affine-phase-screen.md')
s=p.read_text()
code=re.findall(r'```python\n(.*?)```',s,re.S)
assert len(code)==1
out=io.StringIO()
with contextlib.redirect_stdout(out):
    exec(compile(code[0],str(p)+'::python','exec'),{})
print('REPORT_SHA256',hashlib.sha256(p.read_bytes()).hexdigest())
print('CODE_SHA256',hashlib.sha256(code[0].encode()).hexdigest())
print('STDOUT_SHA256',hashlib.sha256(out.getvalue().encode()).hexdigest())
print(out.getvalue(),end='')
bindings=re.findall(r'\| `(LonelyRunner/[^`]+)` \| `([0-9a-f]{64})` \|',s)
assert len(bindings)==7
for path,h in bindings:
    assert hashlib.sha256(Path(path).read_bytes()).hexdigest()==h,path
print('PASS: all 7 affine source bindings match current bytes.')
PY
```

Exit 0, complete output:

```text
REPORT_SHA256 c8b4ab3de95efaab20fa8d691d2e1fce48f0f206c0555df1d3302604b176f25e
CODE_SHA256 f601e38ca5060da4fce077d54c619c22bf5ed23a3d9e0cf95b5982eb6fe06b9e
STDOUT_SHA256 05d7016212b48de5370150a27fae85d597373ffe144b8c01c9418bf0ca2c8c92
exact phase screen passed: 3 small certificates; 8 family controls; 1192 affine candidates; 92 deletion gcds
PASS: all 7 affine source bindings match current bytes.
```

The divisor report used the following exact inline command:

```sh
python3 -B - <<'PY'
from pathlib import Path
import re, hashlib, contextlib, io
p=Path('research/astra-uniform-divisor-minimality.md')
s=p.read_text()
code=re.findall(r'```python\n(.*?)```',s,re.S)
assert len(code)==1
out=io.StringIO()
with contextlib.redirect_stdout(out):
    exec(compile(code[0],str(p)+'::python','exec'),{})
print('REPORT_SHA256',hashlib.sha256(p.read_bytes()).hexdigest())
print('CODE_SHA256',hashlib.sha256(code[0].encode()).hexdigest())
print('STDOUT_SHA256',hashlib.sha256(out.getvalue().encode()).hexdigest())
print(out.getvalue(),end='')
bindings=re.findall(r'^([0-9a-f]{64})  (LonelyRunner/\S+)$',s,re.M)
assert len(bindings)==9
for h,path in bindings:
    assert hashlib.sha256(Path(path).read_bytes()).hexdigest()==h,path
print('PASS: all 9 divisor source bindings match current bytes.')
PY
```

Exit 0, complete output:

```text
REPORT_SHA256 8c4b6ee094f0f311f360d3abf371e95f731e28cee997d3810dd3218ff6f25746
CODE_SHA256 959a92fdfaf29c3ce06ff0cd9b2700c1ebdc5e8f792391a6b9cd6e656da1382f
STDOUT_SHA256 8090ae2c77517e6cd7b1c3b4460f06a9e4ddedad5a7235387451ff051a433f36
PASS: 60 explicit families, N=5..64; exact integers and fractions only.
PASS: all 9 divisor source bindings match current bytes.
```

The all-`N` and all-`ell` conclusions rest on the manuscript proofs above;
the finite checks are reproducible controls of exactly the supplied families.
There was no failed check or source repair cycle. The mathematical gap is a
uniform mechanism retaining more than these arithmetic capacities and local
upper-face data, such as an effective use of the actual global constrained
maximum. The unrestricted canonical completion gate remains unmet.
