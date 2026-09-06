# Independent review of the five-adic filtering plan

2026-09-06. Assigned reviewer `/root/mss_published_bound_audit`, requested
Astra/xhigh; runtime routing is not independently attested. Source checkpoint
`84eacffc06cabd017d67c53d1d70995a8d25de3d`. The current configuration,
workflow, policy and state were read, and workflow validation passed with
research authorized and in progress. Only this review is owned. No Lean or
build command is run, and no source, other manuscript, Git state, workflow
state or cache is modified. The pinned Mathlib files are read-only inputs.

**Mathematical verdict: accept the corrected plan for implementation.**
The natural arithmetic, finite avoidance, seeded induction and Fin 4 case
split have sound manuscript derivations. This verdict does not certify a
Lean declaration or the separately assigned three-unit carry theorem.

The exact reviewed author artifact is
`research/astra-five-adic-filter-plan.md`, SHA-256
`34725cc13001013cdeefa89d36620442bbe7d6ccffcc0ff6f85585bdd208f500`.
I read the complete corrected artifact. The prior direct-proof screen is
bound below as the published-proof scope record; the present acceptance is
based on the explicit decomposition-first argument, not on a paper abstract
or an assumed formalization of its prime-filtering lemma.

## Arithmetic and closed boundaries

Write R=5^m and P=5R. For every natural x, division first by R and then
by 5 gives x%P=R*((x/R)%5)+x%R. In particular the digit is determined
by the residue modulo P. A digit in {1,2,3} places the residue between
R and 4R-1, so both distances are at least R. This is only a sufficient
condition: residue 4R is also good at the closed boundary, although its
digit is 4. No top-level digit-avoidance hypothesis is justified.

With d=5^ell*u and ell=j<m, multiplication by C=1+k*5^(m-j)
adds exactly k*R*A*u to A*d. Dividing by positive R therefore adds
k*A*u to its quotient without a carry from the unchanged remainder.
Modulo 5 the coefficient is (A*u)%5. It is nonzero because neither
factor is divisible by the prime 5. For ell>j the added term contains
5^(m-j+ell), which is divisible by P since m-j+ell>=m+1.
This proves equality of whole higher residues, not merely their digits.
The assumption j<m also proves C%5=1 and C>0; allowing j=m would
admit C=5 at k=4 and invalidate the unit invariant.

At ell=m, the residue is R*((A*u)%5), with the latter factor in
{1,2,3,4}. Every such residue has distance at least R, regardless of
the number of top labels or repeated values. Thus m=0 and all-top
families require no filtering. In the unseeded theorem lambda=1 works
for m=0, including an empty label type.

## Avoidance, induction and representatives

For each nonzero s in Fin 5, multiplication by s is a permutation.
The two equations q+k*s=0 and q+k*s=4 forbid exactly two distinct
choices of k. Two labels forbid at most four choices; repeated rows
can only decrease the size of their union. The proposed Fin 2 type is
correct as modular Fin arithmetic. Its arbitrary-cardinality wrapper
must handle card 0 separately, duplicate a singleton row, and use an
equivalence with Fin 2 for card 2. This counts labels, not values.
No injectivity of d, u, q or s belongs in the contract.

The seeded induction is correctly generalized over every cutoff h<=m
and every positive unit A, with exact residue preservation for ell>=h.
At h=r+1, correcting level r leaves all older levels fixed and makes
level r good. The recursive call at r consequently has all required
high distance bounds. Its exact high-residue conclusion preserves the
newly filled level r, including its good digit, and composes with the
previous residue equalities above r. The recursive lower-digit conclusion
covers ell<r. The base h=0 simply retains A. This proves the unbounded
multiplier version without a problematic growing bound in the induction.

For its output B, set lambda=B%P. Since 5 divides P, lambda%5=B%5
is nonzero, hence 0<lambda<P. Multiplication preserves the residues
modulo P, and the quotient-digit identity preserves all good digits.
It also preserves the seed's residue modulo 5. Consequently the stated
strong unseeded conclusion lambda%5=1 and unchanged top residues is
valid, even with unused levels, no attained maximum or arbitrary many
top labels. This stronger residue-one condition applies to the unseeded
filter branch; it is not required of the separate hard-branch multiplier.

## Fin 4 assembly and implementation boundaries

The source-read valuation APIs have the stated hypotheses: install
Fact (Nat.Prime 5), use positive speeds to exclude zero in the maximal
valuation fact, and obtain exact divisibility before dividing. The imported
root theorem pow_padicValNat_dvd is defined in Data/Nat/MaxPowDiv.lean
and needs no extra hypothesis. Together with
pow_succ_padicValNat_not_dvd, this gives d=5^ell*u and 5 not dividing u.
The core arithmetic need not import valuations or a p-adic field.
The optional primitive-factorization lemma is unconditional but unnecessary.

