# Two restricted results for ideal row selection

This bounded audit proves two uniform restricted selection lemmas. It does
not prove or refute the proposed claim for arbitrary real slopes. Neither
lemma reduces arbitrary slopes to its own hypotheses. Both supply a closed
selection in the regular rows, without the exceptional pair, within their
stated families. No forward endpoint claim or finite-M cluster transfer is
inferred.

Task: `/root/ideal_row_selection_audit`, requested Astra/xhigh.
Source checkpoint: `4227fef76e8a2081460c27b3af627bc6dcb501d4`.
Ownership is only this manuscript; concurrent files are preserved.

Context bindings, checked against the actual files:

- `research/astra-general-slow-cluster-audit.md`:
  `07d42aa0e48e2daa62d4799049b317eee526af42ecb025fcd0e6515a7cfa6478`.
- `research/astra-cluster-grid-rescue.md`:
  `edc948e31d6939132dd44dec7fe84612912ab952ceb8e98140a6b9cb2e9b5f9c`.
- `research/astra-cluster-grid-rescue-review.md`:
  `99caba49dd2b5b20475d89901d39fd6ce24fbbb5a060b949ab7707f52a6b569e`.

The proofs below are self-contained hand arguments. They use neither the
separate finite open-cell control nor the proposed ideal-to-integer transfer
as mathematical premises.

## 1. Target and circle conventions

For N>=5, put b=N-2 and let x_1,...,x_b be arbitrary real slopes modulo N.
The regular candidates are

    1<=k<=N-2,    0<=ell<=N-1.

A candidate is closed-good if every frac((k x_i+ell)/N) belongs to
[1/N,1-1/N]. The proposed claim also permits the exceptional pair (N-1,0).

Work on the circle R/(N Z), whose circumference is N. Write d_N for circle
distance. For a regular row k, selection is equivalent to an integer centre
h modulo N satisfying

    d_N(k x_i,h) >= 1    for every i.

Indeed choose ell congruent to -h modulo N. A row fails precisely when the
open radius-one arcs about the points k x_i cover all N integer centres.
Equality of distance to 1 is good. All rows use the same slopes x_i; the row
points cannot be assigned independently.

## 2. Approach one: the near-regular prime-grid family selects

Let q>=5 be prime, N=q+1, and take the b=q-1 slopes

    x_j = alpha + N j/q,    j=1,...,q-1,

for an arbitrary real alpha. Then some regular pair (k,ell) is closed-good.
In fact a regular row k works if and only if

    ||k alpha|| <= 1/q,                                      (1)

where this norm is distance to an integer, on the unit circle.

To prove the equivalence, every 1<=k<=q-1 is a unit modulo q. Multiplication
by k therefore permutes the nonzero j, and the row points are precisely

    k alpha + N j/q mod N,    j=1,...,q-1.

Their circular gaps have length N/q except for the single gap of length
2N/q around the omitted point k alpha. Since N/q=1+1/q<2, the ordinary gaps
contain no centre at distance at least 1 from both bordering points. In the
long gap, the permitted centres form exactly the closed interval

    [k alpha-1/q, k alpha+1/q] modulo N.

All other row points lie farther along the circle than the two bordering
points. Thus this interval is the entire closed-good set of centres. Because
N is an integer, it contains an integer centre modulo N exactly when (1)
holds.

Now consider the q unit-circle points

    0, alpha, 2 alpha, ..., (q-1)alpha modulo 1.

If two coincide, their nonzero index difference gives (1) with norm zero.
Otherwise their q cyclic gaps sum to 1, so one gap has length at most 1/q.
Its endpoints have distinct indices with absolute difference k between 1
and q-1. Their unit-circle distance is at most that gap, so (1) follows.
This also handles the wraparound gap; no signed or out-of-range k is needed.

This proves selection for every alpha in the displayed family. Equality in
(1) is retained: it places a bordering row point at distance exactly 1 from
the selected centre. The argument does not discard rational equality cases
or claim that the resulting selection is forward-good.

Thus this structured family is not an obstruction to ideal selection. The
proof depends on the permutation of a punctured equally spaced grid and
does not apply to an arbitrary set of b real slopes.

## 3. Approach two: small perturbations of distinct residues also select

Let N>=5 be prime. Let R be any set of N-2 distinct residues modulo N, and
choose real slopes represented by

    x_r = r + epsilon_r,    r in R,
    |epsilon_r| < 1/(N-2).                                  (2)

Then some regular pair (k,ell) is closed-good. The perturbations may have
different signs and magnitudes and may be zero. They are attached once to
the slopes, not reassigned when the row changes.

Here is the exact sign constraint behind the proof. In every regular row,
|k epsilon_r|<1. If epsilon_r>0, the open radius-one arc about k x_r covers
the integer centres kr and kr+1; if epsilon_r<0, it covers kr-1 and kr.
If epsilon_r=0, it covers only kr. These statements are modulo N, including
arcs that cross 0. Since the bad arcs are open, the adjacent integer centre
is not bad when its distance is exactly 1.

