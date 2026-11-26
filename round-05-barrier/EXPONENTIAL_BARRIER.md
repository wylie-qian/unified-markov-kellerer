# Exponential barrier obstruction and the critical logarithmic scale

Round 05 — research draft, 2026-11-27. We give a new tail-summability obstruction, strengthen the round-04 Gaussian-active-axis counterexample, and close the log-power family in the deterministic-start energy clock, conditional on the round-04 positive theorem. The base construction is elementary; the regularized state space is genuinely continuous. No finite-grid optimization is used. Historical priority and the main stochastic-process theorems have not been independently certified. This does not resolve the general fixed-path corank-one usual-filtration question or the unregularized raw-filtration problem.

## 1. Statements

Let a peacock be a weakly continuous family in P_2(R^d) increasing in convex order. Usual filtration means the completed, right-continuous natural filtration. All Markov assertions concern the full state, not its projections. We allow arbitrary square-integrable martingale candidates, including jumping paths, for nonexistence results.

Fix d>=2, orthonormal e_1,e_2, the plane W=span(e_1,e_2), and V=W-perp. Let (gamma_t) on [0,1] be any centered P_2 peacock whose projection onto W at time zero is delta_0. For a random vector G_t with law gamma_t write G_t^j=<G_t,e_j>. This notation specifies only one-time noise distributions; there is no assumption about their coupling with a candidate process.

For t_n=2^(-n), n>=0, put h_n=sqrt(t_n)/8. Define the nonnegative tail budget

$$
E_n=\sum_{j=1}^2\left[
 P(|G_{t_n}^j|\ge h_n/2)+P(|G_{t_{n+1}}^j|\ge h_n/2)
 +h_n^{-1}E(|G_{t_n}^j|1_{\{|G_{t_n}^j|\ge h_n\}})
\right].
$$

**Theorem 5.1 (kernel-independent exponential barrier mechanism).** There exists an explicit deterministic-start peacock (lambda_t), supported on the two axes in W and with second moment exactly t/2, such that if

$$\sum_{n=0}^\infty E_n<\infty,$$

then (lambda_t*gamma_t) has no Markov martingale realization in the usual filtration. The conclusion also holds if the other d-2 noise coordinates are correlated with either blind coordinate or have nontrivial initial laws.

**Corollary 5.2 (anisotropic Gaussian tail criterion).** Let Q(t) be any continuous Loewner-nondecreasing PSD covariance curve with W contained in ker Q(0), and write

$$r_n=\max_{j=1,2}e_j^\top Q(t_n)e_j.$$

If

$$\sum_n\exp(-t_n/(512r_n))<\infty,$$

where the summand is zero if r_n=0, then lambda_t*N(0,Q(t)) has no usual-filtration Markov martingale realization. If Q(t) is positive definite for t>0, all positive-time marginals have everywhere positive smooth densities.

The constant 512 is an explicit sufficient constant, not asserted optimal. In the isotropic case Q(t)=q(t)I, the criterion includes all

$$q(t)=O(t/(\log(e/t))^p),\quad p>0,$$

and more generally

$$q(t)=o(t/\log\log(e^e/t)).$$

It also applies at the latter log-log boundary for sufficiently small coefficients: for instance q(t)<=c_0 t/log log(e^e/t) near zero with 0<c_0<1/512.

**Corollary 5.3 (sharp log-power family on the energy clock).** For deterministic-start peacocks define theta(t)=t+E|X_t-X_0|^2 and S=theta(T). For d>=2 and eta>0, consider

$$q(s)=\frac{\eta s}{(\log(eS/s))^p},\qquad 0<s\le S,\quad q(0)=0,\quad p\ge0.$$

The universal usual-filtration continuous strong Markov realization claim holds for p=0 by round 04 Theorem 4.1; for every p>0 it fails, even for jumping candidates. The negative assertion can be witnessed by an input peacock with everywhere positive smooth density at every positive time and a continuous martingale realization. Thus within this log-power family the critical exponent is exactly zero, subject to independent validation of the round-04 positive theorem. A general q=o(s) is not classified: q(s) approximately s/log log log(1/s), for example, is outside the proved summability region.

## 2. Construct the axis peacock

Use alternating clocks a_1,a_2, with derivatives 1,0 on alternating dyadic intervals (t_{n+1},t_n], and 0,1 on the others. Both start at zero. At dyadic endpoints the geometric series gives

