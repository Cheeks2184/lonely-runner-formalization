# Independent review of the two-branch combined supply contract

2026-09-05. Task `/root/cluster_limit_review-combined-supply-review`, requested
GPT-6 Astra / xhigh, assigned at main checkpoint
`a4c395827100593500747904a1a11f4251fdb271`. Runtime model/effort metadata were
not independently exposed. Current `.codex/config.toml`, project workflow,
policy and state were read; `python3 -B scripts/validate_workflow.py` passed.
Research is active and the unrestricted LRC goal remains unresolved.

**Disposition: accept the frozen manuscript's precise two-branch supply
refutation. No defect found.** The reviewed manuscript is
`research/astra-combined-affine-supply-audit.md`, SHA-256
`87fd780d4df515910203aaa8824a2f9265cd57dfdf6e323e43c9cb12bb320327`.
The proof and complete finite certificate concern the fixed primitive tuple
N=4, s=(0,1,3,4), chosen r=0. They refute the disjunction of a reciprocal
witness with denominator 2 through N and the specified adaptive worst-case
endpoint packet. They do not refute a union with all existing height or
insertion methods, a restriction to actual minimal counterexamples, finite
family supply, or LRC. No kernel-checked result is created by this review.

## Exact contract and previous accepted dependency

The first branch is exactly existence of an integer d in [2,N] dividing
none of the original nonzero signed relative speeds Delta_i=s_i-s_r. A
nonzero residue has circular distance at least 1/d>=1/N, while a divisible
relative speed has distance zero at the literal positive time 1/d. Thus the
branch is equivalent to the existence of one of these particular reciprocal
times as a chosen-runner witness. It does not include arbitrary rational
numerators or denominators larger than N. The contrapositive necessary
condition for no witness is forall d in [2,N], exists i distinct from r,
d divides Delta_i. The label i may depend on d; a single endpoint can block
several d. Taking absolute values preserves signs and divisibility without
requiring deduplication or changing the original target denominator N.

The second branch retains all of the preceding adaptive audit's premises:
positive integer q, integer endpoint coefficients u0=0 and u_last=q, p=H/q,
residuals R_i=q s_i-H u_i, a distinct original comparison pair a,b, and the
nowhere-zero signed collision row

```text
W_i=|Delta_i|, U_i=sign(Delta_i)*(u_i-u_r),
w_i=(W_a+W_b)*U_i-(U_a+U_b)*W_i,
c=card {|w_i|:i != r},
|R_i-R_r|/(2H) <= 1/(c+1)-1/N  for every i.
```

There are N-1 original comparisons. Because w_a=-w_b and both are nonzero,
1<=c<=N-2. All distinct unordered comparison pairs are allowed. The true
cardinality is essential; choosing c=1 merely because its budget is largest
would not prove supply. A different q,u,pair may be selected for each r.

The exact accepted generic transfer review is
`research/astra-cardinality-adaptive-affine-review.md`, SHA-256
`09dd14f819e03a08583754375c6317157b3717bbf54f3e4a289cf1285bb45c49`.
Its manuscript input remains SHA-256
`a71e55b71e6e6a8a7893c5b3523859d9e51255078c2b17de0ea5cb6b5439a101`.
That review establishes the manuscript transfer conditional on H_N: enumerate
the c positive magnitudes, retain the own-count margin 1/(c+1), normalize the
second phase modulo q, and round to a positive original time with closed
loss and target inequalities. Its positivity proof works for every q>0,
including p<=1. H_N is an explicit lower-count supply assumption, not a
conclusion or an assumption of original witness existence. The current
manuscript uses precisely those premises and equations, so a fresh proof or
Lean build of that generic transfer is unnecessary for this bounded review.
The earlier qualification about adjacency remains: only distinct adjacent
ratio values guarantee nonvanishing. The current contract has no adjacency
assertion or restriction and explicitly rejects every zero coordinate.

## All-q completeness and the additional residual observation

Independently rechecking the folding argument, c>=1 implies