Let u,v be the two omitted residues. Since k is a unit modulo the prime N,
the nominal row centres kR omit exactly ku and kv. For a missing centre kh,
where h is either u or v, write d=k^{-1} modulo N. It is covered only if

    epsilon_(h-d)>0  OR  epsilon_(h+d)<0,                    (3)

with an alternative omitted when its subscript is not in R. Conversely,
each displayed available alternative does cover kh. Formula (3) uses the
sign of the original perturbation: k is a positive integer, so it never
reverses that sign even when its residue modulo N acts as a negative
multiplier on the nominal centres.

Assume for contradiction that every regular row fails, so (3) must hold for
both holes in every regular row.

### 3.1 Nonadjacent omitted residues

Translate all residue representatives by -u. This adds an integer shift to
each row and merely permutes its columns, so assume the holes are 0,d with
d nonzero. Suppose d is neither 1 nor -1 modulo N.

Take k=d^{-1}, represented in {1,...,N-1}. Both k and N-k belong to the
allowed set {1,...,N-2}: exclusion of either would mean d=1 or d=-1.
The label -d belongs to R, because N is odd and d is nonzero.

In row k, the holes are 0 and 1. The only available neighbour that can cover
the missing centre 0 is label -d at nominal centre -1, requiring
epsilon_(-d)>0. In row N-k, the holes are 0 and -1. The same label is now
at nominal centre 1, and coverage of 0 requires epsilon_(-d)<0. This is a
contradiction.

### 3.2 Adjacent omitted residues

By choosing their order and translating, assume the holes are 0 and 1.
Failure of row k=1 forces

    epsilon_(-1)>0,    epsilon_2<0.                         (4)

For any e different from 0,1,-1 modulo N, the inverse rows e^{-1} and
(-e)^{-1} are both allowed. Applying (3) to the hole 0 in these two rows
gives

    epsilon_(-e)>0 OR epsilon_e<0,
    epsilon_e>0 OR epsilon_(-e)<0.

These two clauses force epsilon_e and epsilon_(-e) to be nonzero and to
have the same sign. Opposite signs fail one clause, and a zero sign makes
the two clauses require opposite strict signs from the other label.
Applying the same reasoning to the hole 1 forces equal, nonzero signs for
the pair of labels 1-e and 1+e whenever e differs from 0,1,-1.

Equivalently, the available reflection edges

    r <-> -r,       r <-> 2-r

force equal signs at their endpoints. The first excludes the missing labels
and the endpoint -1; the second excludes the missing labels and endpoint 2.
The following explicit path uses only available edges and joins those two
endpoints. Write N=2h+1:

    2, -2, 4, -4, ..., 2(h-1), -2(h-1), 2h=-1   (mod N).

For 1<=j<h, the edge 2j to -2j is reflection about 0, and the next edge
-2j to 2(j+1) is reflection about 1. Their respective distances from the
reflection centres are neither 0 nor 1 nor -1, so the paired inverse-row
argument applies. In ordinary representatives the positive even entries
are 2,4,...,N-1 and the negative even entries are N-2,N-4,...,3. Thus the
path visits every label in R exactly once. In particular epsilon_2 and
epsilon_(-1) must have the same sign, contradicting (4).

Both cases contradict simultaneous failure of all regular rows. This proves
the lemma, with the closed boundary preserved throughout.

The conclusion is more than an independent assignment of favourable row
signs: the contradiction specifically uses that every positive row
multiplier preserves each fixed epsilon_r's sign. Primality provides all
inverse rows used in the argument. Distinct nominal residues and (2) are
essential hypotheses of this proof, not consequences of the general ideal
selection problem.

## 4. Exact remaining scope and verification

Approach one proves selection in an unbounded punctured-grid family. Approach
two proves stability for small independent real perturbations of N-2
distinct integer residues when N is prime. These rule out two precise
structural constructions of an ideal obstruction. They neither establish
the full arbitrary-real-slope claim nor exhibit a counterexample to it,
even when its exceptional pair is retained.

The remaining issue is actual carry evolution outside (2): a row displacement
can pass integer centres, so a slope's extra bad column can change with k.
The fixed-sign clauses and reflection path then cease to follow. Arbitrary
slopes also need not have N-2 distinct nominal residues. No argument here
reduces those cases to either proved lemma or supplies a contradictory
constraint for their actual shared carry sequences. Merely allowing each
row an independently chosen sign or mask would discard the needed slope
coupling and is not a solution to that issue.

Only closed ideal selections have been proved. A selected upper endpoint may
be lost under a positive finite-M correction, so automatic transfer to the
general-slow two-digit candidate is not asserted. No restricted-family Lean
implementation is proposed without a caller; unrestricted LRC is unchanged.

Verification: hand circle geometry, finite cyclic pigeonhole, inverse-row
algebra, and the explicit reflection path. No mathematical program, solver,
enumeration, external theorem, or additional numerical domain was used.
The project config, workflow, policy and focused state were read, and
`python3 -B scripts/validate_workflow.py` exited 0 with:

    workflow structural validation passed; it cannot certify mathematical validity.

The three context hashes above were rechecked. The owned file was checked
for trailing whitespace and a final newline. There were no Git/state/cache
or Lean changes. These are manuscript proofs pending independent review.