$$a_1(t_n)+a_2(t_n)=t_n,\quad
\{a_1(t_n),a_2(t_n)\}=\{t_n/3,2t_n/3\}.$$

At every interval one clock is frozen (constant). Write b_j(t)=sqrt(a_j(t)). Set

$$
\lambda_t=\tfrac14(\delta_{b_1(t)e_1}+\delta_{-b_1(t)e_1}
+\delta_{b_2(t)e_2}+\delta_{-b_2(t)e_2}).
$$

Equivalently first choose a fair branch J in {1,2}, then an independent fair sign on its active axis. Each symmetric two-point family with increasing radius is increasing in convex order: if 0<=a<=b, the values of any convex function at +/-a are bounded by interpolation between +/-b, and averaging cancels the asymmetric coefficients. The zero-radius case is Jensen's inequality. Each clock is continuous nondecreasing, hence lambda is a weakly continuous centered P_2 peacock, with

$$\int |x|^2\lambda_t(dx)=(a_1(t)+a_2(t))/2=t/2.$$

Convolution with gamma preserves convex order and weak continuity (apply convex order to one independent summand and then the other). At each endpoint of a dyadic interval, b_j(t)>=sqrt(t_n/6)>=3h_n, for both j. Indeed 1/6>9/64. Also h_{n+1}=h_n/sqrt(2) lies strictly between h_n/2 and h_n.

We only use the one-time representation M+G_t with M distributed as lambda_t and independent G_t. In particular the candidate Y below need not carry any common branch or sign variable across times.

## 3. A deterministic convex barrier

Define phi_h(x)=(|x|-h)^+ for h>0 and the subgradient b_h(v)=1 if v>h, -1 if v<-h and 0 otherwise. Let

$$D_h(u,v)=\phi_h(u)-\phi_h(v)-b_h(v)(u-v).$$

By convexity D_h>=0. Since phi_h is 1-Lipschitz and |b_h|<=1, D_h(m+g,m)<=2|g|. If m=0 or |m|>=3h, and |g|<=h, the two arguments lie on the same affine segment of phi_h; hence D_h(m+g,m)=0. Consequently,

$$0\le D_h(m+g,m)\le 2|g|1_{\{|g|>h\}}
\quad(m=0\ \text{or}\ |m|\ge3h). \tag{5.1}$$

This is the new barrier certificate. For independent centered noise G and such an M, the linear term has zero expectation, so

$$0\le E\phi_h(M+G)-E\phi_h(M)
\le2E(|G|1_{\{|G|\ge h\}}). \tag{5.2}$$

The upper bound is valid for a mixture of allowed centers, regardless of the sign of the displacement. Integrability follows from finite first moments.

If indicators 1_{|u|<=h} and 1_{|v|<=h} disagree, either D_h(u,v)>=h/2 or h/2<|u|<=2h. To check the first far-crossing case, |v|<=h and |u|>=2h give D_h=|u|-h>=h. In the reverse direction |v|>h and |u|<=h/2 give D_h=h-sign(v)u>=h/2. All other crossings are in the stated annulus. Thus for any scalar martingale values U (later) and V (earlier),

$$
P(\{|U|\le h\}\triangle\{|V|\le h\})
\le \frac2h(E\phi_h(U)-E\phi_h(V))+P(h/2<|U|\le2h).
\tag{5.3}
$$

This uses the bounded measurable subgradient and E[U-V|F_earlier]=0. It is valid for jumps and no continuity of paths is used.

A second deterministic fact is that if |g|<h/2, then the zero center falls inside every threshold in [h/2,h], whereas every center |m|>=3h satisfies |m+g|>2h. In either case the annulus (h/2,2h] is avoided. These facts explain why there is no polynomial Gaussian small-ball term from the broad component in the present construction.

## 4. Classifiers and summable label changes

Let Y be an arbitrary square-integrable martingale with the specified convolved marginals. Define F_n^j={|<Y_{t_n},e_j>|\le h_n}. At either endpoint t_n,t_{n+1}, each coordinate's classifier agrees with the branch that is inactive in that coordinate whenever |G^j|<h_n/2 (also using h_{n+1} in the earlier classifier). This is a probability bound computed from the prescribed one-time law, not an assertion that Y has a shared label process.

In particular,

$$P(F_n^2)\longrightarrow1/2,$$

