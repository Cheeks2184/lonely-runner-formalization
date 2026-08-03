#include <algorithm>
#include <array>
#include <cassert>
#include <chrono>
#include <cstdint>
#include <cstdlib>
#include <functional>
#include <iomanip>
#include <iostream>
#include <limits>
#include <numeric>
#include <optional>
#include <sstream>
#include <string>
#include <tuple>
#include <utility>
#include <vector>

using u64 = std::uint64_t;
using u128 = unsigned __int128;

static constexpr const char* CHECKER_VERSION = "prompt61-height-checker-v1.2.0";

struct Counts {
    u64 all_sorted = 0;
    u64 primitive = 0;
    u64 modulus_cover = 0;
    u64 fastest_ratio = 0;
    u64 fastest_interval = 0;
    u64 fastest_no_certificate = 0;
    u64 deletion_gcd = 0;
    u64 above_height_target = 0;
};

struct TupleKey {
    int n = 0;
    u64 maximum = 0;
    u64 sum = 0;
    std::vector<u64> tuple;
};

static TupleKey tuple_key(const std::vector<u64>& a) {
    return TupleKey{static_cast<int>(a.size()), a.back(),
                    std::accumulate(a.begin(), a.end(), u64{0}), a};
}

static bool tuple_key_less(const TupleKey& x, const TupleKey& y) {
    if (x.n != y.n) return x.n < y.n;
    if (x.maximum != y.maximum) return x.maximum < y.maximum;
    if (x.sum != y.sum) return x.sum < y.sum;
    return std::lexicographical_compare(x.tuple.begin(), x.tuple.end(),
                                        y.tuple.begin(), y.tuple.end());
}

static bool replacement_key_less(const std::vector<u64>& x,
                                 const std::vector<u64>& y) {
    const u64 xmax = x.back(), ymax = y.back();
    if (xmax != ymax) return xmax < ymax;
    const u64 xsum = std::accumulate(x.begin(), x.end(), u64{0});
    const u64 ysum = std::accumulate(y.begin(), y.end(), u64{0});
    if (xsum != ysum) return xsum < ysum;
    return std::lexicographical_compare(x.begin(), x.end(), y.begin(), y.end());
}

static std::string vec_string(const std::vector<u64>& a) {
    std::ostringstream os;
    os << "(";
    for (std::size_t i = 0; i < a.size(); ++i) {
        if (i) os << ",";
        os << a[i];
    }
    os << ")";
    return os.str();
}

static u64 gcd_all(const std::vector<u64>& a) {
    u64 g = 0;
    for (u64 x : a) g = std::gcd(g, x);
    return g;
}

static bool deletion_gcd_condition(const std::vector<u64>& a) {
    const std::size_t n = a.size();
    std::vector<u64> pref(n + 1, 0), suff(n + 1, 0);
    for (std::size_t i = 0; i < n; ++i) pref[i + 1] = std::gcd(pref[i], a[i]);
    for (std::size_t i = n; i-- > 0;) suff[i] = std::gcd(suff[i + 1], a[i]);
    for (std::size_t i = 0; i < n; ++i) {
        if (std::gcd(pref[i], suff[i + 1]) != 1) return false;
    }
    return true;
}

static u64 lcm_checked(u64 a, u64 b) {
    if (a == 0 || b == 0) return 0;
    u64 g = std::gcd(a, b);
    u128 z = static_cast<u128>(a / g) * b;
    if (z > std::numeric_limits<u64>::max()) {
        std::cerr << "LCM overflow\n";
        std::exit(3);
    }
    return static_cast<u64>(z);
}

static u64 cyclic_distance(u64 modulus, u64 product) {
    assert(modulus > 0);
    u64 r = product % modulus;
    return std::min(r, modulus - r);
}

static bool is_pivot_certificate(const std::vector<u64>& a, std::size_t pivot,
                                 u64 r, u64 N) {
    const u64 p = a[pivot];
    const u64 modulus = N * p;
    if (!(r < modulus) || r % N == 0) return false;
    for (std::size_t i = 0; i < a.size(); ++i) {
        if (i == pivot) continue;
        if (cyclic_distance(modulus, r * a[i]) < p) return false;
    }
    return true;
}

struct Certificate {
    std::size_t pivot = 0;
    u64 r = 0;
};

