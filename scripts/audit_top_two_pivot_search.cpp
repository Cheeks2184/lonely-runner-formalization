// Deterministic finite stress test for the top-two pivot strengthening.
//
// For a sorted tuple 0 < a_1 < ... < a_n and N=n+1, the strengthening asks
// whether one of A=a_{n-1},a_n has a residue r modulo N*A such that N does
// not divide r and rho_{N*A}(r*a_i) >= A for every i.  This is the existing
// exact pivot certificate with its pivot existential restricted to the two
// numerically largest speeds.  It implies the unrestricted pivot proposition;
// no converse is known.  Every result printed here is bounded computation.

#include <algorithm>
#include <cstdint>
#include <functional>
#include <iostream>
#include <limits>
#include <numeric>
#include <set>
#include <stdexcept>
#include <tuple>
#include <utility>
#include <vector>

using namespace std;

static int rho(int modulus, int64_t value) {
  const int residue = int(value % modulus);
  return min(residue, modulus - residue);
}

static vector<int> safe_residues(const vector<int>& speeds, int pivot) {
  const int n = int(speeds.size());
  const int N = n + 1;
  const int A = speeds[pivot];
  const int modulus = N * A;
  vector<int> result;
  for (int r = 1; r < modulus; ++r) {
    if (r % N == 0) continue;
    bool safe = true;
    for (int speed : speeds) {
      if (rho(modulus, int64_t(r) * speed) < A) {
        safe = false;
        break;
      }
    }
    if (safe) result.push_back(r);
  }
  return result;
}

static bool has_safe_residue(const vector<int>& speeds, int pivot) {
  const int n = int(speeds.size());
  const int N = n + 1;
  const int A = speeds[pivot];
  const int modulus = N * A;
  for (int r = 1; r < modulus; ++r) {
    if (r % N == 0) continue;
    bool safe = true;
    for (int speed : speeds) {
      if (rho(modulus, int64_t(r) * speed) < A) {
        safe = false;
        break;
      }
    }
    if (safe) return true;
  }
  return false;
}

static bool divisor_cover(const vector<int>& speeds) {
  const int N = int(speeds.size()) + 1;
  for (int q = 2; q <= N; ++q) {
    bool covered = false;
    for (int speed : speeds) covered = covered || speed % q == 0;
    if (!covered) return false;
  }
  return true;
}

struct BoxResult {
  uint64_t primitive = 0;
  uint64_t divisor_cover = 0;
  uint64_t fastest_failures = 0;
  uint64_t top_two_failures = 0;
  uint64_t divisor_cover_top_two_failures = 0;
  vector<int> first_fastest_failure;
  vector<int> first_top_two_failure;
};

static BoxResult scan_box(int n, int maximum) {
  BoxResult result;
  vector<int> tuple(n);
  function<void(int, int)> visit = [&](int position, int start) {
    if (position == n) {
      int common = 0;
      for (int speed : tuple) common = gcd(common, speed);
      if (common != 1) return;
      ++result.primitive;
      const bool cover = divisor_cover(tuple);
      result.divisor_cover += cover;
      const bool fastest = has_safe_residue(tuple, n - 1);
      if (!fastest) {
        ++result.fastest_failures;
        if (result.first_fastest_failure.empty()) {
          result.first_fastest_failure = tuple;
        }
        const bool penultimate = has_safe_residue(tuple, n - 2);
        if (!penultimate) {
          ++result.top_two_failures;
          result.divisor_cover_top_two_failures += cover;
          if (result.first_top_two_failure.empty()) {
            result.first_top_two_failure = tuple;
          }
        }
      }
      return;
    }
    const int last = maximum - (n - position) + 1;
    for (int speed = start; speed <= last; ++speed) {
      tuple[position] = speed;
      visit(position + 1, speed + 1);
    }
  };
  visit(0, 1);
  return result;
}

static string show_tuple(const vector<int>& tuple) {
  if (tuple.empty()) return "none";
  string result = "(";
  for (int i = 0; i < int(tuple.size()); ++i) {
    if (i) result += ',';
    result += to_string(tuple[i]);
  }
  return result + ')';
}

static vector<int> primitive_normalize(vector<int> tuple) {
  if (*min_element(tuple.begin(), tuple.end()) <= 0) return {};
  sort(tuple.begin(), tuple.end());
  if (adjacent_find(tuple.begin(), tuple.end()) != tuple.end()) return {};
  int common = 0;
  for (int speed : tuple) common = gcd(common, speed);
  if (common > 1) for (int& speed : tuple) speed /= common;
  return tuple;
}

static void print_residue_profile(const vector<int>& tuple) {
  const int n = int(tuple.size());
  cout << "profile tuple=" << show_tuple(tuple);
  for (int pivot = 0; pivot < n; ++pivot) {
    const vector<int> safe = safe_residues(tuple, pivot);
    cout << " pivot=" << tuple[pivot] << ":";
    if (safe.empty()) {
      cout << "[]";
    } else {
      cout << '[';
      for (int i = 0; i < int(safe.size()); ++i) {
        if (i) cout << ',';
        cout << safe[i];
      }
      cout << ']';
    }
  }
  cout << '\n';
}

