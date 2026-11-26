# Multidimensional Markov Martingale Realization and Minimal Regularization

Research archive · initial snapshot: 2026-11-27 (UTC+8)

This repository records an AI-assisted mathematical research project on multidimensional peacocks, Kellerer-type Markov martingale realization, and regularization. The aim is to characterize existence, obstructions, and minimal regularization beyond Gaussian marginals. The manuscripts are research drafts, not peer-reviewed results; priority and the complete stochastic-process arguments require independent review. This archive does not claim a solution to the general multidimensional Kellerer or raw-filtration problem.

## Research snapshot

| Stage | Material | Scope |
| --- | --- | --- |
| 01 | [Gaussian covariance optimization](round-01-gaussian/KELLERER_RESEARCH_REPORT.md) | Exact trace-minimizing covariance repair under prescribed initial and instantaneous ellipticity floors; explicit Gaussian realization; no Loewner-least repair in general. |
| 02 | [Fixed kernel theorem](round-02-general/FIXED_KERNEL_THEOREM.md) | Proposed general fixed spatial smoothing theorem, covariance kernel geometry, and universal rank classification for continuous realization. |
| 02 | [Smooth two-dimensional obstruction](round-02-general/SMOOTH_TWO_DIMENSIONAL_OBSTRUCTION.md) | Draft obstruction for usual right-continuous filtration; strictly positive smooth densities at positive times. |
| 02 | [Initial kernel obstruction](round-02-general/INITIAL_KERNEL_OBSTRUCTION.md) | Draft extension to time-dependent Gaussian kernels with at least two initial null directions. |
| 02 | [Blind subspace obstruction](round-02-general/BLIND_SUBSPACE_OBSTRUCTION.md) | Frozen-branch and blind-subspace mechanisms. |
| 02 | [Literature audit](round-02-general/LITERATURE_AUDIT.md) | Literature dependencies, caveats, and novelty boundaries. |

## Verification and reproducibility

Both stages preserve their original Lean 4.19.0 / Mathlib v4.19.0 project configuration. The archived build logs report successful compilation and standard-axiom-only audits for 11 declarations in stage 01 and 21 in stage 02. These checks concern the listed matrix, integral and probability lemmas, not a complete formalization of the stochastic-process theorems. The archive was packaged without recompiling; original source hashes were verified. Temporary workspace prefixes in logs were redacted for publication (see the archive notes).

With Elan and a network connection, run from each stage's directory:

```sh
cd round-01-gaussian
lake update
lake exe cache get
lake env lean KellererCore.lean
cd ../round-02-general
lake update
lake exe cache get
lake env lean KernelGeometry.lean
lake env lean GermObstructionCore.lean
```

From the repository root, verify the delivered file checksums using `sha256sum -c SHA256SUMS` (or `shasum -a 256 -c SHA256SUMS` on macOS).

## Open research targets

- Classify the initial corank-one case for time-dependent Gaussian smoothing when jumps are allowed.
- Obtain distribution-level necessary and sufficient conditions for Markov realization.
- Resolve the raw natural filtration question distinguished in the regularized Kellerer literature.
- Characterize instance-specific minimum regularization for non-Gaussian marginals under a specified cost.
- Independently check the mathematical drafts, extend formal verification, and establish the exact novelty of the results.

## Reference and citation

The key prior work is Pammer, Robinson and Schachermayer, *A Regularized Kellerer Theorem in Arbitrary Dimension*, [arXiv:2210.13847](https://arxiv.org/abs/2210.13847). The individual reports identify additional mathematical dependencies. Cite the specific manuscript and immutable Git commit when referring to this archive. No new blanket reuse license is assigned by this packaging step; existing third-party rights and attributions remain applicable.