For Fin 4, if a lower layer has more than two labels, its at least three
labels and one attained maximum exhaust the four positions. There are
exactly three at a single j<m and exactly one at m; no intermediate
or smaller level remains. Repetition of speed values does not alter this
argument. Divide by 5^j only here. The reduced maximum is m-j>0,
the three lower entries are units, and the fourth is at the top level.

The correction in the author artifact is necessary and sufficient:
the hard theorem's raw a*(1+k*R') need not be below P'. Reduce it
modulo P' before asserting 0<lambda<P'. It remains a unit because
R' is divisible by 5 and a is 1, 2 or 3. Products retain their residues.
For g=5^j>0, the exact equality (g*x)%(g*P')=g*(x%P') and
natural subtraction then give scaled cyclic distance g times the original.
Since g*R'=R and g*P'=P, the bound returns to the original modulus
P=5^(m+1), with lambda<P'<=P. The time lambda/P is positive and
its phase for the original speed g*d equals lambda*d/P'. The existing
circleNorm_nat_div_ge therefore gives the same-time closed fifth bound.
No global gcd or minimum normalization is needed.

Implement the natural identities and two-row avoidance first, followed by
the seeded unbounded induction and a separate residue-representative helper.
Then derive the stated unseeded theorem and the valuation/classification
adapter. Keep the carry/sign theorem an explicit dependency of the hard
branch. The complete natural Fin 4 ordinary theorem, H6/canonical bridge,
mixed supply and unrestricted LRC are not established by this plan review.

## Guarded reproducible checks

The sole Python block replays the exact author program, including its seven
source guards, then checks five fixed filtering calls, three fixed Fin 4
level lists and one fixed hard-branch scaling fixture. Each filtering step
examines only the five choices of k on its supplied labels. No speed tuple
domain is enumerated, and no Lean command is launched. These controls check
the analytic edge cases; they are not substitutes for the induction proof.

