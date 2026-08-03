// Independent exact enumerator for the PRO-C deletion/correlation audit.
// Implementation B uses C++ integer arithmetic, a separate rational type,
// OpenSSL EVP SHA-256, and a separate active-component graph implementation.

#include <openssl/evp.h>

#include <algorithm>
#include <cassert>
#include <cstdint>
#include <fstream>
#include <iomanip>
#include <iostream>
#include <numeric>
#include <set>
#include <sstream>
#include <stdexcept>
#include <string>
#include <tuple>
#include <utility>
#include <vector>

using i64 = long long;
using i128 = __int128_t;

static const char* VERSION = "PRO-C-IMPL-B-1.0.0";

static i64 abs64(i64 x) { return x < 0 ? -x : x; }

struct Rat {
    i64 n = 0;
    i64 d = 1;
    Rat() = default;
    Rat(i64 nn, i64 dd = 1) : n(nn), d(dd) {
        if (d == 0) throw std::runtime_error("zero denominator");
        if (d < 0) { n = -n; d = -d; }
        i64 g = std::gcd(abs64(n), d);
        n /= g;
        d /= g;
    }
    std::string str() const { return std::to_string(n) + "/" + std::to_string(d); }
};

static bool operator==(const Rat& a, const Rat& b) { return a.n == b.n && a.d == b.d; }
static bool operator!=(const Rat& a, const Rat& b) { return !(a == b); }
static bool operator<(const Rat& a, const Rat& b) {
    return (i128)a.n * b.d < (i128)b.n * a.d;
}
static Rat operator+(const Rat& a, const Rat& b) {
    i128 nn = (i128)a.n * b.d + (i128)b.n * a.d;
    i128 dd = (i128)a.d * b.d;
    if (nn < INT64_MIN || nn > INT64_MAX || dd > INT64_MAX) throw std::runtime_error("Rat add overflow");
    return Rat((i64)nn, (i64)dd);
}
static Rat operator/(const Rat& a, i64 q) {
    i128 dd = (i128)a.d * q;
    if (dd > INT64_MAX) throw std::runtime_error("Rat divide overflow");
    return Rat(a.n, (i64)dd);
}
static Rat mod1(Rat x) {
    i64 r = x.n % x.d;
    if (r < 0) r += x.d;
    return Rat(r, x.d);
}

static i64 imod(i64 x, i64 m) {
    i64 r = x % m;
    return r < 0 ? r + m : r;
}
static i64 rho(i64 m, i64 x) {
    i64 y = imod(x, m);
    return std::min(y, m - y);
}
static Rat dist_at(i64 speed, const Rat& t) {
    i128 prod = (i128)speed * t.n;
    i64 rem = (i64)(prod % t.d);
    if (rem < 0) rem += t.d;
    return Rat(std::min(rem, t.d - rem), t.d);
}

static std::vector<std::string> split(const std::string& s, char delim) {
    std::vector<std::string> out;
    std::stringstream ss(s);
    std::string item;
    while (std::getline(ss, item, delim)) out.push_back(item);
    return out;
}

template <class T>
static std::string join_nums(const std::vector<T>& xs, char delim = ',') {
    if (xs.empty()) return "-";
    std::ostringstream os;
    for (size_t i = 0; i < xs.size(); ++i) {
        if (i) os << delim;
        os << xs[i];
    }
    return os.str();
}
static std::string matrix_s(const std::vector<std::vector<i64>>& mat) {
    std::ostringstream os;
    for (size_t i = 0; i < mat.size(); ++i) {
        if (i) os << ';';
        for (size_t j = 0; j < mat[i].size(); ++j) {
            if (j) os << ',';
            os << mat[i][j];
        }
    }
    return os.str();
}

struct Sha256 {
    EVP_MD_CTX* ctx;
    Sha256() : ctx(EVP_MD_CTX_new()) {
        if (!ctx || EVP_DigestInit_ex(ctx, EVP_sha256(), nullptr) != 1) throw std::runtime_error("EVP init");
    }
    ~Sha256() { if (ctx) EVP_MD_CTX_free(ctx); }
    void update(const std::string& s) {
        if (EVP_DigestUpdate(ctx, s.data(), s.size()) != 1) throw std::runtime_error("EVP update");
    }
    std::string final_hex() {
        unsigned char md[EVP_MAX_MD_SIZE];
        unsigned int len = 0;
        if (EVP_DigestFinal_ex(ctx, md, &len) != 1) throw std::runtime_error("EVP final");
        std::ostringstream os;
        os << std::hex << std::setfill('0');
        for (unsigned int i = 0; i < len; ++i) os << std::setw(2) << (unsigned int)md[i];
        return os.str();
    }
};

