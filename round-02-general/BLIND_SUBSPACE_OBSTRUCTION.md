# Blind-subspace obstructions for universal Markov regularization

## Status and attribution

This note proves a structural obstruction under the **usual (completed, right-continuous) filtration**. It does not answer the raw-filtration version of multidimensional Kellerer's problem. The underlying germ-information mechanism and alternating-clock construction are due to Pammer, Robinson and Schachermayer (PRS), notably Proposition 4.6 and Remark 4.3 of *A regularized Kellerer theorem in arbitrary dimension*, Annals of Applied Probability **35** (2025), 749–778, DOI [10.1214/24-AAP2125](https://doi.org/10.1214/24-AAP2125). An accessible author version is [arXiv:2210.13847](https://arxiv.org/pdf/2210.13847); the published PDF is [available from the author](https://barobinson.github.io/kellerer-regularized.pdf).

The product lifting below is a proved consequence of that mechanism. Its proof does **not** assert that a projection of a Markov process is Markov, which would be false in general. A two-dimensional Gaussian-on-axes variant is also derived explicitly; this is an adaptation of the same mechanism, and no claim of historical priority is made here.

## 1. The precise information obstruction

Let \((Y_t,Z_t)_{0\le t\le T}\) be an adapted process with values in \(E\times\mathbb R^m\) on a probability space whose filtration \((\mathcal F_t)\) is complete and right-continuous. Assume:

1. \(Y_0=y_0\) almost surely;
2. there is an event \(A\), with \(0<p:=\mathbb P(A)<1\), and Borel functions \(b_t:E\to\{0,1\}\) such that \(1_A=b_t(Y_t)\) almost surely for every deterministic \(t>0\);
3. \(Y_t\) and \(Z_t\) are independent for every deterministic \(t>0\);
4. \(Z_t\to Z_0\) in probability as \(t\downarrow0\).

**Theorem 1 (independent extra coordinates do not remove a forced germ).** Under these assumptions, \((Y,Z)\) is not Markov at time zero relative to \((\mathcal F_t)\).

### Proof

For every \(t>0\), assumption 2 and completeness imply \(A\in\mathcal F_t\). Right-continuity gives

\[
A\in\bigcap_{t>0}\mathcal F_t=\mathcal F_0.
\tag{1}
\]

Assumptions 2–3 imply that \(A\) and \(Z_t\) are independent for every \(t>0\). Fix a sequence \(t_n\downarrow0\) and a bounded continuous function \(h\) on \(\mathbb R^m\). Convergence in probability, boundedness and continuity yield convergence in \(L^1\), so

\[
\begin{aligned}
\mathbb E[1_Ah(Z_0)]
&=\lim_n\mathbb E[1_Ah(Z_{t_n})]\\
&=p\lim_n\mathbb E[h(Z_{t_n})]
=p\mathbb E[h(Z_0)].
\end{aligned}
\tag{2}
\]

Bounded continuous functions determine finite Borel measures on Euclidean space. Thus \(A\) and \(Z_0\) are independent. Since \(Y_0\) is deterministic, \(A\) is independent of \(\sigma(Y_0,Z_0)\).

If the joint process were Markov at zero, then for a fixed \(s>0\) and the bounded Borel function \(f(y,z)=b_s(y)\),

\[
1_A
=\mathbb E[f(Y_s,Z_s)\mid\mathcal F_0]
=\mathbb E[f(Y_s,Z_s)\mid\sigma(Y_0,Z_0)]
=p
\quad\text{a.s.},
\tag{3}
\]

contradicting \(0<p<1\). \(\square\)

The independence used here is **one-time marginal independence**. We neither assume nor need that the whole path \(Y\) is independent of \(Z_0\). In particular, the proof addresses the concern that the additional initial coordinate could serve as a latent memory label: it cannot reveal the particular forced event \(A\), because (2) proves independence of that event and the initial label.

The result also does not require a generic theorem about conditioning a Markov process on an initial label. Such a theorem would require care with exceptional sets and uncountably many times. The contradiction above uses a single fixed time \(s>0\).

## 2. The PRS four-dimensional example

PRS use two orthogonal two-dimensional planes. Let \(I_1,I_2\) partition \((0,1]\) into alternating dyadic intervals, and put

