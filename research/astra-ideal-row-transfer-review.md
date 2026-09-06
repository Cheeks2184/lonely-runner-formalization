# Independent review of strict ideal-row transfer

**Verdict: accepted as a conditional manuscript transfer.** A supplied
strict ideal failure for every specified pair produces infinitely many
ordinary integer clusters on which all proposed two-digit assignments
fail the closed target. The retained N=5 control supplies no such failure.
Neither source gives an actual counterfamily or an unrestricted LRC result.

Date: 2026-09-06. Task `/root/ideal_row_transfer_review`, in the existing
`/root/uniform_screen_review` session, requested Astra/xhigh. This reviewer
authored neither input. Observed runtime model/effort, total task time and
token accounting are not independently exposed and remain null. Current
parent-supplied checkpoint: `4227fef76e8a2081460c27b3af627bc6dcb501d4`.
Only this review is worker-owned. Current config, workflow, policy and
focused state were read, and structural validation passed.

## Bound inputs and premise

Both files were read completely. The embedded program was decoded and
read completely without being executed. Actual bindings are:

| Input | SHA-256 |
| --- | --- |
| `research/astra-ideal-row-integer-transfer.md` | `a8e53ac960a0cd0907437a38042ed574498259a472dc92cf223e4568f1124ebc` |
| `research/astra-general-slow-row-control.json` | `fbef3674ec3c30719325cfc91d0fc15c1a347377d0b4e8bd114e487059363d0c` |
| Decoded program, 3,776 bytes | `6b951fede947acc0791bc8f2ab46a0011717d81bd77d0dc0278756c3f49afbe3` |

The transfer fixes N>=5 and N-2 distinct nonnegative rational slopes r_i.
The pair set is

`P=({1,...,N-2} x {0,...,N-1}) union {(N-1,0)}`.

For every pair, at least one of the same fixed slopes must satisfy
`norm((k*r_i+ell)/N)<1/N`. The witnessing index may vary with the pair;
the slopes cannot. Choosing one index per pair and taking the minimum
of its positive deficits gives eta>0, since P is finite and nonempty.
The premise includes the exceptional pair (N-1,0). Failure of the
upper-strict forward predicate alone does not imply this strict closed
failure, since an upper boundary can still have norm exactly 1/N.

## Integer construction and exact slow-row pruning

Choose a positive common denominator q, with d_i=q*r_i nonnegative integers.
Let d_min=min d_i, H=max d_i-d_min, a=q, and

`M=N*q*T+d_min`, `c_i=d_i-d_min`.

Distinctness gives N-2 distinct integer offsets, with minimum zero and
maximum H. Positivity of q makes max(H,q)>0. For all sufficiently large
positive integers T, both

`M>(N-1)*max(H,q)` and `H*(N-1)/(N*M)<eta`

hold. M grows linearly with positive coefficient N*q, so this is an
infinite tail of integer T values, not a limiting construction without
actual finite examples. The slow speed a and the N-2 fast speeds M+c_i
are positive, distinct integers. Every fast speed exceeds a. The cluster
span is H, and M/max(H,a) tends to infinity. No primitivity conclusion
is required or silently used. M follows the displayed arithmetic progression;
the phase argument does not claim to work at every sufficiently large M.

The sampled times are precisely `t(k,ell)=k/(N*a)+ell/(N*M)` for
0<=k,ell<N, with all other fast digits zero. Put b=q*ell/(N*M).
The speed inequality gives 0<=b<1/N, and b=0 exactly when ell=0.
Thus the slow phase is k/N+b, always below one. Its cases are exact:

- For k=0 it is below 1/N and is bad.
- For 1<=k<=N-2 it is at least 1/N and strictly below 1-1/N.
- For k=N-1 it is the closed upper endpoint when ell=0, and is strictly
  above that endpoint when ell>0.

Consequently the slow speed's closed-good pairs are exactly P. There is
no omitted wrapping row. This is why the exceptional pair must be covered
by the ideal premise even though it would already fail a forward test.

## Actual fast phases and strict preservation

Since M+c_i=N*q*T+d_i and a=q, direct expansion at the actual common time
gives

`(M+c_i)*t(k,ell)=T*k+(k*r_i+ell)/N+c_i*ell/(N*M)`.

The term T*k is an integer. The final error e_i is nonnegative and bounded
above by H*(N-1)/(N*M), strictly less than eta. For the selected bad index
at this pair, the distance-to-integers function is 1-Lipschitz, hence

`norm((M+c_i)*t) <= norm((k*r_i+ell)/N)+e_i`

`<= 1/N-eta+e_i < 1/N`.

This inequality is global on the real line, so carries, changes of nearest
integer and fractional-part wrap cause no discontinuity in the proof.
An error of zero also preserves the original strict failure. At the
exceptional pair ell=0 the error is exactly zero.

Every pair in P therefore has a bad fast label, and every pair outside P
has a bad slow label. All N^2 proposed assignments fail the closed target,
hence also the forward target. This quantifies over the two-digit family;
it does not exhaust the full adapted grid with N-1 independently varying
digits, nor does it say that every real time is bad.

## Real slopes and the direction of transfer

A supplied strict failure with real slopes also has a finite selected
margin eta. Each selected norm changes by at most `(k/N)*abs(r_i-s_i)`
under a perturbation of its slope. Since k<=N-1, sufficiently small
simultaneous rational perturbations preserve all the strict inequalities.
One can choose the rational coordinates distinctly inside that neighborhood,
avoiding the finitely many previous choices. Distinctness need not be
manufactured by perturbing a non-strict failure; strict openness is essential.

