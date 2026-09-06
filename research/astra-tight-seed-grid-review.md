# Independent review of the restricted tight-seed grid family

Date: 2026-09-06. Task `/root/tight_seed_grid_review`, executed by
`/root/uniform_screen_review`; requested Astra/xhigh. Base supplied by root:
`e45793996d7ab435ad93822b068ef489edf52f53`. Observed runtime model/effort
and token usage are unavailable. The reviewer did not author the argument.
Only this review file is owned; prior reviews and concurrent work are preserved.

**Accepted at manuscript scope.** The argument proves a uniform restricted-family
seed construction explaining all twelve fixed controls. It neither proves
unrestricted Q nor supplies a new Lean result. No mathematical gap was found
under the stated hypotheses.

## Frozen inputs

| Input | SHA-256 |
| --- | --- |
| `research/astra-tight-seed-grid-explanation.md` | `0ba5e0aaeedd556eecf24eb2986123e6a81369291d3547e48c42d709e2e5595a` |
| `research/astra-tight-seed-controls-plan.md` | `810cefdc5466df979b3c91419159e67565fdb0c858f6704039e6340cb9640203` |
| `research/astra-tight-seed-controls.json` | `1b45a4b38b4964ae192304f942aa00ed5a5e16089fb63d8a277548408b5de876` |

The full explanatory manuscript and input plan were read. Current project
config/workflow/policy and focused state were read; the startup workflow
validator exited 0. The receipt is bound for its exact input tuples. Root's
separate driver/transcript verification, 254 score-attainer checks and 24
witness checks are not claimed as work repeated by this reviewer.

## Independent mathematical assessment

The theorem assumes `N>=4`, exactly `N-1` distinct positive integer speeds,
the actual labels 1 and `q=N-1`, every other residue in `2,...,N-2` modulo N,
and `2 max(v)<=(N-1)^2`. These are substantive hypotheses. Merely excluding
additional residues 1 and `N-1` would not suffice: residue zero must also be
excluded. Containing speed 1 already implies primitivity.

Set `delta=1/N`, `gamma=1/(N-1)`, `h=1/[N(N-1)^2]`, and `s=delta-h`.
For the deletion of the actual speed 1,

```text
q*s = 1-delta-q*h = 1-gamma,
||q*s|| = gamma,
(gamma-delta)/q = h.
```

The phase is strictly between 1/2 and 1 for `N>=4`, so the norm identity has
the stated orientation. Every other retained speed d has norm at least
`2delta` at time delta by the exact residue hypothesis. Lipschitz continuity
and the height assumption give

```text
||d*s|| >= 2delta-d*h,
2d*h <= delta,
2delta-d*h >= 3delta/2 >= gamma,
2delta-d*h >= delta+d*h.
```

The comparison `3/(2N)>=1/(N-1)` is valid precisely from `N>=3`, so the
advertised `N>=4` scope is sufficient. All retained speeds are therefore
own-margin safe, and every radius contribution is at least h. The q label
attains h, proving the **exact** minimum radius, not just a lower bound.

Since `0<s<delta<=1/4`, the deleted speed has norm `s=delta-h`.
Its score is exactly `delta`, and `s+rho=delta`. Thus the full witness at
`1/N` is the right endpoint of the closed protected ball. Strict score
inequality is neither proved nor needed. The argument establishes one
successful deletion directly; it does not establish nonemptiness of all
other deletion seed sets or calculate all their maxima. Those separate
properties of the twelve controls belong to the retained full checker receipt.

The general theorem includes the low endpoint `N=4`, even though the twelve
controls begin at `N=5`. Its small-denominator limitation is real: all speeds
are nonzero modulo N, so `1/N` is already a full witness and denominator N
is absent from the necessary divisor cover of any missing-witness tuple.
Consequently these positive controls do not resolve the unrestricted supply
obligation. No classification or tightness result from the external paper is
used by this proof or this review.

## Tiny exact input check

This independently constructs the twelve plan inputs, compares them with the
frozen receipt, and checks only the family hypotheses. It does not call
`audit`, rerun a score search, or enumerate additional tuples. The actual
executed Python script is the sole Python block below:

