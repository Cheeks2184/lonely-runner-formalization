#include <algorithm>
#include <array>
#include <bit>
#include <bitset>
#include <cstdint>
#include <cstdlib>
#include <functional>
#include <iostream>
#include <limits>
#include <numeric>
#include <optional>
#include <set>
#include <sstream>
#include <stdexcept>
#include <string>
#include <tuple>
#include <utility>
#include <vector>

#ifndef SOURCE_SHA256
#define SOURCE_SHA256 "UNBOUND"
#endif

namespace {

using i64 = long long;
constexpr int SEARCH_MIN_N = 3;
constexpr int SEARCH_MAX_N = 7;
constexpr int SEARCH_MAX_SPEED = 24;
constexpr int SEARCH_MAX_MODULUS = (SEARCH_MAX_N + 1) * SEARCH_MAX_SPEED; // 192
using SearchBits = std::bitset<SEARCH_MAX_MODULUS>;

struct PivotData {
    int pivot_index{};
    i64 pivot_speed{};
    i64 modulus{};
    std::vector<int> R;
    std::vector<std::vector<int>> B; // global owner index; empty at diagonal
    std::vector<int> Q;
    int G{};
};

struct CoverData {
    std::vector<int> owners;
    bool complete{};
    bool minimal{};
    std::vector<std::vector<int>> private_sets; // global index; empty off cover
};

struct TupleData {
    std::vector<i64> speeds;
    int n{};
    int N{};
    std::vector<PivotData> pivots;
};

struct SearchPivot {
    int p{};
    int M{};
    SearchBits R;
    std::vector<SearchBits> B;
    SearchBits Q;
    int G{};
};

struct SearchStats {
    std::array<std::uint64_t, SEARCH_MAX_N + 1> primitive_tuples{};
    std::array<std::uint64_t, SEARCH_MAX_N + 1> covered_pivots{};
    std::array<std::uint64_t, SEARCH_MAX_N + 1> applicable_covers{};
    std::array<std::array<std::uint64_t, SEARCH_MAX_N + 1>, SEARCH_MAX_N + 1> applicable_by_size{};
    std::optional<std::string> first_failure_json;
};

struct BoundaryStats {
    std::uint64_t tuple_count{};
    std::uint64_t pivot_count{};
    std::uint64_t owner_pivot_pairs{};
    std::uint64_t candidate_membership_checks{};
    std::uint64_t excluded_multiple_checks{};
    std::uint64_t strict_p_minus_one_hits{};
    std::uint64_t equality_p_hits{};
    std::uint64_t reflection_checks{};
    std::uint64_t candidate_antipode_fixed_points{};
    std::uint64_t gcd_fiber_cases{};
    std::uint64_t coincident_owner_set_pairs{};
};

[[noreturn]] void fail(const std::string& message) {
    throw std::runtime_error(message);
}

int rho(i64 M, i64 x) {
    i64 t = x % M;
    if (t < 0) t += M;
    return static_cast<int>(std::min(t, M - t));
}

bool contains(const std::vector<int>& sorted, int x) {
    return std::binary_search(sorted.begin(), sorted.end(), x);
}

std::vector<int> set_union_many(const std::vector<std::vector<int>>& sets, const std::vector<int>& indices) {
    std::set<int> u;
    for (int idx : indices) u.insert(sets[idx].begin(), sets[idx].end());
    return {u.begin(), u.end()};
}

std::vector<int> set_difference_sorted(const std::vector<int>& a, const std::vector<int>& b) {
    std::vector<int> out;
    std::set_difference(a.begin(), a.end(), b.begin(), b.end(), std::back_inserter(out));
    return out;
}

TupleData compute_tuple(const std::vector<i64>& speeds) {
    TupleData out;
    out.speeds = speeds;
    out.n = static_cast<int>(speeds.size());
    out.N = out.n + 1;
    out.pivots.reserve(out.n);

    for (int j = 0; j < out.n; ++j) {
        PivotData pd;
        pd.pivot_index = j;
        pd.pivot_speed = speeds[j];
        pd.modulus = static_cast<i64>(out.N) * speeds[j];
        if (pd.modulus > std::numeric_limits<int>::max()) fail("modulus exceeds verifier integer serialization range");
        const int M = static_cast<int>(pd.modulus);
        pd.B.resize(out.n);

        for (int r = 0; r < M; ++r) {
            if (r % out.N != 0) pd.R.push_back(r);
        }
        std::vector<unsigned char> covered(M, 0);
        for (int i = 0; i < out.n; ++i) {
            if (i == j) continue;
            auto& bad = pd.B[i];
            for (int r : pd.R) {
                if (rho(pd.modulus, static_cast<i64>(r) * speeds[i]) < speeds[j]) {
                    bad.push_back(r);
                    covered[r] = 1;
                }
            }
        }
        for (int r : pd.R) if (!covered[r]) pd.Q.push_back(r);
        pd.G = static_cast<int>(pd.Q.size());
        out.pivots.push_back(std::move(pd));
    }
    return out;
}

CoverData evaluate_cover(const TupleData& td, int pivot, const std::vector<int>& owners) {
    CoverData out;
    out.owners = owners;
    out.private_sets.resize(td.n);
    const auto& pd = td.pivots[pivot];
    const auto union_all = set_union_many(pd.B, owners);
    out.complete = (union_all == pd.R);
    out.minimal = out.complete;
    if (!out.complete) return out;

    for (int i : owners) {
        std::vector<int> others;
        for (int h : owners) if (h != i) others.push_back(h);
        const auto union_others = set_union_many(pd.B, others);
        out.private_sets[i] = set_difference_sorted(pd.B[i], union_others);
        if (out.private_sets[i].empty()) out.minimal = false;
    }
    return out;
}

std::vector<CoverData> all_complete_covers(const TupleData& td, int pivot) {
    std::vector<int> owner_list;
    for (int i = 0; i < td.n; ++i) if (i != pivot) owner_list.push_back(i);
    const int m = static_cast<int>(owner_list.size());
    std::vector<CoverData> out;
    for (int mask = 1; mask < (1 << m); ++mask) {
        std::vector<int> owners;
        for (int k = 0; k < m; ++k) if (mask & (1 << k)) owners.push_back(owner_list[k]);
        auto c = evaluate_cover(td, pivot, owners);
        if (c.complete) out.push_back(std::move(c));
    }
    return out;
}

std::optional<CoverData> canonical_cover(const TupleData& td, int pivot) {
    auto covers = all_complete_covers(td, pivot);
    if (covers.empty()) return std::nullopt;
    auto key = [&](const CoverData& c) {
        std::vector<i64> values;
        for (int i : c.owners) values.push_back(td.speeds[i]);
        std::sort(values.begin(), values.end());
        return std::pair<std::size_t, std::vector<i64>>(c.owners.size(), values);
    };
    return *std::min_element(covers.begin(), covers.end(), [&](const CoverData& x, const CoverData& y) {
        return key(x) < key(y);
    });
}

void json_int_array(std::ostream& os, const std::vector<int>& xs) {
    os << '[';
    for (std::size_t k = 0; k < xs.size(); ++k) {
        if (k) os << ',';
        os << xs[k];
    }
    os << ']';
}

void json_i64_array(std::ostream& os, const std::vector<i64>& xs) {
    os << '[';
    for (std::size_t k = 0; k < xs.size(); ++k) {
        if (k) os << ',';
        os << xs[k];
    }
    os << ']';
}

void json_cover(std::ostream& os, const TupleData& td, int pivot, const CoverData& c) {
    os << '{';
    os << "\"owner_indices\":";
    json_int_array(os, c.owners);
    std::vector<i64> owner_speeds;
    for (int i : c.owners) owner_speeds.push_back(td.speeds[i]);
    os << ",\"owner_speeds\":";
    json_i64_array(os, owner_speeds);
    os << ",\"complete\":" << (c.complete ? "true" : "false");
    os << ",\"inclusion_minimal\":" << (c.minimal ? "true" : "false");
    os << ",\"applicable_to_frozen_target\":"
       << ((c.minimal && c.owners.size() >= 2 && c.owners.size() <= static_cast<std::size_t>(td.n / 2 + 1)) ? "true" : "false");
    os << ",\"owners\":[";
    for (std::size_t k = 0; k < c.owners.size(); ++k) {
        if (k) os << ',';
        const int i = c.owners[k];
        os << '{';
        os << "\"owner_index\":" << i << ",\"owner_speed\":" << td.speeds[i];
        os << ",\"private_set\":";
        json_int_array(os, c.private_sets[i]);
        os << ",\"owner_pivot_Q\":";
        json_int_array(os, td.pivots[i].Q);
        os << '}';
    }
    os << ']';
    os << ",\"pivot_index\":" << pivot << ",\"pivot_speed\":" << td.speeds[pivot];
    os << '}';
}

void json_tuple_record(std::ostream& os, const TupleData& td) {
    os << '{';
    os << "\"speeds\":";
    json_i64_array(os, td.speeds);
    os << ",\"n\":" << td.n << ",\"N\":" << td.N;
    i64 tuple_gcd = 0;
    for (i64 x : td.speeds) tuple_gcd = std::gcd(tuple_gcd, x);
    os << ",\"tuple_gcd\":" << tuple_gcd;
    os << ",\"SparseBound\":" << (td.n / 2 + 1);
    os << ",\"G\":[";
    for (int j = 0; j < td.n; ++j) {
        if (j) os << ',';
        os << td.pivots[j].G;
    }
    os << ']';
    os << ",\"pivots\":[";
    for (int j = 0; j < td.n; ++j) {
        if (j) os << ',';
        const auto& pd = td.pivots[j];
        os << '{';
        os << "\"pivot_index\":" << j << ",\"pivot_speed\":" << td.speeds[j]
           << ",\"M\":" << pd.modulus;
        os << ",\"R\":";
        json_int_array(os, pd.R);
        os << ",\"bad_sets\":[";
        bool first_bad = true;
        for (int i = 0; i < td.n; ++i) {
            if (i == j) continue;
            if (!first_bad) os << ',';
            first_bad = false;
            os << '{' << "\"owner_index\":" << i << ",\"owner_speed\":" << td.speeds[i] << ",\"residues\":";
            json_int_array(os, pd.B[i]);
            os << '}';
        }
        os << ']';
        os << ",\"Q\":";
        json_int_array(os, pd.Q);
        os << ",\"G\":" << pd.G;
        auto canon = canonical_cover(td, j);
        os << ",\"canonical_cover\":";
        if (!canon) {
            os << "null";
        } else {
            json_cover(os, td, j, *canon);
        }
        os << ",\"inclusion_minimal_complete_covers\":[";
        auto covers = all_complete_covers(td, j);
        bool first_cover = true;
        for (const auto& c : covers) {
            if (!c.minimal) continue;
            if (!first_cover) os << ',';
            first_cover = false;
            json_cover(os, td, j, c);
        }
        os << ']';
        os << '}';
    }
    os << ']';
    os << '}';
}

std::vector<SearchPivot> compute_search_tuple(const std::vector<int>& a) {
    const int n = static_cast<int>(a.size());
    const int N = n + 1;
    std::vector<SearchPivot> data(n);
    for (int j = 0; j < n; ++j) {
        auto& pd = data[j];
        pd.p = a[j];
        pd.M = N * a[j];
        pd.B.resize(n);
        for (int r = 0; r < pd.M; ++r) if (r % N != 0) pd.R.set(r);
        SearchBits u;
        for (int i = 0; i < n; ++i) {
            if (i == j) continue;
            for (int r = 0; r < pd.M; ++r) {
                if (r % N != 0 && rho(pd.M, static_cast<i64>(r) * a[i]) < a[j]) pd.B[i].set(r);
            }
            u |= pd.B[i];
        }
        pd.Q = pd.R & ~u;
        pd.G = static_cast<int>(pd.Q.count());
    }
    return data;
}

std::string search_failure_json(const std::vector<int>& a, int pivot, int owner_mask,
                                const std::vector<int>& owner_list,
                                const std::vector<SearchPivot>& data,
                                const std::vector<SearchBits>& subset_unions) {
    std::ostringstream os;
    const int n = static_cast<int>(a.size());
    os << '{';
    os << "\"tuple\":[";
    for (int k = 0; k < n; ++k) { if (k) os << ','; os << a[k]; }
    os << "],\"N\":" << (n + 1) << ",\"pivot_index\":" << pivot << ",\"pivot_speed\":" << a[pivot];
    os << ",\"F_indices\":[";
    bool first = true;
    for (int i = 0; i < n; ++i) if (data[i].G == 0) { if (!first) os << ','; first = false; os << i; }
    os << "],\"G\":[";
    for (int i = 0; i < n; ++i) { if (i) os << ','; os << data[i].G; }
    os << "],\"C_indices\":[";
    first = true;
    for (int k = 0; k < static_cast<int>(owner_list.size()); ++k) if (owner_mask & (1 << k)) {
        if (!first) os << ',';
        first = false;
        os << owner_list[k];
    }
    os << "],\"C_speeds\":[";
    first = true;
    for (int k = 0; k < static_cast<int>(owner_list.size()); ++k) if (owner_mask & (1 << k)) {
        if (!first) os << ',';
        first = false;
        os << a[owner_list[k]];
    }
    os << "],\"R\":[";
    first = true;
    for (int r = 0; r < data[pivot].M; ++r) if (data[pivot].R.test(r)) { if (!first) os << ','; first = false; os << r; }
    os << "],\"owners\":[";
    first = true;
    for (int k = 0; k < static_cast<int>(owner_list.size()); ++k) if (owner_mask & (1 << k)) {
        if (!first) os << ',';
        first = false;
        const int i = owner_list[k];
        os << '{' << "\"owner_index\":" << i << ",\"owner_speed\":" << a[i] << ",\"bad_set\":[";
        bool f2 = true;
        for (int r = 0; r < data[pivot].M; ++r) if (data[pivot].B[i].test(r)) { if (!f2) os << ','; f2 = false; os << r; }
        os << "],\"private_set\":[";
        const SearchBits priv = data[pivot].B[i] & ~subset_unions[owner_mask ^ (1 << k)];
        f2 = true;
        for (int r = 0; r < data[pivot].M; ++r) if (priv.test(r)) { if (!f2) os << ','; f2 = false; os << r; }
        os << "],\"owner_pivot_Q\":[";
        f2 = true;
        for (int r = 0; r < data[i].M; ++r) if (data[i].Q.test(r)) { if (!f2) os << ','; f2 = false; os << r; }
        os << "]}";
    }
    os << "]}";
    return os.str();
}

void inspect_search_tuple(const std::vector<int>& a, SearchStats& stats) {
    const int n = static_cast<int>(a.size());
    int tuple_gcd = 0;
    for (int x : a) tuple_gcd = std::gcd(tuple_gcd, x);
    if (tuple_gcd != 1) return;
    ++stats.primitive_tuples[n];

    const auto data = compute_search_tuple(a);
    for (int j = 0; j < n; ++j) {
        if (data[j].G != 0) continue;
        ++stats.covered_pivots[n];
        std::vector<int> owner_list;
        for (int i = 0; i < n; ++i) if (i != j) owner_list.push_back(i);
        const int m = static_cast<int>(owner_list.size());
        const int limit = 1 << m;
        std::vector<SearchBits> subset_unions(limit);
        for (int mask = 1; mask < limit; ++mask) {
            const int low = mask & -mask;
            const int k = std::countr_zero(static_cast<unsigned>(low));
            subset_unions[mask] = subset_unions[mask ^ low] | data[j].B[owner_list[k]];
        }
        for (int mask = 1; mask < limit; ++mask) { // deterministic bit-mask order
            const int size = std::popcount(static_cast<unsigned>(mask));
            if (size < 2 || size > n / 2 + 1) continue;
            if (subset_unions[mask] != data[j].R) continue;
            bool minimal = true;
            for (int k = 0; k < m; ++k) {
                if (!(mask & (1 << k))) continue;
                const SearchBits priv = data[j].B[owner_list[k]] & ~subset_unions[mask ^ (1 << k)];
                if (priv.none()) { minimal = false; break; }
            }
            if (!minimal) continue;
            ++stats.applicable_covers[n];
            ++stats.applicable_by_size[n][size];
            bool every_owner_covered = true;
            for (int k = 0; k < m; ++k) {
                if ((mask & (1 << k)) && data[owner_list[k]].G != 0) {
                    every_owner_covered = false;
                    break;
                }
            }
            if (every_owner_covered && !stats.first_failure_json) {
                stats.first_failure_json = search_failure_json(a, j, mask, owner_list, data, subset_unions);
                return;
            }
        }
    }
}

bool enumerate_search_tuples(int n, int pos, int next, std::vector<int>& tuple, SearchStats& stats) {
    if (stats.first_failure_json) return false;
    if (pos == n) {
        inspect_search_tuple(tuple, stats);
        return !stats.first_failure_json.has_value();
    }
    const int max_here = SEARCH_MAX_SPEED - (n - pos) + 1;
    for (int x = next; x <= max_here; ++x) {
        tuple[pos] = x;
        if (!enumerate_search_tuples(n, pos + 1, x + 1, tuple, stats)) return false;
    }
    return true;
}

SearchStats run_search() {
    SearchStats stats;
    for (int n = SEARCH_MIN_N; n <= SEARCH_MAX_N; ++n) {
        std::vector<int> tuple(n);
        if (!enumerate_search_tuples(n, 0, 1, tuple, stats)) break;
    }
    return stats;
}

std::vector<i64> permuted_scaled(const std::vector<i64>& base, const std::vector<int>& perm, int c) {
    std::vector<i64> out;
    out.reserve(base.size());
    for (int idx : perm) out.push_back(c * base[idx]);
    return out;
}

int find_speed_index(const std::vector<i64>& speeds, i64 speed) {
    for (int i = 0; i < static_cast<int>(speeds.size()); ++i) if (speeds[i] == speed) return i;
    return -1;
}

void verify_permutation_and_scaling(const TupleData& base, const TupleData& transformed, int c) {
    if (base.n != transformed.n || base.N != transformed.N) fail("permutation/scaling dimension mismatch");
    for (int j = 0; j < base.n; ++j) {
        const int tj = find_speed_index(transformed.speeds, c * base.speeds[j]);
        if (tj < 0) fail("scaled pivot label missing");
        const auto& p = base.pivots[j];
        const auto& tp = transformed.pivots[tj];
        if (tp.modulus != c * p.modulus) fail("scaled modulus mismatch");
        if (tp.G != c * p.G) fail("scaled G mismatch");
        for (int rp = 0; rp < tp.modulus; ++rp) {
            const int r = static_cast<int>(rp % p.modulus);
            if (contains(tp.R, rp) != contains(p.R, r)) fail("candidate lift mismatch");
            if (contains(tp.Q, rp) != contains(p.Q, r)) fail("Q lift mismatch");
            for (int i = 0; i < base.n; ++i) {
                if (i == j) continue;
                const int ti = find_speed_index(transformed.speeds, c * base.speeds[i]);
                if (ti < 0) fail("scaled owner label missing");
                if (contains(tp.B[ti], rp) != contains(p.B[i], r)) fail("owner-labelled badness lift mismatch");
            }
        }

        std::vector<int> owner_list;
        for (int i = 0; i < base.n; ++i) if (i != j) owner_list.push_back(i);
        const int m = static_cast<int>(owner_list.size());
        for (int mask = 1; mask < (1 << m); ++mask) {
            std::vector<int> C, tC;
            for (int k = 0; k < m; ++k) if (mask & (1 << k)) {
                C.push_back(owner_list[k]);
                const int ti = find_speed_index(transformed.speeds, c * base.speeds[owner_list[k]]);
                tC.push_back(ti);
            }
            const auto bc = evaluate_cover(base, j, C);
            const auto tc = evaluate_cover(transformed, tj, tC);
            if (bc.complete != tc.complete || bc.minimal != tc.minimal) fail("cover/minimality lift mismatch");
            if (bc.complete) {
                for (std::size_t k = 0; k < C.size(); ++k) {
                    const int i = C[k], ti = tC[k];
                    if (tc.private_sets[ti].size() != static_cast<std::size_t>(c) * bc.private_sets[i].size()) {
                        fail("private-set cardinality lift mismatch");
                    }
                    for (int rp : tc.private_sets[ti]) {
                        if (!contains(bc.private_sets[i], static_cast<int>(rp % p.modulus))) {
                            fail("private-set fiber lift mismatch");
                        }
                    }
                }
            }
        }

        const auto bc = canonical_cover(base, j);
        const auto tc = canonical_cover(transformed, tj);
        if (bc.has_value() != tc.has_value()) fail("canonical cover existence mismatch");
        if (bc) {
            std::vector<i64> bs, ts;
            for (int i : bc->owners) bs.push_back(c * base.speeds[i]);
            for (int i : tc->owners) ts.push_back(transformed.speeds[i]);
            std::sort(bs.begin(), bs.end());
            std::sort(ts.begin(), ts.end());
            if (bs != ts) fail("canonical cover label mismatch");
        }
    }
}

BoundaryStats verify_boundaries(const std::vector<TupleData>& tuples) {
    BoundaryStats stats;
    stats.tuple_count = tuples.size();
    for (const auto& td : tuples) {
        for (int j = 0; j < td.n; ++j) {
            ++stats.pivot_count;
            const auto& pd = td.pivots[j];
            const int M = static_cast<int>(pd.modulus);
            if (contains(pd.R, 0)) fail("r=0 incorrectly admitted");
            for (int r = 0; r < M; ++r) {
                const bool expected_candidate = (r % td.N != 0);
                if (contains(pd.R, r) != expected_candidate) fail("candidate grid mismatch");
                if (!expected_candidate) ++stats.excluded_multiple_checks;
            }
            if (M % 2 == 0) {
                const int antipode = M / 2;
                if (antipode % td.N != 0) {
                    ++stats.candidate_antipode_fixed_points;
                    if ((M - antipode) % M != antipode) fail("antipode not reflection-fixed");
                }
            }
            for (int i = 0; i < td.n; ++i) {
                if (i == j) continue;
                ++stats.owner_pivot_pairs;
                for (int r : pd.R) {
                    ++stats.candidate_membership_checks;
                    const int distance = rho(pd.modulus, static_cast<i64>(r) * td.speeds[i]);
                    const bool actual = contains(pd.B[i], r);
                    if (actual != (distance < td.speeds[j])) fail("strict badness implementation mismatch");
                    if (distance == td.speeds[j] - 1) {
                        ++stats.strict_p_minus_one_hits;
                        if (!actual) fail("rho=p-1 was not bad");
                    }
                    if (distance == td.speeds[j]) {
                        ++stats.equality_p_hits;
                        if (actual) fail("rho=p equality was incorrectly bad");
                    }
                    const int reflected = (M - r) % M;
                    ++stats.reflection_checks;
                    if (contains(pd.B[i], reflected) != actual) fail("bad set reflection mismatch");
                    if (contains(pd.Q, reflected) != contains(pd.Q, r)) fail("Q reflection mismatch");
                }

                const int g = static_cast<int>(std::gcd(td.speeds[i], pd.modulus));
                std::vector<int> fibers(M, 0);
                for (int r = 0; r < M; ++r) {
                    const int image = static_cast<int>((static_cast<i64>(r) * td.speeds[i]) % pd.modulus);
                    ++fibers[image];
                }
                for (int x = 0; x < M; ++x) {
                    const int expected = (x % g == 0) ? g : 0;
                    if (fibers[x] != expected) fail("gcd fiber multiplicity mismatch");
                }
                ++stats.gcd_fiber_cases;
            }
            for (int i = 0; i < td.n; ++i) for (int h = i + 1; h < td.n; ++h) {
                if (i == j || h == j) continue;
                if (pd.B[i] == pd.B[h]) ++stats.coincident_owner_set_pairs;
            }
        }
    }
    return stats;
}

std::uint64_t factorial(int n) {
    std::uint64_t out = 1;
    for (int k = 2; k <= n; ++k) out *= static_cast<std::uint64_t>(k);
    return out;
}

std::pair<std::uint64_t, std::uint64_t> run_invariance_suite(const std::vector<std::vector<i64>>& fixtures) {
    std::uint64_t permutations_checked = 0;
    std::uint64_t scaled_permutations_checked = 0;
    for (const auto& tuple : fixtures) {
        const auto base = compute_tuple(tuple);
        std::vector<int> perm(tuple.size());
        std::iota(perm.begin(), perm.end(), 0);
        do {
            ++permutations_checked;
            for (int c : {1, 2, 3}) {
                const auto transformed = compute_tuple(permuted_scaled(tuple, perm, c));
                verify_permutation_and_scaling(base, transformed, c);
                ++scaled_permutations_checked;
            }
        } while (std::next_permutation(perm.begin(), perm.end()));
    }
    return {permutations_checked, scaled_permutations_checked};
}

std::vector<std::tuple<int, int, i64, bool>> all_but_one_regression() {
    std::vector<std::tuple<int, int, i64, bool>> rows;
    for (int n = 2; n <= 12; ++n) {
        const int N = n + 1;
        i64 L = 1;
        for (int k = 1; k <= n - 1; ++k) L = std::lcm(L, static_cast<i64>(k));
        for (int m = 1; m <= 3; ++m) {
            const i64 P = static_cast<i64>(m) * N * L;
            bool pass = true;
            for (int k = 1; k <= n - 1; ++k) {
                if (P % (static_cast<i64>(N) * k) != 0) pass = false; // singleton cover of small pivot
            }
            const i64 r = P + 1;
            if (r % N == 0) pass = false;
            const i64 M = static_cast<i64>(N) * P;
            for (int k = 1; k <= n - 1; ++k) {
                if (rho(M, r * k) < P) pass = false;
            }
            rows.emplace_back(n, m, P, pass);
        }
    }
    return rows;
}

std::uint64_t choose_u64(int n, int k) {
    if (k < 0 || k > n) return 0;
    if (k > n - k) k = n - k;
    std::uint64_t out = 1;
    for (int i = 1; i <= k; ++i) out = out * static_cast<std::uint64_t>(n - k + i) / static_cast<std::uint64_t>(i);
    return out;
}

} // namespace

