# Round 03 — entrance and adaptive regularization

- [ENTRANCE_THEOREMS.md](ENTRANCE_THEOREMS.md): mathematical manuscript. Adaptive zero-initial-noise repair; exact universal raw continuous-path classification; quantitative entrance criterion.
- [EntranceCore.lean](EntranceCore.lean): scalar algebraic certificates, **not yet compiler-verified**.
- [verification.log](verification.log): actual environment check and limits.

Reproduce with Lean 4.19.0 / Mathlib v4.19.0:

```sh
lake update
lake exe cache get
lake env lean EntranceCore.lean
```

The usual-filtration fixed-path corank-one case with positive definite covariance for all positive times is not solved. The raw result is for continuous paths; no claim of solving the general unregularized raw-filtration conjecture. These are research drafts, not priority-certified results.
