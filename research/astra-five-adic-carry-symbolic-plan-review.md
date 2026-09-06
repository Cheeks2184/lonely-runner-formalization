# Independent review of symbolic five-adic carry assembly

2026-09-06. Reviewer `/root/mss_published_bound_audit`, requested Astra/xhigh;
runtime routing is not independently attested. Assignment checkpoint:
`f55744833dd2876e582f0e4e0726614b6b527a54`. Current configuration, workflow,
policy and state were read; structural validation passed. Only this review
is owned. No Lean command, cache access, source edit, other manuscript edit,
Git/state mutation or further 64,000-triple replay is performed.

**Verdict: accept the symbolic plan for bounded implementation without changing
the public theorem.** I read the entire proposed plan, preserved failed Lean
source, failure report and original carry plan. The normalized helpers and
algebraic assembly imply precisely the existing fiveCarryTriple, with no
state-distinctness, equal-residue, valuation or realizability hypothesis added.
This is manuscript acceptance; the source is still a failed kernel attempt.

| Exact input | SHA-256 |
| --- | --- |
| `research/astra-five-adic-carry-symbolic-plan.md` | `d1fef1fafc6c7ae6adaf0ee885b4d44931e26bda667ff040f6c237f082555f80` |
| `LonelyRunner/FiveAdicCarry.lean` | `edcc4c6a1c8a31ce6188b92d9d0a21d09f01013027290d6ed6cfeb3d1876fdb3` |
| `research/astra-five-adic-carry-implementation.md` | `610a1326baed5cab1aaef93030fa8e5ff36738c167514bd5685823c1d9ada9db` |
| `research/astra-five-adic-carry-plan.md` | `da1a4f4828f6e9d9cae6ed601151e0b56b518bea8e9add524e06b289b1713e69` |

## Helper contracts and mathematical justification

The source's carry rows are exactly (0,0,0), (0,0,1), (0,1,1),
(0,1,2), with multiplier J=u.val+1 and residue rho=r.val+1.
Its public digit is (J*top+carry+J*k*rho)%5. These definitions must remain
unchanged. In particular the two carries come from one tag; allowing the
two omitted pairs would invalidate the argument.

T has exactly 5*5*4*4*4=1,600 universal inputs. Its free h is an arbitrary
common digit translation after choosing J, which is exactly what the later
nonzero coefficient J*rho permits. It is not a constrained original time.
Subtracting the first top position removes absolute position without changing
any carry tag. Translating all top positions by t adds J*t to every selected
digit, preserving the property of lying in a three-block. Relabelling moves
the corresponding carry tags with their positions.

The three-block proof is valid even with repeated digits: at most two distinct
points always fit in a three-block on the five-cycle. Otherwise a failing
triple is a translate of {0,2,3}. At J=2 its second digit must be 4 and its
third digit 2 if no three-block works. This forces their double carries to
be 0 and 1 respectively. The coupled triple carries then put all J=3 digits
in {0,1,2}. Translation into {1,2,3} proves T with all carry tags allowed.

P has exactly 5*4*4=80 universal inputs. A nonadjacent pair can be translated
and swapped to {0,2}. At J=2 the only failure is (1,4), forcing double
carries (1,0), and hence J=3 digits both in {1,2}. Its output is a block
location b, not a translation k. Coincident digits may be extended to a
two-block. The wrapped block at b=4 is {4,0}, so omitting wraparound would
break the intended contract. The printed natural Block predicate handles it.

The proposed finite checks therefore prove small genuine sublemmas; they
do not merely repartition the original full-state theorem. The replay below
checks all T and P inputs and only the stated 28 scalar-helper inputs.

## Casts and symbolic assembly

In F=ZMod 5 every element has a unique representative from Fin 5. Casting
natural addition and multiplication and removing remainder modulo 5 gives
the exact public digit identity. Because B is already in [0,5), equality
of its cast to b or b+1 is equivalent to the stated natural block predicate,
including b=4. For G on an unreduced sum, first reduce the sum modulo 5;
then the five-value equivalence with z=1 or z=2 or z=3 applies. This avoids
silently treating an arbitrary natural sum as its bounded representative.
None of these identities requires a product enumeration over states.

