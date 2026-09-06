# Exact controls for the two-hole mixed-margin manuscript

This is a fixed finite replay of the accepted manuscript at
`research/astra-two-hole-mixed-supply.md`, guarded below. It covers only the
sixteen prescribed positive rows and two specified range guards. All arithmetic
uses standard-library `Fraction`; there is no search, floating point, Lean, or
cache/dependency operation. The controls are reproducibility evidence, not a
proof of the manuscript's quantified statement. The structured domain already
has ordinary closed-margin coverage through `boundedHeight_stationary_witness`;
these controls establish no new ordinary coverage or LRC result.

Run the sole block exactly from the repository root with `python3 -B`, retaining
its final newline, and collect UTF-8 stdout including its final newline.

```python
from fractions import Fraction as F
from hashlib import sha256
from math import gcd
from pathlib import Path
import json

GUARDS = {
    "research/astra-two-hole-mixed-supply.md": "2bbc12481c164bf5e4eaf30ea7ca966cb0b2614524d9bea779034a2ebf115ccb",
    "research/astra-two-hole-mixed-review.md": "16d309ca8d9f51981cd44687bdee7e6667a42cb4a5ac47b2e42865981b509081",
}
for path, expected in GUARDS.items():
    assert sha256(Path(path).read_bytes()).hexdigest() == expected, path

ROWS = (
    ("C01", 4, 3, (), "direct", {"d": 4, "T": F(1, 4)}),
    ("C02", 4, 4, (1,), "first", {"T": F(1, 8)}),
    ("C03", 5, 5, (3,), "direct", {"d": 3, "T": F(1, 3)}),
    ("C04", 4, 4, (2,), "one_boundary", {"a": 2, "T": F(5, 12)}),
    ("C05", 5, 5, (2,), "one_nonboundary", {"a": 2, "T": F(9, 20)}),
    ("C06", 4, 5, (1, 3), "direct", {"d": 3, "T": F(1, 3)}),
    ("C07", 5, 6, (1, 2), "modular", {"u": 7, "q": 8, "r": 1, "T": F(1, 8)}),
    ("C08", 7, 8, (2, 3), "modular", {"u": 9, "q": 11, "r": 6, "T": F(6, 11)}),
    ("C09", 10, 11, (3, 4), "modular", {"u": 13, "q": 16, "r": 11, "T": F(11, 16)}),
    ("C10", 4, 5, (1, 2), "even_exception", {"T": F(1, 10)}),
    ("C11", 6, 7, (2, 3), "even", {"a": 3, "T": F(11, 24)}),
    ("C12", 8, 9, (3, 4), "even", {"a": 4, "T": F(5, 16)}),
    ("C13", 10, 11, (4, 5), "even", {"a": 5, "T": F(19, 80)}),
    ("C14", 5, 6, (2, 3), "odd", {"a": 2, "T": F(9, 20)}),
    ("C15", 7, 8, (3, 4), "odd", {"a": 3, "T": F(13, 42)}),
    ("C16", 9, 10, (4, 5), "odd", {"a": 4, "T": F(17, 72)}),
)

def rho(x):
    floor = x.numerator // x.denominator
    return min(abs(x - floor), abs(x - (floor + 1)))

def text(x):
    return str(x)

records = []
ordinary_comparisons = 0
mixed_comparisons = 0
direct_rows = 0
for ident, N, H, holes, branch, prescribed in ROWS:
    W = tuple(k for k in range(1, H + 1) if k not in holes)
    assert len(W) == N - 1 and len(set(W)) == N - 1
    assert all(k > 0 for k in W) and max(W) == H and H <= N + 1
    assert tuple(sorted(holes)) == holes and all(1 <= h <= H for h in holes)
    T = prescribed["T"]
    assert 0 < T < 1
    auxiliary = {"branch": branch}

    if branch == "direct":
        d = prescribed["d"]
        assert 2 <= d <= N and T == F(1, d)
        assert all(k % d != 0 for k in W)
        direct_rows += 1
        auxiliary.update({"d": d, "all_nonzero_mod_d": True})
    elif branch == "first":
        assert holes == (1,) and H == N and T == F(1, 2 * N)
        assert all(F(k, 1) * T <= F(1, 2) for k in W)
        assert all(rho(k * T) == k * T for k in W)
        auxiliary.update({"formula": "1/(2N)"})
    elif branch in {"one_boundary", "one_nonboundary"}:
        a = prescribed["a"]
        assert holes == (a,) and H == N and 2 * a <= N
        if branch == "one_boundary":
            assert N == 2 * a
            epsilon = F(1, N * (N - 1))
            nonmultiple_lower = F(1, a) - F(N - 1, 1) * epsilon
            assert nonmultiple_lower == F(1, N)
        else:
            assert N >= 2 * a + 1
            epsilon = F(1, 2 * a * N)
            nonmultiple_lower = F(1, a) - N * epsilon
            assert nonmultiple_lower >= F(1, N - 1)
        assert T == F(1, a) - epsilon
        multiples = []
        nonmultiples = []
        for k in W:
            if k % a == 0:
                shift = k * epsilon
                assert k >= 2 * a and 0 < shift < F(1, 2)
                assert rho(k * T) == shift
                multiples.append([k, text(shift)])
            else:
                assert rho(F(k, a)) >= F(1, a)
                assert rho(k * T) >= rho(F(k, a)) - k * epsilon
                assert rho(k * T) >= nonmultiple_lower
                nonmultiples.append(k)
        auxiliary.update({"a": a, "epsilon": text(epsilon), "multiples": multiples,
                          "nonmultiple_lower": text(nonmultiple_lower), "nonmultiples": nonmultiples})
    elif branch == "modular":
        c, d = holes
        L = N + 2
        e = (1 - L) % c
        u = L + e
        q = c + u
        r = prescribed["r"]
        assert N >= 2 * c + 3 and 2 * d <= N + 1
        assert prescribed["u"] == u and prescribed["q"] == q
        assert N + 2 <= u <= 2 * N - c - 2 and u % c == 1 % c
        assert gcd(c, q) == 1 and 1 <= r < q and (c * r) % q == 1
        assert T == F(r, q) and H < q <= 2 * (N - 1)
        residues = []
        for k in W:
            y = (r * k) % q
            assert 0 < k < q and k not in {c, q - c}
            assert 2 <= y <= q - 2
            assert rho(k * T) == F(min(y, q - y), q) >= F(2, q) >= F(1, N - 1)
            residues.append([k, y])
        auxiliary.update({"c": c, "d": d, "L": L, "e": e, "u": u, "q": q,
                          "r": r, "residues": residues, "strong_lower": text(F(2, q))})
    elif branch == "even_exception":
        assert (N, H, holes, T) == (4, 5, (1, 2), F(1, 10))
        expected = {3: F(3, 10), 4: F(2, 5), 5: F(1, 2)}
        assert {k: rho(k * T) for k in W} == expected
        auxiliary.update({"listed_norms": [[k, text(expected[k])] for k in W]})
    elif branch == "even":
        a = prescribed["a"]
        c = a - 1
        assert N == 2 * a and holes == (c, a) and H == N + 1 and a >= 3
        epsilon = F(1, 2 * c * N)
        assert T == F(1, c) - epsilon
        nonmultiple_lower = F(1, c) - H * epsilon
        assert nonmultiple_lower >= F(1, N - 1)
        multiples = []
        for k in W:
            if k % c == 0:
                shift = k * epsilon
                assert k >= 2 * c and 0 < shift < F(1, 2)
                assert rho(k * T) == shift
                multiples.append([k, text(shift)])
            else:
                assert rho(F(k, c)) >= F(1, c)
                assert rho(k * T) >= rho(F(k, c)) - k * epsilon >= nonmultiple_lower
        if ident == "C12":
            assert H % c == 0 and rho(H * T) == H * epsilon
        auxiliary.update({"a": a, "c": c, "epsilon": text(epsilon), "multiples": multiples,
                          "nonmultiple_lower": text(nonmultiple_lower),
                          "endpoint_multiple": ident == "C12"})
    elif branch == "odd":
        a = prescribed["a"]
        assert N == 2 * a + 1 and holes == (a, a + 1) and H == N + 1
        epsilon = F(1, 2 * a * N)
        assert T == F(1, a) - epsilon
        nonmultiple_lower = F(1, a) - H * epsilon
        assert nonmultiple_lower == F(1, N)
        multiples = []
        for k in W:
            if k % a == 0:
                shift = k * epsilon
                assert k >= 2 * a and 0 < shift < F(1, 2)
                assert rho(k * T) == shift
                multiples.append([k, text(shift)])
            else:
                assert rho(F(k, a)) >= F(1, a)
                assert rho(k * T) >= rho(F(k, a)) - k * epsilon >= nonmultiple_lower
        f = F(3 * a + 1, a * (2 * a + 1))
        assert H * T == 2 + f
        if a == 2:
            assert f > F(1, 2) and rho(H * T) == 1 - f == F(3, 10) >= F(1, N - 1)
        else:
            assert 0 < f < F(1, 2) and rho(H * T) == f >= F(1, N - 1)
        auxiliary.update({"a": a, "epsilon": text(epsilon), "multiples": multiples,
                          "nonmultiple_lower": text(nonmultiple_lower), "f": text(f),
                          "endpoint_norm": text(rho(H * T))})
    else:
        raise AssertionError(branch)

    norms = [[k, text(rho(k * T))] for k in W]
    assert all(rho(k * T) >= F(1, N) for k in W)
    mixed = branch != "direct"
    if mixed:
        assert rho(H * T) >= F(1, N - 1)
        mixed_comparisons += 1
    ordinary_comparisons += len(W)
    records.append({"id": ident, "N": N, "H": H, "holes": list(holes), "certificate": text(T),
                    "mixed": mixed, "norms": norms, "auxiliary": auxiliary})

# These guards reject range inferences, not the stated witness theorem.
g01_epsilon = F(1, 8)
g01_T = 1 - g01_epsilon
assert F(5, 1) * g01_epsilon > F(1, 2)
assert rho(5 * g01_T) == F(3, 8) != 5 * g01_epsilon
g02_T = F(9, 20)
g02_f = F(7, 10)
assert 6 * g02_T == 2 + g02_f and g02_f > F(1, 2)
assert rho(6 * g02_T) == F(3, 10) != g02_f
guards = [
    {"id": "G01", "epsilon": text(g01_epsilon), "time": text(g01_T), "speed": 5,
     "shift": text(5 * g01_epsilon), "norm": text(rho(5 * g01_T))},
    {"id": "G02", "f": text(g02_f), "time": text(g02_T), "speed": 6,
     "norm": text(rho(6 * g02_T))},
]
counts = {"positive_rows": len(records), "direct_rows": direct_rows,
          "mixed_rows": mixed_comparisons, "ordinary_comparisons": ordinary_comparisons,
          "range_guards": len(guards)}
assert counts == {"positive_rows": 16, "direct_rows": 3, "mixed_rows": 13,
                  "ordinary_comparisons": 81, "range_guards": 2}
print(json.dumps({"source_guards": GUARDS, "counts": counts, "certificates": records,
                  "range_guards": guards}, indent=2, sort_keys=True))
```

| Replay item | SHA-256 |
| --- | --- |
| Sole Python program, including final newline | `83180180b3428e8c3ace2b16a6b4145d18696ae930f6c5413ee85011a6e9eb5f` |
| Exact UTF-8 JSON stdout, including final newline | `63d0ce84f1527085bbfa97dd314dfbd6327fccd2dad451390ca923244c8aca8c` |

Exact replay status: observed passed. The document hash is reported separately to
avoid a self-referential artifact hash. Only this file was modified; no Lean
build, cache/dependency operation, Git operation, or workflow-state change was
performed.
