import Mathlib.LinearAlgebra.Matrix.PosDef
import Mathlib.LinearAlgebra.Matrix.Trace
import Mathlib.Data.Real.StarOrdered
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Positivity
import Mathlib.MeasureTheory.Integral.Bochner.Basic
import Mathlib.Data.Matrix.Notation
import Mathlib.Tactic.FinCases

/-!
# Verified core for multidimensional covariance regularization

Lean 4.19.0 / Mathlib v4.19.0. Standalone Mathlib-only source.

Proves the exact spectral minimum and uniqueness of PSD covariance repair,
the corresponding arbitrary-measure integrated cost and equality conditions,
and a parameterized obstruction to a Loewner-least correction.

Finite index types label coordinates of continuous Euclidean space, not
possible transport states. The time measure space is fully general.

The stochastic Gaussian realization and original-clock covariance arguments
are proved in KELLERER_RESEARCH_REPORT.md. They are NOT axiomatized or claimed
as Lean theorems here. The general multidimensional Kellerer open problem
remains unresolved by this artifact.
-/

/-! ## Component: SpectralRepair -/
noncomputable section Bundled_SpectralRepair
/-!
# Trace-optimal covariance repair in arbitrary real dimension

The index type indexes coordinates of a Euclidean space; it is not a finite
transport state space. The input matrix is an arbitrary real symmetric matrix.
All matrix inequalities below are actual positive-semidefinite inequalities.
-/


open scoped BigOperators Matrix

namespace SpectralRepair

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

def Feasible (B R : Matrix ι ι ℝ) : Prop :=
  R.PosSemidef ∧ (R - B).PosSemidef

def positivePart (B : Matrix ι ι ℝ) (hB : B.IsHermitian) : Matrix ι ι ℝ :=
  (hB.eigenvectorUnitary : Matrix ι ι ℝ) *
    Matrix.diagonal (fun i => max (hB.eigenvalues i) 0) *
      (hB.eigenvectorUnitary : Matrix ι ι ℝ)ᴴ

theorem diagonal_nonnegative {R : Matrix ι ι ℝ} (hR : R.PosSemidef) (i : ι) :
    0 ≤ R i i := by
  simpa using hR.2 (Pi.single i 1)

theorem trace_nonnegative {R : Matrix ι ι ℝ} (hR : R.PosSemidef) :
    0 ≤ Matrix.trace R := by
  exact Finset.sum_nonneg (fun i _ => diagonal_nonnegative hR i)

theorem trace_conjugate (U R : Matrix ι ι ℝ) (hU : Uᴴ * U = 1) :
    Matrix.trace (U * R * Uᴴ) = Matrix.trace R := by
  rw [Matrix.trace_mul_cycle, hU, one_mul]

theorem unitary_left (B : Matrix ι ι ℝ) (hB : B.IsHermitian) :
    (hB.eigenvectorUnitary : Matrix ι ι ℝ)ᴴ *
      (hB.eigenvectorUnitary : Matrix ι ι ℝ) = 1 := by
  exact unitary.coe_star_mul_self hB.eigenvectorUnitary

theorem unitary_right (B : Matrix ι ι ℝ) (hB : B.IsHermitian) :
    (hB.eigenvectorUnitary : Matrix ι ι ℝ) *
      (hB.eigenvectorUnitary : Matrix ι ι ℝ)ᴴ = 1 := by
  exact unitary.coe_mul_star_self hB.eigenvectorUnitary

theorem spectral_coordinates (B : Matrix ι ι ℝ) (hB : B.IsHermitian) :
    (hB.eigenvectorUnitary : Matrix ι ι ℝ)ᴴ * B *
      (hB.eigenvectorUnitary : Matrix ι ι ℝ) = Matrix.diagonal hB.eigenvalues := by
  simpa only [Matrix.star_eq_conjTranspose, RCLike.ofReal_real_eq_id, Function.id_comp]
    using hB.star_mul_self_mul_eq_diagonal

