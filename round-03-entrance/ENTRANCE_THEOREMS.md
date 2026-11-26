# Vanishing adaptive Gaussian regularization and the raw-filtration boundary

Research draft, round 03. This is not a claimed solution of the unregularized multidimensional Kellerer problem or of the universal corank-one usual-filtration problem. The results below are mathematical proofs subject to independent review. The main mechanism extends the preceding round's positive-kernel argument, using an integrable estimate at the initially singular time.

## 1. Setup and statements

Let T>0, let (mu_t) be a weakly continuous peacock in P_2(R^d) on [0,T], and let Q(t) be a continuous Loewner-nondecreasing symmetric positive semidefinite matrix curve. Write

- v(t) = integral |x|^2 mu_t(dx);
- P for the orthogonal projector onto ker Q(0);
- k = rank P;
- theta(t) = t + v(t)-v(0) + tr(Q(t)-Q(0)), and S=theta(T).

A Markov property below is time-inhomogeneous. "Usual" means completion and right-continuous augmentation of the natural filtration; "raw" means the unaugmented natural filtration. Strong Markov statements refer to the time-space process, under the specified initial law; no global conservativity from every possible point is asserted.

**Theorem A (adaptive repair without initial perturbation).** If k>0, choose eta>0 no greater than the smallest positive eigenvalue of Q(0), if such an eigenvalue exists. For t>0 put

$$q_\eta(t)=\eta(1+\log(S/\theta(t)))^{-1/2},\qquad q_\eta(0)=0.$$

Then

$$\nu_t=\mu_t*\mathcal N(0,Q(t)+q_\eta(t)P)$$

has a continuous square-integrable strong Markov martingale realization in the usual filtration. For k=0 no extra noise is required. In particular the initial law is unchanged relative to the prescribed regularization, the additional covariance has rank k at every positive time, and

$$\sup_{t\in[0,T]}W_2^2(\nu_t,\mu_t*\mathcal N(0,Q(t)))\le k\eta.$$

If Q(0)=0 this preserves the original initial law exactly. For corank one the additional noise is one-dimensional. If v and Q are absolutely continuous in the original time, the realization can be taken to be an Itô martingale in that time. Otherwise deterministic time change gives the claimed continuous strong Markov martingale, without a claim of original-time Itô regularity.

**Theorem B (exact universal raw continuous-path classification).** For a fixed Q as above, the following are equivalent:

1. For every weakly continuous square-integrable peacock mu, mu_t*N(0,Q(t)) has a continuous martingale realization.
2. For every such mu there is a continuous martingale realization which is Markov in the raw natural filtration (indeed strong Markov at positive starting times).
3. Q(t) is positive definite for every t>0.

No positive definiteness at t=0 is required. This is a classification for continuous paths. It does not classify universal raw Markov realizability with jumps when (3) fails.

**Theorem C (entrance criterion).** Let X be a continuous square-integrable martingale, Markov at every positive deterministic time in its usual filtration. Let H=sigma(X_0) completed, G=F^X_{0+}, and K_{s,r} be a version of its Markov transition operator for 0<s<r. For bounded Borel g define D_{r,g}=||E[g(X_r)|G]-E[g(X_r)|H]||_2^2. Then

$$D_{r,g}=\lim_{s\downarrow0}E\left[\operatorname{Var}(K_{s,r}g(X_s)\mid X_0)\right].$$

If K_{s,r}g has a globally L_s-Lipschitz version, then

$$D_{r,g}\le\liminf_{s\downarrow0}L_s^2\bigl(E|X_s|^2-E|X_0|^2\bigr).$$

Usual-filtration Markovness at zero is equivalent to D_{r,g}=0 for every r>0 and bounded Lipschitz g. The inequality identifies a quantitative obstruction at the entrance: if D_{r,g}>0 then the Lipschitz constant must diverge at least on the inverse root second-moment increment scale (where the increment tends to zero). No claim that these sufficient regularity bounds are necessary for existence is made.

## 2. Time normalization and positive matrix flux

The terminal measure dominates all mu_t in convex order. The convex tail test (|x|^2-R)^+ shows uniform integrability of squared norms, hence weak continuity implies continuity of v. The common mean is constant. The strictly increasing continuous map theta is a homeomorphism onto [0,S]. In normalized time s=theta(t), write mu_s, v_s and Q_s for the pullbacks. For s1<s2 the increment of v and of tr Q are each bounded by s2-s1. Every entry of a PSD increment D of Q has |D_ij|<=tr D, so Q and v are Lipschitz in s. Their derivatives exist almost everywhere, v' lies in [0,1], and Q' is PSD.