struct CoreResult {
    std::string line;
    bool any_good;
};

static CoreResult analyze_core(int rid, const std::string& families, const std::vector<i64>& a) {
    int n = (int)a.size();
    int N = n + 1;
    std::vector<i64> cert_counts(n), good_counts(n), pivot_good_counts(n), empty_rows(n);
    std::vector<std::vector<i64>> deep(n, std::vector<i64>(n)), shell(n, std::vector<i64>(n));
    i64 cert_total = 0, good_total = 0;
    Sha256 hash;

    for (int j = 0; j < n; ++j) {
        i64 p = a[j], m = (i64)n * p;
        for (i64 r = 0; r < m; ++r) {
            if (r % n == 0) continue;
            std::vector<i64> vals(n);
            std::vector<int> bad;
            for (int i = 0; i < n; ++i) {
                vals[i] = rho(m, r * a[i]);
                if (vals[i] < p) bad.push_back(i);
            }
            if (std::find(bad.begin(), bad.end(), j) != bad.end()) throw std::runtime_error("pivot unsafe");
            std::vector<int> deletions;
            if (bad.empty()) {
                empty_rows[j]++;
                for (int k = 0; k < n; ++k) if (k != j) deletions.push_back(k);
            } else if (bad.size() == 1) {
                int k0 = bad[0];
                deletions.push_back(k0);
                if ((i64)N * vals[k0] < m) deep[j][k0]++;
                else shell[j][k0]++;
            }
            for (int k : deletions) {
                bool good = (i64)N * vals[k] >= m;
                cert_counts[k]++; cert_total++;
                if (good) { good_counts[k]++; pivot_good_counts[j]++; good_total++; }
                std::ostringstream payload;
                payload << k << ',' << j << ',' << r << ',' << p << ',' << vals[k] << ',' << (good ? 1 : 0) << ',';
                for (int i = 0; i < n; ++i) { if (i) payload << ','; payload << vals[i]; }
                payload << '\n';
                hash.update(payload.str());
            }
        }
    }

    i64 g = 0;
    for (i64 x : a) g = std::gcd(g, x);
    bool primitive = g == 1;
    bool residual = *std::max_element(a.begin(), a.end()) > N + N / 3;
    std::vector<int> ndiv;
    for (int i = 0; i < n; ++i) if (a[i] % N == 0) ndiv.push_back(i);
    bool all_nonempty = std::all_of(cert_counts.begin(), cert_counts.end(), [](i64 x){ return x > 0; });
    bool any_good = good_total > 0;

    std::ostringstream os;
    os << rid << '\t' << families << '\t' << n << '\t' << join_nums(a) << '\t'
       << (primitive ? 1 : 0) << '\t' << (residual ? 1 : 0) << '\t' << join_nums(ndiv) << '\t'
       << join_nums(cert_counts) << '\t' << join_nums(good_counts) << '\t' << join_nums(pivot_good_counts) << '\t'
       << cert_total << '\t' << good_total << '\t' << (all_nonempty ? 1 : 0) << '\t' << (any_good ? 1 : 0) << '\t'
       << join_nums(empty_rows) << '\t' << matrix_s(deep) << '\t' << matrix_s(shell) << '\t' << hash.final_hex();
    return {os.str(), any_good};
}

static std::set<Rat> boundary_times(int n, i64 speed) {
    std::set<Rat> out;
    i64 m = (i64)n * speed;
    for (i64 z = 0; z < speed; ++z) {
        out.emplace(1 + (i64)n * z, m);
        out.emplace((n - 1) + (i64)n * z, m);
    }
    return out;
}
static bool k_feasible(const std::vector<i64>& a, int k, const Rat& t) {
    int n = (int)a.size();
    Rat threshold(1, n);
    for (int i = 0; i < n; ++i) if (i != k && dist_at(a[i], t) < threshold) return false;
    return true;
}

struct DSU {
    std::vector<int> p;
    explicit DSU(int n) : p(n) { std::iota(p.begin(), p.end(), 0); }
    int find(int x) { return p[x] == x ? x : p[x] = find(p[x]); }
    void unite(int x, int y) { x = find(x); y = find(y); if (x != y) p[y] = x; }
};