```python
from pathlib import Path
from hashlib import sha256
from contextlib import redirect_stdout
from fractions import Fraction
import ast, io, json, re

author_path = Path('research/astra-five-adic-filter-plan.md')
author_hash = '34725cc13001013cdeefa89d36620442bbe7d6ccffcc0ff6f85585bdd208f500'
assert sha256(author_path.read_bytes()).hexdigest() == author_hash
f = chr(96)*3
blocks = re.findall(rf'^{f}python\n(.*?)^{f}[ \t]*$',author_path.read_text(),re.M|re.S)
assert len(blocks) == 1
program = blocks[0]
assert sha256(program.encode()).hexdigest() == 'e17d3a5c02a94cffb1e599db2ceb57e3b36e954776e5b992e3fac9b1ebd527e3'
out = io.StringIO()
with redirect_stdout(out):
    exec(compile(program,'<reviewed-five-adic-author-controls>','exec'),{})
assert sha256(out.getvalue().encode()).hexdigest() == '68be37f01856a5938e64e989c8b0b1ab90430f10dd04415a93e67497837003aa'
print(out.getvalue(),end='')
extra_path = '.lake/packages/mathlib/Mathlib/Data/Nat/MaxPowDiv.lean'
extra_hash = '16f080a2837b7c9c15592f02967af5dea3b0bf9506df47ca3873abb3ea3f1bfd'
assert sha256(Path(extra_path).read_bytes()).hexdigest() == extra_hash

def distance(P,x):
    r = x % P
    return min(r,P-r)

def fixed_filter(m,h,seed,ell,u):
    R,P = 5**m,5**(m+1)
    d = [5**e*v for e,v in zip(ell,u)]
    assert len(ell) == len(u) and 0 <= h <= m and seed > 0 and seed%5 != 0
    assert all(0 <= e <= m and v > 0 and v%5 != 0 for e,v in zip(ell,u))
    assert all(ell.count(j) <= 2 for j in range(h))
    assert all(distance(P,seed*x) >= R for e,x in zip(ell,d) if e >= h)
    A,trace = seed,[]
    for j in reversed(range(h)):
        rows = [(A*x//R%5,A*v%5) for e,v,x in zip(ell,u,d) if e == j]
        choices = [k for k in range(5) if all((q+k*s)%5 in (1,2,3) for q,s in rows)]
        assert choices
        k = choices[0]
        B = (1+k*5**(m-j))*A
        assert B > 0 and B%5 == A%5
        assert all((B*x)%P == (A*x)%P for e,x in zip(ell,d) if e > j)
        assert all((B*x//R)%5 in (1,2,3) for e,x in zip(ell,d) if e == j)
        A = B
        trace.append((j,k,A))
    lam = A%P
    assert 0 < lam < P and lam%5 == seed%5 != 0
    assert all((lam*x)%P == (seed*x)%P for e,x in zip(ell,d) if e >= h)
    assert all((lam*x//R)%5 in (1,2,3) for e,x in zip(ell,d) if e < h)
    assert all(distance(P,lam*x) >= R for x in d)
    return lam,trace

levels,units = [0,0,1,2,3,3,3],[1,2,1,3,4,4,2]
seeded,trace = fixed_filter(3,3,2,levels,units)
assert seeded == 177 and trace == [(2,0,2),(1,1,52),(0,3,19552)]
unseeded,_ = fixed_filter(3,3,1,levels,units)
assert unseeded == 156 and unseeded%5 == 1
assert fixed_filter(2,1,2,[0,1,2],[1,3,4])[0] == 52
assert fixed_filter(2,0,127,[],[])[0] == 2
assert fixed_filter(0,0,1,[0,0,0,0,0],[1,4,6,14,4])[0] == 1
assert distance(25,20) == 5 and distance(25,21) == 4

def fixed_level_class(ell):
    assert len(ell) == 4
    m = max(ell)
    crowded = [j for j in set(ell) if j < m and ell.count(j) > 2]
    if not crowded:
        return 'filtered'
    assert len(crowded) == 1
    j = crowded[0]
    top = [i for i,e in enumerate(ell) if e == m]
    assert len(top) == 1 and all(e == j for i,e in enumerate(ell) if i != top[0])
    return 'hard'

assert fixed_level_class([1,1,1,3]) == 'hard'
assert fixed_level_class([0,0,2,3]) == 'filtered'
assert fixed_level_class([3,3,3,3]) == 'filtered'
g,Rp,Pp,raw = 5,5,25,63
lam = raw%Pp
assert raw > Pp and 0 < lam < Pp <= g*Pp and lam%5 == raw%5 != 0
for d in (1,3,7,5):
    assert distance(Pp,raw*d) == distance(Pp,lam*d) >= Rp
    assert distance(g*Pp,lam*g*d) == g*distance(Pp,lam*d) >= g*Rp
    assert Fraction(lam*g*d,g*Pp) == Fraction(lam*d,Pp)

guard_node = next(n for n in ast.parse(program).body if isinstance(n,ast.Assign)
    and any(isinstance(t,ast.Name) and t.id == 'guards' for t in n.targets))
guards = ast.literal_eval(guard_node.value)
assert len(guards) == 7
for path,digest in guards.items():
    assert sha256(Path(path).read_bytes()).hexdigest() == digest,path
assert sha256(Path(extra_path).read_bytes()).hexdigest() == extra_hash
assert sha256(author_path.read_bytes()).hexdigest() == author_hash
print(json.dumps({'result':'PASS','source_guards':8,'author_guard':True,
    'fixed_filter_calls':5,'fixed_level_lists':3,'fixed_scaling_coordinates':4,
    'seeded_lambda':seeded,'unseeded_lambda':unseeded,
    'Lean_execution':False,'speed_tuple_scan':False},sort_keys=True))
```

## Terminal receipt

The author-only guarded replay completed first with terminal exit 0, tool
chunk `125751`. The sole review program above was then extracted from this
file and executed by `python3 -B -`; its first execution ended with terminal
exit 0, tool chunk `af0a05`. All author guards and exact stdout matched,
as did the eight source guards before/after the independent controls.
Five fixed filtering calls, three fixed level lists and four coordinates
of the single scaling fixture passed. There was no failed control run.

| Frozen input or executable evidence | SHA-256 |
| --- | --- |
| Corrected author artifact | `34725cc13001013cdeefa89d36620442bbe7d6ccffcc0ff6f85585bdd208f500` |
| Author Python block | `e17d3a5c02a94cffb1e599db2ceb57e3b36e954776e5b992e3fac9b1ebd527e3` |
| Raw author stdout | `68be37f01856a5938e64e989c8b0b1ab90430f10dd04415a93e67497837003aa` |
| Sole review Python block | `b8553819312dc09b1a9f96256b3116d671958fd602595a9905437c83e7cf7b1c` |
| Raw review-program stdout | `c02fa5df95bc7ba25992e67a122beb7e0fe4c94064a8636e3152d5c3c1fdf075` |

The last hash covers the program's printed author stdout and final JSON,
excluding an outer runner's hash labels. The corrected author artifact binds
its seven exact dependency hashes; the additional MaxPowDiv source is bound
explicitly in this review's program. No mutable implementation or root/audit
file is a guard. Final structural workflow validation passed.

No further correction is required. The plan is ready for the stated staged
implementation with the separate carry/sign contract still outstanding.
No finite control is promoted to an infinite or kernel theorem, and no
five-total-runner or unrestricted LRC result is claimed. All reviewer
processes have stopped; the shared cache is unchanged by this review.
