# Response96 independent mathematical audit

- Task: `P96-MATHEMATICAL-VERIFICATION-312`
- Mathematical audit base: `ead7361e79923e8b4e27c1757f2304c68dcebb81`
- Persistence base: `4fec7c4225789e933d52270e23e68f4733bff887`
- Overall disposition: `ACCEPT SEPARATION`
- Scope: the symbolic all-`E` family only

This is a mathematical review separate from recovery provenance. The recovery
package correctly preserved `SEPARATION` as response-authored and unverified.
This memo accepts the symbolic claims below as `proved-math-qualified`; it
does not retroactively turn recovery into mathematical evidence and does not
promote any theorem to `proved-lean`.

## Provenance boundary

| Item | Commit or SHA-256 |
| --- | --- |
| Prompt integration commit | `bf11c644c80cc1f4411a1d2bb311c26e7040a8eb` |
| Prompt96 launch record commit | `2cd5d41704709872765cee549e6d1c0a46761e76` |
| Prompt96 launch record SHA-256 | `833cafd9303a971bc6c9ea2be7f17797ab668cf6e9b17580177633e123147c3d` |
| Tracked prompt SHA-256 | `adbcb3215f385df5e21d2f5f3c6a79ec2f775f309c189cd7c731b65fc9d6f1d1` |
| Submitted payload SHA-256 | `cfe244b748c67d64e1d6c5e8a0710f1ed9ba97d44f7699a12d71ba625821fdab` |
| Ignored base64 capture SHA-256 | `06dc5440215cbbe5528628ca38501b551ba8a9c97023080adc1938e3756743af` |
| Raw decoded response SHA-256 | `d9bce8c6cca6fd75da50393c49e301284060519970379fe112d6b5329197b8ed` |
| Normalized response SHA-256 | `fe812c66937d5ad3b2db9504bd9df5601878af23753d524c9407258b19336d9f` |
| Original recovery commit | `d13d35fc4d7c69638a32505f680b7e774121edf3` |
| Authoritative integrated recovery commit | `d257b9502bb31c8220fa051c5ad60857cab3fc06` |
| Recovery audit SHA-256 | `8b699adcb0998b5cca353c83f9a8890a409634b66150d4a0362bf6a5188bc549` |

No attachment existed for Prompt96. No Prompt92 quarantine file, archive,
source, manifest, or result is evidence for this audit.

## Family and decision

For every integer `E>=3`, put

```text
q=2^E,  t=q/4,  C=7*t,  H=14*t,
a_E=(1,q,C-1,C+1,H-1,H).
```

The response completes the contract's all-`E` family analysis. The correct
disposition is `SEPARATION`: this family is neither a Prompt94 counterexample
nor a Prompt95 counterexample, and it proves no unrestricted transfer.

## Claim audit