For equal residues r, choose differences d=A(b)-A(a) and e=A(c)-A(a)
in F and use their Fin 5 representatives in T. With D=J*r nonzero, solve
D*K=h-J*A(a). Substitution gives J*(A(x)-A(a))+C(x)+h for each state.
These are exactly the three T outputs. The representative k of K preserves
them through the unchanged public digit formula. The carry tag of the
anchoring state need not be zero; T explicitly includes it.

For the equal-residue pair a,b, P puts each unshifted digit at U or U+1,
where U=J*A(a)+b0. Set K0=(1-U)/D and K1=(2-U)/D. The pair's digits
are respectively in {1,2} and {2,3}; this remains true for a wrapped block
or coincident pair digits. K1-K0=1/D. The third state's displacement is
J*(K1-K0)*r'=r'/r, which is 2 for r=1,r'=2 and 3 for the reverse case.
If its first digit is outside {1,2,3}, it is 0 or 4, and either displacement
makes the second digit good. Thus choosing K0 or K1 preserves the same
translation for all three states. The cancellations require only J,r nonzero,
as the proposed six-input scalar fact supplies.

The eight residue triples split into exactly the four stated cases. In the
last two pair cases the calls on (a,c,b) and (b,c,a) are correctly reordered
afterward. The public wrapper then applies the private three-state theorem
to s 0, s 1, s 2 and eliminates Fin 3. No new assumption remains, and no
order or distinctness of top digits is used.

The whole future source must still meet the single 60-second/4-GiB monitored
cap. Smaller logical domains do not establish a Lean resource measurement.
Use T and P as theorem constants in algebraic proofs; do not unfold the
whole target into another full-state decide. If T exceeds the cap, stop
that evaluation and use its small geometry proof as the author directs.
The failure report records a recursion-depth failure and three RSS-limited
evaluations, not counterexamples. This review neither reruns nor promotes
any of them. Kernel type/axiom checks and the integer/sign adapter remain
outstanding; no complete five-total-runner or unrestricted LRC result follows
from manuscript acceptance alone.

## Guarded bounded reproducer

Run the sole Python block from the repository root. It replays exactly the
author's six small helper domains, then checks five fixed algebraic assemblies:
one equal-residue J=3 case, both unequal-residue ratios with J=3 pair
compression, a wrapped block, and a repeated triple. The remaining fixed
representative checks concern only four specified integers. No full-state
enumeration, speed discovery, Lean command or resource benchmark is invoked.

