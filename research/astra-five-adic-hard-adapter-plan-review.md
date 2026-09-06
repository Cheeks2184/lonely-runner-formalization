# Independent review of the natural five-adic hard-pattern adapter

2026-09-06. Assigned reviewer `/root/mss_published_bound_audit`, requested
Astra/xhigh; runtime routing is not independently attested. Main checkpoint
`f55744833dd2876e582f0e4e0726614b6b527a54`. Current configuration, workflow,
policy and state were read and structural validation passed. Only this review
is owned. No Lean, build, cache access, source/other-manuscript edit or Git/state
mutation is performed. Active Carry and Filtering source files are neither
read nor used as guards; their interfaces are the explicit required contracts
quoted in the frozen manuscripts, not a claim about current compiled bytes.

**Verdict: accept the proposed conditional adapter for implementation.**
The natural complement method correctly avoids signed division, preserves all
three original unit distances for the same later multiplier, and handles the
closed top-digit-four boundary. No semantic correction is required.

The complete reviewed author artifact is
`research/astra-five-adic-hard-adapter-plan.md`, SHA-256
`f2d5e74769d86dc729d0f63f098654a9a538bf690e0c47d952272259bba37eef`.
Its five stable source/manuscript dependencies are guarded by the reproducer
below. I also read the existing cyclic distance definition and full natural
residue-to-circle-norm bridge in PivotResidues. The present verdict is a
manuscript and contract review, not a kernel proof or live-source audit.

## Distance symmetry and natural normalization

For positive P, let a=X%P and b=Y%P. If (X+Y)%P=0, then a+b is a
multiple of P in [0,2P). It is therefore either zero, forcing a=b=0,
or P, giving b=P-a and a=P-b. The minima defining cyclic distance are
equal in both cases. This includes P=1, composite moduli, zero residues
and the half-modulus boundary; no unit or primality premise is needed.

For s<=P and every natural A, A*(P-s)+A*s=A*P, so that symmetry applies
after multiplication without cancellation. In particular A may be zero or
a nonunit and may annihilate a nonzero residue. The bound s<=P is essential
for the displayed natural-subtraction identity. The other two congruence
corollaries follow directly from multiplication modulo P and also need no
unit multiplier.

For P=5*5^m and a 5-unit d, s=d%P satisfies 0<s<P and s%5=d%5.
Choose s for residues 1,2, and P-s for residues 3,4. In the latter case
x+s=P forces x%5 to be 2,1 respectively. Thus 0<x<P and x%5 is 1 or 2.
The generic symmetry and congruence lemmas prove distance(A*x)=distance(A*d)
for every A at once. Independent coordinate choices therefore preserve
one common later time; they do not introduce coordinate-dependent multipliers.
This constructor is valid at m=0 as stated.

## Coupled carries, bounded states and exact digit identity

The four selector branches are the exact intervals
3z<R; R<=3z with 2z<R; R<=2z with 3z<2R; and 2R<=3z, subject to
0<=z<R. They yield (floor(2z/R),floor(3z/R)) equal to (0,0), (0,1),
(1,1), (1,2). The strict tests assign equality at R/3, R/2 and 2R/3
to the correct upper interval. The multiplier-one quotient is zero.
Thus one Fin 4 tag realizes all three carry entries simultaneously for
every positive R, including R=1 and denominators divisible by 2 or 3.

For R=5^m, x<5R implies x/R<5. The normalized residue is 1 or 2,
so the proposed top, residue and carry fields have the stated finite bounds.
No extra reduction of the top or independent choice of carries is used.
The residue premise also implies x>0; it is not a new hidden hypothesis.

Writing x=R*a+z and J=u.val+1 gives
(J*x)/R=J*a+(J*z)/R. Adding J*k*R*x to J*x then adds exactly J*k*x
to this quotient. Consequently, for every m>=0,

```text
fiveAdicDigit m (J*(1+k*R)*x)
  = (J*a + floor(J*z/R) + J*k*(x%5)) % 5.
```

This proves the proposed state-digit lemma directly and explains the reuse
of the selected-level identity at ell=0 with current multiplier A=J.
The coefficient is (J*x)%5; omitting J from the translation is false.
Neither this division identity nor the state/tag constructor requires
the correction to be a unit. Thus the m=0 helper scope is sound even though
the later automatic-unit argument uses m>=1.

## Conditional assembly and preserved scope

The only carry premise remains exactly