Use the multidimensional martingale realization theorem (Hirsch and Roynette, 2013, On R^d-valued peacocks, ESAIM P&S 17, 444-454, DOI 10.1051/ps/2012009). On a finite horizon the weakly continuous square-integrable peacock has a cadlag square-integrable martingale realization U. One may use martingale regularization on a dense countable time set; convex-order domination gives the needed uniform integrability.

There is a finite PSD matrix-valued measure F on (0,S] x R^d satisfying, for f in C_c^infty,

$$\mu_b(f)-\mu_a(f)=\frac12\int_{(a,b]\times\mathbb R^d} D^2f(x):F(ds,dx),$$
$$F((a,b]\times\mathbb R^d)=\operatorname{Cov}(\mu_b)-\operatorname{Cov}(\mu_a).$$

For clarity, F is the sum of (i) E[d[U^c]_s delta_{U_{s-}}(dx)] and (ii) the jump contribution

$$2E\sum_{0<s\le S}\delta_s(ds')\int_0^1(1-r)
(\Delta U_s)(\Delta U_s)^\top\delta_{U_{s-}+r\Delta U_s}(dx)\,dr.$$

The expression is defined by integration against bounded Borel test functions; each contribution is PSD. Its trace mass is finite by square integrability and the bracket identity. Itô's formula, the integral second-order Taylor remainder and the vanishing expectation of the stochastic integral prove the weak equation. The covariance identity follows from polarization of the quadratic variation identity, or application to quadratic functions by localization. These arguments apply to the normalized time process.

The trace time marginal of F equals dv. Disintegrate the positive trace measure and take the Radon-Nikodym matrix density with respect to its trace. This gives measurable PSD spatial matrix measures F_s with F(ds,dx)=F_s(dx)ds and tr F_s(R^d)=v'(s) almost everywhere. In particular all entries are absolutely integrable. We choose versions for exceptional times arbitrarily, for example zero.

## 3. Time-dependent Gaussian convolution

We first establish a more general sufficient condition in normalized time. Let C_s be any absolutely continuous Loewner-nondecreasing PSD matrix curve, positive definite for all s>0. Write r_s=lambda_min(C_s)>0 for s>0. We require

$$\int_0^S v'(s)(1+r_s^{-1})\exp(c/r_s)\,ds<\infty
\quad\hbox{for every }c>0. \tag{IC}$$

The proof will also yield raw Markov existence without (IC).

Let phi_s be the centered Gaussian density with covariance C_s for s>0. Set

$$\rho_s(x)=\int\phi_s(x-y)\mu_s(dy),\quad
H_s(x)=\int\phi_s(x-y)F_s(dy),\quad
B_s(x)=H_s(x)/\rho_s(x).$$

The denominator is strictly positive and B_s is PSD. Define

$$A_s(x)=C_s'+B_s(x).$$

Then the family nu_s=mu_s*N(0,C_s) satisfies the weak Fokker-Planck equation

$$\partial_s\nu_s=\tfrac12\sum_{i,j}\partial_{ij}((A_s)_{ij}\nu_s). \tag{FP}$$

Indeed Gaussian convolution commutes with spatial derivatives, and differentiation in the covariance gives the heat identity

$$\frac{d}{ds}P_{C_s} f=\tfrac12\sum_{i,j}(C_s')_{ij}P_{C_s}(\partial_{ij}f)$$

almost everywhere for smooth bounded f with bounded derivatives. On any compact interval of positive times apply the flux equation to the time-dependent test P_{C_s}f. The bounded derivative version follows by cutoff and finite flux mass. This proves (FP) there; passing the lower endpoint to zero is justified by weak continuity of nu and the integrable flux budget

$$\int_0^S\int\operatorname{tr}A_s(x)\nu_s(dx)ds
=v(S)-v(0)+\operatorname{tr}(C_S-C_0)<\infty. \tag{E}$$

In the identity we used Fubini and the unit integral of phi_s. The value of the coefficient at s=0 is immaterial to the dt-integral. No density is needed for nu_0.

Trevisan's superposition theorem (2016, EJP 21, DOI 10.1214/16-EJP4453, Theorem 2.5) applies to the narrowly continuous probability curve (FP), with zero drift and integrable PSD diffusion matrix. It yields a continuous martingale-problem solution with these marginals. The coordinate local martingale has integrable total bracket trace by (E), hence is a square-integrable martingale. On an enlarged space it solves the SDE with a measurable square root of A. This weak existence is global for the given initial law, independently of (IC).

## 4. Quantitative estimate at a singular entrance

Fix a spatial radius R. By the uniform second moment bound choose M such that mu_s(B_M)>=1/2 for all s. Put c_R=(R+M)^2/2 and N_s=(2*pi)^(-d/2) det(C_s)^(-1/2). For |x|<=R,

$$\rho_s(x)\ge \tfrac12 N_s\exp(-c_R/r_s). \tag{1}$$

For j=0,1,2, differentiating the Gaussian gives the global estimate

$$\|D^j\phi_s\|_\infty\le C_d N_s r_s^{-j/2}. \tag{2}$$

For j=1 this follows from |C_s^{-1}z|<=r_s^{-1/2}|C_s^{-1/2}z| and the bounded function u exp(-u^2/2). For j=2 use D^2 phi=(C_s^{-1}zz^T C_s^{-1}-C_s^{-1})phi and the bounded function (1+u^2)exp(-u^2/2). Constants may absorb dimension and choice of tensor norm.

The same bound applies to D^j rho_s, and to D^j H_s with the additional factor v'(s) because the total trace mass of F_s equals v'(s). Quotient differentiation, including the terms H D^2rho/rho^2 and H Drho Drho/rho^3, now gives

$$\|B_s\|_{C^2(B_R)}
\le C_{d,R}v'(s)(1+r_s^{-1})\exp(3c_R/r_s). \tag{3}$$

The determinant cancels. This cancellation is essential when the covariance has a single small eigenvalue or several small eigenvalues. Under (IC), the right side is integrable for every R. The state-independent C_s' also has integrable norm.

For completeness the local square-root estimate used here is quantitative: for a C^2 PSD matrix field B on B_{R+1}, the squared local Lipschitz constant of its principal square root on B_R is at most C_{d,R}||B||_{C^2(B_{R+1})}. To see it, multiply B by a smooth nonnegative cutoff equal to one on B_R and extend by zero, bounding the global second derivatives by C||B||_{C^2}. For a unit vector v, apply the scalar inequality |f'|^2<=2M f to the nonnegative function f=v^T B v along a line with |f''|<=M (Taylor, minimizing the quadratic). Use v=e_i+e_j and e_i-e_j after diagonalizing at the point, with their norm factors, to bound the directional derivative |DB_ij| by a constant times sqrt(M)(sqrt(lambda_i)+sqrt(lambda_j)); diagonal entries use v=e_i. For B+epsilon I the derivative of its square root solves the Sylvester equation, with denominator sqrt(lambda_i+epsilon)+sqrt(lambda_j+epsilon). The resulting derivative bound is uniform in epsilon>0. Let epsilon tend to zero. This is also the classical PSD C^2 square-root Lipschitz lemma; see Freidlin and Varadhan's diffusion-process notes.

Apply this estimate to A_s=C_s'+B_s (or to B_s with an extra state-independent Brownian factor). On every spatial compact, the squared spatial Lipschitz constant and squared coefficient bound of the square root are time-integrable under (IC). Localized pathwise uniqueness follows from Itô isometry and Gronwall for these integrable time-dependent bounds. Local strong SDE solutions and uniqueness in law follow by the standard localized Yamada-Watanabe argument; localization and the global weak solution above show nonexplosion for the prescribed initial law. The time-space SDE solution is strong Markov in its usual filtration (equivalently use the measurable maximal strong solution family and Brownian strong Markov property at stopping times). No global-in-x nonexplosion or uniform ellipticity at the initial time is asserted.

Without (IC), on every [a,S] with a>0 the continuous positive definite curve C has min eigenvalue bounded away from zero, and (3) is integrable there. Consequently the weak solution from Section 3 is Markov at all positive starting times, relative even to the filtration carrying the martingale-problem solution. To justify this without assuming uniqueness at zero, condition on the history at a positive time s: the conditional continuation solves the same local martingale problem with current point X_s, and localized uniqueness plus nonexplosion of the actual continuation makes the law depend only on X_s. The same argument gives the positive-starting-time strong Markov statement. At zero the raw sigma-field is exactly sigma(X_0), so ordinary raw Markovness is automatic. This does not assert usual-filtration Markovness at zero.

## 5. Proof of Theorem A

If k=0 take C_s=Q_s, with r_s bounded below by lambda_min(Q_0); (IC) holds.

For k>0 set

$$q(s)=\eta(1+\log(S/s))^{-1/2}\quad (s>0),\qquad q(0)=0,\qquad C_s=Q_s+q(s)P.$$

The scalar q is continuous, nondecreasing and absolutely continuous on [0,S]: its positive-time derivative is eta/(2s(1+log(S/s))^(3/2)), with integral eta. Thus C is absolutely continuous and Loewner-nondecreasing. By Q_s>=Q_0, the orthogonal decomposition ker Q_0 plus its perpendicular gives C_s>=q(s) I, under the stated restriction on eta. The same bound holds when Q_0=0. Hence r_s>=q(s).

For any c>0, let a=c/eta, and substitute u=log(S/s), so ds=S exp(-u)du in the integral over (0,S]. Since v'<=1 and the integrand decreases as r increases, (IC) is bounded by

$$S\int_0^\infty (1+\sqrt{1+u}/\eta)
\exp(a\sqrt{1+u}-u)\,du.$$

The elementary certificate

$$a\sqrt{1+u}\le (1+u+a^2)/2$$

follows from a square. Also sqrt(1+u)<=1+u for u>=0. Therefore the displayed integral is dominated by

$$S\exp((1+a^2)/2)\int_0^\infty(1+(1+u)/\eta)e^{-u/2}\,du
=S\exp((1+a^2)/2)(2+6/\eta)<\infty.$$

This proves (IC). The coefficient result in Sections 3-4 gives the usual-filtration strong Markov martingale in normalized time, and the deterministic continuous strictly increasing inverse time change preserves the stated properties. If the original clock is AC, its pullback has an AC bracket, so a Brownian representation gives the original-time Itô version (with an enlargement if needed). Otherwise an original-time Itô representation is not claimed.

The Gaussian coupling using an independent additional N(0,qP) vector gives W_2^2<=tr(qP)=kq at each date. Thus the uniform perturbation estimate and exact preservation of the initial marginal hold.

In fact the proof works for any nondecreasing AC normalized-time q with q(0)=0, q(s)>0 for s>0 and q(s) log(S/s) -> infinity as s->0 (assuming eta bounds as above). For every c>0, eventually c/q(s) <= (1/4)log(S/s); the polynomial factor is absorbed by a slightly larger exponential, so (IC) follows. The logarithmic scale is sufficient, not proved optimal.

## 6. Proof of Theorem B

If Q(t)>0 for all t>0, normalize time as in Section 2 and use C_s=Q_s in Sections 3-4 without (IC). This constructs a continuous martingale, Markov at positive times and in the raw filtration at zero. Thus (3) implies (2), and (2) implies (1).

Conversely suppose Q(t_*) is singular at some t_*>0. Choose a unit u in its kernel. Loewner monotonicity and PSD imply Q(t)u=0 for every 0<=t<=t_*.

Take a symmetric real random variable R with a smooth density supported in (-2,-1) union (1,2), and independently a centered nondegenerate Gaussian W on u-perp (W=0 in dimension one). Define mu_t=Law(W+(1+t)Ru). This is a weakly continuous P_2 peacock: conditional on |R| and W, the expectation of every convex function at the two symmetric endpoints is nondecreasing with their distance from W. Convolution with the prescribed noise preserves its u-projection for t<=t_*.

Any continuous martingale M with these marginals would have Z_t=u dot M_t satisfy |Z_t|>=1 at all rational t in [0,t_*] almost surely, and then at all t by continuity. The sign of Z cannot change. With A={Z_0>0}, martingale conditioning implies E[1_A Z_{t_*}]=E[1_A Z_0]. But the prescribed marginals and sign invariance give E[1_A Z_{t_*}]=(1+t_*)E[R^+] > E[R^+]=E[1_A Z_0]. Contradiction. This excludes all continuous realizations, not only Markov ones. It does not exclude jumping paths.

## 7. Proof of Theorem C

For s>0 the Markov property gives K_{s,r}g(X_s)=E[g(X_r)|F^X_s]. As s decreases to zero, reverse martingale convergence in L^2 gives convergence to E[g(X_r)|G]. Conditioning on H gives the fixed random variable E[g(X_r)|H] by the tower property. The squared norm of the difference therefore converges to D_{r,g}, proving the identity.

Conditional expectation onto H is the least-squares projection. A competitor is the H-measurable variable K_{s,r}g(X_0), using the assumed globally Lipschitz version. Thus

$$E\operatorname{Var}(K_{s,r}g(X_s)|X_0)
\le E|K_{s,r}g(X_s)-K_{s,r}g(X_0)|^2
\le L_s^2 E|X_s-X_0|^2.$$

The last expectation equals E|X_s|^2-E|X_0|^2 by the martingale identity. Taking a liminf proves the bound. Bounded Lipschitz functions determine probability measures; equality of conditional expectations for a countable determining class and a monotone class argument gives the usual Markov property at zero for all bounded Borel tests. Conversely Markovness gives D=0. This is a criterion for an existing positive-time Markov realization, not a complete criterion in terms of marginal data.

For the forced-germ examples in round 02, let A be the fair germ event with E[1_A|X_0]=1/2 and let A_n be the one-time classifiers tending to A in L^2. For large n, a bounded Lipschitz function g of X_{t_n} approximates 1_{A_n} in L^2 to arbitrary accuracy (regularity of probability measures on R^d). Hence choose ||g(X_{t_n})-1_A||_2<1/4. The difference of the two nested conditional expectation projections is an orthogonal projection, with norm at most one. Thus sqrt(D_{t_n,g})>=1/2-||g(X_{t_n})-1_A||_2>1/4. Every Lipschitz version of the corresponding transitions must obey the bound in Theorem C. This quantifies the obstruction; it does not assume the existence of a globally Lipschitz version.

## 8. Classification and exact remaining gap

For a fixed prescribed covariance path, the following table separates the quantifiers.

| Condition | Universal raw Markov with continuous paths | Universal usual Markov with continuous paths |
|---|---|---|
| Q(0) positive definite | yes | yes (fixed-kernel argument, also Sections 3-4) |
| Q(t) singular for some t>0 | no | no |
| Q(t) positive definite for all t>0, corank Q(0)>=2 | yes | no (round 02 germ obstruction) |
| Q(t) positive definite for all t>0, corank Q(0)=1 | yes | unresolved in general |

For arbitrary prescribed Q(0) and Q(t), Theorem A supplies an instance-adapted repair. In particular, for every peacock and every epsilon>0 there exists an additive increasing covariance R(t), R(0)=0, tr R(T)<=epsilon, making the baseline family usually strong Markov realizable. Take eta<=epsilon/k. The infimum of the extra terminal trace cost in this adaptive class is zero; it is attained exactly when the baseline family itself already has the required continuous strong Markov realization, since PSD monotonicity and tr R(T)=0 force R(t)=0 at every time.

This is the quantifier distinction:
- Given a fixed Q in advance, a bad peacock may be chosen (round 02).
- Given a peacock, its variance clock can be used to choose a sufficiently slow vanishing additional noise schedule (this round).
There is no contradiction. A one-dimensional blind direction that persists for positive time precludes universal continuous realization, but jumping realizations are not excluded by the gap argument. The fixed positive-time-nondegenerate corank-one usual-filtration classification remains an open target of this research project. The general unregularized raw-filtration existence problem in PRS remains unresolved here.

## 9. Literature and verification scope

Pammer, Robinson and Schachermayer, A Regularized Kellerer Theorem in Arbitrary Dimension, Ann. Appl. Probab. 35 (2025), 749-778, DOI 10.1214/24-AAP2125, https://arxiv.org/abs/2210.13847. Their Theorem 1.1 uses positive initial Gaussian variance and their examples establish failure in the usual filtration for prescribed zero-initial noise. Their raw-filtration question is distinct. Our statements concerning adaptive schedules and the exact raw continuous-path classification use the time-dependent flux method and do not settle their unregularized question. We do not claim priority without an independent comprehensive literature review.

Hirsch and Roynette, On R^d-valued peacocks, ESAIM Probability and Statistics 17 (2013), 444-454, provides the multivariate martingale existence step. Trevisan, Well-posedness of Multidimensional Diffusion Processes with Weakly Differentiable Coefficients, EJP 21 (2016), DOI 10.1214/16-EJP4453, provides the superposition principle. Classical PSD square-root regularity and localized SDE well-posedness are used explicitly, not presented as new results.

The adjacent Lean file proposes checks of the scalar algebraic domination in Section 5 and the scalar zero-cost implication for nonnegative increasing costs. It is not a formalization of the flux, Gaussian differentiation, reverse martingale theorem or SDE machinery. No local Lean executable was available when this round was prepared, so the new Lean source must not be labeled as kernel-verified until an actual compiler run succeeds. Earlier round build logs remain unchanged.
