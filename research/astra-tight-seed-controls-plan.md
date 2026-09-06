# Fixed tight-family inputs for the uniform deletion-seed screen

This is a settled mechanical verification task, requested Terra High. It tests
the still-unproved uniform seed-supply statement Q on twelve specified tuples.
It is not a program to prove LRC at successive runner counts.

The input list comes from the explicit examples and Table 1 of
[Yuhan Zhang, Single-speed modifications of the tight Lonely Runner instance,
2026, sections 1 and 1.2](https://arxiv.org/html/2608.13599v1).
The source lists single replacements of the baseline and a two-replacement
example. Here their reported tightness is motivation only: the checker must
verify the actual arithmetic without assuming any theorem from that paper.
Root retrieved the primary HTML on 2026-09-06. No claim about the completeness
or correctness of the external classification is needed by this task.

Use the twelve distinct inputs:

* `(1,3,4,7)`;
* `(1,3,4,5,9)`;
* `(1,4,5,6,7,11,13)`;
* for each `(N,r,w)` in
  `(8,6,12), (14,12,24), (20,18,36), (26,24,48), (32,30,60),
  (32,30,90), (33,30,60), (38,36,72), (44,42,84)`,
  use the sorted tuple `({1,...,N-1} minus {r}) union {w}`.

Read the exact checker definition and finite completeness proof in
`research/astra-uniform-all-deletion-seed-screen.md`, frozen SHA-256
`b2b6acd00dae3c8ed777bc3da4227fab0254016eec035c2c100f8d346a398f1b`.
Its full Python block SHA-256 is
`ea6253ce7de5eed7e7c3f477858e09dcc2293f1fb0d93cf7656fd440c5e4d065`
when extracted by splitting at the literal code fences as specified there.
Execute only its definition prefix before the first newline followed by
`v=(1,4,5,6,7,11)`, in a fresh namespace. Do not replay its discovery ranges.
The function `audit(v,p,True)` returns every seed interval, the exact score/time
maximum, seeded weak intervals, the whole-component pivot maximum, and the
protected-ball union; `None` means the deletion seed set is empty.

For each input, validate its total count, distinctness, positivity and gcd.
Run every deletion label, retaining its seed count, score maximum and attaining
time, and whole-component pivot maximum. Report whether every deletion seed
set is nonempty and whether at least one exact score reaches `1/N`. Do not
stop after the first positive pivot; a negative certificate needs all labels.
Check the explicit full witness `t=1/N` directly for every tuple, retaining
its exact minimum norm. A full witness does not itself establish Q.

If Q succeeds, additionally construct one witness inside its protected ball:
if its selected seed already protects the pivot, retain it; otherwise move
by `(1/N-||s*v_p||)/v_p` away from the nearest integer, with sign determined
by the actual pivot phase. Verify the displacement is within rho and verify
every original coordinate at the resulting common rational time.
If Q fails with all seed sets nonempty, preserve the full per-label intervals
and maxima for independent Astra review and stop extending the task.

Use exact Python integers/Fractions only. No broad search, external data,
new Lean code, dependency restoration, Git operations or shared-state edits.
Keep one compact owned JSON receipt at
`research/astra-tight-seed-controls.json`: exact input/source hashes, actual
script bytes, command and limits, complete stdout/stderr, exit status, failed
attempts if any, and per-label results. Bound execution to 180 seconds,
2 GiB address space and 179 seconds CPU. Initial check plus at most two
mechanical repair rounds; escalate semantic uncertainty immediately. Unknown
total task time and per-model usage remain null; command duration is separate.
You are not alone in the checkout; preserve all other files.
