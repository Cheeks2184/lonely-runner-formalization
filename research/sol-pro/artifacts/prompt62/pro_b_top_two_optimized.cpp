// Optimized independent exact evaluator for Prompt 62 PRO-B top-two criteria.
// It uses grouped circular cross-correlation for affine fibers rather than
// literal robust-pair enumeration.
#include <algorithm>
#include <cassert>
#include <cstdint>
#include <fstream>
#include <iostream>
#include <numeric>
#include <sstream>
#include <string>
#include <tuple>
#include <unordered_set>
#include <utility>
#include <vector>

using i64 = long long;
static const char* VERSION = "PROB-62-v1.0.0";

static int rho(int M, i64 x) {
    int y = int(x % M);
    if (y < 0) y += M;
    return std::min(y, M - y);
}

static i64 choose_small(int k, int q) {
    if (q == 0) return 1;
    if (k < q) return 0;
    if (q == 1) return k;
    if (q == 2) return i64(k) * (k - 1) / 2;
    if (q == 3) return i64(k) * (k - 1) * (k - 2) / 6;
    assert(false);
    return 0;
}

struct PivotData {
    int P = 0;
    int Q = 0;
    std::vector<int> safe;
    i64 fullH[4] = {0,0,0,0};
    i64 fullQ2 = 0;
    i64 fullQ3 = 0;
    std::vector<std::pair<int,int>> robust;
    i64 robustH[4] = {0,0,0,0};
    i64 robustQ2 = 0;
    i64 robustQ3 = 0;
    std::vector<i64> robustSlices;
    std::vector<std::vector<i64>> lowerBadSlices;
};

static PivotData pivot_data(const std::vector<int>& speeds, int pivot, int other_top) {
    const int n = int(speeds.size());
    const int N = n + 1;
    const int P = speeds[pivot];
    const int Q = speeds[other_top];
    const int M = N * P;
    std::vector<int> lower;
    for (int i = 0; i < n; ++i) if (i != pivot && i != other_top) lower.push_back(i);

    PivotData out;
    out.P = P;
    out.Q = Q;
    out.robustSlices.assign(N, 0);
    out.lowerBadSlices.assign(lower.size(), std::vector<i64>(N, 0));

    std::vector<uint8_t> flags(lower.size());
    for (int r = 0; r < M; ++r) {
        if (r % N == 0) continue;
        assert(rho(M, i64(r) * P) >= P);
        int lower_k = 0;
        for (size_t z = 0; z < lower.size(); ++z) {
            flags[z] = uint8_t(rho(M, i64(r) * speeds[lower[z]]) < P);
            lower_k += int(flags[z]);
        }
        const bool top_bad = rho(M, i64(r) * Q) < P;
        const int full_k = lower_k + int(top_bad);
        for (int q = 0; q < 4; ++q) out.fullH[q] += choose_small(full_k, q);
        if (full_k == 0) out.safe.push_back(r);
        if (!top_bad) {
            out.robust.push_back({r, lower_k});
            const int j = r % N;
            out.robustSlices[j]++;
            for (size_t z = 0; z < lower.size(); ++z) {
                if (flags[z]) out.lowerBadSlices[z][j]++;
            }
            for (int q = 0; q < 4; ++q) out.robustH[q] += choose_small(lower_k, q);
        }
    }
    assert(out.fullH[0] == i64(n) * P);
    assert(out.robustH[0] == i64(out.robust.size()));
    const int m_full = n - 1;
    out.fullQ2 = i64(m_full) * out.fullH[0] - i64(m_full) * out.fullH[1] + 2 * out.fullH[2];
    out.fullQ3 = out.fullH[0] - out.fullH[1] + out.fullH[2] - out.fullH[3];
    const int m_robust = n - 2;
    out.robustQ2 = (m_robust == 0)
        ? out.robustH[0]
        : i64(m_robust) * out.robustH[0] - i64(m_robust) * out.robustH[1] + 2 * out.robustH[2];
    out.robustQ3 = out.robustH[0] - out.robustH[1] + out.robustH[2] - out.robustH[3];
    return out;
}

static std::pair<i64,std::vector<i64>> slice_score(const PivotData& a, const PivotData& b) {
    const int N = int(a.robustSlices.size());
    assert(int(b.robustSlices.size()) == N);
    std::vector<i64> deficits;
    i64 best = 0;
    bool first = true;
    for (int j = 1; j < N; ++j) {
        i64 supply = a.robustSlices[j] + b.robustSlices[j];
        i64 incidence = 0;
        for (const auto& row : a.lowerBadSlices) incidence += row[j];
        for (const auto& row : b.lowerBadSlices) incidence += row[j];
        i64 d = supply - incidence;
        deficits.push_back(d);
        if (first || d > best) { best = d; first = false; }
    }
    if (deficits.empty()) best = 0;
    return {best, deficits};
}

