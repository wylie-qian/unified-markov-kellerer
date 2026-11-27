# Theorem Registry / 定理台账

Baseline 018fff6704f0722674aecc2349abb14f353f23fe. Use this as the status ledger, not as a proof or a priority claim. M/L/N levels are defined in [ACCEPTANCE_CRITERIA.md](ACCEPTANCE_CRITERIA.md). M2 means written derivation pending independent verification, not a certificate. L2 in the **core** column never transfers to the entire statement. N1 = preliminary literature comparison, not verified novelty.

## 1. Top-level targets

| ID | Exact target | Status | Next blocking obligation |
|---|---|---|---|
| T1-P | Universal usual-continuous Markov realizability for all weakly continuous P_2 peacocks and any prescribed continuous monotone PSD covariance Q in physical time | OPEN (M0/L0/N1) | WP1: evolving-transverse corank one, combine and audit existing branches |
| T1-E | Universal energy-clock criterion for arbitrary matrix schedules and arbitrary initial laws | OPEN (M0/L0/N1) | WP2 anisotropic deterministic-start, then WP3 random starts/nonregular clocks |
| T2 | Instance-specific feasibility/minimum in a prospectively specified nontrivial regularization class and cost | OPEN (M0/L0/N1) | Separate trivial zero infimum from attainment; formulate constrained optimization |
| T3 | Unregularized multidimensional raw-filtration problem matching PRS original scope | OPEN (M0/L0/N1) | New proof of existence or all-candidate obstruction in raw filtration; usual germ cannot close it |

## 2. Existing claims

