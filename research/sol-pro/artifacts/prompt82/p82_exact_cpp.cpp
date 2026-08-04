#include <algorithm>
#include <array>
#include <boost/multiprecision/cpp_int.hpp>
#include <cstdint>
#include <cstdlib>
#include <functional>
#include <iostream>
#include <map>
#include <numeric>
#include <set>
#include <sstream>
#include <stdexcept>
#include <string>
#include <tuple>
#include <utility>
#include <vector>

using boost::multiprecision::cpp_int;
using u64 = std::uint64_t;

#ifndef SOURCE_SHA256
#define SOURCE_SHA256 "UNBOUND"
#endif

namespace {

struct Rat {
    cpp_int num{0};
    cpp_int den{1};
};

cpp_int abs_big(cpp_int x) { return x < 0 ? -x : x; }

cpp_int gcd_big(cpp_int a, cpp_int b) {
    a = abs_big(a);
    b = abs_big(b);
    while (b != 0) {
        cpp_int r = a % b;
        a = b;
        b = r;
    }
    return a;
}

Rat normalize(cpp_int num, cpp_int den) {
    if (den == 0) throw std::runtime_error("zero denominator");
    if (den < 0) { num = -num; den = -den; }
    cpp_int g = gcd_big(num, den);
    if (g != 0) { num /= g; den /= g; }
    return {num, den};
}

Rat add(const Rat& a, const Rat& b) {
    return normalize(a.num * b.den + b.num * a.den, a.den * b.den);
}

Rat mul_int(const Rat& a, std::int64_t k) {
    return normalize(a.num * k, a.den);
}

bool less_rat(const Rat& a, const Rat& b) {
    return a.num * b.den < b.num * a.den;
}

bool equal_rat(const Rat& a, const Rat& b) {
    return a.num == b.num && a.den == b.den;
}

std::string big_string(const cpp_int& x) {
    return x.convert_to<std::string>();
}

std::string rat_text(const Rat& r) {
    if (r.den == 1) return big_string(r.num);
    return big_string(r.num) + "/" + big_string(r.den);
}

int rat_sign(const Rat& r) { return (r.num > 0) - (r.num < 0); }

void json_rat(std::ostream& os, const Rat& r) {
    os << "{\"numerator\":\"" << big_string(r.num)
       << "\",\"denominator\":\"" << big_string(r.den)
       << "\",\"text\":\"" << rat_text(r)
       << "\",\"sign\":" << rat_sign(r) << "}";
}

u64 gcd_all(const std::vector<u64>& a) {
    u64 g = 0;
    for (u64 x : a) g = std::gcd(g, x);
    return g;
}

void validate_tuple(const std::vector<u64>& a, bool increasing = false) {
    if (a.empty()) throw std::invalid_argument("empty tuple");
    if (std::any_of(a.begin(), a.end(), [](u64 x){ return x == 0; }))
        throw std::invalid_argument("nonpositive speed");
    std::set<u64> distinct(a.begin(), a.end());
    if (distinct.size() != a.size()) throw std::invalid_argument("duplicate speed");
    if (increasing && !std::is_sorted(a.begin(), a.end()))
        throw std::invalid_argument("tuple not increasing");
}

u64 mul_mod(u64 a, u64 b, u64 mod) {
    return static_cast<u64>((static_cast<unsigned __int128>(a) * b) % mod);
}

u64 centered(u64 q, u64 M) {
    return std::min(q, M - q);
}

bool strict_bad_two_sided(u64 q, u64 M, u64 p) {
    // rho_M(q) < p, with equality q=p or q=M-p safe.
    return q < p || q > M - p;
}

Rat phi8(std::size_t m) {
    return normalize(cpp_int(1) - cpp_int(m), cpp_int(8 * m + 1));
}

struct PivotRecord {
    std::size_t pivot{};
    u64 p{};
    u64 M{};
    u64 R_size{};
    std::vector<u64> hist;
    Rat local;
    std::vector<u64> good;
    u64 p_minus_1_hits{};
    u64 p_hits{};
    bool reflection_ok{};
    bool antipode_candidate{};
    u64 antipode{};
    std::int64_t antipode_mu{-1};
    u64 nonunit_owners{};
    std::vector<std::tuple<std::size_t,std::size_t,u64>> coincident;
};

PivotRecord pivot_record(const std::vector<u64>& a, std::size_t pivot) {
    validate_tuple(a);
    const std::size_t n = a.size();
    if (pivot >= n) throw std::out_of_range("pivot");
    const u64 N = static_cast<u64>(n + 1);
    const u64 p = a[pivot];
    const u64 M = N * p;

    std::vector<u64> candidates;
    candidates.reserve(static_cast<std::size_t>(n * p));
    // Independent candidate enumeration by quotient block and nonzero N-residue.
    for (u64 block = 0; block < p; ++block) {
        for (u64 s = 1; s < N; ++s) {
            candidates.push_back(block * N + s);
        }
    }
    if (candidates.size() != n * p) throw std::runtime_error("candidate count mismatch");

    std::vector<std::vector<unsigned char>> bad(n, std::vector<unsigned char>(M, 0));
    u64 p_minus_1_hits = 0;
    u64 p_hits = 0;
    u64 nonunit = 0;
    for (std::size_t i = 0; i < n; ++i) {
        if (i == pivot) continue;
        if (std::gcd(a[i], M) > 1) ++nonunit;
        for (u64 r : candidates) {
            const u64 q = mul_mod(r, a[i], M);
            const u64 d = centered(q, M);
            p_minus_1_hits += (d == p - 1);
            p_hits += (d == p);
            bad[i][r] = strict_bad_two_sided(q, M, p) ? 1 : 0;
        }
    }

    std::vector<u64> hist(n, 0);
    std::vector<u64> mu(M, static_cast<u64>(-1));
    std::vector<u64> good;
    for (u64 r : candidates) {
        u64 m = 0;
        for (std::size_t i = 0; i < n; ++i) if (i != pivot) m += bad[i][r];
        mu[r] = m;
        ++hist[m];
        if (m == 0) good.push_back(r);
    }

    Rat local{0,1};
    for (std::size_t m = 0; m < hist.size(); ++m) {
        local = add(local, mul_int(phi8(m), static_cast<std::int64_t>(hist[m])));
    }

    bool reflection_ok = true;
    for (u64 r : candidates) {
        const u64 reflected = (M - r) % M;
        if (mu[r] != mu[reflected]) reflection_ok = false;
    }
    if (!reflection_ok) throw std::runtime_error("reflection mismatch");

    std::vector<std::tuple<std::size_t,std::size_t,u64>> coincident;
    for (std::size_t i = 0; i < n; ++i) {
        if (i == pivot) continue;
        for (std::size_t k = i + 1; k < n; ++k) {
            if (k == pivot) continue;
            bool same = true;
            u64 count = 0;
            for (u64 r : candidates) {
                if (bad[i][r] != bad[k][r]) same = false;
                count += bad[i][r];
            }
            if (same) coincident.emplace_back(i,k,count);
        }
    }

    const u64 antipode = M / 2;
    const bool antipode_candidate = (M % 2 == 0) && (antipode % N != 0);
    std::int64_t antipode_mu = antipode_candidate ? static_cast<std::int64_t>(mu[antipode]) : -1;

    return {
        pivot, p, M, static_cast<u64>(candidates.size()), hist, local, good,
        p_minus_1_hits, p_hits, reflection_ok, antipode_candidate, antipode,
        antipode_mu, nonunit, coincident
    };
}

struct TupleRecord {
    std::vector<u64> speeds;
    std::vector<PivotRecord> pivots;
    Rat global;
    u64 total_candidates{};
    u64 total_good{};
};

TupleRecord tuple_record(const std::vector<u64>& a) {
    validate_tuple(a);
    TupleRecord out;
    out.speeds = a;
    out.global = {0,1};
    for (std::size_t j = 0; j < a.size(); ++j) {
        auto row = pivot_record(a,j);
        out.global = add(out.global, row.local);
        out.total_candidates += row.R_size;
        out.total_good += row.hist[0];
        out.pivots.push_back(std::move(row));
    }
    if (out.total_candidates != a.size() * std::accumulate(a.begin(), a.end(), u64{0}))
        throw std::runtime_error("total candidate identity failed");
    return out;
}

Rat score(const std::vector<u64>& a) { return tuple_record(a).global; }

std::vector<std::vector<u64>> all_fixture_tuples() {
    const std::vector<std::vector<u64>> raw = {
        {1,2,8}, {1,3,4}, {1,2,3,5}, {4,5,9}, {1,4,5,6,7,11},
        {1,2,3,4,5,7}, {1,6,11,12,13}, {6,7,168}, {6,7,12,24,144},
        {8,15,35,40,48,56,75,132,147},
        {15,21,40,48,56,105,126,280,1200},
        {1,3,4,5}, {4,5,8}, {4,5,32}, {1,3,4,9,12}, {1,3,13},
        {2,5,6}, {2,4,6}, {1,2,3,10}, {1,3,4,7}, {1,2,3,60},
        {1,2,6,8,10}, {7,63,70,77,98,187}
    };
    std::vector<std::vector<u64>> out;
    std::set<std::vector<u64>> seen;
    for (const auto& a : raw) if (seen.insert(a).second) out.push_back(a);
    return out;
}

std::map<std::vector<u64>, Rat> expected_calibrations() {
    return {
        {{1,2,8}, normalize(93,17)},
        {{1,3,4}, normalize(66,17)},
        {{1,2,3,5}, normalize(1532,425)},
        {{4,5,9}, normalize(128,17)},
        {{1,4,5,6,7,11}, normalize(165878,191675)},
        {{1,2,3,4,5,7}, normalize(452714,191675)},
        {{1,6,11,12,13}, normalize(101887,4675)},
        {{6,7,168}, normalize(1997,17)},
        {{6,7,12,24,144}, normalize(617587,4675)},
        {{8,15,35,40,48,56,75,132,147}, normalize(cpp_int("900274298524"),cpp_int("2319842525"))},
        {{15,21,40,48,56,105,126,280,1200}, normalize(cpp_int("32973892321"),cpp_int("19494475"))}
    };
}

void generate_combinations(int n, int next, std::vector<u64>& current,
                           const std::function<void(const std::vector<u64>&)>& visit) {
    if (static_cast<int>(current.size()) == n) { visit(current); return; }
    const int remaining = n - static_cast<int>(current.size());
    for (int x = next; x <= 14 - remaining + 1; ++x) {
        current.push_back(static_cast<u64>(x));
        generate_combinations(n, x + 1, current, visit);
        current.pop_back();
    }
}

struct FrozenResult {
    std::map<int,u64> counts;
    std::map<int,std::pair<std::vector<u64>,Rat>> minima;
    u64 total{};
};

FrozenResult frozen_scan() {
    const std::map<int,u64> expected_counts = {{2,63},{3,325},{4,965},{5,1981},{6,2996}};
    const std::map<int,std::pair<std::vector<u64>,Rat>> expected_minima = {
        {2, {{1,3}, normalize(2,1)}},
        {3, {{1,4,5}, normalize(64,17)}},
        {4, {{1,2,3,5}, normalize(1532,425)}},
        {5, {{1,5,6,7,8}, normalize(26683,4675)}},
        {6, {{1,4,5,6,7,11}, normalize(165878,191675)}}
    };
    FrozenResult result;
    for (int n = 2; n <= 6; ++n) {
        bool have = false;
        std::vector<u64> best;
        Rat best_score;
        std::vector<u64> current;
        generate_combinations(n,1,current,[&](const std::vector<u64>& a){
            if (gcd_all(a) != 1) return;
            ++result.counts[n];
            ++result.total;
            Rat s = score(a);
            if (!have || less_rat(s,best_score)) { have=true; best=a; best_score=s; }
        });
        result.minima[n] = {best,best_score};
        if (result.counts[n] != expected_counts.at(n)) throw std::runtime_error("frozen count mismatch");
        const auto& expected = expected_minima.at(n);
        if (best != expected.first || !equal_rat(best_score, expected.second))
            throw std::runtime_error("frozen minimum mismatch");
    }
    return result;
}

struct MutationResult {
    u64 tested{};
    u64 inserted{};
    std::vector<std::tuple<u64,u64,std::vector<u64>,Rat>> prefix;
    TupleRecord failure;
};

MutationResult mutation_scan() {
    const std::vector<u64> base = {1,4,5,6,7,11};
    MutationResult out;
    for (u64 x = 1; x <= 120; ++x) {
        if (std::find(base.begin(),base.end(),x) != base.end()) continue;
        std::vector<u64> a = base;
        a.push_back(x);
        std::sort(a.begin(),a.end());
        if (gcd_all(a) != 1) continue;
        ++out.tested;
        Rat s = score(a);
        out.prefix.emplace_back(out.tested,x,a,s);
        if (s.num <= 0) {
            out.inserted = x;
            out.failure = tuple_record(a);
            break;
        }
    }
    if (out.failure.speeds != std::vector<u64>({1,4,5,6,7,11,32}))
        throw std::runtime_error("wrong mutation failure");
    if (!equal_rat(out.failure.global, normalize(-5245398,1878415)))
        throw std::runtime_error("wrong failure score");
    if (out.tested != 26) throw std::runtime_error("wrong mutation ordinal");
    return out;
}

void scaling_audit(const std::vector<u64>& a, u64 c) {
    const auto base = tuple_record(a);
    std::vector<u64> scaled;
    for (u64 x : a) scaled.push_back(c*x);
    const auto lifted = tuple_record(scaled);
    if (!equal_rat(lifted.global,mul_int(base.global,static_cast<std::int64_t>(c))))
        throw std::runtime_error("score scaling failed");
    const u64 N = static_cast<u64>(a.size()+1);
    for (std::size_t j=0;j<a.size();++j) {
        const u64 M=N*a[j];
        const u64 Mp=c*M;
        std::vector<u64> fibers(M,0);
        for (u64 block=0;block<c*a[j];++block) {
            for (u64 s=1;s<N;++s) {
                u64 rr=block*N+s;
                ++fibers[rr%M];
                for (std::size_t i=0;i<a.size();++i) if (i!=j) {
                    const u64 q1=mul_mod(rr,c*a[i],Mp);
                    const u64 q0=mul_mod(rr%M,a[i],M);
                    if (strict_bad_two_sided(q1,Mp,c*a[j]) != strict_bad_two_sided(q0,M,a[j]))
                        throw std::runtime_error("badness scaling failed");
                    if (centered(q1,Mp) != c*centered(q0,M))
                        throw std::runtime_error("rho scaling failed");
                }
            }
        }
        for (u64 r=0;r<M;++r) {
            if (r%N==0) {
                if (fibers[r]!=0) throw std::runtime_error("noncandidate fiber emitted");
            } else if (fibers[r]!=c) throw std::runtime_error("fiber size mismatch");
        }
        for (std::size_t m=0;m<base.pivots[j].hist.size();++m) {
            if (lifted.pivots[j].hist[m] != c*base.pivots[j].hist[m])
                throw std::runtime_error("hist scaling mismatch");
        }
    }
}

u64 permutation_audit(std::vector<u64> a) {
    std::sort(a.begin(),a.end());
    Rat expected=score(a);
    u64 count=0;
    do {
        if (!equal_rat(score(a),expected)) throw std::runtime_error("permutation score mismatch");
        ++count;
    } while (std::next_permutation(a.begin(),a.end()));
    return count;
}

void malformed_internal_audit() {
    int rejected=0;
    for (const auto& a : std::vector<std::vector<u64>>{{},{0,1},{1,1}}) {
        try { validate_tuple(a); }
        catch (const std::invalid_argument&) { ++rejected; }
    }
    try { validate_tuple({2,1},true); }
    catch (const std::invalid_argument&) { ++rejected; }
    if (rejected!=4) throw std::runtime_error("malformed audit failed");
}

void json_u64_array(std::ostream& os, const std::vector<u64>& xs) {
    os << '[';
    for (std::size_t i=0;i<xs.size();++i) { if(i) os<<','; os<<xs[i]; }
    os << ']';
}

void json_hist(std::ostream& os, const std::vector<u64>& xs) { json_u64_array(os,xs); }

void json_pivot(std::ostream& os, const PivotRecord& p) {
    os << '{';
    os << "\"pivot_index\":" << p.pivot;
    os << ",\"pivot_speed\":" << p.p;
    os << ",\"M\":" << p.M;
    os << ",\"R_size\":" << p.R_size;
    os << ",\"histogram\":"; json_hist(os,p.hist);
    os << ",\"local_score\":"; json_rat(os,p.local);
    os << ",\"good_residues\":"; json_u64_array(os,p.good);
    os << ",\"rho_equals_p_minus_1_hits\":" << p.p_minus_1_hits;
    os << ",\"rho_equals_p_hits\":" << p.p_hits;
    os << ",\"reflection_invariance\":" << (p.reflection_ok?"true":"false");
    os << ",\"antipode\":{\"r\":" << p.antipode
       << ",\"candidate\":" << (p.antipode_candidate?"true":"false")
       << ",\"multiplicity\":" << p.antipode_mu << '}';
    os << ",\"nonunit_owner_count\":" << p.nonunit_owners;
    os << ",\"coincident_owner_sets\":[";
    for (std::size_t k=0;k<p.coincident.size();++k) {
        if(k) os<<',';
        const auto [i,j,c]=p.coincident[k];
        os << "{\"owner_indices\":["<<i<<','<<j<<"],\"bad_count_each\":"<<c<<'}';
    }
    os << "]}";
}

} // namespace