and the probability of F_n^2 disagreeing with the complement of F_n^1 is bounded by the sum of the two directional tail probabilities at t_n. The analogous earlier-time discrepancy is bounded by the two directional tails at t_{n+1} in E_n. A discrepancy between the earlier threshold h_{n+1} and the common threshold h_n is likewise bounded by the appropriate earlier tail. The annulus probability at the later date is bounded by the later tail.

On [t_{n+1},t_n] select a frozen coordinate j. Its base marginal is the same three-point law at both times (zero with probability 1/2 and +/-b with probability 1/4 each). By Jensen at the earlier date and (5.2) at the later date, the increment of its expected convex payoff at common threshold h_n is at most

$$2E(|G_{t_n}^j|1_{\{|G_{t_n}^j|\ge h_n\}}).$$

Applying (5.3) and then changing the earlier threshold shows

$$
P(F_n^j\triangle F_{n+1}^j)
\le 4h_n^{-1}E(|G_{t_n}^j|1_{\{|G_{t_n}^j|\ge h_n\}})
+P(|G_{t_n}^j|\ge h_n/2)+P(|G_{t_{n+1}}^j|\ge h_n/2).
$$

When coordinate 2 is frozen use this directly. Otherwise exchange coordinate 2 with the complement of coordinate 1 at both times and use the symmetric-difference triangle inequality. In either case

$$P(F_n^2\triangle F_{n+1}^2)\le4E_n. \tag{5.4}$$

The assumed summability and Borel-Cantelli give an event A=limsup F_n^2, with indicators converging almost surely and in L1 and P(A)=1/2. As t_n decreases to zero, A lies in the initial right-limit sigma-field, hence in F_0 of the usual filtration.

## 5. The full initial state cannot encode the label

If d>2 or the transverse noise is nontrivial at time zero, it is insufficient to say that the projection of a Markov process is Markov (which is false in general). Instead prove independence from the entire initial state.

Write Z_t=P_V Y_t. In the one-time mixture construction, P_V M=0 and Z_t=P_V G_t. The fair branch is independent of the entire G_t, irrespective of its internal correlations. For any bounded continuous f on V,

$$
|E[1_{F_n^2}f(Z_{t_n})]-\tfrac12 Ef(Z_{t_n})|
\le \|f\|_\infty P(|G_{t_n}^2|\ge h_n/2)\longrightarrow0.
$$

Convex order and the terminal finite second moment give uniform integrability of squared norms (use convex tail tests (|x|^2-R)^+). Thus weak continuity of the noise peacock implies continuity of its second moment. For the projected martingale, the covariance identity gives E|Z_{t_n}-Z_0|^2=E|Z_{t_n}|^2-E|Z_0|^2 ->0. Passing to the limit using bounded continuity and L1 convergence of the classifier yields

$$E[1_A f(Z_0)]=\tfrac12 Ef(Z_0).$$

Bounded continuous functions determine finite Borel measures, and the blind initial coordinates vanish, so Y_0=Z_0 a.s. We obtain E[1_A|Y_0]=1/2.

Were Y Markov in the usual filtration, at time zero we would have E[1_{F_n^2}|F_0]=E[1_{F_n^2}|Y_0]. Since A belongs to F_0,

$$P(A\cap F_n^2)=\tfrac12 P(F_n^2).$$

The left-hand side tends to 1/2, the right-hand side to 1/4, a contradiction. This proves Theorem 5.1, including the nontrivial transverse initial state and jumping candidates.

## 6. Gaussian criterion and the critical scale

For G~N(0,r), r>0, Chernoff's inequality gives P(|G|>=a)<=2exp(-a^2/(2r)), and direct integration of the Gaussian density gives

$$E(|G|1_{\{|G|\ge a\}})=\sqrt{2r/\pi}\exp(-a^2/(2r)).$$

For r=0 both quantities are zero if a>0. By Loewner monotonicity the directional variances at both endpoints are at most r_n. The exponents for h_n/2 and h_n are respectively t_n/(512r_n) and t_n/(128r_n). The summability assumption implies r_n<=t_n eventually (otherwise infinitely many summands are bounded below by exp(-1/512)). For sufficiently large n, each tail is at most 2exp(-t_n/(512r_n)); each normalized truncated first moment is at most 8exp(-t_n/(512r_n)). Summing the four tails and two moments yields

$$E_n\le24\exp(-t_n/(512r_n)).$$

In particular the label-change probability is at most 96 times this exponential without any density small-ball penalty from the active centers. Corollary 5.2 follows.

