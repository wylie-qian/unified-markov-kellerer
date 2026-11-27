# Research Master Plan / 研究总纲

**Project:** Multidimensional Markov Martingale Realization and Minimal Regularization  
**Baseline:** round 06, commit 018fff6704f0722674aecc2349abb14f353f23fe (2026-11-27).  
**Status:** open research program. Existing stochastic-process manuscripts are mathematical drafts, not certified solutions.  
**Companion documents:** [proof graph](PROOF_GRAPH.md) · [theorem registry](THEOREM_REGISTRY.md) · [acceptance gates](ACCEPTANCE_CRITERIA.md) · [agent instructions](AGENTS.md).

## 1. Scope and fixed definitions

Work on the continuous state space R^d, with d a positive integer and finite horizon [0,T]. A peacock is a weakly continuous family mu=(mu_t) in P_2(R^d), increasing in convex order (all integrable convex tests, or the equivalent finite convex test convention, with common mean). Write E_mu(t)=int |x|^2 d mu_t and Sigma_mu(t)=Cov(mu_t). Their increments are nonnegative in scalar and Loewner order respectively. The project uses the energy clock theta_mu(t)=t+E_mu(t)-E_mu(0), a strictly increasing homeomorphism. In that clock the scalar energy increment is 1-Lipschitz. This clock depends on the input mu and is NOT interchangeable with a schedule fixed in physical time before mu is chosen.

A Gaussian regularization path Q is continuous, symmetric PSD and nondecreasing in Loewner order on [0,T]. Its initial matrix can be singular. Define nu_t=mu_t*N(0,Q(t)). The convolution describes target one-time laws, not a prescribed pathwise noise coupling.

For a law P on continuous or cadlag paths, let F^0_t=sigma(X_u: u<=t) be its raw natural filtration. Let F^us_t be its completion and right-continuous augmentation (at T take the completion). Ordinary Markov means E[f(X_t)|F_s]=E[f(X_t)|X_s] for all deterministic s<=t and bounded Borel f; strong Markov means the corresponding time-inhomogeneous space-time transition property at stopping times. Martingale always means an integrable genuine martingale, not merely local; in the P_2 setting the terminal second moment gives square integrability. Initial state may be random unless the theorem explicitly restricts it. All exact target marginals are required at every date, not almost every time.

Use the following predicates, with the path class and filtration explicitly attached:

- M(F,path;mu,Q): exists a square-integrable martingale of the specified path class with marginals nu_t, ordinary Markov relative to F.
- SM(F,continuous;mu,Q): the same with strong Markov property. Positive existence results should aim for SM; a negative result for M is stronger than one for SM.
- U(F,path;Q,C): for every mu in a declared class C, M(F,path;mu,Q).
- A(mu;F,path,K): the set of admissible regularizations in the declared class K for which a realization exists.

Never suppress the quantifier order: fixed Q followed by all mu is different from all mu followed by existence of Q(mu). Raw and usual filtration, and continuous and jumping paths, are separate columns.

## 2. Locked top-level goals

### T1 — Universal classification of Gaussian regularization (primary mathematical target)

**T1-P (physical-time fixed covariance):** For arbitrary d>=2 and prescribed Q as above, classify U(usual,continuous;Q,all weakly continuous P_2 peacocks) by an explicit, noncircular mathematical criterion on Q. Establish necessity with counterexamples and sufficiency with a construction. Where possible, strengthen a negative result to exclude cadlag/jumping Markov realizations and strengthen a positive result to strong Markov. Keep these strengthenings separate in the registry. Also settle the corresponding raw-continuous classification and clearly mark the distinct raw-jumping question.

