# Symbolic assembly of the finite five-adic carry theorem

2026-09-06. Requested Astra/xhigh author `/root/mixed_equivalence_freeze`;
routing is requested, not independently attested. Only this manuscript is
owned. Current configuration, workflow, policy and state were read; the
structural validator passed. Assigned checkpoint:
`84eacffc06cabd017d67c53d1d70995a8d25de3d`. No Lean, dependency/cache access,
source/state/Git edit, additional 64,000-state check or speed enumeration is
performed. Other work is preserved; unrestricted LRC remains unresolved.

**Settled recommendation:** replace the failed full-state `decide` helper by
two small normalized geometry/carry helpers and symbolic modular assembly.
Their input domains are 1,600 and 80, respectively. Four elementary residue
facts have domains of at most ten. Preserve all three public definitions and
the exact public theorem below. The 60-second/4-GiB cap applies to the whole
future source check, including all helpers and assembly; this plan does not
claim that the proposed Lean implementation has met it.

## Exact source and preserved contract

`LonelyRunner/FiveAdicCarry.lean` SHA-256:
`edcc4c6a1c8a31ce6188b92d9d0a21d09f01013027290d6ed6cfeb3d1876fdb3`.
The failure report is `research/astra-five-adic-carry-implementation.md`, SHA
`610a1326baed5cab1aaef93030fa8e5ff36738c167514bd5685823c1d9ada9db`.
The accepted mathematical starting plan is
`research/astra-five-adic-carry-plan.md`, SHA
`da1a4f4828f6e9d9cae6ed601151e0b56b518bea8e9add524e06b289b1713e69`.
All three were read. The source is a preserved failed attempt, not a compiled
proof. The report records one default-recursion failure and three later
evaluations exceeding the external RSS cap, including the three-explicit-state
encoding. Changing the quantifier representation did not solve that problem.

Retain `FiveCarryState` with `top : Fin 5`, `residue : Fin 2`, `carry : Fin 4`;
`fiveCarryCarry` with rows `(0,0,0),(0,0,1),(0,1,1),(0,1,2)`; and
`fiveCarryDigit` with the existing natural remainder formula. Retain verbatim:

```lean
theorem fiveCarryTriple : ∀ s : Fin 3 → FiveCarryState,
    ∃ u : Fin 3, ∃ k : Fin 5, ∀ i,
      (fiveCarryDigit (s i) u k).val ∈ ({1, 2, 3} : Finset Nat)
```

Do not add residue-equality, distinctness, carry-realizability or valuation
premises to this theorem. Replace the private `fiveCarryTripleThree` proof
and add only private supporting declarations. Its current final `fin_cases`
wrapper at `s 0,s 1,s 2` can remain unchanged.

## Two small finite helpers

In the following proposed API, define `Jnat u := u.val+1` and

```
B(d,c,u) := (Jnat(u)*d.val + fiveCarryCarry c u) mod 5.
G(v) := v mod 5 ∈ {1,2,3}.
Block(v,b) := v=b.val or v=(b.val+1) mod 5.
```

Use `private abbrev` for the finite predicates, or provide explicit decidable
instances. The earlier failure report shows that an opaque private predicate
can obstruct instance synthesis. These are normalized digits and a free
common translation, not full `FiveCarryState` values.

**T: normalized equal-residue triple (1,600 inputs).**

```lean
private theorem fiveCarryNormalizedTriple :
    ∀ d e : Fin 5, ∀ c0 c1 c2 : Fin 4,
      ∃ u : Fin 3, ∃ h : Fin 5,
        G (B 0 c0 u + h.val) ∧
        G (B d c1 u + h.val) ∧
        G (B e c2 u + h.val)
```

The domain is `5²*4³=1,600`, with 15 candidate (u,h) pairs per input. This
is exactly the equal-residue compression part of the existing manuscript:
the first top digit has been subtracted and the normalized residue itself
has disappeared. Its proof is the three-block argument. If the three top
digits do not already lie in a three-block, translate and permute them to
(0,2,3). Failure at multiplier 2 forces carry-2 values 0 at top 2 and 1 at
top 3. Their coupled carry-3 values then put all multiplier-3 digits in a
three-block. The common h moves that block into {1,2,3}.

**P: normalized pair compression (80 inputs).**

```lean
private theorem fiveCarryNormalizedPair :
    ∀ d : Fin 5, ∀ c0 c1 : Fin 4,
      ∃ u : Fin 3, ∃ b : Fin 5,
        Block (B 0 c0 u) b ∧ Block (B d c1 u) b
```