```text
|R_i-R_r| <= 2H*(1/2-1/N) < H.
```

If H divides q, every integer difference R_i-R_r is a multiple of H and
must vanish. R0=0 then makes every R_i zero, giving u_i=(q/H)s_i and hence
an identically zero collision row. The strict comparison with H, together
with nonvanishing, excludes this case; neither primitivity nor a supplied
rank premise is used. The controls also show that omitting the error bound
can admit a nonzero collision at H|q.

For q=kH+q0, 0<q0<H, put u'_i=u_i-k s_i. Endpoints and residuals are
preserved, and U'_i=U_i-k W_i. Substitution shows every w_i is unchanged,
so c and all relative errors |R_i-R_r|/(2H) stay unchanged. This reduces
existence over all positive q to the complete range 1 through H-1, preserving
the original tuple and chosen label. It is a reduction of an auxiliary
denominator, not a descent in actual height or count. A finite negative
certificate after this proof is therefore exhaustive for the stated class,
without asserting that any finite range of actual tuples is solved.

The new local divisibility observation is also correct. If d divides Delta_i
and g=gcd(d,H), then g divides q Delta_i and H(u_i-u_r), hence their difference
E_i=R_i-R_r. It also divides T_i=sign(Delta_i)E_i. A valid-packet bound
|E_i|<=2H epsilon with 2H epsilon<g forces E_i=0. The last comparison must
be strict: a nonzero residual of magnitude g can satisfy a non-strict bound.
Eliminating U gives

```text
H*w_i=W_i*(T_a+T_b)-(W_a+W_b)*T_i.
```

This identity and the divisibility fact are restrictions, not constructions
of a joint residual row or a favorable collision count. On the stated r=0
fixture, d=2 and d=4 are both blocked by the speed-4 endpoint, already of
residual zero, while the speed-3 blocker for d=3 has gcd(3,4)=1. There is
no extra supply inference hidden in those observations.

## Independent reconstruction of all six rows and 18 pairs

For N=4, H=4, r=0, c can only be 1 or 2, with budgets 1/4 and 1/12. The
closed envelope is |R_i|<=2. This differs materially from a strict envelope:
residuals of magnitude exactly 2 must be retained. With q in {1,2,3}, the
congruences R_i=q s_i mod 4 give exactly

| q | Residual at speed 1 | Residual at speed 3 |
| --- | --- | --- |
| 1 | 1 | -1 |
| 2 | -2 or 2 | -2 or 2 |
| 3 | -1 | 1 |

The endpoint residuals are zero. These choices give exactly six rows, with
u_i=(q s_i-R_i)/4 uniquely determined. Two rows have error 1/8 and four
boundary rows have error 1/4. No integer u row within the envelope is omitted.

Write A=R1 and B=R2, with original comparison label order (1,2,3), meaning
speeds (1,3,4). Independent direct expansion of the residual determinant gives

```text
pair (1,2): ((B-3A)/4, (3A-B)/4, A+B)
pair (1,3): (-A, (3A-5B)/4, A)
pair (2,3): ((B-7A)/4, -B, B).
```

The complete program below enumerates the residual choices, evaluates these
three formulas, and separately checks them against the original U,W collision
definition. It contains no copied expected-vector table and does not execute
the author's program. The obtained rows match every manuscript vector:

| q | (u1,u2) | Pair (1,2) | Pair (1,3) | Pair (2,3) |
| --- | --- | --- | --- | --- |
| 1 | (0,1) | (-1,1,0) Z | (-1,2,1) | (-2,1,-1) |
| 2 | (0,1) | (-1,1,4) | (-2,-1,2) | (-3,-2,2) |
| 2 | (0,2) | (-2,2,0) Z | (-2,4,2) | (-4,2,-2) |
| 2 | (1,1) | (2,-2,0) Z | (2,-4,-2) | (4,-2,2) |
| 2 | (1,2) | (1,-1,-4) | (2,1,-2) | (3,2,-2) |
| 3 | (1,2) | (1,-1,0) Z | (1,-2,-1) | (2,-1,1) |

