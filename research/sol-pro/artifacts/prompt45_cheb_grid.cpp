#include <algorithm>
#include <array>
#include <cstdint>
#include <iostream>
#include <limits>
#include <numeric>
#include <string>
#include <vector>

using i128 = __int128_t;

static int rho(int M, long long x) {
  int y = static_cast<int>(x % M);
  return std::min(y, M - y);
}

static i128 ipow(i128 a, int e) {
  i128 z = 1;
  while (e-- > 0) z *= a;
  return z;
}

static i128 scaledT(int r, long long y, long long c) {
  if (r == 0) return 1;
  if (r == 1) return y;
  i128 a = 1, b = y, cc = static_cast<i128>(c) * c;
  for (int d = 2; d <= r; ++d) {
    i128 z = 2 * static_cast<i128>(y) * b - cc * a;
    a = b;
    b = z;
  }
  return b;
}

static std::string str128(i128 x) {
  if (x == 0) return "0";
  bool neg = x < 0;
  if (neg) x = -x;
  std::string s;
  while (x > 0) {
    s.push_back(char('0' + x % 10));
    x /= 10;
  }
  if (neg) s.push_back('-');
  std::reverse(s.begin(), s.end());
  return s;
}

static std::array<i128, 15> poly() {
  // n=15, prescribed degree r=13, common positive scaling 13^13.
  constexpr int n = 15, m = 14, r = 13, c = 13;
  i128 base = ipow(c, r);
  std::array<i128, n> p{};
  for (int k = 0; k < n; ++k)
    p[k] = scaledT(r, m + 1 - 2 * k, c) - base;
  return p;
}

static i128 pivotScore(const std::array<int, 15>& a, int pivot,
                       const std::array<i128, 15>& p) {
  constexpr int N = 16;
  int A = a[pivot], M = N * A;
  std::vector<unsigned char> count(M, 0);
  for (int i = 0; i < 15; ++i) if (i != pivot) {
    for (int r = 1; r < M; ++r) if (r % N != 0) {
      if (rho(M, 1LL * a[i] * r) < A) ++count[r]; // strict endpoint
    }
  }
  i128 score = 0;
  for (int r = 1; r < M; ++r) if (r % N != 0) score += p[count[r]];
  return score;
}

int main() {
  const std::array<int, 13> core =
      {1,3,4,5,6,8,9,14,24,30,42,56,168};
  const auto p = poly();
  long long tuples = 0;
  long long first_new_pivot_nonpositive = 0;
  long long both_new_pivots_nonpositive = 0;

  for (int x = 50; x <= 600; ++x) {
    for (int y = x + 1; y <= 600; ++y) {
      bool duplicate = false;
      for (int z : core) if (z == x || z == y) duplicate = true;
      if (duplicate) continue;

      std::array<int, 15> a{};
      for (int i = 0; i < 13; ++i) a[i] = core[i];
      a[13] = x;
      a[14] = y;
      std::sort(a.begin(), a.end());
      ++tuples;

      int ix = int(std::find(a.begin(), a.end(), x) - a.begin());
      i128 sx = pivotScore(a, ix, p);
      if (sx > 0) continue;
      ++first_new_pivot_nonpositive;

      int iy = int(std::find(a.begin(), a.end(), y) - a.begin());
      i128 sy = pivotScore(a, iy, p);
      if (sy > 0) continue;
      ++both_new_pivots_nonpositive;

      bool all_nonpositive = true;
      for (int j = 0; j < 15; ++j)
        if (pivotScore(a, j, p) > 0) { all_nonpositive = false; break; }
      if (all_nonpositive) {
        std::cout << "ALL_PIVOT_FAILURE\n";
        for (int z : a) std::cout << z << ',';
        std::cout << '\n';
        return 0;
      }
    }
  }

  std::cout << "domain=core_plus_two_distinct_speeds_50_through_600\n";
  std::cout << "tuples=" << tuples << '\n';
  std::cout << "all_pivot_failures=0\n";
  std::cout << "first_new_pivot_nonpositive="
            << first_new_pivot_nonpositive << '\n';
  std::cout << "both_new_pivots_nonpositive="
            << both_new_pivots_nonpositive << '\n';

}
