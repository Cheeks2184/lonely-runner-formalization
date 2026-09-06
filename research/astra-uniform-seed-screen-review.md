# Independent review of the all-deletion seed screen

Date: 2026-09-06. Registered task `/root/uniform_seed_screen_review`, executed
by `/root/uniform_screen_review`; requested Astra/xhigh. Runtime model,
effort and token usage are not independently exposed. Root supplied checkpoint
`e48f49d`. The reviewer did not author the screened manuscript and owns only
this review. The previous uniform-screen review is unchanged.

**Accepted: the exact finite decision reduction, protected-interval geometry,
and stated positive bounded controls. The uniform supply claim Q remains
unproved and unrefuted.** This is a manuscript/code review, not a Lean result
or an unrestricted LRC result. No blocking mathematical or checker defect was
found in the final artifact.

## Frozen input and review scope

The complete report read and reviewed is
`research/astra-uniform-all-deletion-seed-screen.md`, SHA-256
`b2b6acd00dae3c8ed777bc3da4227fab0254016eec035c2c100f8d346a398f1b`.
Its complete embedded Python block has 3,427 bytes, SHA-256
`ea6253ce7de5eed7e7c3f477858e09dcc2293f1fb0d93cf7656fd440c5e4d065`.
The frozen small-control prefix has 2,548 bytes, SHA-256
`06763233c17ccd066245b00fffe001028d0b1f8b8aa225816941f2efe4b4b43f`.
These code hashes exclude the fences and the newline before the closing fence.

All four source bindings in the report matched current bytes. The reviewer
inspected the actual Lipschitz lemma in `LonelyRunner/FastRunnerInsertion.lean`
and the relevant historical dense-component contracts, preserving the held
fastest-only strategy's scope. Current workflow/config/policy and focused
state were read; startup `python3 -B scripts/validate_workflow.py` exited 0:

```text
workflow structural validation passed; it cannot certify mathematical validity.
```

## Mathematical and checker acceptance

The count and margins are correct: `N-1` distinct positive moving speeds,
`delta=1/N`, and `gamma=1/(N-1)` for each deletion. Nonempty own-margin seed
sets remain explicit hypotheses. Common scaling preserves Q: scaling speeds
by `c` scales the seed time and radius by `1/c`, leaving the score unchanged.

Each function `(||v_i*t||-delta)/v_i` is 1-Lipschitz, so its finite minimum
`rho_p` is 1-Lipschitz. On a rising pivot half-period, its possible decrease
is cancelled by the exact increase `v_p*(u-t)` of the pivot norm. On a falling
half-period, the reverse bound makes the score nonincreasing. Therefore every
closed seed interval attains its maximum at an endpoint or pivot antipode.
Pivot integer times need not be added because they are minima between those
monotone pieces. Singleton intervals, flat pieces, and equality are included.

Integer-speed periodicity reduces all real times, including negative times,
to `[0,1]`. The `d` listed bands for each positive speed are its complete
closed gamma-good set in that period. The two-pointer intersection routine
preserves singleton intersections and merges touching output pieces without
enlarging the union. The candidate generator includes every seed endpoint
and every antipode in a seed interval. All arithmetic uses `Fraction` and
integers. Thus `audit` computes the claimed exact maximum for a nonempty
seed set; it returns `None` for an empty set.

The local geometric identity is exact, not just a sufficient radius bound.
Inside the unique old phase bands `[L_i,R_i]`, each normalized slack equals
`min(t-L_i,R_i-t)`. Their minimum is `min(t-L,R-t)`, where the weak component
is `[L,R]=[max L_i,min R_i]`. Since `gamma>delta`, a strong component lies
in the interior of exactly one weak component. For a strong interval `[l,r]`,
the protected balls have continuous nondecreasing left/right endpoints
`max(L,2t-R)` and `min(R,2t-L)`. Their union is exactly
`[max(L,2l-R),min(R,2r-L)]`, also for a singleton strong interval.

The maximum pivot norm on one protected ball is
`min(1/2,||v_p*t||+v_p*rho_p(t))`. Hence the score meeting delta is equivalent
to a full witness in that particular ball. The score itself can exceed 1/2;
the reported value `4/7` is a score, not a circle norm. Existence of an
arbitrary full witness has not been proved to imply Q.

`has_Q` correctly stops when any deletion supplies the existential conclusion.
It does not calculate every pivot maximum in each broad positive case, and
it does not establish that every deletion seed set is nonempty in those cases.
Neither fact is needed to certify a positive Q witness. A future negative
certificate would separately require all deletion seed sets to be nonempty
and every maximum to be strictly below delta; a bare `has_Q=False` would
not establish that antecedent.

