# Draft follow-up: reducing a one-zero obstruction to a balanced cover

Status: root working derivation, independent Astra review pending. This note
supplies no actual one-zero counterexample and no universal positive theorem.
The two-zero guard counterexample is separately frozen in
`astra-unique-bad-escape-audit.md`. The current bounded p=13 cover search has
not supplied a reproducible positive certificate.

Let p be an odd prime. Suppose A has p-3 positive unit speeds, includes 1,
and its strict bad sets cover every unit numerator modulo p^2. Additionally
suppose the p-3 residues a mod p are pairwise distinct. Choose D=lcm(A) and
C=p*D, so each a<C and p^2 does not divide C. A alone covers all unit grid
points. At every nonunit grid point k/p (1<=k<p), all unit rows are good
and C is bad.

At the right endpoint t=k/p+1/(p*C), a row a in A is bad exactly when
k*a=-1 modulo p: its fractional numerator is k*a mod p plus a/C, with
0<a/C<1. Thus A blocks p-3 distinct choices of k and leaves exactly two,
x and y. Let b=(x-y)^(-1) mod p in 1..p-1, and let q=-b*x mod p in
1..p-1. The latter is nonzero since b,x are units. Put B=q*C+b.
Then B is a unit modulo p, B>C, and B/C=q+b/C with 0<b/C<1. At the two
remaining points its homogeneous residues b*x=-q and b*y=-q-1 are precisely
its two bad residues. Consequently B blocks both remaining right endpoints.
Reflection t -> 1-t treats every left endpoint as well.

The tuple V=A+(B,C) has p-1 distinct positive speeds, gcd one and exactly
one p-divisible speed, with none divisible by p^2. Every grid point fails.
At unit grid points, a unique bad owner can only belong to A because A
already covers the point; C is good. Any endpoint of any such A-row is
integral for C and hence fails. At nonunit grid points only C is bad, and
all its endpoints fail by the preceding construction. This would refute the
one-zero single-step candidate if an A satisfying the antecedent is found.
It would not disprove LRC. An independent ordinary witness should accompany
any actual numerical instance before promotion.

Signed representatives of a p^2 unit cover can be oriented to have distinct
mod-p residues whenever each signed class {r,-r} has occupancy at most two.
Normalize the cover by a common unit modulo p^2 to include speed 1, then
orient the remaining representatives consistently; this preserves covering
and signed-class capacity. The current ten-row p=13 cover has three entries
in one signed class and fails that criterion. A bounded search with the
capacity restriction is exploratory; nonfinding proves no impossibility.

Next check: independent Astra review of this conditional construction, then
prove or refute existence of a suitable balanced cover. Do not replace that
antecedent with finite-search optimism or treat it as unrestricted supply.