static std::optional<Certificate> first_certificate(const std::vector<u64>& a,
                                                    u64 N) {
    for (std::size_t p = 0; p < a.size(); ++p) {
        const u64 modulus = N * a[p];
        for (u64 r = 0; r < modulus; ++r) {
            if (is_pivot_certificate(a, p, r, N)) return Certificate{p, r};
        }
    }
    return std::nullopt;
}

static bool fastest_has_certificate(const std::vector<u64>& a, u64 N) {
    const std::size_t p = a.size() - 1;
    const u64 modulus = N * a[p];
    for (u64 r = 0; r < modulus; ++r) {
        if (is_pivot_certificate(a, p, r, N)) return true;
    }
    return false;
}

static bool modulus_cover_condition(const std::vector<u64>& a, u64 N) {
    for (u64 q = 2; q <= N; ++q) {
        bool found = false;
        for (u64 x : a) {
            if (x % q == 0) { found = true; break; }
        }
        if (!found) return false;
    }
    return true;
}

static bool fastest_ratio_condition(const std::vector<u64>& a, u64 N) {
    return (N - 1) * a.front() < a.back();
}

static bool fastest_interval_condition(const std::vector<u64>& a, u64 N) {
    const u64 slow = a.front();
    const u64 upper = a[a.size() - 2];
    const u64 fast = a.back();
    const u64 L = (fast + slow - 1) / slow;
    const u64 U = ((N - 1) * fast) / upper;
    return U < L || (U == L && L % N == 0);
}

static std::vector<u64> normalize_sorted(std::vector<u64> raw, u64& factor) {
    std::sort(raw.begin(), raw.end());
    factor = gcd_all(raw);
    assert(factor > 0);
    for (u64& x : raw) x /= factor;
    assert(gcd_all(raw) == 1);
    return raw;
}

static bool positive_injective(const std::vector<u64>& raw) {
    if (raw.empty()) return false;
    for (u64 x : raw) if (x == 0) return false;
    std::vector<u64> b = raw;
    std::sort(b.begin(), b.end());
    return std::adjacent_find(b.begin(), b.end()) == b.end();
}

struct Replacement {
    std::string operation;
    std::vector<u64> raw;
    std::vector<u64> normalized;
    u64 normalization_factor = 1;
    u64 old_top = 0;
    u64 new_value = 0;
    u64 parameter = 0;       // anchor for fixed signed; quotient for divisor signed
    u64 parameter2 = 0;      // lower LCM for mixed LCM
    int sign_lower = 0;      // +1 means a-b divisible; -1 means a+b divisible
    int sign_changed = 0;
};

static bool strictly_descends(const std::vector<u64>& old_a,
                              const std::vector<u64>& normalized_b) {
    return replacement_key_less(normalized_b, old_a);
}

static std::optional<Replacement> make_replacement(
        const std::string& name, const std::vector<u64>& a, u64 b,
        u64 parameter = 0, u64 parameter2 = 0,
        int sign_lower = 0, int sign_changed = 0) {
    if (b == 0 || b >= a.back()) return std::nullopt;
    std::vector<u64> raw(a.begin(), a.end() - 1);
    raw.push_back(b);
    if (!positive_injective(raw)) return std::nullopt;
    std::sort(raw.begin(), raw.end());
    u64 d = 1;
    std::vector<u64> norm = normalize_sorted(raw, d);
    if (!positive_injective(norm) || gcd_all(norm) != 1) return std::nullopt;
    if (!strictly_descends(a, norm)) return std::nullopt;
    return Replacement{name, raw, norm, d, a.back(), b, parameter, parameter2,
                       sign_lower, sign_changed};
}

static std::optional<Replacement> op_subtract_N(const std::vector<u64>& a) {
    const u64 N = a.size() + 1;
    if (a.back() <= N) return std::nullopt;
    return make_replacement("SUBTRACT_N", a, a.back() - N);
}

static std::optional<Replacement> op_fixed_signed(const std::vector<u64>& a) {
    const u64 N = a.size() + 1;
    const u64 top = a.back();
    std::optional<Replacement> best;
    for (std::size_t j = 0; j + 1 < a.size(); ++j) {
        const u64 anchor = a[j];
        const u64 modulus = N * anchor;
        const u64 rem = top % modulus;
        const u64 signed_rep = std::min(rem, modulus - rem);
        auto cand = make_replacement("FIXED_SIGNED_REP", a, signed_rep, anchor);
        if (!cand) continue;
        if (!best || replacement_key_less(cand->normalized, best->normalized) ||
            (cand->normalized == best->normalized && anchor < best->parameter)) {
            best = std::move(cand);
        }
    }
    return best;
}

