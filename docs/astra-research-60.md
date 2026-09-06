# Exact deletion-seed screening and its limits

The preceding uniform mechanism screens merged through PR58 at
`e45793996d7ab435ad93822b068ef489edf52f53` after both required CI jobs passed.
Canonical N=6 remains established. This pass investigates arbitrary-N seed
supply; it does not start a sequence of higher finite-runner milestones.

For a deletion p, an own-margin seed protects all other runners at 1/(N-1).
Its exact safe radius at the desired margin 1/N is the minimum of each old
runner's margin slack divided by its speed. Q asks whether some deletion seed
has pivot norm plus pivot speed times that radius at least 1/N, assuming all
deletion seed sets are nonempty. Such a seed supplies a full witness inside its
closed protected interval. The uniform existence assertion is still open.

The exact all-real checking reduction is now independently reviewed. Integer
periodicity reduces seeds to finitely many closed rational intervals. The
score reaches its maximum at a seed interval endpoint or a pivot antipode.
Within an old weak component [L,R], the radius at s is exactly
min(s-L,R-s). A strong component [l,r] therefore protects precisely
[max(L,2l-R), min(R,2r-L)]. This can be smaller than the whole weak component;
a full witness somewhere in that component does not alone prove Q.

Terra High checked twelve fixed inputs motivated by tight-set examples. All
254 deletion labels have nonempty seed sets, and each input has a successful
score and directly checked protected witness. Root verified the frozen source,
original execution transcript, complete driver and raw streams, then checked
the retained score attainers and 24 explicit full/protected witnesses. The
all-real interval enumeration was not repeated. The first calculation passed;
one Astra guidance round corrected an incomplete execution receipt without
rerunning the calculation or changing its output.

A separate, independently reviewed uniform argument explains every positive
input. If the speeds contain 1 and N-1, all others have residues 2 through
N-2 modulo N, and twice the maximum speed is at most (N-1)^2, delete speed 1
and choose s=1/N-1/[N(N-1)^2]. Its exact radius is 1/[N(N-1)^2], its score is
exactly 1/N, and its protected endpoint is the evident witness 1/N. These
restrictions hold for all twelve inputs. Their successes therefore add little
evidence about the missing arbitrary-N mechanism. In particular none covers
denominator N, as any genuine missing-witness tuple would have to do.

The earlier author's bounded discovery reached its mathematical PASS marker
but then failed in metadata reporting; this exit1 is retained explicitly.
The independent small check passed. Complete review and execution evidence,
including a corrected root provenance-validator newline convention, is bound
in `research/astra-pass60-verification.json`. No manuscript result here is
presented as a new Lean theorem, and unchanged Lean sources were not rebuilt.

The approved delegation method remains active: Terra High owns settled checks
and their bounded repairs, Astra owns semantics, complete focused receipts are
accepted without identical replay, and actual delivery metrics are retained.
There are now 19 closed High tasks; the next scheduled review is at 20. Exact
per-task usage remains unavailable, so no token-saving percentage is claimed.

With the verification batch finished and no Lean task queued, guarded cleanup
removed 7,943,743,726 bytes of rebuildable .lake cache. Pinned toolchains,
source, Git history and unique evidence were retained. Next work concerns the
relationship between different deletion choices and actual component geometry;
expanding generic finite searches is not the research plan. The unrestricted
formal proof/disproof goal remains active and unresolved.
