# Kellerer covariance research: exact verified scope

This project contains a complete paper proof of minimum added variance for arbitrary-dimensional Gaussian peacocks, an explicit strong Markov realizing process, and a standalone Lean verification of the matrix and continuous-time integral optimization.

It **does not** solve the general multidimensional Kellerer problem or the raw-filtration question.

## Files

- `KELLERER_RESEARCH_REPORT.md`: theorem, complete proof, clock/filtration qualifications, explicit limits of the result.
- `KellererCore.lean`: standalone source; actual spectral positive part, minimum trace, uniqueness, general-measure integrated minimum, and no Loewner-least repair counterexample.
- `lean_build.log`: actual compilation output and axiom audit.
- `lean-toolchain`, `lakefile.toml`: Lean 4.19.0 and Mathlib v4.19.0 pins.
- `SHA256SUMS`: delivered file hashes.

## Reproduce

With Elan installed, run from this directory:

```sh
lake update
lake exe cache get
lake env lean KellererCore.lean
```

There are no project-local module dependencies or separately delivered theorem binaries. The single file imports Mathlib only. The original stochastic process and Gaussian measure arguments are proved in the report, not axiomatized in Lean.

## Main result and interpretation

For continuous Loewner-increasing covariance `Sigma(t)`, Gaussian marginals `N(m,Sigma(t))`, initial covariance floor `kappa I`, and an integrable nonnegative instantaneous diffusion floor `lambda(t) I`, minimize terminal added variance `trace Q(T)` over continuous Loewner-increasing Gaussian noise covariances. An original-time square-integrable Ito realization is possible exactly when `Sigma` is absolutely continuous. The unique minimum-cost noise covariance is

```text
Q*(t) = positivePart(kappa I - Sigma(0))
        + integral_0^t positivePart(lambda(s) I - Sigma'(s)) ds.
```

The realizing process can be chosen as a continuous Gaussian additive strong Markov martingale. Competitors need not be Gaussian processes or Markov. Uniqueness concerns `Q*`, not all realizing processes. The criterion is trace minimality; there need not be a Loewner-least correction, and no Wasserstein minimality is claimed.

The dimension index in Lean is finite because it describes coordinates of a continuous state space `R^d`. It is not a finite set of possible prices. The integral theorems allow an arbitrary measure space, including real time with Lebesgue measure.