\[
a_i(t)=\int_0^t1_{I_i}(r)\,dr,\qquad i=1,2.
\tag{4}
\]

Each \(a_i\) is continuous, nondecreasing, strictly positive for \(t>0\), and constant on every dyadic interval belonging to the other family. The peacock at time \(t\) assigns mass one-half to a uniform circle of radius \(\sqrt{a_1(t)}\) in the first plane and one-half to the analogous circle in the second plane. At time zero it is \(\delta_0\).

The proof of PRS Proposition 4.6 shows that **every martingale** with these one-time marginals remains on its chosen branch at every positive deterministic time. Here is a short second-moment formulation of the freezing step. If \(U\) is any square-integrable vector martingale and \(s\le t\), then

\[
\mathbb E|U_t-U_s|^2
=\mathbb E|U_t|^2-\mathbb E|U_s|^2.
\tag{5}
\]

On an interval on which \(a_2\) is constant, the second-plane projection of any mimicking martingale has constant second moment. Equation (5) forces that projection to be unchanged. Since the second-plane circles have positive radius, branch membership cannot change. The first-plane projection gives the same conclusion on the alternating intervals. A finite subdivision of any interval \([s,t]\subset(0,1]\) proves persistence between arbitrary positive deterministic times.

Fixing a positive time defines an event \(A\) of probability one-half which is a Borel function of \(Y_t\) for every positive \(t\). This is exactly assumption 2 of Theorem 1. Consequently adding arbitrary independent extra-coordinate marginals, provided the additional coordinate is stochastically continuous at zero, cannot restore Markovianity under the usual filtration.

PRS Remark 4.3 already observes the static extra-coordinate special case. Theorem 1 makes explicit why arbitrary continuous-time extra-coordinate marginals cannot resolve this same obstruction.

## 3. A two-dimensional continuous-marginal variant

The same freezing argument admits a lower-dimensional version that is useful for rank statements. This is a directly verified adaptation of PRS, not an assertion of independently established priority.

Let \(a_1,a_2\) be as in (4), let \(B^1,B^2\) be independent standard one-dimensional Brownian motions, and let \(J\) be an independent Bernoulli random variable with parameter \(p\in(0,1)\). Define

\[
X_t=\begin{cases}
(B^1_{a_1(t)},0),&J=1,\\
(0,B^2_{a_2(t)}),&J=0.
\end{cases}
\tag{6}
\]

This is a continuous square-integrable martingale in a filtration containing \(J\). Its marginal family is

\[
\eta_t=p\bigl(\mathcal N(0,a_1(t))\otimes\delta_0\bigr)
+(1-p)\bigl(\delta_0\otimes\mathcal N(0,a_2(t))\bigr).
\tag{7}
\]

In particular, \(\eta\) is a weakly continuous peacock and \(\eta_0=\delta_{(0,0)}\). For every \(t>0\), \(\eta_t\) is atomless, although it is singular with respect to two-dimensional Lebesgue measure. It has non-Gaussian joint law. Its covariance is

\[
\operatorname{Cov}(\eta_t)
=\operatorname{diag}(p\,a_1(t),(1-p)\,a_2(t)),
\tag{8}
\]

which is positive definite for all \(t>0\).

**Theorem 2 (two-dimensional frozen-branch obstruction).** Every square-integrable martingale \(Y=(Y^1,Y^2)\) with marginals \(\eta_t\) fails the Markov property at zero in its completed, right-continuous natural filtration. The conclusion permits discontinuous candidate martingales.

### Proof

For every fixed \(t>0\), the marginal (7) has no mass at the origin and is concentrated on the union of the two axes. Thus

\[
A_t:=\{Y_t^2=0\}
\quad\text{agrees a.s. with}\quad\{Y_t^1\ne0\},
\qquad\mathbb P(A_t)=p.
\tag{9}
\]

If \([s,t]\) lies in an interval on which \(a_2\) is constant, then

\[
\mathbb E[(Y_t^2-Y_s^2)^2]
=(1-p)(a_2(t)-a_2(s))=0.
\tag{10}
\]

Here \(Y_t^2\) denotes the second coordinate, not its square; the outer exponent in (10) is the square of the coordinate increment. Thus the second coordinates agree almost surely, and \(A_s=A_t\) modulo null sets. On intervals where \(a_1\) is constant, the same argument with the first coordinate and the second description in (9) gives the same conclusion.