**T1-E (normalized energy-clock fixed covariance):** For every d>=2, classify prescribed matrix paths Q(s) on [0,1] over the class C_d of peacocks with arbitrary initial law and 0<=E_mu(b)-E_mu(a)<=b-a. Begin with deterministic starts and then remove that restriction. Seek a computable criterion on Q, its null subspaces, directional variation and near-zero rate. It must reduce to the round-06 criterion for Q(s)=q(s)I, deterministic starts, and locally bi-Lipschitz increasing q, if that draft survives audit. The general criterion is not assumed to be a minimum-eigenvalue test. If an initially proposed formula fails, exhibit the counterexample and replace it rather than redefining the problem.

Mandatory boundary cases: d=1 benchmark (do not falsely extend a d>=2 obstruction), Q(0)>0, Q(t) singular at positive time, initial nullity >=2, initial nullity exactly one with evolving transverse coordinates, deterministic/random initial law, noncommuting Q(t), plateaus and singular time clocks. Record raw/ordinary/strong/continuous/jumping conclusions separately.

**Completion:** an independently checked if-and-only-if classification for the declared full T1-P and T1-E scopes, with all restrictions and cases explicit, matching positive/negative proofs, and the formalization gates in ACCEPTANCE_CRITERIA.md. A theorem under a new unapproved restriction is a subordinate milestone, not closure of T1. No claim that a completed regularized classification would solve T3.

### T2 — Instance-specific minimal regularization (second major target)

For a given peacock mu and a fixed baseline Q_0(t), declare the admissible repair class K *before* optimizing. The default K consists of continuous Loewner-nondecreasing PSD increments R with R(0)=0; the corrected marginals are mu_t*N(0,Q_0(t)+R(t)). Define

$$J_K(\mu,Q_0)=\inf\{\operatorname{tr}R(T):R\in K,\ SM(\mathrm{usual},\mathrm{continuous};\mu,Q_0+R)\}.$$

The infimum of the empty set is +infinity. The round-03 draft suggests the unrestricted adaptive trace infimum is zero, possibly not attained. Do not present this degenerate objective as a positive optimal noise threshold. It requires a separate audit. To obtain informative positive costs, explicitly specify and justify a restricted class (e.g. a prescribed schedule shape R(t)=a r(t)P, rate/regularity budget, ellipticity floor, or a prescribed quantitative mixing guarantee). State the criterion for admissibility, infimum, attainment, uniqueness if true, and a matching lower bound. Distinguish Pareto/Loewner minimality from least elements and from trace or Wasserstein minimization. Do not silently switch costs or classes.

**Completion:** necessary and sufficient distribution-level feasibility and sharp optimization results in the declared nontrivial class(es), including exact zero-cost/attainment distinctions and constructive realizations or infeasibility witnesses. Recover the Gaussian trace-repair theorem as a consistency check. An arbitrary positive sufficient repair alone is not minimality.

### T3 — The historical raw-filtration question (independent long-term target)

In the scope of the unregularized multidimensional Kellerer question discussed in Pammer–Robinson–Schachermayer (PRS, 2025, Remark 4.5; verify the exact published statement before claiming resolution), either prove that every eligible weakly continuous multidimensional P_2 peacock admits a Markov martingale in its raw natural filtration, or give a counterexample excluding every eligible realization. For the working formulation use Q=0, d>=2, and allow cadlag martingales/jumps. Check whether the cited original problem permits an even larger process class and match that scope before declaring a solution.

**Completion:** an actual proof of the original yes/no question (or a precisely documented stronger theorem implying its answer), independent mathematical review, literature priority review and the formalization gates. A failure of continuous paths, failure of a particular SDE, failure after usual augmentation, or a forced event in F_{0+} alone does not answer this question. At zero the raw history is exactly sigma(X_0). A construction needs an obstruction at a positive raw time or another argument valid for the raw filtration. A positive proof must preserve the full transition structure without relying on weak closedness of Markov laws. T3 is not an automatic consequence of T1 or T2.

## 3. Work packages and order of attack