## Controls and bounded-search scope

The small replay verified all twelve table entries for the two requested
tuples, including the listed seed-interval counts and maximizing times.
The first tuple succeeds for pivots 6 and 7 despite its unsuccessful largest
pivot. The second tuple's pivot 2 attains exactly `1/7`; retaining closed
equality is essential. The six-consecutive-speed control also confirms five
exact-equality maxima.

For `(1,2,3,4,6,11)` with pivot speed 6 and seed `1/6`, the old strong
intersection is a singleton because speeds 1 and 11 impose opposite tight
inequalities. Their weak endpoint constraints give `[1/7,13/77]`.
The radius is `1/462`, the protected ball is `[38/231,13/77]`, and the
score is `1/77`. The actual full witness `1/7`, with norms
`(1,2,3,3,1,3)/7`, lies outside that ball but inside the same weak component.
This separates symmetric protection from whole-component motion. It does
not refute Q: the same pivot's maximum over all its seeds is `4/7`.

The first discovery list contains 512 generated cases: three controls and
509 fixed-seed pseudorandom six-subsets of `1..40`. Its gcd filter skips
nonprimitive cases; 512 is not a primitive-success count, and the list is
not claimed deduplicated. The second list contains exactly `choose(16,6)=8008`
six-subsets. Of these, 28 are all even and nonprimitive; no odd prime has
six multiples in `1..16`, so the reported 7,980 primitive cases are correct.
The complete checker requires a positive Q witness for each retained tuple.
These are finite `N=7` controls of one uniform mechanism, not higher-count
milestones, an induction step, or an exhaustive arbitrary-N result.

The full author reproducer reached its final PASS line after its assertions.
Its subsequent metadata operation failed because unrestricted `exec` replaced
the launcher's Path variable `p` with an integer. The final report preserves
the full command and raw `AttributeError` traceback, distinguishing the Python
process's exit 1 from the enclosing shell's later exit 0. This is a disclosed
launcher failure after the mathematical checks; it must not be reported as
a clean full Python-process exit. The reviewer did not repeat either broad
case list. Discovery durations are author-recorded measurements, not newly
verified reviewer timings.

## Independent small replay receipt

Root was notified immediately before and after this bounded Python run, so
cleanup could be held until it ended. Exact command, from the repository root:

```sh
python3 -B - <<'PY'
from pathlib import Path
from hashlib import sha256
import re
report=Path('research/astra-uniform-all-deletion-seed-screen.md')
source=report.read_text()
block=source.split('```python\n',1)[1].split('\n```',1)[0]
small=block.split('\nfrom itertools import combinations',1)[0]
assert sha256(report.read_bytes()).hexdigest()=='b2b6acd00dae3c8ed777bc3da4227fab0254016eec035c2c100f8d346a398f1b'
assert sha256(block.encode()).hexdigest()=='ea6253ce7de5eed7e7c3f477858e09dcc2293f1fb0d93cf7656fd440c5e4d065'
assert sha256(small.encode()).hexdigest()=='06763233c17ccd066245b00fffe001028d0b1f8b8aa225816941f2efe4b4b43f'
exec(compile(small,str(report)+':independent-small-controls','exec'),{})
bindings=re.findall(r'\| `((?:research|LonelyRunner)/[^`]+)` \| `([0-9a-f]{64})` \|',source)
assert len(bindings)==4
for path,expected in bindings:
    assert sha256(Path(path).read_bytes()).hexdigest()==expected,path
print('PASS: independent frozen small controls; both complete maxima tables; closed equality; local radius loss.')
print('PASS: full/small block hashes and all 4 source bindings matched.')
print('REPORT_SHA256',sha256(report.read_bytes()).hexdigest())
print('FULL_BLOCK_BYTES',len(block.encode()))
print('SMALL_BLOCK_BYTES',len(small.encode()))
PY
```

Exit 0, complete output:

```text
PASS: independent frozen small controls; both complete maxima tables; closed equality; local radius loss.
PASS: full/small block hashes and all 4 source bindings matched.
REPORT_SHA256 b2b6acd00dae3c8ed777bc3da4227fab0254016eec035c2c100f8d346a398f1b
FULL_BLOCK_BYTES 3427
SMALL_BLOCK_BYTES 2548
```

No search range was expanded. No Lean command, dependency/cache access,
Git operation, shared-state edit, or other source edit was performed.
The earlier review's readback hash remains
`4694285c064e53697343c9d04cbe05cac9714eb40be5799010e6058d1776af91`.
The remaining mathematical obligation is exactly a uniform reason that at
least one deletion maximum reaches `1/N`. This review supplies no such reason
and recommends no larger search in place of that missing argument.