| ID | Claim and exact restriction | Manuscript / section | Math | Lean for full stochastic statement | Lean core | Novelty | Dependencies / principal unresolved audit |
|---|---|---|---|---|---|---|---|
| R01-1 | Arbitrary finite-dimensional PSD repair R>=0,R>=B: unique trace minimizer B_+; integral optimum | [R01 report](round-01-gaussian/KELLERER_RESEARCH_REPORT.md) | M2 | Not applicable to isolated matrix lemma; full Gaussian theorem L0 | L2 archived | N1 | Real spectral calculus; verify exact scope of named core declarations |
| R01-2 | Gaussian peacock optimal increasing covariance repair under initial and diffusion ellipticity floors; original-time Ito iff AC covariance in declared class | [R01 report](round-01-gaussian/KELLERER_RESEARCH_REPORT.md) | M2 | L0 | L2 matrix/integral only | N1 | Ito covariance identity, AC decomposition, Gaussian independent-increment construction |
| R01-3 | Feasible repair can have no Loewner least element | [R01 report](round-01-gaussian/KELLERER_RESEARCH_REPORT.md) | M2 | L2 for archived matrix counterexample, not every possible lifted statement | L2 | N1 | Do not confuse least with minimal trace or Pareto minimal |
| R02-1 | Fixed positive C_b^2 centered density with finite second moment suffices for usual continuous strong Markov realization, arbitrary weakly continuous P_2 peacock | [Fixed kernel, Thm 2.1](round-02-general/FIXED_KERNEL_THEOREM.md) | M2 | L0 | L2 PSD/integral only | N1 | F1–F5, including degenerate square-root estimate; actual strong Markov construction |
| R02-2 | Fixed kernel, AC energy iff original-time Ito; kernel a(t,x)=kernel Sigma'(t) in AC setting | [Fixed kernel, Thm 2.1](round-02-general/FIXED_KERNEL_THEOREM.md) | M2 | L0 | L2 positive-weight kernel lemma | N1 | R02-1, covariance budget, analytic lifting |
| R02-3 | Fixed Gaussian Q universal for continuous strong Markov realization iff Q>0 | [Fixed kernel](round-02-general/FIXED_KERNEL_THEOREM.md) | M2 | L0 | L2 partial | N1 | R02-1 and continuous support-gap contradiction; no negative claim for jumps |
| R02-4 | Smooth positive-time 2D marginal obstruction to usual Markov, allows jumping candidates | [Smooth 2D obstruction](round-02-general/SMOOTH_TWO_DIMENSIONAL_OBSTRUCTION.md) | M2 | L0 | L2 independent-event/threshold core | N1 | Alternating clocks, summable classifier error, initial germ |
| R02-5 | Fixed continuous monotone Q with initial nullity >=2: exists peacock excluding every usual Markov realization, even jumps | [Initial kernel](round-02-general/INITIAL_KERNEL_OBSTRUCTION.md), [Blind subspace](round-02-general/BLIND_SUBSPACE_OBSTRUCTION.md) | M2 | L0 | L2 partial | N1 | R02-4 mechanism, adaptive counterexample clock, independence from full initial state |
| R03-1 | Adaptive vanishing added noise on ker Q(0), arbitrarily small terminal trace; usual continuous strong Markov, initial law preserved | [Entrance, Thm A](round-03-entrance/ENTRANCE_THEOREMS.md) | M2 | L0 | L1 | N1 | F1–F5 at singular entrance, Gaussian bounds and integrability, actual strong uniqueness |
| R03-2 | Fixed Q universal raw continuous-path realization iff Q(t)>0 for every t>0 | [Entrance, Thm B](round-03-entrance/ENTRANCE_THEOREMS.md) | M2 | L0 | L1 partial | N1 | F1–F5 positive times, raw initial sigma-field, continuous support gap; not raw-jumping classification |
| R03-3 | Entrance defect conditional variance identity and Lipschitz upper estimate | [Entrance, Thm C](round-03-entrance/ENTRANCE_THEOREMS.md) | M2 | L0 | L1 | N1 | Conditional projections, reverse martingale convergence, actual Lipschitz version |
| R04-1 | Deterministic initial point, linear energy-clock noise with uniformly elliptic bounded covariance rate: continuous usual strong Markov | [Critical scale, Thm 4.1](round-04-critical-scale/CRITICAL_SCALE_THEOREMS.md) | M2 | L0 | L1 | N1 | F1–F5, log-time scaling, killed heat-kernel minorization and coalescence; R06 provides alternate scalar route |
| R04-2 | Sharp power exponent in deterministic-start isotropic energy clock; earlier log-power p>2 obstruction | [Critical scale, Cor 4.2/Thm 4.3](round-04-critical-scale/CRITICAL_SCALE_THEOREMS.md) | M2 | L0 | L1 | N1 | R04-1 plus barrier mechanism; refined by R05 and R06 |
| R04-3 | Initial corank one, transverse marginal constant, constant transverse H and positive-time scalar q: usual continuous Markov | [Critical scale, Thm 4.4](round-04-critical-scale/CRITICAL_SCALE_THEOREMS.md) | M2 | L0 | L1 partial | N1 | Lowther measurable fiber laws, time-zero density weighting, usual filtration disintegration; not general corank one |
| R05-1 | General convolution-noise tail-budget summability in two blind directions forces germ obstruction | [Exponential barrier, Thm 5.1](round-05-barrier/EXPONENTIAL_BARRIER.md) | M2 | L0 | L1 | N1 | N2–N5, one-time labels only |
| R05-2 | Gaussian directional tail series with explicit sufficient constant; every positive ordinary log-power correction fails in deterministic-start energy clock | [Exponential barrier, Cor 5.2–5.3](round-05-barrier/EXPONENTIAL_BARRIER.md) | M2 | L0 | L1 | N1 | R05-1 and R04-1 for positive endpoint; superseded for scalar regular class by R06 |
| R06-1+ | Scalar all-C divergence sufficient for every deterministic-start d>=2 peacock with 1-Lipschitz energy, q locally bi-Lipschitz away from zero | [Summability, Thm 6.1, §§2–6](round-06-criterion/SUMMABILITY_CRITERION.md) | M2 | L0 | L1 | N1 | E1–E5 and F1–F5; highest-priority independent audit |
| R06-1− | Failure of scalar all-C divergence gives a counterexample excluding every usual Markov candidate even with jumps, for continuous nondecreasing q | [Summability, Thm 6.1, §7](round-06-criterion/SUMMABILITY_CRITERION.md) | M2 | L0 | L1 | N1 | Rare rectangle at fixed energy, N1–N5; smooth input extension |
| R06-1 | Combined exact scalar iff under same regular class | [Summability, Thm 6.1](round-06-criterion/SUMMABILITY_CRITERION.md) | M2 | L0 | L1 | N1 | Both R06-1+ and R06-1−, audit all shared assumptions |
| R06-2 | Double-logarithmic q(s)=eta*s/[log log(e^e/s)]^p universal iff p<1, all eta>0 in stated scalar class | [Summability, Cor 6.2](round-06-criterion/SUMMABILITY_CRITERION.md) | M2 | L0 | L1 | N1 | R06-1 and exact series comparison |

