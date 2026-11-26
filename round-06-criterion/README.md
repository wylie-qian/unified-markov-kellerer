# Round 06 — Exact energy-clock summability criterion

- [SUMMABILITY_CRITERION.md](SUMMABILITY_CRITERION.md): mathematical proof draft of an exact universal criterion in the deterministic-start isotropic locally bi-Lipschitz schedule class. Positive direction: weak Poincare and backward variance dissipation. Negative direction: rare rectangle and amplified germ obstruction. Includes the sharp double-logarithmic exponent and smooth-input counterexamples.
- [CriterionCore.lean](CriterionCore.lean): uncompiled Lean 4.19.0 / Mathlib v4.19.0 scalar candidate.
- [verify_criterion.py](verify_criterion.py) and [verification.log](verification.log): actual exact rational and symbolic checks.

Run `python3 verify_criterion.py` with SymPy installed. For Lean use `lake update`, `lake exe cache get`, then `lake env lean CriterionCore.lean`.

This round supersedes the proposed conjecture that all sublinear schedules are nonuniversal. It does not classify arbitrary nonregular time schedules, random initial laws, anisotropic corank one, or the general unregularized multidimensional raw-filtration question. The stochastic-process proof is not formally certified; novelty is not independently established.