| Claim | Decision | Exact scope and evidence recommendation |
| --- | --- | --- |
| Audit301 counterfamily replication | ACCEPT | Canonicality, deletion gcds, strict cover, valuation, `E_6=117`, and the Prompt87/92 route impact agree with Audit301. Retain Audit301's `proved-math-qualified` scope; replication creates no new result. |
| `a_E` is positive and injective | ACCEPT | The strict inequalities hold for `t=2^(E-2)>=2`. Recommend `proved-math-qualified` for every `E>=3`. |
| Exact `q`-row transfer | ACCEPT | Removing pivot `q` leaves precisely the accepted five-owner full-grid cover, which restricts to the candidate row. Recommend `proved-math-qualified`. |
| `Q_q` is empty and `DefUnit_q=0` | ACCEPT | Exact consequence of the `q`-row cover. Recommend `proved-math-qualified`. |
| Speed-one row is covered | ACCEPT | Its modulus is `7`, and owner `H=14*t` has zero product at every candidate. Recommend `proved-math-qualified`. |
| `Q_1` is empty and `DefUnit_1=0` | ACCEPT | Recommend `proved-math-qualified`. |
| Unit property of `r_m=4*m+1` | ACCEPT | `gcd(r_m,m)=1`, and its residues modulo `7` are `4,5,4,1` for `m=C-1,C+1,H-1,H`. Recommend `proved-math-qualified`. |
| Four all-`E` distance rows | ACCEPT | Every displayed reduction modulo `7*m`, including each `q`-owner value for `t mod 7` in `{1,2,4}`, is correct and at least the strict pivot threshold. Recommend `proved-math-qualified`. |
| Positive deficits on the four remaining pivots | ACCEPT | Each `r_m` is an uncovered unit candidate. Recommend `proved-math-qualified`. |
| `OmegaUnit(a_E)>=4>0` | ACCEPT | The bound is valid, though reflection parity can sharpen its numerical lower bound. This is family-specific `proved-math-qualified` evidence only. |
| Every-pivot-positive unit-deficit strengthening | ACCEPT as refuted | Rows `1` and `q` have zero deficit. Recommend `refuted-exact`, supported by the preceding `proved-math-qualified` proofs. This is not a Prompt94 refutation. |
| Literal `E=3` uncovered sets and deficits | ACCEPT | The deficits are `(0,0,8,6,18,14)` and total `46`. Recommend `proved-math-qualified`, not `computed finite evidence`. |
| Literal `E=3` Prompt95 statuses | ACCEPT | `F(a_3)={1,8}` and `j_star=8`. Recommend `proved-math-qualified`. |
| Literal `E=4` boundary and mechanism control | ACCEPT | The tuple, valuation, equality-boundary vector, and strict/weak distinction are correct. This is a control, not universal evidence. |
| `F(a_E)={1,q}` for every `E>=3` | ACCEPT | Rows `1,q` are covered and every other row has its explicit safe `r_m`. Recommend `proved-math-qualified`. |
| `j_star=q` | ACCEPT | Since `F(a_E)={1,q}` and `q>1`. Recommend `proved-math-qualified`. |
| No internal complete cover at `j_star` | ACCEPT | The only eligible owner is speed `1`; candidate `r=q` is safe at equality. Recommend `proved-math-qualified`. |
| Fixed-grid private-distance table | ACCEPT | All five vectors are exact and give one private owner each. Recommend `proved-math-qualified` at full-grid scope only. |
| Five-owner fixed-grid cover is inclusion-minimal | ACCEPT | Recommend `proved-math-qualified` at full-grid scope only. |
| The five-owner candidate-row cover is inclusion-minimal for all `E` | REJECT if inferred | The displayed private residue `q+3` is excluded from the candidate row when `q=4 mod 7`. The response correctly does not infer candidate-row minimality. |
| Prompt94 unrestricted target | RETAIN OPEN | The family satisfies positive total unit deficit; it proves no universal theorem. |
| Prompt95 unrestricted target | RETAIN OPEN | The internal-cover premise is absent for this family. |
| Unrestricted LRC | RETAIN OPEN | No unrestricted implication is established. |

## Qualifications and first remaining gaps

1. Prompt94 still requires a uniform proof that every positive injective tuple
   has positive total unit deficit. This family satisfies rather than narrows
   that target.
2. Prompt95 still requires redundancy when an internal complete cover actually
   exists. No such cover exists in this family.
3. Fixed-grid inclusion-minimality does not imply candidate-row minimality or
   Prompt95 internality. In particular, the `q+3` private point can be an
   excluded multiple of `7`.
4. A final manuscript should expand the terse modular reductions behind the
   all-`E` distance table, even though those reductions audit correctly.
5. None of the new family claims is Lean-formalized by this audit.

## Material-progress boundary

This is a sound family-specific negative integration result. It prevents the
Prompt92 fixed-grid family from being misused as either a Prompt94
counterexample or a Prompt95 internal cover. It does not supply an unrestricted
bridge and does not materially shorten the first open edge of Prompt94,
Prompt95, or LRC. The accepted disposition is exactly `SEPARATION`, not
`TRANSFER`, `PIVOT`, `COUNTEREXAMPLE`, or an unrestricted theorem.
