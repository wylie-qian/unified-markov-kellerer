# A summability criterion for universal Gaussian regularization in the energy clock

Round 06 — mathematical research draft. This note replaces the proposed conjecture that every sublinear noise schedule fails by an exact criterion within a specified class of regular time schedules. The results are not peer-reviewed or fully Lean-formalized. The general random-initial-law, anisotropic corank-one, and unregularized raw-filtration questions remain open in this project.

## 1. Setting and main theorem

Fix d>=2 and normalize the energy clock to [0,1]. Let C_d be the class of weakly continuous P_2(R^d) peacocks (mu_s) starting at a point delta_m, with

$$v(s)=\int |x-m|^2\,\mu_s(dx),\qquad 0\le v(b)-v(a)\le b-a\quad(0\le a<b\le1).$$

In particular v(0)=0, v(s)<=s, and v'<=1 almost everywhere. We can translate m to zero. This is a natural normalized energy-clock class: the clock theta(t)=t+v(t) is continuous strictly increasing and v in the theta-clock is 1-Lipschitz. A finite clock interval [0,S] can be reduced to [0,1] by rescaling time by S and space by sqrt(S); a variance schedule q on [0,1] becomes S q(s/S) in the unnormalized clock. Conversely a peacock with v'(s)<=c<1 in the s-clock can be viewed as an actual energy-clock example by taking physical time t=s-v(s). These changes are deterministic and preserve the martingale and usual-filtration Markov properties.

Let q:[0,1]->[0,infinity) be continuous nondecreasing, q(0)=0, q(s)>0 for s>0. For the positive direction impose the following local time regularity:

(Q) q is locally absolutely continuous on (0,1], and for every 0<a<b<=1 there are constants 0<l_ab<=L_ab<infinity such that l_ab<=q'(s)<=L_ab almost everywhere on [a,b].

Equivalently, q is locally increasing and bi-Lipschitz away from zero. This includes continuously differentiable schedules whose derivative is strictly positive at positive times. No lower or upper bound on q' uniform down to zero is imposed. By monotonicity, local AC and continuity at zero also imply absolute continuity on [0,1]: integrate q' from a to b and let a decrease to zero by monotone convergence.

Write t_n=2^(-n), and define the following series condition:

$$\mathcal D(q):\quad
\forall C>0,\qquad \sum_{n=0}^{\infty}\exp\left(-\frac{C t_n}{q(t_n)}\right)=\infty. \tag{D}$$

**Theorem 6.1 (exact universal criterion for regular schedules).** For d>=2 and q satisfying (Q), the following are equivalent:

1. Every mu in C_d has, after the Gaussian convolution nu_s=mu_s*N(0,q(s)I_d), a continuous square-integrable strong Markov martingale realization in the usual (completed, right-continuous) natural filtration.
2. Every mu in C_d has a Markov martingale realization of these convolved marginals in the usual filtration, even allowing jumps.
3. Condition (D) holds.

The proof of 3=>1 is the weak-Poincare entrance dissipation argument below. The proof of not-3=>not-2 is the rare-rectangle obstruction, which does not require (Q), only continuity and monotonicity of q. In dimension one the usual Kellerer--Lowther theorem supplies realizations and this obstruction does not apply. The theorem is about a schedule in the energy clock, not a prescribed physical-time covariance curve independent of the input's energy clock.

The result concerns the existence of an appropriate realization; it makes no claim that every realization is Markov. Strong Markovness is time-inhomogeneous (in the space-time state). No global conservativity from arbitrary exceptional starting points is asserted. The assumptions concern deterministic initial laws and isotropic noise.

**Corollary 6.2 (critical double-logarithmic family).** For eta>0 and p>=0 take

$$q(s)=\eta s/[\log\log(e^e/s)]^p,\quad s>0,\qquad q(0)=0.$$

This satisfies (Q). Universal usual-filtration continuous strong Markov realization within C_d holds if and only if p<1, for every eta>0. In particular the boundary p=1 fails for *every* finite positive eta; there is no favorable finite coefficient at that boundary.