int main(int argc, char**) {
    if (argc != 1) {
        std::cerr << "malformed input: p82_exact_cpp accepts no command-line arguments\n";
        return 64;
    }
    try {
        malformed_internal_audit();
        const auto frozen=frozen_scan();
        const auto fixtures=all_fixture_tuples();
        const auto expected=expected_calibrations();
        std::vector<std::pair<std::vector<u64>,Rat>> fixture_scores;
        for (const auto& a:fixtures) {
            Rat s=score(a);
            auto it=expected.find(a);
            if(it!=expected.end() && !equal_rat(s,it->second)) throw std::runtime_error("calibration mismatch");
            fixture_scores.push_back({a,s});
            scaling_audit(a,2);
            scaling_audit(a,3);
        }
        const auto mutation=mutation_scan();
        const u64 permutation_count=permutation_audit({1,4,5,6,7,11,32});
        if(permutation_count!=5040) throw std::runtime_error("permutation count mismatch");

        // Exact anti-tautology witness at pivot speed 7, r=17.
        const std::vector<u64> ce={1,4,5,6,7,11,32};
        const u64 N=8,p=7,M=56,r=17;
        std::vector<u64> distances;
        for(u64 x:ce) distances.push_back(centered(mul_mod(r,x,M),M));
        if(r%N==0) throw std::runtime_error("certificate not candidate");
        for(u64 d:distances) if(d<p) throw std::runtime_error("certificate unsafe");

        std::cout << '{';
        std::cout << "\"schema\":\"PIPE-P82-EXACT-CPP20-v1\"";
        std::cout << ",\"runtime\":{\"language\":\"C++20\",\"compiler\":\"" << __VERSION__
                  << "\",\"cplusplus\":" << __cplusplus
                  << ",\"arithmetic\":\"integer-only candidate logic and boost::multiprecision::cpp_int reduced rationals; no floating point\""
                  << ",\"overflow_policy\":\"products reduced with unsigned __int128 before modulus; score integers arbitrary precision\"}";
        std::cout << ",\"source_sha256_binding\":\"" << SOURCE_SHA256 << "\"";
        std::cout << ",\"malformed_input_behavior\":\"any argument -> stderr and exit 64\"";
        std::cout << ",\"candidate_enumeration\":\"r=block*N+s with 0<=block<p and 1<=s<N\"";
        std::cout << ",\"strict_badness\":\"q<p or q>M-p; equality q=p and q=M-p safe\"";
        std::cout << ",\"frozen_scan\":{\"total\":" << frozen.total << ",\"counts\":{";
        bool first=true;
        for(const auto& [n,c]:frozen.counts){if(!first)std::cout<<',';first=false;std::cout<<'\"'<<n<<"\":"<<c;}
        std::cout << "},\"minima\":{"; first=true;
        for(const auto& [n,item]:frozen.minima){if(!first)std::cout<<',';first=false;std::cout<<'\"'<<n<<"\":{\"tuple\":";json_u64_array(std::cout,item.first);std::cout<<",\"score\":";json_rat(std::cout,item.second);std::cout<<'}';}
        std::cout << "},\"nonpositive_found\":false}";

        std::cout << ",\"fixture_scores\":[";
        for(std::size_t k=0;k<fixture_scores.size();++k){if(k)std::cout<<',';std::cout<<"{\"tuple\":";json_u64_array(std::cout,fixture_scores[k].first);std::cout<<",\"score\":";json_rat(std::cout,fixture_scores[k].second);std::cout<<'}';}
        std::cout << ']';
        std::cout << ",\"scaling_checks\":{\"fixture_count\":"<<fixtures.size()<<",\"factors\":[2,3],\"all_exact\":true}";
        std::cout << ",\"permutation_audit\":{\"tuple\":[1,4,5,6,7,11,32],\"permutations_checked\":"<<permutation_count<<",\"all_equal\":true}";

        std::cout << ",\"structured_mutation\":{\"definition\":\"insert x=1..120 into (1,4,5,6,7,11), skip collisions/nonprimitive, sort, stop at first S_8<=0\",\"tested\":"<<mutation.tested<<",\"inserted_speed\":"<<mutation.inserted<<",\"prefix\":[";
        for(std::size_t k=0;k<mutation.prefix.size();++k){if(k)std::cout<<',';const auto& [ord,x,a,s]=mutation.prefix[k];std::cout<<"{\"ordinal\":"<<ord<<",\"inserted_speed\":"<<x<<",\"tuple\":";json_u64_array(std::cout,a);std::cout<<",\"score\":";json_rat(std::cout,s);std::cout<<'}';}
        std::cout << "],\"first_failure\":{\"tuple\":";json_u64_array(std::cout,mutation.failure.speeds);
        std::cout << ",\"gcd\":"<<gcd_all(mutation.failure.speeds)<<",\"total_candidates\":"<<mutation.failure.total_candidates<<",\"total_good\":"<<mutation.failure.total_good<<",\"global_score\":";json_rat(std::cout,mutation.failure.global);
        std::cout << ",\"pivots\":[";
        for(std::size_t j=0;j<mutation.failure.pivots.size();++j){if(j)std::cout<<',';json_pivot(std::cout,mutation.failure.pivots[j]);}
        std::cout << "]}}";

        std::cout << ",\"anti_tautology_certificate\":{\"tuple\":[1,4,5,6,7,11,32],\"pivot_speed\":7,\"M\":56,\"r\":17,\"distances\":";json_u64_array(std::cout,distances);std::cout<<",\"certificate_exists_but_global_score_negative\":true}";
        std::cout << ",\"final_disposition\":\"STOP\",\"sole_lemma_status\":\"rejected\"}";
        std::cout << '\n';
        return 0;
    } catch(const std::exception& e) {
        std::cerr << "fatal verifier error: " << e.what() << '\n';
        return 2;
    }
}
