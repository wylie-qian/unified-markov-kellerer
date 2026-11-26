import Mathlib.LinearAlgebra.Matrix.PosDef
import Mathlib.Analysis.Matrix
import Mathlib.Data.Real.StarOrdered
import Mathlib.MeasureTheory.Integral.Bochner.ContinuousLinearMap
import Mathlib.Analysis.SpecialFunctions.Exp
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.Positivity

/-!
# Null directions of positive-semidefinite noise

The finite index type indexes coordinates of an arbitrary real Euclidean
space. The averaging space and its measure are arbitrary. This file proves
kernel intersections for sums and for genuine Bochner matrix integrals.
No stochastic existence theorem is assumed or declared as an axiom.
-/

noncomputable section
open scoped BigOperators Matrix
open MeasureTheory

namespace KernelGeometry

variable {ι : Type*} [Fintype ι]

attribute [local instance] Matrix.normedAddCommGroup Matrix.normedSpace

def Kernel (A : Matrix ι ι ℝ) : Set (ι → ℝ) := {x | A *ᵥ x = 0}

/-- A positive-semidefinite sum kills exactly the common null directions. -/
theorem add_mulVec_zero_iff (A B : Matrix ι ι ℝ)
    (hA : A.PosSemidef) (hB : B.PosSemidef) (x : ι → ℝ) :
    (A + B) *ᵥ x = 0 ↔ A *ᵥ x = 0 ∧ B *ᵥ x = 0 := by
  constructor
  · intro h
    have hsum : star x ⬝ᵥ A *ᵥ x + star x ⬝ᵥ B *ᵥ x = 0 := by
      rw [← dotProduct_add, ← Matrix.add_mulVec, h, dotProduct_zero]
    have hqa : star x ⬝ᵥ A *ᵥ x = 0 := by
      linarith [hA.2 x, hB.2 x]
    have hqb : star x ⬝ᵥ B *ᵥ x = 0 := by
      linarith [hA.2 x, hB.2 x]
    exact ⟨(hA.dotProduct_mulVec_zero_iff x).mp hqa,
      (hB.dotProduct_mulVec_zero_iff x).mp hqb⟩
  · rintro ⟨ha, hb⟩
    rw [Matrix.add_mulVec, ha, hb, add_zero]

theorem kernel_add (A B : Matrix ι ι ℝ)
    (hA : A.PosSemidef) (hB : B.PosSemidef) :
    Kernel (A + B) = Kernel A ∩ Kernel B := by
  ext x
  exact add_mulVec_zero_iff A B hA hB x

/-- Increasing a PSD matrix in Loewner order can only remove null directions. -/
theorem mulVec_zero_of_le (A B : Matrix ι ι ℝ)
    (hA : A.PosSemidef) (hBA : (B - A).PosSemidef)
    (x : ι → ℝ) (hx : B *ᵥ x = 0) : A *ᵥ x = 0 := by
  have hdiff := hBA.2 x
  rw [Matrix.sub_mulVec, dotProduct_sub, hx, dotProduct_zero] at hdiff
  have hqa : star x ⬝ᵥ A *ᵥ x = 0 := by linarith [hA.2 x]
  exact (hA.dotProduct_mulVec_zero_iff x).mp hqa

theorem kernel_antitone (A B : Matrix ι ι ℝ)
    (hA : A.PosSemidef) (hBA : (B - A).PosSemidef) :
    Kernel B ⊆ Kernel A := by
  intro x hx
  exact mulVec_zero_of_le A B hA hBA x hx

theorem psd_smul (a : ℝ) (ha : 0 ≤ a) (A : Matrix ι ι ℝ)
    (hA : A.PosSemidef) : (a • A).PosSemidef := by
  constructor
  · change (a • A)ᴴ = a • A
    rw [Matrix.conjTranspose_smul, star_trivial, hA.1]
  · intro x
    rw [Matrix.smul_mulVec_assoc, dotProduct_smul, smul_eq_mul]
    exact mul_nonneg ha (hA.2 x)