For scope details use the manuscript, not an abbreviated row. The L2 assignments refer to archived logs for the listed cores, not new compilation in this update. No row above has L4 for a full stochastic-process theorem or N3. No independent referee-level sign-off is recorded. The registry deliberately avoids inflating maturity on the basis of earlier progress messages.

## 3. Active open lemmas / next round

| ID | Statement to resolve (not asserted) | Status | Pass criterion |
|---|---|---|---|
| O-01 | General initial corank-one fixed Q, Q(t)>0 for t>0, evolving transverse laws: universal usual Markov? | M0 | Decide full quantifiers; if dependence on Q, give the exact criterion with necessity and sufficiency. Excluding continuous paths only does not exclude jumps. |
| O-02 | Anisotropic extension of R06-1 for deterministic initial state and general matrix Q in normalized energy clock | M0 | Prove matching directional conditions or refute simple eigenvalue candidates. Address direction rotation and noncommuting increments; reduce to scalar case. |
| O-03 | Conditional entrance defect for random initial laws, rather than germ triviality | M0 | Bound E Var(P_{s,r}g(M_s) | M_0) by usable energy/dissipation and classify the corresponding schedule class |
| O-04 | Remove local strict positive derivative/bounded derivative assumption in R06 positive direction | M0 | Treat plateaus/singular clocks or prove counterexample to extension |
| O-05 | Instance-specific sharp regularization with declared nontrivial cost/constraints | M0 | Construct and prove optimum or nonattainment; zero infimum not sufficient |
| O-06 | General raw-filtration unregularized problem | M0 | Match original PRS problem, not right-continuous germ argument |
| O-07 | Complete formalization of R06-1 in Lean | M0/L0 for full theorem | Genuine continuous-space stochastic statement, bridge lemmas and L4 audit; core CI alone insufficient |

## 4. Formal artifact inventory

| Stage | Core source | Evidence |
|---|---|---|
| 01 | [KellererCore.lean](round-01-gaussian/KellererCore.lean) | [archived log](round-01-gaussian/lean_build.log), 11 audited declarations |
| 02 | [KernelGeometry.lean](round-02-general/KernelGeometry.lean), [GermObstructionCore.lean](round-02-general/GermObstructionCore.lean) | [archived log](round-02-general/lean_build.log), 21 audited declarations |
| 03 | [EntranceCore.lean](round-03-entrance/EntranceCore.lean) | [verification record](round-03-entrance/verification.log), uncompiled candidate |
| 04 | [CriticalScale.lean](round-04-critical-scale/CriticalScale.lean) | [verification record](round-04-critical-scale/verification.log), uncompiled candidate |
| 05 | [BarrierCore.lean](round-05-barrier/BarrierCore.lean) | [verification record](round-05-barrier/verification.log), uncompiled candidate; finite tests |
| 06 | [CriterionCore.lean](round-06-criterion/CriterionCore.lean) | [verification record](round-06-criterion/verification.log), uncompiled candidate; finite tests |
| CI | [.github/workflows/lean-core-audit.yml](.github/workflows/lean-core-audit.yml) | Configured; no successful transcript in baseline record |

## 5. Superseded conjectures and restrictions

- "Every q=o(t) schedule fails" was an earlier proposed direction, not an accepted theorem; R06-1+ proposes a counterexample to it via q=t/sqrt(log log(e^e/t)). Preserve this distinction.
- R05 fixed tail exponent constant 512 is sufficient, not optimal; the rare-branch construction in R06 varies the exponent constant. R06 is still restricted to the stated scalar class for the equivalence.
- Full initial nullity >=2 obstruction does not decide corank one. The frozen-transverse result is a subclass, not a resolution.
- No previous round resolves the PRS unregularized raw question.

## 6. Update format (append or update with change history)

For every new or modified claim supply: ID; exact theorem statement or path/section; M/L/N status; essential dependencies and proof-gap list; changed hypotheses relative to prior ID; named Lean declaration(s) and exact source/toolchain hash; compiler evidence if any; prior-art sources and open checks; immutable commit or PR; reviewer and findings; target/work-package impact. Never replace an OPEN status by a percentage. If a draft fails, mark MX or MB and propagate to dependent rows. Preserve original text/commit for traceability.