Here u0=0 and u3=q. There are four zero-coordinate rejections; all other
14 vectors have exactly c=2, so the required loss is 1/12. Both 1/8 and
1/4 exceed it strictly. No c=1 vector qualifies. Reversed pairs give identical
rows and diagonal pairs have a zero coordinate. Thus the entire second branch
fails for r=0, over every positive q and every admissible integer u and pair.
The first branch also fails: d=2,3,4 have respective blocker labels 3,2,3.
One failing chosen label suffices to refute supply even with separate packets
for each runner. The tuple is primitive, strictly increasing, and is in the
inclusive retained family because 4<=12^2=144.

## Original witnesses and exact existing-theorem scope

At t=5/12 the r=0 comparison norms are exactly (5/12,1/4,1/3), with one
closed equality; at t=3/7 they are (3/7,2/7,2/7), all strictly above 1/4.
These are positive original chosen-runner witnesses independent of H_N.
They are not one time witnessing all runners simultaneously: the relative
speed 2 between labels 1 and 2 has norm 1/6 at 5/12 and 1/7 at 3/7.
The source manuscript's fixed chosen label is therefore retained throughout.
The direct-branch control for r=1 at d=4 also gives a nonvacuous successful
instance of the first branch, with the original target still 1/4.

The exact read source `LonelyRunner/SmallDenominatorWitness.lean` has SHA-256
`1570a359100594f4a5589588e3b32674dc2d54d60e500df1d47aca64c2faf95f`.
Its family theorem permits the target N independently of the indexing count;
`divisor_cover_of_no_small_witness` takes the negation of any real-time
witness and returns the quantified divisor cover for 2<=d<=N. It needs
neither injectivity nor deduplication. Sign invariance handles absolute
original comparisons while retaining their index labels and target N.

The exact read source `LonelyRunner/BoundedHeight.lean` has SHA-256
`681c38dae0158ffd4162fa471c429dea4e8b90e27ee6e3a6fdf7b3cbd6e47ecc`.
`boundedHeight_stationary_witness` assumes n>=3, n positive injective natural
moving speeds, and each speed <=n+2; it concludes a real-time stationary
witness at the closed 1/(n+1) threshold. The supplied moving row is (1,3,4),
so n=3, the height bound is 5, and the conclusion is exactly 1/4. Counting
the stationary zero as a fourth moving speed would be an incorrect theorem
application. The theorem has no H_N or primitivity premise. Its time need
not be explicitly positive in the signature; the displayed literal positive
times already settle positivity for this example. This is a check of the
existing theorem's source interface and arithmetic premises, not a new Lean
compilation or a fresh trust audit of that source.

Consequently this example cannot refute any broader union that includes the
existing bounded-height branch. It is not an actual counterexample, let alone
a minimal one. A theorem restricted to genuine minimal counterexamples would
require a different argument; failure of the two numerical branches alone
proves nothing about that restriction. No further mechanism or tuple discovery
was undertaken in this independent review.

## Exact controls, complete program and execution record

The fixed finite domain is the one supplied tuple, the six residual rows,
all three comparison pairs, their reversed and diagonal controls, denominator
lifts k in {0,1,4}, all four original chosen labels for sign/folding controls,
and d in {2,3,4} for the direct branch and local gcd checks. These are algebra
checks on failed packets, not successful packet supply for other labels.
There are also q=kH controls for k in {1,3}, one fixed coefficient perturbation
omitting the error premise, one strict-gcd boundary control, the two literal
witness times, and the bounded-height theorem's arithmetic premises. All
arithmetic uses integers and `Fraction`. No witness or tuple search is used.

The sole Python block below is complete. It checks all five frozen input
hashes and prints the full reconstructed certificate, direct-branch controls,
literal witnesses and counts. The temporary program is
`/tmp/astra-combined-independent-review.py`, 6,932 bytes, SHA-256
`6ae1891ceb761d900bdc49866928066b68dff173b817eecfcb1f1caa2f7111a6`.
Its complete JSON output with trailing newline is
`/tmp/astra-combined-independent-review.json`, 3,027 bytes, SHA-256
`c32388ad4463106f8df48e7c42b62c1c8d6c61fdcb594d89a6f9d136db699997`.
The embedded program is the durable reproducer; temporary paths are conveniences.