static int component_count(const std::vector<i64>& a, int k, const std::vector<Rat>& bounds) {
    if (bounds.empty()) return k_feasible(a, k, Rat(0)) ? 1 : 0;
    int L = (int)bounds.size();
    std::vector<bool> point_ok(L), arc_ok(L);
    for (int q = 0; q < L; ++q) point_ok[q] = k_feasible(a, k, bounds[q]);
    for (int q = 0; q < L; ++q) {
        Rat right = bounds[(q + 1) % L];
        if (q == L - 1) right = right + Rat(1);
        Rat mid = mod1((bounds[q] + right) / 2);
        arc_ok[q] = k_feasible(a, k, mid);
    }
    std::vector<int> np(L, -1), na(L, -1);
    int nodes = 0;
    for (int q = 0; q < L; ++q) if (point_ok[q]) np[q] = nodes++;
    for (int q = 0; q < L; ++q) if (arc_ok[q]) na[q] = nodes++;
    if (!nodes) return 0;
    DSU dsu(nodes);
    for (int q = 0; q < L; ++q) if (arc_ok[q]) {
        int rr = (q + 1) % L;
        if (!point_ok[q] || !point_ok[rr]) throw std::runtime_error("feasible arc endpoint failure");
        dsu.unite(na[q], np[q]); dsu.unite(na[q], np[rr]);
    }
    std::set<int> roots;
    for (int q = 0; q < nodes; ++q) roots.insert(dsu.find(q));
    return (int)roots.size();
}

struct Edge {
    Rat t;
    int eps, j, s;
    i64 p, r, d, b, z, qv, R;
    Rat delta;
    int rev_full;
    std::vector<i64> rev_res;
    bool operator<(const Edge& x) const {
        if (t != x.t) return t < x.t;
        return std::tie(eps,j,s,p,r,d,b,z,qv,R,delta.n,delta.d,rev_full,rev_res)
             < std::tie(x.eps,x.j,x.s,x.p,x.r,x.d,x.b,x.z,x.qv,x.R,x.delta.n,x.delta.d,x.rev_full,x.rev_res);
    }
};

