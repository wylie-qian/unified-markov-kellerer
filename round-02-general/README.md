# 多维 Markov 实现与最小正则化：第二轮研究包

日期：2026-11-27。环境：Lean 4.19.0 / Mathlib v4.19.0。

## 本轮相对于第一轮的推进

第一轮只求解了高斯边缘族的最小总方差修正。本轮的主对象是**任意维、任意弱连续平方可积的非高斯凸序族**，以及通常滤过下的 Markov 实现。空间始终是连续的 `R^d`。

1. **固定空间平滑定理：** 同一个严格正的 `C_b²` 中心概率密度（有限二阶矩）在每个时间对边缘作卷积，即足以得到连续平方可积强 Markov 鞅实现。无需随时间增加卷积方差。要求原始时间 Itô 表示时，二阶矩曲线绝对连续是充要条件。
2. **固定 Gaussian 核的精确秩分类：** 它能对所有 peacock 保证连续强 Markov 实现，当且仅当核协方差正定。最小普适秩是全秩，但噪声迹成本的下确界仍为零且不达到。
3. **二维光滑反例：** 正时间各边缘在 `R²` 上有严格正 `C∞` 密度，并有显式连续鞅实现，但任何实现都不可能在通常滤过下 Markov。可写成 `μ_t * N(0,t^p I₂)`，任意 `p>1`；换时后得到线性方差 `t I₂` 形式。
4. **一般初始核障碍：** 对任何连续 Loewner 递增的 Gaussian 协方差路径 `Q(t)`，如果 `dim ker Q(0) ≥ 2`，则不能普适保证 Markov 实现，即使允许跳跃、即使所有正时间的 `Q(t)` 都正定。`Q(0)` 正定是充分条件；初始余秩一仍未分类。

这是包含完整数学证明、明确外部定理依赖与形式化核心的研究稿；未完成全文随机过程形式化、外部同行审查或历史优先权核定。不能宣称解决了 raw-filtration Kellerer 开放问题。

## 文件导航

| 文件 | 内容 |
|---|---|
| `FIXED_KERNEL_THEOREM.md` | 主证明：鞅二阶通量、固定核卷积、局部 C² 估计、叠加原理、强 Markov 构造、精确核几何、普适秩与代价结论 |
| `SMOOTH_TWO_DIMENSIONAL_OBSTRUCTION.md` | 二维正时间全支撑光滑反例；Gaussian 小球估计、阈值变化可求和、初始 germ 事件与 Markov 矛盾 |
| `INITIAL_KERNEL_OBSTRUCTION.md` | 任意时间变 Gaussian 协方差路径的初始余秩至少二障碍；处理初始随机状态和交叉协方差 |
| `BLIND_SUBSPACE_OBSTRUCTION.md` | 基础冻结分支引理与共同未平滑子空间的障碍 |
| `LITERATURE_AUDIT.md` | 文献定位、精确依赖、不能直接套用的条件和优先权边界 |
| `KernelGeometry.lean` | 真实 PSD、Bochner 矩阵积分、正权重与 Gaussian 核空间恒等、Glaeser 代数核心 |
| `GermObstructionCore.lean` | 真实概率空间中独立事件的误分类下界、零一结论、阈值事件包含与概率界 |
| `lean_build.log` | 交付源码的实际编译输出、退出码、警告/错误计数、公理审计与散列 |
| `lean-toolchain`, `lakefile.toml` | 可复现环境配置 |
| `SHA256SUMS` | 交付文件散列 |

## 复现 Lean

安装 Elan 后，在解压后的目录执行：

```sh
lake update
lake exe cache get
lake env lean KernelGeometry.lean
lake env lean GermObstructionCore.lean
```

两个源码文件都只依赖 Mathlib，不依赖未交付的项目模块或预编译定理。源文件中的 `#print axioms` 会输出公理依赖。

## 形式化信任边界

Lean 核验的是实际矩阵、积分和概率事件的核心命题。维数索引有限只表示 Euclidean 坐标，不是离散状态网格。Gaussian 核使用真实指数函数，概率结论使用真实 `Measure`、`IsProbabilityMeasure` 和 `IndepSet`。

完整鞅存在性、Itô 跳跃公式、通量的析取、Gaussian 小球界、Borel–Cantelli 极限、Fokker–Planck superposition 和强 Markov 性仍属于报告中的分析证明及引用模块。没有把这些结论用自定义公理塞进 Lean。

## 尚未完成的核心问题

- 初始协方差恰有一个零方向时，时间变 Gaussian 核是否普适保证允许跳跃的 Markov 实现。
- 任意未平滑 peacock 的分布层面 Markov 可实现性判别。
- 原始自然滤过下的 Kellerer 反例问题。
- 给定非高斯边缘、指定核类和非平凡标量代价下的逐实例精确最优正则化。
- 全文随机过程 Lean 形式化与独立专家审核。

以上不是待补的简单代数步骤，也不能由本轮编译通过直接推出。