theorem smul_mulVec_zero_iff (a : ℝ) (ha : a ≠ 0) (A : Matrix ι ι ℝ)
    (x : ι → ℝ) : (a • A) *ᵥ x = 0 ↔ A *ᵥ x = 0 := by
  rw [Matrix.smul_mulVec_assoc, smul_eq_zero]
  simp only [ha, false_or]

/-- Coordinate evaluation as a continuous linear functional on real matrices. -/
def entryCLM (i j : ι) : Matrix ι ι ℝ →L[ℝ] ℝ :=
  (ContinuousLinearMap.proj j : (ι → ℝ) →L[ℝ] ℝ).comp
    (ContinuousLinearMap.proj i : Matrix ι ι ℝ →L[ℝ] (ι → ℝ))

omit [Fintype ι] in
@[simp] theorem entryCLM_apply (i j : ι) (A : Matrix ι ι ℝ) :
    entryCLM i j A = A i j := rfl

/-- For a fixed vector, its quadratic evaluation is linear in the matrix. -/
def quadraticCLM (x : ι → ℝ) : Matrix ι ι ℝ →L[ℝ] ℝ :=
  ∑ i, ∑ j, (x i * x j) • entryCLM i j

theorem quadraticCLM_apply (x : ι → ℝ) (A : Matrix ι ι ℝ) :
    quadraticCLM x A = star x ⬝ᵥ A *ᵥ x := by
  simp only [quadraticCLM, ContinuousLinearMap.sum_apply,
    ContinuousLinearMap.smul_apply, entryCLM_apply, smul_eq_mul]
  simp only [star_trivial, dotProduct, Matrix.mulVec, Finset.mul_sum]
  apply Finset.sum_congr rfl
  intro i _
  apply Finset.sum_congr rfl
  intro j _
  ring

section Integration

variable {T : Type*} [MeasurableSpace T] {μ : Measure T}
variable {Q : T → Matrix ι ι ℝ}

theorem entry_integral (hQ : Integrable Q μ) (i j : ι) :
    (∫ t, Q t ∂μ) i j = ∫ t, Q t i j ∂μ := by
  simpa only [entryCLM_apply] using ((entryCLM i j).integral_comp_comm hQ).symm

theorem quadratic_integrable (hQ : Integrable Q μ) (x : ι → ℝ) :
    Integrable (fun t => star x ⬝ᵥ Q t *ᵥ x) μ := by
  simpa only [quadraticCLM_apply] using (quadraticCLM x).integrable_comp hQ

theorem quadratic_integral (hQ : Integrable Q μ) (x : ι → ℝ) :
    ∫ t, star x ⬝ᵥ Q t *ᵥ x ∂μ = star x ⬝ᵥ (∫ t, Q t ∂μ) *ᵥ x := by
  simpa only [quadraticCLM_apply] using (quadraticCLM x).integral_comp_comm hQ

/-- A Bochner average of almost-everywhere PSD matrices is PSD. -/
theorem integral_posSemidef (hQ : Integrable Q μ)
    (hPSD : ∀ᵐ t ∂μ, (Q t).PosSemidef) :
    (∫ t, Q t ∂μ).PosSemidef := by
  constructor
  · change (∫ t, Q t ∂μ)ᴴ = ∫ t, Q t ∂μ
    ext i j
    simp only [Matrix.conjTranspose_apply, star_trivial]
    rw [entry_integral hQ j i, entry_integral hQ i j]
    apply integral_congr_ae
    filter_upwards [hPSD] with t ht
    have hs := congrArg (fun A : Matrix ι ι ℝ => A i j) ht.1
    simpa only [Matrix.conjTranspose_apply, star_trivial] using hs
  · intro x
    rw [← quadratic_integral hQ x]
    apply integral_nonneg_of_ae
    filter_upwards [hPSD] with t ht
    exact ht.2 x

