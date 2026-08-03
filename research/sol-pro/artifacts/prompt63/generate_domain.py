#!/usr/bin/env python3
"""Generate the deterministic targeted PRO-C adversarial domain."""
from __future__ import annotations

import itertools
import json
import math
import random
from collections import OrderedDict
from functools import reduce
from pathlib import Path

VERSION = "PRO-C-AUDIT-1.0.0"
ROOT = Path(__file__).resolve().parent

records: "OrderedDict[tuple[int, ...], dict[str, object]]" = OrderedDict()


def add(family: str, values, desc: str = "") -> None:
    a = tuple(sorted(int(x) for x in values))
    if len(a) < 2 or len(set(a)) != len(a) or min(a) <= 0:
        return
    if reduce(math.gcd, a) != 1:
        return
    if a not in records:
        records[a] = {"families": [family], "descriptions": ([desc] if desc else [])}
    else:
        families = records[a]["families"]
        descriptions = records[a]["descriptions"]
        assert isinstance(families, list) and isinstance(descriptions, list)
        if family not in families:
            families.append(family)
        if desc and desc not in descriptions:
            descriptions.append(desc)


mandatory = [
    (1, 3, 4, 7),
    (1, 2, 3, 60),
    (1, 3, 4, 5, 18),
    (1, 2, 6, 8, 10),
    (15, 21, 40, 48, 56, 105, 126, 280, 1200),
]
for a in mandatory:
    add("mandatory", a)

for n in range(2, 31):
    add("consecutive", range(1, n + 1))

known_tight = [
    (1, 3, 4, 7),
    (1, 3, 4, 5, 9),
    (1, 5, 6, 11, 16, 17),
    (1, 2, 3, 4, 5, 7, 12),
    (1, 4, 5, 6, 7, 11, 13),
    tuple(list(range(1, 12)) + [13, 24]),
    tuple(list(range(1, 18)) + [19, 36]),
]
for a in known_tight:
    add("known_tight", a)

for n in range(4, 13):
    N = n + 1
    for multiplier in [1, 2, 3, 5, 8, 13, 21, 50, 200]:
        add("N_spike", list(range(1, n)) + [multiplier * N], f"n={n},L={multiplier}")

for n in range(4, 11):
    N = n + 1
    for step in [1, 2, 3, 5, 7, 11]:
        for offset in range(N):
            base = [step * (i + 1) + offset for i in range(n)]
            for multiplier in [1, 2, 5, 11]:
                q = (step + offset + multiplier) % n
                values = base.copy()
                values[q] = multiplier * N
                add(
                    "affine_residue",
                    values,
                    f"n={n},u={step},v={offset},m={multiplier}",
                )

for n in range(4, 13):
    N = n + 1
    for multiplier in [1, 2, 5, 10, 50, 200]:
        add("large_N_multiple", list(range(1, n)) + [multiplier * N])

for base in [(1, 3, 4, 7), (1, 3, 4, 5, 9)]:
    for deltas in itertools.product(range(-2, 3), repeat=len(base)):
        add("raw_mutation", [x + d for x, d in zip(base, deltas)], f"base={base}")
    n = len(base)
    N = n + 1
    for changed in range(n):
        for delta in range(-3, 4):
            mutated = list(base)
            mutated[changed] += delta
            for replaced in range(n):
                for multiplier in range(1, 21):
                    values = mutated.copy()
                    values[replaced] = multiplier * N
                    add(
                        "raw_mutation_N",
                        values,
                        f"base={base},q={changed},d={delta},repl={replaced},m={multiplier}",
                    )

for n in range(4, 10):
    N = n + 1
    for modulus in [5, 7, 11, 13, 17]:
        for multiplier in [1, 2, 3]:
            values = [
                modulus * (i + 1) + ((i * i + 3 * i + 1) % N)
                for i in range(n)
            ]
            values[(modulus + multiplier) % n] = multiplier * modulus * N
            add("CRT_structured", values, f"n={n},M={modulus},L={multiplier}")

rng = random.Random(630063)
bases = [
    (1, 3, 4, 7),
    (1, 3, 4, 5, 9),
    (1, 5, 6, 11, 16, 17),
    (1, 2, 3, 4, 5, 7, 12),
    (1, 4, 5, 6, 7, 11, 13),
]
for sample_id in range(2500):
    if rng.random() < 0.6:
        base = list(rng.choice(bases))
    else:
        n = rng.randint(4, 10)
        base = list(range(1, n + 1))
    n = len(base)
    N = n + 1
    scale = rng.randint(1, 7)
    values = [scale * x + rng.randint(-3, 3) for x in base]
    if rng.random() < 0.7:
        values[rng.randrange(n)] = N * rng.choice([1, 2, 3, 5, 8, 13, 21, 34])
    add("deterministic_mutation", values, f"z={sample_id}")

lines = []
metadata = []
for index, (a, meta) in enumerate(records.items()):
    families = ",".join(meta["families"])
    lines.append(f"{index}\t{families}\t{','.join(map(str, a))}\n")
    metadata.append(
        {
            "id": index,
            "a": list(a),
            "families": meta["families"],
            "descriptions": meta["descriptions"],
        }
    )

(ROOT / "domain.tsv").write_text("".join(lines), encoding="utf-8", newline="\n")
(ROOT / "domain_metadata.json").write_text(
    json.dumps(
        {
            "version": VERSION,
            "ordering": "first insertion by family order in generate_domain.py; tuple values sorted ascending; exact duplicates merged",
            "record_count": len(metadata),
            "records": metadata,
        },
        sort_keys=True,
        separators=(",", ":"),
    )
    + "\n",
    encoding="utf-8",
    newline="\n",
)
print(len(metadata))
