# Independent review of one-deletion mixed-margin supply

2026-09-05. Requested route: Astra/xhigh, task
`/root/one_deletion_review`; runtime model and effort are not independently
exposed. Assigned source checkpoint: `5e7d690e6606ad096bf4a2319be0328f9c6d2e68`.
The project configuration, current workflow, policy, relevant state, and
validator were read. Structural workflow validation passed. Research is
authorized; unrestricted canonical LRC remains unresolved.

**Mathematical disposition: accept the frozen manuscript's full quantified
one-deletion family statement, including both signs and its closed epsilon
interval, as an independently reviewed manuscript proof.** This review uses
the actual author bytes at SHA-256
`a619c863d2d4c10c90f21572caee371bf1b55d6ebfdaf81d9e4f24aeec4fd818` in
`research/astra-direct-mixed-supply.md`. It does not rely on an informal prior
worker verdict. No correction to the author's statement or proof is needed.
This is neither a kernel proof nor new ordinary LRC coverage. Finite controls
below are separate reproducibility evidence, not a proof of the quantifiers.

## Contract and direct-reciprocal obstruction

Let integers `N,a` satisfy `N>=4`, `a>=2`, and `2a<=N`. Define
`W={1,...,N}\{a}` and let `rho(x)` denote distance from a real number x to
the nearest integer. The chosen runner is stationary, and the moving speeds
are exactly W. The theorem supplies one time T satisfying, simultaneously,

```text
rho(k*T) >= 1/N       for every k in W,
rho(N*T) >= 1/(N-1),
0 < T < 1.
```

There are N total runners, including the stationary one, and N-1 positive
distinct moving speeds. Since `a>=2`, speed 1 survives, so W has gcd 1.
Since `a<=N/2<N`, speed N survives and is the fastest speed. Every d with
`2<=d<=N` has the explicit retained multiple `w=d` if `d!=a`, and `w=2a`
if `d=a`. In the exceptional case, `2a<=N` and `2a!=a` ensure membership.
At `T=1/d`, that coordinate has zero norm. Thus the specified direct
reciprocal branch is unavailable for every denominator in that range.
This says nothing against other times or denominators.

## Independent proof of the perturbation interval

The circle distance is invariant under integer translation and under sign
reversal. Its distance-to-a-set definition implies
`rho(x+z)>=rho(x)-abs(z)`. Also, `rho(z)=abs(z)` for `abs(z)<=1/2`.
For an integer k not divisible by a, the residue of k modulo a is some
`r in {1,...,a-1}`, so
`rho(k/a)=min(r,a-r)/a>=1/a`. This does not assume that a perturbed phase
stays in one linear piece of the norm.

Suppose first that `N>=2a+1`. Put

```text
L = 1/(2aN),
U = (N-1-a)/(aN(N-1)),
L <= epsilon <= U,
T_sigma = 1/a + sigma*epsilon,   sigma in {-1,+1}.
```

All denominators are positive. Direct subtraction gives

```text
U-L = (N-1-2a)/(2aN(N-1)).
```

Thus the interval is closed and nonempty, is a singleton exactly when
`N=2a+1`, and has positive width exactly when `N>=2a+2`. Moreover,

```text
0 < epsilon,
N*epsilon <= N*U = 1/a - 1/(N-1) < 1/a <= 1/2.
```

For a retained multiple `k=j*a`, positivity gives `j>=1` and deletion of a
excludes `j=1`. Therefore `2a<=k<=N`. Since `0<k*epsilon<1/2`, translation
by the integer j and sign invariance give the exact identity

```text
rho(k*T_sigma) = rho(sigma*k*epsilon)
               = k*epsilon >= 2a*L = 1/N.
```

There is no unnoticed folding at one half in this identity. The strict
upper phase bound holds even at epsilon U and for either sign.

For each nonmultiple, the global Lipschitz estimate gives

```text
rho(k*T_sigma) >= rho(k/a)-k*epsilon
               >= 1/a-N*epsilon
               >= 1/(N-1) > 1/N.
```

