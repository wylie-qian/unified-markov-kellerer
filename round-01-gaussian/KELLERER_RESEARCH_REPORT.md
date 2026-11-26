# Multidimensional Markov Realization: Exact Gaussian Covariance Repair and the Limits of a Minimal-Regularization Programme

**Date:** 2026-11-27  
**Status:** Complete mathematical proofs for the stated Gaussian-marginal problem; kernel-checked matrix and continuous-time integral optimization. The general multidimensional Kellerer problem and its raw-filtration variant are **not solved** here.  
**Formal environment:** Lean 4.19.0 / Mathlib v4.19.0.

## 中文摘要

本稿首先把“最小正则化”明确为一个有指定目标、指定噪声类型与指定代价的优化问题。对于任意维数的连续 Gaussian marginals（高斯边缘）\(N(m,\Sigma(t))\)，允许加入协方差为 \(Q(t)\) 的独立高斯鞅噪声，要求原始时间下的 Itô 实现、初始协方差下界 \(\kappa I\) 及瞬时扩散协方差下界 \(\lambda(t)I\)，并最小化 \(\operatorname{tr}Q(T)\)。我们证明：可行性当且仅当 \(\Sigma\) 绝对连续；可行情形唯一的最优噪声协方差为
\[
Q^*(t)=(\kappa I-\Sigma(0))_+
+\int_0^t(\lambda(s)I-\Sigma'(s))_+\,ds.
\]
该结论允许任意实现过程作为竞争者，不预设竞争过程本身是 Gaussian process。达到者可以显式取为具有确定性扩散系数的强 Markov 高斯鞅。我们同时证明矩阵偏序下的最小修正可能不存在，并说明原时间 Itô 实现的时钟障碍。Lean 实际验证的是任意维矩阵最优性、唯一性、一般测度下积分最优性与一个多参数反例；没有把尚未证明的随机过程存在性伪装成公理。此稿是严格限定范围的研究进展，不是统一的一般 Kellerer 理论，也不宣称这些谱分析结论具有首次发现的优先权。

## 1. What must be specified before asking for a minimum

A continuous-time peacock is a family \((\mu_t)_{0\le t\le T}\) of probability measures on \(\mathbb R^d\) increasing in convex order. A Markov martingale realization is a stochastic process with these marginals which is both a martingale and Markov with respect to the specified filtration. Throughout the main theorem, time is the original deterministic coordinate \(t\), the filtration satisfies the usual conditions, and Markov processes may be time inhomogeneous.

The request for a universally “minimal regularization” leaves several independent choices open:

1. Raw natural filtration versus its completed, right-continuous augmentation.
2. Continuous or càdlàg Markov realizations versus an original-clock Itô representation.
3. Scalar Gaussian smoothing, matrix Gaussian smoothing, or a different class of kernels.
4. A smallest element in covariance order versus minimization of a scalar cost.
5. Whether deterministic time change is permitted.

These choices cannot be interchanged. The results below show that an order-least correction can fail to exist even for smooth Gaussian peacocks, and that an arbitrarily small positive smoothing level need not have a minimum. A well-posed optimization must therefore state its loss functional and realization class.

The established regularized Kellerer theorem of Pammer–Robinson–Schachermayer [PRS25] supplies general non-Gaussian existence after Gaussian smoothing, while its four-dimensional examples exclude unregularized Markov realizations under the usual filtration. Remark 4.5 explicitly separates an unresolved raw-filtration question. We use those results only to delimit the general problem; we do not reprove them or claim to settle their open case.

## 2. Matrix notation and the exact spectral optimization lemma

Write \(\mathbb S^d\) for real symmetric matrices, \(\mathbb S_+^d\) for positive semidefinite matrices, and \(A\succeq B\) when \(A-B\in\mathbb S_+^d\). For a spectral decomposition
\[
B=U\operatorname{diag}(b_1,\ldots,b_d)U^\top,
\]
define
\[
B_+=U\operatorname{diag}(\max(b_1,0),\ldots,\max(b_d,0))U^\top.
\tag{2.1}
\]
This definition is independent of the orthonormal eigenbasis. In the formal code an actual Mathlib spectral decomposition defines the matrix; existence of a suitable matrix is not an assumed input.

**Lemma 2.1 (Exact trace repair).** For every \(B\in\mathbb S^d\),
\[
\min\{\operatorname{tr}R:R\succeq0,\ R\succeq B\}
=\operatorname{tr}B_+
=\sum_i\max(b_i,0).
\tag{2.2}
\]
The minimum is attained by \(R=B_+\), and this minimizer is unique.

**Proof.** In an orthonormal eigenbasis of \(B\), write \(S=U^\top R U\). The two semidefinite constraints give
\[
S_{ii}\ge0,\qquad S_{ii}\ge b_i.
\]
Summing yields the lower bound in (2.2), since trace is invariant under orthogonal conjugation. The diagonal matrix with entries \(\max(b_i,0)\) satisfies both constraints, proving attainment.

If trace equality holds, every nonnegative diagonal gap is zero, so \(S_{ii}=\max(b_i,0)\). A positive semidefinite matrix with a zero diagonal entry has its corresponding row and column zero: for example this follows from its nonnegative quadratic form or its square-root factorization. If \(b_i\le0\), apply this observation to \(S\). If \(b_i>0\), apply it to \(S-\operatorname{diag}(b)\), whose \(i\)-th diagonal entry is zero. Thus every off-diagonal entry of \(S\) vanishes and \(S=\operatorname{diag}(b_+)\). Hence \(R=B_+\). QED.

An equivalent dual certificate is the orthogonal projection \(P_+\) onto the strictly positive eigenspaces of \(B\):
\[
\operatorname{tr}R\ge\operatorname{tr}(P_+R)
\ge\operatorname{tr}(P_+B)=\operatorname{tr}B_+.
\]
The matrix optimization in Lemma 2.1 is classical spectral/semidefinite optimization, not a proposed new foundational theorem.

## 3. The original-clock obstruction

We first establish a necessary property of any square-integrable Itô realization, whether Gaussian, Markov, or neither.

**Lemma 3.1 (Covariance clock).** Let
\[
M_t=M_0+\int_0^t\sigma_s\,dW_s
\]
be a square-integrable martingale on a finite interval. Its covariance \(C(t)\) is entrywise absolutely continuous, and
\[
C(t)-C(0)=\mathbb E\int_0^t\sigma_s\sigma_s^\top\,ds.
\tag{3.1}
\]
In particular, if \(\sigma_s\sigma_s^\top\succeq\lambda(s)I\) almost everywhere for \(ds\otimes\mathbb P\), then
\[
C'(s)\succeq\lambda(s)I\quad\text{for almost every }s.
\tag{3.2}
\]

**Proof.** Apply the Itô isometry and polarization to the coordinates of the martingale increment. The cross moment with \(M_0-\mathbb EM_0\) is zero by conditional expectation. Square integrability makes the expected trace of the quadratic variation finite; every matrix entry is dominated in absolute value by the trace of the positive semidefinite integrand, so Fubini applies entrywise. This proves (3.1) and absolute continuity. Inequality (3.2) follows by expectation and differentiation. QED.

**Lemma 3.2 (Positive covariance increments cannot cancel singular clocks).** Suppose \(\Sigma,Q:[0,T]\to\mathbb S_+^d\) are continuous and Loewner nondecreasing. If \(C=\Sigma+Q\) is absolutely continuous, then both \(\Sigma\) and \(Q\) are absolutely continuous.

**Proof.** For any positive semidefinite matrix \(H\),
\[
|H_{ij}|\le\sqrt{H_{ii}H_{jj}}\le\operatorname{tr}H.
\]
For each interval \([a,b]\), both covariance increments are positive semidefinite. Therefore
\[
|\Sigma_{ij}(b)-\Sigma_{ij}(a)|
\le\operatorname{tr}(\Sigma(b)-\Sigma(a))
\le\operatorname{tr}(C(b)-C(a)).
\tag{3.3}
\]
Sum (3.3) over any finite family of disjoint intervals of sufficiently small total length. Absolute continuity of \(\operatorname{tr}C\) proves absolute continuity of every entry of \(\Sigma\). The same argument works for \(Q\). QED.

These statements concern an Itô integral against the original clock \(dt\). They do not obstruct a continuous strong Markov realization under a different deterministic clock.

**Example 3.3 (Singular clock with smooth marginals).** Let \(F\) be the Cantor function on \([0,1]\) and set
\[
\Sigma(t)=(1+F(t))I_d.
\tag{3.4}
\]
The Gaussian marginals \(N(0,\Sigma(t))\) are nondegenerate with smooth, everywhere positive densities and form a weakly continuous peacock. They admit a continuous Gaussian strong Markov realization by Brownian motion at time \(F(t)\) with independent \(N(0,I_d)\) initial law. They admit no original-clock square-integrable Itô realization. More strongly, no continuous Loewner-increasing covariance addition \(Q\) can repair this defect: otherwise Lemmas 3.1–3.2 would force \(\Sigma\) to be absolutely continuous. Adding \(\varepsilon(t+\delta)I_d\) does not remove the singular component of the covariance clock.

This observation is a time-regularity qualification, not a solution of the multidimensional Kellerer problem. When applying [PRS25], its deterministic time normalization in Remark 2.1 must be respected; a diffusion in a normalized clock need not be a \(dt\)-Itô diffusion after pulling back to an arbitrary singular clock.

## 4. Main theorem: exact minimum added variance for Gaussian peacocks

Fix an arbitrary finite dimension \(d\ge1\), a finite horizon \(T>0\), and a mean vector \(m\in\mathbb R^d\). Let
\[
\mu_t=N(m,\Sigma(t)),\qquad 0\le t\le T,
\tag{4.1}
\]
where \(\Sigma:[0,T]\to\mathbb S_+^d\) is continuous and Loewner nondecreasing. This is the general continuous Gaussian peacock with constant mean. The covariance may be singular; imposing \(\Sigma(0)\succ0\) gives a subclass with smooth positive densities at every date, and every conclusion below still holds.

Fix \(\kappa\ge0\) and a measurable integrable function \(\lambda:[0,T]\to[0,\infty)\). An allowed noise covariance is a continuous Loewner-nondecreasing curve
\[
Q:[0,T]\to\mathbb S_+^d.
\]
Such curves are precisely covariance curves of continuous centered Gaussian martingales with independent increments, allowing an independent Gaussian initial random variable. Convolution changes the desired marginals to
\[
\mu_t^Q=\mu_t*N(0,Q(t))=N(m,\Sigma(t)+Q(t)).
\tag{4.2}
\]
We require a square-integrable original-clock Itô martingale realization of (4.2), with
\[
\Sigma(0)+Q(0)\succeq\kappa I_d,
\qquad
\sigma_t\sigma_t^\top\succeq\lambda(t)I_d
\quad (dt\otimes\mathbb P)\text{-almost everywhere}.
\tag{4.3}
\]
The objective is the **total added variance**
\[
J(Q)=\operatorname{tr}Q(T).
\tag{4.4}
\]
The competing realizations may be any square-integrable Itô martingales, including ones that are not Gaussian processes and are not Markov. The theorem constructs a strong Markov minimizer, so imposing Markovity on the competitors does not change the optimal cost. We prescribe convolved one-date marginals; we do not require a competitor to be a pathwise sum of a preselected original process and noise.

**Theorem 4.1 (Exact Gaussian covariance regularization).** Under (4.1)–(4.4):

1. A feasible correction exists if and only if \(\Sigma\) is entrywise absolutely continuous.
2. In the feasible case, the unique cost-minimizing covariance correction is
   \[
   \boxed{
   Q^*(t)=(\kappa I_d-\Sigma(0))_+
   +\int_0^t(\lambda(s)I_d-\Sigma'(s))_+\,ds.
   }
   \tag{4.5}
   \]
3. The exact minimum is
   \[
   \boxed{
   J^*=\operatorname{tr}(\kappa I_d-\Sigma(0))_+
   +\int_0^T\operatorname{tr}(\lambda(s)I_d-\Sigma'(s))_+\,ds.
   }
   \tag{4.6}
   \]
4. A realizing process is the explicit continuous Feller, time-inhomogeneous strong Markov martingale
   \[
   M_t^*=\xi+\int_0^t a^*(s)^{1/2}\,dW_s,
   \quad
   a^*(s)=\Sigma'(s)+(\lambda(s)I_d-\Sigma'(s))_+,
   \tag{4.7}
   \]
   with \(\xi\sim N(m,\Sigma(0)+(\kappa I_d-\Sigma(0))_+)\) independent of the standard \(d\)-dimensional Brownian motion.

The uniqueness statement concerns the correction curve \(Q^*\). It does not claim that all realizing processes have the same law.

### 4.1. Necessity and the lower bound

Suppose \(Q\) and an Itô realization are feasible. Lemma 3.1 makes \(C=\Sigma+Q\) absolutely continuous, and Lemma 3.2 makes \(\Sigma,Q\) absolutely continuous separately. Thus non-AC \(\Sigma\) is impossible regardless of how much allowed noise is added.

In the AC case choose measurable derivative versions and write \(A(t)=\Sigma'(t)\), \(R(t)=Q'(t)\). Monotonicity gives \(A(t),R(t)\succeq0\) almost everywhere. The covariance identity, even for a non-Gaussian competitor, gives
\[
A(t)+R(t)=\mathbb E[\sigma_t\sigma_t^\top]\succeq\lambda(t)I_d.
\tag{4.8}
\]
The initial correction obeys
\[
Q(0)\succeq0,\qquad Q(0)\succeq\kappa I_d-\Sigma(0),
\]
and the rate correction obeys
\[
R(t)\succeq0,\qquad R(t)\succeq\lambda(t)I_d-A(t).
\tag{4.9}
\]
Apply Lemma 2.1 to the initial matrix and to (4.9), then integrate. This gives \(J(Q)\ge J^*\) for every feasible realization, without assuming Gaussian joint laws or deterministic diffusion coefficients.

### 4.2. Feasibility and explicit attainment

Assume \(\Sigma\) is AC. After changing derivatives on a null set, take \(A(t)\succeq0\) everywhere. The positive-part map on symmetric matrices is continuous. Consequently \(R^*(t)=(\lambda(t)I_d-A(t))_+\) is measurable. In an eigenbasis of \(A(t)\),
\[
0\preceq R^*(t)\preceq\lambda(t)I_d,
\qquad
a^*(t)=U_t\operatorname{diag}(\max(a_i(t),\lambda(t)))U_t^\top.
\tag{4.10}
\]
This proves integrability of \(R^*\), \(a^*\succeq\lambda I_d\), and integrability of \(\operatorname{tr}a^*\). The deterministic square root in (4.7) is measurable and square integrable in time, so the stochastic integral is a square-integrable continuous martingale.

Its covariance equals
\[
\Sigma(0)+(\kappa I_d-\Sigma(0))_+
+\int_0^t[A(s)+R^*(s)]\,ds
=\Sigma(t)+Q^*(t).
\]
Its mean is \(m\), and the deterministic stochastic integral has Gaussian independent increments. Thus its marginals are exactly (4.2). Its transition kernels are
\[
P_{s,t}f(x)=\int f(x+z)\,N\!\left(0,\int_s^t a^*(r)\,dr\right)(dz).
\tag{4.11}
\]
These are convolution kernels preserving \(C_0(\mathbb R^d)\), continuous in the starting state and continuous in time as the increment covariance tends to zero. The continuous additive process is therefore a Feller evolution and is strong Markov, equivalently as a space-time process. This verifies the required realization and attainment of (4.6).

### 4.3. Uniqueness and zero-cost boundary

For any feasible \(Q\), the difference \(J(Q)-J^*\) is the sum of a nonnegative initial trace gap and an integral of nonnegative rate trace gaps. Equality forces each initial/rate gap to vanish, with the latter assertion holding almost everywhere. Lemma 2.1 then forces
\[
Q(0)=(\kappa I_d-\Sigma(0))_+,
\qquad Q'(t)=(\lambda(t)I_d-\Sigma'(t))_+\quad\text{a.e.}
\]
The fundamental theorem for AC functions gives \(Q=Q^*\) at every time. QED.

In particular, in the feasible case,
\[
\boxed{J^*=0\iff
\Sigma(0)\succeq\kappa I_d\quad\text{and}\quad
\Sigma'(t)\succeq\lambda(t)I_d\text{ a.e.}}
\tag{4.12}
\]
The simple estimate \(J^*\le d\kappa+d\int_0^T\lambda(s)\,ds\) follows from (4.10) and its initial analogue. Neither this cost nor (4.6) is asserted to be a Wasserstein distance. It is the mean square size of independently added Gaussian noise at the terminal date.

## 5. Why a Loewner-least correction need not exist

Trace optimality and leastness in covariance order are different. The latter fails even in a smooth, nondegenerate two-dimensional Gaussian peacock.

Choose arbitrary nonzero real numbers \(p,q\) and define
\[
B=\begin{pmatrix}p^2&0\\0&-2q^2\end{pmatrix},\quad
R_0=\begin{pmatrix}p^2&0\\0&0\end{pmatrix},\quad
R_1=2\begin{pmatrix}p^2&pq\\pq&q^2\end{pmatrix}.
\tag{5.1}
\]
Both corrections satisfy \(R\succeq0\) and \(R\succeq B\). The nontrivial certificates are, for every vector \((u,v)\),
\[
(u,v)R_1(u,v)^\top=2(pu+qv)^2,
\qquad
(u,v)(R_1-B)(u,v)^\top=(pu+2qv)^2.
\tag{5.2}
\]
The same assertions for \(R_0\) are diagonal nonnegative squares.

**Theorem 5.1 (No order-least repair).** There is no matrix \(L\) satisfying
\[
L\succeq0,\quad L\succeq B,\quad
L\preceq R\text{ for every }R\succeq0,\ R\succeq B.
\tag{5.3}
\]

**Proof.** If \(L\preceq R_0\), its second diagonal entry must be zero, hence its second row and column are zero by positivity. The first diagonal entry is at least \(p^2\) from \(L\succeq B\), and at most \(p^2\) from \(L\preceq R_0\). Thus \(L=R_0\). However the vector \((q,-p)\) has quadratic form zero under \(R_1\) and \(p^2q^2>0\) under \(R_0\). Hence \(R_0\npreceq R_1\), contradicting (5.3). QED.

To embed this exactly in the preceding continuous-state problem, take \(\kappa=0\), choose \(\ell>p^2\), \(c>0\), and
\[
A=\operatorname{diag}(\ell-p^2,\ell+2q^2),
\qquad \Sigma(t)=cI_2+tA.
\tag{5.4}
\]
This is a smooth strictly positive definite Gaussian peacock. Requiring instantaneous covariance at least \(\ell I_2\) makes the correction constraint precisely \(R\succeq\ell I_2-A=B\). The curves \(Q_i(t)=tR_i\) are feasible. No pointwise Loewner-least curve exists: any such curve, at any fixed positive time, divided by that time, would provide the impossible least matrix. More explicitly, integrating the rate constraints makes \(Q(t)/t\succeq B,0\), while being least would force it below both \(R_0\) and \(R_1\). In contrast \(Q^*(t)=tR_0\) uniquely minimizes total added variance.

This is an obstruction to a definition of “smallest in every direction,” not an obstruction to Markov realization. The entire price state space remains \(\mathbb R^2\); the two-by-two matrices are covariance operators, not a finite transport grid.

## 6. General peacocks: what the known theorem implies about minima

For arbitrary weakly continuous \(\mathcal P_2\) peacocks, define
\[
m_2(t)=\int|x|^2\mu_t(dx),\qquad
\theta(t)=t+m_2(t)-m_2(0).
\tag{6.1}
\]
The moment function is continuous. To justify this, convex order bounds \(\int(|x|^2-R)_+\,d\mu_t\) uniformly by its terminal value, which tends to zero as \(R\to\infty\). This gives uniform integrability of second moments, so weak continuity implies moment continuity. Hence \(\theta\) is continuous and strictly increasing.

In the clock \(s=\theta(t)\), the second moment curve is 1-Lipschitz. The regularized existence theorem [PRS25], with its deterministic clock convention, gives a continuous strong Markov realization after convolution with \(N(0,\varepsilon(s+\delta)I_d)\), for arbitrary \(\varepsilon,\delta>0\). Pulling back gives the marginals
\[
\mu_t^{\varepsilon}
=\mu_t*N(0,\varepsilon(\theta(t)+\delta)I_d).
\tag{6.2}
\]
We only need the continuous strong Markov conclusion here. Its quadratic variation has an Itô density in the normalized clock; no density with respect to the original \(dt\) is inferred when \(\theta\) is singular.

An independent-noise coupling gives the elementary quantitative estimate
\[
\boxed{
\sup_{0\le t\le T}W_2(\mu_t,\mu_t^{\varepsilon})^2
\le d\varepsilon(\theta(T)+\delta).
}
\tag{6.3}
\]
Thus arbitrarily small errors are attainable. For a peacock from the nonexistence results in [PRS25], zero error is not attainable by a usual-filtration Markov realization. There is no positive universal minimal smoothing amplitude in this family: replacing \(\varepsilon\) by \(\varepsilon/2\) gives another admissible positive amplitude. Its infimum is zero, which need not be a minimum.

Equations (6.2)–(6.3) are consequences of a known theorem and an elementary coupling estimate. They do not solve the open raw-filtration problem or characterize which singular or degenerate smoothing kernels suffice.

## 7. Why covariance information cannot solve the general realization problem

The Gaussian theorem cannot be promoted to a general non-Gaussian theorem by retaining only its covariance hypotheses.

**Proposition 7.1 (Mean and covariance cannot classify general Markov realizability).** Under the usual filtration, there are two weakly continuous \(\mathcal P_2\) peacocks with the same complete mean and covariance curves, one with a continuous strong Markov martingale realization and the other with no Markov martingale realization.

**Proof.** Take a nonrealizable peacock \(\mu_t\) from [PRS25, Theorem 1.4 / Section 4]. Its mean is constant and its covariance curve \(\Sigma(t)\) is continuous and Loewner nondecreasing: necessity of monotonicity follows by testing convex order with quadratic forms, and continuity follows by the uniform-integrability argument preceding (6.1). Let \(\nu_t=N(m,\Sigma(t))\).

To construct a continuous Gaussian realization for any such covariance curve, let \(\theta(t)=t+\operatorname{tr}\Sigma(t)-\operatorname{tr}\Sigma(0)\). For \(s\le t\),
\[
\|\Sigma(t)-\Sigma(s)\|_{\rm op}
\le\operatorname{tr}(\Sigma(t)-\Sigma(s))\le\theta(t)-\theta(s).
\]
Therefore \(\bar\Sigma(r)=\Sigma(\theta^{-1}(r))\) is Lipschitz, has an a.e. positive semidefinite derivative, and is the covariance of a deterministic-coefficient Gaussian Itô martingale in \(r\)-time. Pull back to \(t\) to get a continuous Gaussian additive strong Markov process with marginal law \(\nu_t\). The mean and covariance match those of \(\mu_t\), while the Markov-realizability conclusions differ. QED.

This does not prevent a future criterion that uses complete distributions or suitable support/filtration geometry. It rules out only a classification based solely on mean and covariance data. It also explains why a complete spectral solution in the Gaussian class does not resolve the non-Gaussian Kellerer obstruction.

## 8. Lean verification and the precise trust boundary

The standalone `KellererCore.lean` contains three components, all proved from Mathlib with no extra axiom declarations or admitted proof steps:

| Mathematical statement | Lean declaration |
|---|---|
| Explicit spectral positive part | `SpectralRepair.positivePart` |
| Actual PSD constraints on candidate corrections | `SpectralRepair.Feasible` |
| Feasibility, exact value, and optimality in arbitrary dimension | `SpectralRepair.trace_optimal_repair` |
| Unique minimum trace correction | `SpectralRepair.trace_minimizer_unique`, `trace_equality_iff` |
| Optimal rate integrated over any measure space | `IntegratedRepair.integral_trace_minimum` |
| Integrated equality iff rates agree almost everywhere | `IntegratedRepair.integral_trace_equality_iff` |
| Initial-plus-running minimum cost | `IntegratedRepair.initial_plus_running_minimum` |
| Initial-plus-running uniqueness | `IntegratedRepair.initial_plus_running_equality_iff` |
| Genuine covariance-rate example satisfying ellipticity constraints | `NoLeastRepair.original_rate_posDef`, `ellipticity_repair_iff` |
| Nonexistence of a Loewner-least correction for arbitrary nonzero parameters | `NoLeastRepair.no_least_covariance_repair` |

The finite index type in these declarations labels Euclidean coordinates of \(\mathbb R^d\), not possible price states. The time space in the integral theorems is an arbitrary measurable space and measure, including the real interval with Lebesgue measure. There is no finite-state transport approximation anywhere in these results.

The integral theorem takes PSD feasibility and integrability of the competing costs as hypotheses. It does **not** take a pointwise optimality inequality as a hypothesis: it derives that inequality from the proved spectral theorem. The analytic proof in Section 4 shows why stochastic competitors meet those PSD and integrability hypotheses.

**What Lean does not certify here:** the construction of Brownian motion, Itô isometry, strong Markov/Feller properties, Gaussian convolutions, the absolute-continuity implication for covariance curves, or the general theorem cited from [PRS25]. Those steps have mathematical proofs or explicit literature dependencies in this report. In particular the general Kellerer theorem is neither an axiom nor a theorem in this Lean file. The full stochastic statement (Theorem 4.1) is a paper proof supported by a kernel-checked optimization core, not a completely formalized stochastic-process theorem.

The actual compiler transcript is delivered separately in `lean_build.log`. It identifies versions, command, source hash, exit code, warnings and errors, and the `#print axioms` output. Reproduction commands are in `README.md` and the project pins Lean and Mathlib to version 4.19.0.

## 9. Research assessment and the exact remaining gap

The work establishes a complete covariance optimization in a well-defined Gaussian class, with an explicit stochastic minimizer, a nonexistence criterion caused by singular clocks, and a concrete reason that covariance order does not supply a least correction. These are rigorous results; their proof mechanisms use standard Gaussian and spectral theory. No claim of first discovery or resolution of a decades-old problem is made.

The following objectives remain unresolved by this work:

- Characterizing Markov realizability for arbitrary multidimensional non-Gaussian peacocks under the usual filtration.
- Resolving the raw-filtration question explicitly raised in [PRS25, Remark 4.5].
- Finding necessary and sufficient kernel-shape or rank conditions for regularizing every peacock.
- Establishing optimal regularization for an arbitrary non-Gaussian family under a fixed scalar loss and a fixed realization class.
- Formalizing the full stochastic construction, rather than the exact matrix/integral certificates.

These missing results are not minor omitted algebraic steps. A necessary-and-sufficient criterion for general Markov realizability must use information beyond covariance (Proposition 7.1), and any theory of a minimum must distinguish infimum, attainment, and the chosen order or objective (Sections 5–6). Thus the present work is an exact scoped result and an audit of obstacles, not a unified solution of all multidimensional Kellerer realization and regularization questions.

## References

**[PRS25]** Gudmund Pammer, Benjamin A. Robinson, Walter Schachermayer. *A regularized Kellerer theorem in arbitrary dimension.* The Annals of Applied Probability **35**(2), 749–778, 2025. DOI: [10.1214/24-AAP2125](https://doi.org/10.1214/24-AAP2125). [Author PDF](https://barobinson.github.io/kellerer-regularized.pdf). [arXiv:2210.13847v3](https://arxiv.org/abs/2210.13847v3). Relevant parts: Theorems 1.1 and 1.4, deterministic clock normalization in Remark 2.1, and filtration distinctions in Remark 4.5. The arXiv v3 revision is dated 2024-03-22; this should not be confused with a later HTML rendering date.

**[M19]** The Mathlib Community. [Mathlib v4.19.0](https://github.com/leanprover-community/mathlib4/tree/v4.19.0). The formalization uses its real symmetric spectral theorem, actual `Matrix.PosSemidef`, and Bochner integral order/equality results, together with [Lean 4.19.0](https://github.com/leanprover/lean4/releases/tag/v4.19.0).