```python
from pathlib import Path
from hashlib import sha256
from contextlib import redirect_stdout
import ast, io, json, re

author = Path('research/astra-five-adic-carry-symbolic-plan.md')
author_hash = 'd1fef1fafc6c7ae6adaf0ee885b4d44931e26bda667ff040f6c237f082555f80'
assert sha256(author.read_bytes()).hexdigest() == author_hash
f = chr(96)*3
blocks = re.findall(rf'^{f}python\n(.*?)^{f}[ \t]*$',author.read_text(),re.M|re.S)
assert len(blocks) == 1
program = blocks[0]
assert sha256(program.encode()).hexdigest() == 'ffd0739e680cbc3c12e3ac0e35cb6b41e6f3b6c4a5a3db4500c76031de4aa6aa'
out = io.StringIO()
with redirect_stdout(out):
    exec(compile(program,'<reviewed-symbolic-carry-helpers>','exec'),{})
assert sha256(out.getvalue().encode()).hexdigest() == '3e95ff25d9c4e17ecf30b7979b6d48ef1b6912fcfe2923bc6fbb4e9914e3553c'
print(out.getvalue(),end='')

C = ((0,0,0),(0,0,1),(0,1,1),(0,1,2))
def base(d,c,u):
    return ((u+1)*d+C[c][u])%5
def good(x):
    return x%5 in (1,2,3)
def digit(s,u,k):
    a,r,c = s
    return ((u+1)*a+C[c][u]+(u+1)*k*(r+1))%5
def block(x,b):
    return x == b or x == (b+1)%5

def same_fixed(states):
    a,b,c = states
    assert a[1] == b[1] == c[1]
    d,e = (b[0]-a[0])%5,(c[0]-a[0])%5
    u,h = next((u,h) for u in range(3) for h in range(5)
        if all(good(base(x,s[2],u)+h) for x,s in zip((0,d,e),states)))
    J,r = u+1,a[1]+1
    k = ((h-J*a[0])*pow(J*r,-1,5))%5
    for x,s in zip((0,d,e),states):
        assert digit(s,u,k) == (J*x+C[s[2]][u]+h)%5
        assert good(digit(s,u,k))
    return u,k

def pair_fixed(states):
    a,b,c = states
    assert a[1] == b[1] and a[1] != c[1]
    d = (b[0]-a[0])%5
    u,b0 = next((u,b0) for u in range(3) for b0 in range(5)
        if block(base(0,a[2],u),b0) and block(base(d,b[2],u),b0))
    J,r,rp = u+1,a[1]+1,c[1]+1
    U,D = (J*a[0]+b0)%5,J*r%5
    k0,k1 = ((1-U)*pow(D,-1,5))%5,((2-U)*pow(D,-1,5))%5
    assert all(digit(s,u,k0) in (1,2) and digit(s,u,k1) in (2,3) for s in (a,b))
    delta = rp*pow(r,-1,5)%5
    assert delta in (2,3)
    y0,y1 = digit(c,u,k0),digit(c,u,k1)
    assert y1 == (y0+delta)%5
    assert good(y0) or good(y1)
    k = k0 if good(y0) else k1
    assert all(good(digit(s,u,k)) for s in states)
    return u,b0,delta,y0,y1,k

assert same_fixed(((3,1,0),(4,1,2),(1,1,0))) == (2,3)
assert pair_fixed(((4,0,2),(1,0,0),(2,1,0))) == (2,0,2,4,1,0)
assert pair_fixed(((4,1,2),(1,1,0),(4,0,0))) == (2,0,3,4,2,0)
assert pair_fixed(((2,0,0),(1,0,0),(4,1,0))) == (0,4,2,4,1,1)
assert same_fixed(((4,0,3),(4,0,3),(4,0,3))) == (0,2)
assert block(0,4) and block(4,4) and not block(1,4)
for z in (-7,0,9,14):
    rep = z%5
    assert 0 <= rep < 5 and (rep-z)%5 == 0
    assert good(z) == good(rep)

node = next(n for n in ast.parse(program).body if isinstance(n,ast.Assign)
    and any(isinstance(t,ast.Name) and t.id == 'guards' for t in n.targets))
guards = ast.literal_eval(node.value)
assert len(guards) == 3
for path,digest in guards.items():
    assert sha256(Path(path).read_bytes()).hexdigest() == digest,path
assert sha256(author.read_bytes()).hexdigest() == author_hash
print(json.dumps({'result':'PASS','source_guards':3,'author_guard':True,
    'helper_inputs':1708,'fixed_assemblies':5,'fixed_representatives':4,
    'full_64000_replay':False,'Lean_execution':False},sort_keys=True))
```

## Terminal receipt

The author-only guarded replay ended with terminal exit 0, tool chunk
`f7f871`. The sole review program above was then extracted from this file
and executed using `python3 -B -`; its first execution ended with terminal
exit 0, tool chunk `735bf2`. There was no failed review control run.
All exact input guards and author stdout matched. T passed 1,600 inputs,
P passed 80, and the scalar helpers passed 28, for 1,708 total; their
candidate counts remain exactly 24,000 and 1,200. All five fixed assembly
checks and four fixed representative checks passed. None of these executions
ran the original 64,000-triple program or invoked Lean.

| Frozen executable evidence | SHA-256 |
| --- | --- |
| Author Python block | `ffd0739e680cbc3c12e3ac0e35cb6b41e6f3b6c4a5a3db4500c76031de4aa6aa` |
| Raw author stdout | `3e95ff25d9c4e17ecf30b7979b6d48ef1b6912fcfe2923bc6fbb4e9914e3553c` |
| Sole review Python block | `cf2eeb638a05889118e1037ec4886c7e60fd13e09539020d93287beafe01e309` |
| Raw review-program stdout | `cfe6f316074907d94ca56bbd91d781c34d80e3b70ee4c3917d9f5624942bb8ff` |

The review stdout hash includes the replayed author's six lines and final
JSON, excluding the outer runner's hash labels. The guards are checked again
after the controls. Final structural workflow validation passed; it does not
certify mathematical truth.

No correction is required before bounded implementation. Preserve the exact
public definitions and theorem, prove the two small helpers, then perform
the symbolic field assembly and eight-case residue split. The full future
source check retains one 60-second/4-GiB cap and requires its own successful
kernel and allowed-axiom evidence. All reviewer processes have stopped, with
no source or cache changes. Unrestricted LRC remains unresolved.