static std::optional<Replacement> op_divisor_signed(const std::vector<u64>& a) {
    const u64 N = a.size() + 1;
    const u64 top = a.back();
    std::optional<Replacement> best;
    for (u64 b = 1; b < top; ++b) {
        if (top % b != 0) continue;
        const u64 q = top / b;
        if (q < 2 || std::gcd(q, N) != 1) continue;
        bool compatible = true;
        for (std::size_t i = 0; i + 1 < a.size(); ++i) {
            const u64 mod = N * a[i];
            const bool same = (top - b) % mod == 0;
            const bool opposite = (top + b) % mod == 0;
            if (!same && !opposite) { compatible = false; break; }
        }
        if (!compatible) continue;
        auto cand = make_replacement("DIVISOR_SIGNED_ALL_PIVOT", a, b, q);
        if (!cand) continue;
        if (!best || replacement_key_less(cand->normalized, best->normalized) ||
            (cand->normalized == best->normalized && b < best->new_value)) {
            best = std::move(cand);
        }
    }
    return best;
}

static std::optional<Replacement> op_lcm_mixed_signed(const std::vector<u64>& a) {
    const u64 N = a.size() + 1;
    const u64 top = a.back();
    u64 L = 1;
    for (std::size_t i = 0; i + 1 < a.size(); ++i) L = lcm_checked(L, a[i]);
    const u64 lower_mod = N * L;
    std::optional<Replacement> best;
    for (u64 b = 1; b < top; ++b) {
        int lower_sign = 0;
        if ((top - b) % lower_mod == 0) lower_sign = +1;
        else if ((top + b) % lower_mod == 0) lower_sign = -1;
        if (lower_sign == 0) continue;
        const u64 changed_mod = N * b;
        int changed_sign = 0;
        if ((top - b) % changed_mod == 0) changed_sign = +1;
        else if ((top + b) % changed_mod == 0) changed_sign = -1;
        if (changed_sign == 0) continue;
        auto cand = make_replacement("LCM_MIXED_SIGN_ALL_PIVOT", a, b, 0, L,
                                     lower_sign, changed_sign);
        if (!cand) continue;
        if (!best || replacement_key_less(cand->normalized, best->normalized) ||
            (cand->normalized == best->normalized && b < best->new_value)) {
            best = std::move(cand);
        }
    }
    return best;
}

struct AuditFailure {
    std::size_t normalized_pivot_index = 0;
    u64 normalized_pivot = 0;
    u64 raw_pivot = 0;
    u64 numerator = 0;
    u64 failed_speed = 0;
    u64 failed_distance = 0;
    std::vector<u64> all_distances;
};

struct AuditResult {
    bool passed = true;
    bool vacuous = true;
    u64 certificates_tested = 0;
    std::optional<AuditFailure> failure;
};

static AuditResult audit_reverse_every_certificate(const std::vector<u64>& original,
                                                   const Replacement& repl) {
    const u64 N = original.size() + 1;
    AuditResult out;
    for (std::size_t p = 0; p < repl.normalized.size(); ++p) {
        const u64 pn = repl.normalized[p];
        const u64 modulus_norm = N * pn;
        for (u64 r = 0; r < modulus_norm; ++r) {
            if (!is_pivot_certificate(repl.normalized, p, r, N)) continue;
            out.vacuous = false;
            ++out.certificates_tested;
            const u64 praw = pn * repl.normalization_factor;
            const u64 modulus_raw = N * praw;
            std::vector<u64> distances;
            distances.reserve(original.size());
            bool good = true;
            u64 failed_speed = 0, failed_dist = 0;
            for (u64 x : original) {
                const u64 d = cyclic_distance(modulus_raw, r * x);
                distances.push_back(d);
                if (good && d < praw) {
                    good = false;
                    failed_speed = x;
                    failed_dist = d;
                }
            }
            if (!good) {
                out.passed = false;
                out.failure = AuditFailure{p, pn, praw, r, failed_speed,
                                           failed_dist, distances};
                return out; // reject at first exact failure
            }
        }
    }
    return out;
}

