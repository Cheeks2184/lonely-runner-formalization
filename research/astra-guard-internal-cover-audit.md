# One divisible guard and the internal-cover refutation target

Task `/root/guard_internal_cover_audit`, requested Astra/xhigh, 2026-09-05.
Base commit: `7a3ea75d1221b815a46b97f2b487807e48375649`.
The worker read the project configuration, workflow, policy, and active
research state, and ran `python3 scripts/validate_workflow.py`: passed.
Only this evidence file is owned by this worker. No Lean source, Git state,
shared workflow state, dependency, or cache was changed. No browser model,
external model worker, or third-party computation was used.

**Disposition: no counterexample found in the completed finite search domain.
The guard reduction below is a manuscript argument awaiting independent review;
it is not a new unrestricted existence theorem or a Lean proof.** Neither
Prompt95 nor the canonical Lonely Runner Conjecture is resolved here.

## 1. Literal contracts and runner count

Use the exact definitions from `LonelyRunner/PivotResidues.lean`:

```text
R(N,p) = {0 <= r < N*p : N does not divide r},
B(N,p,d) = {r in R(N,p) : min(r*d mod(N*p), -r*d mod(N*p)) < p}.
```

Badness is strict. Equality with `p` is safe. For positive modulus these
expressions agree with Lean's `min (x % M) (M - x % M)`, including residue zero.

`LonelyRunner/Prompt99Scaling.lean` defines `coveredPivots N a` using *all*
other original labels. `IsMaximumCoveredPivot` takes a speed maximum only
among those covered labels. `IsInternalOwnerSet N a j D` means
`D subset coveredPivots N a \ {j}`. `InternalCoverRedundantAt` quantifies over
every internal complete cover and requires a removable owner in each.
`MaxCoveredPivotInternalCoverRedundancy` is only a proposition definition,
quantified over positive injective `a : Fin n -> Nat`, `n>=2`, with **N=n+1**.
It is not an asserted theorem.

Consequently a concrete internal inclusion-minimal complete cover at a
maximum covered pivot refutes the literal proposition. It need not refute LRC:
another original pivot can be noncovered. The guard construction exploits
exactly this distinction.

With `c` distinct lower owners, one pivot, and one guard, the number of moving
speeds is `n=c+2`. Thus `N=n+1` forces **c=N-3**. The known
`N=7,p=11,d=(1,4,5,6,7)` row has five owners, namely `N-2`; adding a guard to
that tuple changes the denominator to 8 and cannot be treated as an `N=7`
internal-cover counterexample.

## 2. A fully explicit conditional guard construction

Let `N>=3`, `c=N-3`, and let `d_1,...,d_c` be distinct integers with
`0<d_i<p`. Put `A={d_1,...,d_c,p}` and suppose:

1. The lower owners completely cover `R(N,p)`.
2. There are integers `0<u<v` such that `||a*u/v||>1/N` for every `a in A`.

The second assumption is an ordinary *strict* witness for the entire family
`A` at the unchanged threshold `1/N`; it is not inferred from the first.
A strict real witness, if separately established, gives a rational one by
continuity and rational density. This does not supply the witness uniformly.

Define

```text
L = lcm(A),
C = N*L*v,
a_full = (d_1,...,d_c,p,C),
r_C = N*(C/v)*u + 1,
t_C = r_C/(N*C) = u/v + 1/(N*C).
```

Every quantity is integral where indicated; `v` divides `C`. The tuple has
exactly `N-1` positive distinct moving speeds. In particular `L>=p` and
`C>p`, so the added label is distinct and largest.

For every `a in A`, `N*a` divides `C`. Hence at every candidate of the
`a`-pivot row the guard phase is zero, and the guard alone covers that row.
Thus every label in `A` belongs to `coveredPivots` of the full tuple.

The guard row is noncovered. First, `r_C mod N=1`, and

```text
1 <= r_C <= N*C - N*C/v + 1 < N*C.
```

It is therefore a literal canonical guard candidate. Its guard phase is an
integer plus `1/N`, so the guard itself attains the allowed closed boundary.
For an owner `a`, write `||a*u/v||=k_a/v`. Strictness and integrality give

```text
k_a/v - 1/N = (N*k_a-v)/(N*v) >= 1/(N*v).
```

Distance to the nearest integer is 1-Lipschitz. The phase perturbation is

