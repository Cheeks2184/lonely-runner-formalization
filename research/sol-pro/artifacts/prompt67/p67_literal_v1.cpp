#include <algorithm>
#include <array>
#include <cstdint>
#include <cstdlib>
#include <iostream>
#include <fstream>
#include <numeric>
#include <optional>
#include <sstream>
#include <string>
#include <vector>

using u64 = std::uint64_t;

static u64 rho(u64 M, u64 x) {
    const u64 y = x % M;
    return std::min(y, M - y);
}

static u64 gcd_all_deleted(u64 M, const std::vector<u64>& v, std::size_t deleted) {
    u64 g = M;
    for (std::size_t i = 0; i < v.size(); ++i) {
        if (i != deleted) g = std::gcd(g, v[i]);
    }
    return g;
}

static bool premises(u64 n, u64 p, const std::vector<u64>& v) {
    const u64 N = n + 1;
    const u64 M = N * p;
    if (v.size() != n) return false;
    for (u64 x : v) {
        if (x >= M || x % p == 0) return false;
    }
    for (std::size_t k = 0; k < v.size(); ++k) {
        if (gcd_all_deleted(M, v, k) != 1) return false;
    }
    return true;
}

static std::optional<u64> first_witness(u64 n, u64 p, const std::vector<u64>& v) {
    const u64 M = (n + 1) * p;
    for (u64 r = 0; r < M; ++r) {
        bool safe = true;
        for (u64 x : v) {
            if (rho(M, r * x) < p) {
                safe = false;
                break;
            }
        }
        if (safe) return r;
    }
    return std::nullopt;
}

static std::vector<u64> first_bad_index_certificate(u64 n, u64 p, const std::vector<u64>& v) {
    const u64 M = (n + 1) * p;
    std::vector<u64> cert;
    cert.reserve(M);
    for (u64 r = 0; r < M; ++r) {
        bool found = false;
        for (std::size_t i = 0; i < v.size(); ++i) {
            if (rho(M, r * v[i]) < p) {
                cert.push_back(static_cast<u64>(i));
                found = true;
                break;
            }
        }
        if (!found) {
            std::cerr << "internal error: requested cover certificate for non-cover\n";
            std::exit(2);
        }
    }
    return cert;
}

static std::vector<u64> distances(u64 n, u64 p, const std::vector<u64>& v, u64 r) {
    const u64 M = (n + 1) * p;
    std::vector<u64> out;
    out.reserve(v.size());
    for (u64 x : v) out.push_back(rho(M, r * x));
    return out;
}

static std::string json_array(const std::vector<u64>& xs) {
    std::ostringstream os;
    os << '[';
    for (std::size_t i = 0; i < xs.size(); ++i) {
        if (i) os << ',';
        os << xs[i];
    }
    os << ']';
    return os.str();
}

// Deterministic 64-bit FNV-1a transcript accumulator. SHA-256 of the complete
// source and emitted JSON is computed externally and recorded in the manifest.
static void fnv_mix(u64& h, u64 x) {
    constexpr u64 prime = 1099511628211ULL;
    for (int j = 0; j < 8; ++j) {
        h ^= static_cast<unsigned char>((x >> (8 * j)) & 0xffU);
        h *= prime;
    }
}

