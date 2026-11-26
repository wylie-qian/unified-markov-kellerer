# Fixed Spatial Smoothing, Markov Realization, and Gaussian Rank Requirements

**Research date:** 2026-11-27 (Asia/Taipei).  
**Status:** A complete mathematical derivation using explicitly cited stochastic-process theorems; independent internal proof checks. The matrix/integral and germ-obstruction cores are separately kernel-checked in Lean 4.19.0. Neither the full stochastic theorem nor historical novelty is certified by that Lean check. This is a research draft, not a claim of external peer review or resolution of the raw-filtration Kellerer problem.

## 中文摘要

这一轮的对象已从高斯边缘族扩展为任意维的弱连续、平方可积凸序递增族。证明路线是：由一个不要求 Markov 性的鞅实现构造正半定矩阵值二阶通量；对通量和边缘同时作固定空间卷积；证明所得扩散协方差具有时间可积的局部空间二阶导数界；调用已有的 superposition principle（叠加原理）和退化矩阵平方根正则性，获得具有给定边缘的连续强 Markov 鞅。固定核不需要随时间增加方差。若要求原始时间下的 Itô 表示，则二阶矩曲线绝对连续是充要条件。

对于固定 Gaussian 卷积协方差，进一步得到一个范围明确的精确分类：它能把**每一个**弱连续平方可积 peacock 变成可由连续强 Markov 鞅实现的族，当且仅当协方差正定。必要性甚至可用全维光滑、但有支撑间隙的非高斯密度证明。允许跳跃的 Markov 实现是不同问题；本稿不将连续路径的必要性偷换成允许跳跃的必要性。配套反例报告给出二维、每个正时刻都有严格正光滑密度的通常滤过 Markov 障碍。

这些结论组合了既有的鞅存在性、Fokker–Planck 与卷积技术；未完成优先权核定，不宣称世界首创。所有通常滤过结论都与 raw natural filtration（原始自然滤过）问题区分。

## 1. Definitions and exact scope

Let \(d\ge1\), \(0<T<\infty\), and let \((\mu_t)_{t\in[0,T]}\subset\mathcal P_2(\mathbb R^d)\) be weakly continuous and increasing in convex order. This is a square-integrable peacock. Its mean is constant. Put
\[
v(t)=\int |x|^2\,\mu_t(dx),\qquad
\Sigma(t)=\operatorname{Cov}(\mu_t).
\]
The state space is the full continuous space \(\mathbb R^d\); no finite-state approximation is part of the theorem.

Let \(k:\mathbb R^d\to(0,\infty)\) be a probability density satisfying
\[
k\in C_b^2(\mathbb R^d),\qquad
\int z\,k(z)\,dz=0,\qquad
\int |z|^2 k(z)\,dz<\infty.                 \tag{1.1}
\]
Here \(C_b^2\) means that the function and all derivatives of orders one and two are bounded and continuous. It does **not** mean that the density is bounded below by a positive constant on all of \(\mathbb R^d\), which would be impossible. Strict positivity gives positive lower bounds only on compact sets.

Define the fixed spatially smoothed peacock
\[
\nu_t(dx)=\rho(t,x)\,dx,
\qquad
\rho(t,x)=\int k(x-y)\,\mu_t(dy).          \tag{1.2}
\]
The same density \(k\) is used at every date. We construct a new process with these one-time laws. We do not assert that adding one independent random vector to an arbitrarily chosen original process makes that original process Markov.

Markov and strong Markov properties below are time-inhomogeneous properties with respect to the usual, completed and right-continuous natural filtration. Equivalently one may use the space-time process. The existence conclusion is for the prescribed initial law; it is not an assertion of a conservative Feller family from every possible starting state.

## 2. Main theorem: fixed smoothing suffices

**Theorem 2.1 (fixed positive spatial kernel).** Under the assumptions above:

1. The family \((\nu_t)\) admits a continuous square-integrable strong Markov martingale realization.
2. It admits a square-integrable martingale Itô realization against the **original** clock \(dt\) if and only if \(v\) is absolutely continuous.
3. In the absolutely continuous case the realizing process may be chosen as a strong solution, for the prescribed initial law, of
   \[
   dY_t=\sigma(t,Y_t)\,dW_t,
   \qquad \sigma(t,x)=a(t,x)^{1/2},         \tag{2.1}
   \]
   where \(a\) is measurable in time, positive semidefinite, and \(C^2\) in space, with
   \[
   \int_0^T\|a(t,\cdot)\|_{C^2(K)}\,dt<\infty
   \quad\text{for every compact }K.       \tag{2.2}
   \]