If `a` does not divide N, this already supplies the fastest-coordinate
requirement. If `a` divides N, the exact multiple identity instead gives

```text
rho(N*T_sigma) = N*epsilon >= N*L = 1/(2a)
               >= 1/(N-1).
```

The last inequality uses precisely `N-1>=2a`. No lower-count conjecture,
collision witness, time selector, or packet hypothesis is used. Both signs
and every real epsilon in the entire interval have now been covered.

## Boundary branch, equality, and time domain

When `N=2a`, use `epsilon=1/(N(N-1))`. The only retained multiple of a is
N itself. Its phase is

```text
N*T_sigma = 2 + sigma/(N-1),
rho(N*T_sigma) = 1/(N-1),
```

because `1/(N-1)<=1/3<1/2`. Every other retained speed is a nonmultiple
with `k<=N-1`, so

```text
rho(k*T_sigma) >= 1/a-k*epsilon
               >= 1/a-(N-1)*epsilon
               = 2/N-1/N = 1/N.
```

These are the closed bounds requested. In particular, for the plus sign,

```text
(N-1)*T_plus = 2-1/N,
rho((N-1)*T_plus) = 1/N.
```

Hence strict ordinary inequalities would incorrectly discard a stated
witness. The fastest bound is an equality for both signs throughout this
boundary branch. In the nonboundary branch, at epsilon L the retained
coordinate `k=2a` always has exact norm `1/N`. Endpoint equality can also
occur at U: when `N mod a=1`, the minus sign gives fastest norm
`1/(N-1)`; when `N mod a=a-1`, the plus sign gives that same equality.
The independent controls below include both patterns and the half-circle
phase at `(N,a,sign)=(7,3,+1)`.

The unadjusted nonboundary formula at `N=2a` would give
`N*epsilon=1/N<1/(N-1)` for both signs, so it fails the mixed endpoint
requirement. It is only this altered formula that fails. The boundary
formula above supplies a valid witness.

For time positivity, the nonboundary estimate gives
`epsilon<1/(aN)`. In the boundary branch the same strict bound is
equivalent to `a<N-1=2a-1`, which follows from `a>=2`. Consequently, for
either sign in either branch,

```text
0 < (1-1/N)/a < T_sigma < (1+1/N)/a <= 5/8 < 1.
```

All advertised rational formulas therefore give positive rational times
inside one period. For arbitrary real epsilon the interval statement is a
real-time statement, with no rationality asserted unless epsilon is
rational. The interval is a sufficient domain; neither the proof nor this
review claims it is the set of all mixed-witness times.

## Existing source coverage and limits

The actual declaration `LonelyRunner.boundedHeight_stationary_witness` at
`LonelyRunner/BoundedHeight.lean:326` accepts `n>=3`, positive injective
natural speeds bounded by `n+2`, and concludes a common closed ordinary
margin `1/(n+1)`. Enumerating W with `n=N-1` satisfies these hypotheses:
`n>=3` and `max(W)=N<=N+1=n+2`. Thus ordinary stationary witnesses for the
whole present family were already covered by that theorem. Its displayed
conclusion does not contain the additional fastest margin `1/(N-1)`.
This review reads the source interface; it performs no fresh Lean build.

`FastRunnerInsertion.lean` contains the small-absolute-phase identity,
integer translation, and the global Lipschitz inequality used here.
`StructuredClasses.lean` contains sign invariance and closed residue-band
interfaces. Their source is consistent with the norm conventions in this
proof. The source hashes are guarded in the replay program below. No claim
is made to have searched all equivalent repository results or the research
literature, and no novelty claim is made.

The accepted conclusion is a stronger endpoint margin on this particular
infinite family. It does not supply witnesses for arbitrary primitive
tuples, all chosen runners, or unrestricted N; it proves no standalone
exact-packet converse or universal direct-or-exact union. Any use with an
independently reviewed mixed-witness/packet equivalence must retain that
equivalence's exact hypotheses. The canonical formalization objective
remains active and unresolved.

