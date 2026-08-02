#!/usr/bin/env node
/*
 * Exact targeted search for an all-pivot OPT-ADD failure.
 *
 * This JavaScript implementation is intentionally independent of the Python
 * search code.  It reconstructs the strict candidate universe and every
 * child fiber literally, then minimizes the unrestricted additive insertion
 * cost by subset dynamic programming.  It is a finite search tool, not a
 * proof of the Lonely Runner Conjecture.
 */

"use strict";

const gcd2 = (a, b) => {
  while (b !== 0) [a, b] = [b, a % b];
  return a;
};

function normalize(values) {
  const sorted = [...new Set(values)].sort((a, b) => a - b);
  if (sorted.length !== values.length || sorted[0] < 1) return null;
  const divisor = sorted.reduce(gcd2);
  return sorted.map((value) => value / divisor);
}

function scorePivot(speeds, pivot) {
  const n = speeds.length;
  const N = n + 1;
  const A = speeds[pivot];
  const modulus = N * A;
  const candidates = [];
  for (let residue = 0; residue < modulus; residue += 1) {
    if (residue % N !== 0) candidates.push(residue);
  }
  if (candidates.length !== n * A) throw new Error("candidate count mismatch");

  const others = [];
  for (let index = 0; index < n; index += 1) {
    if (index !== pivot) others.push(index);
  }
  const m = others.length;
  const bad = Array.from({ length: m }, () => new Uint8Array(candidates.length));
  const fibers = Array.from({ length: m }, () => new Map());
  const counts = new Int32Array(m);
  for (let child = 0; child < m; child += 1) {
    const speed = speeds[others[child]];
    for (let position = 0; position < candidates.length; position += 1) {
      const image = (speed * candidates[position]) % modulus;
      if (image < A || image > modulus - A) {
        bad[child][position] = 1;
        counts[child] += 1;
        let members = fibers[child].get(image);
        if (members === undefined) {
          members = [];
          fibers[child].set(image, members);
        }
        members.push(position);
      }
    }
  }

  const full = (1 << m) - 1;
  const credit = Array.from({ length: m }, () => new Int32Array(full + 1));
  for (let child = 0; child < m; child += 1) {
    const singleton = Array.from({ length: m }, () => []);
    for (const members of fibers[child].values()) {
      for (let parent = 0; parent < m; parent += 1) {
        let overlap = 0;
        for (const position of members) overlap += bad[parent][position];
        singleton[parent].push(overlap);
      }
    }
    const fiberCount = fibers[child].size;
    for (let state = 1; state <= full; state += 1) {
      if (state & (1 << child)) continue;
      let total = 0;
      for (let fiber = 0; fiber < fiberCount; fiber += 1) {
        let maximum = 0;
        for (let parent = 0; parent < m; parent += 1) {
          if (state & (1 << parent)) maximum = Math.max(maximum, singleton[parent][fiber]);
        }
        total += maximum;
      }
      credit[child][state] = total;
    }
  }

  const infinity = counts.reduce((sum, value) => sum + value, 0) + 1;
  const cost = new Int32Array(full + 1);
  cost.fill(infinity);
  const previousState = new Int32Array(full + 1);
  const previousChild = new Int8Array(full + 1);
  previousState.fill(-1);
  previousChild.fill(-1);
  for (let child = 0; child < m; child += 1) cost[1 << child] = counts[child];
  for (let state = 1; state <= full; state += 1) {
    if (cost[state] === infinity) continue;
    for (let child = 0; child < m; child += 1) {
      const bit = 1 << child;
      if (state & bit) continue;
      const successor = state | bit;
      const candidate = cost[state] + counts[child] - credit[child][state];
      if (candidate < cost[successor]) {
        cost[successor] = candidate;
        previousState[successor] = state;
        previousChild[successor] = child;
      }
    }
  }
  const reverse = [];
  let state = full;
  while ((state & (state - 1)) !== 0) {
    reverse.push(previousChild[state]);
    state = previousState[state];
  }
  reverse.push(Math.log2(state));
  reverse.reverse();
  const order = reverse.map((local) => speeds[others[local]]);
  return {
    pivot: A,
    threshold: n * A,
    optimizedBound: cost[full],
    surplus: n * A - cost[full],
    order,
  };
}

