# A two-dimensional, everywhere-positive smoothing obstruction

## Mathematical status

This note gives a complete direct proof of a two-dimensional counterexample under the **usual, right-continuous filtration**. The argument adapts the alternating-clock and germ-event mechanism of Pammer–Robinson–Schachermayer, *A regularized Kellerer theorem in arbitrary dimension*, Annals of Applied Probability **35** (2025), 749–778, DOI [10.1214/24-AAP2125](https://doi.org/10.1214/24-AAP2125), especially their Proposition 4.7. Their published counterexample is four-dimensional. The derivation below is independently checkable; establishing historical priority for its exact two-dimensional formulation requires a fuller literature review. It does not settle the raw-filtration question.

## 1. Statement

Fix an arbitrary real exponent \(p>1\). There exists a weakly continuous peacock \((\mu_t)_{0\le t\le1}\) on \(\mathbb R^2\) such that

\[
\nu_t=\mu_t*\mathcal N(0,t^pI_2)
\tag{1}
\]

has all of the following properties:

1. \(\nu_0=\delta_0\).
2. For every \(t>0\), \(\nu_t\) has an everywhere strictly positive \(C^\infty\) density on \(\mathbb R^2\), and all moments are finite.
3. The family \(\nu\) is realized by an explicit continuous square-integrable martingale, indeed an Itô martingale with bounded volatility on \([0,1]\).
4. No martingale with these marginals is Markov at zero relative to a right-continuous filtration to which it is adapted. Candidate martingales are allowed to have jumps.

By the deterministic time change \(u=t^p\), there is also a two-dimensional weakly continuous square-integrable peacock \(\widehat\mu\) such that

\[
\widehat\nu_u=\widehat\mu_u*\mathcal N(0,uI_2)
\tag{2}
\]

has no mimicking Markov martingale under the usual filtration. Thus smoothing which is strictly positive at every positive time, but vanishes at the initial time, does not guarantee universal Markov realization, even in dimension two.

## 2. The peacock and its explicit continuous realization

Partition \((0,1]\) into alternating half-open dyadic intervals:

\[
I_1=\bigcup_{n\text{ even}}(2^{-(n+1)},2^{-n}],
\qquad
I_2=\bigcup_{n\text{ odd}}(2^{-(n+1)},2^{-n}].
\]

Set

\[
a_i(t)=\int_0^t1_{I_i}(r)\,dr,\qquad i=1,2.
\tag{3}
\]

Then \(a_1+a_2=t\), both clocks are continuous and nondecreasing, and

\[
\frac t3\le a_i(t)\le\frac{2t}3
\quad(t>0).
\tag{4}
\]

To check (4), at any dyadic endpoint the alternating geometric series gives values \(t/3\) and \(2t/3\). On each dyadic interval one clock is constant and the other has slope one; their ratios to \(t\) remain between the same two bounds.

Let \(J\) be Bernoulli with parameter one-half, let \(B^1,B^2\) be independent one-dimensional Brownian motions, and let \(W\) be an independent two-dimensional Brownian motion. All are independent. Define

\[
X_t=
\begin{cases}
(B^1_{a_1(t)},0),&J=1,\\
(0,B^2_{a_2(t)}),&J=0,
\end{cases}
\qquad
\widetilde X_t=X_t+W_{t^p}.
\tag{5}
\]

These are continuous square-integrable martingales in the filtration containing \(J\) and the relevant time-changed Brownian filtrations. Their laws are

\[
\mu_t=
\frac12\bigl(\mathcal N(0,a_1(t))\otimes\delta_0\bigr)
+\frac12\bigl(\delta_0\otimes\mathcal N(0,a_2(t))\bigr),
\tag{6}
\]

and

\[
\nu_t=
\frac12\mathcal N\!\left(0,
\begin{pmatrix}a_1(t)+t^p&0\\0&t^p\end{pmatrix}\right)
+\frac12\mathcal N\!\left(0,
\begin{pmatrix}t^p&0\\0&a_2(t)+t^p\end{pmatrix}\right).
\tag{7}
\]

For \(t>0\) both component covariance matrices are positive definite. Formula (7) gives the claimed strictly positive smooth density. Jensen's inequality applied to (5) gives the peacock property. The covariance matrix of \(\nu_t\) is

\[
\operatorname{diag}\left(\frac{a_1(t)}2+t^p,
\frac{a_2(t)}2+t^p\right).
\tag{8}
\]

The process (5) can equivalently be constructed by stochastic integrals with coefficients \(\sqrt{a_i'}\) and \(\sqrt p\,t^{(p-1)/2}\). These coefficients are bounded on \([0,1]\), since \(a_i'\) takes values zero and one almost everywhere. The coefficient of the first part also depends on the hidden branch \(J\); the construction does not purport to give a Markov martingale.

## 3. Single-time branch classifiers

Choose any

\[
\frac12<\beta<\frac p2,
\qquad
\alpha=\beta-\frac12>0,
\qquad
\gamma=p-2\beta>0.
\tag{9}
\]

Let \(Y\) be **any** martingale with marginal laws \(\nu_t\). The following proof uses only those marginals and the martingale condition; it never assumes that \(Y\) comes equipped with the latent variable \(J\) from (5).

At a time \(t>0\), put

\[
F_t^j=\{|Y_t^j|\le t^\beta\},\qquad j=1,2,
\tag{10}
\]

where \(Y_t^j\) denotes coordinate \(j\). Define \(C_0=\sqrt{6/\pi}\). For a centered real Gaussian of variance \(t^p\), Chebyshev gives

\[
\mathbb P(|G|>t^\beta)\le t^\gamma.
\tag{11}
\]

For a centered Gaussian of variance at least \(t/3\), its density is bounded by \(\sqrt{3/(2\pi t)}\), so

\[
\mathbb P(|G|\le c t^\beta)
\le C_0 c\,t^\alpha
\qquad(c>0).
\tag{12}
\]

Using the two components of the one-time mixture (7), (11)–(12) imply

\[
\left|\mathbb P(F_t^j)-\frac12\right|
\le\frac12\bigl(t^\gamma+C_0t^\alpha\bigr),
\tag{13}
\]

and

\[
\mathbb P\bigl(F_t^2\triangle(F_t^1)^c\bigr)
\le e(t):=t^\gamma+C_0t^\alpha.
\tag{14}
\]

Indeed, in the first mixture component the desired configuration is “coordinate one large, coordinate two small”; failure is contained in the union of the active-coordinate small-ball event and the inactive-coordinate tail event. In the second component the roles are reversed. This is a calculation under the specified one-time law, not an assumption about how mixture labels are coupled at different times.

## 4. A two-time deterministic classifier inequality

The needed elementary inclusion is the following. For real \(U,V\), \(h>0\), and \(0<r\le1\),

\[
\{ |U|\le h\}\triangle\{|V|\le rh\}
\ \subseteq\
\{|U-V|>rh/2\}
\ \cup\
\{rh/2<|U|\le(1+r/2)h\}.
\tag{15}
\]

To prove it, suppose the first event on the right does not occur. If \(|U|\le rh/2\), then \(|V|\le rh\), so both classifiers are true. If \(|U|>(1+r/2)h\), then \(|V|>h\ge rh\), so both are false. Thus a discrepancy forces the stated annulus.

Taking probabilities and applying Chebyshev gives

\[
\begin{aligned}
\mathbb P\bigl(\{|U|\le h\}\triangle\{|V|\le rh\}\bigr)
\le&\ \frac{4\mathbb E[(U-V)^2]}{r^2h^2}\\
&+\mathbb P\bigl(rh/2<|U|\le(1+r/2)h\bigr).
\end{aligned}
\tag{16}
\]

This estimate applies to an arbitrary coupling of \(U,V\).

## 5. Summable classification changes on the dyadic mesh

Set \(t_n=2^{-n}\), \(r=2^{-\beta}\). On every interval \([t_{n+1},t_n]\), one of the base clocks \(a_j\) is constant. For this frozen coordinate, the square-integrable martingale identity and (8) give exactly

\[
\mathbb E[(Y_{t_n}^j-Y_{t_{n+1}}^j)^2]
=t_n^p-t_{n+1}^p\le t_n^p.
\tag{17}
\]

Apply (16) with \(U=Y_{t_n}^j\), \(V=Y_{t_{n+1}}^j\), and \(h=t_n^\beta\). The first term is at most \(4r^{-2}t_n^\gamma\). For the annulus term, decompose only the marginal law of \(U\):

- the inactive Gaussian component contributes at most \(4r^{-2}t_n^\gamma\), by the lower annulus radius and Chebyshev;
- the active Gaussian component contributes at most \(C_0(1+r/2)t_n^\alpha\le2C_0t_n^\alpha\), by its density bound and the upper annulus radius.

Dropping mixture weights only enlarges these upper bounds. Therefore

\[
\mathbb P(F_{t_n}^j\triangle F_{t_{n+1}}^j)
\le f(t_n):=8r^{-2}t_n^\gamma+2C_0t_n^\alpha.
\tag{18}
\]

Let \(A_n=F_{t_n}^2\). If coordinate two is frozen, (18) directly bounds \(\mathbb P(A_n\triangle A_{n+1})\). If coordinate one is frozen, first use (14) to replace each coordinate-two classifier by the complement of its coordinate-one classifier, apply (18), and use the triangle inequality for symmetric-difference probabilities. In both cases,

\[
\begin{aligned}
\mathbb P(A_n\triangle A_{n+1})
&\le f(t_n)+e(t_n)+e(t_{n+1})\\
&\le (8r^{-2}+2)t_n^\gamma+4C_0t_n^\alpha.
\end{aligned}
\tag{19}
\]

Both exponents in (19) are positive. Hence

\[
\sum_{n=0}^{\infty}\mathbb P(A_n\triangle A_{n+1})<\infty.
\tag{20}
\]

The first Borel–Cantelli lemma implies that the indicators \(1_{A_n}\) are eventually constant almost surely. Put

\[
A=\limsup_{n\to\infty}A_n.
\tag{21}
\]

Then \(1_{A_n}\to1_A\) almost surely and in \(L^1\). Equation (13) gives

\[
\mathbb P(A)=\frac12.
\tag{22}
\]

For any \(\varepsilon>0\), the tail of \((A_n)\) is measurable with respect to \(\mathcal F_\varepsilon\). Deleting finitely many terms does not change the limsup. Thus \(A\in\mathcal F_\varepsilon\) for every \(\varepsilon>0\), and right-continuity gives

\[
A\in\mathcal F_0.
\tag{23}
\]

Notice the distinction from the unsmoothed case: here the germ event need not be exactly visible in any one fixed positive-time state. It is recovered asymptotically with summable errors. This is enough for the contradiction below.

## 6. The Markov contradiction

Suppose \(Y\) were Markov at time zero. Since \(Y_0=0\) almost surely, every bounded Borel function of \(Y_t\), at each deterministic \(t>0\), would be independent of \(\mathcal F_0\). In particular, since \(A\in\mathcal F_0\) and \(A_n\) is a function of \(Y_{t_n}\),

\[
\mathbb P(A\cap A_n)=\mathbb P(A)\mathbb P(A_n)
\quad\text{for every }n.
\tag{24}
\]

Letting \(n\to\infty\), the left-hand side tends to \(\mathbb P(A)=1/2\), while the right-hand side tends to \(\mathbb P(A)^2=1/4\). This is impossible. The counterexample therefore excludes every mimicking Markov martingale under the usual filtration. \(\square\)

## 7. Linear-variance Gaussian smoothing

Define \(\widehat\mu_u=\mu_{u^{1/p}}\) and \(\widehat\nu_u=\nu_{u^{1/p}}\), for \(u\in[0,1]\). Then (2) holds. If a Markov martingale \(Z_u\) realized \(\widehat\nu\), the strictly increasing continuous time change \(Y_t=Z_{t^p}\) would be a Markov martingale realizing \(\nu\). Right-continuity of the time-changed filtration is preserved by this homeomorphism. Section 6 rules this out.

This two-dimensional statement has the same Gaussian-variance form as PRS Theorem 1.4, whose published construction uses four dimensions. The present derivation should be described as a proved candidate strengthening of that construction pending independent expert review and fuller priority checking, not as a solution of the raw-filtration Kellerer problem.

## 8. Scope relative to fixed initial smoothing

The construction does not conflict with a theorem asserting that a **fixed** strictly positive smoothing density, applied already at time zero, yields a Markov realization. Here the smoothing variance is zero initially. The initial state therefore records none of the branch information in the nontrivial germ event.

The covariance path (8) itself has an ordinary Gaussian strong Markov realization with independent increments. The obstruction is therefore not captured by covariance matrices alone: it depends on the shape of the marginal laws and on the conditional information forced at arbitrarily small times.

The proof concerns the completed, right-continuous filtration. With the raw natural filtration, \(\mathcal F_0=\sigma(Y_0)\) need not contain the event (21), and this proof gives no contradiction. The raw-filtration issue remains separate.