## Reproducible finite controls

The corrected routine artifact is
`research/astra-direct-mixed-controls.md`, frozen at SHA-256
`66bb36404e33f25f4b1372a3af8056d3cee742bc4bfd4caff0ace778680b612a`. Its sole Python block has SHA-256
`854955e638a5ce5b137a4e6735f053e5dd0f2ae5ba96866221f787cb2db9fb91`; its exact stdout has SHA-256
`de0823ce759577795cd653dac0040548e12faf48578b1991fd88f92a144d8cd8`. The earlier incomplete artifact beginning
`653cef59` is not accepted or used as the final control source. Its reported
28/218 margin counts alone did not establish that every required assertion
had been executed. The corrected program was read against every item of
the author's frozen specification before replay.

The single Python block below first guards the author, the corrected
control artifact, and the three inspected Lean sources. It extracts the
corrected routine program without changing a byte, checks its program
hash, replays it in memory, and verifies the entire stdout hash and the
observed counts `28 times / 218 coordinate comparisons / 53 explicit
divisor witnesses / 8 negative times`.

The same program then runs small independent controls with a separately
implemented rational circle norm. Their complete positive domain is the
following six named `(N,a,epsilon)` selections, each with both signs:

```text
boundary-four:          (4,2,1/[4*3])
singleton-seven:        (7,3,L=U)
fastest-multiple-low:   (9,3,L)
fastest-multiple-high:  (9,3,U)
upper-minus-tight:      (10,3,U)
upper-plus-tight:       (14,5,U)
```

The five distinct parameter pairs have 39 explicit divisor witnesses. The
six selections give 12 times and 94 retained coordinate/time comparisons.
Four negative controls use both signs of the unadjusted epsilon at `(4,2)`
and both signs of half the lower epsilon at `(7,3)`. They assert exact
failure values, respectively `rho(N*T)=1/N<1/(N-1)` and
`rho(2a*T)=1/(2N)<1/N`. All arithmetic is exact standard-library Fraction
arithmetic. There is no sampling, optimization, tuple discovery, Lean
execution, or cache/dependency operation.

This is the **sole Python replay program** in this review. Extract exactly
the bytes between its opening `python` fence plus newline and the closing
fence, retaining the code's final newline. From the repository root, execute
those bytes with `python3 -B` and collect UTF-8 stdout including its final
newline. The block performs no writes. Program and stdout hashes are
recorded after the block.

