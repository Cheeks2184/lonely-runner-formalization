# Independent review of three lower owners at denominator seven

Accepted at manuscript scope, 5 September 2026. The entire frozen
[author audit](astra-next-bridge-audit.md), SHA-256
`f6130fd8ed2bda6b50aa73b64a6fcbdbacb27efb478163d0b6e4e9e12d69dc50`,
was read, including its contract map, historical exclusions, new proof, value
comparison, guard control, and executable certificate. No correction is
required. All 16 listed source hashes and the separately listed takeover-audit
hash match. Relevant Lean declaration types and definitions were inspected;
no Lean build or axiom audit was repeated, and the new theorem is not yet
formalized.

The accepted new statement is exactly: for every `0<a<b<c<p` in the natural
numbers, the union of their three literal `pivotBadResidues 7 p` sets has
cardinality strictly below `6p`. A remaining candidate supplies a common
closed `1/7` witness for `a,b,c,p`. Sorting makes this equivalent to the
three-distinct-owner formulation. There is no prime assumption on the pivot,
bounded-height assumption, supplied witness, or hidden coprimality premise.
The condition implies `p≥4`; smaller pivots cannot have three distinct
positive lower owners.

This is a uniform but restricted supply theorem. It does not protect the two
other arbitrary moving speeds of a full seven-runner instance, establish
unrestricted internal-cover redundancy, or resolve LRC.

## 1. Independent count derivation

Use the author's exact finite sets

`R={0≤r<7p : 7∤r}`,
`B_d={r∈R : min(r*d mod7p,-r*d mod7p)<p}`,
`Z_d={r∈R : r*d=0 mod7p}`.

Equality at residue distance `p` is safe. There are `6p` candidates, and
every candidate makes the pivot phase `r/7` closed-good.

Let `h=gcd(d,p)`, `P=p/h`, `D=d/h`, and `k=gcd(D,7)`. Dividing the common
factor gives `h` copies of the modulus-`7P` row. Since `gcd(D,P)=1`,
multiplication by `D` modulo `7P` has kernel size `k` and image the multiples
of `k`. The strict distance ball contains
`2*floor((P-1)/k)+1` such image residues. Excluded candidates `r=7s` remove
`2*floor((P-1)/7)+1` residues, because multiplication by `D` permutes residues
modulo `P`. Thus the independent count is

`|B_d|=h*(k*(2*floor((P-1)/k)+1)-(2*floor((P-1)/7)+1))`.

The analogous zero count is `|Z_d|=h*(k-1)`. These expressions agree with the
existing normalized-count and zero-kernel declarations. The `P-1` terms are
essential: replacing strict badness by a closed bad ball would change them.

For `k=1`, the count is at most `12p/7`. For `k=7`, write `D=7e`; then
`P≥8`, `7∤P`, `gcd(e,P)=1`, `7e<P`, and with `q=floor((P-1)/7)`,

`|B_d|/p=6*(2q+1)/P`.

For `q≥2`, `P≥7q+1` and `6*(2q+1)≤2*(7q+1)`. For `q=1`, only `P=8`
exceeds 2. At that denominator `D=7` is forced. Hence the unique possible
owner with count above `2p` is `d*=7p/8`, of count `9p/4`; it exists only
when `8|p`. Distinctness prevents using this exceptional row twice.

With zero, one, or two nonempty zero kernels, the sums are respectively at
most `36p/7`, `159p/28`, and `167p/28`, all below `6p`. With three zero
kernels and no exceptional row, all counts are at most `2p`. Every lower
owner contains the two distinct nonzero bad candidates `1` and `7p-1`, so
their union is at most the sum minus four, again strictly below `6p`.

## 2. The exceptional remainder, including arbitrary 7-adic height

The author's common-scaling proof is valid. Nonempty `Z_d` means
`v7(d)>v7(p)`. Removing `g=7^v7(p)` from all speeds and the pivot preserves
bad membership under reduction to the smaller modulus, with exactly `g`
copies of each candidate. It preserves intersections and differences too;
it does not keep the owners fixed while changing the pivot.