static std::vector<std::string> active_analysis_lines(int rid, const std::vector<i64>& a) {
    int n = (int)a.size(), N = n + 1;
    std::vector<std::string> out;
    for (int k = 0; k < n; ++k) {
        i64 ak = a[k];
        std::set<Rat> bset, candidates;
        candidates.insert(Rat(0));
        for (int i = 0; i < n; ++i) if (i != k) {
            auto bt = boundary_times(n, a[i]);
            bset.insert(bt.begin(), bt.end());
            candidates.insert(bt.begin(), bt.end());
        }
        for (i64 z = 0; z < ak; ++z) candidates.emplace(2 * z + 1, 2 * ak);
        std::vector<Rat> bounds(bset.begin(), bset.end());
        int comps = component_count(a, k, bounds);
        std::vector<Rat> feasible;
        for (const Rat& t : candidates) if (k_feasible(a, k, t)) feasible.push_back(t);
        if (feasible.empty()) {
            std::ostringstream os; os << rid << '\t' << k << '\t' << comps << "\tEMPTY\t-\t-\t-";
            out.push_back(os.str());
            continue;
        }
        Rat eta = dist_at(ak, feasible.front());
        for (const Rat& t : feasible) if (eta < dist_at(ak, t)) eta = dist_at(ak, t);
        std::vector<Rat> max_times;
        for (const Rat& t : feasible) if (dist_at(ak, t) == eta) max_times.push_back(t);

        std::vector<std::string> active_desc;
        std::set<Edge> edges;
        for (const Rat& t : max_times) {
            std::vector<int> active;
            for (int j = 0; j < n; ++j) if (j != k && dist_at(a[j], t) == Rat(1, n)) active.push_back(j);
            std::ostringstream ad; ad << t.str() << ':' << join_nums(active); active_desc.push_back(ad.str());

            i128 pkprod = (i128)ak * t.n;
            i64 remk = (i64)(pkprod % t.d); if (remk < 0) remk += t.d;
            std::vector<int> epsilons;
            if (remk == 0) epsilons = {-1, 1};
            else if ((i128)2 * remk < t.d) epsilons = {1};
            else if ((i128)2 * remk > t.d) epsilons = {-1};

            for (int eps : epsilons) for (int j : active) {
                i64 p = a[j];
                i64 remj = (i64)(((i128)p * t.n) % t.d); if (remj < 0) remj += t.d;
                int s = 0; bool decreases = false;
                if (n == 2 && (i128)2 * remj == t.d) { s = -eps; decreases = true; }
                else if ((i128)n * remj == t.d) { s = 1; decreases = eps == -1; }
                else if ((i128)n * remj == (i128)(n - 1) * t.d) { s = -1; decreases = eps == 1; }
                else throw std::runtime_error("active phase malformed");
                if (!decreases) continue;
                if (eps != -s) throw std::runtime_error("orientation mismatch");
                i64 m = (i64)n * p;
                i128 trnum = (i128)t.n * m;
                if (trnum % t.d != 0) throw std::runtime_error("noncanonical time");
                i64 r = imod((i64)(trnum / t.d), m);
                if (imod(r - s, n) != 0) throw std::runtime_error("wrong canonical class");
                std::vector<i64> vals(n);
                for (int i = 0; i < n; ++i) vals[i] = rho(m, r * a[i]);
                for (int i = 0; i < n; ++i) if (i != k && vals[i] < p) throw std::runtime_error("not certificate");
                i64 d = vals[k];
                i64 rawk = imod(r * ak, m);
                if (rawk != imod(-s * d, m)) throw std::runtime_error("signed residue failure");
                if ((ak + d) % n) throw std::runtime_error("b nonintegral");
                i64 b = (ak + d) / n;
                i64 z = (r - s) / n;
                i64 numq = z * ak + (i64)s * b;
                if (numq % p) throw std::runtime_error("q nonintegral");
                i64 qv = numq / p;
                i64 Rmod = (i64)N * ak;
                i64 R = imod((i64)N * qv - s, Rmod);
                Rat delta((i64)n * p - (i64)N * d, (i64)N * n * p * ak);
                std::vector<i64> rev_res(n);
                bool rev_full = true;
                for (int i = 0; i < n; ++i) { rev_res[i] = rho(Rmod, R * a[i]); if (rev_res[i] < ak) rev_full = false; }
                if (rev_res[k] != ak) throw std::runtime_error("deleted endpoint failure");
                if (rho(Rmod, R * p) != rho(Rmod, (i64)N * b - p)) throw std::runtime_error("pivot identity failure");
                edges.insert(Edge{t, eps, j, s, p, r, d, b, z, qv, R, delta, rev_full ? 1 : 0, rev_res});
            }
        }

        std::ostringstream mt, ads, eds;
        for (size_t q = 0; q < max_times.size(); ++q) { if (q) mt << ';'; mt << max_times[q].str(); }
        for (size_t q = 0; q < active_desc.size(); ++q) { if (q) ads << ';'; ads << active_desc[q]; }
        if (edges.empty()) eds << '-';
        else {
            bool first = true;
            for (const Edge& e : edges) {
                if (!first) eds << '|';
                first = false;
                eds << e.t.str() << ',' << e.eps << ',' << e.j << ',' << e.s << ',' << e.p << ',' << e.r << ','
                    << e.d << ',' << e.b << ',' << e.z << ',' << e.qv << ',' << e.R << ',' << e.delta.str() << ','
                    << e.rev_full << ',' << join_nums(e.rev_res);
            }
        }
        std::ostringstream line;
        line << rid << '\t' << k << '\t' << comps << '\t' << eta.str() << '\t' << mt.str() << '\t' << ads.str() << '\t' << eds.str();
        out.push_back(line.str());
    }
    return out;
}

int main(int argc, char** argv) {
    try {
        std::string root = argc > 1 ? argv[1] : ".";
        std::ifstream in(root + "/domain.tsv");
        if (!in) throw std::runtime_error("cannot open domain.tsv");
        std::ofstream core(root + "/impl_b_core.tsv"), active(root + "/impl_b_active.tsv");
        if (!core || !active) throw std::runtime_error("cannot open output");
        std::string line;
        int records = 0, active_tuples = 0, active_lines = 0;
        std::vector<int> ids;
        while (std::getline(in, line)) {
            auto fields = split(line, '\t');
            if (fields.size() != 3) throw std::runtime_error("bad domain line");
            int rid = std::stoi(fields[0]);
            std::vector<i64> a;
            for (const auto& x : split(fields[2], ',')) a.push_back(std::stoll(x));
            CoreResult cr = analyze_core(rid, fields[1], a);
            core << cr.line << '\n';
            records++;
            if (rid < 5 || !cr.any_good) {
                ids.push_back(rid); active_tuples++;
                auto als = active_analysis_lines(rid, a);
                for (const auto& x : als) { active << x << '\n'; active_lines++; }
            }
        }
        std::cout << VERSION << "\trecords=" << records << "\tactive_tuple_ids=" << active_tuples
                  << "\tactive_deletion_lines=" << active_lines << "\tids=" << join_nums(ids) << '\n';
    } catch (const std::exception& e) {
        std::cerr << "ERROR: " << e.what() << '\n';
        return 1;
    }
    return 0;
}