| ID | Deliverable | Priority | Dependencies / evidence of closure |
|---|---|---|---|
| WP0 | Audit the round-06 proof and current library dependencies; check all prior claims used in the next argument | P0, parallel with new work | [A1–A9](ACCEPTANCE_CRITERIA.md); independent review of flux, local PDE, variance identity, clock comparison, rare-branch construction; actual compiler results or explicit blocker |
| WP1 | T1-P: fixed-path initial corank one, positive-time Q>0, evolving transverse coordinates | P0 | New general proof or counterexample, not only frozen transverse/fiber examples |
| WP2 | T1-E: anisotropic covariance classification, deterministic start | P0 | Directional necessary and sufficient tests; compare smallest/second-smallest eigenvalues and integrated directional dissipation; investigate rotating directions |
| WP3 | Remove local bi-Lipschitz assumption and deterministic initial law in T1-E | P1 | Singular/flat clocks, conditional entrance defect given X_0; recover round-06 special case |
| WP4 | Integrate full T1-P/T1-E statements, publish unified theorem and proof | P1 | WP0–WP3, case table and no hidden restrictions |
| WP5 | Define nontrivial instance-specific cost(s), derive sharp T2 bounds and attainment | P2 | T1 and distribution-specific geometry; not just unrestricted zero infimum |
| WP6 | Attack T3 independently; search positive-time raw memory obstructions or new compactness method | P1 exploratory, do not conflate with WP1 | Exact PRS question; failure and success cases in raw filtration |
| WP7 | Formalization and literature review | P0 continuous | Pin environment, close proof graph, run CI, audit actual theorem signatures and axioms; independent reviewers |

The next mathematical iteration (round 07) should prioritize WP1 and WP2. Begin by trying to break the simplest anisotropic extensions of the scalar criterion using one/two blind directions and direction rotation. Separately test sufficiency via a conditional weak Poincare/variance dissipation estimate. WP0 must check the central round-06 analytic argument before using it as a certified base. WP7 should run in parallel. If the general question remains unresolved, preserve the precise strongest proved subcase and explicit missing lemma.

## 4. Present baseline and falsifiable checkpoints

Round 06 has a draft scalar equivalence for deterministic starts, d>=2, Q=qI and positive-time local bi-Lipschitz q:

$$\mathcal D(q)\quad\Longleftrightarrow\quad
\forall C>0,\ \sum_{n\ge0}\exp(-C\,2^{-n}/q(2^{-n}))=\infty.$$

Its negative direction permits jumping candidates, and needs less regularity on q than the positive direction. Positive direction: PSD flux, Gaussian smoothing, local SDE/PDE theory, backward variance, weak Poincare and divergent entrance dissipation. Negative direction: rare rectangular branch, separated convex barriers, summable classifier changes, nontrivial germ. The "all sublinear schedules fail" conjecture from earlier rounds is superseded; do not resurrect it. The round-06 draft must be checked in its own right.

Checkpoints for further theories:

- Recover the linear, ordinary log-power, and double-log thresholds in the existing scalar scope.
- Explain what changes if only one noise direction vanishes at zero or if two directions vanish at different rates; do not claim that a Markov projection is Markov.
- Preserve exact marginals and the martingale constraints after conditioning, time change, or smoothing.
- Distinguish existence of a process from uniqueness/well-posedness for every possible starting point.
- When conjecturing necessity, give an obstruction for **every** candidate realization, not a single non-Markov example.

## 5. Project governance

Use stable theorem IDs and separate mathematical/Lean/novelty states from THEOREM_REGISTRY.md. Do not erase superseded or unsuccessful arguments; mark them with the specific reason and replacement. Keep each round immutable after publication except for explicitly logged corrections. The root README indexes results but the master plan, proof graph and registry define the current research contract.

Any change of top-level target, hypothesis, cost or acceptance rule must be documented and justified; a weakened target cannot be counted as the original target's completion. Changes to the research plan do not establish a theorem. Historical importance is assessed only after mathematical correctness and prior-art review, not by code length or number of rounds.