```python
from collections import Counter
from fractions import Fraction as F
from hashlib import sha256
from itertools import combinations, product
from math import gcd
from pathlib import Path
import json

ROOT=Path('/home/joshua/lonely-runner-formalization')
FROZEN={
 'research/astra-combined-affine-supply-audit.md':'87fd780d4df515910203aaa8824a2f9265cd57dfdf6e323e43c9cb12bb320327',
 'research/astra-cardinality-adaptive-affine-review.md':'09dd14f819e03a08583754375c6317157b3717bbf54f3e4a289cf1285bb45c49',
 'research/astra-cardinality-adaptive-affine-audit.md':'a71e55b71e6e6a8a7893c5b3523859d9e51255078c2b17de0ea5cb6b5439a101',
 'LonelyRunner/SmallDenominatorWitness.lean':'1570a359100594f4a5589588e3b32674dc2d54d60e500df1d47aca64c2faf95f',
 'LonelyRunner/BoundedHeight.lean':'681c38dae0158ffd4162fa471c429dea4e8b90e27ee6e3a6fdf7b3cbd6e47ecc',
}
for path,digest in FROZEN.items():
 assert sha256((ROOT/path).read_bytes()).hexdigest()==digest,path
s,N,H=(0,1,3,4),4,4
counts=Counter()
assert gcd(*s)==1 and s[0]==0 and all(s[i]<s[i+1] for i in range(N-1))
assert H<=(N*(N-1))**(N-2)==144

def norm(x):
 x=F(x);f=x-x.numerator//x.denominator
 return min(f,1-f)
def collision(q,u,r,a,b):
 I=tuple(i for i in range(N) if i!=r)
 assert a in I and b in I and u[0]==0 and u[-1]==q and q>0
 R=tuple(q*s[i]-H*u[i] for i in range(N))
 W={i:abs(s[i]-s[r]) for i in I}
 U={i:(1 if i>r else -1)*(u[i]-u[r]) for i in I}
 T={i:(1 if i>r else -1)*(R[i]-R[r]) for i in I}
 w=tuple((W[a]+W[b])*U[i]-(U[a]+U[b])*W[i] for i in I)
 determinant=tuple(F(W[i]*(T[a]+T[b])-(W[a]+W[b])*T[i],H) for i in I)
 assert w==determinant and w[I.index(a)]==-w[I.index(b)]
 return R,w

# Complete certificate from congruences within the proved CLOSED radius 2.
# No ceiling/floor search over u and no author vector table is used.
rows=[]
for q in (1,2,3):
 pools=[tuple(z for z in (-2,-1,0,1,2) if (q*s[i]-z)%H==0) for i in (1,2)]
 for R1,R2 in product(*pools):
  R=(0,R1,R2,0)
  u=tuple((q*s[i]-R[i])//H for i in range(N))
  assert tuple(q*s[i]-H*u[i] for i in range(N))==R
  error=F(max(map(abs,R)),2*H)
  assert error<=F(1,4)
  counts['closed_envelope_boundary_rows']+=int(error==F(1,4))
  # Three explicit residual formulas, independently expanded by hand.
  formulas={
   (1,2):(F(R2-3*R1,4),F(3*R1-R2,4),F(R1+R2)),
   (1,3):(F(-R1),F(3*R1-5*R2,4),F(R1)),
   (2,3):(F(R2-7*R1,4),F(-R2),F(R2)),
  }
  entries=[]
  for (a,b),computed in formulas.items():
   assert all(z.denominator==1 for z in computed)
   w=tuple(int(z) for z in computed)
   assert collision(q,u,0,a,b)==(R,w)
   assert collision(q,u,0,b,a)==(R,w)
   counts['reverse_pair_identities']+=1
   if 0 in w:
    c=None;counts['zero_rejections']+=1
   else:
    c=len(set(map(abs,w)))
    assert c==2 and error>F(1,c+1)-F(1,N)==F(1,12)
    counts['true_count_2_budget_rejections']+=1
   entries.append({'pair':(a,b),'w':w,'c':c})
   counts['certificate_pairs']+=1
  for a in (1,2,3):
   assert collision(q,u,0,a,a)[1][a-1]==0
   counts['diagonal_rejections']+=1
  rows.append({'q':q,'u':u,'R':R,'error':str(error),'pairs':entries})
rows.sort(key=lambda row:(row['q'],row['u']))
counts['certificate_rows']=len(rows)
assert len(rows)==6 and counts['certificate_pairs']==18
assert counts['zero_rejections']==4 and counts['true_count_2_budget_rejections']==14
assert counts['closed_envelope_boundary_rows']==4
assert Counter(row['error'] for row in rows)==Counter({'1/8':2,'1/4':4})

# Each reciprocal branch is checked in both directions with the original N.
divisor_rows=[]
for r,d in product(range(N),(2,3,4)):
 I=tuple(i for i in range(N) if i!=r)
 blockers=tuple(i for i in I if (s[i]-s[r])%d==0)
 norms=tuple(norm(F(s[i]-s[r],d)) for i in I)
 assert bool(blockers)==(min(norms)<F(1,N))
 for i,z in zip(I,norms):
  assert norm(F(abs(s[i]-s[r]),d))==z
  if i not in blockers:
   assert z>=F(1,d)>=F(1,N)
  else:
   assert z==0
  counts['reciprocal_signed_comparisons']+=1
 counts['reciprocal_branch_instances']+=1
 divisor_rows.append({'r':r,'d':d,'blockers':blockers,'norms':list(map(str,norms))})
assert [(row['d'],row['blockers']) for row in divisor_rows if row['r']==0]==[(2,(3,)),(3,(2,)),(4,(3,))]
assert all(row['blockers'] for row in divisor_rows if row['r']==0)
assert [row['d'] for row in divisor_rows if row['r']==1 and not row['blockers']]==[4]

# Fixed lifts of every certified residual row check all original chosen labels.
for row in rows:
 q0,u0,R0=row['q'],row['u'],row['R']
 for k in (0,1,4):
  q=q0+k*H
  u=tuple(u0[i]+k*s[i] for i in range(N))
  assert q%H==q0 and tuple(u[i]-k*s[i] for i in range(N))==u0
  assert tuple(q*s[i]-H*u[i] for i in range(N))==R0
  for r in range(N):
   I=tuple(i for i in range(N) if i!=r)
   for a,b in combinations(I,2):
    assert collision(q,u,r,a,b)==collision(q0,u0,r,a,b)
    counts['all_chosen_fold_pairs']+=1
    for i in I:
     p,p0=F(H,q),F(H,q0)
     assert abs(F(R0[i]-R0[r],q))/(2*p)==abs(F(R0[i]-R0[r],q0))/(2*p0)
     counts['fold_relative_error_checks']+=1
   for d,i in product((2,3,4),I):
    if (s[i]-s[r])%d==0:
     g=gcd(d,H);E=R0[i]-R0[r]
     assert E%g==0
     if abs(E)<g:
      assert E==0
      counts['strict_gcd_zero_controls']+=1
     counts['gcd_divisibility_controls']+=1
# The local gcd condition must be strict: equality need not force zero.
R=(0,1,-1,0)
assert (s[2]-s[1])%2==0 and abs(R[2]-R[1])==gcd(2,H)==2
assert R[2]-R[1]!=0
counts['gcd_boundary_nonzero_control']=1

# H|q with the envelope forces the rank-one zero collision, not a packet.
for k in (1,3):
 q=k*H;u=tuple(k*z for z in s)
 for r in range(N):
  for a,b in combinations([i for i in range(N) if i!=r],2):
   assert collision(q,u,r,a,b)==((0,)*N,(0,)*(N-1))
   counts['multiple_height_zero_collision_controls']+=1
# Omitting the error bound permits H|q and a nonzero collision.
badR,badW=collision(4,(0,2,3,4),0,1,3)
assert badW==(4,-3,-4) and len(set(map(abs,badW)))==2
assert F(max(map(abs,badR)),2*H)==F(1,2)>F(1,12)
counts['missing_error_premise_control']=1

# Literal author/parent times; do not infer a simultaneous all-runner witness.
witnesses=[]
for t,wanted in ((F(5,12),(F(5,12),F(1,4),F(1,3))),
                 (F(3,7),(F(3,7),F(2,7),F(2,7)))):
 got=tuple(norm(t*s[i]) for i in (1,2,3))
 assert t>0 and got==wanted and min(got)>=F(1,N)
 for v in got:
  counts['literal_witness_comparisons']+=1
  counts['literal_closed_equalities']+=int(v==F(1,N))
 assert norm(t*(s[2]-s[1]))<F(1,N)
 counts['chosen_label_scope_controls']+=1
 witnesses.append({'t':str(t),'r':0,'norms':list(map(str,got))})
# Exact existing theorem premises: n=3 moving runners, threshold 1/(n+1).
positive=s[1:];n=len(positive)
assert n==3 and n>=3 and len(set(positive))==n
assert all(0<a<=n+2 for a in positive) and F(1,n+1)==F(1,N)
counts['bounded_height_premise_instance']=1
print(json.dumps({'frozen':FROZEN,'counts':dict(sorted(counts.items())),'certificate':rows,'direct_branches':divisor_rows,'literal_witnesses':witnesses},sort_keys=True,separators=(',',':')))
```

