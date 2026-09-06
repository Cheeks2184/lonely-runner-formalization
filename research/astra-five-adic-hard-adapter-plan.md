# Natural modular adapter for the hard five-adic pattern

2026-09-06. Requested Astra/xhigh author `/root/mixed_equivalence_freeze`;
routing is requested, not independently attested. Only this manuscript is
owned. Current configuration, workflow, policy and state were read; the
structural validator passed. Assigned main checkpoint:
`f55744833dd2876e582f0e4e0726614b6b527a54`. Other work is preserved. No Lean,
cache/dependency access, source/state/Git edit or speed-domain enumeration is
performed. The overall goal remains active and unresolved.

**Recommendation:** use the natural complement construction below. It gives
the exact hard-pattern adapter without signed division or floor identities.
The only natural subtraction in the construction is `P-s`, guarded by s<P;
the distance definition already uses its own bounded subtraction. Reuse the
new filtering arithmetic identities, but do not depend on a full filtering
descent. The carry theorem is an explicit conditional input here: its public
contract is unchanged and this plan does not assume a successful kernel proof.

## Target and source dependencies

Let m≥1, R=5^m and P=5R. Let d:Fin 3→Nat satisfy `5∤d_i`, and let v:Nat
satisfy `5∤v`. These unit conditions imply all four speeds d_i and Rv are
positive. Ordering, distinctness and a common gcd of one are unnecessary.
Conditionally on the exact `fiveCarryTriple` statement, the target is

```lean
theorem fiveAdic_hard_pattern_of_carry
    (hcarry : ∀ s : Fin 3 → FiveCarryState,
      ∃ u : Fin 3, ∃ k : Fin 5, ∀ i,
        (fiveCarryDigit (s i) u k).val ∈ ({1, 2, 3} : Finset Nat))
    (m : Nat) (hm : 1 ≤ m) (d : Fin 3 → Nat)
    (hd : ∀ i, ¬ 5 ∣ d i) (v : Nat) (hv : ¬ 5 ∣ v) :
    ∃ lambda : Nat, 0 < lambda ∧ lambda < 5 * 5^m ∧ ¬ 5 ∣ lambda ∧
      (∀ i, 5^m ≤ cyclicResidueDistance (5 * 5^m) (lambda * d i)) ∧
      5^m ≤ cyclicResidueDistance (5 * 5^m) (lambda * (5^m * v))
```

This is a proposed type, not a new Lean declaration. The multiplier can
additionally be shown to have residue 1,2 or 3 modulo 5; it need not have
residue 1. The speed of largest 5-adic valuation need not be the fastest.
No strict ordinary seed or lower-count hypothesis is used.

The stable nine-lemma source checkpoint for `FiveAdicFiltering.lean`, SHA-256
`806ce4292128bf912b7a5a1c4cf6efd8f649868602e8d81611b2133d8304e7c4`,
has the following interfaces, read during this task:

| Declaration | Exact relevant content |
|---|---|
| `fiveAdicDigit` | `(x / 5^m) % 5` |
| `fiveAdic_residue_decomposition` | `x % (5*5^m)=5^m*fiveAdicDigit m x+x%5^m` |
| `fiveAdicGoodDigit_distance` | digit in the closed integer interval [1,3] implies distance ≥5^m |
| `fiveAdicCorrection_selected_digit` | correction at level ell shifts the digit by `k*((A*u)%5)`, retaining the actual current coefficient |
| `fiveAdicCorrection_mod_five` | below-top correction is 1 modulo 5 |
| `fiveAdic_top_residue` | `A*(5^m*v)` has residue `5^m*((A*v)%5)` |
| `fiveAdic_top_distance` | a top-level unit meets the distance bound, including digit 4 |

The arithmetic worker report records a successful named build and type/axiom
probe for these nine arithmetic declarations. This task reads that evidence
and the source but does not replay Lean. The full filtering descent is not
among these declarations. Both Filtering and Carry source files are now
owned by active implementers: their current mutable bytes are deliberately
not replay guards, and no current source verification is asserted here.
The generic norm bridge remains `PivotResidues.circleNorm_nat_div_ge`
(declaration namespace `LonelyRunner`). The reproducer guards that stable
source and the accepted carry/filter manuscripts used for this plan.