More generally q(s)/s times log log(e^e/s) tending to infinity is sufficient (under (Q)); if that product is bounded above near zero, universal realization fails. For irregular rates that do not satisfy either comparison, the full series condition is the criterion. There exist strictly sublinear universal schedules, e.g. p=1/2, and strictly sublinear nonuniversal schedules, e.g. p=1. The conjectured universal implication q=o(s) => nonexistence is false.

## 2. Equivalent integral tests

For any continuous nondecreasing q positive at positive times put delta(s)=q(s)/s. On [t_{n+1},t_n],

$$\delta(t_{n+1})/2\le\delta(s)\le2\delta(t_n).$$

Since r -> exp(-C/r) is increasing on r>0, we have

$$
\log 2\,e^{-2C/\delta(t_{n+1})}
\le\int_{t_{n+1}}^{t_n}e^{-C/\delta(s)}\frac{ds}{s}
\le\log 2\,e^{-C/(2\delta(t_n))}. \tag{2.1}
$$

It follows, by summing and allowing every C>0, that (D) is equivalent to

$$\forall C>0,\quad\int_0^1 e^{-Cs/q(s)}\,\frac{ds}{s}=\infty. \tag{I}$$

Likewise failure of (D) is equivalent to finiteness of this integral for some C>0. The scaling of C is essential; no equivalence at a *fixed* C is claimed.