```text
a/(N*C) <= p/(N^2*L*v) <= 1/(N^2*v) < 1/(N*v).
```

Consequently `||a*t_C||>1/N` for every `a in A`. In integer residue form,
`min(r_C*a mod(N*C), -r_C*a mod(N*C))>C`; every owner misses the guard's bad
set at `r_C`. No enumeration up to the potentially enormous guard is needed.

There are no other labels, so the full tuple has exactly

```text
coveredPivots = A,
maximum covered pivot = p.
```

Choose an inclusion-minimal subfamily `D` of the lower owners that still
covers `R(N,p)`. It exists by finiteness and the first hypothesis. Every
owner in `D` is covered and different from `p`, so it is internal. For each
`d in D`, deletion fails; equivalently there is a private candidate in
`B(N,p,d)` outside every other selected owner's bad set. Thus no owner is
removable, refuting `InternalCoverRedundantAt` at the literal maximum covered
pivot. The full tuple nevertheless has the displayed closed witness `t_C`.

This proves the conditional refutation mechanism. It does **not** prove that
its lower-owner cover or strict-witness inputs exist. Conversely, in this
constructed family once the guard is known noncovered, an internal complete
cover at `p` must be a subfamily of the original lower owners. That observation
is a contract reduction, not unrestricted mathematical progress.

If a cover search returns fewer than `N-3` owners, padding to exactly `N-3`
preserves coverage when enough unused speeds below `p` exist. However the
strict witness must be checked for the entire padded family; it is not
preserved automatically by adding arbitrary speeds.

## 3. Exact controls

The old covered row `N=7,p=11,d=(1,4,5,6,7)` has private witnesses
`(3,18,15,13,11)` in the displayed owner order. It is indeed an
inclusion-minimal five-owner cover, but has the wrong owner count for the
one-guard construction at `N=7`.

Use the *correctly counted* full tuple with `N=8` and
`A=(1,4,5,6,7,11)`. The ordinary time `13/42` is strict at threshold `1/8`:
its owner distances are

```text
(13/42, 5/21, 19/42, 1/7, 1/6, 17/42).
```

The construction gives

```text
L=4620, C=1552320,
r_C=3843841, N*C=12418560,
owner distances at r_C:
(3843841,2956804,5617915,1774074,2069767,5026571),
guard distance at r_C: 1552320.
```

Every displayed owner distance is strictly greater than `C`; the guard
attains equality. The maximum covered pivot is therefore 11. However its
maximal internal family is **not** a complete cover: its exact safe residues
are

```text
[11,27,33,41,47,55,61,77] modulo 88.
```

This control catches both the tempting runner-count error and an accidental
replacement of closed safety by strict safety.

The separate accepted tuple
`N=9,a=(7,8,9,10,11,13,18,3243240)` is also not a counterexample: at its maximum
covered pivot 18, `r=56` is safe against every internal owner. This was checked
from `docs/internal-pair-overlap-supply-refutation.md`; no old quarantined
attachment was read or run.

## 4. Bounded exact search

The decision problem is whether *at most* `k=N-3` distinct speeds in
`1,...,p-1` cover `R(N,p)`. For `p-1>=k` this is equivalent, for the cover
predicate alone, to existence of an exactly `k`-owner cover by padding.
Search instances with `p-1<k` are skipped because the required full tuple
cannot have that many distinct genuine lower owners.

Reflection `r -> N*p-r` preserves both the candidate predicate and every bad
set. The solver therefore represents only candidates in `1,...,floor(N*p/2)`.
At each node it selects an uncovered candidate with the fewest remaining
possible owners and branches over those owners. Successive branches remove
previously tried owners, assigning each possible completion to its first
selected owner of that candidate. Pruning is limited to impossible union or
insufficient sum of the largest remaining `k` gains. These are exact upper
bounds; no heuristic cutoff yields a negative decision.

A wall-clock deadline raises `TimeoutError` within an unfinished instance.
Only completed decision instances contribute negative evidence. Searches ran
as attached tool sessions, with no detached worker or leftover process.