struct OperationStats {
    u64 tuples_considered = 0;
    u64 defined = 0;
    u64 structurally_valid = 0;
    u64 reverse_pass_nonvacuous = 0;
    u64 reverse_pass_vacuous = 0;
    u64 reverse_fail = 0;
    u64 certificates_tested = 0;
};

struct RejectionRecord {
    TupleKey key;
    std::vector<u64> original;
    Replacement replacement;
    AuditFailure failure;
};

static bool rejection_less(const RejectionRecord& x, const RejectionRecord& y) {
    if (tuple_key_less(x.key, y.key)) return true;
    if (tuple_key_less(y.key, x.key)) return false;
    if (x.replacement.new_value != y.replacement.new_value)
        return x.replacement.new_value < y.replacement.new_value;
    if (x.replacement.parameter != y.replacement.parameter)
        return x.replacement.parameter < y.replacement.parameter;
    if (x.failure.raw_pivot != y.failure.raw_pivot)
        return x.failure.raw_pivot < y.failure.raw_pivot;
    if (x.failure.numerator != y.failure.numerator)
        return x.failure.numerator < y.failure.numerator;
    return x.failure.failed_speed < y.failure.failed_speed;
}

struct OpBundle {
    std::string name;
    std::function<std::optional<Replacement>(const std::vector<u64>&)> make;
    OperationStats stats;
    std::optional<RejectionRecord> smallest_rejection;
};

struct ResidualRecord {
    TupleKey key;
    std::vector<u64> tuple;
    std::optional<Certificate> certificate;
};

static void update_residual_min(std::optional<ResidualRecord>& slot,
                                const std::vector<u64>& a) {
    ResidualRecord rec{tuple_key(a), a, first_certificate(a, a.size() + 1)};
    if (!slot || tuple_key_less(rec.key, slot->key)) slot = std::move(rec);
}

static void audit_operation(OpBundle& op, const std::vector<u64>& a) {
    ++op.stats.tuples_considered;
    auto repl = op.make(a);
    if (!repl) return;
    ++op.stats.defined;
    const bool structural = positive_injective(repl->raw) &&
                            positive_injective(repl->normalized) &&
                            gcd_all(repl->normalized) == 1 &&
                            strictly_descends(a, repl->normalized);
    if (!structural) {
        std::cerr << "Internal structural invariant failure in " << op.name << "\n";
        std::exit(4);
    }
    ++op.stats.structurally_valid;
    AuditResult ar = audit_reverse_every_certificate(a, *repl);
    op.stats.certificates_tested += ar.certificates_tested;
    if (ar.passed) {
        if (ar.vacuous) ++op.stats.reverse_pass_vacuous;
        else ++op.stats.reverse_pass_nonvacuous;
    } else {
        ++op.stats.reverse_fail;
        RejectionRecord rr{tuple_key(a), a, *repl, *ar.failure};
        if (!op.smallest_rejection || rejection_less(rr, *op.smallest_rejection))
            op.smallest_rejection = std::move(rr);
    }
}


static std::optional<RejectionRecord> find_smallest_unfiltered_rejection(
        const std::function<std::optional<Replacement>(const std::vector<u64>&)>& make) {
    for (int n = 3; n <= 8; ++n) {
        const u64 N = n + 1;
        const u64 height_cap = N + N / 3;
        for (u64 maximum = static_cast<u64>(n); maximum <= 40; ++maximum) {
            if (maximum <= height_cap) continue;
            std::optional<RejectionRecord> best_at_fixed_n_max;
            std::vector<u64> a(n, 0);
            a[n - 1] = maximum;
            std::function<void(int,u64,u64)> rec;
            rec = [&](int pos, u64 next, u64 running_gcd) {
                if (pos == n - 1) {
                    if (running_gcd != 1) return;
                    auto repl = make(a);
                    if (!repl) return;
                    AuditResult ar = audit_reverse_every_certificate(a, *repl);
                    if (ar.passed) return;
                    RejectionRecord rr{tuple_key(a), a, *repl, *ar.failure};
                    if (!best_at_fixed_n_max || rejection_less(rr, *best_at_fixed_n_max))
                        best_at_fixed_n_max = std::move(rr);
                    return;
                }
                const int slots_after = (n - 1) - (pos + 1);
                const u64 max_choice = maximum - 1 - static_cast<u64>(slots_after);
                for (u64 x = next; x <= max_choice; ++x) {
                    a[pos] = x;
                    rec(pos + 1, x + 1, std::gcd(running_gcd, x));
                }
            };
            rec(0, 1, maximum);
            // All tuples with this fixed n and maximum were checked.  The
            // first maximum containing a failure is therefore globally least;
            // rejection_less selects least sum and then least sorted tuple.
            if (best_at_fixed_n_max) return best_at_fixed_n_max;
        }
    }
    return std::nullopt;
}