theorem spectral_representation (B : Matrix ι ι ℝ) (hB : B.IsHermitian) :
    B = (hB.eigenvectorUnitary : Matrix ι ι ℝ) * Matrix.diagonal hB.eigenvalues *
      (hB.eigenvectorUnitary : Matrix ι ι ℝ)ᴴ := by
  simpa only [Matrix.star_eq_conjTranspose, RCLike.ofReal_real_eq_id, Function.id_comp]
    using hB.spectral_theorem

theorem positivePart_psd (B : Matrix ι ι ℝ) (hB : B.IsHermitian) :
    (positivePart B hB).PosSemidef := by
  have hd : (Matrix.diagonal (fun i => max (hB.eigenvalues i) 0)).PosSemidef :=
    Matrix.PosSemidef.diagonal (fun i => le_max_right (hB.eigenvalues i) 0)
  exact hd.mul_mul_conjTranspose_same _

theorem positivePart_sub_psd (B : Matrix ι ι ℝ) (hB : B.IsHermitian) :
    (positivePart B hB - B).PosSemidef := by
  let U : Matrix ι ι ℝ := hB.eigenvectorUnitary
  let d : ι → ℝ := hB.eigenvalues
  have heq : positivePart B hB - B =
      U * Matrix.diagonal (fun i => max (d i) 0 - d i) * Uᴴ := by
    have hs : B = U * Matrix.diagonal d * Uᴴ := spectral_representation B hB
    calc
      positivePart B hB - B =
          U * Matrix.diagonal (fun i => max (d i) 0) * Uᴴ -
            U * Matrix.diagonal d * Uᴴ := by rw [← hs]; rfl
      _ = U * Matrix.diagonal (fun i => max (d i) 0 - d i) * Uᴴ := by
        rw [← Matrix.diagonal_sub, mul_sub, sub_mul]
  rw [heq]
  have hd : (Matrix.diagonal (fun i => max (d i) 0 - d i)).PosSemidef :=
    Matrix.PosSemidef.diagonal (fun i => sub_nonneg.mpr (le_max_left (d i) 0))
  exact hd.mul_mul_conjTranspose_same U

theorem positivePart_feasible (B : Matrix ι ι ℝ) (hB : B.IsHermitian) :
    Feasible B (positivePart B hB) :=
  ⟨positivePart_psd B hB, positivePart_sub_psd B hB⟩

theorem trace_positivePart (B : Matrix ι ι ℝ) (hB : B.IsHermitian) :
    Matrix.trace (positivePart B hB) = ∑ i, max (hB.eigenvalues i) 0 := by
  rw [positivePart, trace_conjugate _ _ (unitary_left B hB), Matrix.trace_diagonal]

theorem trace_lower_bound (B R : Matrix ι ι ℝ) (hB : B.IsHermitian)
    (hR : Feasible B R) :
    (∑ i, max (hB.eigenvalues i) 0) ≤ Matrix.trace R := by
  let U : Matrix ι ι ℝ := hB.eigenvectorUnitary
  let C : Matrix ι ι ℝ := Uᴴ * R * U
  have hC : C.PosSemidef := hR.1.conjTranspose_mul_mul_same U
  have hCB : (C - Matrix.diagonal hB.eigenvalues).PosSemidef := by
    have hp := hR.2.conjTranspose_mul_mul_same U
    have heq : Uᴴ * (R - B) * U = C - Matrix.diagonal hB.eigenvalues := by
      rw [mul_sub, sub_mul]
      change C - Uᴴ * B * U = C - Matrix.diagonal hB.eigenvalues
      rw [spectral_coordinates B hB]
    rwa [heq] at hp
  have hpoint : ∀ i, max (hB.eigenvalues i) 0 ≤ C i i := by
    intro i
    have h0 := diagonal_nonnegative hC i
    have h1 := diagonal_nonnegative hCB i
    simp only [Matrix.sub_apply, Matrix.diagonal_apply_eq] at h1
    exact max_le (by linarith) h0
  have htrace : Matrix.trace C = Matrix.trace R := by
    change Matrix.trace (Uᴴ * R * U) = Matrix.trace R
    rw [Matrix.trace_mul_cycle]
    have hu : U * Uᴴ = 1 := unitary_right B hB
    rw [hu, one_mul]
  calc
    (∑ i, max (hB.eigenvalues i) 0) ≤ Matrix.trace C :=
      Finset.sum_le_sum (fun i _ => hpoint i)
    _ = Matrix.trace R := htrace