Adding N times an integer to any one slope changes every ideal phase by
an integer k times that integer. It therefore preserves all pairs at once.
Separate sufficiently large shifts can make the rational slopes nonnegative
and pairwise distinct. A positive common denominator then exists, and the
proved construction applies. These operations transfer an existing strict
failure; they do not show that any such failure exists.

The converse is not established. A finite-M failure need not survive removal
of its positive corrections. Nor does ideal closed success imply success
at a corrected point: a good upper endpoint can become bad under an
arbitrarily small positive error. The manuscript properly makes neither
inference. No result from the separately assigned ideal-selection audit
or a proposed continuity extension is assumed here.

## Retained control: exact contract and bounded outcome

The decoded program fixes N=5, uses Fraction for every slope, phase and
comparison, and constructs the stated cuts j/k for k=1,2,3,4 with endpoints
zero and five included. The retained sorted list has 31 cuts and 30 open
cells. It chooses exactly three distinct cells and uses their midpoints.
The 4,060 possibilities agree with `30*29*28/6`. These are increasing
midpoint triples, not triples of arbitrary slopes or repeated cells.

Its labels are all 15 pairs with k=1,2,3 and ell=0,...,4 plus (4,0).
For each label it seeks one slope whose fractional phase is below 1/5
or above 4/5. Both endpoints are good. If no slope is bad for a pair,
that triple is immediately excluded as a possible all-pair failure.
Only a triple with witnesses for all 16 pairs would trigger a found result.
This is the exact quantifier order of the transfer premise.

The retained successful execution reports 4,060 triples examined, no found
triple, exit 0 and empty stderr. There is one recorded attempt and no repair
history. Its floating-point timer measures duration only; it is not used
in any mathematical decision. The result is accepted as the recorded bounded
nonfinding, without repeating the unchanged enumeration.

The found-witness branch is **unexercised**. Its separate integer residue
formula for x=p/q is `(k*p+ell*q) mod (5*q)`, divided by 5*q, which is
algebraically correct. That branch would report phase-agreement and strict
exteriority flags, including an aggregate all-16 flag. No such witnesses
were emitted or dynamically verified in this run. Those checks cannot
be described as 16 successful modular witness checks.

The bound record supplies no assertion about cut boundaries, two slopes
in the same cell, arbitrary real slopes, another N or integer clusters.
Any extension requires its own proof. Thus there is no realized premise
to feed into the conditional transfer and no actual counterfamily here.

## Actual review receipts

Commands ran in `/home/joshua/lonely-runner-formalization`. Source readback:

```sh
sha256sum research/astra-ideal-row-integer-transfer.md research/astra-general-slow-row-control.json
```

Exit 0; full output:

```text
a8e53ac960a0cd0907437a38042ed574498259a472dc92cf223e4568f1124ebc  research/astra-ideal-row-integer-transfer.md
fbef3674ec3c30719325cfc91d0fc15c1a347377d0b4e8bd114e487059363d0c  research/astra-general-slow-row-control.json
```

The source was first decoded, byte-counted, SHA-256 checked and printed
for full reading, with no execution of its contents. The following subsequent
administrative check verifies the retained metadata and stdout agreement;
it also does not execute the mathematical program. Exact command:

```sh
python3 -B - <<'PY'
import base64
import hashlib
import json
from pathlib import Path
record = json.loads(Path('research/astra-general-slow-row-control.json').read_text())
attempts = record['execution']['attempts']
assert len(attempts) == 1
attempt = attempts[0]
source = base64.b64decode(attempt['program_source_base64'], validate=True)
digest = hashlib.sha256(source).hexdigest()
assert digest == attempt['program_source_sha256'] == '6b951fede947acc0791bc8f2ab46a0011717d81bd77d0dc0278756c3f49afbe3'
assert len(source) == attempt['program_source_bytes'] == 3776
saved = json.loads(attempt['stdout_complete_bounded'])
for key in ('counterexample_found', 'cut_count', 'open_cell_count', 'candidate_triples_total', 'triples_examined'):
    assert saved[key] == record['result'][key]
assert saved['cut_set'] == record['result']['sorted_unique_cut_set']
assert attempt['exit_code'] == 0
assert attempt['stderr_complete_bounded'] == ''
assert record['execution']['failure_and_repair_history'] == []
print(json.dumps({'source_bytes': len(source), 'source_sha256': digest, 'attempts': len(attempts), 'recorded_exit': attempt['exit_code'], 'stdout_matches_result': True, 'cut_count': saved['cut_count'], 'open_cell_count': saved['open_cell_count'], 'triples_examined': saved['triples_examined'], 'counterexample_found': saved['counterexample_found'], 'mathematical_program_replayed': False}, sort_keys=True))
PY
```

Exit 0; full output:

```text
{"attempts": 1, "counterexample_found": false, "cut_count": 31, "mathematical_program_replayed": false, "open_cell_count": 30, "recorded_exit": 0, "source_bytes": 3776, "source_sha256": "6b951fede947acc0791bc8f2ab46a0011717d81bd77d0dc0278756c3f49afbe3", "stdout_matches_result": true, "triples_examined": 4060}
```

Workflow command:

```sh
python3 -B scripts/validate_workflow.py
```

Exit 0; full output:

```text
workflow structural validation passed; it cannot certify mathematical validity.
```

No mathematical search, simulation, enumeration replay, domain expansion,
Lean invocation, Git or cache action, shared-state mutation or other-file
edit was performed. All transfer verification was hand algebra and scope
review. No correction to either frozen input is required.

Owned-file whitespace check:

```sh
rg -n '[ \t]+$' research/astra-ideal-row-transfer-review.md
```

Exit 1 with empty output: no trailing-whitespace matches. The frozen review
SHA-256 is returned separately after the final file readback.