Here is an independent way to verify all valuations directly. For a zero row
`d=7he`, `p=hP`, badness is exactly

`7*min(e*r modP,-e*r modP)<P`.

With the exceptional row present, let `L=lcm(8,P)`. Then `L|p` and `7∤L`.
On the `L`-period, the exceptional row is bad exactly at `r mod8∈{0,1,7}`.
Every class modulo `L` has exactly `6*(p/L)` candidates in the complete
`7p` row: in each `7L` block it has seven representatives, exactly one
divisible by 7. Therefore, even if `7|p`,

`|B_d\B_*| = 6*(p/L)*#{r modL : 7*dist_P(e*r)<P, r mod8∉{0,1,7}}`.  

This proves that no coprimality with the original pivot was silently added.
It also gives a direct finite-period implementation option without explicit
7-adic induction.

The raw count is already strictly less than `15p/8` except at
`P=8,9,15,16,22`. For `q≥4`, the required inequality reduces to `33<9q`.
The three smaller values `q=1,2,3` give exactly the stated finite list. The
case `P=8` is the excluded exceptional owner itself.

| Remaining denominator | Independent literal remainder calculation |
| --- | --- |
| `9,15` | Coprimality with 8 distributes each bad `P`-class uniformly over all eight classes modulo 8. Five avoid the star. The remainder is `(5/8)*2p=5p/4`. |
| `16` | `7e<16` and `gcd(e,16)=1` force `e=1`. Of `0,1,2,14,15`, exactly `2,14` avoid the star, giving `3p/4`. |
| `22` | Four lifts of each class run through one parity class modulo 8. At most three avoid the star, giving the valid bound `63p/44<15p/8`. More precisely, the admissible `e=1,3` give three even and four odd bad classes, hence exact remainder `51p/44`. |

All periods divide the actual pivot, so these are exact counts, not
asymptotic densities. Consequently both other rows have remainder strictly
below `15p/8`, and

`|B_*∪B_b∪B_c| < (9/4+15/8+15/8)*p = 6p`.

This completes an unrestricted-height proof of the proposed theorem. The
closed witness follows from the exact modular-band interpretation at the
time `r/(7p)`; no endpoint was lost in the counting argument.

## 3. Value and the surrounding contracts

The existing `OwnerKernelCover` declaration has numerical premise
`2(N+1)c+(N-2)e≤N(N+1)` and protects only its listed owners and pivot.
Taking all three labels as zero representatives gives `9N≤N(N+1)`, true for
`N≥8`. Thus the new denominator-seven proof extends that uniform domain to
all `N≥7`. Families of zero, one, or two lower owners are already covered by
the existing bound. With injective original speeds, an internal owner at a
maximum covered pivot is strictly slower. Hence complete internal covers
there require at least four owners, and at most four covered labels makes
redundancy vacuous. This uses injectivity only in that application.

The two separating examples are genuine:

* At `p=72`, owners `(1,56,63)` have counts `(122,144,162)`, 128 safe
  candidates, and two indispensable zero representatives.
* At `p=360`, owners `(315,280,168)` have counts `(810,720,720)`, 600 safe
  candidates, and three indispensable zero representatives. The raw sum
  minus the common-pair correction is `2250-4>2160`.

Literal zero-set inclusion confirms the respective minimum domination
numbers 2 and 3. Both old numerical budgets fail. The existing ordered-union
machinery can express the final overlap certificate, but does not supply the
new uniform arithmetic remainder estimate. The inspected fast-insertion
contract requires a witness and factor-four separation when adding a fourth
moving speed, and the saturated-top-two contract specifies a saturated lower
interval and may choose a different pivot. Neither directly gives this
fixed-pivot arbitrary-height result. These are exact source-contract
comparisons, not claims of literature priority or impossibility of finding
other proofs.

The broader contract map is accurate. The pivot-certificate and
divisor-or-uncovered-pivot formulations are existing equivalences; their
existence propositions have not been proved. Gcd normalization and the
primitive divisibility split of Prompt95 also preserve an unproved
redundancy proposition. A finite internal cover has a minimal subcover, so
universal removable-owner redundancy at a fixed pivot is equivalent to
absence of an internal cover there. If every original pivot were covered,
the maximum-speed pivot would contradict that redundancy. This proves the
stated sufficient implication of universal Prompt95, not a converse from
ordinary witness existence.

