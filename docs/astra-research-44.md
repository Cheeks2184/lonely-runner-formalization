# Forty-fourth Astra checkpoint: the Renault phase lemma

The concrete Renault phase certificate now yields a Lean theorem for every
three real phases. One candidate works for all three: either an affine phase
with a common natural slope from 2 through 5 and a common sixth-turn shift
from 1 through 5 has circular distance at least 1/6, or a common shift of
1/6, 2/6 or 4/6 has circular distance strictly greater than 1/6. The theorem
allows arbitrary real phases, including negative values and integer endpoints.
It does not require the phases to be ordered, distinct or rational.

This is the exact mixed closed/strict statement of Renault Lemma 5.1, with
its periodic extension to arbitrary real inputs. It is an ingredient of the
six-total-runner argument, not that argument's conclusion. No new runner
count or unrestricted Lonely Runner result is claimed.

## Connecting the fixed data to real phases

`RenaultPhaseBandFacts` decodes the 23 candidates and expresses the required
endpoint arithmetic over natural numbers. Closed candidates use inclusive
singleton remainder bounds; the three strict candidates use strict bounds.
For open atoms, inclusive endpoint bounds suffice because every slope is
positive and the phase lies strictly between the endpoints.

`RenaultPhaseBandSoundness` proves the real implication for arbitrary cuts
and masks satisfying those facts. It uses exact quotient/remainder arithmetic
for singleton phases and an affine open-band proof for interval phases. The
quotient selects an integer band; the proof does not assume it is the floor
of every real point in the interval. Integer periodicity gives an exact
fractional-part equivalence for both strict and closed candidate goodness.

`RenaultPhaseConcreteData` copies the frozen certificate's 61 cuts, 120 atom
masks, 41 retained atom indices and 120 domination indices. Its 120 private
row proofs use ordinary kernel-checked `decide` over the fixed 23 candidates.
The public facts also check the first and last cuts, link the retained atoms
to the previously checked core masks, and check every domination intersection.
No new masks, witnesses or candidate families were searched for.

`FiniteMaskSubset` turns an unchanged bitwise intersection into inclusion of
bounded candidate sets. `RenaultPhaseLemma` uses that inclusion, finite-cut
coverage, real band soundness and the previously checked core intersections
to prove the common-candidate theorem on [0,1). Fractional-part normalization
then gives all real phases. The final decoder chooses the shared slope and
shift once, outside the quantifier over the three phases.

## Verification and independent review

The complete endpoint source passed its declared resource-capped kernel check
in approximately nine seconds, with empty stdout and stderr. The first run
failed to synthesize decidability through a private definition. Changing that
wrapper to an abbreviation preserved every predicate and made its finite
decision procedure transparent. The complete failed source and execution
record are retained separately from the passing record. Before execution,
root also corrected generated proof indentation and compared all four literal
arrays to the frozen certificate.

The focused concrete-data and assembly build passed, followed by the full
project build with 3,674 jobs. The trust audit accepted 589 theorem reports;
all 20 new public declarations are included in its output and use only the
permitted axioms. The full build replays existing warnings in older modules;
the new focused modules compile without warnings.

The independent generic-band review and root's exact replay both passed.
Independent review of the concrete data, subset transport and final assembly
also passed, followed by root’s exact replay. Both probes checked universal
types and allowed axioms; the final probe also checked the four literal
definitions and guarded their certificate transcriptions. The verification JSON records exact
source hashes, commands, outputs and the distinction between source drafts,
kernel checks and independent reviews.

The preceding checkpoint was merged as PR 42 at
`5e60390195660af375300233309f058f2d2cb452` after both required checks passed.
Root verified the checkpoint head is an ancestor of remote main and synchronized
local main before starting this checkpoint branch.

The shared build cache remains needed by the active review and immediately
queued divisibility work. The full conjecture remains active and unresolved.