## Natural complement normalization

For P>0, define `dist_P(y)=cyclicResidueDistance P y`. First prove two small
generic natural lemmas; neither requires primality or a unit multiplier:

```
x%P = y%P                   ⇒ dist_P(x)=dist_P(y),
(x+y)%P = 0, with P>0       ⇒ dist_P(x)=dist_P(y).          (S)
```

The first follows by unfolding the existing distance definition. For the
second set a=x%P and b=y%P. Then a,b<P, `(a+b)%P=0` and a+b<2P. Euclidean
division shows `(a+b)/P<2`, hence its quotient is 0 or 1; therefore a+b is
0 or P. In the zero case a=b=0. In the other case b=P−a and a=P−b, so the
two minima `min(a,P−a)` and `min(b,P−b)` are equal. This explicitly handles
zero residues after multiplication. It uses only natural division/modulo,
the quotient bound, the two quotient cases and bounded subtraction.

As immediate corollaries, for s≤P and any A:Nat,

```
dist_P(A*(P−s)) = dist_P(A*s),
dist_P(A*(d%P)) = dist_P(A*d),
dist_P((A%P)*d) = dist_P(A*d).                            (S')
```

The first uses `A*(P−s)+A*s=A*P` and (S); the others use `Nat.mul_mod` and
`Nat.mod_mod`. A may be zero or a nonunit. There is no hidden cancellation
assumption on A and no need to introduce real norms to prove these facts.

Now put s=d%P, with 5∤d and 5∣P. Then 0<s<P and s%5=d%5∈{1,2,3,4}.
Choose

```
x = if s%5=1 or s%5=2 then s else P−s.                   (N)
```

