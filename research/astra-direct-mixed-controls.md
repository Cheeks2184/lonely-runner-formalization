# Direct mixed one-deletion controls

2026-09-05. This corrected routine artifact is a deterministic, literal replay
of the frozen eight-fixture specification in
[astra-direct-mixed-supply.md](astra-direct-mixed-supply.md). It is finite
control evidence only: it does not search for tuples or witnesses, establish
the quantified manuscript statement, or resolve LRC.

The earlier artifact replayed the stated domain and reproduced its aggregate
counts, but did **not** execute every required frozen check. In particular, it
used a searched divisor representative, omitted the author-source SHA guard,
did not assert the complete tuple invariants and time range, and did not check
the exact multiple/nonmultiple phase facts, boundary equality, or the named
negative equalities. This replacement corrects those omissions while preserving
the analytical manuscript and its author unchanged.

Run from the repository root exactly as follows. The program first guards the
frozen author manuscript SHA, then emits deterministic JSON to standard output.

```text
python3 -B /tmp/astra-direct-mixed-controls.py > /tmp/astra-direct-mixed-controls.json
```

The author manuscript SHA asserted by the program is
`a619c863d2d4c10c90f21572caee371bf1b55d6ebfdaf81d9e4f24aeec4fd818`.

```python
from fractions import Fraction as F
from hashlib import sha256
from math import gcd
from pathlib import Path
import json

AUTHOR_PATH = Path("research/astra-direct-mixed-supply.md")
AUTHOR_SHA = "a619c863d2d4c10c90f21572caee371bf1b55d6ebfdaf81d9e4f24aeec4fd818"
FIXTURES = ((4, 2), (5, 2), (6, 3), (7, 3), (8, 3), (8, 4), (11, 3), (12, 5))

assert sha256(AUTHOR_PATH.read_bytes()).hexdigest() == AUTHOR_SHA

def text(x):
    return str(x)

def norm(x):
    x %= 1
    return min(x, 1 - x)

def stated_epsilons(N, a):
    if N == 2 * a:
        e = F(1, N * (N - 1))
        return (e,), {"branch": "boundary", "epsilon": text(e)}
    lo = F(1, 2 * a * N)
    hi = F(N - 1 - a, a * N * (N - 1))
    mid = (lo + hi) / 2
    assert lo <= hi
    values = tuple(dict.fromkeys((lo, hi, mid)))
    assert all(lo <= value <= hi for value in values)
    return values, {"branch": "generic", "lower": text(lo), "upper": text(hi), "midpoint": text(mid)}

def literal_divisors(N, a, W):
    facts = []
    for d in range(2, N + 1):
        w = d if d != a else 2 * a
        assert w in W
        assert w % d == 0
        facts.append({"d": d, "w": w})
    return facts

def tuple_checks(N, a, W):
    assert len(W) == N - 1
    assert all(k > 0 for k in W)
    assert len(set(W)) == len(W)
    assert max(W) == N
    assert gcd(*W) == 1
    return {"count": len(W), "positive": True, "distinct": True, "maximum": max(W), "gcd": gcd(*W)}

def positive_control(N, a, e, sign, W, divisors):
    T = F(1, a) + sign * e
    assert 0 < T < 1
    ordinary = []
    for k in W:
        value = norm(k * T)
        assert value >= F(1, N)
        ordinary.append({"k": k, "norm": text(value)})
    Hnorm = norm(N * T)
    assert Hnorm >= F(1, N - 1)

    multiples = []
    nonmultiples = []
    for k in W:
        value = norm(k * T)
        if k % a == 0:
            assert 0 <= k * e < F(1, 2)
            assert value == k * e
            multiples.append({"k": k, "norm": text(value), "k_epsilon": text(k * e)})
        else:
            if N != 2 * a:
                assert value >= F(1, N - 1)
            nonmultiples.append({"k": k, "norm": text(value)})
    if N == 2 * a:
        assert Hnorm == F(1, N - 1)
    return {
        "N": N, "a": a, "epsilon": text(e), "sign": sign, "time": text(T),
        "ordinary_norms": ordinary, "H_norm": text(Hnorm),
        "multiple_phase_checks": multiples, "nonmultiple_checks": nonmultiples,
        "divisibility": divisors,
    }

def negative_generic_endpoint(N, a):
    e = F(1, 2 * a * N)
    W = tuple(k for k in range(1, N + 1) if k != a)
    tuple_checks(N, a, W)
    signs = []
    for sign in (-1, 1):
        T = F(1, a) + sign * e
        assert 0 < T < 1
        ordinary = [norm(k * T) for k in W]
        Hnorm = norm(N * T)
        assert all(value >= F(1, N) for value in ordinary)
        assert Hnorm == F(1, N)
        assert Hnorm < F(1, N - 1)
        signs.append({"sign": sign, "time": text(T), "H_norm": text(Hnorm)})
    return {"kind": "generic_endpoint", "N": N, "a": a, "epsilon": text(e), "signs": signs}

def negative_half_epsilon(N, a):
    e = F(1, 4 * a * N)
    W = tuple(k for k in range(1, N + 1) if k != a)
    tuple_checks(N, a, W)
    k = 2 * a
    assert k in W
    signs = []
    for sign in (-1, 1):
        T = F(1, a) + sign * e
        assert 0 < T < 1
        value = norm(k * T)
        assert value == F(1, 2 * N)
        assert value < F(1, N)
        signs.append({"sign": sign, "time": text(T), "k": k, "norm": text(value)})
    return {"kind": "half_epsilon", "N": N, "a": a, "epsilon": text(e), "signs": signs}

records = []
coordinate_checks = 0
divisor_facts = 0
domains = []
for N, a in FIXTURES:
    W = tuple(k for k in range(1, N + 1) if k != a)
    invariants = tuple_checks(N, a, W)
    divisors = literal_divisors(N, a, W)
    epsilons, interval = stated_epsilons(N, a)
    domains.append({"N": N, "a": a, "W": list(W), "invariants": invariants,
                    "epsilon_specification": interval, "epsilon_values": [text(e) for e in epsilons]})
    for e in epsilons:
        for sign in (-1, 1):
            records.append(positive_control(N, a, e, sign, W, divisors))
            coordinate_checks += len(W)
    divisor_facts += len(divisors)

assert len(records) == 28
assert coordinate_checks == 218
assert divisor_facts == 53
negatives = [
    negative_generic_endpoint(4, 2), negative_generic_endpoint(6, 3),
    negative_half_epsilon(5, 2), negative_half_epsilon(7, 3),
]
assert sum(len(row["signs"]) for row in negatives) == 8
print(json.dumps({
    "author_source_sha256": AUTHOR_SHA, "fixtures": domains, "positive_controls": records,
    "observed_counts": {"times": len(records), "coordinate_inequalities": coordinate_checks,
                        "divisor_facts": divisor_facts, "negative_times": 8},
    "negative_controls": negatives,
}, sort_keys=True, indent=2))
```

Save the bytes strictly between the sole `python` fence and its closing fence
as `/tmp/astra-direct-mixed-controls.py`, retaining the final newline.
The program and output hashes below are frozen from the
command above after a source readback and full literal-specification review. No
data outside the eight listed fixtures is discovered or searched. All commands
are stopped at this checkpoint. The independent Astra family review remains
pending; these controls do not replace it.

| Reproducibility item | SHA-256 |
| --- | --- |
| Embedded Python program | `854955e638a5ce5b137a4e6735f053e5dd0f2ae5ba96866221f787cb2db9fb91` |
| Deterministic JSON stdout | `de0823ce759577795cd653dac0040548e12faf48578b1991fd88f92a144d8cd8` |
