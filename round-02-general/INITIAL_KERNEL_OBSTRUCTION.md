# Initial-kernel obstruction for time-dependent Gaussian regularization

## 1. The theorem and its scope

Let \(d\ge2\), \(T>0\), and let \(Q:[0,T]\to\mathbb S^d_+\) be continuous and nondecreasing in Loewner order. Suppose

\[
\dim\ker Q(0)\ge2.
\tag{1}
\]

Then there exists a weakly continuous square-integrable peacock \((\mu_t)\) on \(\mathbb R^d\) such that

\[
\nu_t=\mu_t*\mathcal N(0,Q(t))
\tag{2}
\]

does not admit a mimicking Markov martingale relative to the usual filtration. This holds even when \(Q(t)\) is positive definite for every \(t>0\); in that case every \(\nu_t\), \(t>0\), has an everywhere positive smooth density.

This note extends the two-dimensional frozen-branch proof in `SMOOTH_TWO_DIMENSIONAL_OBSTRUCTION.md`. Its mechanism is adapted from Pammer–Robinson–Schachermayer, *A regularized Kellerer theorem in arbitrary dimension*, Annals of Applied Probability **35** (2025), 749–778, DOI [10.1214/24-AAP2125](https://doi.org/10.1214/24-AAP2125). The mathematical proof is given below. No claim that the exact theorem has never appeared before is made. It does not settle the raw-filtration question.

## 2. Choose the hidden plane and its clock

Choose orthonormal vectors \(e_1,e_2\in\ker Q(0)\), put \(W=\operatorname{span}(e_1,e_2)\), and let \(V=W^\perp\). Write \(P_W,P_V\) for the orthogonal projections. Set

\[
\eta(t)=\operatorname{tr}(P_WQ(t)P_W).
\tag{3}
\]

Then \(\eta\) is continuous, nondecreasing, and \(\eta(0)=0\). For an arbitrary \(p>1\), let

\[
f(t)=(t+\eta(t))^{1/p}.
\tag{4}
\]

The function \(f\) is continuous, strictly increasing, and vanishes at zero. On a sufficiently small initial interval, its range lies in \([0,1]\). It is enough to construct the obstruction there; extend the underlying peacock constantly after that interval if necessary.

Let \(a_1,a_2\) be the alternating dyadic clocks defined in the preceding note, so

\[
a_1(u)+a_2(u)=u,
\qquad
u/3\le a_i(u)\le2u/3.
\tag{5}
\]

Define \(\mu_t\) to be the law in \(W\oplus V\) of

\[
X_t=
\begin{cases}
B^1_{a_1(f(t))}e_1,&J=1,\\
B^2_{a_2(f(t))}e_2,&J=0,
\end{cases}
\tag{6}
\]

with \(J\) fair Bernoulli and the Brownian motions independent. All \(V\)-coordinates are zero. Formula (6) is a continuous square-integrable martingale construction, so \(\mu\) is a weakly continuous peacock.

## 3. Classifier estimates survive arbitrary cross-covariances

Suppose \(Y\) were any martingale with marginals (2). Write

\[
U_t^i=\langle Y_t,e_i\rangle,
\qquad
Z_t=P_VY_t.
\tag{7}
\]

For all sufficiently large integers \(n\), define

\[
u_n=2^{-n},\qquad \tau_n=f^{-1}(u_n).
\tag{8}
\]

Thus \(\tau_n\downarrow0\), and

\[
\eta(\tau_n)\le f(\tau_n)^p=u_n^p.
\tag{9}
\]

Choose \(1/2<\beta<p/2\), and put

\[
A_n=\{|U_{\tau_n}^2|\le u_n^\beta\},
\qquad
D_n=\{|U_{\tau_n}^1|\le u_n^\beta\}.
\tag{10}
\]

At time \(\tau_n\), the marginal law can be calculated using a fresh mixture label \(J\), a base normal variable in the selected axis, and an independent Gaussian vector \(G\sim\mathcal N(0,Q(\tau_n))\). This is a calculation of the one-time law, not an assumption about the coupling of the candidate process over time.

Every inactive coordinate has Gaussian variance at most \(\eta(\tau_n)\le u_n^p\). Every active coordinate has Gaussian variance at least \(a_i(u_n)\ge u_n/3\). Therefore the Gaussian tail and small-ball bounds of the preceding note give, with \(\alpha=\beta-1/2>0\), \(\gamma=p-2\beta>0\),

\[
\left|\mathbb P(A_n)-\frac12\right|\le C(u_n^\alpha+u_n^\gamma),
\qquad
\mathbb P(A_n\triangle D_n^c)\le C(u_n^\alpha+u_n^\gamma).
\tag{11}
\]

Off-diagonal entries of \(Q(t)\), including cross-covariances between \(W\) and \(V\), do not affect these bounds. Only the stated one-coordinate variances and union bounds are used.

On each interval \([\tau_{n+1},\tau_n]\), one base clock \(a_j\circ f\) is constant. For that coordinate the martingale identity gives

\[
\begin{aligned}
\mathbb E[(U_{\tau_n}^j-U_{\tau_{n+1}}^j)^2]
&=\langle e_j,(Q(\tau_n)-Q(\tau_{n+1}))e_j\rangle\\
&\le\eta(\tau_n)\le u_n^p.
\end{aligned}
\tag{12}
\]

The deterministic classifier inclusion in the preceding note, applied with thresholds \(u_n^\beta\) and \(u_{n+1}^\beta\), bounds changes in that frozen coordinate by \(C(u_n^\alpha+u_n^\gamma)\). On alternating intervals use (11) to exchange the two coordinate classifiers. Hence

\[
\mathbb P(A_n\triangle A_{n+1})
\le C'(u_n^\alpha+u_n^\gamma).
\tag{13}
\]

The right-hand side is summable. Borel–Cantelli yields an event

\[
A=\limsup_nA_n,
\qquad
1_{A_n}\longrightarrow1_A\text{ a.s. and in }L^1,
\qquad
\mathbb P(A)=\frac12.
\tag{14}
\]

Since \(\tau_n\downarrow0\), right-continuity of the filtration gives \(A\in\mathcal F_0\).

## 4. Initial extra coordinates cannot encode the germ

The initial state is not necessarily deterministic: it has law \(\mathcal N(0,Q(0))\), supported on \(V\). It is therefore necessary to prove that the event \(A\) is independent of the extra initial coordinate \(Z_0\). Ignoring this issue or assuming that a Markov projection stays Markov would leave a gap.

For each single-time mixture representation above, the Bernoulli label \(J\) is independent of the entire Gaussian vector \(G\), hence independent of its \(V\)-projection. Moreover the classifier \(A_n\) agrees with \(\{J=1\}\) except with probability at most \(C(u_n^\alpha+u_n^\gamma)\). Consequently, for every bounded continuous \(h:V\to\mathbb R\),

\[
\left|
\mathbb E[1_{A_n}h(Z_{\tau_n})]
-\frac12\mathbb E[h(Z_{\tau_n})]
\right|
\le C\|h\|_\infty(u_n^\alpha+u_n^\gamma).
\tag{15}
\]

This identity depends only on the one-time marginal law of \((U_{\tau_n},Z_{\tau_n})\), so it holds for the arbitrary candidate \(Y\). No common latent label is postulated on its probability space.

The \(V\)-projection of a martingale is a martingale. Its marginals are centered Gaussians with covariance \(P_VQ(t)P_V\). Continuity of \(Q\) therefore gives

\[
\mathbb E|Z_{\tau_n}-Z_0|^2
=\operatorname{tr}(P_V(Q(\tau_n)-Q(0))P_V)
\longrightarrow0.
\tag{16}
\]

By (14), (16), boundedness and continuity of \(h\), we may pass to the limit in (15), obtaining

\[
\mathbb E[1_Ah(Z_0)]=\frac12\mathbb E[h(Z_0)].
\tag{17}
\]

Bounded continuous functions determine finite Borel measures, so

\[
\mathbb E[1_A\mid Z_0]=\frac12\quad\text{a.s.}
\tag{18}
\]

Because \(P_WY_0=0\) almost surely, \(Y_0=Z_0\), and the same conditional independence holds given the entire initial state.

## 5. Contradiction with Markovianity

If \(Y\) were Markov at zero, then for each \(n\),

\[
\mathbb E[1_{A_n}\mid\mathcal F_0]
=\mathbb E[1_{A_n}\mid Y_0].
\tag{19}
\]

Using \(A\in\mathcal F_0\) and (18),

\[
\begin{aligned}
\mathbb P(A\cap A_n)
&=\mathbb E\left[1_A\,\mathbb E[1_{A_n}\mid Y_0]\right]\\
&=\frac12\mathbb P(A_n).
\end{aligned}
\tag{20}
\]

Taking limits using (14), the left-hand side tends to \(1/2\) and the right-hand side tends to \(1/4\), a contradiction. \(\square\)

## 6. Connection with the positive initial covariance regime

Suppose the fixed strictly positive smoothing-kernel realization theorem has been established. If \(Q(0)\succ0\), choose a constant positive-definite matrix \(H\prec Q(0)\). Then

\[
R(t)=Q(t)-H
\]

is a continuous Loewner-nondecreasing positive-semidefinite covariance path. For every peacock \(\mu\),

\[
\widetilde\mu_t=\mu_t*\mathcal N(0,R(t))
\]

is again a peacock. Apply the fixed-kernel theorem with \(\mathcal N(0,H)\) to obtain a continuous strong Markov martingale with marginals

\[
\widetilde\mu_t*\mathcal N(0,H)
=\mu_t*\mathcal N(0,Q(t)).
\tag{21}
\]

Accordingly, for this class of Gaussian covariance paths:

- positive-definite initial covariance is sufficient for universal continuous strong Markov realization;
- an initial kernel of dimension at least two prevents universal Markov realization, even if jumps are allowed;
- the initial corank-one case is **not classified by these arguments**.

These are distinct conclusions. In particular, the final bullet must not be replaced by an asserted equivalence with positive definiteness. For a **constant** covariance matrix, a separate one-dimensional disconnected-support obstruction proves that full rank is necessary if universal *continuous* realizations are required. That additional statement does not automatically extend to time-dependent covariances which inject noise into the initially blind direction at positive times.

