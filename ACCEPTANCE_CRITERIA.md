# Acceptance Criteria / 验收标准

Applies to all research rounds, papers, and final targets T1–T3. These are hard gates, not a weighted score. A stage may have valid partial deliverables without passing the final target. No agent may waive a gate by describing a special case as a general theorem.

## 1. Evidence levels (independent axes)

**Mathematics M:** M0 open/unproved; M1 conjecture or incomplete proof sketch; M2 complete-looking written derivation with all known dependencies identified, pending independent review; M3 independent line-by-line mathematical review passed, with documented reviewer/checklist and resolved findings; MX refuted; MB blocked by a known gap. Use M2 conservatively: a missing essential lemma is M1 or MB. Math proof by a human/agent is not automatically a theorem certified by Lean.

**Lean L:** L0 no source; L1 source/candidate (including exact arithmetic or symbolic tests, but no successful compiler transcript for this source hash); L2 actual successful kernel check of named core declarations with exact proof scope and axiom audit; L3 actual successful kernel check of a named conditional theorem with explicit nonstandard mathematical assumptions still external; L4 actual successful kernel check of the full intended theorem and dependency closure, no omitted substantive proof obligations and no extra axioms. L3 never implies L4. Track separately for each named declaration, not by file line count. Old logs apply only to their exact source/toolchain hashes.

**Prior art N:** N0 unassessed; N1 preliminary literature comparison; N2 systematic search with direct theorem-by-theorem comparison and exact citations/versions, open concerns logged; N3 independent specialist novelty review (not a guarantee no unpublished result exists). Never infer originality from a missing search result or a timestamp.

A successful finite test is useful evidence but does not upgrade a universal statement's Lean or math status. A committed file is not mathematical validation. A "success" status from an unrelated CI job is not a theorem audit. If no compiler output is accessible, record NOT RUN/UNVERIFIED, not PASS or FAIL by guess.

## 2. Acceptance gates

| ID | Pass condition | Evidence to retain |
|---|---|---|
| A1 — Scope | Exact target ID, quantified dimension, initial laws, peacock regularity, covariance/schedule class, clock, path class and filtration agree with the master plan. No hidden assumption of target conclusion. | Precise theorem statement and comparison to target; counterexamples to weakened variants |
| A2 — Mathematical closure | Every implication has a complete proof, no circular reasoning or essential gap, correct handling of singular/zero times and null sets. Existence means every target time marginal and martingale/Markov constraint. Necessity excludes all candidates allowed by the statement. | Manuscript with stable lemma IDs, dependencies, local assumption checks, independent review findings and repairs |
| A3 — Boundary and regression cases | Recover prior correct special cases; test d=1, d>=2, full rank/singular/corank one, arbitrary random initial, fixed versus adaptive Q, raw versus usual, jumps versus continuous, nonregular clock. Where outside scope, explicitly list nonapplicability. | Case table, adversarial examples, exact sanity scripts and their actual output |
| A4 — External theorem use | Every imported mathematical result has a trustworthy version, theorem number/page, exact statement and verified hypotheses, including measurability, integrability, Markov convention and stopping-time claim. No substitution of a related but weaker theorem. | Literature/dependency ledger and proof links |
| A5 — Core Lean audit | For each new core certificate, use Lean 4.19.0 / Mathlib v4.19.0 (or a separately approved migration), actual compiler exit 0, no errors or warnings; source has no sorry/admit/custom axioms, transitive #print axioms only subset of propext, Classical.choice, Quot.sound. | Actual command, versions/commit, source SHA256, compiler transcript, named theorem signatures, #print axioms outputs |
| A6 — Full main theorem Lean audit | Formalize actual continuous-space theorem (probability laws/filtration/convex order/path classes and final quantifiers), all substantive lemmas discharged. No finite-grid surrogate, tautological encoding, hidden assumption that an optimizer/realization exists, or custom axiom for missing external theorem. #print axioms on the exact main declaration and audit closure. | Full source project, theorem statement-to-paper map, dependency closure, clean build logs and axiom audit |
| A7 — Reproducibility | Immutable source commit, pinned dependencies, hash manifest, documented reproducible commands, independent run/CI with real compiler results. If CI unavailable, report it as such and do not mark accepted. | Commit SHA, artifact hashes, logs, CI job/run identifiers, status, versions |
| A8 — Originality | Distinguish classical tools, direct corollaries, new estimates/structure, and genuinely unresolved target. Check direct prior art and potentially equivalent forms; preserve references and attribution. | Search date, queries and primary-paper comparison, external review or unresolved novelty qualification |
| A9 — Target acceptance | A1–A8 satisfied for the specified complete target, no unresolved blockers in transitive proof graph, reviewer record, and public release with verified scope. | Signed-off acceptance report tied to exact immutable version; do not assign unearned sign-off |

