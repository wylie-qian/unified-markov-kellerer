# Round 05 — Exponential barrier and logarithmic scale

- [EXPONENTIAL_BARRIER.md](EXPONENTIAL_BARRIER.md): tail-summability obstruction for general convolution noise, Gaussian specialization, exact log-power family (combining the round-04 positive theorem draft with the new negative theorem), and a smooth input peacock.
- [BarrierCore.lean](BarrierCore.lean): uncompiled scalar Lean candidate.
- [verify_barrier.py](verify_barrier.py) and [verification.log](verification.log): actual exact rational and symbolic sanity tests.

Reproduction: `python3 verify_barrier.py` with SymPy installed; for Lean 4.19.0 / Mathlib v4.19.0 run `lake update`, `lake exe cache get`, `lake env lean BarrierCore.lean`.

Neither the scalar checks nor a future scalar compilation can certify the full stochastic theorem. The general usual-filtration corank-one and unregularized raw-filtration problems remain open in this project. The log-log/iterated-log boundary beyond the stated summability sufficient condition for obstruction remains unclassified.