```lean
hcarry : ∀ s : Fin 3 → FiveCarryState,
  ∃ u : Fin 3, ∃ k : Fin 5, ∀ i,
    (fiveCarryDigit (s i) u k).val ∈ ({1, 2, 3} : Finset Nat)
```

Apply it once to the three normalized states. Their common u,k supplies
Araw=J*(1+kR), and the exact digit identity gives the required distance
bound for each normalized unit. The universal normalization equality transfers
all three bounds to the original d_i, at precisely that same Araw.

For m>=1, R is divisible by 5, so Araw%5=J in {1,2,3}. This proves
Araw is a positive 5-unit. For the separate top speed R*v, its residue is
R*((Araw*v)%5); primality of 5 and the two unit assumptions place the latter
factor in {1,2,3,4}. All four factors give distance at least R. In particular
factor 4 gives equality and must not be sent through the units' narrower
digit-in-{1,2,3} predicate.

Set lambda=Araw%P only after these facts are proved. Since 5 divides P,
lambda%5=J is nonzero; hence 0<lambda<P and 5 does not divide lambda.
Multiplication modulo P preserves all four distances. Araw itself need not
be below P, and positivity of Araw alone would not prove positivity of lambda.
The proposed conclusion needs no ordering, injectivity, common gcd of one,
largest-speed interpretation, strict seed or lower-count premise. The unit
assumptions exclude zero speeds automatically.

The stable circleNorm_nat_div_ge theorem takes P>0 and the natural distance
bound directly. At t=lambda/P the phase is (lambda*d)/P and R/P=1/5;
therefore it yields all four closed fifth margins at a positive common t<1.
This is an ordinary threshold, not a fastest-quarter mixed conclusion.

The proposed implementation order is sound: generic symmetry/congruence,
unit normalization, coupled tag and bounded state, exact digit identity,
then the explicitly conditional assembly. The filtering descent is not
needed here. The carry proof, current source checks, all-pattern assembly
and canonical real five-total bridge remain separate obligations. No new
unconditional formal result or unrestricted LRC resolution is claimed.

## Guarded fixed reproducer

The sole Python block replays only the author's eight fixed control groups.
Additional controls use four specified symmetry inputs, four complement
inputs, the normalization of d=13 at m=0 with four supplied multipliers,
three specified carry-boundary inputs, two fixed state-digit identities and
one repeated/unsorted tuple at the already supplied time 53/125. It searches
no tuple domain or carry states and invokes no Lean or build command.

