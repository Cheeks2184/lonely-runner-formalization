#!/usr/bin/env python3
from math import gcd


def omega(c: int) -> int:
    x = c
    p = 2
    out = 0
    while p * p <= x:
        if x % p == 0:
            out += 1
            while x % p == 0:
                x //= p
        p += 1
    if x > 1:
        out += 1
    return out


def rho(M: int, x: int) -> int:
    y = x % M
    return min(y, M-y)


def safe_residues(speeds, pivot):
    n = len(speeds)
    N = n + 1
    A = speeds[pivot]
    M = N*A
    return tuple(r for r in range(M) if r % N != 0 and
                 all(rho(M, r*a) >= A for a in speeds))

# Classification of short Kanold-bound exceptions under 5t <= N.
exceptions = []
triples = 0
for N in range(1, 1001):
    for t in range(1, N//5 + 1):
        for c in range(1, N+1):
            if 2*c <= N+t:
                triples += 1
                ell = N-c-t
                assert ell >= 0
                if ell < 2**omega(c):
                    exceptions.append((N,t,c,ell,2**omega(c)))
assert exceptions == [(5,1,3,1,2),(10,2,6,2,4),(11,2,6,3,4)]

# Direct exceptional selector at (10,2,6).
assert 19 in range(10+6+2+1, 2*10+1)
assert gcd(19,6) == 1

# The fixed-c selector really fails at (11,2,6).
assert tuple(q for q in range(20,23) if gcd(q,6)==1) == ()

# Endpoint counterexample to slowest/fastest-pivot restriction.
endpoint = (1,4,5,6,7,11)
endpoint_table = tuple(safe_residues(endpoint,j) for j in range(len(endpoint)))
assert endpoint_table == ((),(),(),(13,29),(15,34),())

# Saturated top-two class: speeds 1,...,N-2,B.
# Verify explicit case split through N=200 and a range of B.
checked = 0
for N in range(5,201):
    A = N-2
    M = N*A
    for B in list(range(A+1, min(A+80, 5*N)+1)) + [M,2*M,3*M]:
        speeds = tuple(range(1,A+1)) + (B,)
        if B % N != 0:
            r = A                 # t=1/N on pivot A
            pivot = len(speeds)-2
        elif B % M != 0:
            r = N-1               # second explicit pivot-A numerator
            pivot = len(speeds)-2
        else:
            k = B//M
            r = (N-1)*N*k - 1     # explicit pivot-B numerator
            pivot = len(speeds)-1
        A_p = speeds[pivot]
        mod = N*A_p
        assert 0 <= r < mod and r % N != 0
        assert all(rho(mod,r*a) >= A_p for a in speeds)
        checked += 1

print(f"five_coefficient_short_bound_triples_N_le_1000={triples}")
print(f"short_bound_exceptions={exceptions}")
print("direct_exception_q=(N,t,c,q)=(10,2,6,19)")
print("fixed_c_local_failure=(N,t,c)=(11,2,6) interval=(20,21,22)")
print(f"endpoint_safe_table={endpoint_table}")
print(f"saturated_top_two_explicit_checks={checked}")