Its domain is `5*4²=80`, with 15 candidate (u,b) pairs. A pair already in
a two-block uses multiplier 1. Otherwise translate and swap it to (0,2).
The only multiplier-2 failure is (1,4); it forces carry-2 values (1,0),
whose coupled carry-3 values put both multiplier-3 digits in {1,2}.
The output is a block location b, not a time/translation k.

Both statements permit equal digits, equal carry tags and every listed carry
combination. The proofs never choose double and triple carries independently.
They may be proved by bounded ordinary `decide` on the explicitly displayed
closed quantifiers, or directly by the small geometry arguments above. Do not
encode a `Fin 3 → State` anywhere inside either finite check, and do not
implement 40 separate chunks of the original full domain. The reduction is
semantic: shared residue and absolute top position are handled algebraically.

## Modular bridge, with exact obligations

Use `F := ZMod 5` as the private algebraic layer. Write `ι(d)` for the cast
of `d.val` to F, `A(s)=ι(s.top)`, `ρ(r)=(r.val+1 : F)`,
`J(u)=(u.val+1 : F)`, `C(c,u)=(fiveCarryCarry c u : F)`, and
`Good(z) := z=1 ∨ z=2 ∨ z=3`. The following are proposed helper contracts;
library lemma names for their proofs can be selected during implementation.

1. `∀ z:F, ∃ d:Fin 5, ι(d)=z`, using the canonical residue of z, and
   `ι(d)=ι(e) ↔ d=e`. In particular
   `d.val∈{1,2,3} ↔ Good(ι(d))`. The last equivalence is a five-value fact;
   it is not a large state computation.
2. `ι(⟨B(d,c,u),...⟩)=J(u)*ι(d)+C(c,u)` and
   `G(B(d,c,u)+h.val) ↔ Good(J(u)*ι(d)+C(c,u)+ι(h))`.
   Cast natural addition/multiplication, remove remainder modulo 5 in F,
   and apply the preceding good-digit equivalence.
3. `Block(B(d,c,u),b)` implies
   `J(u)*ι(d)+C(c,u)=ι(b) ∨ J(u)*ι(d)+C(c,u)=ι(b)+1`.
   The converse is also true. This includes b=4: its second point is 0.
4. The central bridge to the unchanged public API is the algebraic identity

   `ι(fiveCarryDigit s u k) = J(u)*A(s)+C(s.carry,u)+J(u)*ι(k)*ρ(s.residue)`.

   Prove it by natural-cast/remainder identities, not by enumerating s,u,k.
5. For every u and r, `J(u)≠0`, `ρ(r)≠0`, hence `J(u)*ρ(r)≠0` in F.
   This is a six-input scalar fact. For distinct r,r':Fin 2,
   `ρ(r')/ρ(r)=2 ∨ ρ(r')/ρ(r)=3`; this has four inputs and two nonvacuous
   cases: 2/1=2 and 1/2=3 modulo 5.

If a state-translation lemma is useful, define `shift(s,h)` by replacing only
its top with the representative of `A(s)+h*ρ(s.residue)`. Its residue and
carry tag are definitionally unchanged. For a field-valued translation K,
the digit expression obeys

```
digitExpr(shift(s,h),u,K)=digitExpr(s,u,K+h).
```

This proves translation covariance without asserting anything about independent
carries. The assembly below can avoid constructing translated states entirely:
it uses top differences and solves directly for K in F. No original integer
speed, valuation or sign-normalization lemma is needed for this finite theorem.

## Symbolic assembly over three arbitrary states

First prove the following two private statements over explicit a,b,c states.
They should use T or P as opaque theorem constants and algebraic rewriting;
neither statement is another finite whole-state `decide` call.

```lean
private theorem fiveCarryTriple_same (a b c : FiveCarryState)
    (hab : a.residue = b.residue) (hac : a.residue = c.residue) :
    ∃ u : Fin 3, ∃ k : Fin 5,
      fiveCarryGood a u k ∧ fiveCarryGood b u k ∧ fiveCarryGood c u k

private theorem fiveCarryTriple_pair (a b c : FiveCarryState)
    (hab : a.residue = b.residue) (hac : a.residue ≠ c.residue) :
    ∃ u : Fin 3, ∃ k : Fin 5,
      fiveCarryGood a u k ∧ fiveCarryGood b u k ∧ fiveCarryGood c u k
```

**All residues equal.** Let their common residue be r. Choose d,e:Fin 5 with
`ι(d)=A(b)−A(a)` and `ι(e)=A(c)−A(a)`. Apply T to d,e and the unchanged
three carry tags, obtaining u,h. Set

