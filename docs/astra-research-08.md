# Pass 8: a compact mathematical obstruction to the coarse union

The manuscript `research/astra-union-obstruction.md` explains why the tuple
`(2,3,4,7,14,9)` has no A/B/R normalization for any modulus. Its proof does not
assume the decision engine's negative answer. A short rational interval table
and elementary inequalities exclude every sign choice and arithmetic class.

For R, every normalized zero base is at most `5/7` and every ordinary base
at most `5/42`. The eight arithmetic classes and the three core speeds
`2,3,4` give a small table. Adding the remaining rows leaves contradictions
of the forms `9x<7x`, `14x<12x`, or `x<=1/42` with `x>=37/588`. The argument
keeps the permitted closed endpoints, handles moduli divisible by 7, and
separately excludes velocity boundaries and the pivot branch. Coarse C is
already contained in R.

Root read the proof and reran both the author's 192-case rational table check
and the reviewer's independent 12,288-case linear replay. The latter has four
surviving assignments before the final quadratic inequality, paired by
reflection. The independent review, exact source hashes, and verification
commands are retained in `research/astra-pass8-review.md` and
`research/astra-pass8-verification.json`.

This is an independently reviewed manuscript proof, not a Lean declaration.
The same tuple has a strict witness at `1/5`, also expressible by the existing
general residue-band transport. Thus the proof rejects universal supply by
these coarse conditions and the proposed implication from a strict witness
to an R normalization. It does not reject all affine methods or LRC.

No executable source, Lean declaration, or dependency pin changed. The shared
Lean cache was not restored. The next research task examines whether more
precise residue bands admit a useful existence theorem without assuming the
desired witness. That unfinished task is excluded from this checkpoint.