/-- Exact minimum and an explicit spectral minimizer for every real dimension. -/
theorem trace_optimal_repair (B : Matrix ι ι ℝ) (hB : B.IsHermitian) :
    Feasible B (positivePart B hB) ∧
    Matrix.trace (positivePart B hB) = ∑ i, max (hB.eigenvalues i) 0 ∧
    ∀ R, Feasible B R → Matrix.trace (positivePart B hB) ≤ Matrix.trace R := by
  refine ⟨positivePart_feasible B hB, trace_positivePart B hB, ?_⟩
  intro R hR
  rw [trace_positivePart]
  exact trace_lower_bound B R hB hR

theorem zero_diagonal_forces_zero_column {R : Matrix ι ι ℝ} (hR : R.PosSemidef)
    (j : ι) (hj : R j j = 0) (i : ι) : R i j = 0 := by
  have hq : star (Pi.single j (1 : ℝ)) ⬝ᵥ R *ᵥ Pi.single j 1 = 0 := by
    simpa using hj
  have hz := (hR.dotProduct_mulVec_zero_iff (Pi.single j 1)).mp hq
  have hi := congrFun hz i
  simpa using hi

theorem diagonal_trace_unique (d : ι → ℝ) (C : Matrix ι ι ℝ)
    (hC : C.PosSemidef) (hCd : (C - Matrix.diagonal d).PosSemidef)
    (ht : Matrix.trace C = ∑ i, max (d i) 0) :
    C = Matrix.diagonal (fun i => max (d i) 0) := by
  have hpoint : ∀ i, max (d i) 0 ≤ C i i := by
    intro i
    have h0 := diagonal_nonnegative hC i
    have h1 := diagonal_nonnegative hCd i
    simp only [Matrix.sub_apply, Matrix.diagonal_apply_eq] at h1
    exact max_le (by linarith) h0
  have hsum : ∑ i, (C i i - max (d i) 0) = 0 := by
    rw [Finset.sum_sub_distrib]
    change Matrix.trace C - (∑ i, max (d i) 0) = 0
    rw [ht, sub_self]
  have hdiag : ∀ i, C i i = max (d i) 0 := by
    intro i
    have hz := (Finset.sum_eq_zero_iff_of_nonneg
      (fun j (_ : j ∈ Finset.univ) => sub_nonneg.mpr (hpoint j))).mp hsum
    exact sub_eq_zero.mp (hz i (Finset.mem_univ i))
  ext i j
  by_cases hij : i = j
  · subst j
    simpa using hdiag i
  · have hcij : C i j = 0 := by
      by_cases hd : d j ≤ 0
      · have hj : C j j = 0 := by rw [hdiag j, max_eq_right hd]
        exact zero_diagonal_forces_zero_column hC j hj i
      · have hd' : 0 ≤ d j := le_of_lt (lt_of_not_ge hd)
        have hj : (C - Matrix.diagonal d) j j = 0 := by
          simp only [Matrix.sub_apply, Matrix.diagonal_apply_eq, hdiag j,
            max_eq_left hd', sub_self]
        have hz := zero_diagonal_forces_zero_column hCd j hj i
        simpa [Matrix.sub_apply, Matrix.diagonal, hij] using hz
    simpa [Matrix.diagonal, hij] using hcij

/-- Among feasible covariance corrections, the trace minimizer is unique. -/
theorem trace_minimizer_unique (B R : Matrix ι ι ℝ) (hB : B.IsHermitian)
    (hR : Feasible B R)
    (ht : Matrix.trace R = Matrix.trace (positivePart B hB)) :
    R = positivePart B hB := by
  let U : Matrix ι ι ℝ := hB.eigenvectorUnitary
  let C : Matrix ι ι ℝ := Uᴴ * R * U
  have hC : C.PosSemidef := hR.1.conjTranspose_mul_mul_same U
  have hCB : (C - Matrix.diagonal hB.eigenvalues).PosSemidef := by
    have hp := hR.2.conjTranspose_mul_mul_same U
    have heq : Uᴴ * (R - B) * U = C - Matrix.diagonal hB.eigenvalues := by
      rw [mul_sub, sub_mul]
      change C - Uᴴ * B * U = C - Matrix.diagonal hB.eigenvalues
      rw [spectral_coordinates B hB]
    rwa [heq] at hp
  have htrace : Matrix.trace C = ∑ i, max (hB.eigenvalues i) 0 := by
    change Matrix.trace (Uᴴ * R * U) = _
    rw [Matrix.trace_mul_cycle]
    have hu : U * Uᴴ = 1 := unitary_right B hB
    rw [hu, one_mul, ht, trace_positivePart]
  have hCeq := diagonal_trace_unique hB.eigenvalues C hC hCB htrace
  have hu : U * Uᴴ = 1 := unitary_right B hB
  have hrec : U * C * Uᴴ = R := by
    change U * (Uᴴ * R * U) * Uᴴ = R
    calc
      _ = (U * Uᴴ) * R * (U * Uᴴ) := by simp only [Matrix.mul_assoc]
      _ = R := by rw [hu, one_mul, mul_one]
  calc
    R = U * C * Uᴴ := hrec.symm
    _ = positivePart B hB := by rw [hCeq]; rfl

theorem trace_equality_iff (B R : Matrix ι ι ℝ) (hB : B.IsHermitian)
    (hR : Feasible B R) :
    Matrix.trace R = (∑ i, max (hB.eigenvalues i) 0) ↔ R = positivePart B hB := by
  constructor
  · intro h
    apply trace_minimizer_unique B R hB hR
    rw [h, trace_positivePart]
  · intro h
    rw [h, trace_positivePart]

end SpectralRepair

end Bundled_SpectralRepair

/-! ## Component: IntegratedRepair -/
noncomputable section Bundled_IntegratedRepair
/-!
# Integrated optimal covariance repair

The index space below is an arbitrary measurable space carrying an arbitrary
measure, in particular a real time interval with Lebesgue measure. The finite
index type indexes Euclidean coordinates, not time points or transport states.
The inequalities follow from the fully proved spectral repair theorem rather
than taking pointwise optimality as an assumption.
-/


open MeasureTheory
open scoped BigOperators

namespace IntegratedRepair

variable {ι T : Type*} [Fintype ι] [DecidableEq ι] [MeasurableSpace T]

/-- A pointwise spectral minimizer minimizes every integrable trace cost. -/
theorem integral_trace_minimum
    (ν : Measure T) (B R : T → Matrix ι ι ℝ)
    (hB : ∀ t, (B t).IsHermitian)
    (hfeas : ∀ᵐ t ∂ν, SpectralRepair.Feasible (B t) (R t))
    (hoptInt : Integrable (fun t => Matrix.trace (SpectralRepair.positivePart (B t) (hB t))) ν)
    (hRInt : Integrable (fun t => Matrix.trace (R t)) ν) :
    (∫ t, Matrix.trace (SpectralRepair.positivePart (B t) (hB t)) ∂ν) ≤
      ∫ t, Matrix.trace (R t) ∂ν := by
  apply integral_mono_ae hoptInt hRInt
  filter_upwards [hfeas] with t ht
  exact (SpectralRepair.trace_optimal_repair (B t) (hB t)).2.2 (R t) ht

/-- Equality of integrated costs is equivalent to almost-everywhere equality
with the spectral correction, with no finiteness assumption on the time space. -/
theorem integral_trace_equality_iff
    (ν : Measure T) (B R : T → Matrix ι ι ℝ)
    (hB : ∀ t, (B t).IsHermitian)
    (hfeas : ∀ᵐ t ∂ν, SpectralRepair.Feasible (B t) (R t))
    (hoptInt : Integrable (fun t => Matrix.trace (SpectralRepair.positivePart (B t) (hB t))) ν)
    (hRInt : Integrable (fun t => Matrix.trace (R t)) ν) :
    (∫ t, Matrix.trace (R t) ∂ν) =
        (∫ t, Matrix.trace (SpectralRepair.positivePart (B t) (hB t)) ∂ν) ↔
      ∀ᵐ t ∂ν, R t = SpectralRepair.positivePart (B t) (hB t) := by
  have hle : (fun t => Matrix.trace (SpectralRepair.positivePart (B t) (hB t))) ≤ᵐ[ν]
      (fun t => Matrix.trace (R t)) := by
    filter_upwards [hfeas] with t ht
    exact (SpectralRepair.trace_optimal_repair (B t) (hB t)).2.2 (R t) ht
  constructor
  · intro heq
    have htr := (integral_eq_iff_of_ae_le hoptInt hRInt hle).mp heq.symm
    filter_upwards [hfeas, htr] with t ht he
    exact SpectralRepair.trace_minimizer_unique (B t) (R t) (hB t) ht he.symm
  · intro heq
    apply integral_congr_ae
    filter_upwards [heq] with t ht
    rw [ht]

/-- Initial covariance and running covariance corrections have a joint exact
minimum; both corrections are abstract real matrices. -/
theorem initial_plus_running_minimum
    (ν : Measure T) (B0 R0 : Matrix ι ι ℝ) (hB0 : B0.IsHermitian)
    (hR0 : SpectralRepair.Feasible B0 R0)
    (B R : T → Matrix ι ι ℝ) (hB : ∀ t, (B t).IsHermitian)
    (hfeas : ∀ᵐ t ∂ν, SpectralRepair.Feasible (B t) (R t))
    (hoptInt : Integrable (fun t => Matrix.trace (SpectralRepair.positivePart (B t) (hB t))) ν)
    (hRInt : Integrable (fun t => Matrix.trace (R t)) ν) :
    Matrix.trace (SpectralRepair.positivePart B0 hB0) +
        (∫ t, Matrix.trace (SpectralRepair.positivePart (B t) (hB t)) ∂ν) ≤
      Matrix.trace R0 + ∫ t, Matrix.trace (R t) ∂ν := by
  exact add_le_add
    ((SpectralRepair.trace_optimal_repair B0 hB0).2.2 R0 hR0)
    (integral_trace_minimum ν B R hB hfeas hoptInt hRInt)

/-- Uniqueness of the minimum initial-and-running cost, modulo null times. -/
theorem initial_plus_running_equality_iff
    (ν : Measure T) (B0 R0 : Matrix ι ι ℝ) (hB0 : B0.IsHermitian)
    (hR0 : SpectralRepair.Feasible B0 R0)
    (B R : T → Matrix ι ι ℝ) (hB : ∀ t, (B t).IsHermitian)
    (hfeas : ∀ᵐ t ∂ν, SpectralRepair.Feasible (B t) (R t))
    (hoptInt : Integrable (fun t => Matrix.trace (SpectralRepair.positivePart (B t) (hB t))) ν)
    (hRInt : Integrable (fun t => Matrix.trace (R t)) ν) :
    Matrix.trace R0 + (∫ t, Matrix.trace (R t) ∂ν) =
        Matrix.trace (SpectralRepair.positivePart B0 hB0) +
          (∫ t, Matrix.trace (SpectralRepair.positivePart (B t) (hB t)) ∂ν) ↔
      R0 = SpectralRepair.positivePart B0 hB0 ∧
        ∀ᵐ t ∂ν, R t = SpectralRepair.positivePart (B t) (hB t) := by
  constructor
  · intro heq
    have h0 := (SpectralRepair.trace_optimal_repair B0 hB0).2.2 R0 hR0
    have h1 := integral_trace_minimum ν B R hB hfeas hoptInt hRInt
    have heq0 : Matrix.trace R0 = Matrix.trace (SpectralRepair.positivePart B0 hB0) := by
      linarith
    have heq1 : (∫ t, Matrix.trace (R t) ∂ν) =
        ∫ t, Matrix.trace (SpectralRepair.positivePart (B t) (hB t)) ∂ν := by
      linarith
    exact ⟨SpectralRepair.trace_minimizer_unique B0 R0 hB0 hR0 heq0,
      (integral_trace_equality_iff ν B R hB hfeas hoptInt hRInt).mp heq1⟩
  · rintro ⟨heq0, heq1⟩
    rw [heq0, (integral_trace_equality_iff ν B R hB hfeas hoptInt hRInt).mpr heq1]

end IntegratedRepair

end Bundled_IntegratedRepair

/-! ## Component: NoLeastRepair -/
noncomputable section Bundled_NoLeastRepair
/-!
# A parameterized obstruction to a least covariance repair

For every nonzero real p and q, there is no least positive semidefinite
matrix R satisfying R >= diag(p^2,-2*q^2), in the Loewner order.
Both displayed feasible repairs are verified by polynomial square identities.
These matrices are covariance rates for continuous Gaussian state spaces;
their size is not a finite-state approximation of a stochastic process.
-/

namespace NoLeastRepair

open Matrix
open scoped Matrix

abbrev Mat := Matrix (Fin 2) (Fin 2) ℝ

def defect (p q : ℝ) : Mat := !![p^2, 0; 0, -2*q^2]
def diagonalRepair (p : ℝ) : Mat := !![p^2, 0; 0, 0]
def obliqueRepair (p q : ℝ) : Mat := !![2*p^2, 2*p*q; 2*p*q, 2*q^2]

def Feasible (p q : ℝ) (R : Mat) : Prop :=
  R.PosSemidef ∧ (R - defect p q).PosSemidef

theorem diagonal_feasible (p q : ℝ) : Feasible p q (diagonalRepair p) := by
  constructor
  · constructor
    · change (diagonalRepair p)ᴴ = diagonalRepair p
      ext i j
      fin_cases i <;> fin_cases j <;> simp [diagonalRepair]
    · intro v
      have hid : star v ⬝ᵥ diagonalRepair p *ᵥ v = (p * v 0)^2 := by
        simp [diagonalRepair, dotProduct, Matrix.mulVec, Fin.sum_univ_two]
        ring
      rw [hid]
      exact sq_nonneg _
  · constructor
    · change (diagonalRepair p - defect p q)ᴴ = diagonalRepair p - defect p q
      ext i j
      fin_cases i <;> fin_cases j <;> simp [diagonalRepair, defect]
    · intro v
      have hid : star v ⬝ᵥ (diagonalRepair p - defect p q) *ᵥ v =
          2 * (q * v 1)^2 := by
        simp [diagonalRepair, defect, dotProduct, Matrix.mulVec, Fin.sum_univ_two]
        ring
      rw [hid]
      positivity

theorem oblique_feasible (p q : ℝ) : Feasible p q (obliqueRepair p q) := by
  constructor
  · constructor
    · change (obliqueRepair p q)ᴴ = obliqueRepair p q
      ext i j
      fin_cases i <;> fin_cases j <;> simp [obliqueRepair]
    · intro v
      have hid : star v ⬝ᵥ obliqueRepair p q *ᵥ v =
          2 * (p * v 0 + q * v 1)^2 := by
        simp [obliqueRepair, dotProduct, Matrix.mulVec, Fin.sum_univ_two]
        ring
      rw [hid]
      positivity
  · constructor
    · change (obliqueRepair p q - defect p q)ᴴ = obliqueRepair p q - defect p q
      ext i j
      fin_cases i <;> fin_cases j <;> simp [obliqueRepair, defect]
    · intro v
      have hid : star v ⬝ᵥ (obliqueRepair p q - defect p q) *ᵥ v =
          (p * v 0 + 2 * q * v 1)^2 := by
        simp [obliqueRepair, defect, dotProduct, Matrix.mulVec, Fin.sum_univ_two]
        ring
      rw [hid]
      exact sq_nonneg _

theorem psd_diag_nonneg (R : Mat) (hR : R.PosSemidef) (i : Fin 2) :
    0 ≤ R i i := by
  simpa using hR.2 (Pi.single i 1)

theorem below_diagonal_forces_eq (p q : ℝ) (R : Mat)
    (hR : Feasible p q R)
    (hbelow : (diagonalRepair p - R).PosSemidef) : R = diagonalRepair p := by
  have h11nonneg : 0 ≤ R 1 1 := psd_diag_nonneg R hR.1 1
  have h11le : R 1 1 ≤ 0 := by
    have hh := psd_diag_nonneg _ hbelow 1
    simpa [diagonalRepair] using hh
  have h11 : R 1 1 = 0 := le_antisymm h11le h11nonneg
  have hquad : star (Pi.single (1 : Fin 2) (1 : ℝ)) ⬝ᵥ
      R *ᵥ Pi.single (1 : Fin 2) (1 : ℝ) = 0 := by
    simpa using h11
  have hcol : R *ᵥ Pi.single (1 : Fin 2) (1 : ℝ) = 0 :=
    (hR.1.dotProduct_mulVec_zero_iff _).mp hquad
  have h01 : R 0 1 = 0 := by
    simpa using congrFun hcol (0 : Fin 2)
  have h10 : R 1 0 = 0 := by
    have hh := congrArg (fun M : Mat => M 0 1) hR.1.1
    simpa [h01] using hh
  have h00ge : p^2 ≤ R 0 0 := by
    have hh := psd_diag_nonneg _ hR.2 0
    simpa [defect] using hh
  have h00le : R 0 0 ≤ p^2 := by
    have hh := psd_diag_nonneg _ hbelow 0
    simpa [diagonalRepair] using hh
  have h00 : R 0 0 = p^2 := le_antisymm h00le h00ge
  ext i j
  fin_cases i <;> fin_cases j <;> simp [diagonalRepair, h00, h01, h10, h11]

theorem diagonal_not_below_oblique (p q : ℝ) (hp : p ≠ 0) (hq : q ≠ 0) :
    ¬ (obliqueRepair p q - diagonalRepair p).PosSemidef := by
  intro h
  have hh := h.2 ![q, -p]
  have hid : star ![q, -p] ⬝ᵥ (obliqueRepair p q - diagonalRepair p) *ᵥ ![q, -p] =
      -(p * q)^2 := by
    simp [obliqueRepair, diagonalRepair, dotProduct, Matrix.mulVec, Fin.sum_univ_two]
    ring
  rw [hid] at hh
  have hpos : 0 < (p*q)^2 := sq_pos_of_ne_zero (mul_ne_zero hp hq)
  linarith

/-- In contrast to the absent order minimum, the trace has a unique minimizer. -/
theorem trace_lower_bound (p q : ℝ) (R : Mat) (hR : Feasible p q R) :
    p^2 ≤ Matrix.trace R := by
  have h0 : p^2 ≤ R 0 0 := by
    have hh := psd_diag_nonneg _ hR.2 0
    simpa [defect] using hh
  have h1 : 0 ≤ R 1 1 := psd_diag_nonneg R hR.1 1
  simp only [Matrix.trace, Matrix.diag, Fin.sum_univ_two]
  linarith

theorem trace_equality_iff (p q : ℝ) (R : Mat) (hR : Feasible p q R) :
    Matrix.trace R = p^2 ↔ R = diagonalRepair p := by
  constructor
  · intro ht
    have h0 : p^2 ≤ R 0 0 := by
      have hh := psd_diag_nonneg _ hR.2 0
      simpa [defect] using hh
    have h1 : 0 ≤ R 1 1 := psd_diag_nonneg R hR.1 1
    simp only [Matrix.trace, Matrix.diag, Fin.sum_univ_two] at ht
    have h11 : R 1 1 = 0 := by linarith
    have h00 : R 0 0 = p^2 := by linarith
    have hquad : star (Pi.single (1 : Fin 2) (1 : ℝ)) ⬝ᵥ
        R *ᵥ Pi.single (1 : Fin 2) (1 : ℝ) = 0 := by
      simpa using h11
    have hcol : R *ᵥ Pi.single (1 : Fin 2) (1 : ℝ) = 0 :=
      (hR.1.dotProduct_mulVec_zero_iff _).mp hquad
    have h01 : R 0 1 = 0 := by
      simpa using congrFun hcol (0 : Fin 2)
    have h10 : R 1 0 = 0 := by
      have hh := congrArg (fun M : Mat => M 0 1) hR.1.1
      simpa [h01] using hh
    ext i j
    fin_cases i <;> fin_cases j <;> simp [diagonalRepair, h00, h01, h10, h11]
  · rintro rfl
    simp [Matrix.trace, Matrix.diag, diagonalRepair, Fin.sum_univ_two]

/-- A strictly elliptic original Gaussian covariance rate may still need an
anisotropic repair to reach a larger prescribed ellipticity threshold. -/
def originalCovarianceRate (lambda p q : ℝ) : Mat :=
  !![lambda - p^2, 0; 0, lambda + 2*q^2]

theorem original_rate_posDef (lambda p q : ℝ) (hlambda : p^2 < lambda) :
    (originalCovarianceRate lambda p q).PosDef := by
  constructor
  · change (originalCovarianceRate lambda p q)ᴴ = originalCovarianceRate lambda p q
    ext i j
    fin_cases i <;> fin_cases j <;> simp [originalCovarianceRate]
  · intro v hv
    have h0 : 0 < lambda - p^2 := sub_pos.mpr hlambda
    have h1 : 0 < lambda + 2*q^2 := by nlinarith [sq_nonneg p, sq_nonneg q]
    have hid : star v ⬝ᵥ originalCovarianceRate lambda p q *ᵥ v =
        (lambda - p^2)*(v 0)^2 + (lambda + 2*q^2)*(v 1)^2 := by
      simp [originalCovarianceRate, dotProduct, Matrix.mulVec, Fin.sum_univ_two]
      ring
    rw [hid]
    by_cases hv0 : v 0 = 0
    · have hv1 : v 1 ≠ 0 := by
        intro h
        apply hv
        ext i
        fin_cases i <;> simp [hv0, h]
      have hs : 0 < (v 1)^2 := sq_pos_of_ne_zero hv1
      nlinarith [mul_pos h1 hs]
    · have hs : 0 < (v 0)^2 := sq_pos_of_ne_zero hv0
      have hn : 0 ≤ (lambda + 2*q^2)*(v 1)^2 := mul_nonneg h1.le (sq_nonneg _)
      linarith [mul_pos h0 hs]

theorem ellipticity_repair_identity (lambda p q : ℝ) (R : Mat) :
    originalCovarianceRate lambda p q + R - lambda • (1 : Mat) =
      R - defect p q := by
  ext i j
  fin_cases i <;> fin_cases j <;> simp [originalCovarianceRate, defect] <;> ring

/-- The algebraic repair problem is exactly the prescribed ellipticity problem. -/
theorem ellipticity_repair_iff (lambda p q : ℝ) (R : Mat) :
    (R.PosSemidef ∧
      (originalCovarianceRate lambda p q + R - lambda • (1 : Mat)).PosSemidef) ↔
      Feasible p q R := by
  rw [ellipticity_repair_identity]
  rfl

/-- The feasible covariance repairs have no least element in Loewner order. -/
theorem no_least_covariance_repair (p q : ℝ) (hp : p ≠ 0) (hq : q ≠ 0) :
    ¬ ∃ R : Mat, Feasible p q R ∧
      ∀ S : Mat, Feasible p q S → (S - R).PosSemidef := by
  rintro ⟨R, hR, hleast⟩
  have heq : R = diagonalRepair p :=
    below_diagonal_forces_eq p q R hR (hleast _ (diagonal_feasible p q))
  have hh := hleast _ (oblique_feasible p q)
  rw [heq] at hh
  exact diagonal_not_below_oblique p q hp hq hh

end NoLeastRepair

end Bundled_NoLeastRepair

/-! ## Kernel dependency audit -/
#print axioms SpectralRepair.trace_optimal_repair
#print axioms SpectralRepair.trace_minimizer_unique
#print axioms SpectralRepair.trace_equality_iff
#print axioms IntegratedRepair.integral_trace_minimum
#print axioms IntegratedRepair.integral_trace_equality_iff
#print axioms IntegratedRepair.initial_plus_running_minimum
#print axioms IntegratedRepair.initial_plus_running_equality_iff
#print axioms NoLeastRepair.no_least_covariance_repair
#print axioms NoLeastRepair.trace_equality_iff
#print axioms NoLeastRepair.original_rate_posDef
#print axioms NoLeastRepair.ellipticity_repair_iff