Then 0<x<P and x%5∈{1,2}. In the complement branch, `(x+s)%5=0` and
s%5∈{3,4} imply x%5 is respectively 2 or 1. This can be proved from
`x+s=P`, natural addition modulo 5 and bounded residues; it need not use
a subtraction-modulo formula. By (S'), **every** natural multiplier A gives
`dist_P(A*x)=dist_P(A*d)`. Prove this universally at normalization time,
so later callers never need to remember which sign was chosen.

Suggested reusable contracts are
`cyclicResidueDistance_eq_of_add_mod_eq_zero`,
`cyclicResidueDistance_mul_complement`, and
`fiveAdic_normalize_unit`, whose last conclusion is the universal distance
equality just stated. All are new planned lemmas, not existing API names.
The most useful constructor contract needs no m≥1 premise:

```lean
theorem fiveAdic_normalize_unit (m d : Nat) (hd : ¬ 5 ∣ d) :
    ∃ x : Nat, 0 < x ∧ x < 5 * 5^m ∧ (x%5=1 ∨ x%5=2) ∧
      ∀ A : Nat,
        cyclicResidueDistance (5 * 5^m) (A*x) =
        cyclicResidueDistance (5 * 5^m) (A*d)
```

## A simultaneous carry tag from natural inequalities

For any R>0 and 0≤z<R, use this single selector:

```
tag(R,z) = if 3z<R then 0
           else if 2z<R then 1
           else if 3z<2R then 2
           else 3.                                     (C)
```

It lies in Fin 4 and yields the respective coupled pairs
`(0,0),(0,1),(1,1),(1,2)` for `(2z/R,3z/R)`, using natural division.
The proof checks the four branches: the numerator lies between the stated
quotient times R and the next quotient times R. Since z<R, the multiplier-1
quotient is always zero. Thus the exact generic conclusion is

```lean
theorem fiveAdicCarryTag_spec (R z : Nat) (hR : 0 < R) (hz : z < R) :
    ∀ u : Fin 3,
      fiveCarryCarry (fiveAdicCarryTag R z) u = ((u.val+1)*z)/R
```

The selector uses strict tests and the division result uses closed lower
endpoints: equality at 3z=R chooses tag 1, at 2z=R tag 2, and at 3z=2R
tag 3. The helper is valid even when those equalities occur for a general R.
No coprimality of R with 2 or 3 is needed. Independent selections of the
double and triple carries would lose exactly the constraint the finite
theorem requires.

For x from (N), set `a=x/R`, `z=x%R` and r=x%5. Since x<5R, a<5; hence
use top `⟨a,...⟩:Fin 5` directly, with no additional `%5`. Decode r=1 or 2
into `Fin 2` by the cases 0 or 1, and use tag(R,z) for the carry. This defines
a natural state constructor with specification

```
state.top.val = x/R,
state.residue.val+1 = x%5,
∀ u, fiveCarryCarry state.carry u = ((u.val+1)*(x%R))/R.
```

The state-construction lemma only needs x<5R and r∈{1,2}; positivity follows.
The power 5^m is always positive. The stronger m≥1 premise will be used to
prove that the final correction is a unit, not to justify coupled carries.

## Exact digit identity and the current correction coefficient

Write J=u.val+1∈{1,2,3}. The division identity `x=R*a+z` gives

```
J*x = R*(J*a)+J*z,
(J*x)/R = J*a+(J*z)/R,
fiveAdicDigit m (J*x) = (J*a+fiveCarryCarry state.carry u)%5.  (D)
```

The middle line is division of a multiple of R plus a remainder numerator;
`J*z` need not be less than R, which is why the carry is retained. The
source already uses `Nat.add_mul_div_left` for this kind of exact rewrite.

Set `Araw=J*(1+k.val*R)`. Use `fiveAdicCorrection_selected_digit` at
**level ell=0**, with its current multiplier parameter **A=J** and unit
parameter **u=x**. Its natural identity is

```
fiveAdicDigit m ((1+kR)*(J*x))
  = (fiveAdicDigit m (J*x)+k*((J*x)%5))%5.
```

Combine this with (D) and natural addition/multiplication modulo 5 to obtain

```
fiveAdicDigit m (Araw*x)
  = (J*a+fiveCarryCarry state.carry u+J*k.val*r)%5
  = (fiveCarryDigit state u k).val.                     (E)
```

This exactly matches the unchanged public digit definition. Replacing the
correction term by k*r would be wrong: the current unit coefficient is J*x,
so the factor J is essential. Commutativity identifies the correction product
with Araw*x; no transformed floor or signed carry must be recomputed.
The suggested lemma `fiveAdicCarryState_digit` states (E) for all u:Fin 3
and k:Fin 5 after the state specification has been proved.
Its precise proposed interface is:

```lean
def fiveAdicCarryState (m x : Nat) (hx : x < 5 * 5^m)
    (hr : x%5=1 ∨ x%5=2) : FiveCarryState

theorem fiveAdicCarryState_digit (m x : Nat) (hx : x < 5 * 5^m)
    (hr : x%5=1 ∨ x%5=2) (u : Fin 3) (k : Fin 5) :
    fiveAdicDigit m (((u.val+1)*(1+k.val*5^m))*x) =
      (fiveCarryDigit (fiveAdicCarryState m x hx hr) u k).val
```

The digit identity itself also allows m=0. Only the full hard-pattern
assembly needs m≥1 to ensure correction-unit and positive-remainder facts.

## Conditional assembly and multiplier normalization

Normalize the three d_i independently and construct their three states. Apply
hcarry once, obtaining common u,k. Formula (E) and
`fiveAdicGoodDigit_distance` give R≤dist_P(Araw*x_i), and (N) transfers
these bounds to the original d_i, all at that same multiplier.

Because m≥1, R≡0 modulo 5, so `Araw%5=J` with 1≤J≤3; also Araw>0.
The product Araw*v is a 5-unit since 5 is prime and neither factor is
divisible by 5. Apply `fiveAdic_top_distance m Araw v`. Its exact residue
formula is `R*((Araw*v)%5)`, whose digit can be 1,2,3 **or 4**. Digit 4
gives residue 4R and distance exactly R; do not apply the units' digit-1-to-3
predicate to this top-level speed.

Finally set `lambda=Araw%P`. Then lambda<P, and since 5∣P,
`lambda%5=Araw%5=J≠0`, which proves both lambda>0 and 5∤lambda. The last
identity in (S') preserves every original distance, including the top runner.
This gives the stated conditional theorem. Reduction is essential: Araw may
exceed P, and its positivity alone does not imply positivity of its remainder;
that latter step uses the nonzero residue modulo 5.

An optional final corollary takes the positive time `t=lambda/P`, with t<1,
and uses `circleNorm_nat_div_ge` plus R/P=1/5 to obtain the four closed real
norm inequalities. It supplies ordinary fifth margins, not a fastest-quarter
condition. The adapter itself is already expressed in the natural residue
contract needed by the separate filtering route.

## Scope and implementation order

Prefer this natural route over signed x=±d: the full normalization remains
inside 0<x<P, top digits have immediate Fin 5 bounds, and the complement
lemma absorbs sign invariance for every later multiplier. The signed route
is mathematically sound but adds the formula `q(−x)=−q(x)−1` and signed
division obligations that this caller does not need.

After the carry source is successfully checked, implement (S)/(S'), the
normalizer, simultaneous tag/state specification, the small-multiplier digit
identity, and then the conditional assembly. Reuse the already authored
filtering arithmetic instead of reproving its selected-digit and top-boundary
facts. Each step should receive ordinary source/type/axiom checks; this plan
authorizes no kernel execution or resource-budget expansion. The full
filtering descent, the all-pattern natural supply and the canonical real
five-total theorem remain separate work. No unconditional formal result is
claimed while the carry implementation is still unresolved.

## Guarded fixed arithmetic controls

The sole program below evaluates one explicitly chosen hard-pattern tuple,
two fixed scalar digit identities, three internal carry-boundary fixtures
and two complement fixtures. It performs no speed-domain search or finite
carry-theorem replay. The hard tuple is d=(1,84,49), m=2, v=3; normalization
gives x=(1,41,76). Use the supplied J=3,k=4, so Araw=303 and lambda=53.
The tuple is not required to be sorted. The two complement cases use A=0
and A=5 to check the generic lemma beyond unit multipliers. R=6 is used only
for the generic carry helper's internal equalities; it is not a five-adic
speed-instance hypothesis.

```python
from hashlib import sha256
from pathlib import Path

guards = {
    'LonelyRunner/PivotResidues.lean':
        '362da5ab923f22e900ae7ac821dd4cf4aab91dfe70889987bc9e5a05d19c276a',
    'research/astra-five-adic-carry-plan.md':
        'da1a4f4828f6e9d9cae6ed601151e0b56b518bea8e9add524e06b289b1713e69',
    'research/astra-five-adic-carry-symbolic-plan.md':
        'd1fef1fafc6c7ae6adaf0ee885b4d44931e26bda667ff040f6c237f082555f80',
    'research/astra-five-adic-filter-plan.md':
        '34725cc13001013cdeefa89d36620442bbe7d6ccffcc0ff6f85585bdd208f500',
    'research/astra-five-adic-filter-plan-review.md':
        '750f12219cc784560ec8c8822274f455a3a12c316c95072d645b9f94fe3f328e',
}
for path, expected in guards.items():
    assert sha256(Path(path).read_bytes()).hexdigest() == expected, path

C = ((0,0,0),(0,0,1),(0,1,1),(0,1,2))
def distance(P,y):
    r = y%P
    return min(r,P-r)
def normalize(P,d):
    s = d%P
    assert 0 < s < P and P%5 == 0 and d%5 != 0
    x = s if s%5 in (1,2) else P-s
    assert 0 < x < P and x%5 in (1,2)
    return x
def tag(R,z):
    assert R > 0 and 0 <= z < R
    result = 0 if 3*z < R else 1 if 2*z < R else 2 if 3*z < 2*R else 3
    assert C[result] == (z//R,2*z//R,3*z//R)
    return result
def state(R,x):
    assert 0 < x < 5*R and x%5 in (1,2)
    return x//R,x%5,tag(R,x%R)
def digit(state,J,k):
    a,r,c = state
    return (J*a+C[c][J-1]+J*k*r)%5

R,P = 25,125
d = (1,84,49)
v,J,k = 3,3,4
x = tuple(normalize(P,w) for w in d)
states = tuple(state(R,w) for w in x)
assert x == (1,41,76) and states == ((0,1,0),(1,1,2),(3,1,0))
raw = J*(1+k*R)
lam = raw%P
assert (raw,lam) == (303,53) and 0 < lam < P and lam%5 == J
for original,normalized,s in zip(d,x,states):
    q = ((raw*normalized)//R)%5
    assert q == digit(s,J,k) and q in (1,2,3)
    assert distance(P,raw*normalized) == distance(P,raw*original)
    assert distance(P,raw*original) == distance(P,lam*original) >= R
distances = tuple(distance(P,lam*w) for w in d+(R*v,))
assert distances == (53,48,28,25)
assert (lam*(R*v))%P == 4*R and distance(P,lam*(R*v)) == R
assert ((lam*(R*v))//R)%5 == 4

scalar_digits = []
for m,w,J,k,expected in ((1,27,2,3,2),(2,21,3,2,3)):
    R1 = 5**m
    P1 = 5*R1
    x1 = normalize(P1,w)
    s1 = state(R1,x1)
    raw1 = J*(1+k*R1)
    actual = ((raw1*x1)//R1)%5
    assert actual == digit(s1,J,k) == expected
    scalar_digits.append(actual)
    if m == 1:
        a,r,c = s1
        assert (J*a+C[c][J-1]+k*r)%5 != actual

boundary_tags = tuple(tag(6,z) for z in (2,3,4))
assert boundary_tags == (1,2,3)
complements = []
for A in (0,5):
    left,right = A*(25-24),A*24
    assert (left+right)%25 == 0
    assert distance(25,left) == distance(25,right)
    complements.append(distance(25,left))
assert complements == [0,5]

print('source_and_manuscript_guards=5 passed; live_Carry_Filtering_guards=none')
print('hard_tuple_normalized=' + str(x) + '; raw=303; lambda=53')
print('original_closed_distances=' + str(distances) + '; top_residue=100=4R')
print('scalar_digits=' + str(tuple(scalar_digits)) + '; omitted_J_countercontrol=passed')
print('internal_boundary_tags=' + str(boundary_tags) + '; complement_distances=' + str(tuple(complements)))
print('fixed_groups=8 passed; speed_domain_enumeration=none; carry_replay=none; Lean_execution=none')
```

Replay in memory from the repository root:

```sh
python3 -B - <<'PY'
from contextlib import redirect_stdout
from hashlib import sha256
from io import StringIO
from pathlib import Path
s = Path('research/astra-five-adic-hard-adapter-plan.md').read_text()
assert s.count('```python\n') == 1
program = s.split('```python\n',1)[1].split('```',1)[0]
out = StringIO()
with redirect_stdout(out):
    exec(compile(program, '<five-adic-natural-hard-adapter>', 'exec'), {})
print(out.getvalue(), end='')
print('program_sha256=' + sha256(program.encode()).hexdigest())
print('stdout_sha256=' + sha256(out.getvalue().encode()).hexdigest())
PY
```

The exact replay completed with exit 0. All five stable-source/manuscript
guards and the eight fixed groups passed. The main wrapped multiplier 303
reduces to 53, and the four original cyclic distances are `(53,48,28,25)`
at R=25; the last distance is the retained top-digit-four equality.
Program SHA-256:
`2f31b920d2a028b347ff727136f43316f6d4b6fb55596b53c607881b758eddeb`.
Captured stdout SHA-256:
`5f8d96b8f0343722db74d39eb49b37da4d835510da24126482b294b4f73ab8b1`.
Program bytes are exactly the sole Python fence contents including its final
newline; the stdout hash covers its six result lines, excluding hash reports.
The workflow validator passed as a structural check only.

All owned commands have stopped; no Lean, cache-dependent or discovery process
was started or queued. Freeze outcome: the natural normalization, coupled-tag
construction, exact digit identity and conditional hard-pattern multiplier
contract are settled for review. Their formal implementation and the upstream
carry proof remain separate required work. No current mutable source hash,
unconditional formal hard-pattern theorem or complete five-runner result is
asserted by this manuscript.
