import Mathlib

/-!
Round 03: algebraic certificates for the adaptive Gaussian schedule.
This source is supplied for Lean 4.19.0 / Mathlib v4.19.0.
It has not been compiled in the environment that prepared this round.
No probabilistic or stochastic-process theorem is represented by these
scalar lemmas. The mathematical lifting is in ENTRANCE_THEOREMS.md.
-/

namespace EntranceCore

theorem young_product_bound (a b : ℝ) :
    a * b ≤ (a ^ 2 + b ^ 2) / 2 := by
  nlinarith [sq_nonneg (a - b)]

theorem logarithmic_schedule_exponent (a u : ℝ) (hu : 0 ≤ u) :
    a * Real.sqrt (1 + u) - u ≤ (1 + a ^ 2) / 2 - u / 2 := by
  have h : 0 ≤ 1 + u := by linarith
  have hsq := Real.sq_sqrt h
  have hy := young_product_bound a (Real.sqrt (1 + u))
  rw [hsq] at hy
  linarith

theorem logarithmic_schedule_exp (a u : ℝ) (hu : 0 ≤ u) :
    Real.exp (a * Real.sqrt (1 + u) - u) ≤
      Real.exp ((1 + a ^ 2) / 2) * Real.exp (-u / 2) := by
  rw [← Real.exp_add]
  apply Real.exp_le_exp.mpr
  linarith only [logarithmic_schedule_exponent a u hu]

theorem sqrt_le_linear (u : ℝ) (hu : 0 ≤ u) :
    Real.sqrt (1 + u) ≤ 1 + u := by
  have h : 0 ≤ 1 + u := by linarith
  have hsq := Real.sq_sqrt h
  have hnon := Real.sqrt_nonneg (1 + u)
  by_contra! hbad
  have hp := mul_pos (sub_pos.mpr hbad)
    (show 0 < Real.sqrt (1 + u) + (1 + u) by linarith)
  have hu2 := mul_nonneg hu h
  nlinarith only [hsq, hp, hu2]

theorem logarithmic_integrand_bound (a u eta : ℝ)
    (hu : 0 ≤ u) (heta : 0 < eta) :
    (1 + Real.sqrt (1 + u) / eta) *
      Real.exp (a * Real.sqrt (1 + u) - u) ≤
    (1 + (1 + u) / eta) *
      (Real.exp ((1 + a ^ 2) / 2) * Real.exp (-u / 2)) := by
  have hdiv : Real.sqrt (1 + u) / eta ≤ (1 + u) / eta :=
    div_le_div_of_nonneg_right (sqrt_le_linear u hu) (le_of_lt heta)
  have hleft : 0 ≤ 1 + Real.sqrt (1 + u) / eta := by positivity
  have hexp := logarithmic_schedule_exp a u hu
  have hright : 0 ≤ Real.exp ((1 + a ^ 2) / 2) * Real.exp (-u / 2) := by positivity
  calc
    _ ≤ (1 + Real.sqrt (1 + u) / eta) *
        (Real.exp ((1 + a ^ 2) / 2) * Real.exp (-u / 2)) :=
      mul_le_mul_of_nonneg_left hexp hleft
    _ ≤ _ := mul_le_mul_of_nonneg_right (by linarith) hright

theorem zero_increasing_cost (a b : ℝ) (ha : 0 ≤ a)
    (hab : a ≤ b) (hb : b = 0) : a = 0 := by
  linarith

theorem quantitative_defect_bound (defect L energy : ℝ)
    (hd : 0 < defect) (hL : 0 ≤ L) (he : 0 ≤ energy)
    (h : defect ≤ L ^ 2 * energy) :
    Real.sqrt defect ≤ L * Real.sqrt energy := by
  have h1 := Real.sq_sqrt (le_of_lt hd)
  have h2 := Real.sq_sqrt he
  have hn2 : 0 ≤ L * Real.sqrt energy := by positivity
  have hsq : (Real.sqrt defect) ^ 2 ≤ (L * Real.sqrt energy) ^ 2 := by
    rw [h1, mul_pow, h2]
    exact h
  by_contra! hbad
  have hs : 0 < Real.sqrt defect + L * Real.sqrt energy := by linarith
  have hp := mul_pos (sub_pos.mpr hbad) hs
  nlinarith only [hp, hsq]

#print axioms young_product_bound
#print axioms logarithmic_schedule_exp
#print axioms logarithmic_integrand_bound
#print axioms zero_increasing_cost
#print axioms quantitative_defect_bound

end EntranceCore