4. In the absolutely continuous case, the construction can be made to satisfy, for almost every time and every spatial point,
   \[
   \boxed{\ker a(t,x)=\ker\Sigma'(t).}    \tag{2.3}
   \]

Thus spatial smoothing alone suffices for the stated continuous strong Markov existence conclusion; an additional Brownian variance rate is not required. Uniform ellipticity is not asserted. In particular, the theorem does not reproduce all of the stronger diffusion-coefficient conclusions in the regularized theorem of Pammer–Robinson–Schachermayer [PRS].

### 2.1. Continuity of the energy clock

Convex order implies monotonicity of \(v\) and of \(\Sigma\) in the Loewner order. The second moments are uniformly integrable: for \(R>0\), the convex function \((|x|^2-R)_+\) gives
\[
\int (|x|^2-R)_+\,d\mu_t
\le \int (|x|^2-R)_+\,d\mu_T\longrightarrow0.
\]
For example \(|x|^2\mathbf1_{|x|^2>2R}\le2(|x|^2-R)_+\). Weak continuity therefore implies continuity of \(v\). The deterministic clock
\[
\theta(t)=t+v(t)-v(0)                     \tag{2.4}
\]
is continuous and strictly increasing. In this clock, \(v\circ\theta^{-1}\) is 1-Lipschitz. We first prove the theorem when \(v\) is absolutely continuous and then apply this normalization.

## 3. Constructing a positive second-order flux

We use the known existence of a right-continuous martingale with the marginals of a right-continuous multidimensional peacock [HR, Theorem 3.2]. Our weakly continuous \(\mathcal P_2\) assumptions imply its hypotheses. Finite terminal second moment and the standard martingale regularization theorem give a càdlàg square-integrable version in a usual filtration. No Markov property is required of that initial realization. Let \(X\) be one such realization. On the finite horizon, \(X_t=\mathbb E[X_T\mid\mathcal F_t]\), so all the needed quadratic-variation expectations are finite.

Write \(X^c\) for its continuous local-martingale part and \(\Delta X_s=X_s-X_{s-}\). Define the finite symmetric matrix-valued measure \(F\) on \((0,T]\times\mathbb R^d\), by its integrals against bounded Borel test functions \(\psi\):
\[
\begin{split}
\int\psi\,dF
={}&\mathbb E\int_0^T
   \psi(s,X_{s-})\,d\langle X^c\rangle_s\\
 &+2\mathbb E\sum_{0<s\le T}
   \Delta X_s\Delta X_s^\top
   \int_0^1(1-r)\,
       \psi(s,X_{s-}+r\Delta X_s)\,dr .   \tag{3.1}
\end{split}
\]
For nonnegative scalar \(\psi\), the resulting matrix is positive semidefinite. In particular \(F\) is a positive semidefinite matrix-valued measure. Its trace measure is finite.

**Lemma 3.1 (flux identities).** For \(0\le s<t\le T\),
\[
F((s,t]\times\mathbb R^d)=\Sigma(t)-\Sigma(s), \qquad
\operatorname{tr}F((s,t]\times\mathbb R^d)=v(t)-v(s). \tag{3.2}
\]
Furthermore, for \(f\in C_c^\infty(\mathbb R^d)\),
\[
\int f\,d\mu_t-\int f\,d\mu_s
=\frac12\int_{(s,t]\times\mathbb R^d}D^2f(y):F(dr,dy).
                                                        \tag{3.3}
\]

**Proof.** The continuous part in Itô's formula contributes its usual quadratic-variation term. For every jump, Taylor's integral identity is
\[
f(x+z)-f(x)-Df(x)z
=\int_0^1(1-r)\,z^\top D^2f(x+rz)z\,dr. \tag{3.4}
\]
Its absolute value is at most \(\tfrac12\|D^2f\|_\infty |z|^2\), so the jump sum is integrable. The stochastic integral has zero expectation since \(Df\) is bounded and \(X\) is square-integrable. This proves (3.3). The weight in (3.1) satisfies \(2\int_0^1(1-r)dr=1\), so its total matrix mass is the expectation of the continuous plus jump quadratic variation. The square-integrable martingale covariance identity gives (3.2). Polarization gives off-diagonal entries. \(\square\)

This is a positive Hessian-flux construction, not a proof that \(X\) itself has continuous paths. The jump part has been represented as a distributional second-order flux along the chord of each jump. Second-order flux and martingale/Fokker–Planck formulations have substantial prior literature; see [HT, BB].

### 3.1. Disintegration in an absolutely continuous energy clock

Suppose \(v\) is absolutely continuous. Its derivative \(v'\) is nonnegative and integrable. By (3.2), the time marginal of the trace measure of \(F\) is \(v'(t)dt\). For a PSD matrix measure every entry is absolutely continuous with respect to its trace measure. Disintegrating the trace measure and its matrix Radon–Nikodym density therefore gives a measurable family of finite PSD matrix measures \(F_t\) such that
\[
F(dt,dy)=F_t(dy)\,dt,
\qquad
F_t(\mathbb R^d)=\Sigma'(t),
\qquad
\operatorname{tr}F_t(\mathbb R^d)=v'(t)              \tag{3.5}
\]
almost everywhere. Null-time versions may be set to zero. Absolute continuity of \(\Sigma\) follows either from (3.2) or from the bound on PSD increments by their trace.

Equations (3.3)–(3.5) express
\[
\partial_t\mu=\frac12\sum_{i,j}\partial_{ij}F_{ij}.
                                                        \tag{3.6}
\]
No spatial absolute continuity of \(F_t\) with respect to \(\mu_t\) is assumed. This point matters when the original realization has jumps.

## 4. Fixed convolution and the missing regularity estimate

Set
\[
H(t,x)=\int k(x-y)\,F_t(dy),
\qquad
a(t,x)=\frac{H(t,x)}{\rho(t,x)}.                 \tag{4.1}
\]
The denominator is strictly positive and the numerator is PSD. Both are measurable in \(t\).

**Lemma 4.1 (local derivative bounds).** For every compact ball \(K\), there is a finite constant \(C_K\), depending on \(k,K\) and the uniformly tight marginal family, such that
\[
\sup_{x\in K}\max_{|\alpha|\le2}\|D_x^\alpha a(t,x)\|
\le C_K v'(t)\quad\text{a.e.}                   \tag{4.2}
\]

**Proof.** Uniform tightness gives a ball \(B_L\) with \(\mu_t(B_L)\ge1/2\) for all \(t\). Strict positivity and continuity of \(k\) imply
\[
\inf_{t,x\in K}\rho(t,x)
\ge\frac12\min_{x\in K,\,y\in\overline B_L} k(x-y)
=:c_K>0.                                         \tag{4.3}
\]
For \(|\alpha|\le2\), differentiation under the integral is justified by the global boundedness of the corresponding derivatives of \(k\), and
\[
|D_x^\alpha\rho(t,x)|\le\|D^\alpha k\|_\infty.
\]
Since every entry variation of a PSD matrix measure is bounded by its trace measure,
\[
\|D_x^\alpha H(t,x)\|
\le C_d\|D^\alpha k\|_\infty v'(t).              \tag{4.4}
\]
The quotient rule, (4.3), and these derivative bounds prove (4.2). \(\square\)

Convolving (3.6) in space yields
\[
\partial_t\rho
=\frac12\sum_{i,j}\partial_{ij}(a_{ij}\rho).       \tag{4.5}
\]
For completeness, one may test (3.3) with \(f*k^\vee\), where \(f\in C_c^\infty\) and \(k^\vee(x)=k(-x)\). This function has bounded first and second derivatives, so the same Itô/Taylor argument applies without a compact-support assumption on that convolved test. Fubini is justified by finite flux mass and the derivative bounds. Thus (4.5) follows without assuming \(F_t\ll\mu_t\).

The global integrability condition for superposition is exact:
\[
\int_0^T\int_{\mathbb R^d}\operatorname{tr}a(t,x)\rho(t,x)\,dx\,dt
=\int_0^T v'(t)\,dt
=v(T)-v(0)<\infty.                              \tag{4.6}
\]

**Literature qualification.** Fixed convolution of a Fokker–Planck solution and the ratio in (4.1) are established techniques [T, Appendix A.1; HT, Lemma 3.6]. Their particular hypotheses must not be silently substituted here: our \(F_t\) can be spatially singular relative to \(\mu_t\), and Gaussian kernels do not satisfy a global bound \(|Dk|\le Ck\). Lemma 4.1 supplies the local estimate actually used in this proof.

## 5. From the PDE to a strong Markov martingale

### 5.1. Superposition supplies existence and the prescribed marginals

Apply Trevisan's superposition principle [T, Theorem 2.5] to (4.5), with drift zero. Equation (4.6) verifies its coefficient integrability requirement. It gives a probability law on continuous paths solving the martingale problem for \(\tfrac12 a:D^2\), with one-time marginals \(\rho(t,x)dx\). This is a continuous local martingale whose expected quadratic-variation trace is finite by (4.6); hence it is a square-integrable true martingale.

### 5.2. Degenerate square roots still have enough regularity

We use the established matrix square-root theorem: a \(C^2\) PSD matrix field has a locally Lipschitz principal square root. A quantitative localized form bounds the square of the Lipschitz constant by a dimension-dependent constant times a localized \(C^2\) bound. See [SV, Lemma 3.2.3], [ELL, Theorem 9.2.1], and its explicit use in [T, proof of Theorem A.5]. Positive definiteness is not required.

Here is the algebra behind the quantitative dependence. For a nonnegative scalar \(C^2\) function with second derivative bounded by \(c\), Taylor's inequality gives
\[
0\le f(x)+hf'(x)+\tfrac c2 h^2\quad\forall h,
\qquad |f'(x)|^2\le2c f(x).                       \tag{5.1}
\]
After diagonalizing \(a(x)\), apply this estimate along spatial lines to the quadratic forms associated with \(e_i\pm e_j\). For \(a+\varepsilon I\), differentiation of the square-root identity gives
\[
D\sqrt{a+\varepsilon I}_{ij}
=\frac{Da_{ij}}{\sqrt{\lambda_i+\varepsilon}+\sqrt{\lambda_j+\varepsilon}}.
\]
The numerator is bounded by a constant times \(\sqrt{\lambda_i}+\sqrt{\lambda_j}\), giving a derivative bound uniform in \(\varepsilon>0\). Passing to the limit yields the local Lipschitz conclusion. A nonnegative smooth spatial cutoff makes this argument global on a larger ball while preserving PSD and the localized \(C^2\) bounds.

With (4.2), on every compact ball,
\[
\|\sigma(t,x)-\sigma(t,y)\|_{\rm HS}^2
\le L_K(t)^2 |x-y|^2,
\qquad L_K(t)^2\le C_K'v'(t).                    \tag{5.2}
\]
The squared Lipschitz constants and local coefficient-growth bounds are integrable in time. Stopped Itô estimates and Gronwall therefore give pathwise uniqueness. Cutoff coefficients give globally defined strong solutions; gluing them gives the unique maximal solution, with a cemetery state if explosion occurs.

### 5.3. Nonexplosion and the precise Markov conclusion

The superposition solution already exists on the entire finite horizon for the prescribed initial law. Local pathwise uniqueness and weak–strong equivalence identify it with the maximal SDE solution, which is consequently nonexplosive for this initial law. The unique maximal SDE family, viewed in space-time and killed upon explosion, is strong Markov. Its nonexplosive prescribed-law realization therefore has the claimed strong Markov property under the usual filtration.

No assertion is made that every point \((s,x)\) gives a conservative solution or that the un-killed transition family is globally Feller. The full-support density of the prescribed initial law does not by itself prove those stronger statements.

### 5.4. Arbitrary continuous energy clocks

For general continuous \(v\), pass to \(r=\theta(t)\) from (2.4). The normalized peacock has Lipschitz energy, so the construction above applies. Compose the resulting continuous martingale with the deterministic continuous increasing clock \(\theta\). This preserves the martingale and time-inhomogeneous strong Markov properties and gives the desired marginals in the original time parameter. An arbitrary singular \(\theta\) does not preserve an Itô density relative to the original \(dt\).

Conversely, any original-clock square-integrable Itô realization has absolutely continuous second moment. Since the kernel is fixed and centered,
\[
\int |x|^2\nu_t(dx)=v(t)+\int |z|^2k(z)\,dz.
\]
Thus original-clock Itô realization forces \(v\) to be absolutely continuous. This completes the proof of assertions 1–3 of Theorem 2.1. \(\square\)

## 6. Exact null-space geometry

Fix a time for which (3.5) holds. Dominate \(F_t\) by its trace measure \(\tau_t\), writing
\[
F_t(dy)=G_t(y)\,\tau_t(dy),\qquad G_t(y)\succeq0.
\]
For any vector \(u\), strict positivity of \(k\) gives
\[
\begin{split}
u^\top H(t,x)u=0
&\iff\int k(x-y)\,u^\top G_t(y)u\,\tau_t(dy)=0\\
&\iff G_t(y)u=0\quad\tau_t\text{-a.e.}\\
&\iff F_t(\mathbb R^d)u=0.
\end{split}                                                    \tag{6.1}
\]
The equivalence uses the zero-integral criterion for nonnegative functions and the PSD identity \(u^\top Gu=0\iff Gu=0\). Dividing by positive \(\rho(t,x)\) does not change a null space. Equation (3.5) therefore yields
\[
\ker a(t,x)=\ker\Sigma'(t),
\qquad
\operatorname{rank}a(t,x)=\operatorname{rank}\Sigma'(t).           \tag{6.2}
\]
This proves assertion 4. At almost every time the null space is independent of the spatial observation point. Initial spatial smoothing has not added ongoing covariance energy or new instantaneous diffusion directions.

The genuine matrix/Bochner-integral statement behind (6.1), including actual Gaussian weights, is fully proved in `KernelGeometry.lean`. The stochastic identification \(F_t(\mathbb R^d)=\Sigma'(t)\) is the paper argument in Section 3, not a hidden Lean axiom.

## 7. A sharp universal rank theorem for fixed Gaussian kernels

For a PSD matrix \(Q\), let \(\mathsf U_c(Q)\) mean:

> For every weakly continuous \(\mathcal P_2\) peacock on \(\mathbb R^d\), its fixed convolution with \(\mathcal N(0,Q)\) admits a continuous square-integrable strong Markov martingale realization.

**Theorem 7.1.**
\[
\boxed{\mathsf U_c(Q)\iff Q\succ0.}                             \tag{7.1}
\]

**Sufficiency.** A nondegenerate Gaussian density satisfies (1.1). Apply Theorem 2.1.

**Necessity with smooth input densities.** Suppose \(Q\) has a unit null vector \(u\). Let \(R\) have a symmetric smooth probability density supported in \((-2,-1)\cup(1,2)\). Let \(W\) be an independent nondegenerate Gaussian vector on \(u^\perp\), and set
\[
\mu_t=\operatorname{Law}(W+(1+t)Ru).                            \tag{7.2}
\]
These laws have full-dimensional smooth densities (with a support gap) and finite moments. They form a peacock: condition on \(W\) and use that a symmetric scalar law increases in convex order under increasing positive dilation. To verify the latter directly, for convex \(f\) the function \(r\mapsto f(w+ru)+f(w-ru)\) is nondecreasing on \([0,\infty)\).

Convolution with \(\mathcal N(0,Q)\) leaves the \(u\)-projection unchanged, because its Gaussian projection has variance \(u^\top Qu=0\). Suppose a continuous martingale \(Y\) realized the convolved marginals, and write \(Z_t=u\cdot Y_t\). By checking rational times and using continuity, its paths avoid the interval \((-1,1)\) at every time. Their sign therefore never changes. With \(A=\{Z_0>0\}\in\mathcal F_0\),
\[
\mathbb E[Z_t\mathbf1_A]=\mathbb E[Z_0\mathbf1_A]
\]
by the martingale property. But the marginals and constant sign give
\[
\mathbb E[Z_t\mathbf1_A]=(1+t)\mathbb E[R\mathbf1_{R>0}],
\]
which is strictly increasing. This contradiction proves necessity. It rules out every continuous martingale, without needing the Markov restriction. \(\square\)

**Important scope.** This necessity argument does not exclude jump martingales. For universal Markov realization allowing jumps, the companion blind-subspace result excludes at least two unsmoothed directions; a single unsmoothed direction is not classified by this argument. The distinction is part of the theorem, not a technical disclaimer.

## 8. Minimal regularization: exact statements and nonstatements

### 8.1. Minimal amplitude and minimal rank are different

Theorem 7.1 gives the exact rank requirement \(\operatorname{rank}Q=d\) for universal continuous realization by a fixed Gaussian kernel. Yet
\[
\inf_{Q:\mathsf U_c(Q)}\operatorname{tr}Q=0,                    \tag{8.1}
\]
because \(Q=\varepsilon I_d\) works for every \(\varepsilon>0\). This infimum is not attained: a PSD matrix with trace zero is zero and fails (7.1).

For an individual peacock, allowing all PSD fixed Gaussian corrections gives the same zero infimum. In the continuous strong Markov realization class it is attained exactly when the original peacock already belongs to that class. This is an attainment equivalence, **not** an independent analytic classification of unsmoothed peacocks.

For each \(Q\succeq0\), the independent-noise coupling gives
\[
\sup_{t\in[0,T]}W_2(\mu_t,\mu_t*\mathcal N(0,Q))^2
\le\operatorname{tr}Q.                                        \tag{8.2}
\]
The fixed-kernel theorem therefore obtains arbitrary approximation accuracy without an additional time-growing smoothing variance. No claim is made that (8.2) is always the optimal Wasserstein coupling cost.

### 8.2. Relation to time-dependent Gaussian covariance paths

If \(Q(t)\) is continuous and Loewner nondecreasing with \(Q(0)\succ0\), choose a fixed \(H\succ0\) with \(H\preceq Q(0)\). The family
\[
\widetilde\mu_t=\mu_t*\mathcal N(0,Q(t)-H)
\]
is a weakly continuous \(\mathcal P_2\) peacock. Theorem 2.1 applied to its fixed \(\mathcal N(0,H)\) convolution gives a continuous strong Markov realization of \(\mu_t*\mathcal N(0,Q(t))\). This is a sufficiency statement without a strictly positive ongoing variance rate.

The companion report `SMOOTH_TWO_DIMENSIONAL_OBSTRUCTION.md` shows why positivity of \(Q(t)\) only at positive times cannot be substituted for a positive initial covariance in a universal theorem: for any \(p>1\), there is a two-dimensional counterexample with \(Q(t)=t^pI_2\). Its target marginals have everywhere positive smooth densities for every \(t>0\), and still have no Markov martingale under the usual filtration.

The further report `INITIAL_KERNEL_OBSTRUCTION.md` proves a uniform necessity statement for arbitrary such covariance paths:
\[
\boxed{
\dim\ker Q(0)\ge2
\quad\Longrightarrow\quad
\exists\mu\text{ for which }\mu_t*\mathcal N(0,Q(t))
\text{ has no usual-filtration Markov martingale realization.}
}                                                               \tag{8.3}
\]
This permits arbitrary later increases of \(Q\), positive-definite \(Q(t)\) for every positive time, and arbitrary cross-covariances. The proof adapts the speed of a two-dimensional peacock to the initially blind directions. A summably accurate classifier produces a nontrivial initial germ event, while the one-time Gaussian-mixture laws force that event to be independent of the entire initial state. It therefore cannot be explained by an enlarged collection of initial observed coordinates.

For universal Markov realization allowing jumps, the initial-rank picture established here is consequently:

| Initial covariance | Conclusion for arbitrary continuous Loewner-increasing \(Q(t)\) |
|---|---|
| \(Q(0)\succ0\) | Sufficient; a continuous strong Markov realization exists for every peacock. |
| \(\dim\ker Q(0)\ge2\) | Insufficient; a counterexample peacock exists, even if jump realizations are allowed. |
| \(\dim\ker Q(0)=1\) | Not classified here. |

The unresolved last row must not be replaced by an asserted equivalence. The complete equivalence (7.1) has the different scope of a fixed covariance and universal **continuous** realizations.

## 9. Formal verification boundary

`KernelGeometry.lean` proves actual matrix and measure-theoretic statements, including

- \(\ker(A+B)=\ker A\cap\ker B\) for PSD matrices;
- the Loewner-order reversal of kernels;
- positive semidefiniteness of the Bochner integral and the zero-energy/equality criterion;
- \(\ker(\rho^{-1}\int wG)=\ker(\int G)\) for strictly positive weights;
- the specialization to actual Gaussian exponential weights on \(\mathbb R^d\);
- the universal quadratic nonnegativity implication \(b^2\le2ca\) used in (5.1).

The companion `GermObstructionCore.lean` verifies the probability obstruction and deterministic threshold geometry used in the two-dimensional construction. Neither source declares a stochastic existence theorem as an axiom. The full flux construction, superposition application, pathwise uniqueness argument, and Markov realization remain mathematical proofs in this report with explicit literature dependencies.

## 10. What is established and what remains open here

This draft supplies a general fixed spatial smoothing theorem, an original-clock criterion, exact null-space geometry, and an exact universal **continuous-realization** rank characterization for fixed Gaussian kernels. The companion notes give progressively stronger usual-filtration obstructions, including a two-dimensional positive-density construction and the initial-kernel necessity statement (8.3).

The programme is not complete. In particular, these results do not characterize all unsmoothed peacocks with Markov realizations; they do not classify arbitrary regularization kernel shapes, solve every per-instance minimal-cost problem, or settle the raw-filtration question. The corank-one case for universal Markov realization **allowing jumps** is not classified here. Historical priority for the particular assembled statements, especially the two-dimensional refinement, has not been established by the finite literature search.

## References

**[PRS]** G. Pammer, B. A. Robinson, W. Schachermayer, *A regularized Kellerer theorem in arbitrary dimension*, Annals of Applied Probability **35**(2), 749–778 (2025). [DOI](https://doi.org/10.1214/24-AAP2125), [author PDF](https://barobinson.github.io/kellerer-regularized.pdf), [arXiv](https://arxiv.org/abs/2210.13847). See Theorems 1.1 and 1.4; Remarks 2.1, 4.3, 4.5; Propositions 4.6–4.7.

**[HR]** F. Hirsch, B. Roynette, *On \(\mathbb R^d\)-valued peacocks*, ESAIM: Probability and Statistics **17**, 444–454 (2013), Theorem 3.2. [Primary PDF](https://www.numdam.org/item/PS_2013__17__444_0.pdf). This is the multidimensional non-Markov martingale-existence input; no Markov selection is being imported into Section 3.

**[T]** D. Trevisan, *Well-posedness of multidimensional diffusion processes with weakly differentiable coefficients*, Electronic Journal of Probability **21**, paper 22 (2016). [DOI](https://doi.org/10.1214/16-EJP4453), [arXiv PDF](https://arxiv.org/pdf/1507.01357). Theorem 2.5 is the superposition principle. Appendix A.1 discusses fixed spatial convolution; the proof of Theorem A.5 invokes the degenerate square-root regularity theorem.

**[SV]** D. W. Stroock, S. R. S. Varadhan, *Multidimensional Diffusion Processes*, Springer (1979; reprint 2006), Lemma 3.2.3. Its applicable statement is also reproduced in the primary author sources below.

**[ELL]** K. D. Elworthy, Y. Le Jan, X.-M. Li, *The Geometry of Filtering*, Theorem 9.2.1. [Author-hosted preliminary monograph](https://www.xuemei.org/FiltDiff.pdf). See also S. R. S. Varadhan's [2019 lecture notes, first lemma](https://math.nyu.edu/~varadhan/Fall2019/Fall19.6.pdf).

**[HT]** M. Huesmann, D. Trevisan, *A Benamou–Brenier formulation of martingale optimal transport*, Bernoulli **25**(4A), 2729–2757 (2019). [arXiv PDF](https://arxiv.org/pdf/1707.01493). Lemma 3.6 treats fixed convolution in a diffusion-flux formulation, under its own relative-derivative hypotheses.

**[BB]** K. Bołbotowski, G. Bouchitté, *Kantorovich–Rubinstein duality theory for the Hessian*, [arXiv:2412.00516v3](https://arxiv.org/html/2412.00516v3) (2025 revision). Relevant background on positive matrix-valued Hessian fluxes and convex order; not cited as an already proved version of Theorem 2.1.
