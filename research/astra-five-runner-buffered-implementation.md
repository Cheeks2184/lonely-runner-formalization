# Buffered five-runner mixed implementation

`LonelyRunner/FiveRunnerBuffered.lean` composes the frozen buffered insertion
with the four-runner mixed classification and the exceptional-family wrapper.
It exports `fiveRunnerMixed_of_buffer_inequalities` for the two accepted
integer endpoint-width inequalities, and
`fiveRunnerMixed_of_three_mul_height_ge` for the coarse condition
`22*b <= 3*H`.  The proof treats all nine ordered `Fin 3` endpoint pairs,
using the two assumed pair bounds and the monotonicity from `a < b` for the
remaining pair.

Final source hash:
`70f690a2300e122da3e9646e48d2f4e9c6af630c16da89d403e8508cb16b6d04`.

Actual checks: `lake env lean LonelyRunner/FiveRunnerBuffered.lean` (session
62826) exited 0; `lake build LonelyRunner.FiveRunnerBuffered` (session 83151)
exited 0 with 3520 jobs.  The final stdin probe (session 13530) exited 0,
printed exact types and permitted axioms for both public buffered theorems,
and compiled the parameter fixture `(4,5,11,24)` and coarse equality fixture
`(1,3,4,22)`.  The same probe also checked the two exceptional scaled controls.
No root imports, audit file, workflow state, Git metadata, or cache files were
changed.