| Invocation | Complete negative domain | Completed instances / branch nodes | Stop |
| --- | --- | --- | --- |
| `7 14 120 240` | Every `7<=N<=14`, `p<=103`, `p-1>=N-3`; additionally `p=104,N=7,...,13` | 771 / 11,138,225 | 240.072496 seconds; unfinished `(N,p,k)=(14,104,11)` excluded |
| `7 9 300 180` | Every `7<=N<=9`, `p<=288`, `p-1>=N-3`; additionally `p=289,N=7,8` | 851 / 3,039,076 | 181.313121 seconds; unfinished `(N,p,k)=(9,289,6)` excluded |

Both runs returned `status=timeout`, exit code 2, after preserving those
completed instances. The invocation bounds `p<=120` and `p<=300` were **not**
fully searched. No cover was found in any completed instance. The two domains
overlap; their instance counts must not be added as distinct cases.
The branch-node totals exclude the unfinished decision instance. These
finite negative results carry no all-height or all-N inference.

The solver was independently compared with literal full-residue enumeration
of every size-k subset for `3<=N<=10`, `2<=p<=14`, and
`1<=k<=min(5,p-1)`: **440 decision comparisons passed**. Its positive control
`(N,p,k)=(7,11,5)` returns `(1,7,6,5,4)`; `(7,11,4)` and `(9,18,6)` return
no cover. These are computational checks, not kernel verification.

No strict-witness or private-point search was launched on a candidate
refutation because the cover stage found none. The exact remaining gap is:
find `N>=7,p>0` and exactly `N-3` distinct lower speeds covering `R(N,p)`,
together with a strict `1/N` witness for those speeds plus `p`; or prove a
uniform obstruction to that explicitly stated target. The finite misses
supply neither alternative.

## 5. Reproduction

Save the following standard-library program as `/tmp/lrc_guard_search.py`.
Its SHA-256 at execution was
`f18d0b4aa467189e7b10258cb52edb9059eaea9cdaa95ba1af697543937dc049`.
The source file is embedded so no temporary artifact is required to reproduce
this checkpoint. Timings and the exact timeout position are machine-dependent;
every completed decision is deterministic.

```python
from time import monotonic
from itertools import combinations
import sys,json

def solve(N,p,k,deadline):
    # Reflection halves the universe without changing cover existence.
    R=[r for r in range(1,N*p//2+1) if r%N]
    B=[]; row=[]
    for d in range(1,p):
        z=0
        for i,r in enumerate(R):
            m=r*d%(N*p)
            if min(m,N*p-m)<p:z|=1<<i
        B.append(z)
    allr=(1<<len(R))-1
    for i,r in enumerate(R):
        row.append(sum(1<<j for j,b in enumerate(B) if b>>i&1))
    nodes=0
    def dfs(uncovered,allowed,k,chosen):
        nonlocal nodes
        nodes+=1
        if nodes%16384==0 and monotonic()>deadline:raise TimeoutError
        if not uncovered:return chosen
        if not k:return None
        # discard candidates with no gain and prune by best possible k gains
        gains=[];rest=allowed; uni=0
        while rest:
            z=rest&-rest;rest-=z;j=z.bit_length()-1
            gain=B[j]&uncovered
            if gain:gains.append((gain.bit_count(),j));uni|=gain
        if uni!=uncovered:return None
        gains.sort(reverse=True)
        if sum(x for x,j in gains[:k])<uncovered.bit_count():return None
        if k==1:
            for x,j in gains:
                if x==uncovered.bit_count():return chosen+[j+1]
            return None
        # In every completion at least one owner covers a rare uncovered point.
        rem=uncovered;branch=None;best=p
        while rem:
            z=rem&-rem;rem-=z;i=z.bit_length()-1
            opts=row[i]&allowed;n=opts.bit_count()
            if n<best:best=n;branch=opts
            if best<=1:break
        branches=[j for _,j in gains if branch>>j&1]
        for j in branches:
            allowed&=~(1<<j)
            ans=dfs(uncovered&~B[j],allowed,k-1,chosen+[j+1])
            if ans:return ans
        return None
    ans=dfs(allr,(1<<(p-1))-1,k,[])
    return ans,nodes

if __name__=='__main__':
    lo,hi,pmax,seconds=map(int,sys.argv[1:]);start=monotonic();deadline=start+seconds
    total=0;completed=0
    for p in range(2,pmax+1):
      for N in range(lo,hi+1):
        k=N-3
        if p-1<k:continue
        try:ans,nodes=solve(N,p,k,deadline)
        except TimeoutError:
            print(json.dumps(dict(status='timeout',incomplete=[N,p,k],previous_completed=completed,nodes_completed=total,seconds=monotonic()-start)),flush=True);sys.exit(2)
        total+=nodes;completed+=1
        if ans:
            print(json.dumps(dict(status='cover',N=N,p=p,k=k,owners=sorted(ans),nodes=nodes,total_nodes=total,completed=completed,seconds=monotonic()-start)),flush=True);sys.exit()
      if p%10==0:print(json.dumps(dict(status='progress',p_completed=p,instances=completed,total_nodes=total,seconds=monotonic()-start)),flush=True)
    print(json.dumps(dict(status='exhausted',domain=[lo,hi,pmax],completed=completed,total_nodes=total,seconds=monotonic()-start)),flush=True)
```