```python
from contextlib import redirect_stdout
from fractions import Fraction as F
from hashlib import sha256
from io import StringIO
from math import gcd
from pathlib import Path
import json
import re

GUARDS = {
    "research/astra-direct-mixed-supply.md": "a619c863d2d4c10c90f21572caee371bf1b55d6ebfdaf81d9e4f24aeec4fd818",
    "research/astra-direct-mixed-controls.md": "66bb36404e33f25f4b1372a3af8056d3cee742bc4bfd4caff0ace778680b612a",
    "LonelyRunner/BoundedHeight.lean": "681c38dae0158ffd4162fa471c429dea4e8b90e27ee6e3a6fdf7b3cbd6e47ecc",
    "LonelyRunner/FastRunnerInsertion.lean": "dda82d1f8830d961499292656c3dfac884a471ad5ef38bd925b1a25c403603a5",
    "LonelyRunner/StructuredClasses.lean": "5328a7a88d2b42f86ffc3f0f0418ca22c761219e8fa3e5822bda5a18ac286e8c",
}
ROUTINE_PROGRAM_SHA = "854955e638a5ce5b137a4e6735f053e5dd0f2ae5ba96866221f787cb2db9fb91"
ROUTINE_OUTPUT_SHA = "de0823ce759577795cd653dac0040548e12faf48578b1991fd88f92a144d8cd8"
for path, expected in GUARDS.items():
    assert sha256(Path(path).read_bytes()).hexdigest() == expected, path
routine_doc = Path("research/astra-direct-mixed-controls.md").read_bytes()
routine_blocks = re.findall(rb"```python\n(.*?)```", routine_doc, re.S)
assert len(routine_blocks) == 1
routine_code = routine_blocks[0]
assert sha256(routine_code).hexdigest() == ROUTINE_PROGRAM_SHA
captured = StringIO()
with redirect_stdout(captured):
    exec(compile(routine_code, "frozen-routine-controls", "exec"), {"__name__": "__main__"})
routine_stdout = captured.getvalue().encode("utf-8")
assert sha256(routine_stdout).hexdigest() == ROUTINE_OUTPUT_SHA
routine_counts = json.loads(routine_stdout)["observed_counts"]
assert routine_counts == {
    "times": 28, "coordinate_inequalities": 218,
    "divisor_facts": 53, "negative_times": 8,
}

# This definition uses the adjacent integers, independently of the routine's modulo norm.
def rho(x):
    q = x.numerator // x.denominator
    return min(abs(x - q), abs(x - (q + 1)))

def interval(N, a):
    return F(1, 2 * a * N), F(N - 1 - a, a * N * (N - 1))

SPECS = (
    ("boundary-four", 4, 2, "boundary"),
    ("singleton-seven", 7, 3, "lower"),
    ("fastest-multiple-low", 9, 3, "lower"),
    ("fastest-multiple-high", 9, 3, "upper"),
    ("upper-minus-tight", 10, 3, "upper"),
    ("upper-plus-tight", 14, 5, "upper"),
)
domains = []
seen = set()
positives = []
coordinates = 0
divisor_facts = 0
for name, N, a, selection in SPECS:
    assert N >= 4 and a >= 2 and 2 * a <= N
    W = tuple(k for k in range(1, N + 1) if k != a)
    assert len(W) == N - 1 and len(set(W)) == N - 1
    assert min(W) == 1 and max(W) == N and gcd(*W) == 1
    L, U = interval(N, a)
    width = F(N - 1 - 2 * a, 2 * a * N * (N - 1))
    assert U - L == width
    if N == 2 * a:
        assert selection == "boundary" and width < 0
        epsilon = F(1, N * (N - 1))
    else:
        assert L <= U and ((L == U) == (N == 2 * a + 1))
        epsilon = L if selection == "lower" else U
        assert L <= epsilon <= U
        assert N * epsilon <= F(1, a) - F(1, N - 1)
    assert 0 < epsilon < F(1, a * N)
    if (N, a) not in seen:
        witnesses = []
        for d in range(2, N + 1):
            w = d if d != a else 2 * a
            assert w in W and w % d == 0 and rho(F(w, d)) == 0
            witnesses.append([d, w])
        divisor_facts += len(witnesses)
        domains.append({"N": N, "a": a, "W": list(W), "width": str(width),
                        "direct_reciprocal_zero_witnesses": witnesses})
        seen.add((N, a))
    for sign in (-1, 1):
        T = F(1, a) + sign * epsilon
        assert 0 < F(N - 1, a * N) < T < F(N + 1, a * N) <= F(5, 8) < 1
        values = {}
        for k in W:
            value = rho(k * T)
            values[k] = value
            assert value >= F(1, N)
            if k % a == 0:
                assert k >= 2 * a and 0 < k * epsilon < F(1, 2)
                assert value == k * epsilon
            else:
                base = rho(F(k, a))
                assert base >= F(1, a)
                assert value >= base - k * epsilon
                if N != 2 * a:
                    assert value >= F(1, N - 1)
                else:
                    assert k <= N - 1 and F(1, a) - k * epsilon >= F(1, N)
        assert values[N] >= F(1, N - 1)
        if N == 2 * a:
            assert values[N] == F(1, N - 1)
            if sign == 1:
                assert values[N - 1] == F(1, N)
        elif epsilon == L:
            assert values[2 * a] == F(1, N)
        if name == "singleton-seven" and sign == 1:
            assert values[N] == F(1, 2)
        if name == "upper-minus-tight" and sign == -1:
            assert values[N] == F(1, N - 1)
        if name == "upper-plus-tight" and sign == 1:
            assert values[N] == F(1, N - 1)
        coordinates += len(W)
        positives.append({
            "name": name, "N": N, "a": a, "selection": selection,
            "sign": sign, "epsilon": str(epsilon), "time": str(T),
            "norms": [[k, str(values[k])] for k in W],
            "ordinary_equalities": [k for k in W if values[k] == F(1, N)],
            "endpoint_equality": values[N] == F(1, N - 1),
        })
negatives = []
for name, N, a in (("unadjusted-boundary", 4, 2), ("below-lower", 7, 3)):
    epsilon = F(1, (2 if name == "unadjusted-boundary" else 4) * a * N)
    for sign in (-1, 1):
        T = F(1, a) + sign * epsilon
        assert 0 < T < 1
        if name == "unadjusted-boundary":
            k = N
            assert all(rho(j * T) >= F(1, N) for j in range(1, N + 1) if j != a)
            assert rho(k * T) == F(1, N) < F(1, N - 1)
            target = F(1, N - 1)
        else:
            k = 2 * a
            assert epsilon < interval(N, a)[0]
            assert rho(k * T) == F(1, 2 * N) < F(1, N)
            target = F(1, N)
        negatives.append({"name": name, "N": N, "a": a, "sign": sign,
                          "epsilon": str(epsilon), "time": str(T), "speed": k,
                          "norm": str(rho(k * T)), "failed_target": str(target)})
counts = {"positive_times": len(positives), "coordinate_comparisons": coordinates,
          "divisor_facts": divisor_facts, "negative_times": len(negatives),
          "distinct_parameter_pairs": len(seen)}
assert counts == {"positive_times": 12, "coordinate_comparisons": 94,
                  "divisor_facts": 39, "negative_times": 4, "distinct_parameter_pairs": 5}
print(json.dumps({
    "source_guards": GUARDS,
    "routine_replay": {"program_sha256": ROUTINE_PROGRAM_SHA,
                       "stdout_sha256": ROUTINE_OUTPUT_SHA, "observed_counts": routine_counts},
    "independent_counts": counts, "independent_domains": domains,
    "independent_positive_controls": positives, "independent_negative_controls": negatives,
}, indent=2, sort_keys=True))
```

