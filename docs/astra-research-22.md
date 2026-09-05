# Twenty-second Astra checkpoint: exact endpoint descent and its missing bound

Unrestricted Lonely Runner remains unresolved. This pass audits a finite
endpoint reduction and identifies precisely which proposed arithmetic estimate
would itself prove the full conjecture. No Lean source or dependency changed.

## What is now justified

The [minimal-sum manuscript](../research/astra-minimal-height-audit.md) proves
that complete coverage of an actual reference row at speed p places every
old-good component strictly between consecutive row candidates. Its width
is below 2/(Np). For every positive integer q with 2q<=(N-2)p, a witness
for the old speeds together with q therefore exists exactly when one of the
fixed old component endpoints is q-good. This includes closed equality,
negative times, singletons, and arbitrary old-speed counts and order.

After choosing a positive-integer failure of least moving count and then
least speed sum, deletion of its maximum p yields a nonempty finite endpoint
set. Every smaller positive speed is good at some endpoint, while p is bad
at all of them. A smaller speed bad at every endpoint would give a genuine
smaller counterexample. No such speed has been supplied. Duplicate speed
replacement uses the smaller tuple's stronger canonical threshold; it is
not an injective same-count tuple.

The [independent review](../research/astra-minimal-height-review.md) accepts
these exact contracts. It clarifies the integer frequency cap: frequencies
above p are included only when floor((N-2)p/2)>=p+1. The manuscript's explicit
inequality is correct; N>4 alone need not add an integer frequency.

## The first blocker has an exact geometric interpretation

For N>=4 and any nonempty old-good set, let E contain all its component
endpoints, W be its greatest component width, and b be the least positive
integer strictly bad at every endpoint. The period N*lcm(V) guarantees that
b exists. The [width audit](../research/astra-first-blocker-width-audit.md)
derives a sharp dichotomy:

- bW<2/N: adding b destroys every common witness.
- bW>(N-2)/N: every positive integer speed can be added with a common witness.

The intermediate range and both equality cases are impossible. The
[independent review](../research/astra-first-blocker-width-review.md)
accepts the exact fixed-set and uniform statements. In the
second case, endpoints handle speeds below b and the longest old component
handles every speed at least b. Thus the test at b decides all one-speed
extensions of this fixed old set.

The tempting universal estimate b>max(V), quantified over every canonical
old count with nonempty old-good set, is equivalent to unrestricted integer
LRC together with the established small cases. The reverse implication
deletes the smallest speed of a least-count failure. This prevents treating
the estimate as a routine consequence of periodicity or sum minimality.
It remains a possible proof target, with its full strength now explicit.

## Controls and practical limits

All five Euclidean replacements p -> p-a in the fixed example
V=(1,4,5,6,7), p=11 defeat raw reuse of every witness at the replacement's
correct canonical threshold, even after movement within its old component.
The original tuple itself has full witnesses; this only refutes that
unconditional transfer method.

Exact [first-blocker controls](../research/astra-first-blocker-controls.json)
give b=8, 2940, and 903 on three fixed old sets. The first and third have
nonintegral blocked endpoint phases, so the first blocker cannot generally
be identified with a common endpoint denominator. These are finite controls,
not proof of the missing uniform estimate.

Root reproduced the minimal-height author and independent review controls,
including the preserved 280,528 signed component tests and 78 additional
boundary tests, and replayed all three first-blocker fixtures. Verification
bindings and further width-review evidence are recorded in
[the pass record](../research/astra-pass22-verification.json).

A separate [bounded primary-source screen](../research/astra-primary-resolution-audit.md)
found no usable unrestricted resolution among its three inspected candidates.
The recent paper concerns at most thirteen total runners and relies on
computations not audited here; a full-proof claim is withdrawn; the inspected
formal entry contains `sorry`. This is a bounded screen, not an exhaustive
literature conclusion.

The next mathematical step must establish a new exclusion of the actual
minimum pattern or another unconditional witness supply. Repeating the
endpoint reformulation, the period argument, or raw Euclidean witness reuse
would not close that gap. Formalizing an equivalent condition alone would
also leave the requested proof unfinished.
