# AGENTS.md — Kellerer research protocol

These repository instructions apply to all assistants, code agents, and mathematical proof agents working on this project. They are project-level guidance, subordinate to the user's explicit current task and applicable tool/safety policies.

## 1. Read before acting

1. [RESEARCH_MASTER_PLAN.md](RESEARCH_MASTER_PLAN.md): locked goals T1-P/T1-E, T2, T3, work-package priorities and precise quantifiers.
2. [PROOF_GRAPH.md](PROOF_GRAPH.md): dependency DAG and proof obligations.
3. [THEOREM_REGISTRY.md](THEOREM_REGISTRY.md): current maturity and blocking lemmas.
4. [ACCEPTANCE_CRITERIA.md](ACCEPTANCE_CRITERIA.md): mathematical/formal/novelty evidence levels and acceptance gates.
5. Relevant full manuscript(s), source(s), current README and latest commit. Do not rely solely on prior chat summaries or success claims.

Resolve the current branch/head and inspect changes since your baseline. Use actual repository data and preserve source provenance. The baseline for this guidance is round 06; do not assume it stays current.

## 2. Mission and priorities

The aim is a rigorous, nontrivial, continuous-space multidimensional Markov martingale realization and minimal regularization theory, with eventual independent validation and full Lean verification. T1 is the near-term main target; T3 is a distinct historical open question. Do not retreat into finite price grids or re-prove classical finite LP/Strassen/duality results as the main research contribution. Such tools and examples can be used to test conjectures, not to replace the target.

Next round: target O-01/WP1 (initial corank one, evolving transverse coordinates) and O-02/WP2 (general anisotropic energy-clock classification), while auditing R06-1+ and R06-1− (WP0) and running formal verification (WP7). If the task is narrower, follow the requested scope and explicitly report the target ID. Do not create a new round solely for restating existing results, cosmetic changes, or unconnected scalar lemmas.

A new result is substantive only if it closes a registered proof gap, establishes a stronger precise theorem with strictly broader relevant scope, produces a counterexample that changes the research direction, or repairs an actual defect. If no such result is found, record the obstacle and failed approaches without inventing progress.

## 3. Research loop

### Start
- Write the exact candidate proposition with all quantifiers, covariance path, clock, initial law, filtration and path class.
- Identify its graph parents, known special cases and missing lemma. Check whether it is already in the registry or literature.
- State the planned mathematical change and concrete success/failure test.

### Explore in parallel where available
Use independent workstreams for (1) existence proof, (2) obstruction/counterexample, (3) adversarial proof audit, (4) literature/novelty, and (5) Lean/reproducibility. If real parallel agents are available, use them; if not, do these passes sequentially and report that fact. Do not claim an independent review if the same agent merely repeated its own reasoning. Reviewers should inspect actual manuscript and theorem signatures, not just summaries. Merge only mutually consistent results.

### Prove or refute
- Try to disprove a candidate before building on it: test deterministic/random starts, d=1 vs >=2, null directions, noncommuting/rotating matrices, flat/singular clocks, heavy tails, and raw/usual filtration.
- Prove both directions when claiming iff; exact martingale marginals for all dates, all-candidate exclusion for negative direction.
- Use classical results with precise statement, reference/version and hypothesis check. Do not re-prove a known theorem merely to inflate code length; do not treat an informal citation as an available Lean proof.
- Do not infer Markovness from superposition, projection, marginal matching or weak convergence; do not infer raw obstruction from a usual germ. Keep conditional independence and full initial state explicit.
- If a draft has a gap, mark it, propagate blockers to dependent claims, and either repair or narrow the result transparently. No weakening silently counted as success.
- Keep the distinction between "exists a realization" and "all realizations", strong vs ordinary Markov, continuous vs cadlag, and universal vs instance-adapted schedules.