static void run_case(u64 n, u64 p, const std::string& scope) {
    const u64 N = n + 1;
    const u64 M = N * p;
    u64 total = 1;
    for (u64 i = 0; i < n; ++i) total *= M;

    std::vector<u64> v(n, 0);
    std::vector<u64> witness_hist(M, 0);
    // One byte for every ordered tuple ordinal: 255=nonpremise, 254=failure,
    // otherwise the byte is the first safe witness r (M<=35 in this run).
    std::vector<unsigned char> outcome_map(total, static_cast<unsigned char>(255));
    // For every failure, store 8-byte little-endian tuple ordinal followed by
    // M one-byte first-bad-coordinate indices, one for each r in order.
    std::vector<unsigned char> failure_cover_stream;
    u64 premise_count = 0;
    u64 failure_count = 0;
    std::optional<std::vector<u64>> first_failure;
    std::optional<std::vector<u64>> first_failure_cert;
    u64 witness_record_hash = 1469598103934665603ULL;
    u64 boundary_witness_count = 0;

    for (u64 ordinal = 0; ordinal < total; ++ordinal) {
        u64 z = ordinal;
        // Last coordinate changes fastest; this is ordinary lexicographic order.
        for (std::size_t jj = 0; jj < n; ++jj) {
            const std::size_t i = n - 1 - jj;
            v[i] = z % M;
            z /= M;
        }
        if (!premises(n, p, v)) continue;
        ++premise_count;
        const auto w = first_witness(n, p, v);
        for (u64 x : v) fnv_mix(witness_record_hash, x);
        if (w) {
            outcome_map[ordinal] = static_cast<unsigned char>(*w);
            ++witness_hist[*w];
            fnv_mix(witness_record_hash, *w + 1); // reserve 0 for failure marker
            bool has_boundary = false;
            for (u64 x : v) {
                if (rho(M, (*w) * x) == p) {
                    has_boundary = true;
                    break;
                }
            }
            if (has_boundary) ++boundary_witness_count;
        } else {
            outcome_map[ordinal] = static_cast<unsigned char>(254);
            ++failure_count;
            fnv_mix(witness_record_hash, 0);
            const auto cert = first_bad_index_certificate(n, p, v);
            for (int j = 0; j < 8; ++j) {
                failure_cover_stream.push_back(
                    static_cast<unsigned char>((ordinal >> (8 * j)) & 0xffU));
            }
            for (u64 index : cert) {
                failure_cover_stream.push_back(static_cast<unsigned char>(index));
            }
            if (!first_failure) {
                first_failure = v;
                first_failure_cert = cert;
            }
        }
    }

    const char* cert_dir_env = std::getenv("P67_CERT_DIR");
    const std::string cert_dir = cert_dir_env ? cert_dir_env : ".";
    const std::string cert_name = "p67_outcomes_n" + std::to_string(n) +
        "_p" + std::to_string(p) + "_literal.bin";
    const std::string cert_path = cert_dir + "/" + cert_name;
    const std::string failure_cert_name = "p67_failure_covers_n" +
        std::to_string(n) + "_p" + std::to_string(p) + "_literal.bin";
    const std::string failure_cert_path = cert_dir + "/" + failure_cert_name;
    {
        std::ofstream cert(cert_path, std::ios::binary);
        if (!cert) {
            std::cerr << "cannot open certificate file: " << cert_path << "\n";
            std::exit(3);
        }
        cert.write(reinterpret_cast<const char*>(outcome_map.data()),
                   static_cast<std::streamsize>(outcome_map.size()));
        if (!cert) {
            std::cerr << "cannot write certificate file: " << cert_path << "\n";
            std::exit(4);
        }
    }
    {
        std::ofstream cert(failure_cert_path, std::ios::binary);
        if (!cert) {
            std::cerr << "cannot open failure certificate file: "
                      << failure_cert_path << "\n";
            std::exit(5);
        }
        cert.write(reinterpret_cast<const char*>(failure_cover_stream.data()),
                   static_cast<std::streamsize>(failure_cover_stream.size()));
        if (!cert) {
            std::cerr << "cannot write failure certificate file: "
                      << failure_cert_path << "\n";
            std::exit(6);
        }
    }

    std::cout << '{';
    std::cout << "\"verifier\":\"p67-literal-v1\",";
    std::cout << "\"scope\":\"" << scope << "\",";
    std::cout << "\"n\":" << n << ',';
    std::cout << "\"N\":" << N << ',';
    std::cout << "\"p\":" << p << ',';
    std::cout << "\"M\":" << M << ',';
    std::cout << "\"tuple_total\":" << total << ',';
    std::cout << "\"premise_total\":" << premise_count << ',';
    std::cout << "\"failure_total\":" << failure_count << ',';
    std::cout << "\"success_total\":" << (premise_count - failure_count) << ',';
    std::cout << "\"first_failure\":";
    if (first_failure) std::cout << json_array(*first_failure); else std::cout << "null";
    std::cout << ',';
    std::cout << "\"first_failure_cover_first_bad_index_by_r\":";
    if (first_failure_cert) std::cout << json_array(*first_failure_cert); else std::cout << "null";
    std::cout << ',';
    std::cout << "\"first_failure_distance_rows\":";
    if (first_failure) {
        std::cout << '[';
        for (u64 r = 0; r < M; ++r) {
            if (r) std::cout << ',';
            std::cout << json_array(distances(n, p, *first_failure, r));
        }
        std::cout << ']';
    } else {
        std::cout << "null";
    }
    std::cout << ',';
    std::cout << "\"first_witness_histogram\":" << json_array(witness_hist) << ',';
    std::cout << "\"first_witness_boundary_tuple_count\":" << boundary_witness_count << ',';
    std::cout << "\"ordered_witness_record_fnv1a64\":\"" << std::hex << witness_record_hash << std::dec << "\",";
    std::cout << "\"outcome_map_file\":\"" << cert_name << "\",";
    std::cout << "\"outcome_map_encoding\":\"one byte per lexicographic ordered tuple: 255 nonpremise, 254 failure, 0..M-1 first witness\",";
    std::cout << "\"failure_cover_file\":\"" << failure_cert_name << "\",";
    std::cout << "\"failure_cover_record_count\":" << failure_count << ',';
    std::cout << "\"failure_cover_encoding\":\"records in failed-tuple lex order: uint64 little-endian tuple ordinal, then M one-byte first-bad-coordinate indices for r=0..M-1\",";
    std::cout << "\"tuple_order\":\"lexicographic over [0,M)^n; last coordinate fastest\",";
    std::cout << "\"witness_order\":\"r=0,1,...,M-1; stop at first safe r only within each tuple\",";
    std::cout << "\"global_early_stop\":false";
    std::cout << "}\n";
}

int main() {
    // Mandatory verifier preflight: reproduce the accepted n=3,p=5 failure.
    run_case(3, 5, "mandatory-baseline");
    // Exactly one new dimension and exactly one declared interval: n=4, primes [2,7].
    for (u64 p : std::array<u64, 4>{2, 3, 5, 7}) {
        run_case(4, p, "new-interval-n4-[2,7]");
    }
    return 0;
}