Every closed interval \([s,t]\subset(0,1]\) meets only finitely many dyadic pieces. Subdivide and use transitivity of equality modulo null sets to obtain \(A_s=A_t\) modulo null sets for every \(s,t>0\). Fixing \(A=A_1\), we have \(1_A=1_{\{Y_t^2=0\}}\) almost surely for every \(t>0\). Consequently \(A\in\mathcal F_0\), while \(Y_0=0\) and \(\mathbb P(A)=p\). The contradiction in Theorem 1, with no additional coordinate, proves the claim. \(\square\)

Nothing in this proof treats a finite state grid as the price state space. The marginals in (7) are continuous one-dimensional Gaussian distributions on a union of subspaces, indexed by a continuum of times. Nor does the theorem require that a candidate martingale have continuous paths: (10) is a two-time martingale identity.

There is no contradiction with one-dimensional Kellerer theory. The construction needs two geometrically distinguishable branches and alternating frozen coordinate directions. There is also no contradiction with raw-filtration Markovianity: the germ event \(A\) need not be observable in the raw natural sigma-algebra at time zero.

## 4. Consequence for Gaussian regularizers with a blind subspace

Let \(T>0\), and let \(Q:[0,T]\to\mathbb S^d_+\) be a continuous, Loewner-nondecreasing covariance path. Write \(\gamma_{Q(t)}\) for the possibly degenerate centered Gaussian law with covariance \(Q(t)\). Such a covariance path defines a Gaussian peacock and can be realized by an independent Gaussian martingale.

**Theorem 3 (necessary rank condition for universal regularization).** If

\[
\dim\bigcap_{t\in[0,T]}\ker Q(t)\ge2,
\tag{11}
\]

then the map \(\mu_t\mapsto\mu_t*\gamma_{Q(t)}\) does not send every weakly continuous square-integrable peacock on \(\mathbb R^d\) to a family admitting a Markov martingale under the usual filtration. The statement with threshold four follows already from the PRS example alone; threshold two uses the verified variant in Theorem 2.

### Proof

Choose a two-dimensional subspace \(W\) contained in the common kernel in (11), and write \(V=W^\perp\). Place the peacock \(\eta_t\) of Theorem 2 in \(W\), with the other coordinates identically zero:

\[
\mu_t=\eta_t\otimes\delta_0^V.
\tag{12}
\]

Since \(Q(t)w=0\) for all \(w\in W\), the Gaussian law \(\gamma_{Q(t)}\) is supported on \(V\). Therefore the convolution factorizes as

\[
\mu_t*\gamma_{Q(t)}=\eta_t\otimes\gamma_{Q(t)|_V}.
\tag{13}
\]

Suppose a joint Markov martingale \((Y,Z)\) had marginals (13). The projection \(Y\) is a martingale, so Theorem 2 supplies the forced branch event \(A\). No Markov property of this projection is assumed. Equation (13) gives one-time independence of \(Y_t\) and \(Z_t\).

Moreover, since \(Z\) is a square-integrable martingale and \(Q\) is continuous,

\[
\mathbb E|Z_t-Z_0|^2
=\operatorname{tr}(Q(t)|_V)-\operatorname{tr}(Q(0)|_V)
\longrightarrow0.
\tag{14}
\]

All the hypotheses of Theorem 1 hold. Hence \((Y,Z)\) cannot be Markov, a contradiction. \(\square\)

### What this theorem does and does not establish

- For a constant covariance \(Q\), universal regularization requires \(\dim\ker Q\le1\). Positive definiteness is a sufficient condition in the separate fixed-kernel smoothing theorem. These two statements leave the corank-one case unclassified.
- The argument permits a nontrivial random initial law on \(V\) and permits the additional coordinates to evolve after zero. They cannot store this branch event because each-time marginal independence forces independence from their initial value.
- The theorem makes no claim about a general projection of a Markov process, nor about arbitrary products of arbitrary non-Markov peacocks.
- The origin of the obstruction is a nontrivial germ event unrecorded by the initial state. All nonexistence assertions here concern the usual filtration. They do not settle the separate raw-filtration question explicitly left open in PRS Remark 4.5.
- The note establishes a mathematical consequence and a simplification of a published mechanism. Search results alone do not justify a claim that the exact statement has never previously appeared.

