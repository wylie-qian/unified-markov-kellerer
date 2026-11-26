# Critical noise scales and entrance mixing for multidimensional peacocks

Round 04, mathematical research draft. The stochastic-process theorems are not Lean-certified and historical priority is not established. This note supplies a sharp power-law classification for deterministic initial states and isotropic energy-clock Gaussian regularization, a logarithmic-scale obstruction, and a corank-one subclass. It does not close the general fixed-covariance corank-one usual-filtration problem or the unregularized multidimensional raw-filtration problem.

## 1. Definitions and results

Let $(\mu_t)_{0\le t\le T}$ be a weakly continuous peacock in $\mathcal P_2(\mathbb R^d)$; i.e. $\mu_s\preceq_{\rm cx}\mu_t$ for $s\le t$. A realization is a square-integrable martingale with exactly the specified one-time marginals. "Usual filtration" refers to the completed right-continuous natural filtration. Strong Markovness is the time-inhomogeneous (space-time) property.

**Theorem 4.1 (linear noise on the energy clock).** Suppose $\mu_0=\delta_m$ and $v(t)=\int |x-m|^2\mu_t(dx)$ is Lipschitz in a time coordinate $t\in[0,T]$. Suppose $Q(0)=0$, $Q$ is absolutely continuous, and for some $0<\lambda\le\Lambda<\infty$,

$$\lambda I\preceq Q'(t)\preceq\Lambda I\qquad\text{a.e.}$$

Then $\nu_t=\mu_t*\mathcal N(0,Q(t))$ has a continuous square-integrable strong Markov realization in the usual filtration, with the unperturbed initial point $m$.

In particular, for any strictly increasing continuous scalar clock $q:[0,T]\to[0,\infty)$ with $q(0)=0$, the same conclusion for covariance $q(t)I$ holds whenever

$$v(t)-v(s)\le K(q(t)-q(s)),\qquad 0\le s<t\le T$$

for some finite $K$. Apply the first theorem in the $q$-clock and pull back by the deterministic time change.

**Corollary 4.2 (sharp exponent, deterministic start).** Write $\theta(t)=t+v(t)$ and fix $\eta>0$. For $0<\alpha\le1$ and every dimension, every peacock starting at $\delta_m$ has a usual-filtration continuous strong Markov realization after Gaussian convolution with covariance $\eta\theta(t)^\alpha I$. For $\alpha>1$ and $d\ge2$, this universal assertion fails, even if competing martingales are allowed jumps.

This exponent refers specifically to the energy clock and a universal assertion within the deterministic-start class. It is not a classification of all initial laws, all prescribed covariance matrices, or a necessary condition for each individual peacock.

**Theorem 4.3 (sublinear logarithmic obstruction).** For any continuous nondecreasing $q:[0,1]\to[0,\infty)$ with $q(0)=0$ and

$$q(t)\le C t/(\log(e/t))^p,\qquad p>2,\quad t>0,$$

the alternating-axis peacock below, whose energy is exactly $t/2$, has no usual-filtration Markov realization after convolution with $\mathcal N(0,q(t)I_2)$. If $q(t)>0$ for all $t>0$, all the positive-time marginals have smooth, strictly positive densities. The conclusion excludes jumping candidates too.

Consequently the upper and lower results match at the power exponent $1$, not at the logarithmic correction: this argument does not classify $q(t)=t/\log(e/t)^p$ for $0<p\le2$.

**Theorem 4.4 (corank one with frozen transverse marginal).** Let $e$ be a unit vector and $V=e^\perp$. Suppose the $V$-projection of $\mu_t$ is constant in time, without imposing independence of the two coordinates. Let $H$ be positive definite on $V$ and zero on $\mathbb Re$. For any continuous nondecreasing $q$ with $q(0)=0$ and $q(t)>0$ for $t>0$,

$$\mu_t*\mathcal N(0,H+q(t)ee^\top)$$

