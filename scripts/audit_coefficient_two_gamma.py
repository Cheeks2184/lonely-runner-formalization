from itertools import combinations
from math import gcd

EX22 = {
    (4, 1, 2), (5, 2, 2), (6, 3, 2), (5, 1, 3), (6, 2, 3),
    (7, 3, 3), (8, 4, 3), (10, 2, 6), (11, 2, 6), (11, 3, 6),
    (12, 3, 6), (12, 4, 6), (13, 4, 6), (13, 5, 6),
    (14, 5, 6), (14, 6, 6), (15, 6, 6), (15, 7, 6),
    (16, 7, 6), (16, 8, 6), (17, 8, 6), (18, 9, 6),
}


def omega(n):
    x, p, k = n, 2, 0
    while p * p <= x:
        if x % p == 0:
            k += 1
            while x % p == 0:
                x //= p
        p += 1
    return k + (x > 1)


def candidate(N, t, c):
    H = N + t
    nat_sub = max(0, N - c - t)
    return (
        1 <= c <= N
        and 2 * c <= H
        and nat_sub < 2**omega(c)
        and (3 * (N - t) < 4 * c or (N, t, c) in EX22)
    )


def automatic(N, t, c):
    H = N + t
    return [d for d in range(H + 1, 2 * N - c + 1) if gcd(c, d) == 1]


def gamma(N, t, c):
    H = N + t
    return [
        d
        for d in range(N + 1, H + 1)
        if H < c + d <= 2 * N and gcd(c, d) == 1
    ]


def has_full_matching(C, G):
    owner = {}

    def augment(c, seen):
        for d in G[c]:
            if d in seen:
                continue
            seen.add(d)
            if d not in owner or augment(owner[d], seen):
                owner[d] = c
                return True
        return False

    return all(augment(c, set()) for c in C)


failures = []
for N in range(4, 301):
    for t in range(1, N // 2 + 1):
        C = [
            c
            for c in range(1, N + 1)
            if candidate(N, t, c) and not automatic(N, t, c)
        ]
        G = {c: gamma(N, t, c) for c in C}
        if not has_full_matching(C, G):
            failures.append((N, t, C, G))

expected_pairs = [(4, 2), (5, 2), (8, 4), (11, 5)]
assert [(N, t) for N, t, _, _ in failures] == expected_pairs
print("range=N:4..300,t:1..floor(N/2)")
print("selector_failures=" + repr(expected_pairs))
for N, t, C, G in failures:
    print(f"failure[{N},{t}].C={C}")
    print(f"failure[{N},{t}].Gamma={G}")

expected_configs = {
    (4, 2): [((2, 3), (5,))],
    (5, 2): [((2, 3), (7,))],
    (8, 4): [((6,), ()), ((4, 5, 6), (9, 11))],
    (11, 5): [((6, 8), (13,))],
}
for N, t, C, G in failures:
    H = N + t
    configs = []
    for m in range(1, len(C) + 1):
        for Mt in combinations(C, m):
            forced = set().union(*(set(G[c]) for c in Mt))
            if len(forced) > m - 1:
                continue
            for Et in combinations(range(N + 1, H + 1), m - 1):
                E = set(Et)
                if forced <= E:
                    configs.append((Mt, Et))
    assert configs == expected_configs[(N, t)]
    for Mt, Et in configs:
        S = (set(range(1, N + 1)) - set(Mt)) | set(Et)
        assert any(all(x % c for x in S) for c in Mt)
    print(f"failure[{N},{t}].all_containment_configs={configs}")
    print(f"failure[{N},{t}].all_have_reciprocal_witness=True")

N, t = 19, 9
M = {9, 14}
E = {28}
S = (set(range(1, N + 1)) - M) | E
assert len(S) == N - 1 and max(S) == N + t
assert 3 * 9 + 1 == 2 * 14 == 28
assert all(any(x % c == 0 for x in S) for c in M)
q, c, d = 29, 9, 20
assert N < q <= 2 * N and max(S) < q and gcd(c, q) == 1
assert c not in S and d == q - c and d not in S
print("collision=(N,t,M,E)=(19,9,{9,14},{28})")
print("collision_witness=(q,c,q-c)=(29,9,20)")
print("PASS")
