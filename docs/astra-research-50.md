# Fiftieth Astra checkpoint: positive witnesses from a supplied cover

The conditional factor-six cover implication is now a Lean theorem. For five
positive natural speeds, suppose exactly two labels p,q have speeds divisible
by three. If every other speed multiplied by six divides either v p or v q,
there is one positive real time at which all five circle norms are at least
one sixth. Repeated speeds are permitted; the cover is an explicit premise.

## The checked argument

The exact two-label characterization gives three exceptional labels. Under
absence of a positive witness, the full supplied cover and the fast-speed
theorem exclude both extreme ratios: v p < 5*v q and v q < 5*v p. These
inequalities are obtained before selecting any exceptional pair.

The finite-set pigeonhole theorem chooses two distinct exceptional labels
whose factor-six speeds divide the same target A. Positive divisibility gives
the two corresponding speed bounds. The local finisher needs only these
inequalities, the exact two-label characterization and both reciprocal ratios.

At the seed 1/(6*A), each selected small phase is at most 1/36; at five times
that seed it is at most 5/36. The scalar lemma proves strict badness at both
times for arbitrary positive real speeds satisfying the smallness bound.
The target A has the closed-safe phase 1/6 or 5/6, respectively.

If the other divisible speed is safe at the first seed, the checked collision
rescue completes the witness. Otherwise the reciprocal ratios and the closed
integer band force its first phase x into (1/30,1/6); its second phase 5*x is
then safe. The rescue applies at that seed instead. In both branches, one
common third shift handles every label and preserves positive time.

The proof uses absence of a positive witness only where the existing fast
wrapper already returns positive time. It does not silently strengthen that
assumption to absence of every real-time witness.

## Verification and remaining premise

Four public declarations in three modules cover the scalar bounds, exact
exception count, local finisher and final cover wrapper. The full source build
passed 3,698 jobs; the trust audit accepted 627 dependency reports and eight
axiom-free declarations. All four exact contracts and complete proofs passed
independent source review. Root read the complete report and replayed its
exact import check: exit zero, 38 unchanged guards, four allowed-axiom reports,
443 bytes of complete stdout and empty stderr.

The verification JSON retains failed drafts and actual compiler output beside
their corrected passes. Corrections selected the positive-factor cancellation
lemma, supplied an explicit multiplication reassociation, and used the lower
rather than upper consequence of the exact cardinality equality. The scalar
draft received explicit weak-nonnegativity corrections before its first build.
No mathematical hypothesis or conclusion was weakened. New modules compile
without warnings; existing dependency warnings remain in the full build log.

One Terra implementation task returned without a file. Its result was retained,
the actual overall goal was checked as active, and the work was split into a
smaller scalar draft and root integration. No placeholder was introduced and
the unrestricted goal was not marked blocked.

The boundary-minimum-zero argument must still establish the supplied cover
from the larger two-divisible setup. This theorem therefore does not complete
that branch or an unconditional five-moving sixth-margin result, and does not
establish a new canonical runner count or resolve unrestricted LRC. The shared
pinned cache remains needed for active and queued boundary-assembly work.

The preceding checkpoint merged through PR48 after both required checks passed,
at main commit `901dcfda808cceb32718a2e98fdd793cc78154fe`. Root verified
reviewed-head ancestry and synchronized local and remote main.