A5 is a stage gate for claiming "core Lean checked." A6 is the nonnegotiable gate for claiming "the main theorem/the paper is guaranteed by Lean." A mathematical paper may be sent for review without A6 if it is truthfully described as a mathematical draft; this does not satisfy the project's full formalization goal.

## 3. Mathematical failure modes to challenge explicitly

- Quantifier reversal: forall mu exists Q(mu) does not imply exists Q forall mu; universal failure is not failure for each individual peacock.
- Filtration change: germ event may belong to usual F_0 but not raw F_0. Weak limits of Markov processes may fail to be Markov. A Markov projection need not be Markov.
- Path class: support-gap obstruction to continuous realization does not exclude jumping realization. Ordinary Markov at deterministic dates is not strong Markov at stopping times.
- Conditional structure: conditional laws at a moving coordinate need not be peacocks; ensure conditional expectation on the correct sigma-field and no assumed shared latent label across dates.
- Clock/spectral geometry: changing time may destroy original dt-Itô property; Q(t) and Q'(t) are different; smallest-eigenvalue bound is not automatically necessary; corank one is not two blind directions.
- Regularity: smooth marginals do not imply SDE well-posedness at zero. Superposition alone does not ensure Markovness; local uniqueness does not ensure all-starting-point nonexplosion. If using PDE/Sobolev Ito, verify all bounds, localization and convergence.
- Optimization: infimum versus minimum, zero-cost limit versus attainment, Loewner least versus trace minimizer. Do not optimize over an undefined or retrospectively chosen class.
- Formal semantics: definitions must not smuggle in the conclusion. Review elaborated statement including instance/type parameters, implicit hypotheses, external assumptions and dependency graph; finite/symbolic tests do not prove a continuous stochastic theorem.

## 4. Reproduction procedure

For an available pinned environment, from the relevant round's directory:

```sh
lake env lean --version
lake update
lake exe cache get
set -o pipefail
lake env lean MainFile.lean 2>&1 | tee lean_build.log
```

Replace MainFile with actual file name(s). Preserve pipeline exit status, source hash before/after, exact dependency revision and all requested #print axioms lines. A cache/download failure is not a Lean proof failure and not a successful compile. Do not remove checks or warnings merely to pass CI; repair the underlying issue. If no executable/network permission, write the actual blocker in verification.log and leave L1. Existing [workflow](.github/workflows/lean-core-audit.yml) is for candidate core files; extend it with the appropriate audit declarations when new proofs are added.

From root run `sha256sum -c SHA256SUMS` (or `shasum -a 256 -c SHA256SUMS` on macOS) after regenerating a correct manifest. A Git blob hash check verifies file transport only; it is not a compile or math check. Do not claim a local command ran if only a GitHub API readback was performed.

## 5. Baseline acceptance status

As of commit 018fff6704f0722674aecc2349abb14f353f23fe:

- Archived round-01/02 logs report successful kernel checks on 11 and 21 core declarations respectively. Their full stochastic-process conclusions are not formalized.
- Round-03/04/05/06 new Lean files are L1; no successful compiler transcript obtained in the project record. The existence of a configured CI workflow is not evidence it passed.
- Round-06 scalar classification has a written draft and exact finite checks, but no documented independent referee-level proof review, no full Lean theorem, no independently certified novelty.
- T1–T3 are NOT accepted. Do not mark the project complete, use a percentage as proof, or claim a historical problem solved until A9 passes for that specific target.

Every future round must include a gate-by-gate delta (PASS / FAIL / NOT RUN / NOT APPLICABLE / BLOCKED, with evidence). A PASS must cite evidence, not an intention.
