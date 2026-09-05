# Bounded independent screen of Kumar's March 2026 proof candidate

2026-09-05. Task `/root/cluster_limit_review-kumar-proof-screen`, requested
GPT-6 Astra / xhigh, assignment checkpoint
`a4c395827100593500747904a1a11f4251fdb271`. Runtime model/effort metadata were
not independently exposed. Current project configuration, workflow, policy
and state were read; `python3 -B scripts/validate_workflow.py` passed.

**Disposition: reject this particular proof candidate.** Its strict target is
false, and its finite nesting lemma has an independent counterexample that
survives changing the target to a closed inequality. This screen is neither
a disproof of LRC nor an exhaustive review of proposed proofs.

## Primary source and assertions screened

Bhaskar Kumar, *Everyone Will Eventually Be Lonely: A Proof of the Lonely
Runner Conjecture*, [Zenodo record 19171253](https://zenodo.org/records/19171253),
version 1, published March 22, 2026. The [primary PDF](https://zenodo.org/records/19171253/files/lrc%203.pdf?download=1)
uses strict distance >1/n in its displayed target and open good windows
(Sections 1–2, 5–6). Section 4 asserts that an intersection of k finite local
bad sets has density (2/n)^k. Section 5, Case B then uses a product expression
for an integer count of progression points. Those are the only source claims
needed for this screen; the analysis below is independent.

The exact supplied PDF is `/tmp/astra-zenodo-19171253.pdf`, 14,613 bytes,
SHA-256 `74d1e1eaa035c15a2ed7c655aad46482e4a09e79f007076c7116a1a95df89871`.
Its MD5 `20344a62037a58f28bd317c2817e50bc` matches the primary record.
The full six-page text was extracted with `pdftotext -layout`; mathematical
pages 1–5 were also rendered and visually inspected to confirm inequalities,
exponents, finite residue domains and the counting formula. No secondary
source, further literature search, or author contact was used.

## Independent fatal checks

For the original speeds (0,1,2), choose runner 0 and reduce time modulo 1
as x in [0,1). The closed first comparison forces x in [1/3,2/3]. On that
interval, ||2x||=|2x-1|<=1/3, with equality only at x=1/3 or x=2/3.
Therefore the complete closed witness set modulo 1 is exactly {1/3,2/3},
and the strict witness set is empty. The two displayed positive times satisfy
the original closed LRC requirement. This is an exact continuum argument,
not a negative time search. Equivalently, for periods (1,2), substitute r=2x:
the open simultaneous good set is empty, while the closed version has
representatives 2/3 and 4/3 modulo 2.

Separately take the finite lemma's literal parameters p=2, k_p=1, k=1,
w1=1. These meet its prime, positive exponent and distinct nonnegative
valuation-level assumptions, even with the natural extra restriction
w1<=k_p. The residue domain has representatives {0,1}. Direct evaluation
of the printed closed predicate gives:

| n | Bad-window bounds inside [0,2] | Bad residues | Actual density | Asserted density |
| --- | --- | --- | --- | --- |
| 3 | [0,2/3] union [4/3,2] | {0} | 1/2 | 2/3 |
| 11 | [0,2/11] union [20/11,2] | {0} | 1/2 | 2/11 |

The corresponding asserted cardinalities would be 4/3 and 4/11, although
the actual cardinality is 1. Thus the induction base k=1 of the finite
lemma fails; the n=11 instance is not confined to the paper's small-n base
range. Continuous interval length cannot be substituted for the cardinality
of a discrete residue set. A repair from strict good windows to closed good
windows would make the bad windows open at their threshold endpoints.
Neither tested residue is on such a threshold, so both controls still give
exactly {0}. The nesting failure is therefore separate from the strict-target
failure and is not fixed by changing an inequality symbol.

One additional consistency control uses n=3, periods (2,1), and shift 1/2.
The Case-B progression is {1/2,3/2}; both points meet the period-1 good
condition and both fail the period-2 good condition. Its actual simultaneous
count is 0, whereas substitution in the displayed product gives 2/3.
This is a check of that counting identity, not a claim that the paper invokes
its inductive step at n=3 instead of a base case. The n=11 finite-lemma
counterexample already suffices for rejection, so no other reductions or
proof stages were audited further.

## Exact control domain and execution

The program below verifies the exact source hash, the nine breakpoints and
eight open linear cells for ||x|| and ||2x|| on [0,1], their threshold signs,
the two closed witnesses, the period rescaling, the two literal finite-lemma
instances with both endpoint conventions, and the two Case-B progression
points. All relevant slopes change at included k/(2a) points, and every
threshold root is included, so each open cell has constant truth values for
the tested inequalities. The written argument above establishes completeness
for all real times; the finite cell checks corroborate it. No other input
tuple, parameter search, numerical tolerance, or Lean verifier was used.

The sole complete Python block has SHA-256
`61bd031f447499c27b171852039181b1dfc38c76b5e58bc1a856e531a5bfb618`
and 3,715 bytes. Its temporary copy is `/tmp/astra-kumar-proof-screen.py`.
The full JSON output with trailing newline has SHA-256
`36bb8cc2bcbee8aeec67b9452d70a07c7f4548109f2d368ca7371ca00dc8637c`
and 924 bytes, at `/tmp/astra-kumar-proof-screen.json`. Retain the exact
source PDF, or retrieve the linked file and verify its frozen hash before
replaying; no third-party package or build cache is required.

```python
from fractions import Fraction as F
from hashlib import sha256, md5
from pathlib import Path
import json

pdf=Path('/tmp/astra-zenodo-19171253.pdf').read_bytes()
source_sha='74d1e1eaa035c15a2ed7c655aad46482e4a09e79f007076c7116a1a95df89871'
assert len(pdf)==14613 and sha256(pdf).hexdigest()==source_sha
assert md5(pdf).hexdigest()=='20344a62037a58f28bd317c2817e50bc'
def norm(x):
 x=F(x);f=x-x.numerator//x.denominator
 return min(f,1-f)
def good(x,closed):
 return all(norm(a*x)>=F(1,3) if closed else norm(a*x)>F(1,3) for a in (1,2))

# All slope changes and threshold roots, not an arbitrary time grid.
breaks={F(0),F(1)}
for a in (1,2):
 breaks.update(F(k,2*a) for k in range(2*a+1))
 breaks.update(F(k+offset,a) for k in range(a+1)
               for offset in (F(-1,3),F(1,3)) if 0<=F(k+offset,a)<=1)
breaks=sorted(breaks)
assert breaks==[F(0),F(1,6),F(1,4),F(1,3),F(1,2),F(2,3),F(3,4),F(5,6),F(1)]
closed_points=[x for x in breaks if good(x,True)]
strict_points=[x for x in breaks if good(x,False)]
assert closed_points==[F(1,3),F(2,3)] and strict_points==[]
cells=[]
for left,right in zip(breaks,breaks[1:]):
 mid=(left+right)/2
 assert not good(mid,True) and not good(mid,False)
 for a in (1,2):
  # On these known linear pieces, midpoint values check the affine formula.
  assert norm(a*mid)==(norm(a*left)+norm(a*right))/2
  dl,dr=norm(a*left)-F(1,3),norm(a*right)-F(1,3)
  assert dl*dr>=0  # No omitted interior threshold crossing.
 cells.append([str(left),str(right),str(mid)])
# Periods (1,2) correspond exactly to rescaling this variable r=2*x.
for x in breaks+[(a+b)/2 for a,b in zip(breaks,breaks[1:])]:
 r=2*x
 assert (norm(r),norm(r/2))==(norm(2*x),norm(x))
assert [2*x for x in closed_points]==[F(2,3),F(4,3)]

# Literal finite-set predicate in Lemma 1. Both variants are evaluated:
# closed bad windows as printed, and open bad windows for a closed target.
local=[]
for n in (3,11):
 p,kp,w,k=2,1,1,1
 modulus=p**kp;level=p**w
 assert 0<=w<=kp and kp>0 and k==1
 closed_bad=[];open_bad=[]
 for r in range(modulus):
  z=r%level
  if F(z)<=F(level,n) or F(z)>=F(level*(n-1),n): closed_bad.append(r)
  if F(z)<F(level,n) or F(z)>F(level*(n-1),n): open_bad.append(r)
 assert closed_bad==open_bad==[0]
 actual=F(len(closed_bad),modulus);claimed=F(2,n)**k
 assert actual==F(1,2) and actual!=claimed
 claimed_count=claimed*modulus
 assert claimed_count.denominator!=1
 local.append({'n':n,'p':p,'kp':kp,'levels':[w],'closed_bad':closed_bad,
               'open_bad':open_bad,'actual_density':str(actual),
               'claimed_density':str(claimed),'claimed_count':str(claimed_count)})

# A consistency check of the displayed Case-B counting expression at n=3.
# This is separate from its use as an inductive step above the stated bases.
n=3;periods=(2,1);L=2;m=2;shift=F(1,2)
A=[shift+j for j in range(m)]
assert F(1,3)<shift<F(2,3)
def period_good(r,a):
 residue=r-a*(r//a)
 return F(a,n)<residue<F(a*(n-1),n)
assert all(period_good(r,1) for r in A)
actual_count=sum(all(period_good(r,a) for a in periods) for r in A)
claimed_count=m*(1-F(2,n))**1
assert actual_count==0 and claimed_count==F(2,3)

print(json.dumps({'pdf_sha256':source_sha,'closed_good_points_mod_1':list(map(str,closed_points)),
 'strict_good_points_mod_1':strict_points,'open_cells':cells,
 'local_lemma_controls':local,'case_b_control':{'progression':list(map(str,A)),
 'actual_count':actual_count,'claimed_count':str(claimed_count)},
 'counts':{'breakpoints':len(breaks),'open_cells':len(cells),'linear_piece_checks':2*len(cells),
 'rescaling_checks':2*len(breaks)-1,'local_lemma_instances':2,'finite_residue_predicates':8,
 'closed_original_witnesses':2,'case_b_progression_points':2}},sort_keys=True,separators=(',',':')))
```

Actual commands and outcomes:

```bash
python3 -B scripts/validate_workflow.py
pdftotext -layout /tmp/astra-zenodo-19171253.pdf /tmp/astra-kumar-proof-screen.txt
pdfinfo /tmp/astra-zenodo-19171253.pdf
pdftoppm -f 1 -l 5 -r 90 -png /tmp/astra-zenodo-19171253.pdf /tmp/astra-kumar-screen-page
python3 -B /tmp/astra-kumar-proof-screen.py > /tmp/astra-kumar-proof-screen.json
```

All exited 0. The renderer emitted nonfatal Fontconfig warnings about an
unwritable cache directory; all five mathematical page images were produced
and inspected successfully, and no cache repair was attempted. The extracted
text has 12,302 bytes and SHA-256
`46f4fe116e1921f3fa60c9e480f5edde09fac8e076d52f7afe41fe1cb05d6f1d`.
The initial exact-control execution passed. A subsequent readability-only
edit simplified a literal breakpoint assertion; the final program above and
its embedded replay also passed, with identical JSON. No assertion failed.

Embedded replay command, executed successfully with exit 0:

```bash
python3 -B - <<'PY' > /tmp/astra-kumar-proof-screen-replay.json
from pathlib import Path
from hashlib import sha256
import re
p=Path('research/astra-kumar-proof-screen.md')
blocks=re.findall(r'^```python\n(.*?)^```[ \t]*$',p.read_text(),re.M|re.S)
assert len(blocks)==1
assert sha256(blocks[0].encode()).hexdigest()=='61bd031f447499c27b171852039181b1dfc38c76b5e58bc1a856e531a5bfb618'
exec(compile(blocks[0],str(p),'exec'),{})
PY
```

The final JSON and replay agree byte for byte. Exact counts are nine
breakpoints, eight open cells, 16 linear-piece checks, 17 rescaling checks,
two finite-lemma instances, eight finite residue predicates, two closed
original witnesses and two Case-B progression points.

Only this owned review and small temporary read/control artifacts were written.
There was no further literature search, external message, Lean invocation,
dependency restoration, source edit, state edit or Git operation. All owned
commands completed before freeze; none remains running. The review's final
hash is reported externally. This is a reason to stop pursuing this version's
proof as supplied, not a claim about all possible repairs, all other proof
candidates, mathematical novelty, or the truth or falsity of LRC.
