# 固定空间卷积与多维 Markov 实现：文献边界核对

**核对日期：2026-11-27（Asia/Taipei；对应 UTC 2026-11-26）。** 本记录是有界范围的文献检索及数学依赖审计，不是优先权证明。检索未发现直接同命题，不等于证明不存在同命题；未发表工作、未被索引的论文及尚未阅读的书籍章节仍可能包含它。

## 1. 本轮候选定理与允许的结论

候选结论是：给定任意维数中的弱连续平方可积 peacock \((\mu_t)\)，以及固定、中心化、具有有限二阶矩的概率密度 \(k>0\)，若 \(k\in C_b^2\)，则 \(\mu_t*k\) 存在从其规定初始分布出发的连续平方可积强 Markov 鞅实现。对任意 \(Q_0\succ0\)，固定高斯核 \(k=g_{Q_0}\) 满足这些条件。时间上不再额外增加卷积协方差。

该表述本身不包含从**每个**初始点出发的全局保守性、Feller 性、统一椭圆性或实现唯一性。证明若使用能量时钟，必须明确原时钟中的过程只是确定性时间变换；原时钟 Itô 表示另以二阶矩函数绝对连续为条件。

**目前没有找到可以直接标注为“已有某定理的逐字推论”的完整 fixed-kernel 命题，也没有找到已发表的 fixed full-rank initial Gaussian counterexample。上述两项均为检索结果，不是新颖性结论。**

## 2. PRS 的准确边界