```python
from pathlib import Path
from hashlib import sha256
from contextlib import redirect_stdout
from fractions import Fraction
import ast, io, json, re

author = Path('research/astra-five-adic-hard-adapter-plan.md')
author_hash = 'f2d5e74769d86dc729d0f63f098654a9a538bf690e0c47d952272259bba37eef'
assert sha256(author.read_bytes()).hexdigest() == author_hash
f = chr(96)*3
blocks = re.findall(rf'^{f}python\n(.*?)^{f}[ \t]*$',author.read_text(),re.M|re.S)
assert len(blocks) == 1
program = blocks[0]
assert sha256(program.encode()).hexdigest() == '2f31b920d2a028b347ff727136f43316f6d4b6fb55596b53c607881b758eddeb'
out = io.StringIO()
with redirect_stdout(out):
    exec(compile(program,'<reviewed-hard-adapter-fixed-controls>','exec'),{})
assert sha256(out.getvalue().encode()).hexdigest() == '5f8d96b8f0343722db74d39eb49b37da4d835510da24126482b294b4f73ab8b1'
print(out.getvalue(),end='')

def dist(P,x):
    r = x%P
    return min(r,P-r)

symmetry_inputs = ((1,0,0),(6,0,12),(6,14,4),(6,15,3))
for P,X,Y in symmetry_inputs:
    assert P > 0 and (X+Y)%P == 0
    a,b = X%P,Y%P
    assert a+b in (0,P) and dist(P,X) == dist(P,Y)
complement_inputs = ((6,6,4),(6,0,5),(6,2,2),(6,2,3))
for P,s,A in complement_inputs:
    assert s <= P and A*(P-s)+A*s == A*P
    assert dist(P,A*(P-s)) == dist(P,A*s)
assert dist(6,max(6-8,0)) != dist(6,8)  # Dropping s<=P is false for Nat subtraction.

d,P = 13,5
s = d%P
x = s if s%5 in (1,2) else P-s
assert x == 2 and 0 < x < P and x%5 in (1,2)
for A in (0,1,5,6):
    assert dist(P,A*x) == dist(P,A*d)

C = ((0,0,0),(0,0,1),(0,1,1),(0,1,2))
def tag(R,z):
    assert R > 0 and 0 <= z < R
    return 0 if 3*z < R else 1 if 2*z < R else 2 if 3*z < 2*R else 3
for R,z,expected in ((3,1,1),(2,1,2),(3,2,3)):
    c = tag(R,z)
    assert c == expected and C[c] == (z//R,2*z//R,3*z//R)
assert tag(1,0) == 0

digits = []
for m,x,J,k,expected in ((0,2,2,1,3),(2,122,3,4,3)):
    R = 5**m
    assert x < 5*R and x%5 in (1,2)
    a,z,r,c = x//R,x%R,x%5,tag(R,x%R)
    assert a < 5
    raw = J*(1+k*R)
    actual = raw*x//R%5
    predicted = (J*a+C[c][J-1]+J*k*r)%5
    assert actual == predicted == expected
    digits.append(actual)
    if m == 0:
        assert (J*a+C[c][J-1]+k*r)%5 != actual
assert (2*(1+4*5**0))%5 == 0  # Arbitrary corrections need not be units at m=0.

def norm(q):
    r = q-q.numerator//q.denominator
    return min(r,1-r)
t = Fraction(53,125)
fixed_speeds = (49,49,1,75)
norms = tuple(norm(t*w) for w in fixed_speeds)
assert norms == (Fraction(28,125),Fraction(28,125),Fraction(53,125),Fraction(1,5))
assert 0 < t < 1 and all(y >= Fraction(1,5) for y in norms)

node = next(n for n in ast.parse(program).body if isinstance(n,ast.Assign)
    and any(isinstance(t,ast.Name) and t.id == 'guards' for t in n.targets))
guards = ast.literal_eval(node.value)
assert len(guards) == 5
assert 'LonelyRunner/FiveAdicCarry.lean' not in guards
assert 'LonelyRunner/FiveAdicFiltering.lean' not in guards
for path,digest in guards.items():
    assert sha256(Path(path).read_bytes()).hexdigest() == digest,path
assert sha256(author.read_bytes()).hexdigest() == author_hash
print(json.dumps({'result':'PASS','stable_guards':5,'author_guard':True,
    'symmetry_inputs':4,'complement_inputs':4,'m0_normalization_multipliers':4,
    'boundary_inputs':3,'fixed_digit_identities':2,'fixed_real_time':'53/125',
    'mutable_source_guards':False,'Lean_execution':False,'tuple_scan':False},sort_keys=True))
```

## Terminal receipt

The sole review Python block was extracted from this file and executed with
`python3 -B -`. Its first execution ended with terminal exit 0, tool chunk
`195e06`. The exact author artifact/program/stdout matched, and its eight
fixed groups passed. All additional symmetry, complement, normalization,
boundary, digit and shared-time controls passed. There was no failed review
control run, no carry-state replay and no tuple-domain scan.

The fixed m=0 countercontrol shows only that an arbitrary chosen correction
need not be a unit there; it does not refute a separately proved m=0 supply
statement. The failed s>P complement identity uses actual truncated natural
subtraction and records why the lemma's s<=P guard is necessary.

| Frozen executable evidence | SHA-256 |
| --- | --- |
| Author Python block | `2f31b920d2a028b347ff727136f43316f6d4b6fb55596b53c607881b758eddeb` |
| Raw author stdout | `5f8d96b8f0343722db74d39eb49b37da4d835510da24126482b294b4f73ab8b1` |
| Sole review Python block | `dbeed1d7d0877b80cdf0403e89039c8026e6065bb071b3ad5baddf52d981f5fc` |
| Raw review-program stdout | `32d740a8452f81bc8aff63fe064f13772088d084f2415b7f27b0f23a799256b3` |

The last hash covers the author's six printed lines and the final JSON,
excluding an outer runner's hash labels. The five stable dependencies and
the author artifact are checked again after execution. Final structural
workflow validation passed; it is not mathematical certification.

The reviewed plan requires no semantic change. Preserve the exact
conditional hcarry contract and the original ordinary closed thresholds
during implementation. The carry kernel proof, adapter source proof and
subsequent all-pattern/canonical bridges remain outstanding. All reviewer
processes have stopped, and the active Lean files and shared cache are
untouched. Unrestricted LRC remains unresolved.
