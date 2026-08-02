#include <algorithm>
#include <boost/multiprecision/cpp_int.hpp>
#include <cmath>
#include <cstdint>
#include <functional>
#include <iostream>
#include <numeric>
#include <set>
#include <string>
#include <tuple>
#include <vector>

using boost::multiprecision::cpp_int;
using namespace std;

static int rho(int M, long long x) {
  int y = int(x % M);
  if (y < 0) y += M;
  return min(y, M - y);
}

static int chosen_degree(int n) {
  const int m = n - 1;
  long double x = sqrt((long double)m) / 2.0L * log((long double)(4LL * n * (n + 1)));
  return (int)ceill(x - 1e-18L);
}

// S_r(y,c) = c^r T_r(y/c), exactly integral.
static cpp_int scaled_chebyshev(int r, int y, int c) {
  if (r == 0) return cpp_int(1);
  if (r == 1) return cpp_int(y);
  cpp_int a = 1;
  cpp_int b = y;
  const cpp_int c2 = cpp_int(c) * c;
  for (int d = 2; d <= r; ++d) {
    cpp_int z = cpp_int(2) * y * b - c2 * a;
    a = b;
    b = z;
  }
  return b;
}

struct PolynomialData {
  int degree;
  cpp_int denominator;
  vector<cpp_int> numerators;
};

static PolynomialData polynomial_data(int n) {
  const int m = n - 1;
  const int c = m - 1;
  const int degree = chosen_degree(n);
  cpp_int c_pow = 1;
  for (int i = 0; i < degree; ++i) c_pow *= c;
  const cpp_int top = scaled_chebyshev(degree, m + 1, c);
  const cpp_int denominator = top - c_pow;
  if (denominator <= 0) throw runtime_error("nonpositive denominator");
  vector<cpp_int> nums(n);
  for (int k = 0; k < n; ++k) {
    nums[k] = scaled_chebyshev(degree, m + 1 - 2 * k, c) - c_pow;
  }
  if (nums[0] != denominator) throw runtime_error("P(0) != 1");
  for (int k = 1; k < n; ++k) {
    if (nums[k] > 0) throw runtime_error("P(k) positive");
  }
  return {degree, denominator, nums};
}

struct PivotRow {
  cpp_int score_num;
  int safe_count;
};

static PivotRow pivot_row(const vector<int>& a, int pivot, const PolynomialData& poly) {
  const int n = (int)a.size();
  const int N = n + 1;
  const int A = a[pivot];
  const int M = N * A;
  cpp_int score = 0;
  int safe = 0;
  for (int r = 1; r < M; ++r) {
    if (r % N == 0) continue;
    int k = 0;
    for (int i = 0; i < n; ++i) {
      if (i != pivot && rho(M, 1LL * a[i] * r) < A) ++k; // strict bad endpoint
    }
    score += poly.numerators[k];
    if (k == 0) ++safe;
  }
  return {score, safe};
}

static string int_to_string(const cpp_int& x) { return x.convert_to<string>(); }

static bool divisor_cover(const vector<int>& a) {
  for (int q = 2; q <= (int)a.size() + 1; ++q) {
    bool covered = false;
    for (int x : a) covered = covered || x % q == 0;
    if (!covered) return false;
  }
  return true;
}

static bool exact_failure(
    const vector<int>& a, const PolynomialData& poly,
    vector<PivotRow>* rows_out = nullptr) {
  vector<int> order(a.size());
  iota(order.begin(), order.end(), 0);
  sort(order.begin(), order.end(), [&](int i, int j) { return a[i] > a[j]; });
  vector<PivotRow> rows(a.size());
  for (int j : order) {
    rows[j] = pivot_row(a, j, poly);
    if (rows[j].score_num > 0) return false;
  }
  if (rows_out) *rows_out = rows;
  return true;
}

static void print_failure(
    const char* label, const vector<int>& a, const vector<PivotRow>& rows) {
  cout << label << " tuple=";
  for (int x : a) cout << x << ',';
  cout << " rows:";
  for (int j = 0; j < (int)a.size(); ++j)
    cout << " (" << a[j] << ',' << rows[j].score_num << ',' << rows[j].safe_count << ')';
  cout << "\n";
}