Gudmund Pammer、Benjamin A. Robinson、Walter Schachermayer，*A regularized Kellerer theorem in arbitrary dimension*，**Annals of Applied Probability 35(2), 749–778, 2025**，DOI [10.1214/24-AAP2125](https://doi.org/10.1214/24-AAP2125)。核对 [arXiv v3](https://arxiv.org/html/2210.13847v3)（2024-03-22 修订）与[作者所存发表版](https://barobinson.github.io/kellerer-regularized.pdf)。

| 位置 | 已有结论及本轮必须遵守的边界 |
|---|---|
| Theorem 1.1 | 使用 \(\mu_t*\gamma^{\varepsilon(t+\delta)}\)，\(\varepsilon,\delta>0\)，得到强 Markov/Feller 扩散实现。 |
| Remark 2.1 | 初始方差为正、随后严格增加的其他标量方差函数已在作者讨论范围内；仅改变线性方差时钟不是新贡献。 |
| Lemma 2.3 | 固定在每个时间小区间的 Gaussian 卷积给出 covariance 的局部有界与空间 Lipschitz 估计；随后额外噪声用于下方椭圆性。 |
| Proposition 4.2 / Remark 4.4 | 一个四维例子排除连续 Markov 实现，但该例子仍有带跳强 Markov 实现。 |
| Proposition 4.6 | 另一个四维例子排除通常滤过下的 Markov 鞅实现，允许跳跃亦然。 |
| Proposition 4.7 | 即使卷积 \(\gamma^t\)，仍有四维反例；这不排除正的固定初始 Gaussian 卷积。 |
| Remark 4.5 | 反例依赖右连续完成滤过；其中连续例子对未经扩大的原始自然滤过仍可为 Markov。 |

### 时钟审计：独立的数学检查

不能把“弱连续平方可积 peacock”自动改写成“原时钟下有平方可积 Itô 实现”。取连续、非绝对连续的非减函数 \(C\)，令 \(\mu_t=N(0,C(t)I)\)。若目标边缘为 \(\mu_t*N(0,Q_0+tR)\)，其二阶矩仍含有 \(dC\) 的奇异部分。另一方面，任何平方可积原时钟 Itô 鞅都有

\[
\mathbb E|M_t|^2-\mathbb E|M_0|^2
=\int_0^t\mathbb E\operatorname{tr}(\sigma_s\sigma_s^\top)\,ds,
\]

所以二阶矩必为绝对连续函数。引用 PRS 时应同时说明其 Remark 2.1 的时间归一化，而不把一个确定性时间变换默认为原时钟 Itô 积分。其定理陈述中初始变量的符号也必须与**正则化后初始边缘**一致。

## 3. Trevisan：真正可以引用的技术模块

### 3.1. 初始非 Markov 鞅的直接存在性来源

Francis Hirsch、Bernard Roynette，*On \(\mathbb R^d\)-valued peacocks*，**ESAIM: Probability and Statistics 17, 444–454, 2013**，DOI [10.1051/ps/2012009](https://doi.org/10.1051/ps/2012009)，[发表版 PDF](https://www.numdam.org/item/PS_2013__17__444_0.pdf)。**Theorem 3.2** 给出弱右连续多维 peacock 与右连续鞅实现的等价性；有限时域平方可积性和标准鞅正则化提供本轮所需 càdlàg 实现。该结论不要求、也不提供所需的 Markov 性。不要误引两位作者 2012 年一维的 *A new proof of Kellerer's theorem* 作为此多维结论的直接定理。

### 3.2. Superposition、卷积及退化系数

Dario Trevisan，*Well-posedness of multidimensional diffusion processes with weakly differentiable coefficients*，**Electronic Journal of Probability, 2016**。[arXiv:1507.01357v2](https://arxiv.org/pdf/1507.01357)，[作者维护的 CVGMT 条目](https://cvgmt.sns.it/paper/3486/)。

- **Theorem 2.5，PDF p.7：** 弱连续概率值 Fokker–Planck 解，在其 Definition 2.2 的系数可积条件下，具有连续路径 martingale-problem 实现，且所有单时边缘正确。这里的系数可以退化；不要求统一椭圆性。
- **Appendix A.1，PDF pp.30–31：** 讨论固定空间卷积和商形式的新系数；这是既有方法，不应称为本次发现。
- **Lemma A.1：** 原文有相对导数界 \(|D^j k|\le Ck\) 及原始分子测度绝对连续于分母测度等假设。我们的 Gaussian 核不满足全局相对一阶导数界，而待构造的 flux 也未必相对于 \(\mu_t\) 绝对连续。因此该 lemma **不能原样直接应用**。应另证有限 flux 总质量、分母紧集下界及 \(C_b^2\) 核所给出的局部估计。
- **Theorem A.5 及其证明，PDF p.37：** 对 \(L^1_tC_b^2\) 系数建立基础扩散存在性；证明引用 Stroock–Varadhan Lemma 3.2.3 处理退化平方根。

这里需要的 superposition 条件可直接核验：若 \(F_t\) 是有限 PSD 矩阵值 flux，\(\rho_t=k*\mu_t\)，\(a_t=(k*F_t)/\rho_t\)，则

\[
\int\operatorname{tr}a_t(x)\rho_t(x)\,dx
=\operatorname{tr}F_t(\mathbb R^d).
\]

这条等式给出系数沿目标边缘的可积性；它并不单独给出强 Markov 性。后者还需要空间局部 Lipschitz 的平方根、局部路径唯一性及 SDE/鞅问题的标准强 Markov 推论。

## 4. 退化 PSD 矩阵平方根：明确已有定理

K. D. Elworthy、Y. Le Jan、X.-M. Li，*The Geometry of Filtering*，[作者所存稿](https://www.xuemei.org/FiltDiff.pdf)，**Theorem 9.2.1，印刷页136／PDF第136页**：\(C^2\) 的对称 PSD 矩阵值映射，其主平方根局部 Lipschitz。无需正定性、固定秩或统一谱隙。

该处引用 Freidlin 的 *Functional Integration and Partial Differential Equations*（1985）、Stroock–Varadhan 的相关结论和 Ikeda–Watanabe。Trevisan 上述论文独立明确引用 **Stroock–Varadhan, Lemma 3.2.3**。

使用时仍需验证时间方向的常数：局部 \(C^2\) 界应在能量归一化时钟下一致；或在原时钟下具有 \(L^1\) 控制，从而平方根的局部 Lipschitz 常数的平方可积。仅写“每个固定时间局部 Lipschitz”不足以完成时变 SDE 唯一性论证。

## 5. PSD flux 及二阶 Beckmann：不能遗漏的既有背景

Martin Huesmann、Dario Trevisan，*A Benamou–Brenier formulation of martingale optimal transport*，**Bernoulli 25(4A), 2729–2757, 2019**；[arXiv:1707.01493](https://arxiv.org/pdf/1707.01493)，[CVGMT](https://cvgmt.sns.it/paper/3730/)。该文已经系统连接连续时间 MOT、PSD 扩散系数及 Fokker–Planck 方程。尤其 **Lemma 3.6 (convolution)，PDF第13页** 已明确固定严格正 \(C^2\) 核产生商形式 \(\widetilde a=((\rho a)*k)/(\rho*k)\)、空间 \(C^2\) 正则性及原 Fokker–Planck 方程的卷积版本。该 lemma 的核条件仍包括全局相对导数界 \(|D^i k|\le\lambda k\)，并引用 Trevisan Lemma A.1。把 Eulerian 扩散通量或固定卷积平滑系数作为概念本身，都不是新贡献。

Karol Bołbotowski、Guy Bouchitté，*Kantorovich–Rubinstein duality theory for the Hessian*，[arXiv:2412.00516v3](https://arxiv.org/html/2412.00516v3)，修订日期 **2025-10-31**。**§4.1、Proposition 4.1** 研究凸序下 \(\operatorname{div}^2\sigma=\nu-\mu\) 的 PSD 矩阵测度和二阶 Beckmann 问题；文中沿线段的张量测度与本轮 Taylor-flux 构造具有直接结构联系。这里仅核对该 PSD-flux 背景，不援引其其他章节的全部结论。

本轮有价值的待审核连接应准确表述为：对**整条**给定 peacock，在能量时钟下构造可测有限 PSD flux；对固定正核卷积后取得局部一致 \(C^2\) 系数；利用退化平方根正则性和 superposition 获得规定边缘的强 Markov 实现。所有模块均有先行理论；完整连接是否已出现，需要进一步专家核对。

## 6. 2025–2026 检索中出现但不能混为本命题的工作

Michael M. Kay，*Multi-Dimensional Martingales from Mutual Information*，[arXiv:2512.16544](https://arxiv.org/abs/2512.16544)，2025-12-18 提交。其摘要明确处理**有限个时间边缘**及熵 MOT 的校准构造；它不能用来声称解决连续时间 fixed-kernel Kellerer 命题。

截至本记录日期，围绕作者姓名、Kellerer、constant/fixed Gaussian convolution、initial smoothing、peacock、superposition、Freidlin、Glaeser，以及 2025–2026 更新进行了公开检索，核对了以上一手论文或作者稿。没有定位到可确认为本轮完整 fixed-kernel 命题的发表定理，也没有定位到对此完整命题的已发表反例。未使用自动生成论文摘要网站、研究想法网站或非作者维护的代码镜像来认定数学优先权。

## 7. 最小性与退化方向：已经能说什么

固定正定 Gaussian 的充分性若通过完整证明，仍不自动意味着正定性在所有维数中必要。PRS 的四维反例可在未被卷积触及的四维子空间中嵌入；对**固定**退化 Gaussian 核，若 \(\dim\ker Q_0\ge4\)，可由该嵌入和补空间坐标二阶矩恒定而冻结，继承通常滤过下的障碍。须证明全过程的初始信息矛盾，不能使用“Markov 过程的任意投影仍 Markov”这一错误命题。下节给出本轮得到的更低维候选，须与这个已发表的四维边界区分。

若核为 \(N(0,Q_0+tR)\)，单靠 \(\dim\ker Q_0\ge4\) 的同一冻结论证不够：补空间可能随时间变化，且 \(R\) 可有交叉协方差。至少当 \(\ker Q_0\cap\ker R\) 含四维空间时，完全未触及的坏过程子空间仍可用于连续路径的支撑分支论证。更强的必要条件不能从 PRS 标题或一句投影论证推出。本轮随后给出了额外的二维分类误差估计和初始信息独立性论证，见下节及独立文件 `INITIAL_KERNEL_OBSTRUCTION.md`。

因此，在允许带跳 Markov 实现或预先限定原始 peacock 已有连续实现的类别中，本轮不应宣称已获得所有退化秩的必要充分分类。也不应把“任意正噪声可用、零噪声不可普适”称为严格意义上一个达到的最小正噪声。若允许 \(Q_0=\varepsilon I\) 任意 \(\varepsilon>0\)，规模下确界可为零，而普适零正则化仍失败。

若任务明确是对**所有** peacock 普适地保证**连续**实现，则固定 Gaussian 核的满秩必要性有更简单的独立证明。取单位向量 \(v\in\ker Q_0\)，令 \(R\) 有对称光滑密度、支撑于 \((-2,-1)\cup(1,2)\)，令 \(W\) 是 \(v^\perp\) 中独立静态 Gaussian。边缘 \(\mu_t=\operatorname{Law}(W+(1+t)Rv)\) 是光滑密度 peacock；卷积后 \(v\) 投影仍为 \((1+t)R\)。任何连续实现均不能跨越零附近的固定空隙，所以 \(A=\{v\cdot Y_0>0\}\) 是不变分支。鞅性质要求 \(\mathbb E[(v\cdot Y_t)1_A]\) 恒定，而边缘使其等于 \((1+t)\mathbb E[R_+]\)，矛盾。此例的原始 peacock 本身没有连续鞅实现，因此不能冒充更窄类别的反例。

## 8. 本轮二维交替轴 Gaussian 反例的独立核查

研究过程中提出了如下简化候选。将 \((0,1]\) 分成趋于零的交替 dyadic 区间族 \(I_1,I_2\)，置

\[
a_i(t)=\int_0^t1_{I_i}(s)\,ds,\qquad
\mu_t=\tfrac12\bigl(N(0,a_1(t))\otimes\delta_0\bigr)
+\tfrac12\bigl(\delta_0\otimes N(0,a_2(t))\bigr).
\]

对于 \(t>0\)，两项都不在原点放置原子，且 \(a_i(t)>0\)。独立 Bernoulli 变量选择坐标轴，再让一维 Brownian 沿该轴以时钟 \(a_i\) 运行，立即给出连续平方可积鞅实现。

对任何具有这些边缘的平方可积鞅 \(Y\)，若 \(a_2\) 在 \([s,t]\) 上冻结，则

\[
\mathbb E[(Y^2_t-Y^2_s)^2]
=\mathbb E[(Y^2_t)^2]-\mathbb E[(Y^2_s)^2]=0.
\]

因此两个确定端点的横轴指示函数相同。另一类区间改用第一坐标，结论相同。连接有限多个正时间区间，横轴指示在任意两个固定正时刻相同几乎处处。选可数时间列 \(t_n\downarrow0\)，得到非平凡分支事件 \(A\in\bigcap_n\mathcal F_{t_n}=\mathcal F_0\)，但 \(Y_0=0\)。任何固定正时刻的轴指示已经等于 \(1_A\)，故 Markov 性在零时刻矛盾。

随机时刻 Brownian 可以经过原点，不会破坏这个证明：所用的是固定正时间的零原点质量、冻结区间端点及可数事件。此核查未发现数学反例或遗漏。它与 PRS 使用的四维双圆构造不同；应称为**本轮独立推导的二维交替轴构造**，不要未审查优先权就称为首次反例。

围绕“\(\text{Kellerer axes}\)”“\(\text{two-dimensional counterexample Markov martingale}\)”“\(\text{peacock Gaussian alternating}\)”的补充搜索没有定位到同一已发表例子。PRS 的发表文本明确在存在性反例部分使用四维；其二维结论是非唯一性。公开检索不足以证明二维构造没有先例。

该二维例若作为已核准数学引理采用，则固定退化 Gaussian 核在 \(\dim\ker Q_0\ge2\) 时可通过嵌入和冻结补空间继承通常滤过下的 Markov 障碍。对随时间增长的满秩噪声，原始冻结等式不再成立，必须另给定量稳定性证明；下面记录本轮对这一额外步骤的检查。

### 定量升级的独立检查记录

同轮讨论还提出 \(\nu_t=\eta_t*\gamma^{t^p}\)，\(p>1\)，其中 \(\eta\) 是轴 Gaussian peacock。此时正时间边缘有严格正的光滑二维密度。取 \(\beta\in(1/2,p/2)\)，在 dyadic 时刻定义 \(F_t^j=\{|Y_t^j|\le t^\beta\}\)。在基底第 \(j\) 坐标冻结的相邻区间 \(s=t/2\) 中，

\[
\mathbb P(F_t^j\triangle F_s^j)
\le \frac{4(t^p-s^p)}{s^{2\beta}}
+\mathbb P\bigl(s^\beta/2\le |Y_s^j|\le t^\beta+s^\beta/2\bigr).
\]

后项的窄 Gaussian 成分由 Chebyshev 控制为 \(O(s^{p-2\beta})\)，宽成分由 Gaussian 小球估计控制为 \(O(s^{\beta-1/2})\)，因 \(a_j(s)\ge s/3\)。同样的估计证明两个坐标分类近似互补。误差沿 dyadic 序列可求和，故得到非平凡 \(\mathcal F_0\) germ；若零时刻 Markov，该 germ 会独立每个分类事件，从而独立自身，矛盾。该推导也通过了本记录作者的独立代数与概率检查，但完整定理应以专门证明文件为准。

时间替换 \(u=t^p\) 后卷积协方差为 \(uI\)，故若完整论证采用，将给出 PRS “零初始噪声、正时间 Gaussian 正则化仍可能失败”机制的二维版本。其首创性仍未得到文献优先权确认。

### 任意 Gaussian 协方差曲线的初始核障碍

独立文件 `INITIAL_KERNEL_OBSTRUCTION.md` 将上一步推广到任意连续、Loewner 非减的 \(Q(t)\)：若 \(\dim\ker Q(0)\ge2\)，则该 Gaussian 卷积路径不能对全部 peacock 保证通常滤过的 Markov 鞅实现。其额外步骤是选择隐藏二维平面 \(W\subseteq\ker Q(0)\)，令 \(\eta(t)=\operatorname{tr}(P_WQ(t)P_W)\)，使用更快的基底时钟 \(f(t)=(t+\eta(t))^{1/p}\)，从而在基底 dyadic 时间上噪声方差受 \(u^p\) 控制。

即使 \(Q(t)\) 有 \(W\) 与补空间之间的交叉协方差，单时 Gaussian 混合表示仍使“真实混合标签”独立于整个补空间 Gaussian。分类器与标签的概率误差趋于零，加上候选鞅补空间坐标在零时刻的 \(L^2\) 连续性，推出强制 germ 独立于**完整初态**。这一步补足不能把 Markov 性投影的逻辑缺口。本记录逐节审查了该独立文件，未发现实质错误；初始 corank-one 的一般时变情形仍未分类。

## 9. 推荐的论文与形式化用语

建议写成“本文给出固定空间卷积充分性的一个可审核证明；在所检索文献中尚未定位到相同完整表述，优先权待专业文献审查”。不要使用“首次解决多维 Kellerer”“全类别最小正则化分类已完成”“Lean 已证明整个强 Markov 测度论定理”等措辞。

Lean 若仅核验 Taylor/PSD/商估计的核心代数命题，应逐项列出其覆盖范围，另列依赖既有连续测度与 SDE 定理的桥接步骤。编译和公理审计是形式化覆盖部分的证据；它不代替文献优先权审查，也不自动证明文档中未形式化的分析步骤。