If q(t)=O(t/log^p(e/t)), p>0, then t_n/q(t_n)>=c(n+1)^p, and exp(-c'(n+1)^p) is summable for every positive p (for large n it is bounded by (n+1)^(-2)). If q(t)=o(t/log log(e^e/t)), the exponent divided by log(n+2) tends to infinity, so the same comparison proves summability. For q<=c_0 t/log log(e^e/t), the exponent is at least (1/(512c_0))log(e+n log 2), which gives a convergent p-series when c_0<1/512. No optimal log-log coefficient is claimed.

For the axis peacock lambda, theta(t)=3t/2 and S=3/2 on [0,1]. Thus the energy-clock schedule in Corollary 5.3 is exactly q(theta(t))=(3eta/2)t/(log(e/t))^p. Its failure for p>0 follows directly; p=0 is the linear energy-clock positive theorem of round 04 (apply its q-clock version). This is an exact dichotomy for the parameter p>=0, not a claim about every sublinear function.

## 7. Strengthening: the input itself can have smooth positive densities

The preceding result is not a finite-state optimization example: Gaussian convolution already produces continuous, positive-time full-support densities. To remove even the atomic input at positive times, put

$$\mu_t=\lambda_t*\mathcal N(0,t^2 I_d),\qquad
\theta(t)=\tfrac32 t+d t^2.$$

This remains a centered P_2 peacock and has everywhere positive smooth density for every t>0, with mu_0=delta_0. In fact it has a continuous martingale realization without requiring the main positive theorem of round 04: condition on the initial fair choice of axis; on the active axis use the scalar peacock given by the symmetric two-point distribution with radius b_j(t) convolved with N(0,t^2). All scalar supports are connected (a point at zero and full R for positive times). Lowther's one-dimensional continuous fitting theorem applies. In the inactive coordinates use independent Brownian motions run on the t^2 clock. Mix the two resulting martingales using the fair axis choice, which preserves the martingale property (first in the enlarged filtration, then in the natural filtration).

The final regularized family is lambda_t*N(0,[t^2+q(theta(t))]I_d). For every p>0 in Corollary 5.3, the total variance t^2+q(theta(t))=O(t/log^p(e/t)) near zero, since theta(t)/t is bounded above and below by positive constants. The summability obstruction applies exactly as before. The same argument applies to a little-o log-log schedule on the energy clock. Thus smoothness of the original positive-time marginals does not prevent the obstruction.

## 8. Relation to preceding rounds and literature

The round-02/04 alternating Gaussian-axis construction gives a polynomial small-ball error from its active coordinate and the latter round uses convex-payoff increments to reach p>2. The change to a symmetric separated two-center active law and the exact affine-region barrier (5.1) eliminates that source of error. The general tail budget (5.4) works for non-Gaussian convolution as well. The earlier multidimensional germ-obstruction mechanism is due to the ideas of Pammer, Robinson and Schachermayer, A Regularized Kellerer Theorem in Arbitrary Dimension, Ann. Appl. Probab. 35 (2025), 749-778, DOI 10.1214/24-AAP2125, https://arxiv.org/abs/2210.13847. The scalar smooth input construction uses Lowther, Fitting Martingales To Given Marginals, https://arxiv.org/abs/0808.2319 (continuous fitting with connected supports). The present limited literature search has not identified the exact tail-summability and log-power statements; it is not a proof of novelty.

Remaining targets: (i) log-log/iterated-log and arbitrary sublinear energy-clock schedules (matching sufficient condition); (ii) nondeterministic initial laws for the critical positive theorem; (iii) fixed prescribed initial corank one with evolving transverse coordinates; (iv) the unregularized raw-filtration problem. None is claimed solved here.

## 9. Formal verification boundary

BarrierCore.lean isolates the deterministic barrier, affine-region equality, envelope and classifier separation. It is a complete candidate tactic script without admitted declarations, but local Lean/Lake/Elan were absent and the GitHub download probe failed DNS resolution. The actual compiler audit is not complete. The script verify_barrier.py executes exact rational sanity tests and symbolic checks; these finite tests do not establish the universal real inequalities by themselves. The algebraic certificates do not formalize the Gaussian integrals, Borel-Cantelli lifting, conditional expectations, or the stochastic-process theorem. Round-04 existence is still a mathematical proof draft and must be checked independently before calling the combined classification a certified theorem.
