#include <algorithm>
#include <boost/multiprecision/cpp_int.hpp>
#include <cmath>
#include <cstdint>
#include <functional>
#include <iostream>
#include <numeric>
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
  // n >= 15 is the genuinely submaximal regime for this degree rule.
  scan_box(15, 20);
  scan_box(16, 20);
  scan_box(17, 21);
  scan_box(18, 22);
  scan_box(20, 24);
  return 0;
}