static void scan_multi_mutations() {
  const vector<int> seed = {11,13,16,18,20,21,24,28,30,35,36,40,42,60,120};
  const set<int> seed_set(seed.begin(), seed.end());
  const PolynomialData poly = polynomial_data(15);
  uint64_t generated = 0, primitive = 0, covered = 0, failures = 0;

  // Delete exactly two seed speeds and insert two distinct genuinely new
  // speeds from [2,100].  This is disjoint from the prior zero/one-coordinate
  // replacement family by construction.
  vector<int> available;
  for (int x = 2; x <= 100; ++x) if (!seed_set.count(x)) available.push_back(x);
  for (int i = 0; i < 15; ++i) for (int j = i + 1; j < 15; ++j)
    for (int u = 0; u < (int)available.size(); ++u)
      for (int v = u + 1; v < (int)available.size(); ++v) {
        vector<int> a;
        for (int k = 0; k < 15; ++k) if (k != i && k != j) a.push_back(seed[k]);
        a.push_back(available[u]); a.push_back(available[v]); sort(a.begin(), a.end());
        ++generated;
        int g = 0; for (int x : a) g = gcd(g, x);
        if (g != 1) continue;
        ++primitive;
        covered += divisor_cover(a);
        vector<PivotRow> rows;
        if (exact_failure(a, poly, &rows)) {
          ++failures;
          print_failure("EXACT_FAIL_TWO", a, rows);
        }
      }
  cout << "hc_seed_exact_two_replacements_new_2_to_100"
       << " generated=" << generated << " primitive=" << primitive
       << " divisor_cover=" << covered
       << " exact_all_pivot_failures=" << failures << "\n";

  // Delete exactly three seed speeds and insert three speeds from a disjoint,
  // divisor-rich/highly-composite pool.  Score only full q=2,...,16 covers.
  // Exclude tuples wholly contained in the old 20-speed exhaustive pool.
  const vector<int> add = {
    32,45,48,56,70,72,80,84,90,96,105,112,140,168,180,210,240,280,360,720};
  const set<int> old_pool = {
    11,13,16,18,20,21,24,28,30,32,35,36,40,42,45,48,60,72,120,720};
  generated = primitive = covered = failures = 0;
  uint64_t excluded_old_pool = 0;
  for (int i = 0; i < 15; ++i) for (int j = i + 1; j < 15; ++j)
    for (int k = j + 1; k < 15; ++k)
      for (int u = 0; u < (int)add.size(); ++u)
        for (int v = u + 1; v < (int)add.size(); ++v)
          for (int w = v + 1; w < (int)add.size(); ++w) {
            vector<int> a;
            for (int z = 0; z < 15; ++z)
              if (z != i && z != j && z != k) a.push_back(seed[z]);
            a.push_back(add[u]); a.push_back(add[v]); a.push_back(add[w]);
            sort(a.begin(), a.end()); ++generated;
            bool wholly_old = true;
            for (int x : a) wholly_old = wholly_old && old_pool.count(x);
            if (wholly_old) { ++excluded_old_pool; continue; }
            int g = 0; for (int x : a) g = gcd(g, x);
            if (g != 1) continue;
            ++primitive;
            if (!divisor_cover(a)) continue;
            ++covered;
            vector<PivotRow> rows;
            if (exact_failure(a, poly, &rows)) {
              ++failures;
              print_failure("EXACT_FAIL_THREE", a, rows);
            }
          }
  cout << "hc_seed_exact_three_replacements_add_pool"
       << " generated=" << generated
       << " excluded_old_pool=" << excluded_old_pool
       << " primitive_after_exclusion=" << primitive
       << " divisor_cover_scored=" << covered
       << " exact_all_pivot_failures=" << failures << "\n";
}

static void scan_box(int n, int max_speed) {
  const PolynomialData poly = polynomial_data(n);
  vector<int> a(n);
  uint64_t all = 0, primitive = 0, failures = 0;
  bool have_best = false;
  cpp_int best_max;
  vector<int> best_tuple;
  vector<PivotRow> best_rows;

  function<void(int,int)> rec = [&](int pos, int start) {
    if (pos == n) {
      ++all;
      int g = 0;
      for (int x : a) g = std::gcd(g, x);
      if (g != 1) return;
      ++primitive;
      vector<PivotRow> rows(n);
      cpp_int mx;
      bool first = true;
      bool all_nonpositive = true;
      for (int j = 0; j < n; ++j) {
        rows[j] = pivot_row(a, j, poly);
        if (first || rows[j].score_num > mx) { mx = rows[j].score_num; first = false; }
        if (rows[j].score_num > 0) all_nonpositive = false;
      }
      if (all_nonpositive) ++failures;
      if (!have_best || mx < best_max || (mx == best_max && a < best_tuple)) {
        have_best = true;
        best_max = mx;
        best_tuple = a;
        best_rows = rows;
      }
      return;
    }
    const int last = max_speed - (n - pos) + 1;
    for (int x = start; x <= last; ++x) {
      a[pos] = x;
      rec(pos + 1, x + 1);
    }
  };
  rec(0, 1);

  cout << "box n=" << n << " max=" << max_speed
       << " degree=" << poly.degree
       << " all=" << all << " primitive=" << primitive
       << " all_pivot_failures=" << failures << "\n";
  cout << "  denominator=" << int_to_string(poly.denominator) << "\n";
  cout << "  minimum_best_tuple=";
  for (int x : best_tuple) cout << x << ',';
  cout << "\n  best_score_numerator=" << int_to_string(best_max) << "\n";
  cout << "  pivot_rows=(speed,score_numerator,safe_count):";
  for (int j = 0; j < n; ++j) {
    cout << " (" << best_tuple[j] << ',' << int_to_string(best_rows[j].score_num)
         << ',' << best_rows[j].safe_count << ')';
  }
  cout << "\n";
}

int main() {
  scan_multi_mutations();
  return 0;
}
