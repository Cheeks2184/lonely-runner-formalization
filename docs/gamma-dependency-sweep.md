# Gamma dependency sweep: finite evidence and reproducibility

Status: independently audited finite computational evidence, not a proof, a
uniform certificate, or an LRC result.

Source SHA-256:

```text
c995eb63b3de080705b23c01056090d00ab3d5296394bd4c312a9f9f318f6d96  audit_gamma_dependency_sweep.cpp
```

Audited compiler:

```text
g++ (Ubuntu 15.2.0-16ubuntu1) 15.2.0
```

Compile from the repository root under Ubuntu 26.04 WSL:

```bash
g++ -std=c++20 -O3 -Wall -Wextra -Wpedantic \
  scripts/audit_gamma_dependency_sweep.cpp \
  -o /tmp/gamma_dependency_sweep
sha256sum scripts/audit_gamma_dependency_sweep.cpp
```

Run the medium grid:

```bash
/tmp/gamma_dependency_sweep medium-grid
```

Expected deterministic stdout:

```text
mode=medium-grid
parameter_cases=4338
nonempty_graphs=4338
empty_graphs=0
candidate_rows=3557016
greedy_fallbacks=0
matching_failures=0
expected_counts_match=1
status=PASS
```

SHA-256 of that stdout, including its final LF:

```text
0f03079dd203eb6f6f8d77532036eb3a62bfe6fe41eafa523213684ba89a09e0
```

Run the exact `N = 20000`, `t = 10000` analysis:

```bash
/tmp/gamma_dependency_sweep n20000-analysis
```

Expected deterministic stdout:

```text
mode=n20000-analysis
candidate_rows=5001
edges=22800241
greedy_matching=1
strict_hall=1
contiguous_intervals=12507501
minimum_contiguous_slack=1145
minimum_first_index=4910
minimum_last_index=4910
minimum_union_size=1146
minimum_first_candidate=14910
minimum_last_candidate=14910
expected_counts_match=1
status=PASS
```

SHA-256 of that stdout, including its final LF:

```text
e938e1b92b15e413f67001578dced5f765663e5a58033324c4ac6b3eb2d0c2c8
```

Longer optional presets:

```bash
/tmp/gamma_dependency_sweep endpoint-grid
/tmp/gamma_dependency_sweep high-grid
```

Every named mode returns zero only when it finds no matching failure and its
embedded expected counts agree. It returns one on a mathematical/count
regression and two on invalid invocation or an internal validation error.
Wall-clock timing is deliberately excluded from stdout.

The complete local replay is:

```bash
GAMMA_DEPENDENCY_FULL=1 bash scripts/audit_gamma_dependency_sweep.sh
```

The default audit and public CI run only `medium-grid`. The full replay adds
the 19,000 endpoint graphs, the sparse grid through `N<100000`, and the
quadratic `N=20000,t=10000` interval analysis. Keeping that last scan explicit
avoids silently turning a lightweight public check into an expensive one.

## Mathematical interpretation

For a fixed matching `M` saturating the left vertices, direct `x` to `y` when
`x` sees the right vertex matched to `y`, and mark `x` when it sees an
unmatched right vertex. A nonempty left set has zero Hall slack exactly when
it is successor-closed and contains no marked vertex. Thus every nonempty set
has strict Hall precisely when every left vertex reaches a marked one. The
program implements reverse reachability from the marked vertices for the
dedicated `N=20000, t=10000` analysis.

This graph equivalence is exact, but it is not the missing arithmetic theorem.
The three grid sweeps construct and independently validate a saturating
matching for each finite Gamma graph. The separate `N=20000, t=10000` mode
also checks the dependency condition. To turn this particular dependency
route into a uniform proof would still require a canonical arithmetic
matching, or a bounded explicit family of matchings, whose reachability can be
established for every admissible `N,t`.