static std::string bool_string(bool b) { return b ? "true" : "false"; }

struct StressResult {
    std::string label;
    std::vector<u64> tuple;
    bool primitive = false;
    bool modulus_cover = false;
    bool fastest_ratio = false;
    bool fastest_interval = false;
    bool fastest_no_certificate = false;
    bool deletion_gcd = false;
    bool above_height = false;
    struct OneOp {
        std::string name;
        bool defined = false;
        std::optional<Replacement> replacement;
        std::optional<AuditResult> audit;
    };
    std::vector<OneOp> operations;
};

int main(int argc, char** argv) {
    std::string source_sha = "UNSPECIFIED";
    for (int i = 1; i < argc; ++i) {
        std::string arg = argv[i];
        const std::string prefix = "--source-sha=";
        if (arg.rfind(prefix, 0) == 0) source_sha = arg.substr(prefix.size());
    }

    const auto start_time = std::chrono::steady_clock::now();

    std::array<Counts, 9> by_n{};
    Counts total{};

    std::vector<OpBundle> ops;
    ops.push_back(OpBundle{"SUBTRACT_N", op_subtract_N});
    ops.push_back(OpBundle{"FIXED_SIGNED_REP", op_fixed_signed});
    ops.push_back(OpBundle{"DIVISOR_SIGNED_ALL_PIVOT", op_divisor_signed});
    ops.push_back(OpBundle{"LCM_MIXED_SIGN_ALL_PIVOT", op_lcm_mixed_signed});

    std::optional<ResidualRecord> smallest_high_residual;
    std::optional<ResidualRecord> smallest_uncovered_by_survivors;
    std::vector<std::vector<u64>> fastest_no_certificate_tuples;
    std::vector<std::vector<u64>> deletion_gcd_tuples;
    u64 union_survivor_defined = 0;
    std::array<u64, 9> union_survivor_by_n{};

    std::vector<u64> tuple;

    for (int n = 3; n <= 8; ++n) {
        const u64 N = n + 1;
        const u64 height_cap = N + N / 3;
        for (u64 maximum = static_cast<u64>(n); maximum <= 40; ++maximum) {
            tuple.assign(n, 0);
            tuple[n - 1] = maximum;
            std::function<void(int,u64,u64,u64)> rec;
            rec = [&](int pos, u64 next, u64 running_gcd, u64 running_sum) {
                if (pos == n - 1) {
                    Counts& c = by_n[n];
                    ++c.all_sorted; ++total.all_sorted;
                    if (running_gcd != 1) return;
                    ++c.primitive; ++total.primitive;
                    if (!modulus_cover_condition(tuple, N)) return;
                    ++c.modulus_cover; ++total.modulus_cover;
                    if (!fastest_ratio_condition(tuple, N)) return;
                    ++c.fastest_ratio; ++total.fastest_ratio;
                    if (!fastest_interval_condition(tuple, N)) return;
                    ++c.fastest_interval; ++total.fastest_interval;
                    if (fastest_has_certificate(tuple, N)) return;
                    ++c.fastest_no_certificate; ++total.fastest_no_certificate;
                    fastest_no_certificate_tuples.push_back(tuple);
                    if (!deletion_gcd_condition(tuple)) return;
                    ++c.deletion_gcd; ++total.deletion_gcd;
                    deletion_gcd_tuples.push_back(tuple);
                    if (maximum <= height_cap) return;
                    ++c.above_height_target; ++total.above_height_target;
                    update_residual_min(smallest_high_residual, tuple);

                    bool div_defined = static_cast<bool>(op_divisor_signed(tuple));
                    bool lcm_defined = static_cast<bool>(op_lcm_mixed_signed(tuple));
                    if (div_defined || lcm_defined) {
                        ++union_survivor_defined;
                        ++union_survivor_by_n[n];
                    } else {
                        update_residual_min(smallest_uncovered_by_survivors, tuple);
                    }
                    for (auto& op : ops) audit_operation(op, tuple);
                    return;
                }
                const int slots_after = (n - 1) - (pos + 1);
                const u64 max_choice = maximum - 1 - static_cast<u64>(slots_after);
                for (u64 x = next; x <= max_choice; ++x) {
                    tuple[pos] = x;
                    rec(pos + 1, x + 1, std::gcd(running_gcd, x), running_sum + x);
                }
            };
            rec(0, 1, maximum, maximum);
        }
    }

    // Mandatory and historical stress suite. Consecutive rows are included for every n=3..8.
    std::vector<std::pair<std::string,std::vector<u64>>> stresses;
    for (int n = 3; n <= 8; ++n) {
        std::vector<u64> a(n);
        std::iota(a.begin(), a.end(), u64{1});
        stresses.push_back({"consecutive_n" + std::to_string(n), a});
    }
    stresses.push_back({"explicit_1_3_4_7", {1,3,4,7}});
    stresses.push_back({"explicit_1_2_3_60", {1,2,3,60}});
    stresses.push_back({"constructed_lcm_1_3_10", {1,3,10}});
    stresses.push_back({"explicit_1_2_6_8_10", {1,2,6,8,10}});
    stresses.push_back({"signed_example_4_6_24", {4,6,24}});
    stresses.push_back({"tracked_E", {5,28,35,40,68,88,108,148,165}});
    stresses.push_back({"tracked_F", {8,15,35,40,48,56,75,132,147}});
    stresses.push_back({"tracked_G", {15,21,40,48,56,105,126,280,1200}});
    stresses.push_back({"prior_1_9_10_11_12", {1,9,10,11,12}});
    stresses.push_back({"prior_1_2_3_4_5_7", {1,2,3,4,5,7}});
    stresses.push_back({"closest_10_speed", {1,2,3,4,5,6,7,8,9,11}});

    std::vector<StressResult> stress_results;
    for (const auto& [label, input] : stresses) {
        std::vector<u64> a = input;
        std::sort(a.begin(), a.end());
        const u64 N = a.size() + 1;
        StressResult sr;
        sr.label = label;
        sr.tuple = a;
        sr.primitive = gcd_all(a) == 1;
        sr.modulus_cover = modulus_cover_condition(a, N);
        sr.fastest_ratio = fastest_ratio_condition(a, N);
        sr.fastest_interval = fastest_interval_condition(a, N);
        sr.fastest_no_certificate = !fastest_has_certificate(a, N);
        sr.deletion_gcd = deletion_gcd_condition(a);
        sr.above_height = a.back() > N + N / 3;
        for (const auto& op : ops) {
            StressResult::OneOp oo;
            oo.name = op.name;
            oo.replacement = op.make(a);
            oo.defined = static_cast<bool>(oo.replacement);
            if (oo.replacement) oo.audit = audit_reverse_every_certificate(a, *oo.replacement);
            sr.operations.push_back(std::move(oo));
        }
        stress_results.push_back(std::move(sr));
    }

    const auto smallest_subtract_rejection =
        find_smallest_unfiltered_rejection(op_subtract_N);
    const auto smallest_fixed_signed_rejection =
        find_smallest_unfiltered_rejection(op_fixed_signed);

    const auto end_time = std::chrono::steady_clock::now();
    const auto runtime_us = std::chrono::duration_cast<std::chrono::microseconds>(end_time - start_time).count();

    std::cout << "checker_version=" << CHECKER_VERSION << "\n";
    std::cout << "source_sha256=" << source_sha << "\n";
    std::cout << "compiler=" << __VERSION__ << "\n";
    std::cout << "integer_model=uint64_with_uint128_checked_lcm\n";
    std::cout << "domain=n_ascending_3_to_8;maximum_ascending_n_to_40;lower_tuple_lexicographic\n";
    std::cout << "smallest_record_order=(n,maximum,sum,sorted_tuple,operation_parameter,pivot,numerator,failed_coordinate)\n";
    std::cout << "closed_boundary=good_iff_cyclic_distance_greater_or_equal_pivot;bad_iff_strictly_less\n";
    std::cout << "runtime_microseconds=" << runtime_us << "\n";
    std::cout << "\n[stage_counts]\n";
    std::cout << "n,all_sorted,primitive,modulus_cover,fastest_ratio,fastest_interval,fastest_no_certificate,deletion_gcd,above_height_target\n";
    for (int n = 3; n <= 8; ++n) {
        const Counts& c = by_n[n];
        std::cout << n << ',' << c.all_sorted << ',' << c.primitive << ','
                  << c.modulus_cover << ',' << c.fastest_ratio << ','
                  << c.fastest_interval << ',' << c.fastest_no_certificate << ','
                  << c.deletion_gcd << ',' << c.above_height_target << "\n";
    }
    std::cout << "total," << total.all_sorted << ',' << total.primitive << ','
              << total.modulus_cover << ',' << total.fastest_ratio << ','
              << total.fastest_interval << ',' << total.fastest_no_certificate << ','
              << total.deletion_gcd << ',' << total.above_height_target << "\n";
    std::cout << "fastest_no_certificate_tuples=";
    for (std::size_t i = 0; i < fastest_no_certificate_tuples.size(); ++i) {
        if (i) std::cout << ';';
        std::cout << vec_string(fastest_no_certificate_tuples[i]);
    }
    if (fastest_no_certificate_tuples.empty()) std::cout << "NONE";
    std::cout << "\n";
    std::cout << "deletion_gcd_tuples=";
    for (std::size_t i = 0; i < deletion_gcd_tuples.size(); ++i) {
        if (i) std::cout << ';';
        std::cout << vec_string(deletion_gcd_tuples[i]);
    }
    if (deletion_gcd_tuples.empty()) std::cout << "NONE";
    std::cout << "\n";

    std::cout << "\n[operation_counts_on_above_height_residual]\n";
    std::cout << "operation,tuples_considered,defined,structurally_valid,reverse_pass_nonvacuous,reverse_pass_vacuous,reverse_fail,certificates_tested\n";
    for (const auto& op : ops) {
        const auto& s = op.stats;
        std::cout << op.name << ',' << s.tuples_considered << ',' << s.defined << ','
                  << s.structurally_valid << ',' << s.reverse_pass_nonvacuous << ','
                  << s.reverse_pass_vacuous << ',' << s.reverse_fail << ','
                  << s.certificates_tested << "\n";
    }
    std::cout << "surviving_operation_union_defined=" << union_survivor_defined << "\n";
    for (int n = 3; n <= 8; ++n)
        std::cout << "surviving_operation_union_defined_n" << n << '=' << union_survivor_by_n[n] << "\n";

    auto print_residual = [&](const std::string& label, const std::optional<ResidualRecord>& rec) {
        std::cout << label << "=";
        if (!rec) { std::cout << "NONE\n"; return; }
        std::cout << vec_string(rec->tuple);
        if (rec->certificate) {
            std::cout << ";first_global_certificate_pivot="
                      << rec->tuple[rec->certificate->pivot]
                      << ";r=" << rec->certificate->r;
        } else {
            std::cout << ";first_global_certificate=NONE";
        }
        std::cout << "\n";
    };
    print_residual("smallest_above_height_residual", smallest_high_residual);
    print_residual("smallest_uncovered_by_surviving_operations", smallest_uncovered_by_survivors);

    std::cout << "\n[smallest_rejections]\n";
    for (const auto& op : ops) {
        std::cout << "operation=" << op.name << "\n";
        if (!op.smallest_rejection) {
            std::cout << "status=NO_REJECTION_IN_FILTERED_DOMAIN\n";
            continue;
        }
        const RejectionRecord& rr = *op.smallest_rejection;
        const AuditFailure& f = rr.failure;
        std::cout << "status=REJECTED\n";
        std::cout << "original=" << vec_string(rr.original) << "\n";
        std::cout << "replacement_raw=" << vec_string(rr.replacement.raw) << "\n";
        std::cout << "normalization_factor=" << rr.replacement.normalization_factor << "\n";
        std::cout << "replacement_normalized=" << vec_string(rr.replacement.normalized) << "\n";
        std::cout << "new_value=" << rr.replacement.new_value << "\n";
        std::cout << "operation_parameter=" << rr.replacement.parameter << "\n";
        std::cout << "certificate_on_normalized_replacement_pivot=" << f.normalized_pivot
                  << ";raw_pivot=" << f.raw_pivot << ";r=" << f.numerator << "\n";
        std::cout << "failed_original_speed=" << f.failed_speed
                  << ";cyclic_distance=" << f.failed_distance
                  << ";required=" << f.raw_pivot << "\n";
        std::cout << "all_original_distances=" << vec_string(f.all_distances) << "\n";
    }

    std::cout << "\n[smallest_unfiltered_rejections]\n";
    auto print_unfiltered_rejection = [&](const std::string& name,
                                          const std::optional<RejectionRecord>& rec) {
        std::cout << "operation=" << name << "\n";
        if (!rec) {
            std::cout << "status=NO_REJECTION_IN_DECLARED_DOMAIN\n";
            return;
        }
        const auto& rr = *rec;
        const auto& f = rr.failure;
        std::cout << "status=REJECTED\n";
        std::cout << "original=" << vec_string(rr.original) << "\n";
        std::cout << "replacement_raw=" << vec_string(rr.replacement.raw) << "\n";
        std::cout << "normalization_factor=" << rr.replacement.normalization_factor << "\n";
        std::cout << "replacement_normalized=" << vec_string(rr.replacement.normalized) << "\n";
        std::cout << "new_value=" << rr.replacement.new_value
                  << ";operation_parameter=" << rr.replacement.parameter << "\n";
        std::cout << "certificate_on_normalized_replacement_pivot=" << f.normalized_pivot
                  << ";raw_pivot=" << f.raw_pivot << ";r=" << f.numerator << "\n";
        std::cout << "failed_original_speed=" << f.failed_speed
                  << ";cyclic_distance=" << f.failed_distance
                  << ";required=" << f.raw_pivot << "\n";
        std::cout << "all_original_distances=" << vec_string(f.all_distances) << "\n";
    };
    print_unfiltered_rejection("SUBTRACT_N", smallest_subtract_rejection);
    print_unfiltered_rejection("FIXED_SIGNED_REP", smallest_fixed_signed_rejection);

    std::cout << "\n[stress_suite]\n";
    for (const auto& sr : stress_results) {
        std::cout << "stress=" << sr.label << ";tuple=" << vec_string(sr.tuple)
                  << ";primitive=" << bool_string(sr.primitive)
                  << ";modulus_cover=" << bool_string(sr.modulus_cover)
                  << ";fastest_ratio=" << bool_string(sr.fastest_ratio)
                  << ";fastest_interval=" << bool_string(sr.fastest_interval)
                  << ";fastest_no_certificate=" << bool_string(sr.fastest_no_certificate)
                  << ";deletion_gcd=" << bool_string(sr.deletion_gcd)
                  << ";above_height=" << bool_string(sr.above_height) << "\n";
        for (const auto& oo : sr.operations) {
            std::cout << "  op=" << oo.name << ";defined=" << bool_string(oo.defined);
            if (oo.replacement) {
                std::cout << ";raw=" << vec_string(oo.replacement->raw)
                          << ";d=" << oo.replacement->normalization_factor
                          << ";normalized=" << vec_string(oo.replacement->normalized)
                          << ";new=" << oo.replacement->new_value
                          << ";parameter=" << oo.replacement->parameter
                          << ";parameter2=" << oo.replacement->parameter2
                          << ";sign_lower=" << oo.replacement->sign_lower
                          << ";sign_changed=" << oo.replacement->sign_changed;
                const auto& ar = *oo.audit;
                std::cout << ";reverse_pass=" << bool_string(ar.passed)
                          << ";vacuous=" << bool_string(ar.vacuous)
                          << ";certificates_tested=" << ar.certificates_tested;
                if (ar.failure) {
                    std::cout << ";fail_pivot_norm=" << ar.failure->normalized_pivot
                              << ";fail_pivot_raw=" << ar.failure->raw_pivot
                              << ";r=" << ar.failure->numerator
                              << ";failed_speed=" << ar.failure->failed_speed
                              << ";distance=" << ar.failure->failed_distance
                              << ";required=" << ar.failure->raw_pivot;
                }
            }
            std::cout << "\n";
        }
    }

    return 0;
}
