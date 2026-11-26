import Mathlib

/-!
Round 06: scalar certificates for the universal energy-clock criterion.
Target Lean 4.19.0 / Mathlib v4.19.0. Uncompiled candidate.
These lemmas do not formalize the weak Poincare inequality, integration,
Fokker--Planck equation, martingale representation or germ lifting.
-/

namespace CriterionCore

theorem dyadic_ratio_bounds (a t qa qt qb : ℝ)
    (ha : 0 < a) (hat : a ≤ t) (htb : t ≤ 2 * a)
    (hqa : 0 ≤ qa) (hq1 : qa ≤ qt) (hq2 : qt ≤ qb) :
    qa / (2 * a) ≤ qt / t ∧ qt / t ≤ qb / a := by
  have htp : 0 < t := lt_of_lt_of_le ha hat
  have ha2 : 0 < 2 * a := by positivity
  constructor
  · apply (div_le_div_iff₀ ha2 htp).2
    have h1 := mul_le_mul_of_nonneg_left htb hqa
    have h2 := mul_le_mul_of_nonneg_right hq1 (le_of_lt ha2)
    nlinarith only [h1, h2]
  · apply (div_le_div_iff₀ htp ha).2
    have hqb : 0 ≤ qb := hqa.trans (hq1.trans hq2)
    have h1 := mul_le_mul_of_nonneg_right hq2 (le_of_lt ha)
    have h2 := mul_le_mul_of_nonneg_left hat hqb
    nlinarith only [h1, h2]

theorem clock_identity (q dq t : ℝ) (ht : t ≠ 0) :
    dq / t = (dq * t - q) / t ^ 2 + (q / t) / t := by
  field_simp [ht] <;> ring

theorem exp_neg_inv_le (r : ℝ) (hr : 0 < r) :
    Real.exp (-(1 / r)) ≤ r := by
  have hh := Real.add_one_le_exp (1 / r)
  have he : 1 / r ≤ Real.exp (1 / r) := by linarith
  have hmul := mul_le_mul_of_nonneg_left he (le_of_lt hr)
  have hcancel : r * (1 / r) = 1 := by
    field_simp [ne_of_gt hr]
  rw [hcancel] at hmul
  have hprod := mul_le_mul_of_nonneg_right hmul
    (le_of_lt (Real.exp_pos (-(1 / r))))
  calc
    Real.exp (-(1 / r)) = 1 * Real.exp (-(1 / r)) := by ring
    _ ≤ (r * Real.exp (1 / r)) * Real.exp (-(1 / r)) := hprod
    _ = r := by rw [mul_assoc, ← Real.exp_add, add_neg_cancel, Real.exp_zero, mul_one]

theorem exponential_absorption (C r : ℝ) (hr : 0 < r) :
    Real.exp (-(C + 1) / r) ≤ r * Real.exp (-C / r) := by
  have he : -(C + 1) / r = -(1 / r) + (-C / r) := by ring
  rw [he, Real.exp_add]
  exact mul_le_mul_of_nonneg_right (exp_neg_inv_le r hr)
    (le_of_lt (Real.exp_pos _))

theorem variance_to_energy (D D0 tail A E : ℝ)
    (hD : D0 ≤ D) (htail : tail ≤ D0 / 2)
    (hweak : D ≤ tail + A * E) : D0 / 2 ≤ A * E := by
  linarith

theorem rare_energy (p a b : ℝ) (hp : p ≠ 0) :
    p * (a / (2 * p) + b / (2 * p)) = (a + b) / 2 := by
  field_simp [hp] <;> ring

theorem rare_separation (s p b : ℝ)
    (hs : 0 ≤ s) (hp : 0 < p) (hb : 0 ≤ b)
    (hbt : s / (12 * p) ≤ b ^ 2) :
    3 * (Real.sqrt (s / p) / 16) ≤ b := by
  have hsp : 0 ≤ s / p := div_nonneg hs (le_of_lt hp)
  have hsq := Real.sq_sqrt hsp
  have hsn := Real.sqrt_nonneg (s / p)
  have he : s / (12 * p) = (s / p) / 12 := by ring
  rw [he] at hbt
  by_contra! hbad
  have hpos : 0 < 3 * (Real.sqrt (s / p) / 16) + b := by linarith
  have hprod := mul_pos (sub_pos.mpr hbad) hpos
  nlinarith only [hprod, hbt, hsq, hsp]

theorem rare_germ_not_independent (p : ℝ) (hp : 0 < p) (hp1 : p < 1) :
    p ≠ p * p := by
  intro he
  nlinarith only [mul_pos hp (sub_pos.mpr hp1), he]

theorem gaussian_threshold_exponent (s p r : ℝ) (hp : p ≠ 0) (hr : r ≠ 0) :
    (s / (256 * p) / 4) / (2 * r) = s / (2048 * p * r) := by
  field_simp [hp, hr] <;> ring

#print axioms dyadic_ratio_bounds
#print axioms clock_identity
#print axioms exp_neg_inv_le
#print axioms exponential_absorption
#print axioms variance_to_energy
#print axioms rare_energy
#print axioms rare_separation
#print axioms rare_germ_not_independent
#print axioms gaussian_threshold_exponent

end CriterionCore