has a continuous martingale realization that is Markov in its usual filtration. No rate restriction relative to the energy clock is needed. This is a sufficient structural subclass of the fixed-path corank-one case; transverse evolution remains unclassified. The proof below establishes ordinary Markovness of the mixture at deterministic times and does not additionally assert a jointly measurable strong Markov family for all starting points.

## 2. Flux and diffusion with deterministic initial point

Translate to $m=0$. A multidimensional peacock has a martingale realization by Hirsch--Roynette (2013). As in round 02, its continuous bracket and the positive chord representation of jumps yield a PSD matrix-valued spatial flux $F_t$ with

$$
\partial_t\mu_t=\tfrac12\sum_{ij}\partial_{ij}(F_t)_{ij},
\qquad \operatorname{tr}F_t(\mathbb R^d)=v'(t)\le K.
$$

Here the identity is distributional, the time disintegration exists by the absolute continuity of $v$, and $K$ is a Lipschitz constant for $v$. More explicitly, a jump $z$ from $x$ contributes $2zz^\top\int_0^1(1-r)\delta_{x+rz}\,dr$; Taylor's formula verifies the identity and the total mass. The trace budget follows from the square-integrable martingale covariance identity.

For $t>0$ let $g_{Q(t)}$ be the Gaussian density, $\rho_t=\mu_t*g_{Q(t)}$ and $H_t=F_t*g_{Q(t)}$. Define

$$a_t(x)=Q'(t)+B_t(x),\qquad B_t(x)=H_t(x)/\rho_t(x).$$

The matrix is PSD and $a_t\ge\lambda I$. Gaussian differentiation in the covariance gives $\partial_t\nu=\tfrac12\sum_{ij}\partial_{ij}(a_{ij}\nu)$. The equation can first be tested on a positive-time interval, then extended to zero by weak continuity and the finite flux budget

$$\int_0^T\int\operatorname{tr}a_t(x)\nu_t(dx)\,dt=v(T)+\operatorname{tr}Q(T).$$

Trevisan's superposition theorem gives a continuous martingale-problem solution $M$ with all the marginals $\nu_t$. The bracket budget makes it a true square-integrable martingale. On every compact positive-time interval the covariance has integrable local spatial Lipschitz bounds, and the uniform ellipticity makes the principal square root locally Lipschitz there. The corresponding local SDE has pathwise uniqueness and a measurable maximal solution family. Conditional continuation of the actual nonexplosive solution shows the strong Markov property at positive starting times. Only nonexplosion under the specified entrance law is needed. This step does not by itself give Markovness at zero.

## 3. Log-time scaling removes the singular coefficient scale

Put $t=e^u$, $-\infty<u\le\log T$, and set

$$Z_u=e^{-u/2}M_{e^u}.$$

On every finite log-time interval, the change of clock and Itô's formula give

$$dZ_u=-\tfrac12Z_u\,du+
a_{e^u}(e^{u/2}Z_u)^{1/2}\,dW_u.$$

Brownian motion here is the time-transformed driving noise on the chosen finite interval; no Brownian initial condition at $u=-\infty$ is assumed.

Let $\widetilde\mu_t$ and $\widetilde F_t$ be pushforwards under $x\mapsto x/\sqrt t$ (the matrix masses of $\widetilde F_t$ are not scaled). Then

$$B_t(\sqrt t\,z)=
\frac{\int g_{Q(t)/t}(z-y)\widetilde F_t(dy)}
{\int g_{Q(t)/t}(z-y)\widetilde\mu_t(dy)}.$$

Uniformly for $t>0$,

$$
\lambda I\preceq Q(t)/t\preceq\Lambda I,\qquad
\int |y|^2\widetilde\mu_t(dy)\le K,\qquad
\operatorname{tr}\widetilde F_t(\mathbb R^d)\le K.
$$

