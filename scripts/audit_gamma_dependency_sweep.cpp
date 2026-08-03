#include <algorithm>
#include <cstdint>
#include <iostream>
#include <numeric>
#include <set>
#include <stdexcept>
#include <string>
#include <tuple>
#include <utility>
#include <vector>

namespace {

using i64 = std::int64_t;

// These finite searches are intentionally bounded.  This makes every product
// below fit comfortably in signed 64-bit arithmetic and keeps vector indices
// within the range of int.
constexpr int kMaximumN = 1'000'000;

int omega(int x) {
  int count = 0;
  for (int p = 2; static_cast<i64>(p) * p <= x; ++p) {
    if (x % p != 0) continue;
    ++count;
    while (x % p == 0) x /= p;
  }
  return count + (x > 1);
}

i64 pow2_omega(int x) {
  const int exponent = omega(x);
  if (exponent >= 62) throw std::overflow_error("2^omega does not fit in i64");
  return i64{1} << exponent;
}

struct Graph {
  int N;
  int t;
  std::vector<int> candidates;
  std::vector<int> lower_offset;
  std::vector<int> upper_offset;
  std::vector<std::vector<int>> adjacency;
};

void validate_instance(int N, int t) {
  if (N < 1 || N > kMaximumN) {
    throw std::invalid_argument("N must lie in [1, 1000000]");
  }
  if (!(N / 3 + 1 <= t && t <= N / 2)) {
    throw std::invalid_argument("t must lie in [floor(N/3)+1, floor(N/2)]");
  }
}

Graph build_graph(int N, int t) {
  validate_instance(N, t);
  const i64 H = static_cast<i64>(N) + t;
  const int first_c = static_cast<int>(3 * (static_cast<i64>(N) - t) / 4 + 1);
  const int last_c = static_cast<int>(H / 2);
  Graph graph{N, t, {}, {}, {}, {}};

  for (int c = std::max(1, first_c); c <= last_c; ++c) {
    // Candidate guard 1: the lower exclusive strip is shorter than 2^omega(c).
    const i64 lower_strip = std::max<i64>(0, static_cast<i64>(N) - c - t);
    if (lower_strip >= pow2_omega(c)) continue;

    // Candidate guard 2: the upper exclusive strip contains no coprime point.
    bool has_upper_coprime = false;
    for (i64 d = H + 1; d <= 2 * static_cast<i64>(N) - c; ++d) {
      if (std::gcd<i64>(c, d) == 1) {
        has_upper_coprime = true;
        break;
      }
    }
    if (has_upper_coprime) continue;

    graph.candidates.push_back(c);
    const i64 lower_d = std::max<i64>(N + 1, H - c + 1);
    const i64 upper_d = std::min<i64>(H, 2 * static_cast<i64>(N) - c);
    graph.lower_offset.push_back(static_cast<int>(lower_d - N));
    graph.upper_offset.push_back(static_cast<int>(upper_d - N));
    graph.adjacency.emplace_back();
  }
  return graph;
}

bool greedy_matching(const Graph& graph, std::vector<int>* owner_out) {
  std::set<int> free_right;
  for (int d = 1; d <= graph.t; ++d) free_right.insert(d);
  std::vector<int> owner(graph.t + 1, -1);

  for (int i = static_cast<int>(graph.candidates.size()) - 1; i >= 0; --i) {
    bool found = false;
    auto right = free_right.lower_bound(graph.lower_offset[i]);
    while (right != free_right.end() && *right <= graph.upper_offset[i]) {
      if (std::gcd(graph.candidates[i], graph.N + *right) == 1) {
        owner[*right] = i;
        free_right.erase(right);
        found = true;
        break;
      }
      ++right;
    }
    if (!found) return false;
  }
  if (owner_out != nullptr) *owner_out = std::move(owner);
  return true;
}

// Exact augmenting-path fallback.  It enumerates the same implicit Gamma row
// used by greedy_matching and returns a saturating owner map when one exists.
bool exact_matching(const Graph& graph, std::vector<int>* owner_out) {
  std::vector<int> owner(graph.t + 1, -1);
  std::vector<int> seen_right(graph.t + 1, 0);
  std::vector<int> seen_left(graph.candidates.size(), 0);
  int tick = 0;

  auto augment = [&](auto&& self, int i) -> bool {
    if (seen_left[i] == tick) return false;
    seen_left[i] = tick;
    for (int d = graph.lower_offset[i]; d <= graph.upper_offset[i]; ++d) {
      if (seen_right[d] == tick) continue;
      if (std::gcd(graph.candidates[i], graph.N + d) != 1) continue;
      seen_right[d] = tick;
      if (owner[d] < 0 || self(self, owner[d])) {
        owner[d] = i;
        return true;
      }
    }
    return false;
  };

  for (int i = static_cast<int>(graph.candidates.size()) - 1; i >= 0; --i) {
    ++tick;
    if (!augment(augment, i)) return false;
  }
  if (owner_out != nullptr) *owner_out = std::move(owner);
  return true;
}

void materialize_adjacency(Graph& graph) {
  for (int i = 0; i < static_cast<int>(graph.candidates.size()); ++i) {
    auto& row = graph.adjacency[i];
    for (int d = graph.lower_offset[i]; d <= graph.upper_offset[i]; ++d) {
      if (std::gcd(graph.candidates[i], graph.N + d) == 1) row.push_back(d);
    }
  }
}

bool owner_is_saturating(const Graph& graph, const std::vector<int>& owner) {
  if (owner.size() != static_cast<std::size_t>(graph.t + 1)) return false;
  std::vector<int> count(graph.candidates.size(), 0);
  for (int d = 1; d <= graph.t; ++d) {
    const int i = owner[d];
    if (i < 0) continue;
    if (i >= static_cast<int>(graph.candidates.size())) return false;
    if (!(graph.lower_offset[i] <= d && d <= graph.upper_offset[i])) return false;
    if (std::gcd(graph.candidates[i], graph.N + d) != 1) return false;
    ++count[i];
  }
  return std::all_of(count.begin(), count.end(), [](int n) { return n == 1; });
}

// For a fixed left-saturating matching M, a nonempty tight Hall set is exactly
// a nonempty successor-closed left set with no neighbor unmatched by M.  Here
// x -> y when x sees the right vertex owned by y.  Consequently strict Hall is
// equivalent to every left vertex reaching a vertex with an unmatched neighbor.
bool strict_hall_from_matching(const Graph& graph,
                               const std::vector<int>& owner) {
  const int n = static_cast<int>(graph.candidates.size());
  std::vector<std::vector<int>> reverse_edges(n);
  std::vector<char> reaches_unmatched(n, false);
  std::vector<int> queue;

  for (int i = 0; i < n; ++i) {
    for (int d : graph.adjacency[i]) {
      if (owner[d] < 0) {
        if (!reaches_unmatched[i]) {
          reaches_unmatched[i] = true;
          queue.push_back(i);
        }
      } else if (owner[d] != i) {
        reverse_edges[owner[d]].push_back(i);
      }
    }
  }
  for (std::size_t head = 0; head < queue.size(); ++head) {
    for (int i : reverse_edges[queue[head]]) {
      if (!reaches_unmatched[i]) {
        reaches_unmatched[i] = true;
        queue.push_back(i);
      }
    }
  }
  return queue.size() == static_cast<std::size_t>(n);
}

struct IntervalResult {
  int minimum_slack;
  int first_index;
  int last_index;
  int union_size;
  i64 intervals_tested;
};

IntervalResult interval_stats(const Graph& graph) {
  const int n = static_cast<int>(graph.candidates.size());
  const int words = (graph.t + 64) / 64;
  std::vector<std::vector<std::uint64_t>> rows(
      n, std::vector<std::uint64_t>(words, 0));
  for (int i = 0; i < n; ++i) {
    for (int d : graph.adjacency[i]) {
      rows[i][d / 64] |= std::uint64_t{1} << (d % 64);
    }
  }

  IntervalResult result{graph.t + 1, -1, -1, -1, 0};
  std::vector<std::uint64_t> row_union(words, 0);
  for (int first = 0; first < n; ++first) {
    std::fill(row_union.begin(), row_union.end(), 0);
    for (int last = first; last < n; ++last) {
      int union_size = 0;
      for (int word = 0; word < words; ++word) {
        row_union[word] |= rows[last][word];
        union_size += __builtin_popcountll(row_union[word]);
      }
      const int slack = union_size - (last - first + 1);
      ++result.intervals_tested;
      if (slack < result.minimum_slack) {
        result.minimum_slack = slack;
        result.first_index = first;
        result.last_index = last;
        result.union_size = union_size;
      }
    }
  }
  return result;
}

struct SweepResult {
  i64 parameter_cases = 0;
  i64 nonempty_graphs = 0;
  i64 empty_graphs = 0;
  i64 candidate_rows = 0;
  i64 greedy_fallbacks = 0;
  std::vector<std::pair<int, int>> matching_failures;
};

template <typename VisitT>
SweepResult run_grid(int first_N, int last_N, int N_step, int t_step,
                     VisitT visit) {
  if (first_N < 1 || last_N < first_N || last_N > kMaximumN || N_step <= 0 ||
      t_step <= 0) {
    throw std::invalid_argument("invalid grid bounds or step");
  }
  SweepResult result;
  for (int N = first_N; N <= last_N; N += N_step) {
    for (int t = N / 3 + 1; t <= N / 2; t += t_step) {
      ++result.parameter_cases;
      Graph graph = build_graph(N, t);
      result.candidate_rows += static_cast<i64>(graph.candidates.size());
      if (graph.candidates.empty()) {
        ++result.empty_graphs;
        visit(graph, std::vector<int>{});
        continue;
      }
      ++result.nonempty_graphs;
      std::vector<int> owner;
      if (!greedy_matching(graph, &owner)) {
        ++result.greedy_fallbacks;
        if (!exact_matching(graph, &owner)) {
          result.matching_failures.emplace_back(N, t);
          continue;
        }
      }
      if (!owner_is_saturating(graph, owner)) {
        throw std::logic_error("matching owner map failed independent validation");
      }
      visit(graph, owner);
    }
  }
  return result;
}

SweepResult run_endpoints(int first_N, int last_N) {
  if (first_N < 1 || last_N < first_N || last_N > kMaximumN) {
    throw std::invalid_argument("invalid endpoint bounds");
  }
  SweepResult total;
  for (int N = first_N; N <= last_N; ++N) {
    const int t = N / 2;
    validate_instance(N, t);
    ++total.parameter_cases;
    Graph graph = build_graph(N, t);
    total.candidate_rows += static_cast<i64>(graph.candidates.size());
    if (graph.candidates.empty()) {
      ++total.empty_graphs;
      continue;
    }
    ++total.nonempty_graphs;
    std::vector<int> owner;
    if (!greedy_matching(graph, &owner)) {
      ++total.greedy_fallbacks;
      if (!exact_matching(graph, &owner)) {
        total.matching_failures.emplace_back(N, t);
        continue;
      }
    }
    if (!owner_is_saturating(graph, owner)) {
      throw std::logic_error("matching owner map failed independent validation");
    }
  }
  return total;
}

void print_sweep(const std::string& mode, const SweepResult& result) {
  std::cout << "mode=" << mode << '\n';
  std::cout << "parameter_cases=" << result.parameter_cases << '\n';
  std::cout << "nonempty_graphs=" << result.nonempty_graphs << '\n';
  std::cout << "empty_graphs=" << result.empty_graphs << '\n';
  std::cout << "candidate_rows=" << result.candidate_rows << '\n';
  std::cout << "greedy_fallbacks=" << result.greedy_fallbacks << '\n';
  std::cout << "matching_failures=" << result.matching_failures.size() << '\n';
}

bool sweep_passed(const SweepResult& result) {
  return result.parameter_cases == result.nonempty_graphs + result.empty_graphs &&
         result.matching_failures.empty();
}

int run_named_mode(const std::string& mode) {
  if (mode == "medium-grid") {
    const SweepResult result =
        run_grid(1001, 10000, 37, 53,
                 [](const Graph&, const std::vector<int>&) {});
    print_sweep(mode, result);
    const bool expected =
        result.parameter_cases == 4338 && result.nonempty_graphs == 4338 &&
        result.empty_graphs == 0 && result.candidate_rows == 3557016 &&
        result.greedy_fallbacks == 0;
    const bool pass = sweep_passed(result) && expected;
    std::cout << "expected_counts_match=" << expected << '\n';
    std::cout << "status=" << (pass ? "PASS" : "FAIL") << '\n';
    return pass ? 0 : 1;
  }

  if (mode == "endpoint-grid") {
    const SweepResult result = run_endpoints(1001, 20000);
    print_sweep(mode, result);
    const bool expected =
        result.parameter_cases == 19000 && result.nonempty_graphs == 19000 &&
        result.empty_graphs == 0 && result.candidate_rows == 49898384 &&
        result.greedy_fallbacks == 0;
    const bool pass = sweep_passed(result) && expected;
    std::cout << "expected_counts_match=" << expected << '\n';
    std::cout << "status=" << (pass ? "PASS" : "FAIL") << '\n';
    return pass ? 0 : 1;
  }

  if (mode == "high-grid") {
    const SweepResult result =
        run_grid(10001, 100000, 997, 997,
                 [](const Graph&, const std::vector<int>&) {});
    print_sweep(mode, result);
    const bool expected =
        result.parameter_cases == 887 && result.nonempty_graphs == 887 &&
        result.empty_graphs == 0 && result.candidate_rows == 7114873 &&
        result.greedy_fallbacks == 0;
    const bool pass = sweep_passed(result) && expected;
    std::cout << "expected_counts_match=" << expected << '\n';
    std::cout << "status=" << (pass ? "PASS" : "FAIL") << '\n';
    return pass ? 0 : 1;
  }

  if (mode == "n20000-analysis") {
    Graph graph = build_graph(20000, 10000);
    std::vector<int> owner;
    bool greedy = greedy_matching(graph, &owner);
    bool matching_ok = greedy;
    if (!matching_ok) matching_ok = exact_matching(graph, &owner);
    if (!matching_ok || !owner_is_saturating(graph, owner)) {
      std::cout << "mode=" << mode << '\n';
      std::cout << "status=FAIL\n";
      return 1;
    }
    materialize_adjacency(graph);
    i64 edges = 0;
    for (const auto& row : graph.adjacency) edges += row.size();
    const bool strict_hall = strict_hall_from_matching(graph, owner);
    const IntervalResult intervals = interval_stats(graph);

    std::cout << "mode=" << mode << '\n';
    std::cout << "candidate_rows=" << graph.candidates.size() << '\n';
    std::cout << "edges=" << edges << '\n';
    std::cout << "greedy_matching=" << greedy << '\n';
    std::cout << "strict_hall=" << strict_hall << '\n';
    std::cout << "contiguous_intervals=" << intervals.intervals_tested << '\n';
    std::cout << "minimum_contiguous_slack=" << intervals.minimum_slack << '\n';
    std::cout << "minimum_first_index=" << intervals.first_index << '\n';
    std::cout << "minimum_last_index=" << intervals.last_index << '\n';
    std::cout << "minimum_union_size=" << intervals.union_size << '\n';
    if (intervals.first_index >= 0) {
      std::cout << "minimum_first_candidate="
                << graph.candidates[intervals.first_index] << '\n';
      std::cout << "minimum_last_candidate="
                << graph.candidates[intervals.last_index] << '\n';
    }

    const bool expected =
        graph.candidates.size() == 5001 && edges == 22800241 && greedy &&
        strict_hall && intervals.intervals_tested == 12507501 &&
        intervals.minimum_slack == 1145 && intervals.first_index == 4910 &&
        intervals.last_index == 4910 && intervals.union_size == 1146;
    std::cout << "expected_counts_match=" << expected << '\n';
    std::cout << "status=" << (expected ? "PASS" : "FAIL") << '\n';
    return expected ? 0 : 1;
  }

  throw std::invalid_argument(
      "mode must be medium-grid, endpoint-grid, high-grid, or n20000-analysis");
}

}  // namespace

int main(int argc, char** argv) {
  try {
    if (argc != 2) {
      std::cerr << "usage: gamma_sweep_hardened MODE\n";
      return 2;
    }
    return run_named_mode(argv[1]);
  } catch (const std::exception& error) {
    std::cerr << "error: " << error.what() << '\n';
    return 2;
  }
}
