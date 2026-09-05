# N=7 normalized-count arithmetic implementation

Owned implementation: `LonelyRunner/ThreeOwnerSevenArithmetic.lean`.
It contains only the five settled normalized-count arithmetic lemmas requested
for the later three-owner route.

After root's dependency-ready confirmation, the exact command
`PATH="$HOME/.elan/bin:$PATH" lake env lean LonelyRunner/ThreeOwnerSevenArithmetic.lean`
passed. A separate stdin probe containing this source followed by `#print axioms`
for all five public declarations passed; each reports exactly `[propext,
Quot.sound]`. Source SHA-256:
`1f05a8f42c2d49b86e3d234cbd72b01e9b3b30d75549b133aad030f51a61455a`.