```
D = J(u)*ρ(r) ≠ 0,
K = (ι(h)−J(u)*A(a))/D,
choose k:Fin 5 with ι(k)=K.
```

Then for each state x among a,b,c its public digit in F is
`J(u)*(A(x)−A(a))+C(x.carry,u)+ι(h)`.
This is exactly the corresponding good expression from T. For a itself the
difference is zero. Prove `D*ι(k)=ι(h)−J(u)*A(a)` once, then use `ring`
identities and the equal-residue hypotheses; no repeated search is involved.
The digit bridge and Good equivalence finish all three public comparisons.

**Exactly two equal residues.** Arrange a,b to share r and c to have r'≠r.
Choose d representing A(b)−A(a), and apply P to d and the a,b carry tags.
It returns u,b0. Set

```
U = J(u)*A(a)+ι(b0),    D = J(u)*ρ(r) ≠ 0,
K0 = (1−U)/D,         K1 = (2−U)/D,
choose k0,k1:Fin 5 representing K0,K1.
```

Before the translation, the a,b digit expressions each equal U or U+1 by
the block bridge. At k0 they therefore lie in {1,2}; at k1 they lie in {2,3}.
Both translations are good for both states, even if their digits coincide
or the initial block crosses zero.

Let `Y=J(u)*A(c)+C(c.carry,u)+J(u)*K0*ρ(r')`. The c digit at k1 equals

```
Y + J(u)*(K1−K0)*ρ(r') = Y + ρ(r')/ρ(r),
```

because `K1−K0=1/D`. The final displacement is 2 or 3. Use the tiny fact
`Good(Y) ∨ Good(Y+delta)` for delta∈{2,3}: if Y is not good, it is 0 or 4,
and either displacement makes it good. This fact has only `5*2=10` inputs
when encoded by Y:Fin 5 and delta-tag:Fin 2 decoded as delta-tag.val+2.
Select k0 or k1 accordingly. All three public digit comparisons follow.

Finally use the eight-input residue partition

```
∀ r0 r1 r2 : Fin 2,
  (r0=r1 ∧ r1=r2) ∨ (r0=r1 ∧ r0≠r2) ∨
  (r0=r2 ∧ r0≠r1) ∨ (r1=r2 ∧ r1≠r0).
```

For a,b,c, these four cases call the equal-residue result on (a,b,c), or the
pair result on (a,b,c), (a,c,b), or (b,c,a), respectively. Reorder the three
conjuncts afterward. No permutation data, `Equiv` enumeration, ordering of
top digits or state distinctness hypothesis is needed. This supplies the
private `fiveCarryTripleThree`, and the unchanged public wrapper then follows.

## Resource boundary and remaining proof engineering

The planned computational helper inputs total 1,708: T=1,600, P=80,
escape=10, ratio=4, nonzero-factor=6 and residue partition=8. Their scalar
cast/representative identities are symbolic; they must not be replaced by
an implicit product over all states. The Python controls below can verify
these exact small helper domains only. They do not replay the original
64,000 triples and do not constitute a Lean proof.

Keep the entire future `FiveAdicCarry.lean` validation under the original
60-second/4-GiB monitored cap, including all helpers and symbolic assembly.
Do not count separate 60-second allowances for many hidden chunks, evaluate
the original forall through `simp`/`decide`, or materialize external witness
tables. Use only ordinary kernel proofs; no native evaluation trust shortcut.
The failed source's recursion options, if retained, must remain local to a
specific small helper and do not alter the external cap.

If even T is too costly, stop that bounded evaluation and implement its
three-block case argument with smaller scalar geometry/carry lemmas; do not
retry the full domain or enlarge the budget. A successful implementation still
needs the exact public-type and allowed-axiom checks. No measured Lean cost or
kernel success is supplied by this manuscript. Integer adapters and filtering
remain separate work after the finite theorem is checked.

## Guarded small-helper controls

The following sole Python block guards the three exact inputs to this plan,
then tests only the six declared small helper domains. Each finite helper has
at most 1,600 inputs. No result of the original full-state replay is assumed
as an executable oracle, and that replay is not run here.

