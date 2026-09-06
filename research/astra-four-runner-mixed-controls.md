# Exact endpoint compression controls for the finite N=4 target

This is finite proof-data compression for the prospective `H<=36` bounded
branch only. It is not a Lean theorem, a native-computation claim, or a proof
of the proposed four-runner classification. The frozen source plan is
[`astra-four-runner-mixed-finite-plan.md`](astra-four-runner-mixed-finite-plan.md),
with SHA-256
`9b71c56eb36093793df2bf02807e4f7da5f69ef1bccf4edeb68230c154dee085`.

The plan's sole program, stdout, and ordered positive-row digest are guarded
at SHA-256
`233831abc5b5fa246012c05d4ac8ee84738520529c6bf320f1a88d0aec83c845`,
`1b39847584961da45a366d2bfc8035c5be82ef0a7d179927a1297016e6f70aa9`, and
`08e98062af51e2c5e5e5c7d45caaa0cb166d19caa8e55f1ca370d55fef6bdbd3`.

The program below replays those 6,078 positive endpoint rows, obtains its
candidate pool only from their unique reduced rational endpoints, and uses no
new time search. It greedily selects a candidate covering the most currently
uncovered triples. Ties are resolved by `(q,p)`. Every selected candidate is
rechecked against every primitive `a<b<H<=36` by the six displayed natural
residue inequalities; `(1,2,3)` is retained separately as the sole exception.
All candidate denominators are at most 140.

Run from the repository root with `python3 -B`; it writes no file and uses no
floating point arithmetic.

```python
from pathlib import Path
from hashlib import sha256
from contextlib import redirect_stdout
from itertools import combinations
from math import gcd
import io
import json
import re

PLAN = Path('research/astra-four-runner-mixed-finite-plan.md')
PLAN_SHA = '9b71c56eb36093793df2bf02807e4f7da5f69ef1bccf4edeb68230c154dee085'
SOURCE_PROGRAM_SHA = '233831abc5b5fa246012c05d4ac8ee84738520529c6bf320f1a88d0aec83c845'
SOURCE_OUTPUT_SHA = '1b39847584961da45a366d2bfc8035c5be82ef0a7d179927a1297016e6f70aa9'
SOURCE_ROWS_SHA = '08e98062af51e2c5e5e5c7d45caaa0cb166d19caa8e55f1ca370d55fef6bdbd3'

assert sha256(PLAN.read_bytes()).hexdigest() == PLAN_SHA
blocks = re.findall(r'^```python\n(.*?)^```[ \t]*$', PLAN.read_text(), re.M | re.S)
assert len(blocks) == 1
source = blocks[0]
assert sha256(source.encode()).hexdigest() == SOURCE_PROGRAM_SHA
source_stdout = io.StringIO()
namespace = {}
with redirect_stdout(source_stdout):
    exec(compile(source, 'four-runner-finite-plan', 'exec'), namespace)
assert sha256(source_stdout.getvalue().encode()).hexdigest() == SOURCE_OUTPUT_SHA

rows = namespace['rows']
encoded_rows = json.dumps(rows, separators=(',', ':')).encode() + b'\n'
assert len(rows) == 6078 and sha256(encoded_rows).hexdigest() == SOURCE_ROWS_SHA

def covers(W, p, q):
    ra, rb, rh = [(w * p) % q for w in W]
    return (q <= 4 * ra <= 3 * q and q <= 4 * rb <= 3 * q and
            q <= 3 * rh <= 2 * q)

candidates = sorted({(row[-2], row[-1]) for row in rows}, key=lambda t: (t[1], t[0]))
assert len(candidates) == 300
assert all(p > 0 and q > 0 and q <= 140 for p, q in candidates)

uncovered = {tuple(row[:3]) for row in rows}
selected = []
while uncovered:
    best = None
    best_hits = []
    for p, q in candidates:
        hits = [W for W in uncovered if covers(W, p, q)]
        if (len(hits) > len(best_hits) or
                (len(hits) == len(best_hits) and best is not None and
                 (q, p) < (best[1], best[0]))):
            best, best_hits = (p, q), hits
    assert best is not None and best_hits
    selected.append(best)
    uncovered.difference_update(best_hits)

for W in {tuple(row[:3]) for row in rows}:
    assert any(covers(W, p, q) for p, q in selected)
domain = [W for W in combinations(range(1, 37), 3) if gcd(*W) == 1]
exception = (1, 2, 3)
assert len(domain) == 6079
assert {tuple(row[:3]) for row in rows} == set(domain) - {exception}
for W in domain:
    if W == exception:
        assert not any(covers(W, p, q) for p, q in selected)
    else:
        assert any(covers(W, p, q) for p, q in selected)

print(json.dumps({
    'candidate_pool': len(candidates),
    'cutoff': 36,
    'mixed_empty': [[1, 2, 3]],
    'primitive_triples': 6079,
    'selected': [list(t) for t in selected],
    'selected_count': len(selected),
    'status': 'PASS',
    'verified_positive_triples': len(rows),
}, sort_keys=True, separators=(',', ':')))
```

The program SHA-256 is
`7a0dc12d145b9b9672bb026e594f26058ad3dca984900da53117a63e7f9a7720` and
its exact one-line stdout SHA-256 is
`67c3a57dabaa6cb0ce5090aaf9b90fdd0e22f2ea2396a608aef667102f0ce21c`.
The output is the deterministic 34-pair list shown by the program, in the
listed order, with `candidate_pool=300`, `primitive_triples=6079`, and
`verified_positive_triples=6078`.

```json
{"candidate_pool":300,"cutoff":36,"mixed_empty":[[1,2,3]],"primitive_triples":6079,"selected":[[1,3],[1,54],[1,8],[3,8],[1,4],[5,12],[1,20],[22,51],[9,64],[22,63],[5,48],[2,27],[13,63],[13,45],[4,21],[11,36],[1,12],[1,6],[14,51],[9,28],[7,18],[1,36],[7,15],[21,80],[1,15],[3,20],[13,60],[13,27],[5,56],[4,9],[5,21],[9,52],[22,69],[13,33]],"selected_count":34,"status":"PASS","verified_positive_triples":6078}
```

The compact output records a 300-time endpoint pool and a 34-time selected
cover. It verifies all 6,078 nonexception primitive triples and keeps
`(1,2,3)` distinct, with its separate analytic ordinary half-period argument
remaining in the frozen plan. This certificate is bounded finite data awaiting
the proposed kernel arithmetic checker and independent review; it makes no
claim beyond the stated `H<=36` domain.