/-- Exact zero-energy criterion, valid for any measure and real dimension. -/
theorem quadratic_integral_zero_iff (hQ : Integrable Q μ)
    (hPSD : ∀ᵐ t ∂μ, (Q t).PosSemidef) (x : ι → ℝ) :
    star x ⬝ᵥ (∫ t, Q t ∂μ) *ᵥ x = 0 ↔
      ∀ᵐ t ∂μ, Q t *ᵥ x = 0 := by
  have hnonneg : 0 ≤ᵐ[μ] fun t => star x ⬝ᵥ Q t *ᵥ x := by
    filter_upwards [hPSD] with t ht
    exact ht.2 x
  rw [← quadratic_integral hQ x,
    integral_eq_zero_iff_of_nonneg_ae hnonneg (quadratic_integrable hQ x)]
  constructor
  · intro hz
    filter_upwards [hPSD, hz] with t ht he
    exact (ht.dotProduct_mulVec_zero_iff x).mp he
  · intro hz
    filter_upwards [hz] with t ht
    simp only [ht, dotProduct_zero, Pi.zero_apply]

/-- The kernel of a Bochner average is the almost-everywhere common kernel. -/
theorem integral_mulVec_zero_iff (hQ : Integrable Q μ)
    (hPSD : ∀ᵐ t ∂μ, (Q t).PosSemidef) (x : ι → ℝ) :
    (∫ t, Q t ∂μ) *ᵥ x = 0 ↔ ∀ᵐ t ∂μ, Q t *ᵥ x = 0 := by
  rw [← (integral_posSemidef hQ hPSD).dotProduct_mulVec_zero_iff x]
  exact quadratic_integral_zero_iff hQ hPSD x

theorem kernel_integral (hQ : Integrable Q μ)
    (hPSD : ∀ᵐ t ∂μ, (Q t).PosSemidef) :
    Kernel (∫ t, Q t ∂μ) = {x | ∀ᵐ t ∂μ, x ∈ Kernel (Q t)} := by
  ext x
  exact integral_mulVec_zero_iff hQ hPSD x

/-- Strictly positive weighting and normalization do not alter the common kernel.
Only the weighted field is required to be integrable. -/
theorem positive_weighted_normalized_zero_iff (w : T → ℝ) (ρ : ℝ)
    (hρ : 0 < ρ) (hw : ∀ᵐ t ∂μ, 0 < w t)
    (hQ : Integrable (fun t => w t • Q t) μ)
    (hPSD : ∀ᵐ t ∂μ, (Q t).PosSemidef) (x : ι → ℝ) :
    (ρ⁻¹ • (∫ t, w t • Q t ∂μ)) *ᵥ x = 0 ↔
      ∀ᵐ t ∂μ, Q t *ᵥ x = 0 := by
  have hweighted : ∀ᵐ t ∂μ, (w t • Q t).PosSemidef := by
    filter_upwards [hw, hPSD] with t hwt hQt
    exact psd_smul (w t) (le_of_lt hwt) (Q t) hQt
  rw [smul_mulVec_zero_iff _ (inv_ne_zero (ne_of_gt hρ)),
    integral_mulVec_zero_iff hQ hweighted x]
  constructor
  · intro hz
    filter_upwards [hw, hz] with t hwt ht
    exact (smul_mulVec_zero_iff (w t) (ne_of_gt hwt) (Q t) x).mp ht
  · intro hz
    filter_upwards [hz] with t ht
    rw [Matrix.smul_mulVec_assoc, ht, smul_zero]

theorem positive_weighted_normalized_psd (w : T → ℝ) (ρ : ℝ)
    (hρ : 0 < ρ) (hw : ∀ᵐ t ∂μ, 0 ≤ w t)
    (hQ : Integrable (fun t => w t • Q t) μ)
    (hPSD : ∀ᵐ t ∂μ, (Q t).PosSemidef) :
    (ρ⁻¹ • (∫ t, w t • Q t ∂μ)).PosSemidef := by
  apply psd_smul _ (le_of_lt (inv_pos.mpr hρ))
  apply integral_posSemidef hQ
  filter_upwards [hw, hPSD] with t hwt hQt
  exact psd_smul (w t) hwt (Q t) hQt