int main(int argc, char**) {
    if (argc != 1) {
        std::cerr << "malformed input: this deterministic verifier accepts no command-line arguments\n";
        return 64;
    }

    try {
        const std::vector<std::vector<i64>> fixtures = {
            {1,2,8},
            {1,3,4},
            {1,3,4,5},
            {1,2,3,5},
            {4,5,8},
            {4,5,32},
            {1,3,4,9,12},
            {1,6,11,12,13},
            {1,2,3,4,5,7},
            {1,3,13}
        };
        const std::vector<i64> counterexample = {6,7,12,24,144};

        std::vector<TupleData> fixture_data;
        for (const auto& f : fixtures) fixture_data.push_back(compute_tuple(f));
        const auto counterexample_data = compute_tuple(counterexample);

        auto boundary_inputs = fixture_data;
        boundary_inputs.push_back(counterexample_data);
        const auto boundary_stats = verify_boundaries(boundary_inputs);
        const auto [permutation_count, scaled_permutation_count] = run_invariance_suite(fixtures);
        const auto family_rows = all_but_one_regression();
        for (const auto& [n,m,P,pass] : family_rows) {
            (void)n; (void)m; (void)P;
            if (!pass) fail("all-but-one family regression failed");
        }

        const auto search = run_search();

        // Independently assert the explicit unrestricted counterexample.
        const int ce_pivot = find_speed_index(counterexample_data.speeds, 7);
        const std::vector<int> ce_owner_indices = {
            find_speed_index(counterexample_data.speeds, 6),
            find_speed_index(counterexample_data.speeds, 12),
            find_speed_index(counterexample_data.speeds, 24)
        };
        const auto ce_cover = evaluate_cover(counterexample_data, ce_pivot, ce_owner_indices);
        if (!ce_cover.complete || !ce_cover.minimal) fail("counterexample cover is not inclusion-minimal complete");
        if (ce_owner_indices.size() != static_cast<std::size_t>(counterexample_data.n / 2 + 1)) fail("counterexample sparse size mismatch");
        for (int i : ce_owner_indices) if (counterexample_data.pivots[i].G != 0) fail("counterexample selected owner is not covered");
        const int blocker = find_speed_index(counterexample_data.speeds, 144);
        for (int i : ce_owner_indices) {
            if (counterexample_data.speeds[blocker] % (static_cast<i64>(counterexample_data.N) * counterexample_data.speeds[i]) != 0) {
                fail("counterexample singleton divisibility missing");
            }
            if (counterexample_data.pivots[i].B[blocker] != counterexample_data.pivots[i].R) {
                fail("counterexample singleton blocker does not cover owner pivot");
            }
        }

        std::cout << '{';
        std::cout << "\"metadata\":{";
        std::cout << "\"verifier_id\":\"P78-SPARSE-MINIMAL-COVER-FRESH-CPP20-v1\"";
        std::cout << ",\"language\":\"C++20\"";
        std::cout << ",\"compiler_version\":\"" << __VERSION__ << "\"";
        std::cout << ",\"cplusplus\":" << __cplusplus;
        std::cout << ",\"source_sha256_binding\":\"" << SOURCE_SHA256 << "\"";
        std::cout << ",\"arithmetic\":\"signed 64-bit integer arithmetic; no floating point\"";
        std::cout << ",\"set_serialization\":\"strictly increasing JSON integer arrays; owner labels include both index and speed\"";
        std::cout << ",\"malformed_input_behavior\":\"any command-line argument emits an error and exits 64\"";
        std::cout << ",\"search_order\":\"n ascending; primitive strictly increasing tuples lexicographically; pivot index ascending; owner subset bit mask ascending\"";
        std::cout << ",\"early_stop_semantics\":\"the bounded search stops immediately after serializing the first failing owner subset; null means the entire declared domain was exhausted\"";
        std::cout << '}';

        std::cout << ",\"fixtures\":[";
        for (std::size_t k = 0; k < fixture_data.size(); ++k) {
            if (k) std::cout << ',';
            json_tuple_record(std::cout, fixture_data[k]);
        }
        std::cout << ']';

        std::cout << ",\"regression_tests\":{";
        std::cout << "\"permutation_invariance\":{";
        std::cout << "\"status\":\"pass\",\"fixture_permutations_checked\":" << permutation_count;
        std::cout << ",\"expected_fixture_permutations\":";
        std::uint64_t expected_perms = 0;
        for (const auto& f : fixtures) expected_perms += factorial(static_cast<int>(f.size()));
        std::cout << expected_perms << '}';
        std::cout << ",\"common_scaling_and_permutation\":{";
        std::cout << "\"status\":\"pass\",\"scale_factors\":[1,2,3],\"scaled_permutations_checked\":" << scaled_permutation_count << '}';
        std::cout << ",\"boundary_and_fiber_checks\":{";
        std::cout << "\"status\":\"pass\",\"tuple_count\":" << boundary_stats.tuple_count;
        std::cout << ",\"pivot_count\":" << boundary_stats.pivot_count;
        std::cout << ",\"owner_pivot_pairs\":" << boundary_stats.owner_pivot_pairs;
        std::cout << ",\"candidate_membership_checks\":" << boundary_stats.candidate_membership_checks;
        std::cout << ",\"excluded_N_multiple_checks\":" << boundary_stats.excluded_multiple_checks;
        std::cout << ",\"rho_equals_p_minus_one_hits\":" << boundary_stats.strict_p_minus_one_hits;
        std::cout << ",\"rho_equals_p_hits\":" << boundary_stats.equality_p_hits;
        std::cout << ",\"reflection_checks\":" << boundary_stats.reflection_checks;
        std::cout << ",\"candidate_antipode_fixed_points\":" << boundary_stats.candidate_antipode_fixed_points;
        std::cout << ",\"gcd_fiber_cases\":" << boundary_stats.gcd_fiber_cases;
        std::cout << ",\"coincident_owner_set_pairs\":" << boundary_stats.coincident_owner_set_pairs;
        std::cout << '}';
        std::cout << ",\"all_but_one_family_regression\":{";
        std::cout << "\"status\":\"pass\",\"finite_instances\":[";
        for (std::size_t k = 0; k < family_rows.size(); ++k) {
            if (k) std::cout << ',';
            const auto [n,m,P,pass] = family_rows[k];
            std::cout << '{' << "\"n\":" << n << ",\"m\":" << m << ",\"large_speed\":" << P << ",\"pass\":" << (pass ? "true" : "false") << '}';
        }
        std::cout << "]}";
        std::cout << '}';

        std::cout << ",\"bounded_falsification\":{";
        std::cout << "\"n_range\":[3,7],\"maximum_speed\":24,\"primitive_definition\":\"gcd of all speeds equals 1\"";
        std::cout << ",\"strictly_increasing\":true,\"floating_arithmetic\":false";
        std::cout << ",\"by_n\":[";
        for (int n = SEARCH_MIN_N; n <= SEARCH_MAX_N; ++n) {
            if (n != SEARCH_MIN_N) std::cout << ',';
            std::cout << '{' << "\"n\":" << n;
            std::cout << ",\"all_strictly_increasing_tuples\":" << choose_u64(SEARCH_MAX_SPEED, n);
            std::cout << ",\"primitive_tuples\":" << search.primitive_tuples[n];
            std::cout << ",\"covered_pivots\":" << search.covered_pivots[n];
            std::cout << ",\"applicable_sparse_minimal_covers\":" << search.applicable_covers[n];
            std::cout << ",\"applicable_by_size\":{";
            bool first = true;
            for (int size = 0; size <= SEARCH_MAX_N; ++size) if (search.applicable_by_size[n][size]) {
                if (!first) std::cout << ',';
                first = false;
                std::cout << '\"' << size << "\":" << search.applicable_by_size[n][size];
            }
            std::cout << "}}";
        }
        std::cout << ']';
        std::uint64_t total_primitive = 0, total_covered = 0, total_applicable = 0;
        for (int n = SEARCH_MIN_N; n <= SEARCH_MAX_N; ++n) {
            total_primitive += search.primitive_tuples[n];
            total_covered += search.covered_pivots[n];
            total_applicable += search.applicable_covers[n];
        }
        std::cout << ",\"total_primitive_tuples\":" << total_primitive;
        std::cout << ",\"total_covered_pivots\":" << total_covered;
        std::cout << ",\"total_applicable_sparse_minimal_covers\":" << total_applicable;
        std::cout << ",\"first_failure\":";
        if (search.first_failure_json) std::cout << *search.first_failure_json;
        else std::cout << "null";
        std::cout << '}';

        std::cout << ",\"unrestricted_counterexample\":{";
        std::cout << "\"status\":\"proved_by_exact_modular_certificate\",\"record\":";
        json_tuple_record(std::cout, counterexample_data);
        std::cout << ",\"selected_pivot_index\":" << ce_pivot << ",\"selected_pivot_speed\":7";
        std::cout << ",\"selected_cover\":";
        json_cover(std::cout, counterexample_data, ce_pivot, ce_cover);
        std::cout << ",\"singleton_blocker_index\":" << blocker << ",\"singleton_blocker_speed\":144";
        std::cout << ",\"divisibility_certificates\":[";
        for (std::size_t k = 0; k < ce_owner_indices.size(); ++k) {
            if (k) std::cout << ',';
            const int i = ce_owner_indices[k];
            std::cout << '{' << "\"owner_index\":" << i << ",\"owner_speed\":" << counterexample_data.speeds[i]
                      << ",\"N_times_owner_speed\":" << counterexample_data.N * counterexample_data.speeds[i]
                      << ",\"divides_144\":true}";
        }
        std::cout << ']';
        std::cout << ",\"frozen_conclusion_false\":true";
        std::cout << '}';

        std::cout << '}';
        std::cout << '\n';
        return 0;
    } catch (const std::exception& ex) {
        std::cerr << "verifier failure: " << ex.what() << '\n';
        return 1;
    }
}