For use in the existence proof we may assume the variance-to-clock ratio is bounded by one without losing the criterion. Change the clock w=s+q(s), and let p(w)=q(s(w)) with s(w) its inverse; w ranges over [0,W=1+q(1)]. This is a continuous strictly increasing time change. The new v is 1-Lipschitz, p(w)<=w, and p is 1-Lipschitz. On every positive compact time interval, p'(w)=q'(s)/(1+q'(s)) has a strictly positive essential lower bound by (Q).

If q(s)/s is bounded near zero, dw/w>=c ds/s there for some c>0, and w/q(s)=1+s/q(s); thus (I) implies divergence of all corresponding integrals in w. If q(s)/s is unbounded arbitrarily close to zero, choose w_j tending to zero with p(w_j)/w_j>=1/2 and with [w_j,2w_j] disjoint. Monotonicity gives p(w)/w>=1/4 on these intervals. Each contributes at least log(2)e^{-4C} to the w-integral. Hence in either case

$$\forall C>0,\quad \int_0^W e^{-Cw/p(w)}\,\frac{dw}{w}=\infty. \tag{2.2}$$

We now rename the normalized bounded-ratio clock t and the variance curve q, so q(t)<=t, v(t)<=t, and (2.2) holds with upper endpoint T.

The second integral comparison is an exact calculus identity. Write delta(t)=q(t)/t and H_C(r)=integral_0^r exp(-C/u)du with the integrand extended by zero at u=0. The function H_C is bounded on [0,1]. For 0<a<b<=T,

$$
\int_a^b \frac{q'(t)}{t}e^{-C/\delta(t)}dt
=H_C(\delta(b))-H_C(\delta(a))
+\int_a^b \frac{\delta(t)}{t}e^{-C/\delta(t)}dt. \tag{2.3}
$$

Indeed delta'=q'/t-delta/t a.e. and the ordinary chain rule for AC functions applies away from zero. Since exp(-1/r)<=r for all r>0 (use e^x>=x for x=1/r), the last integral dominates the one with exponent C+1 and no factor delta. Boundedness of the endpoint term and (2.2) imply

$$\forall C>0,\qquad \int_0^b\frac{q'(t)}{t}e^{-Ct/q(t)}dt=\infty\quad(0<b\le T). \tag{J}$$

No estimate of q' in terms of q/t at zero is needed. This is why the theorem covers oscillating relative rates as well as standard asymptotic formulas.

## 3. Construct a diffusion before treating the entrance

We spell out the analytic inputs to avoid circular use of round 04 or an unproved heat-kernel mixing estimate.

A weakly continuous multidimensional peacock admits a square-integrable martingale realization (Hirsch--Roynette, 2013). Terminal convex-order domination implies uniform integrability of squared norms using the convex tests (|x|^2-R)^+; in particular weak continuity implies continuity of the second moments. A cadlag version in the usual filtration follows by martingale regularization, or by regularizing a realization on a countable dense time set and using these continuity and integrability properties.

For such a martingale U there is a finite positive-semidefinite matrix-valued space-time measure F, characterized for smooth compactly supported test functions by

$$\mu_b(f)-\mu_a(f)=\tfrac12\int_{(a,b]\times\mathbb R^d}D^2 f(x):F(dt,dx),$$
$$F((a,b]\times\mathbb R^d)=\operatorname{Cov}(\mu_b)-\operatorname{Cov}(\mu_a).$$

Indeed the continuous bracket supplies E[d[U^c]_t delta_{U_{t-}}(dx)]. A jump z at x supplies the PSD spatial measure 2zz^T integral_0^1(1-r)delta_{x+rz}dr at the jump time. The integral Taylor remainder and Ito's formula give the weak equation, and the square-integrable martingale bracket identity gives the total mass (including jumps), by polarization. The stochastic integral in the test equation has zero expectation. Finite trace mass follows from the terminal second moment. The trace time marginal of F is dv, absolutely continuous since v is Lipschitz. Disintegrating the trace and its PSD Radon--Nikodym matrix density yields measurable PSD spatial measures F_t with trace mass v'(t)<=1 almost everywhere and F(dt,dx)=dt F_t(dx).

For t>0 put g_t=N(0,q(t)I)'s density and set

$$\rho_t=\mu_t*g_t,\qquad
B_t=\frac{F_t*g_t}{\rho_t},\qquad a_t=q'(t)I+B_t.$$

The quotient is well-defined at every x, B_t is PSD, and the covariance derivative of Gaussian convolution gives

$$\partial_t\nu_t=\tfrac12\sum_{ij}\partial_{ij}(a_{ij}\nu_t),\qquad
\nu_t(dx)=\rho_t(x)dx.$$

This weak equation follows by testing with the Gaussian-smoothed spatial test; cutoff approximation is valid because its derivatives are bounded and the flux has finite mass. It holds first on positive-time intervals, then to zero by weak continuity and the following exact finite budget:

$$\int_0^T\int \operatorname{tr}a_t(x)\rho_t(x)\,dx\,dt=v(T)+dq(T).$$

Apply Trevisan's superposition principle (Theorem 2.5, EJP 2016). It gives a continuous martingale-problem solution M with these marginals. The integrable total bracket trace upgrades the coordinate local martingales to true square-integrable martingales. On an extension it solves the SDE with diffusion square root a_t^(1/2).

On each compact positive-time interval q has a positive lower bound and q' has strictly positive lower and finite upper bounds. Gaussian convolution, the bound on the mass of F_t, and uniform tightness of mu_t give uniform C^k spatial bounds on B_t on every compact, for each fixed k, because the denominator has a uniform positive lower bound there. In time these coefficients need only be measurable. Thus a_t is locally bounded, uniformly elliptic below on every positive compact time interval, and locally spatially Lipschitz; its positive square root is locally spatially Lipschitz as well. Standard localized SDE uniqueness/existence supplies a unique maximal solution law from positive starting times. The actual superposition solution is global for the specified entrance distribution. Conditional continuation at a positive deterministic time or stopping time is a solution from its current state; uniqueness up to explosion and nonexplosion of that actual continuation establish the positive-time strong Markov property. This does not assume that every possible starting point gives a conservative diffusion.

The remaining question is the initial right-limit germ, since M_0=0 and Markovness at all strictly positive times does not imply Markovness at zero in the usual filtration.

## 4. Backward variance identity at positive times

Fix r>0 and a real smooth compactly supported terminal test g. Write G=||g||_infty, H_t=E[g(M_r)|F_t] for 0<t<r, and h(t,x)=P_{t,r}g(x), where the positive-time transition family is used. Then H_t=h(t,M_t). Let D(t)=E[|H_t-Eg(M_r)|^2]. It is nondecreasing, bounded, and

$$D(b)-D(a)=\int_a^b\int \nabla h(t,x)^\top a_t(x)\nabla h(t,x)\rho_t(x)\,dx\,dt,\qquad 0<a<b<r. \tag{4.1}$$

We justify the spatial gradients and the identity, rather than assuming a classical differentiable semigroup at the singular time zero.

On a positive interval use a nonnegative smooth spatial cutoff chi_N equal to one on B_N and zero outside B_{N+1}. The matrices a^N_t=q'(t)I+chi_N B_t are globally bounded, uniformly elliptic, spatially smooth with bounded derivatives on the interval, and measurable in t. Their SDEs are globally well-posed on the interval. Let h^N(t,x) be their backward expectation of g. Standard uniformly parabolic interior W^{1,2}_p estimates for coefficients measurable in time and uniformly Lipschitz in space apply (e.g. Kim--Krylov, Parabolic equations with measurable coefficients, Potential Anal. 26 (2007), 345--361). To see the connection to these PDE solutions, for the globally truncated equation with smooth spatial coefficients and smooth terminal data, the usual differentiable stochastic-flow argument gives bounded spatial derivatives of h^N for each fixed N. The Markov identity and Ito's formula with a frozen spatial test give time absolute continuity and the backward equation almost everywhere. Alternatively the same function is the probabilistic representation of the parabolic Sobolev solution. For a compact subcylinder of (0,r)xR^d, use a slightly larger subcylinder. For all large N the coefficients are exactly the same there, so the interior estimates give a uniform W^{1,2}_p bound for every finite p sufficiently large, using only ||h^N||_infty<=G and the local bounds on a. Parabolic Sobolev compactness (choose p>d+2) yields a locally continuous subsequential limit with weak W^{1,2}_p derivatives. A diagonal exhaustion of positive times strictly below r gives a version h_* satisfying the local backward equation.

For every fixed t>0 the cutoff solution started at M_t agrees with M until it leaves B_N by local pathwise uniqueness (use a Brownian representation on an extension). The probability of exit between t and r tends to zero, since M has continuous paths on a compact time interval. Conditioning this comparison on the actual history gives

$$E|h^N(t,M_t)-H_t|\le2G\,P(\sup_{t\le u\le r}|M_u|\ge N)\ \longrightarrow0.$$

Consequently the locally uniform subsequential limit is a version of h along the actual path at every deterministic positive time. Its continuous evaluation along the path agrees with the right-continuous conditional-expectation martingale, first on a countable dense set, then throughout positive time. Use this version below.

For completeness, ordinary mollification proves the required generalized Ito formula without imposing smoothness in time. On any compact subcylinder in (0,r)xR^d, smooth mollifications of h_* converge locally uniformly and in W^{1,2}_p. The residual of the backward equation tends to zero in L^p on the subcylinder because a is bounded there. Stop M on leaving a spatial ball inside this subcylinder. The law of M_t restricted to times before this stop is dominated by rho_t dx, and rho_t is uniformly bounded on positive compact time intervals (q has a positive lower bound). Thus the expected integral of the residual tends to zero; the stochastic integral converges in L^2 by convergence of the gradients on the compact and boundedness of a. Passing to the limit in the ordinary Ito formula gives the local formula and bracket density grad h^T a grad h. Exhausting the spatial balls identifies the bracket of H on [a,b]. The bounded martingale H has expected bracket increment E[H_b^2]-E[H_a^2]; monotone convergence gives (4.1). This argument is only on positive time intervals, so it does not presume any regularity at the entrance.

## 5. The elementary weak Poincare estimate

For t>0 let delta(t)=q(t)/t<=1. The law of M_t/sqrt(t) is the convolution of the pushforward mu_t under x->x/sqrt(t), denoted alpha_t, with N(0,delta(t)I). Because v(t)<=t,

$$\int |y|^2\alpha_t(dy)\le1,\quad
\alpha_t(B_2)\ge3/4,\quad
E|M_t/\sqrt t|^2\le 1+d=:L.$$

Let rho_t^scaled be the density of this scaled law, and N_delta=(2*pi*delta)^(-d/2). On a ball B_R,

$$
\tfrac12 N_\delta \exp(-c_R/\delta)
\le \rho_t^{scaled}(z)\le N_\delta,\qquad c_R=(R+2)^2/2. \tag{5.1}
$$

The lower bound follows by restricting the convolution integral to B_2 and using |z-y|<=R+2; the upper bound is the maximum Gaussian density. This density comparison is independent of F_t and of the diffusion's upper ellipticity bound.

For any bounded real f with |f|<=G and local H^1 regularity, let f_R be its Lebesgue average on B_R. Ordinary unweighted Poincare on the ball supplies a finite constant C_P(R,d)>0 with

$$\int_{B_R}|f-f_R|^2dz\le C_P(R,d)\int_{B_R}|\nabla f|^2dz.$$

The variance under the full scaled law is at most the second moment about f_R, since the probability mean minimizes that moment. Outside the ball the integrand is at most 4G^2, and the tail probability is at most L/R^2. Inside use the upper density bound, Poincare, then the lower density bound. This proves

$$
\operatorname{Var}_{\rho_t^{scaled}}(f)
\le \frac{4G^2 L}{R^2}
+2C_P(R,d)e^{c_R/\delta(t)}
 \int |\nabla f|^2\rho_t^{scaled}dz. \tag{5.2}
$$

The last integral may be infinite; the inequality is also valid then. Taking f(z)=h(t,sqrt(t)z) at almost every t, spatial scaling gives

$$
D(t)\le \frac{4G^2 L}{R^2}
+2C_P(R,d)t e^{c_Rt/q(t)}\int|\nabla_x h|^2\rho_t dx. \tag{5.3}
$$

The use of a *weak* Poincare estimate, with a controllable tail error, avoids any need for the original peacock or the convolved measures to have a global Poincare constant. Only second moments have been assumed. The exponential factor in (5.3) is precise enough for matching the obstruction below at the level of all C>0.

## 6. Divergent series imply usual-filtration Markov realization

Reverse martingale convergence as t decreases to zero yields

$$
D_0:=\lim_{t\downarrow0}D(t)
= \|E[g(M_r)|\mathcal F_{0+}]-Eg(M_r)\|_2^2.
$$

Suppose D_0>0. Choose R large so that 4G^2 L/R^2 <=D_0/2. Since D(t)>=D_0, (5.3) implies

$$
\int|\nabla h(t,x)|^2\rho_t(x)dx
\ge\frac{D_0}{4C_P(R,d)t}e^{-c_Rt/q(t)}. \tag{6.1}
$$

The matrix inequality a_t>=q'(t)I and (4.1) then give, for all 0<a<b<r,

$$
D(b)-D(a)\ge\frac{D_0}{4C_P(R,d)}
\int_a^b\frac{q'(t)}{t}e^{-c_Rt/q(t)}dt. \tag{6.2}
$$

By (J), the right side tends to infinity as a decreases to zero, whereas D is bounded. Contradiction. Therefore D_0=0.

The argument holds for every positive r and every smooth compactly supported g. A countable determining class and monotone class argument extend it to all bounded Borel g. Because M_0 is deterministic, this proves usual-filtration Markovness at zero. In fact the germ is trivial: apply the equality to products of finitely many bounded tests at strictly positive times by conditioning at the earliest such time and using positive-time Markovness. Monotone class then gives independence of the germ from the sigma-field of the continuous path, which contains the germ modulo completion. Thus it is trivial modulo null events.

Combining with positive-time strong Markovness gives strong Markovness in the usual filtration: on the positive part of a stopping time localize away from zero, and on its zero part use the just-established entrance property. Pull back the additional deterministic clock w=s+q(s). This proves the positive assertion of Theorem 6.1. Unlike round 04's heat-kernel approach, the proof does not need a quantitative Aronson minorization estimate. The only entrance bound is the explicit Gaussian density ratio and standard local parabolic regularity away from zero.

## 7. A rare rectangular branch amplifies the barrier exponent

We now establish a negative result for *any* C in a convergent series, not just a predetermined numerical constant. Work in the original normalized clock s in [0,1], before the positive-direction auxiliary change. Let t_n=2^(-n). Define continuous nondecreasing clocks a_1,a_2 starting at zero, with slopes (1,0) and (0,1) on alternating dyadic intervals (t_{n+1},t_n]. As before a_1+a_2=s and at dyadic endpoints both a_j(t_n) lie between t_n/3 and 2t_n/3.

Choose a rare-branch probability p in (0,1). With two orthonormal directions e_1,e_2, put

$$b_j(s)=\sqrt{a_j(s)/(2p)},$$
$$
\lambda_s=(1-p)\delta_0+
\frac p4\sum_{\epsilon_1,\epsilon_2\in\{-1,1\}}
\delta_{\epsilon_1 b_1(s)e_1+\epsilon_2 b_2(s)e_2}.
\tag{7.1}
$$

The signs in the rare branch are independent. Each centered symmetric two-point law is increasing in convex order as its radius increases, by convex interpolation between the larger-radius endpoints. The product family is increasing in convex order by applying this argument coordinate by coordinate to any convex test, with the other coordinate fixed. Mixing with the time-constant atom preserves convex order. Thus lambda is a weakly continuous centered peacock and

$$v(s)=p(b_1(s)^2+b_2(s)^2)=s/2.$$

In particular it belongs to C_d, uniformly in p. This is the important distinction from the earlier fair two-axis construction: both coordinates now record the *same* rare branch, and its spatial separation can be arbitrarily large in units of sqrt(s), at a fixed second-moment budget.

Let q be continuous nondecreasing with q(0)=0, positive at positive times. Suppose that for some C_0>0,

$$\sum_n e^{-C_0t_n/q(t_n)}<\infty. \tag{7.2}$$

Then q(t_n)/t_n<=1 eventually: otherwise infinitely many terms are at least e^{-C_0}. Choose p so small that 1/(2048p)>=C_0. Set h_n=sqrt(t_n/p)/16. At both endpoints of the nth dyadic interval,

$$b_j(s)^2\ge t_n/(12p),\qquad b_j(s)\ge 3h_n,$$

using 1/12>9/256. The earlier threshold h_{n+1}=h_n/sqrt(2) belongs to [h_n/2,h_n].

Take any square-integrable candidate martingale Y with marginals lambda_s*N(0,q(s)I_d). Define F_n^j={|Y^j_{t_n}|>h_n}. At a single date, the marginal is represented as M+G, where M has law lambda and is independent of the Gaussian G. Both coordinates of M are zero on the majority branch and have absolute value at least 3h_n on the rare branch. When |G^j|<h_n/2, the classifier at either endpoint, using its own threshold, agrees with that common branch. These are statements about the prescribed one-time laws, not an assumption of a joint latent branch on the candidate's space.

For later/lower endpoint noise variances at most q(t_n), the Gaussian tail estimate and exact truncated first moment give

$$P(|G^j|\ge h_n/2)\le2\exp(-t_n/(2048p q(t_n))),$$
$$h_n^{-1}E(|G^j|1_{\{|G^j|\ge h_n\}})
\le 16\sqrt{2p/\pi}\sqrt{q(t_n)/t_n}
\exp(-t_n/(512p q(t_n))). \tag{7.3}$$

The prefactor is bounded eventually, and (7.2) implies summability of both bounds.

We recall the deterministic barrier inequalities (round 05) explicitly. For phi_h(x)=(|x|-h)^+ take a subgradient b_h(v) in {-1,0,1} (zero at the boundary), and D_h(u,v)=phi_h(u)-phi_h(v)-b_h(v)(u-v). Convexity gives D_h>=0, the Lipschitz property gives D_h(m+g,m)<=2|g|, and for m=0 or |m|>=3h with |g|<=h both arguments lie on the same affine segment, so the gap is zero. Hence for independent centered G and such an M,

$$0\le E\phi_h(M+G)-E\phi_h(M)\le2E(|G|1_{\{|G|\ge h\}}). \tag{7.4}$$

For scalar martingale values U later and V earlier, disagreement of their inside/outside indicators at threshold h entails either D_h(U,V)>=h/2 or h/2<|U|<=2h: check the two far-crossing cases |V|<=h, |U|>=2h and |V|>h, |U|<=h/2; the remaining cases lie in that annulus. Taking expectations using the martingale cancellation of the subgradient term gives

$$P(\{|U|>h\}\triangle\{|V|>h\})
\le (2/h)(E\phi_h(U)-E\phi_h(V))
+P(h/2<|U|\le2h). \tag{7.5}$$

Select the coordinate j that is frozen on [t_{n+1},t_n]. Its base marginal is the identical three-point law at the two endpoints (mass 1-p at zero and p/2 at each signed radius). Thus (7.4) at the later time and Jensen at the earlier bound the convex-price increment in (7.5) at threshold h_n by twice the later truncated moment. The annulus term is bounded by the later tail in (7.3), since separated centers with |G^j|<h_n/2 cannot land in the annulus. Changing the earlier threshold from h_n to h_{n+1} costs at most the earlier tail. Consequently the probability of F_n^j disagreeing with F_{n+1}^j is bounded by the sum of four times the normalized truncated moment and the two tails.

At each endpoint, F_n^1 and F_n^2 both agree with the same rare-branch label in the single-time representation, outside the union of their tail events. Their symmetric difference is therefore bounded by the corresponding two tails. When coordinate 2 is not frozen, replace its classifiers by coordinate 1 at the two endpoints using this error bound. The symmetric-difference triangle inequality now implies

$$\sum_n P(F_n^2\triangle F_{n+1}^2)<\infty,\qquad P(F_n^2)\to p.$$

Borel--Cantelli gives A=limsup F_n^2 whose indicator is the almost sure and L^1 limit of these classifiers, with P(A)=p. Since t_n decreases to zero, A lies in the usual initial sigma-field. Y_0=0 a.s. Markovness at zero would force P(A intersection F_n^2)=p P(F_n^2). Passing to the limit gives p=p^2, contradicting 0<p<1. This excludes every usual-filtration Markov martingale with these marginals, including jumping paths. It works in every d>=2 by embedding the rectangle in a plane; unlike an inference about Markovness of a projection, the contradiction is with the full deterministic initial state.

For the optional smooth-input strengthening, replace lambda_s by lambda_s*N(0,a s^2 I_d) with a=1/(8d). This remains a peacock and has everywhere positive smooth densities at every positive time. Its energy is s/2+da s^2 with derivative <=3/4, so it still lies in C_d, and it can be realized in a genuine physical-to-energy clock t=s-v(s). The final variance is q(s)+a s^2. If (7.2) holds, then for any C'>=2C_0,

$$
e^{-C't_n/(q(t_n)+a t_n^2)}
\le e^{-(C'/2)t_n/q(t_n)}+e^{-(C'/2)/(a t_n)}.
$$

This follows from q+a t_n^2<=2 max(q,a t_n^2) and monotonicity of the exponential. Both series converge. Choose the rare probability p small enough for the new constant C'. The same obstruction applies. Thus it is not necessary to use atomic input laws at positive times.

This completes the negative assertion and Theorem 6.1. It does not depend on the validity of the earlier round-04 positive theorem.

## 8. Exact asymptotic consequences

For q(s)=eta s/[log log(e^e/s)]^p, the series in (D) is

$$\sum_n\exp[-(C/\eta)(\log(e+n\log 2))^p].$$

If 0<=p<1, for each fixed C the exponent's magnitude is eventually less than (1/2)log(n+1), so the sum diverges. For p=1 choose C/eta>1 and apply the p-series test; for p>1 any C>0 gives a summable upper bound eventually. This proves Corollary 6.2. Such schedules have strictly positive derivative on positive times and satisfy (Q).

If q(s) log log(e^e/s)/s -> infinity, then for each fixed C the exponent magnitude at dyadic times is o(log(n+1)), yielding (D). If that ratio is bounded above, choose C large enough for convergence. In particular a slower iterated log such as q(s)=eta s/log log log(e^{e^e}/s) is universally sufficient under (Q), whereas all ordinary log-power corrections of round 05 are nonuniversal. The linear scale is sufficient but is not a necessary lower scale.

The distinction is the full series test (D), not merely a limit of q(s)/s. The double-logarithmic scale is the boundary for regular comparable rates; irregular rates are classified by the series. In the nonregular class (e.g. positive-time flat or singular noise clocks) we have the necessary condition (D) but have not established sufficiency; the proof of the local backward identity uses positive-time uniform ellipticity and boundedness, so cannot simply delete (Q).

## 9. Literature, proof dependencies and validation boundary

- F. Hirsch and B. Roynette, On R^d-valued peacocks, ESAIM P&S 17 (2013), 444--454, DOI 10.1051/ps/2012009: multivariate martingale realization.
- D. Trevisan, Well-posedness of multidimensional diffusion processes with weakly differentiable coefficients, Electron. J. Probab. 21 (2016), arXiv:1507.01357: superposition principle.
- D. Kim and N. V. Krylov, Parabolic equations with measurable coefficients, Potential Analysis 26 (2007), 345--361, arXiv:math/0604124: parabolic Sobolev estimates; our localized coefficient is uniformly elliptic, measurable in time and uniformly smooth/Lipschitz in space on positive-time subcylinders. The use of these estimates and localized Ito approximation in Section 4 is an explicit external dependency, not a Lean-checked step.
- G. Pammer, B. A. Robinson and W. Schachermayer, A regularized Kellerer theorem in arbitrary dimension, Ann. Appl. Probab. 35 (2025), 749--778, DOI 10.1214/24-AAP2125: regularized multidimensional mimicking and usual-filtration germ obstructions. The present limited literature search did not find the exact criterion (D); this is not a proof of novelty. The weak Poincare and variance-dissipation tools themselves are classical.
- G. Lowther, Fitting martingales to given marginals, arXiv:0808.2319: scalar fitting background; not needed for the d>=2 proof here.

The proposed contribution is the exact universal energy-clock criterion for locally bi-Lipschitz isotropic noise schedules, proved by a matched weak-Poincare dissipation and rare-rectangle germ obstruction. Sections 2, 5 and 7 reduce the scale issue to explicit inequalities without unknown heat-kernel constants. It is a restricted universal classification, not a general multidimensional Kellerer theorem, and must undergo independent mathematical and novelty review.

The Lean file CriterionCore.lean contains scalar certificates for the ratio comparison, clock identity, exponential absorption, rare-branch energy/separation, and the contradiction p=p^2. It is supplied as an uncompiled candidate, not a kernel certificate. The actual local environment lacks Lean/Lake/Elan and GitHub download resolution failed. The exact Python script and log record the checks actually executed. A successful CI transcript was not available when this note was prepared. No measure-theoretic or SDE theorem in this note is claimed to have been proved in Lean. Earlier archived logs cover only the declarations listed in those logs.

Open targets: remove the positive-time bi-Lipschitz condition on q; extend the criterion to nondeterministic initial laws and anisotropic noise (especially exactly one initial null direction); find distribution-specific regularization minima; address the distinct unregularized raw-filtration question. The rare rectangle uses two blind directions and does not by itself address corank one.
