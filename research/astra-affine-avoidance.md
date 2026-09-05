# Affine avoidance with prescribed slope product

Status: independently accepted at manuscript scope by in-session Astra xhigh
(`/root/pivot_route`) and kernel-checked in `LonelyRunner/AffineAvoidance.lean`.
The additional `p−2` corollary was reviewed at manuscript scope by Astra xhigh
(`/root/owner_review`) and is kernel-checked in the same module.
These are auxiliary finite-field results, not LRC resolution.
Source checkpoint: ec30e17; proposed in the first authorized Astra research pass.

Inspiration: Sungkawichai–Trakulthongchai, Proposition 4.1,
<https://arxiv.org/html/2604.23906v2>. Their slopes enumerate all nonzero field
members. The observation below isolates the slope-product condition used by
that polynomial argument; novelty is not claimed without literature comparison.

## Exact proposed statement

Let p be an odd prime, I a finite index set of size p−1, and a,v : I → F_p.
Assume every a_i is nonzero, product_i a_i = −1, at least one v_i is zero,
and at least one v_i is nonzero. Then there exist nonzero r,s in F_p such that
for every i, s v_i + r a_i is neither 0 nor −1.

Repeated slopes are allowed. There is no assumption that the slope list is a
permutation, nor any hypothesis of a lonely time or lack of a complete cover.

## Derivation to review

Set P(X)=product_i(X+v_i/a_i). It is monic of degree p−1 and P(0)=0.
Call m in F_p^× good when all v_i+m a_i are nonzero; let G be this set.
Suppose the claimed pair r,s does not exist. For a good m and every nonzero s,
choose r=s m. All s(v_i+m a_i) are nonzero, so at least one equals −1.
As s varies, −1/s enumerates F_p^×. Thus the p−1 entries v_i+m a_i contain
every nonzero field element and hence enumerate them exactly once.
Their product is −1 (the product of F_p^×); dividing by product a_i=−1
gives P(m)=1. At a bad nonzero m, P(m)=0, and also P(0)=0.

Therefore sum_{m in F_p} P(m) equals |G| as an element of F_p. On the other
hand, the finite-field power sums show that the sum of a monic polynomial of
degree p−1 is −1: powers of degrees 0 through p−2 sum to zero, while the
(p−1)-st powers sum to −1. Hence |G| is congruent to p−1 modulo p.
Since 0<=|G|<=p−1, this forces |G|=p−1.

A nonzero v_j now contradicts this: m=−v_j/a_j is a nonzero bad value.
This proves the claimed existence, provided every finite-field step above is
verified. The zero and nonzero v hypotheses both matter to this proof.

## Relevance and remaining gap

This is a candidate generalization of the algebraic step in the project's
finite modular approach. It permits slope multisets beyond (1,...,p−1).
It does not classify all improper tuples, remove the prime assumption, or
supply a dimension-uniform family of prime gates. Connecting it to actual
integer-speed lift families also requires a separate exact floor/grid bridge;
no such bridge is claimed here. Do not mistake the slope-product premise for
an already established property of arbitrary LRC instances.

## Completed Lean declarations

The public theorem is `LonelyRunner.affine_avoidance_of_slope_product`, with
the following exact interface (universe-polymorphic index type):

```lean
theorem affine_avoidance_of_slope_product
    (p : ℕ) [Fact p.Prime] (_hodd : Odd p)
    {I : Type*} [Fintype I] (hcard : Fintype.card I = p - 1)
    (a v : I → ZMod p) (ha : ∀ i, a i ≠ 0)
    (hslopes : ∏ i : I, a i = -1)
    (hvzero : ∃ i, v i = 0) (hvnonzero : ∃ i, v i ≠ 0) :
    ∃ r s : ZMod p, r ≠ 0 ∧ s ≠ 0 ∧
      ∀ i, s * v i + r * a i ≠ 0 ∧ s * v i + r * a i ≠ -1
```

All polynomial and cardinality steps in the derivation above are proved
internally. The proof constructs a map into the unit group at a good value,
derives surjectivity from failure of avoidance, and uses equal finite
cardinalities to obtain a bijection. In particular, neither a permutation
hypothesis nor a polynomial-evaluation premise has been added to the interface.
The natural-cardinality conclusion uses `ZMod.val`, with `|G|<p` proved before
taking values. The final contradiction uses the explicit root `-v_j/a_j`.
The stated oddness hypothesis is retained, though the mixed-offset hypotheses
make the size-one `p=2` case impossible and the implementation does not need
to invoke oddness separately.

The second public theorem is `LonelyRunner.affine_avoidance_card_sub_two`:

```lean
theorem affine_avoidance_card_sub_two
    (p : ℕ) [Fact p.Prime] (hodd : Odd p)
    {I : Type*} [Fintype I] (hcard : Fintype.card I = p - 2)
    (a v : I → ZMod p) (ha : ∀ i, a i ≠ 0) :
    ∃ r s : ZMod p, r ≠ 0 ∧ s ≠ 0 ∧
      ∀ i, s * v i + r * a i ≠ 0 ∧ s * v i + r * a i ≠ -1
```

This corollary has no product condition and no restriction on the offsets.
When some offset is nonzero, extend the index type to `Option I`, with a
dummy row of slope `-(∏ i, a_i)⁻¹` and offset zero. The enlarged family has
size `p−1`, product `−1`, and both offset kinds, so the main theorem applies.
When all offsets vanish, the forbidden nonzero values `-a_i⁻¹` are an image
of a type of size `p−2`, and therefore cannot exhaust the `p−1` units.
Choose a remaining unit for `r` and set `s=1`. Both branches are proved in Lean.

## Kernel evidence and handoff

Implementation ownership: `/root/affine_formal`, explicitly requested
`gpt-6-astra` / `xhigh`, after Terra implemented the polynomial support. The
runtime does not expose independently observed model/effort metadata.

Verification completed on 2026-09-05 with the existing shared pinned cache:

```text
PATH="$HOME/.elan/bin:$PATH" lake env lean LonelyRunner/AffineAvoidance.lean
exit 0, no warnings or errors

PATH="$HOME/.elan/bin:$PATH" lake build LonelyRunner.AffineAvoidance
Built LonelyRunner.AffineAvoidance (1.4s)
Build completed successfully (1930 jobs).
```

A separate temporary Lean file imported the built module and ran `#print`
and `#print axioms` for both public declarations. It exited zero and reported:

```text
'LonelyRunner.affine_avoidance_of_slope_product' depends on axioms:
[propext, Classical.choice, Quot.sound]
'LonelyRunner.affine_avoidance_card_sub_two' depends on axioms:
[propext, Classical.choice, Quot.sound]
```

Source SHA-256 for `LonelyRunner/AffineAvoidance.lean` at this verification:
`9fb78dc2b12694f096ac423c04835f3f961e0769dc6d5ae6180033d6004f22c0`.
A focused source scan found no `sorry`, `admit`, `native_decide`, custom axiom,
`unsafe`, or `implemented_by`. Workflow structural validation passed at entry;
this validation is separate from proof evidence.

Root-module imports, central `AxiomAudit` integration, independent comparison
of these exact compiled contracts to the accepted manuscripts, and the full
project verification checkpoint are orchestrator-owned. No root build, cache
cleanup, or unrelated file edit was performed by this worker. Neither new
declaration proves the canonical Lonely Runner Conjecture or its negation.
