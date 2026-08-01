# Literature and known results

Research cutoff: 2026-08-01. Results are labeled by publication status. A
preprint claim is not treated as an independently verified theorem here.

## Origins

- Wills's 1967--68 work contains the homogeneous Diophantine-approximation
  conjecture: <https://doi.org/10.1007/BF01298332>.
- Cusick gave the view-obstruction formulation in 1973:
  <https://doi.org/10.1007/BF01832623>.
- The runner interpretation/name is due to Goddyn and appeared in
  Bienia--Goddyn--Gvozdjak--Sebo--Tarsi:
  <https://doi.org/10.1006/jctb.1997.1770>.

## Verified finite dimensions

In total-runner indexing `N`, the classical published chain covers `N <= 7`:

- `N = 4`: Betke--Wills (1972), <https://eudml.org/doc/177595>.
- `N = 5`: Cusick--Pomerance (1984),
  <https://doi.org/10.1016/0022-314X(84)90097-0>.
- `N = 6`: Bohman--Holzman--Kleitman (2001),
  <https://doi.org/10.37236/1602>; Renault's shorter proof is
  <https://doi.org/10.1016/j.disc.2004.06.008>.
- `N = 7`: Barajas--Serra (2008), <https://doi.org/10.37236/772>.

The strongest peer-reviewed finite result located by the cutoff covers
`N <= 10`: Rosenfeld's computer-assisted `N = 8` result is published/accepted
in *Mathematics of Computation* (<https://doi.org/10.1090/mcom/4243>;
preprint <https://arxiv.org/abs/2509.14111>), and
Trakulthongchai's `N = 9,10` result appears in EJC 33(2), P2.46 (2026),
<https://doi.org/10.37236/14972>.

Sungkawichai--Trakulthongchai claim computer-assisted proofs through `N = 13`
in a 2026 preprint, <https://arxiv.org/abs/2604.23906>. This repository treats
`N = 11,12,13` as unaudited preprint claims until the proof and certificate code
are independently reproduced. No recognized proof or disproof for all `N` was
found; `N >= 14` remains open at the cutoff.

## General and structural results

- The elementary measure/union-bound argument gives loneliness gap at least
  `1/(2n)` for `n` moving speeds.
- Tao improves this asymptotically, proves finite reducibility to bounded
  integer speeds, and handles several structured speed classes:
  <https://arxiv.org/abs/1701.02048>.
- Malikiosis--Santos--Schymura give the strongest clean published finite
  checking bound used by the recent computer proofs:
  <https://doi.org/10.1017/fms.2025.10107>.
- Henze--Malikiosis relate the conjecture to covering radii of lonely-runner
  zonotopes: <https://arxiv.org/abs/1609.01939>.
- Blanco--Criado--Santos clarify the torus/zonotope reductions and give
  counterexamples to the shifted conjecture and Lonely Vector Property:
  <https://arxiv.org/abs/2603.24784>.
- Giri--Kravitz study accumulation and the hierarchical structure of lonely
  runner spectra: <https://doi.org/10.1017/S0305004125101497>.
- Bohman--Peng prove large families of slow-speed instances and discuss tight
  examples: <https://arxiv.org/abs/2109.09860>.

## Obstructions that affect formalization

- `(1,2,...,n)` is tight: strict `>` cannot replace `>=`.
- A supremum formulation for arbitrary real speeds does not by itself supply
  an attained witness; the orbit need not be closed.
- Time modulo one is valid for integer-normalized speeds, not arbitrary real
  speeds.
- The shifted/free-starting-position generalization is false, so a proof of a
  stronger shifted statement is immediately suspect.
- Allowing duplicate stationary speeds is harmless only after explicitly
  invoking lower-dimensional cases.

The exact real-to-rational reduction used here is BHK Lemma 8, not a direct
continuity argument. In moving dimension `m`, its endpoint-safe form combines
the rational cases in dimensions `m` and `m-1`; see
`docs/real-to-integer-reduction.md`. Henze--Malikiosis give a useful
same-dimensional orbit-closure reduction for supremal constants, but an
additional attainment or open-slack argument is required for the closed
existential formulation.
