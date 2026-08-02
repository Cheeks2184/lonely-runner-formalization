#!/usr/bin/env node
/* Exact bounded OPT-ADD search around the CHAIN3 counterexample F. */

"use strict";

const {
  compareScores,
  normalize,
  scorePivot,
  scoreTuple,
} = require("./search_opt_add_failures.js");

const F = [8, 15, 35, 40, 48, 56, 75, 132, 147];

const gcd2 = (a, b) => {
  while (b !== 0) [a, b] = [b, a % b];
  return a;
};

function* singleReplacements(maximum) {
  const occupied = new Set(F);
  for (let removed = 0; removed < F.length; removed += 1) {
    for (let replacement = 1; replacement <= maximum; replacement += 1) {
      if (occupied.has(replacement)) continue;
      const tuple = [...F];
      tuple[removed] = replacement;
      yield normalize(tuple);
    }
  }
}

function* pairPerturbations(radius) {
  for (let first = 0; first < F.length; first += 1) {
    for (let second = first + 1; second < F.length; second += 1) {
      for (let left = -radius; left <= radius; left += 1) {
        if (left === 0) continue;
        for (let right = -radius; right <= radius; right += 1) {
          if (right === 0) continue;
          const proposal = [...F];
          proposal[first] += left;
          proposal[second] += right;
          yield normalize(proposal);
        }
      }
    }
  }
}

function* triplePerturbations(radius) {
  for (let first = 0; first < F.length; first += 1) {
    for (let second = first + 1; second < F.length; second += 1) {
      for (let third = second + 1; third < F.length; third += 1) {
        for (let left = -radius; left <= radius; left += 1) {
          if (left === 0) continue;
          for (let middle = -radius; middle <= radius; middle += 1) {
            if (middle === 0) continue;
            for (let right = -radius; right <= radius; right += 1) {
              if (right === 0) continue;
              const proposal = [...F];
              proposal[first] += left;
              proposal[second] += middle;
              proposal[third] += right;
              yield normalize(proposal);
            }
          }
        }
      }
    }
  }
}

function* oneExtensions(maximum) {
  const occupied = new Set(F);
  for (let added = 1; added <= maximum; added += 1) {
    if (!occupied.has(added)) yield normalize([...F, added]);
  }
}

function* oneDeletions() {
  for (let removed = 0; removed < F.length; removed += 1) {
    yield normalize(F.filter((_speed, index) => index !== removed));
  }
}

function pivotOrder(length) {
  // Start with pivots nearest the center by index.  This affects runtime only;
  // the reported incumbent receives a complete all-pivot evaluation.
  const center = Math.floor(length / 2);
  const result = [];
  for (let distance = 0; distance < length; distance += 1) {
    if (center + distance < length) result.push(center + distance);
    if (distance > 0 && center - distance >= 0) result.push(center - distance);
  }
  return result;
}

function scan(name, generated) {
  const seen = new Set();
  let generatedCount = 0;
  let valid = 0;
  let primitive = 0;
  let pivotDps = 0;
  let fullyScored = 0;
  let bestTuple = null;
  let bestScore = null;
  for (const tuple of generated) {
    generatedCount += 1;
    if (tuple === null || tuple.some((speed) => speed <= 0)) continue;
    const key = tuple.join(",");
    if (seen.has(key)) continue;
    seen.add(key);
    valid += 1;
    if (tuple.reduce(gcd2) !== 1) continue;
    primitive += 1;

    let pruned = false;
    const rows = new Array(tuple.length);
    for (const pivot of pivotOrder(tuple.length)) {
      const row = scorePivot(tuple, pivot);
      rows[pivot] = row;
      pivotDps += 1;
      if (bestScore !== null && row.surplus > bestScore.objective) {
        pruned = true;
        break;
      }
    }
    if (pruned) continue;
    fullyScored += 1;
    const profile = rows.map((row) => row.surplus).sort((a, b) => b - a);
    const candidateScore = { objective: profile[0], profile, rows };
    if (
      bestScore === null
      || compareScores(candidateScore, bestScore) < 0
      || (compareScores(candidateScore, bestScore) === 0 && key < bestTuple.join(","))
    ) {
      bestTuple = tuple;
      bestScore = candidateScore;
    }
  }
  // Recompute all rows, including when the incumbent was the seed or was
  // reached before the final pruning threshold changed.
  if (bestTuple === null) throw new Error(`empty primitive domain: ${name}`);
  bestScore = scoreTuple(bestTuple);
  const result = {
    name,
    generated: generatedCount,
    distinctValid: valid,
    primitive,
    pivotDps,
    fullyScored,
    found: bestScore.objective <= 0,
    bestTuple,
    objective: bestScore.objective,
    profile: bestScore.profile,
    rows: bestScore.rows,
  };
  console.log(JSON.stringify(result));
  return result;
}