The historical exclusions retain their accepted scopes. The Prompt104
inequalities give `3c≤N` and `N+1<3c`, a contradiction. The takeover audit's
Prompt105 argument correctly counts two boundary certificates and their
reflections, including isolated components, or uses odd-speed candidates
near the antipode; it is a manuscript equivalence to witness existence.
The internal pair-overlap counterexample and one-zero-dominator row concern
failed numerical supply claims. The existing two-parent certificate indeed
subsumes a single-dominator split tree by rooting it at that dominator.
None of these observations revives a rejected supply premise or establishes
unrestricted LRC.

## 4. The balanced guard stress case

For the actual tuple `V=A+(B,C)`, with
`A=(1,7,8,10,17,136,133,64,100,80)`, `C=47028800`, and `B=423259206`,
the two explicit perturbed times and candidate numerators are correct:

`t_B=1/9+10/(39B)`, `r_B=611374412≡-1 mod13`;
`t_C=1/9-17/(117C)`, `r_C=67930487≡1 mod13`.

Their fractional pivot phases are respectively `12/13` and `1/13`.
At the second time the `B` phase is `14/39-34/(39C)`, inside the good band.
The stated small-speed Lipschitz margins are strictly adequate. Direct exact
rational checks protect every original row at both times, without enumerating
either huge pivot grid.

For each `a∈A`, the divisibility `13a|C` instead makes its entire row covered
by the outside owner `C`. Thus the covered set is exactly `A`, whose maximum
is 136. Its nine internal lower owners have empty zero kernels and fail the
old budget `252≤182`, but the candidate `r=196` is safe for all of `A`.
The outside row `C` kills it. This proves failure of the proposed numerical
budget as a consequence of maximal coveredness, while being consistent with
internal-cover redundancy. The additional zero-kernel size lists at `B` and
`C`, and the fact that `B>C` prevents treating the full `C` row as a lower-owner
family, are correct. No row has been silently dropped.

## 5. Independent reproducible evidence

The author block passed: 230,300 triples, 6,074 periodic pairs, two common
7-power controls, two separating fixtures, and three guard certificates.
The separate program below uses literal residue sets and verifies exact
normalization and periodic multiplicities, not just noncoverage. It checks
4,950 lower rows, 27,405 triples, 65 star remainders, the six exceptional
`(P,e)` choices at multipliers `1,7,49`, and the separating and guard controls.
Its scan of the raw exception list is finite supporting evidence for the
analytic `q` proof above, not an unbounded search argument.

