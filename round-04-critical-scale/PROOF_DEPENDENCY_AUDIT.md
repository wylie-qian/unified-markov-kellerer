# Proof dependency and formal verification audit

## Scope (rounds 01--04)

This repository does NOT contain a complete Lean formalization of the multidimensional stochastic-process theorems.

| Claim | Evidence and coverage |
| --- | --- |
| Round 01 matrix trace minimum, uniqueness, integrated objective, Loewner obstruction | Archived Lean compilation log and 11 printed axiom audits. |
| Round 02 PSD kernel/integral geometry and independent-event/threshold lemmas | Archived Lean compilation log and 21 printed axiom audits. |
| Round 02 fixed smoothing and counterexamples | Mathematical drafts; flux, superposition, SDE and germ-lifting steps are not fully formalized. |
| Round 03 adaptive logarithmic repair, raw continuous-path classification and entrance defect | Mathematical draft; its Lean candidate is not compiler-verified. |
| Round 04 critical energy-clock exponent, logarithmic obstruction and frozen transverse subclass | Mathematical draft; the new scalar Lean source is not compiler-verified. |

The 32 previously audited declarations are declarations in core files, not 32 complete stochastic theorems. The original archived round 01 and 02 files have been hash-checked against their published manifest, not recompiled in this round. A correct kernel proof of a scalar inequality does not establish the analytic argument using that inequality.

## External dependencies and checks to perform

- Multivariate martingale existence and cadlag regularization (Hirsch--Roynette), and jump-chord flux construction/disintegration.
- Time-dependent Gaussian differentiation and the Fokker--Planck superposition principle (Trevisan): confirm all integrability and continuity hypotheses and the true-martingale upgrade.
- Positive-time local SDE well-posedness, conditioning of continuation and time-space strong Markovness. Rounds 02--03 also use a degenerate matrix square-root Lipschitz estimate. Round 04 uses uniform ellipticity on positive times and does not require uniqueness at zero.
- Round 04 heat-kernel input: uniform ellipticity and bounded spatial derivatives after cutoff, time-measurability, bounded drift; killed-kernel minorization is derived in the manuscript. External Gaussian estimates are not formalized.
- Round 04 probability lifting: measurable coupling of residual transition kernels, tightness-controlled coalescence recursion, reverse martingale convergence, initial germ triviality, and Borel--Cantelli.
- Round 04 corank-one subclass: Lowther's scalar fitting and continuity theorem, initial-measurable change of measure, and measurable fiber disintegration. Only frozen transverse dynamics are covered.

No contradiction was found in the checked algebraic certificates. This audit is a dependency review, not an independent formal or peer verification of the main theorems. In particular, checking the displayed equations does not certify all the analytic hypotheses or scholarly priority.

## Reproduction

The new Lean file provides complete tactic scripts without admitted lemmas but requires actual compilation to certify correctness. Run the verification script after installing the pinned Lean 4.19.0 and Mathlib v4.19.0. Logs must distinguish compiler success, diagnostic warnings, and axiom dependencies. Do not replace missing results with inferred success.

The overarching unsolved problems remain the fixed positive-time-nondegenerate corank-one case with evolving transverse coordinates, the general random-initial-law optimal scale, the logarithmic gap, and the unregularized raw-filtration Kellerer problem.