| Review reproducibility item | SHA-256 |
| --- | --- |
| Sole Python program, including final newline | `44ffe22c5dd33ae8017d2b21bc45eb3bd9db2015d6bdfca2fc5e3046befc694b` |
| Exact UTF-8 JSON stdout, including final newline | `dceec2be34d313fd4a57ac6a7a050c7c18863c160d47ebbc8eb1aa60fb96bce6` |

The document hash is reported separately to the orchestrator, avoiding a
self-referential file hash. Exact replay status: observed passed with the
recorded program and stdout hashes. The mathematical proof review above is
complete; the finite execution is reproducibility evidence only.

Provenance: Astra authored and reviewed the mathematical proof. After that
reviewer's handle was unavailable, recovered Terra only pinned the supplied
frozen hashes and replayed the existing controls; it supplied no semantic
review and performed no Lean build.

## Ownership and freeze

Only `research/astra-direct-mixed-supply-review.md` is owned or modified by
this task. Source, author manuscript, controls, workflow state, Git, Lean
caches and dependencies remain owned by their respective tasks. The
corrected control author was contacted to obtain the final frozen hashes.
One attempted read during that artifact's replacement returned a missing
file error; the subsequent source read succeeded. No result is inferred
from the failed read.

Commands used were policy/configuration/state/validator reads, workflow
structural validation, focused source inspection, SHA-256 calculation,
writing/readback of this review, and the exact in-memory replay described
above. No broad search, Lean build, source edit, state edit, Git operation,
or cache operation was performed. All owned commands will be stopped at
the final hash handoff. Any later change to a guarded source requires a
fresh review decision and corresponding replay; it must not silently reuse
this frozen evidence.
