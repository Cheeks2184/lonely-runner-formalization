# Endpoint completeness implementation

`exists_endpoint_time_of_witness` reduces any closed witness for positive
natural speeds to an owned floor-band endpoint in `(0,1/2]`, including repeated
speeds and the one-speed half-margin case.  Final checks on the saved source
and named module build completed in session `92472`, terminal exit `0`.
The exact-type/axiom and negative-time controls probe completed in session
`98427`, terminal exit `0`; axioms were only `propext`, `Classical.choice`,
and `Quot.sound`.  It compiled n=1 half and repeated-speed negative-time
controls.  Earlier endpoint drafts failed mechanically; root isolated the last
two repairs before this final successful source.