### Validate
- Run exact symbolic/rational sanity checks where meaningful; report only actual test counts and outputs. Finite tests cannot certify a universal theorem.
- Run the pinned Lean build if tools exist. Use real Lean proof terms/tactics and inspect the elaborated theorem. No sorry, admit, sorryAx, custom axioms, hidden conclusion in hypotheses, or finite surrogate passed off as continuous theorem. Standard axiom subset only. A successful scalar core build is L2, not full-theorem L4.
- Archive actual compiler exit status, diagnostics, source/version hashes and #print axioms output for exact declarations. When unavailable, state NOT RUN and blocker, even if a candidate appears correct. Never fabricate build logs, test runs, citations, agent work, CI status or future results.
- Search primary literature with exact theorem numbers and date; distinguish direct corollaries and known mechanisms from proposed independent contributions. Do not claim a historical breakthrough or priority based on Git commit, missing search results, or self-score.

### Deliver and synchronize
- Use a new round directory for substantive new research, with mathematical manuscript, README, Lean candidate/proofs where relevant, pinned project files, verification.log, optional exact check script, and a ROUND_REPORT.md using the template below. If correcting old work, explicitly record the superseded version, defect and fix; do not erase history.
- Update root README, PROOF_GRAPH.md, THEOREM_REGISTRY.md and acceptance status/evidence as needed. Update the master plan only for a justified change of scope/priorities, not to make a target artificially easier.
- Regenerate/check SHA256SUMS for the delivered file set (do not include the manifest's own hash). Keep CI audit matrix synchronized with actual source paths and audit declaration counts. Preserve source files and existing licenses/attribution.
- Commit changes to the agreed public repository and branch only when authorized; inspect current head, avoid force pushes, respect concurrent edits, and read back all changed files after commit. If publishing is not possible, deliver a verified local patch/package and disclose the blocker. No secrets, private workspace paths, personal records, or unrequested license changes in public files.

## 4. Mandatory round report / handoff template

```markdown
# Round NN — Title
- Base commit / target work package(s):
- Exact mathematical target and hypothesis comparison:
- New theorem IDs and precise statements:
- What is genuinely new relative to prior rounds and literature:
- Positive proof route and dependencies:
- Negative/counterexample route and dependencies:
- Failed attempts / counterexamples / remaining gaps (precise lemma statements):
- Math status M*, Lean status L* (per declaration, full theorem vs core), novelty N*:
- A1–A9 gate delta, with evidence for each PASS:
- Actual verification commands, tool versions, output/log paths, hashes, CI IDs:
- Manuscript/Lean theorem correspondence and all external theorem assumptions:
- Independent review findings (or explicitly not reviewed):
- Updated proof graph / registry references:
- Next 1–3 concrete falsifiable tasks; what would count as closure:
- Published commit and changed-file readback result (or blocker):
```

Use short, factual progress reports: the proved claim, the unresolved gap, the evidence actually obtained, and next task. No promised asynchronous work unless a real scheduling capability has been explicitly used. Do not tell the user the whole paper is Lean-guaranteed until A6 is passed for the actual main theorem. Do not claim T1, T2 or T3 solved unless the specified target meets its acceptance criteria. Acknowledge any choice of additional restriction, cost, proof scope, or unverified dependency.

## 5. Research hygiene and build

Pin Lean/Mathlib to the existing 4.19.0 versions unless the user approves a migration. Use the build instructions in the root README and each round. Keep raw compiler logs and any public redaction separately documented. Do not change mathematical source to match an invented log. A repository readback or SHA256 checksum verifies preservation, not correctness. Preserve prior validated declarations and logs; rerun them if affected by edits. Prior round 01/02 core logs and uncompiled 03–06 sources are not a substitute for full theorem validation.

If a lemma is refuted, prioritize repairing the dependency graph over adding new theorems. If a broader target appears too difficult, record the exact blocker and a worthwhile restricted result, while keeping the top-level target OPEN. The goal is fewer, stronger, well-audited theorems rather than more rounds.