The exact search invocations were:

```bash
python3 /tmp/lrc_guard_search.py 7 14 120 240
python3 /tmp/lrc_guard_search.py 7 9 300 180
```

The following independently checks solver decisions and literal controls:

```python
from itertools import combinations
from math import lcm
from time import monotonic
from importlib.util import spec_from_file_location, module_from_spec
s = spec_from_file_location("guard", "/tmp/lrc_guard_search.py")
m = module_from_spec(s)
s.loader.exec_module(m)
def dist(M, x): return min(x % M, (-x) % M)
def brute(N, p, k):
    for D in combinations(range(1, p), k):
        if all(any(dist(N*p, r*d) < p for d in D)
               for r in range(N*p) if r % N):
            return D
    return None
count = 0
for N in range(3, 11):
    for p in range(2, 15):
        for k in range(1, min(p, 6)):
            actual, _ = m.solve(N, p, k, monotonic()+60)
            assert bool(actual) == bool(brute(N, p, k))
            count += 1
assert count == 440
N, p, owners = 7, 11, (1,4,5,6,7)
R = {r for r in range(N*p) if r % N}
B = {d: {r for r in R if dist(N*p, r*d) < p} for d in owners}
assert set.union(*B.values()) == R
for d, r in zip(owners, (3,18,15,13,11)):
    assert r in B[d] and all(r not in B[e] for e in owners if e != d)
N, A, u, v = 8, (1,4,5,6,7,11), 13, 42
C = N*lcm(*A)*v
r = N*C*u//v + 1
M = N*C
assert (C,r,M) == (1552320,3843841,12418560)
assert len(set(A+(C,))) == len(A)+1 == N-1
assert all(a>0 and C % (N*a) == 0 for a in A)
assert all(N*dist(v,u*a)>v for a in A)
assert 0<r<M and r % N == 1
assert [dist(M,r*a) for a in A] == [3843841,2956804,5617915,1774074,2069767,5026571]
assert all(dist(M,r*a)>C for a in A) and dist(M,r*C)==C
p = 11
safe = [r for r in range(N*p) if r % N and
        all(dist(N*p,r*d)>=p for d in A if d!=p)]
assert safe == [11,27,33,41,47,55,61,77]
assert all(dist(9*18,56*d)>=18 for d in (7,8,9,10,11,13))
print("440 solver comparisons and exact cover/guard controls passed")
```

## 6. Frozen source bindings and evidence limits

Inspected source hashes:

```text
362da5ab923f22e900ae7ac821dd4cf4aab91dfe70889987bc9e5a05d19c276a  LonelyRunner/PivotResidues.lean
49131a7f9690042d1b16cbc876417f9d9ce1b53cc6565f87b6d1b53c4e3340cd  LonelyRunner/Prompt99Scaling.lean
9d949bf0ff389b519721cb9fcf3fb60123df08b9f4612a35ba4b90e36e084de3  docs/internal-pair-overlap-supply-refutation.md
f6130fd8ed2bda6b50aa73b64a6fcbdbacb27efb478163d0b6e4e9e12d69dc50  research/astra-next-bridge-audit.md
```

The last file's three-lower-owner manuscript at `N=7` was independently under
review during this task. This note does not require that theorem for the
guard argument or computational decisions and does not promote its status.
The older owner review and Prompt95 mathematical audit were read only to
check known contract boundaries; their finite searches were not imported as
new evidence here.

No Lean declaration was added or checked for this note. The strict rational
guard construction, exact counterexample interpretation, and decision-search
algorithm need independent mathematical review before acceptance. A passing
workflow validator and finite computations do not settle unrestricted LRC.