```python
from hashlib import sha256
from itertools import product
from pathlib import Path

guards = {
    'LonelyRunner/FiveAdicCarry.lean':
        'edcc4c6a1c8a31ce6188b92d9d0a21d09f01013027290d6ed6cfeb3d1876fdb3',
    'research/astra-five-adic-carry-implementation.md':
        '610a1326baed5cab1aaef93030fa8e5ff36738c167514bd5685823c1d9ada9db',
    'research/astra-five-adic-carry-plan.md':
        'da1a4f4828f6e9d9cae6ed601151e0b56b518bea8e9add524e06b289b1713e69',
}
for path, expected in guards.items():
    assert sha256(Path(path).read_bytes()).hexdigest() == expected, path

C = ((0,0,0),(0,0,1),(0,1,1),(0,1,2))
def base(d,c,u):
    return ((u+1)*d+C[c][u])%5
def good(v):
    return v%5 in (1,2,3)
def block(v,b):
    return v == b or v == (b+1)%5

t_inputs = t_candidates = t_failures = 0
for d,e,c0,c1,c2 in product(range(5),range(5),range(4),range(4),range(4)):
    t_inputs += 1
    found = False
    for u,h in product(range(3),range(5)):
        t_candidates += 1
        if (good(base(0,c0,u)+h) and good(base(d,c1,u)+h)
                and good(base(e,c2,u)+h)):
            found = True
    t_failures += not found

p_inputs = p_candidates = p_failures = 0
for d,c0,c1 in product(range(5),range(4),range(4)):
    p_inputs += 1
    found = False
    for u,b in product(range(3),range(5)):
        p_candidates += 1
        if block(base(0,c0,u),b) and block(base(d,c1,u),b):
            found = True
    p_failures += not found

escape_inputs = 0
for y,tag in product(range(5),range(2)):
    escape_inputs += 1
    assert good(y) or good(y+tag+2)

ratio_inputs = 0
for r,rprime in product(range(2),repeat=2):
    ratio_inputs += 1
    if r != rprime:
        assert ((rprime+1)*pow(r+1,-1,5))%5 in (2,3)

unit_inputs = 0
for u,r in product(range(3),range(2)):
    unit_inputs += 1
    assert (u+1)%5 != 0 and (r+1)%5 != 0 and ((u+1)*(r+1))%5 != 0

majority_inputs = 0
for r0,r1,r2 in product(range(2),repeat=3):
    majority_inputs += 1
    assert ((r0 == r1 == r2) or (r0 == r1 and r0 != r2)
            or (r0 == r2 and r0 != r1) or (r1 == r2 and r1 != r0))

inputs = (t_inputs,p_inputs,escape_inputs,ratio_inputs,unit_inputs,majority_inputs)
assert inputs == (1600,80,10,4,6,8) and sum(inputs) == 1708
assert (t_candidates,p_candidates) == (24000,1200)
assert t_failures == p_failures == 0
print('source_guards=3 passed')
print('helper_inputs_T_P_escape_ratio_unit_majority=' + str(inputs))
print('helper_candidates_T_P=' + str((t_candidates,p_candidates)))
print('failures_T_P=' + str((t_failures,p_failures)) + '; scalar_helpers=passed')
print('total_helper_inputs=1708; largest_helper_inputs=1600')
print('full_64000_replay=none; Lean_execution=none; speed_enumeration=none')
```

Replay in memory from the repository root:

```sh
python3 -B - <<'PY'
from contextlib import redirect_stdout
from hashlib import sha256
from io import StringIO
from pathlib import Path
s = Path('research/astra-five-adic-carry-symbolic-plan.md').read_text()
assert s.count('```python\n') == 1
program = s.split('```python\n',1)[1].split('```',1)[0]
out = StringIO()
with redirect_stdout(out):
    exec(compile(program, '<five-adic-symbolic-small-helpers>', 'exec'), {})
print(out.getvalue(), end='')
print('program_sha256=' + sha256(program.encode()).hexdigest())
print('stdout_sha256=' + sha256(out.getvalue().encode()).hexdigest())
PY
```

The exact replay completed with exit 0: all three source guards passed;
T passed all 1,600 inputs and P passed all 80, with respectively 24,000 and
1,200 candidate pairs checked. All 28 scalar-helper inputs passed. There
were no failed helper inputs and no further full-domain replay.
Program SHA-256:
`ffd0739e680cbc3c12e3ac0e35cb6b41e6f3b6c4a5a3db4500c76031de4aa6aa`.
Captured stdout SHA-256:
`3e95ff25d9c4e17ecf30b7979b6d48ef1b6912fcfe2923bc6fbb4e9914e3553c`.
The program is the sole Python fence contents including its final newline;
the stdout hash covers its six printed lines, excluding the two hash reports.
The workflow validator also passed as a structural check only.

All owned commands have stopped, with no queued or active Lean, cache-dependent
or discovery process. Only this manuscript was changed. Freeze outcome: the
two normalized helper contracts and symbolic lifting are settled for root
review and bounded implementation. Their mathematical reduction is proved
here; the future kernel cost, source acceptance and axiom results remain
unmeasured and unproved. Do not claim the earlier failed source compiles.
