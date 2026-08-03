PRO-B Prompt 62 exact computation bundle
Version: PROB-62-v1.0.0

Scope
-----
This bundle performs finite exact tests of canonical top-two pivot grids. It does
not prove TOP-TWO-PIVOT, the all-pivot certificate, or unrestricted Lonely
Runner.

Conventions
-----------
For a pivot P and N=n+1, candidates are 0 <= r < N*P with N not dividing r.
A nonpivot speed c is strictly bad when rho_{N*P}(r*c) < P. Safety is the closed
condition rho_{N*P}(r*c) >= P.

Reproduction
------------
python3 generate_manifest.py > pro_b_manifest.txt
python3 pro_b_top_two_literal.py pro_b_manifest.txt > pro_b_literal.out
g++ -O3 -std=c++20 pro_b_top_two_optimized.cpp -o pro_b_top_two_optimized
./pro_b_top_two_optimized pro_b_manifest.txt > pro_b_optimized.out
cmp -s pro_b_literal.out pro_b_optimized.out
python3 pro_b_affine_hard_verifier.py > pro_b_affine_hard.out
python3 pro_b_report.py > pro_b_sweep_report.txt
sha256sum -c SHA256SUMS

Primary output
--------------
See pro_b_sweep_report.txt. It records the declared domain, ordering, runtimes,
source/output hashes, exact smallest failures within that finite domain, stress
rows, mutation aggregates, literal/optimized agreement, and the independent
(N,A,B)=(7,98,187) integral affine-transversal check.