The first execution passed on its first run with exit code 0:

```bash
python3 -B /tmp/astra-combined-independent-review.py > /tmp/astra-combined-independent-review.json
```

The following embedded-block replay also passed with exit code 0:

```bash
python3 -B - <<'PY' > /tmp/astra-combined-independent-review-replay.json
from pathlib import Path
from hashlib import sha256
import re
p=Path('research/astra-combined-affine-supply-review.md')
blocks=re.findall(r'^```python\n(.*?)^```[ \t]*$',p.read_text(),re.M|re.S)
assert len(blocks)==1
assert sha256(blocks[0].encode()).hexdigest()=='6ae1891ceb761d900bdc49866928066b68dff173b817eecfcb1f1caa2f7111a6'
exec(compile(blocks[0],str(p),'exec'),{})
PY
```

The replay output is byte-identical to the stated JSON, with the same output
hash. All exact counts are:

```text
all_chosen_fold_pairs=216; bounded_height_premise_instance=1;
certificate_pairs=18; certificate_rows=6; chosen_label_scope_controls=2;
closed_envelope_boundary_rows=4; diagonal_rejections=18;
fold_relative_error_checks=648; gcd_boundary_nonzero_control=1;
gcd_divisibility_controls=180; literal_closed_equalities=1;
literal_witness_comparisons=6; missing_error_premise_control=1;
multiple_height_zero_collision_controls=24; reciprocal_branch_instances=12;
reciprocal_signed_comparisons=36; reverse_pair_identities=18;
strict_gcd_zero_controls=84; true_count_2_budget_rejections=14;
zero_rejections=4.
```

Workflow validation passed. All other commands were read-only configuration,
state, manuscript and source reads, hash/JSON inspection, or creation of this
owned review and small temporary prose/program/output files. No assertion
failed, and no discovery search was started or stopped. There was no Lean
invocation, dependency restoration, source edit, state edit, Git operation,
cache mutation, external research, or other repository-file write. The shared
`.lake` directory was absent. All owned command processes completed before
final freeze; no process remains running. The final review digest is reported
externally to avoid a self-referential hash.

Accepted scope remains the exact two-branch refutation with its complete
all-q packet certificate and its explicit original witnesses. Broader supply,
restriction to actual minimal counterexamples, and unrestricted LRC remain
outside this result. No novelty or full-goal completion is claimed.