static std::tuple<i64,int,i64,i64> affine_score_grouped(
        const std::vector<int>& speeds, const PivotData& a, const PivotData& b) {
    const int n = int(speeds.size());
    const int N = n + 1;
    const int A = a.P, B = b.P;
    assert(A < B);
    const int g = std::gcd(A, B);
    const int alpha = A / g, beta = B / g;
    const int L = N * g * alpha * beta;
    std::vector<i64> countA(L, 0), weightA(L, 0), countB(L, 0), weightB(L, 0);
    for (auto [r, k] : a.robust) {
        const int x = int((i64(beta) * r) % L);
        countA[x]++;
        weightA[x] += k;
    }
    for (auto [s, k] : b.robust) {
        const int y = int((i64(alpha) * s) % L);
        countB[y]++;
        weightB[y] += k;
    }
    std::vector<int> xs, ys;
    for (int x = 0; x < L; ++x) if (countA[x]) xs.push_back(x);
    for (int y = 0; y < L; ++y) if (countB[y]) ys.push_back(y);
    std::vector<i64> pairs(L, 0), unions(L, 0);
    for (int x : xs) {
        for (int y : ys) {
            int h = x - y;
            if (h < 0) h += L;
            pairs[h] += countA[x] * countB[y];
            unions[h] += weightA[x] * weightB[y];
        }
    }
    bool found = false;
    i64 best = 0;
    int best_h = 0;
    i64 best_p = 0, best_u = 0;
    for (int h = 0; h < L; ++h) {
        if (pairs[h] == 0) continue;
        i64 margin = pairs[h] - unions[h];
        if (!found || margin > best) {
            found = true;
            best = margin; best_h = h; best_p = pairs[h]; best_u = unions[h];
        }
    }
    if (!found) return {-1, -1, 0, 0};
    return {best, best_h, best_p, best_u};
}

static bool residual_flag(const std::vector<int>& speeds) {
    const int n = int(speeds.size());
    if (n < 2) return false;
    const int N = n + 1;
    const int A = speeds[n-2], B = speeds[n-1];
    if (!(B < n * A && 2 * B <= N * A)) return false;
    std::unordered_set<int> S(speeds.begin(), speeds.end());
    for (int q = B / 2 + 1; q <= N; ++q) if (!S.count(q)) return false;
    return true;
}

static std::vector<std::string> split(const std::string& s, char sep) {
    std::vector<std::string> out;
    std::string cur;
    for (char c : s) {
        if (c == sep) { out.push_back(cur); cur.clear(); }
        else cur.push_back(c);
    }
    out.push_back(cur);
    return out;
}

static std::string csv(const std::vector<int>& xs) {
    std::ostringstream o;
    for (size_t i = 0; i < xs.size(); ++i) { if (i) o << ','; o << xs[i]; }
    return o.str();
}
static std::string csv64(const std::vector<i64>& xs) {
    std::ostringstream o;
    for (size_t i = 0; i < xs.size(); ++i) { if (i) o << ','; o << xs[i]; }
    return o.str();
}
static std::string hcsv(const i64 h[4]) {
    std::ostringstream o;
    o << h[0] << ',' << h[1] << ',' << h[2] << ',' << h[3];
    return o.str();
}

int main(int argc, char** argv) {
    if (argc != 3) {
        std::cerr << "usage: pro_b_top_two_optimized MANIFEST OUTPUT\n";
        return 2;
    }
    std::ifstream in(argv[1]);
    if (!in) { std::cerr << "cannot open manifest\n"; return 2; }
    std::ofstream out(argv[2]);
    if (!out) { std::cerr << "cannot open output\n"; return 2; }
    out << "# version=" << VERSION << '\n';
    out << "# fields=id|category|name|speeds|N|A|B|safeA|firstA|safeB|firstB|"
           "fullQ2A|fullQ3A|fullQ2B|fullQ3B|robH_A|robQ2A|robQ3A|"
           "robH_B|robQ2B|robQ3B|sliceBest|sliceDeficits|"
           "affineMargin|affineH|affinePairs|affineUnion|residual\n";
    std::string line;
    while (std::getline(in, line)) {
        if (line.empty() || line[0] == '#') continue;
        auto f = split(line, '|');
        assert(f.size() == 4);
        auto nums = split(f[3], ',');
        std::vector<int> speeds;
        for (auto& z : nums) speeds.push_back(std::stoi(z));
        assert(std::is_sorted(speeds.begin(), speeds.end()));
        assert(std::adjacent_find(speeds.begin(), speeds.end()) == speeds.end());
        const int n = int(speeds.size()), N = n + 1;
        const int ia = n - 2, ib = n - 1;
        const int A = speeds[ia], B = speeds[ib];
        PivotData pa = pivot_data(speeds, ia, ib);
        PivotData pb = pivot_data(speeds, ib, ia);
        auto [sl_best, sl_vec] = slice_score(pa, pb);
        auto [af_margin, af_h, af_p, af_u] = affine_score_grouped(speeds, pa, pb);
        out << f[0] << '|' << f[1] << '|' << f[2] << '|' << csv(speeds)
            << '|' << N << '|' << A << '|' << B
            << '|' << pa.safe.size() << '|' << (pa.safe.empty() ? -1 : pa.safe.front())
            << '|' << pb.safe.size() << '|' << (pb.safe.empty() ? -1 : pb.safe.front())
            << '|' << pa.fullQ2 << '|' << pa.fullQ3 << '|' << pb.fullQ2 << '|' << pb.fullQ3
            << '|' << hcsv(pa.robustH) << '|' << pa.robustQ2 << '|' << pa.robustQ3
            << '|' << hcsv(pb.robustH) << '|' << pb.robustQ2 << '|' << pb.robustQ3
            << '|' << sl_best << '|' << csv64(sl_vec)
            << '|' << af_margin << '|' << af_h << '|' << af_p << '|' << af_u
            << '|' << (residual_flag(speeds) ? 1 : 0) << '\n';
    }
    return 0;
}