function verifySummary(result, expected) {
  for (const field of ["generated", "distinctValid", "primitive", "objective"]) {
    if (result[field] !== expected[field]) {
      throw new Error(`${result.name}: ${field}=${result[field]} != ${expected[field]}`);
    }
  }
  if (result.found) throw new Error(`${result.name}: unexpected all-pivot failure`);
  if (result.bestTuple.join(",") !== expected.bestTuple.join(",")) {
    throw new Error(`${result.name}: closest tuple changed`);
  }
  if (result.profile.join(",") !== expected.profile.join(",")) {
    throw new Error(`${result.name}: closest profile changed`);
  }
}

function fixedAudit() {
  const reports = [
    scan("single replacements in [1,300]", singleReplacements(300)),
    scan("two-coordinate nonzero offsets in [-5,5]", pairPerturbations(5)),
    scan("three-coordinate nonzero offsets in [-2,2]", triplePerturbations(2)),
    scan("one-speed extensions from [1,300]", oneExtensions(300)),
    scan("one-speed deletions", oneDeletions()),
  ];
  const expected = [
    {
      generated: 2619, distinctValid: 2619, primitive: 2619, objective: 16,
      bestTuple: [7, 8, 15, 35, 40, 48, 56, 132, 147],
      profile: [16, 8, 5, 4, 4, 4, 0, -14, -65],
    },
    {
      generated: 3600, distinctValid: 3428, primitive: 3428, objective: 18,
      bestTuple: [5, 15, 35, 40, 48, 56, 77, 132, 147],
      profile: [18, 18, 16, 12, 2, -12, -36, -88, -99],
    },
    {
      generated: 5376, distinctValid: 5376, primitive: 5376, objective: 32,
      bestTuple: [10, 15, 35, 42, 48, 56, 77, 132, 147],
      profile: [32, 26, 14, 11, 10, -6, -34, -35, -60],
    },
    {
      generated: 291, distinctValid: 291, primitive: 291, objective: 62,
      bestTuple: [8, 15, 22, 35, 40, 48, 56, 75, 132, 147],
      profile: [62, 46, 40, 22, 14, 14, 12, 8, 6, -10],
    },
    {
      generated: 9, distinctValid: 9, primitive: 9, objective: 92,
      bestTuple: [8, 15, 35, 40, 48, 56, 75, 132],
      profile: [92, 60, 48, 28, 26, 26, 18, 10],
    },
  ];
  reports.forEach((report, index) => verifySummary(report, expected[index]));
  console.log("AUDIT OK: no all-pivot OPT-ADD failure in the five fixed domains");
  return reports;
}

function main(args) {
  const maximumIndex = args.indexOf("--maximum");
  const radiusIndex = args.indexOf("--radius");
  const maximum = maximumIndex < 0 ? 200 : Number(args[maximumIndex + 1]);
  const radius = radiusIndex < 0 ? 3 : Number(args[radiusIndex + 1]);
  const modeIndex = args.indexOf("--mode");
  const mode = modeIndex < 0 ? "all" : args[modeIndex + 1];
  if (mode === "audit") {
    fixedAudit();
    return;
  }
  if (mode === "all" || mode === "single") {
    scan(`single replacements in [1,${maximum}]`, singleReplacements(maximum));
  }
  if (mode === "all" || mode === "pair") {
    scan(`two-coordinate nonzero offsets in [-${radius},${radius}]`, pairPerturbations(radius));
  }
  if (mode === "triple") {
    scan(`three-coordinate nonzero offsets in [-${radius},${radius}]`, triplePerturbations(radius));
  }
  if (mode === "all" || mode === "extend") {
    scan(`one-speed extensions from [1,${maximum}]`, oneExtensions(maximum));
  }
  if (mode === "all" || mode === "delete") {
    scan("one-speed deletions", oneDeletions());
  }
}

if (require.main === module) main(process.argv.slice(2));

module.exports = {
  F,
  fixedAudit,
  oneDeletions,
  oneExtensions,
  pairPerturbations,
  scan,
  singleReplacements,
  triplePerturbations,
};
