#include <algorithm>
#include <array>
#include <chrono>
#include <cstdint>
#include <cstdlib>
#include <iostream>
#include <numeric>
#include <vector>

using namespace std;

static inline int rho(int M, long long x) {
  int y = int(x % M);
  return min(y, M - y);
}

static uint64_t mix(uint64_t h, uint64_t x) {
  h ^= x + UINT64_C(0x9e3779b97f4a7c15) + (h << 6) + (h >> 2);
  return h;
}

struct Tables {
  int n, N, B, W;
  vector<uint16_t> one;
  vector<uint16_t> two;
  Tables(int nn, int BB) : n(nn), N(nn + 1), B(BB), W(BB + 1) {
    one.resize(size_t(W) * W);
    two.resize(size_t(W) * W * W);
    for (int A = 1; A <= B; ++A) {
      int M = N * A, words = (M + 63) / 64;
      vector<vector<uint64_t>> bits(W, vector<uint64_t>(words));
      for (int b = 1; b <= B; ++b) {
        for (int r = 1; r < M; ++r)
          if (r % N && rho(M, 1LL * b * r) < A)
            bits[b][r >> 6] |= UINT64_C(1) << (r & 63);
        int z = 0;
        for (uint64_t w : bits[b]) z += __builtin_popcountll(w);
        one[size_t(A) * W + b] = uint16_t(z);
      }
      for (int b = 1; b <= B; ++b)
        for (int c = b; c <= B; ++c) {
          int z = 0;
          for (int w = 0; w < words; ++w)
            z += __builtin_popcountll(bits[b][w] & bits[c][w]);
          two[(size_t(A) * W + b) * W + c] = uint16_t(z);
          two[(size_t(A) * W + c) * W + b] = uint16_t(z);
        }
    }
  }
  int C1(int A, int b) const { return one[size_t(A) * W + b]; }
  int C2(int A, int b, int c) const { return two[(size_t(A) * W + b) * W + c]; }
};

static long long qscore(const vector<int>& a, int j, const Tables& t) {
  int A = a[j], H0 = t.n * A, H1 = 0, H2 = 0;
  vector<int> o;
  for (int i = 0; i < t.n; ++i) if (i != j) {
    H1 += t.C1(A, a[i]);
    o.push_back(a[i]);
  }
  for (int x = 0; x < (int)o.size(); ++x)
    for (int y = x + 1; y < (int)o.size(); ++y)
      H2 += t.C2(A, o[x], o[y]);
  // Exact numerator after multiplying by alpha denominator.
  return t.n == 3 ? 49LL * (H0 - H1) + 48LL * H2
                  : 3LL * (H0 - H1) + 2LL * H2;
}

static bool primitive(const vector<int>& a) {
  int g = 0;
  for (int x : a) g = gcd(g, x);
  return g == 1;
}

static bool rec_scan(int at, int left, int maxv, vector<int>& a,
                     const Tables& t, uint64_t& count, uint64_t& hash) {
  if (left == 0) {
    if (a.back() != maxv || !primitive(a)) return false;
    ++count;
    vector<long long> q(t.n);
    bool fail = true;
    for (int j = 0; j < t.n; ++j) {
      q[j] = qscore(a, j, t);
      if (q[j] > 0) fail = false;
    }
    for (int x : a) hash = mix(hash, uint64_t(x));
    for (long long x : q) hash = mix(hash, uint64_t(x));
    if (fail) {
      cout << "FOUND n=" << t.n << " tuple=";
      for (int x : a) cout << x << ',';
      cout << " qscaled=";
      for (long long x : q) cout << x << ',';
      cout << "\n";
      return true;
    }
    return false;
  }
  for (int x = at; x <= maxv - left + 1; ++x) {
    a.push_back(x);
    if (rec_scan(x + 1, left - 1, maxv, a, t, count, hash)) return true;
    a.pop_back();
  }
  return false;
}

int main(int argc, char** argv) {
  int B = argc >= 2 ? atoi(argv[1]) : 120;
  for (int n : {3, 4}) {
    auto start = chrono::steady_clock::now();
    Tables t(n, B);
    uint64_t total = 0, hash = UINT64_C(0xcbf29ce484222325);
    for (int h = n; h <= B; ++h) {
      uint64_t count = 0;
      vector<int> a;
      bool found = rec_scan(1, n, h, a, t, count, hash);
      total += count;
      if (h <= 10 || h % 10 == 0 || found)
        cout << "shell n=" << n << " max=" << h << " primitive=" << count
             << " cumulative=" << total << " hash=" << hex << hash << dec << "\n";
      if (found) return 0;
    }
    double sec = chrono::duration<double>(chrono::steady_clock::now() - start).count();
    cout << "NO_FAILURE n=" << n << " max=" << B << " primitive=" << total
         << " hash=" << hex << hash << dec << " seconds=" << sec << "\n";
  }
}