/-- In particular, convolution with everywhere-positive kernels has a spatially
constant nullspace, whenever both convolution matrices are well-defined. -/
theorem positive_weight_kernel_independent
    (w₁ w₂ : T → ℝ) (ρ₁ ρ₂ : ℝ) (hρ₁ : 0 < ρ₁) (hρ₂ : 0 < ρ₂)
    (hw₁ : ∀ᵐ t ∂μ, 0 < w₁ t) (hw₂ : ∀ᵐ t ∂μ, 0 < w₂ t)
    (hQ₁ : Integrable (fun t => w₁ t • Q t) μ)
    (hQ₂ : Integrable (fun t => w₂ t • Q t) μ)
    (hPSD : ∀ᵐ t ∂μ, (Q t).PosSemidef) :
    Kernel (ρ₁⁻¹ • (∫ t, w₁ t • Q t ∂μ)) =
      Kernel (ρ₂⁻¹ • (∫ t, w₂ t • Q t ∂μ)) := by
  ext x
  exact (positive_weighted_normalized_zero_iff w₁ ρ₁ hρ₁ hw₁ hQ₁ hPSD x).trans
    (positive_weighted_normalized_zero_iff w₂ ρ₂ hρ₂ hw₂ hQ₂ hPSD x).symm

/-- The common kernel can be read directly from the unweighted total flux. -/
theorem positive_weighted_normalized_vs_total_kernel
    (w : T → ℝ) (ρ : ℝ) (hρ : 0 < ρ) (hw : ∀ᵐ t ∂μ, 0 < w t)
    (hQ : Integrable Q μ) (hWQ : Integrable (fun t => w t • Q t) μ)
    (hPSD : ∀ᵐ t ∂μ, (Q t).PosSemidef) :
    Kernel (ρ⁻¹ • (∫ t, w t • Q t ∂μ)) = Kernel (∫ t, Q t ∂μ) := by
  ext x
  exact (positive_weighted_normalized_zero_iff w ρ hρ hw hWQ hPSD x).trans
    (integral_mulVec_zero_iff hQ hPSD x).symm

end Integration

/-- The actual isotropic Gaussian weight, without its positive scalar normalizer.
Here `ε` is the covariance scale, and the intended domain is `ε > 0`. -/
def gaussianWeight (ε : ℝ) (x z : ι → ℝ) : ℝ :=
  Real.exp (-((∑ i, (x i - z i)^2) / (2 * ε)))

theorem gaussianWeight_bounds (ε : ℝ) (hε : 0 < ε) (x z : ι → ℝ) :
    0 < gaussianWeight ε x z ∧ gaussianWeight ε x z ≤ 1 := by
  constructor
  · exact Real.exp_pos _
  · apply Real.exp_le_one_iff.mpr
    apply neg_nonpos.mpr
    exact div_nonneg (Finset.sum_nonneg fun i _ => sq_nonneg (x i - z i))
      (le_of_lt (mul_pos (by norm_num) hε))

/-- An actual Gaussian-convolved flux divided by a positive scalar density.
The omitted Gaussian normalizing constant may be included in `ρ`. -/
def gaussianAverage (μ : Measure (ι → ℝ)) (Q : (ι → ℝ) → Matrix ι ι ℝ)
    (ε ρ : ℝ) (x : ι → ℝ) : Matrix ι ι ℝ :=
  ρ⁻¹ • (∫ z, gaussianWeight ε x z • Q z ∂μ)