function scoreTuple(speeds) {
  const rows = speeds.map((_speed, pivot) => scorePivot(speeds, pivot));
  const profile = rows.map((row) => row.surplus).sort((a, b) => b - a);
  return { objective: profile[0], profile, rows };
}

function compareScores(left, right) {
  for (let index = 0; index < left.profile.length; index += 1) {
    if (left.profile[index] !== right.profile[index]) {
      return left.profile[index] - right.profile[index];
    }
  }
  return 0;
}

function deterministicDescent(seed, maximum, radius, rounds) {
  let current = normalize(seed);
  let currentScore = scoreTuple(current);
  let examined = 1;
  const seen = new Set([current.join(",")]);
  console.log(`start objective=${currentScore.objective} tuple=${current}`);
  for (let round = 0; round < rounds; round += 1) {
    let best = current;
    let bestScore = currentScore;
    for (let position = 0; position < current.length; position += 1) {
      for (let delta = -radius; delta <= radius; delta += 1) {
        if (delta === 0) continue;
        const proposal = [...current];
        proposal[position] = Math.max(1, Math.min(maximum, proposal[position] + delta));
        const normalized = normalize(proposal);
        if (normalized === null) continue;
        const key = normalized.join(",");
        if (seen.has(key)) continue;
        seen.add(key);
        const candidateScore = scoreTuple(normalized);
        examined += 1;
        if (compareScores(candidateScore, bestScore) < 0) {
          best = normalized;
          bestScore = candidateScore;
        }
      }
    }
    if (compareScores(bestScore, currentScore) >= 0) break;
    current = best;
    currentScore = bestScore;
    console.log(`round=${round + 1} objective=${currentScore.objective} tuple=${current}`);
    if (currentScore.objective <= 0) break;
  }
  return { speeds: current, score: currentScore, examined };
}

function randomSearch(seeds, maximum, steps, randomSeed) {
  let generator = randomSeed >>> 0;
  const random = () => {
    generator = (1664525 * generator + 1013904223) >>> 0;
    return generator / 0x100000000;
  };
  let best = normalize(seeds[0]);
  let bestScore = scoreTuple(best);
  let current = best;
  let currentScore = bestScore;
  let examined = 1;
  const seen = new Set([best.join(",")]);
  for (let step = 0; step < steps; step += 1) {
    if (step % 250 === 0 && step > 0) {
      current = normalize(seeds[Math.floor(random() * seeds.length)]);
      currentScore = scoreTuple(current);
    }
    const proposal = [...current];
    const changes = random() < 0.22 ? 2 : 1;
    for (let change = 0; change < changes; change += 1) {
      const position = Math.floor(random() * proposal.length);
      const span = Math.max(2, Math.round(maximum * (random() < 0.15 ? 0.25 : 0.04)));
      proposal[position] = Math.max(1, Math.min(maximum,
        proposal[position] + Math.floor(random() * (2 * span + 1)) - span));
    }
    const normalized = normalize(proposal);
    if (normalized === null) continue;
    const key = normalized.join(",");
    if (seen.has(key)) continue;
    seen.add(key);
    const candidateScore = scoreTuple(normalized);
    examined += 1;
    const comparison = compareScores(candidateScore, currentScore);
    if (comparison < 0 || random() < 0.015) {
      current = normalized;
      currentScore = candidateScore;
    }
    if (compareScores(candidateScore, bestScore) < 0) {
      best = normalized;
      bestScore = candidateScore;
      console.log(`step=${step} objective=${bestScore.objective} tuple=${best}`);
      if (bestScore.objective <= 0) break;
    }
  }
  return { speeds: best, score: bestScore, examined };
}