```python
from fractions import Fraction as F
from itertools import combinations
from math import gcd, lcm


def bad(N,p,d):
    M=N*p
    return {r for r in range(M) if r % N
            and (r*d % M < p or r*d % M > M-p)}


def zero(N,p,d):
    return {r for r in range(N*p) if r % N and r*d % (N*p) == 0}


rows=triples=remainders=0
for p in range(2,101):
    R={r for r in range(7*p) if r % 7}
    Bs={d:bad(7,p,d) for d in range(1,p)}
    for d,S in Bs.items():
        h=gcd(d,p); P=p//h; D=d//h; k=gcd(D,7)
        assert len(S)==h*(k*(2*((P-1)//k)+1)-(2*((P-1)//7)+1))
        assert len(zero(7,p,d))==h*(k-1)
        if k==1:
            assert 7*len(S)<=12*p
        else:
            assert P>=8 and P % 7 and D % 7==0
            assert len(S)*P==6*p*(2*((P-1)//7)+1)
            assert (len(S)>2*p)==(P==8 and 8*d==7*p)
            assert 4*len(S)<=9*p
        rows+=1
    if p<=30:
        for ds in combinations(Bs,3):
            assert set.union(*(Bs[d] for d in ds))!=R
            triples+=1
    if p % 8==0:
        star=Bs[7*p//8]
        for d,S in Bs.items():
            if gcd(d,7*p)==gcd(d,p) or 8*d==7*p:
                continue
            assert 8*len(S-star)<15*p
            remainders+=1
assert (rows,triples,remainders)==(4950,27405,65)
assert [P for P in range(8,5001) if P % 7
        and 48*(2*((P-1)//7)+1)>=15*P]==[8,9,15,16,22]

exceptions={}
for P in (9,15,16,22):
    vals=[]
    for e in range(1,(P-1)//7+1):
        if gcd(e,P)!=1:
            continue
        L=lcm(8,P)
        small={r for r in range(L) if 7*min(e*r % P,-e*r % P)<P
               and r % 8 not in (0,1,7)}
        for mult in (1,7,49):
            p=L*mult; d=7*(p//P)*e; star=7*p//8
            R={r for r in range(7*p) if r % 7}
            assert all(sum(r % L==t for r in R)==6*(p//L) for t in range(L))
            actual=bad(7,p,d)-bad(7,p,star)
            assert len(actual)==6*(p//L)*len(small)
            assert 8*len(actual)<15*p
        vals.append((e,F(6*len(small),L)))
    exceptions[P]=vals
assert exceptions=={9:[(1,F(5,4))],15:[(1,F(5,4)),(2,F(5,4))],
                    16:[(1,F(3,4))],22:[(1,F(51,44)),(3,F(51,44))]}

for p,ds,sizes,safe,dom in [
    (72,(1,56,63),(122,144,162),128,2),
    (360,(315,280,168),(810,720,720),600,3),
]:
    Bs=[bad(7,p,d) for d in ds]; Z=[zero(7,p,d) for d in ds]
    assert tuple(map(len,Bs))==sizes
    assert 6*p-len(set.union(*Bs))==safe
    minimum=next(m for m in range(4) if any(
        all(any(Z[i]<=Z[j] for j in E) for i in range(3) if Z[i])
        for E in combinations(range(3),m)))
    assert minimum==dom and 16*3+5*minimum>56
assert 2 not in bad(7,8,4)  # exact residue distance 8 is safe
assert set.union(*(bad(7,11,d) for d in (1,4,5,6,7)))==\
       {r for r in range(77) if r % 7}

A=(1,7,8,10,17,136,133,64,100,80); C=47028800; B=423259206
V=A+(B,C)
def norm(t): return min(t % 1,-t % 1)
tB=F(1,9)+F(10,39*B); tC=F(1,9)-F(17,117*C)
assert 13*B*tB==611374412 and 13*C*tC==67930487
assert (B*tB) % 1==F(12,13) and (C*tC) % 1==F(1,13)
assert (B*tC) % 1==F(14,39)-F(34,39*C)
for p,t in [(B,tB),(C,tC)]:
    r=13*p*t
    assert r.denominator==1 and 0<r<13*p and r % 13
    assert min(norm(v*t) for v in V)==F(1,13)
assert all(C % (13*a)==0 for a in A)
assert max(A)==136 and 196 % 13
assert min(norm(F(196*a,1768)) for a in A)==F(1,13)
assert norm(F(196*C,1768))==0
assert all(not zero(13,136,a) for a in A if a!=136)
assert tuple(gcd(d,13*B)-gcd(d,B) for d in V if d!=B)==(0,)*10+(24,)
assert all(gcd(d,13*C)==gcd(d,C) for d in V if d!=C)
print({'literal_rows':rows,'literal_triples':triples,
       'literal_remainders':remainders,'exception_controls':18,
       'separating_fixtures':2,'guard_certificates':3})
```

Run with
`python3 -c 'from pathlib import Path; s=Path("research/astra-three-owner-review.md").read_text(); exec(s.split("```python\n",1)[1].split("```",1)[0])'`.

This program, the author program, source-hash checks, and
`python3 scripts/validate_workflow.py` passed. Only this review note was
written. The reviewed theorem is ready for a separately scoped formalization;
its fixed denominator, three-owner scope, strict bad sets, arbitrary positive
pivot, and all original hypotheses must be retained.