```python
from pathlib import Path
from hashlib import sha256
from functools import reduce
from math import gcd
import json

bindings = {
    'research/astra-tight-seed-grid-explanation.md': '0ba5e0aaeedd556eecf24eb2986123e6a81369291d3547e48c42d709e2e5595a',
    'research/astra-tight-seed-controls-plan.md': '810cefdc5466df979b3c91419159e67565fdb0c858f6704039e6340cb9640203',
    'research/astra-tight-seed-controls.json': '1b45a4b38b4964ae192304f942aa00ed5a5e16089fb63d8a277548408b5de876',
}
for path, expected in bindings.items():
    assert sha256(Path(path).read_bytes()).hexdigest() == expected, path
inputs = [(1,3,4,7), (1,3,4,5,9), (1,4,5,6,7,11,13)]
for N, r, w in [(8,6,12), (14,12,24), (20,18,36), (26,24,48),
                (32,30,60), (32,30,90), (33,30,60), (38,36,72), (44,42,84)]:
    assert 1 < r < N-1 and w >= N
    inputs.append(tuple(sorted((set(range(1,N)) - {r}) | {w})))
assert len(inputs) == len(set(inputs)) == 12
receipt = json.loads(Path('research/astra-tight-seed-controls.json').read_text())
records = receipt['results']['records']
assert receipt['results']['input_count'] == len(records) == 12
assert inputs == [tuple(row['tuple']) for row in records]
for index, (v, row) in enumerate(zip(inputs, records), 1):
    N = len(v)+1
    assert N >= 4 and row['N'] == N
    assert min(v) > 0 and len(set(v)) == N-1
    assert 1 in v and N-1 in v and reduce(gcd, v) == 1
    other = [d for d in v if d not in (1,N-1)]
    assert len(other) == N-3
    assert all(2 <= d % N <= N-2 for d in other)
    assert all(d % N != 0 for d in v)
    maximum = max(v)
    assert 2*maximum <= (N-1)**2
    print(f'case {index:02}: N={N}, max={maximum}, 2max={2*maximum}, bound={(N-1)**2}; hypotheses PASS')
print('PASS: all 12 exact inputs match the plan construction and frozen receipt; all family hypotheses hold.')
```

The enclosing command is preserved here as the exact shell invocation. Its
Python process receives the script above through extraction from this owned
review; it executes that script once in an isolated namespace. The raw script
output is captured only to hash and print it intact.

```sh
python3 -B - <<'PY'
from pathlib import Path
from hashlib import sha256
import contextlib, io
review = Path('research/astra-tight-seed-grid-review.md')
script = review.read_text().split('```python\n',1)[1].split('\n```',1)[0]
output = io.StringIO()
with contextlib.redirect_stdout(output):
    exec(compile(script,str(review)+':input-check','exec'),{})
print('SCRIPT_SHA256',sha256(script.encode()).hexdigest())
print('SCRIPT_BYTES',len(script.encode()))
print('SCRIPT_STDOUT_SHA256',sha256(output.getvalue().encode()).hexdigest())
print(output.getvalue(),end='')
PY
```

Invocation argv: `["python3", "-B", "-"]`, with the exact here-document above
as stdin, working directory `/home/joshua/lonely-runner-formalization`.
The resolved executable path was not separately recorded. The input check
ran once, exited 0, and produced no stderr or failure/repair history.
Root was notified immediately before and after the check.

Complete raw stdout, including its final newline:

```text
SCRIPT_SHA256 cd05a6a1aa320bb7a54cbf5a6b2ace5ebcb19f6ec200e3bd6e69f2241420b0d0
SCRIPT_BYTES 1819
SCRIPT_STDOUT_SHA256 d5de3e60e436e634d0a722948f07d8aa0fec5891309cb7c080ea3ca0140404e1
case 01: N=5, max=7, 2max=14, bound=16; hypotheses PASS
case 02: N=6, max=9, 2max=18, bound=25; hypotheses PASS
case 03: N=8, max=13, 2max=26, bound=49; hypotheses PASS
case 04: N=8, max=12, 2max=24, bound=49; hypotheses PASS
case 05: N=14, max=24, 2max=48, bound=169; hypotheses PASS
case 06: N=20, max=36, 2max=72, bound=361; hypotheses PASS
case 07: N=26, max=48, 2max=96, bound=625; hypotheses PASS
case 08: N=32, max=60, 2max=120, bound=961; hypotheses PASS
case 09: N=32, max=90, 2max=180, bound=961; hypotheses PASS
case 10: N=33, max=60, 2max=120, bound=1024; hypotheses PASS
case 11: N=38, max=72, 2max=144, bound=1369; hypotheses PASS
case 12: N=44, max=84, 2max=168, bound=1849; hypotheses PASS
PASS: all 12 exact inputs match the plan construction and frozen receipt; all family hypotheses hold.
```

The full stdout above has SHA-256
`1e45f5cfcf514ca9571c2b8c245155f6b7fec2f8f304f97cd597c4752ac34da9`,
checked with `sha256sum` on those exact bytes. The narrower
`SCRIPT_STDOUT_SHA256` printed in it hashes only the twelve case lines and
their final PASS line. The executed script itself excludes its code fences
and the newline before the closing fence when hashed.

All twelve inputs therefore meet the accepted theorem's hypotheses. No
expanded search, Lean build, cache restoration, Git operation, shared-state
edit, or unrelated file edit was performed. Remaining limitations are the
explicit residue/height restrictions, absent unrestricted supply argument,
and manuscript rather than kernel-checked status.