function targetedFailureSearch(seeds, maximum, steps, randomSeed) {
  // This mode searches only for objective <= 0.  It remains exact: a tuple is
  // accepted only after every pivot DP has been evaluated.  The center-out
  // pivot order merely rejects ordinary positive-surplus proposals sooner.
  let generator = randomSeed >>> 0;
  const random = () => {
    generator = (1664525 * generator + 1013904223) >>> 0;
    return generator / 0x100000000;
  };
  const seen = new Set();
  let examined = 0;
  let fallback = normalize(seeds[0]);
  let fallbackScore = scoreTuple(fallback);
  for (const seed of seeds.slice(1)) {
    const normalized = normalize(seed);
    const candidateScore = scoreTuple(normalized);
    if (compareScores(candidateScore, fallbackScore) < 0) {
      fallback = normalized;
      fallbackScore = candidateScore;
    }
  }
  for (let step = 0; step < steps; step += 1) {
    const base = seeds[Math.floor(random() * seeds.length)];
    const proposal = [...base];
    const changes = 1 + Math.floor(random() * Math.min(4, proposal.length));
    for (let change = 0; change < changes; change += 1) {
      const position = Math.floor(random() * proposal.length);
      const span = random() < 0.8 ? 5 : Math.max(6, Math.floor(maximum / 3));
      proposal[position] = Math.max(1, Math.min(maximum,
        proposal[position] + Math.floor(random() * (2 * span + 1)) - span));
    }
    const speeds = normalize(proposal);
    if (speeds === null) continue;
    const key = speeds.join(",");
    if (seen.has(key)) continue;
    seen.add(key);
    examined += 1;
    const center = Math.floor(speeds.length / 2);
    const pivotOrder = [];
    for (let distance = 0; distance < speeds.length; distance += 1) {
      if (center + distance < speeds.length) pivotOrder.push(center + distance);
      if (distance && center - distance >= 0) pivotOrder.push(center - distance);
    }
    const byPivot = new Array(speeds.length);
    let rejected = false;
    for (const pivot of pivotOrder) {
      const row = scorePivot(speeds, pivot);
      byPivot[pivot] = row;
      if (row.surplus > 0) {
        rejected = true;
        break;
      }
    }
    if (!rejected) {
      const profile = byPivot.map((row) => row.surplus).sort((a, b) => b - a);
      return {
        speeds,
        score: { objective: profile[0], profile, rows: byPivot },
        examined,
        found: true,
      };
    }
  }
  return { speeds: fallback, score: fallbackScore, examined, found: false };
}

const E = [5, 28, 35, 40, 68, 88, 108, 148, 165];
const seeds = [
  E,
  [10, 37, 45, 51, 54, 56, 61, 71, 91],
  [1, 4, 6, 7, 9, 10, 13, 16, 17],
  [1, 4, 6, 7, 9, 10, 11, 13, 16, 17],
  [1, 4, 5, 6, 7, 9, 11, 13, 16, 17],
  [1, 2, 3, 4, 5, 6, 7, 8, 9, 11, 60],
  [1, 2, 3, 5, 6, 7, 8, 9, 10, 11, 60],
  [1, 4, 5, 6, 7, 9, 11, 13, 16, 17, 60],
];

function printResult(result) {
  const found = result.found ?? result.score.objective <= 0;
  console.log(`RESULT found=${found} objective=${result.score.objective} examined=${result.examined} tuple=${result.speeds}`);
  console.log(`profile=${result.score.profile}`);
  for (const row of result.score.rows) console.log(JSON.stringify(row));
}

const args = process.argv.slice(2);
const get = (name, fallback) => {
  const index = args.indexOf(name);
  return index === -1 ? fallback : Number(args[index + 1]);
};
if (args.includes("--tuple")) {
  const index = args.indexOf("--tuple");
  const speeds = normalize(args[index + 1].split(",").map(Number));
  printResult({ speeds, score: scoreTuple(speeds), examined: 1 });
} else if (args.includes("--descent")) {
  const index = get("--descent", 0);
  printResult(deterministicDescent(
    seeds[index], get("--maximum", 200), get("--radius", 3), get("--rounds", 20)));
} else {
  const n = get("--runners", 9);
  const matching = seeds.filter((seed) => seed.length === n);
  const search = args.includes("--targeted") ? targetedFailureSearch : randomSearch;
  printResult(search(matching, get("--maximum", 200), get("--steps", 2000), get("--seed", 20260802)));
}