The Gaussian kernels with covariance in this compact elliptic matrix interval have bounded derivatives through order two and a strictly positive common lower bound on any given compact. Tightness of $\widetilde\mu_t$ gives a uniform lower bound for the denominator on each spatial compact. Quotient differentiation therefore gives a uniform (in $u$) local $C^2$ bound for $B_{e^u}(e^{u/2}\cdot)$. The diffusion matrix of $Z$ is locally bounded and locally Lipschitz with constants independent of $u$ and is uniformly elliptic below by $\lambda I$.

There is also a uniform moment estimate,

$$\sup_{u\le\log T}E|Z_u|^2\le K+d\Lambda=:L.$$

The deterministic initial point is essential here. For a general random initial point $M_0$, rescaling the uncentered process does not give this bound; replacing $M_0$ by a random centering does not automatically preserve a Markov transition family.

## 4. Compact minorization in log time

We use the following standard heat-kernel consequence, explaining the localization to avoid presupposing global conservativity of the actual diffusion.

For every $R\ge1$ there is $\epsilon_R>0$ and a probability measure $\zeta_R$ (uniform on $B_1$ suffices) such that the maximal log-time transition kernel satisfies

$$P_{u,u+1}(x,\cdot)\ \ge\ \epsilon_R\zeta_R(\cdot),
\qquad |x|\le R,\ u+1\le\log T. \tag{4.1}$$

To establish this, use a smooth nonnegative cutoff equal to one on $B_{R+2}$ and vanishing outside $B_{R+3}$. Extend the diffusion matrix to $Q'(e^u)+\chi_R B_{e^u}(e^{u/2}\cdot)$ and truncate the drift. The resulting global coefficient is bounded, uniformly elliptic, uniformly spatially Lipschitz, and measurable in time. Standard two-sided Gaussian heat-kernel estimates on intervals of length at most one apply, with constants independent of the time origin. One way to see the applicability is to rewrite the backward generator in divergence form, moving the bounded spatial derivative of the diffusion matrix into the bounded drift, and use the classical Aronson bounds after reversing time. Alternatively use nondivergence-form heat-kernel estimates for uniformly spatially Lipschitz coefficients with bounded measurable drift. See Aronson (1967, 1968) and Kusuoka (2015).

