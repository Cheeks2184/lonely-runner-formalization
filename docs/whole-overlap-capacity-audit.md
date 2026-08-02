# Whole-overlap capacity certificate at `F`, pivot `8`

## Scope

For

```text
F = (8, 15, 35, 40, 48, 56, 75, 132, 147),
```

this audit verifies one explicit Route C certificate at pivot `A=8`.  It is a
fixed-instance, fixed-pivot certificate.  It proves no uniform theorem and
makes no claim about the Lonely Runner Conjecture in general.

`scripts/audit_whole_overlap_capacity.py` is self-contained.  It reconstructs
the strict candidate universe, all eight nonpivot bad sets, every target
fiber, parent intersections, residue capacities, the exact bad union, and the
ordered additive optimum by literal finite enumeration.

## Capacity principle

The modulus is `80`, and the candidate universe is

```text
C = {r in {0,...,79} : r is not divisible by 10},  |C|=72.
```

For a candidate residue `r`, let `m(r)` be the number of nonpivot strict bad
sets containing it.  Its overlap capacity is

```text
cap(r) = max(0, m(r)-1).
```

For a child/token `(d,y)` and a distinct parent `p`, a whole-overlap block is

```text
Q(d,y,p) = {r in C : d*r=y (mod 80)} intersect B_p,
```

where `y` is a strict bad target for `d`.  Select at most one parent block for
each token and require that each residue occur in at most `cap(r)` selected
blocks.  If the selected credit is the sum of block cardinalities, then

```text
credit <= sum_r cap(r) = S - |union_d B_d|,
```

and hence `|union_d B_d| <= S-credit`.

## The 24 literal blocks

Every displayed set was checked for exact equality with the whole filtered
fiber/parent intersection, not merely checked as a subset.

| owner | target | parent | block `Q` |
|---:|---:|---:|---|
| 15 | 0 | 35 | `{16,32,48,64}` |
| 15 | 5 | 132 | `{43}` |
| 15 | 75 | 132 | `{37}` |
| 35 | 0 | 15 | `{16,32,48,64}` |
| 35 | 5 | 48 | `{55}` |
| 35 | 75 | 48 | `{25}` |
| 40 | 0 | 15 | `{16,32,48,64}` |
| 48 | 0 | 15 | `{5,75}` |
| 75 | 5 | 48 | `{15}` |
| 75 | 75 | 48 | `{65}` |
| 132 | 4 | 35 | `{57}` |
| 132 | 76 | 35 | `{23}` |
| 147 | 1 | 15 | `{43}` |
| 147 | 2 | 40 | `{6}` |
| 147 | 3 | 75 | `{49}` |
| 147 | 4 | 40 | `{12}` |
| 147 | 5 | 35 | `{55}` |
| 147 | 6 | 40 | `{18}` |
| 147 | 74 | 40 | `{62}` |
| 147 | 75 | 35 | `{25}` |
| 147 | 76 | 40 | `{68}` |
| 147 | 77 | 75 | `{31}` |
| 147 | 78 | 40 | `{74}` |
| 147 | 79 | 15 | `{37}` |

All 24 owner/target token pairs are distinct, all parents differ from their
owners, and every block is nonempty.

## Capacity and union audit

The selected uses exactly saturate every capacity they touch:

- residues `16,32,48,64` are each used `3/3` times;
- residues `25,37,43,55` are each used `2/2` times;
- residues `5,6,12,15,18,23,31,49,57,62,65,68,74,75` are each used `1/1`
  time.

Therefore the selected credit is

```text
4*3 + 4*2 + 14*1 = 34.
```

Literal enumeration gives `S=104`, so the capacity certificate yields

```text
|union_d B_d| <= 104-34 = 70 < 72 = |C|.
```

The exact union is smaller still:

```text
|union_d B_d| = 68,
C minus union_d B_d = {13,29,51,67}.
```

Thus the selected credit `34` is below the exact overlap debt
`S-|union|=36`, as it must be.

## Precise dominance statement

Any ordered additive certificate at this fixed pivot maps to a feasible
whole-overlap capacity selection: choose, for each credited token, an earlier
parent attaining its maximum.  At a residue lying in `m(r)` bad sets, the
earliest bad owner cannot be credited by an earlier bad parent, so at most
`m(r)-1` chosen blocks contain that residue.  The capacity relaxation
therefore weakly dominates ordered additive credit for the same pivot data.

Here the domination is strict.  An independent subset DP reconstructs

```text
maximum ordered credit = 32,  ordered bound = 104-32 = 72,
selected capacity credit = 34, capacity bound = 104-34 = 70.
```

This explains exactly how the Route C certificate crosses the strict
threshold where unrestricted ordering only attains equality.  It does not
show that a uniform capacity certificate exists for some pivot of every
tuple, nor that the capacity relaxation is exact.

## Reproduction

```bash
python3 scripts/audit_whole_overlap_capacity.py
PYTHONPATH=scripts python3 -m unittest -v tests.test_whole_overlap_capacity
```

The tests recheck all block equalities, unique tokens, strict endpoint and
candidate conventions, per-residue capacities, aggregate credit and union,
the four good residues, and the fixed-row ordered/capacity separation.
