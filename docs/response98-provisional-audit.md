# Prompt98 provisional audit

Task: `SOL-P98-PRO-MAX-COVERED-NONDIVISIBLE-PIVOT-REDUNDANCY-315`

Recovery base: `b12887f1c46d58c03999ef5d82517203ea61a91b`

## Provisional disposition

The Prompt98 response and its five attachments have been recovered. Recovery
establishes provenance only: it does not accept a proof, computation, local
lemma, or theorem status from the response.

The original response remains under correction and independent audit. The
frozen `MAX-COVERED-NONDIVISIBLE-PIVOT-REDUNDANCY` theorem, Prompt95, the
positive-integer pivot certificate, and unrestricted Lonely Runner all remain
`open`.

## Rejected successor: MBCP

The response proposed `MBCP` as a successor to the frozen branch theorem. Let
`B` denote that branch in its equivalent form asserting that no internal
inclusion-minimal complete cover exists.

- Under `B`, the minimal-cover antecedent in `MBCP` is impossible. Therefore
  `B -> MBCP` is vacuous.
- The response claims a descent proving `MBCP -> B`.

Consequently, at universal scope, the proposed `MBCP` is equivalent to the
full frozen branch rather than a strictly narrower separation lemma. It is
rejected as the requested successor and receives no proof-status promotion.
This exact objection was returned to the same Pro conversation for a
correction turn.

## Recovered finite bundle

The artifact inventory, original hashes, replay commands, and declared finite
domain are recorded in
[`../research/sol-pro/artifacts/prompt98/README.md`](../research/sol-pro/artifacts/prompt98/README.md).
The coordinator independently compiled and replayed both implementations. The
two canonical record streams were byte-identical, contained 2,803,981 records,
and reported no disagreement or theorem-domain failure over the declared
finite domain `2 <= n <= 7`, height at most 30.

This replay has not yet been promoted to `computed finite evidence`. Promotion
is fail-closed pending a Sol Medium semantic audit of the enumerated domain,
strict-boundary behavior, canonical ordering, completion markers, and the
meaning of every reported field. Reproducible execution alone does not prove
that the programs check the intended theorem.

## Unpromoted response content

The response's automatic-transport example and its local mathematical lemmas
remain response-authored and unpromoted. They require independent statement
matching, premise checks, and proof replay. In particular, none currently
establishes the frozen nondivisible branch or unrestricted LRC.

## Remaining audit work

1. Recover and audit the correction response separately from the original.
2. Perform the Medium semantic audit of both finite implementations.
3. Independently check each local lemma and the automatic-transport example.
4. Promote only claims whose exact scope survives those checks.