Kill the extended diffusion on leaving $B_{R+2}$. For endpoints $x,y\in B_{R+1}$ at distance at most $\sqrt h$, the Gaussian lower bound for the unrestricted density is at least $c h^{-d/2}$ for $h\le1$. The killed density is the unrestricted density minus the contribution from paths exiting before the terminal time (Hunt's formula). An exit point has distance at least one from $y$. The Gaussian upper bound shows that this contribution is bounded by

$$C\sup_{0<r\le h}r^{-d/2}\exp(-c'/r),$$

which is $o(h^{-d/2})$ as $h\downarrow0$. Hence for sufficiently small $h$ the killed density is at least $c_1h^{-d/2}$ at these endpoints, uniformly in the time origin.

Take $h=1/N$ small enough that the equally spaced points on a line from $x\in B_R$ to $y\in B_1$ are within $\sqrt h/4$. In the Chapman--Kolmogorov integral for the killed kernel over the $N$ subintervals, restrict each intermediate point to a ball of radius $\sqrt h/8$ around the corresponding line point. All such points lie in $B_{R+1}$ and each successive pair is within $\sqrt h$. The product of the positive lower bounds times the positive intermediate volumes is a positive lower bound independent of $u,x,y$. This proves (4.1). The actual local diffusion agrees with the extended one until the exit by local uniqueness, so its transition kernel dominates this killed kernel. If needed a cemetery point accounts for possible explosion from other starting points; the actual entrance marginals give zero mass to that point.

The heat-kernel theorem is an external analytical input, not a result of the Lean file.

## 5. Entrance mixing and trivial germ

For a fixed terminal log time $u_*$, take $u_*-N,u_*-N+1,\ldots,u_*$. At the earliest time take two independent samples of the actual marginal and couple their transitions. If the two copies coincide, keep them identical. If they are different but both inside $B_R$, use the common portion $\epsilon_R\zeta_R$ in (4.1) to make them coincide with probability at least $\epsilon_R$; otherwise use any coupling. The construction is measurable since the common minorizing law is fixed and the residual kernels are measurable. Each copy retains its prescribed marginal at each step.

Let $p_j$ be the probability of not yet coalescing at step $j$. The union bound and the moment estimate give probability at most $2L/R^2$ of one or both copies being outside $B_R$. Consequently,

$$p_{j+1}\le(1-\epsilon_R)p_j+\epsilon_R(2L/R^2).$$

Induction yields the exact bound

$$p_N\le (1-\epsilon_R)^N+(2L/R^2)[1-(1-\epsilon_R)^N]. \tag{5.1}$$

In particular the bound is not based on an unjustified uniform lower bound on the probability of being inside the compact conditional on noncoalescence.

For bounded Borel $g$, let $f_N(z)=P_{u_*-N,u_*}g(z)$. Taking conditional expectations under the coupling given the two independent initial samples gives

$$E|f_N(Z_{u_*-N})-Ef_N(Z_{u_*-N})|
\le2\|g\|_\infty p_N.$$

The left side is the $L^1$ distance between the conditional prediction of $g(Z_{u_*})$ from the actual history at the earliest time and its unconditional expectation. This uses positive-time Markovness. First let $N\to\infty$ with $R$ fixed, then let $R\to\infty$. Reverse martingale convergence shows

$$E[g(Z_{u_*})\mid\mathcal F_{0+}^{M}]=E[g(Z_{u_*})]\quad\text{a.s.}$$

where $\mathcal F_{0+}^{M}$ is the initial germ in original time. Translating back from the scaled state gives the same identity for $g(M_r)$ for every $r>0$. By positive-time Markovness, the result also applies to products of bounded functions at finitely many strictly positive times (condition at the first such time). A monotone class argument extends it to the sigma-field of the continuous path. The germ belongs to that completed sigma-field, hence is trivial modulo null sets. Since $M_0$ is deterministic, Markovness at zero relative to the usual filtration follows. Together with the positive-time strong Markov property it gives the strong Markov property: split any stopping time into its zero part and its positive part, localizing the latter on stopping times bounded away from zero.

This proves Theorem 4.1. In particular it does not require strong uniqueness for the singular SDE started at zero.

## 6. Consequences for the power scale

Convex order and terminal square integrability give continuity of $v$ by uniform integrability; $\theta=t+v(t)$ is a continuous strictly increasing clock. In the $\theta$-clock the energy is 1-Lipschitz. For $0<\alpha\le1$ on the finite clock interval $[0,S]$ the function $q(s)=\eta s^\alpha$ has increments at least $\eta\alpha S^{\alpha-1}$ times the increments of $s$. Thus $v$ is Lipschitz in the $q$-clock. Apply Theorem 4.1 with covariance $r I$ in this last clock. Time changes are deterministic and continuous strictly increasing, preserving the usual-filtration strong Markov property of the space-time process.

The counterexample for $\alpha>1$ follows from the next section, with $v(t)=t/2$ and $\theta(t)=3t/2$. Such $q(t)=\eta(3t/2)^\alpha$ is bounded by $C t/(\log(e/t))^p$ on $[0,1]$ for every fixed $p>2$, after choosing $C$. In dimensions above two embed the base law in a two-plane and convolve with the isotropic Gaussian on all dimensions; the initial point remains deterministic and the two scalar martingale projections still force the germ. This proves Corollary 4.2.

## 7. A sharper counterexample from convex price increments

Let $t_n=2^{-n}$, and alternate the two clocks $a_1,a_2$ with slopes $1,0$ and $0,1$ on successive intervals $[t_{n+1},t_n]$. Then $a_1+a_2=t$ and $t/3\le a_j(t)\le2t/3$. The base peacock is the fair mixture of the laws of Brownian motion on the two axes with these clocks, as in round 02. Its energy is $t/2$. After isotropic smoothing the marginal of coordinate $j$ is

$$\tfrac12\mathcal N(0,a_j(t)+q(t))+\tfrac12\mathcal N(0,q(t)).$$

Let $Y$ be any candidate martingale with the specified vector marginals. No mixture labels are assumed to be common across times.

### 7.1 Convex crossing certificate

For $h>0$ use the convex payoff $\phi_h(x)=(|x|-h)^+$ and its subgradient $b_h(v)=1$ if $v>h$, $-1$ if $v<-h$, and zero otherwise. Define the nonnegative Bregman gap

$$D_h(u,v)=\phi_h(u)-\phi_h(v)-b_h(v)(u-v).$$

For an earlier state $v$ and later state $u$, if the indicators of $|v|\le h$ and $|u|\le h$ disagree, then

$$D_h(u,v)\ge h/2\quad\text{or}\quad h/2<|u|\le 2h. \tag{7.1}$$

Indeed an inside-to-outside crossing with $|u|\ge2h$ gives gap $|u|-h\ge h$. An outside-to-inside crossing with $|u|\le h/2$ gives gap $h-\operatorname{sgn}(v)u\ge h/2$. All remaining crossings lie in the stated annulus. In particular, for scalar martingale values $U$ (later) and $V$ (earlier),

$$P(\{|U|\le h\}\triangle\{|V|\le h\})
\le \frac2h(E\phi_h(U)-E\phi_h(V))
+P(h/2<|U|\le2h). \tag{7.2}$$

The bounded subgradient times the martingale increment has zero expectation. This convex-price estimate replaces the cruder Chebyshev increment bound in round 02.

For $G_r\sim N(0,r)$ and $r>0$, direct differentiation of the two Gaussian call prices gives

$$\frac{d}{dr}E\phi_h(G_r)=\frac{1}{\sqrt{2\pi r}}e^{-h^2/(2r)}. \tag{7.3}$$

The derivative tends to zero as $r\downarrow0$ for $h>0$, so the formula integrates from zero as well.

### 7.2 Summable classification errors

By hypothesis choose $C_1>0$ so that $q(t_n)\le \bar q_n=C_1t_n(n+1)^{-p}$. Set

$$h_n=\sqrt{\bar q_n\,\ell_n},\qquad \ell_n=32\log(n+2).$$

For all sufficiently large $n$ these thresholds decrease, and $\ell_n>1$. At time $t_n$ a narrow Gaussian has tail above $h_n$ at most $2e^{-\ell_n/2}$; a broad Gaussian of variance at least $t_n/3$ has small-ball probability up to $c h_n$ at most a constant times $c h_n/\sqrt{t_n}$. This applies even if $q(t_n)=0$ (the narrow variable is then zero). As in round 02, the two coordinate classifiers $F_n^j=\{|Y_{t_n}^j|\le h_n\}$ have probabilities tending to one half, and

$$P(F_n^2\triangle(F_n^1)^c)
\le C_2(h_n/\sqrt{t_n}+e^{-\ell_n/2}). \tag{7.4}$$

On $[t_{n+1},t_n]$ choose the frozen coordinate $j$ and apply (7.2) with common threshold $h=h_n$, $U=Y^j_{t_n}$, $V=Y^j_{t_{n+1}}$. The frozen base variance is at least $t_n/3$ at both dates. From (7.3), the increase in the convex price along the broad component is bounded by $C_3\bar q_n/\sqrt{t_n}$. For the narrow component, since $h_n^2\ge\bar q_n$, the function $r^{-1/2}e^{-h_n^2/(2r)}$ is increasing for $0<r\le\bar q_n$. Its price increase is therefore bounded by $C_3\sqrt{\bar q_n}\,e^{-\ell_n/2}$. These are exact bounds on the specified marginal expectations, irrespective of the actual joint law of $U,V$.

The annulus term in (7.2) is at most $C_4 h_n/\sqrt{t_n}+2e^{-\ell_n/8}$. Changing the earlier threshold from $h_n$ to $h_{n+1}$ adds a term bounded by $C_4 h_n/\sqrt{t_{n+1}}+2e^{-\ell_{n+1}/2}$. Since $t_{n+1}=t_n/2$, summing gives

$$P(F_n^j\triangle F_{n+1}^j)
\le C_5\left(\frac{h_n}{\sqrt{t_n}}+
\frac{\bar q_n}{h_n\sqrt{t_n}}+
e^{-\ell_n/8}+e^{-\ell_{n+1}/2}\right). \tag{7.5}$$

For the narrow price term we used $\sqrt{\bar q_n}/h_n=1/\sqrt{\ell_n}\le1$.

The first ratio on the right is $\sqrt{C_1}(n+1)^{-p/2}\sqrt{\ell_n}$; the second is $\sqrt{C_1}(n+1)^{-p/2}/\sqrt{\ell_n}$. Both are summable for $p>2$. The exponential terms are summable by the choice of $\ell_n$. On intervals with coordinate two frozen, (7.5) bounds changes of $F_n^2$. Otherwise substitute the complement of the coordinate-one classifier using (7.4) at both times. Thus

$$\sum_n P(F_n^2\triangle F_{n+1}^2)<\infty.$$

Borel--Cantelli produces a fair event $A=\limsup F_n^2$ whose indicator is the a.s. and $L^1$ limit of the classifiers and which belongs to the initial usual filtration. With deterministic initial point, Markovness at zero would make $A$ independent of each $F_n^2$. Passing to the limit would force $1/2=1/4$. Contradiction. The proof did not use path continuity of $Y$. This proves Theorem 4.3.

## 8. A corank-one subclass: frozen transverse directions

Choose coordinates $(U,V)$ on $\mathbb R e\oplus e^\perp$. Use a square-integrable cadlag martingale $X=(U_t,V_t)$ with original marginals. Because the marginal of $V_t$ is constant, the martingale covariance identity gives $E|V_t-V_0|^2=0$. The cadlag version makes $V_t=V_0$ for all times almost surely.

Let $k$ be the nondegenerate Gaussian density on the transverse subspace with covariance $H|_{e^\perp}$, and set $g(w)=E k(w-V_0)>0$. For every fixed transverse state $w$, define a probability $\mathbb P^w$ on the original space by the bounded positive density $k(w-V_0)/g(w)$. It is measurable at time zero, so it preserves the martingale property. Boundedness for fixed $w$ and unconditional $L^2$ continuity give $L^2$ continuity under $\mathbb P^w$ as well.

The conditional scalar peacock is

$$\xi_t^w=\operatorname{Law}_{\mathbb P^w}(U_t)*N(0,q(t)).$$

It is increasing in convex order and weakly continuous (add independent Brownian noise run on the $q$-clock). For $t>0$ it has full scalar support. At zero no connected-support assumption is needed. Lowther's unique almost-continuous diffusion fitting the scalar marginals (Fitting Martingales To Given Marginals, Theorems 1.3--1.4 and Section 2.1, arXiv:0808.2319) is continuous when all positive-time marginals have full support. Restrict to the finite horizon, extending the marginal family constantly after $T$ for application of his theorem.

To be explicit about filtration augmentation, the scalar continuous strong Markov martingale has the usual one-dimensional Lipschitz--Markov contraction (Lowther; Beiglböck, Pammer and Schachermayer, From Bachelier to Dupire via optimal transport, Finance Stoch. 2022, Section 5). Even if one starts from a raw-filtration convention, ordinary Markovness passes to the usual right-continuous filtration: for a bounded Lipschitz terminal test at time t, conditional expectations at s_n decreasing to s<t are functions f_n(Z_{s_n}) with a common Lipschitz bound. Their difference from f_n(Z_s) tends to zero in L1 by L2 continuity. Reverse martingale convergence then makes the limiting conditional expectation measurable with respect to Z_s. Bounded Lipschitz tests determine the conditional law. Thus ordinary usual-filtration Markovness is sufficient for the fiber argument below.

There is a measurable choice of these scalar path laws $P_w$. Indeed their call surfaces are continuous in $w$ at every $(t,x)$ by dominated convergence, since $k$ is bounded continuous, $g(w)>0$, and the call payoff is integrable. Lowther's continuity theorem gives continuity of expectations of bounded continuous finite-dimensional path functions. On the continuous path space, rational evaluation cylinders generate the Borel sigma-field, so this implies Borel measurability of $w\mapsto P_w$.

Draw a constant transverse state $W$ with density $g(w)$ and conditionally draw the scalar path $Z$ with law $P_W$. The process $(Z_t,W)$ has the desired one-time laws by the formula for conditional Gaussian convolution. It is a martingale by integrating the scalar martingale identities; integrability follows from the original square-integrable marginals. It is Markov relative to the usual natural filtration: for fixed times $s<t$, disintegrate bounded functions of the future state and of the history over $W$. Every conditional path law is scalar usual-filtration Markov. A section at $W=w$ of an event in the completed right-continuous history belongs, for almost every $w$, to the completed right-continuous scalar history (use a countable sequence of times decreasing to $s$ and disintegrate null sets). Its conditional future expectation is a function of the scalar state at $s$. The regular conditional expectation given $(W,Z_s)$ is a jointly measurable version of these fiber expectations for almost every $w$, by disintegration on the standard Borel state space. Thus the integrated history identity gives the desired Markov equality. This proves Theorem 4.4.

The argument does not extend merely by replacing the frozen transverse variable by its slowly evolving counterpart: conditioning on a future moving transverse variable is not a time-zero change of measure. The unrestricted corank-one case needs an additional idea.

## 9. Audit and literature boundary

- Hirsch--Roynette, On R^d-valued peacocks, ESAIM P&S 17 (2013), 444--454, DOI 10.1051/ps/2012009: initial martingale existence.
- Trevisan, Well-posedness of multidimensional diffusion processes with weakly differentiable coefficients, EJP 21 (2016), DOI 10.1214/16-EJP4453: superposition principle.
- Aronson, Bounds for the fundamental solution of a parabolic equation (1967), and Non-negative solutions of linear parabolic equations (1968); Kusuoka, Hölder continuity and bounds for fundamental solutions to non-divergence form parabolic equations (2015), arXiv:1310.4600: classical Gaussian heat-kernel bounds. The spatial Lipschitz, bounded, uniformly elliptic cutoff setting in Section 4 is within the standard Gaussian-estimate regime.
- Lowther, Fitting Martingales To Given Marginals, arXiv:0808.2319: the one-dimensional continuous Markov fitting and continuity of the fitting map.
- Pammer--Robinson--Schachermayer, A regularized Kellerer theorem in arbitrary dimension, Ann. Appl. Probab. 35 (2025), 749--778, DOI 10.1214/24-AAP2125: multidimensional regularization, counterexamples, and the distinct unregularized raw-filtration open question.

The proposed contribution is the entrance mixing argument at the linear energy scale, the matching universal power-law obstruction and sharper logarithmic obstruction using option-price increments, and the frozen transverse sufficient class. The underlying heat kernel, martingale flux, coupling and scalar realization results are established tools. A comprehensive priority check and independent referee-level review are still necessary.

Round 04's Lean source concerns the scalar recurrence (5.1) and the pointwise convex crossing certificate (7.1). It is not compiler-verified yet. Neither it nor the earlier formalized lemmas proves the complete stochastic-process manuscript in Lean. See PROOF_DEPENDENCY_AUDIT.md for the exact distinction.