theorem gaussian_kernel_independent
    (μ : Measure (ι → ℝ)) (Q : (ι → ℝ) → Matrix ι ι ℝ)
    (ε : ℝ) (hε : 0 < ε) (x y : ι → ℝ) (ρx ρy : ℝ)
    (hρx : 0 < ρx) (hρy : 0 < ρy)
    (hQx : Integrable (fun z => gaussianWeight ε x z • Q z) μ)
    (hQy : Integrable (fun z => gaussianWeight ε y z • Q z) μ)
    (hPSD : ∀ᵐ z ∂μ, (Q z).PosSemidef) :
    Kernel (gaussianAverage μ Q ε ρx x) =
      Kernel (gaussianAverage μ Q ε ρy y) := by
  exact positive_weight_kernel_independent (gaussianWeight ε x) (gaussianWeight ε y)
    ρx ρy hρx hρy
    (Filter.Eventually.of_forall fun z => (gaussianWeight_bounds ε hε x z).1)
    (Filter.Eventually.of_forall fun z => (gaussianWeight_bounds ε hε y z).1)
    hQx hQy hPSD

/-- The Gaussian flux nullspace equals the nullspace of the total covariance flux. -/
theorem gaussian_kernel_eq_total
    (μ : Measure (ι → ℝ)) (Q : (ι → ℝ) → Matrix ι ι ℝ)
    (ε : ℝ) (hε : 0 < ε) (ρ : ℝ) (hρ : 0 < ρ) (x : ι → ℝ)
    (hQ : Integrable Q μ)
    (hWQ : Integrable (fun z => gaussianWeight ε x z • Q z) μ)
    (hPSD : ∀ᵐ z ∂μ, (Q z).PosSemidef) :
    Kernel (gaussianAverage μ Q ε ρ x) = Kernel (∫ z, Q z ∂μ) := by
  exact positive_weighted_normalized_vs_total_kernel (gaussianWeight ε x) ρ hρ
    (Filter.Eventually.of_forall fun z => (gaussianWeight_bounds ε hε x z).1)
    hQ hWQ hPSD

/-- Scalar Glaeser certificate: global nonnegativity of a quadratic upper
Taylor model forces the sharp discriminant bound. -/
theorem glaeser_quadratic_certificate (a b c : ℝ) (hc : 0 ≤ c)
    (hpoly : ∀ h : ℝ, 0 ≤ a + b * h + (c / 2) * h^2) :
    b^2 ≤ 2 * c * a := by
  by_cases hc0 : c = 0
  · by_cases hb0 : b = 0
    · simp [hc0, hb0]
    · have hh := hpoly (-(a + 1) / b)
      have he : a + b * (-(a + 1) / b) + (c / 2) * (-(a + 1) / b)^2 = -1 := by
        rw [hc0]
        field_simp [hb0]
      rw [he] at hh
      norm_num at hh
  · have hcp : 0 < c := lt_of_le_of_ne hc (Ne.symm hc0)
    have hh := hpoly (-b / c)
    have hm := mul_nonneg (show 0 ≤ 2 * c by positivity) hh
    have he : 2 * c * (a + b * (-b / c) + (c / 2) * (-b / c)^2) =
        2 * c * a - b^2 := by
      field_simp [hc0]
      ring
    rw [he] at hm
    linarith

end KernelGeometry

#print axioms KernelGeometry.kernel_add
#print axioms KernelGeometry.kernel_antitone
#print axioms KernelGeometry.integral_posSemidef
#print axioms KernelGeometry.quadratic_integral_zero_iff
#print axioms KernelGeometry.integral_mulVec_zero_iff
#print axioms KernelGeometry.kernel_integral
#print axioms KernelGeometry.positive_weighted_normalized_zero_iff
#print axioms KernelGeometry.positive_weight_kernel_independent
#print axioms KernelGeometry.positive_weighted_normalized_vs_total_kernel
#print axioms KernelGeometry.gaussian_kernel_independent
#print axioms KernelGeometry.gaussian_kernel_eq_total
#print axioms KernelGeometry.glaeser_quadratic_certificate