static void scan_scaling_and_structured_mutations() {
  const vector<pair<int, vector<int>>> cores = {
      {6, {1,4,5,6,7,11}},
      {8, {1,3,4,5,7,9,11,12}},
      {10, {2,6,8,9,10,11,13,14,17,19}},
      {12, {1,2,3,4,5,6,7,8,9,10,11,13}},
      {15, {1,2,3,4,5,7,9,10,11,12,13,15,16,17,19}},
  };

  uint64_t scaling_checks = 0;
  uint64_t scaling_mismatches = 0;
  for (const auto& [n, core] : cores) {
    const int base_penultimate = int(safe_residues(core, n - 2).size());
    const int base_fastest = int(safe_residues(core, n - 1).size());
    for (int scale = 1; scale <= 64; ++scale) {
      vector<int> scaled = core;
      for (int& speed : scaled) speed *= scale;
      const int scaled_penultimate = int(safe_residues(scaled, n - 2).size());
      const int scaled_fastest = int(safe_residues(scaled, n - 1).size());
      scaling_mismatches += scaled_penultimate != scale * base_penultimate;
      scaling_mismatches += scaled_fastest != scale * base_fastest;
      scaling_checks += 2;
    }
  }
  cout << "scaling cores=" << cores.size() << " scales=1..64 checks="
       << scaling_checks << " mismatches=" << scaling_mismatches << '\n';

  for (const auto& [n, core] : cores) {
    set<vector<int>> seen;
    uint64_t cover_count = 0;
    uint64_t top_two_failures = 0;
    int best_max = numeric_limits<int>::max();
    int best_sum = numeric_limits<int>::max();
    int best_penultimate = 0;
    int best_fastest = 0;
    vector<int> best_tuple;
    for (int scale = 1; scale <= 8; ++scale) {
      vector<int> base = core;
      for (int& speed : base) speed *= scale;
      for (int first = 0; first < n; ++first) {
        for (int second = first + 1; second < n; ++second) {
          for (int delta_first = -4; delta_first <= 4; ++delta_first) {
            for (int delta_second = -4; delta_second <= 4; ++delta_second) {
              vector<int> tuple = base;
              tuple[first] += delta_first;
              tuple[second] += delta_second;
              tuple = primitive_normalize(tuple);
              if (tuple.empty() || !seen.insert(tuple).second) continue;
              cover_count += divisor_cover(tuple);
              const int penultimate = int(safe_residues(tuple, n - 2).size());
              const int fastest = int(safe_residues(tuple, n - 1).size());
              const int maximum = max(penultimate, fastest);
              const int sum = penultimate + fastest;
              top_two_failures += maximum == 0;
              if (tie(maximum, sum, tuple) < tie(best_max, best_sum, best_tuple)) {
                best_max = maximum;
                best_sum = sum;
                best_penultimate = penultimate;
                best_fastest = fastest;
                best_tuple = tuple;
              }
            }
          }
        }
      }
    }
    cout << "structured n=" << n << " scales=1..8 deltas=-4..4 unique="
         << seen.size() << " divisor_cover=" << cover_count
         << " top_two_failures=" << top_two_failures
         << " best_rows=(" << best_penultimate << ',' << best_fastest << ')'
         << " best_tuple=" << show_tuple(best_tuple) << '\n';
  }
}

int main() {
  const vector<pair<int, int>> domains = {
      {3,30}, {4,30}, {5,30}, {6,30}, {7,20}, {8,18},
  };
  uint64_t total_primitive = 0;
  uint64_t total_top_two_failures = 0;
  for (const auto& [n, maximum] : domains) {
    const BoxResult result = scan_box(n, maximum);
    total_primitive += result.primitive;
    total_top_two_failures += result.top_two_failures;
    cout << "box n=" << n << " max=" << maximum
         << " primitive=" << result.primitive
         << " divisor_cover=" << result.divisor_cover
         << " fastest_failures=" << result.fastest_failures
         << " top_two_failures=" << result.top_two_failures
         << " divisor_cover_top_two_failures="
         << result.divisor_cover_top_two_failures
         << " first_fastest_failure="
         << show_tuple(result.first_fastest_failure)
         << " first_top_two_failure="
         << show_tuple(result.first_top_two_failure) << '\n';
  }
  cout << "boxes total_primitive=" << total_primitive
       << " total_top_two_failures=" << total_top_two_failures << '\n';

  print_residue_profile({1,4,5,6,7,11});
  print_residue_profile({2,6,8,9,10,11,13,14,17,19});
  print_residue_profile({1,2,3,4,5,6,7,8,9,10,11,13});
  scan_scaling_and_structured_mutations();
  return 0;
}
