# Round 04 — Critical noise scales

- [CRITICAL_SCALE_THEOREMS.md](CRITICAL_SCALE_THEOREMS.md): sharp power exponent in the deterministic-start class, logarithmic-scale nonexistence, and frozen-transverse corank-one subclass.
- [PROOF_DEPENDENCY_AUDIT.md](PROOF_DEPENDENCY_AUDIT.md): verification boundary of all four rounds.
- [CriticalScale.lean](CriticalScale.lean): scalar recurrence and convex crossing certificates; uncompiled candidate.
- [verification.log](verification.log): actual checks performed and limitations.

Use Lean 4.19.0 / Mathlib v4.19.0. Run `lake update`, `lake exe cache get`, then `lake env lean CriticalScale.lean`. The full stochastic-process results are mathematical proofs using explicitly identified classical results; they are not complete Lean theorems. The general corank-one usual-filtration and unregularized multidimensional raw-filtration problems remain open in this project.
