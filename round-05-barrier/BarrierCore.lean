import Mathlib

/-!
Round 05: deterministic barriers for the separated-axis construction.
Target: Lean 4.19.0 / Mathlib v4.19.0.
Uncompiled candidate. These are real scalar lemmas, not a formal proof
of the continuous-space stochastic-process theorem.
-/

namespace BarrierCore

def payoff (h x : ℝ) : ℝ := max (|x| - h) 0
def slope (h x : ℝ) : ℝ :=
  if h < x then 1 else if x < -h then -1 else 0
def gap (h u v : ℝ) : ℝ :=
  payoff h u - payoff h v - slope h v * (u - v)

theorem payoff_inside (h x : ℝ) (hx : |x| ≤ h) :
    payoff h x = 0 := by
  exact max_eq_right (sub_nonpos.mpr hx)

theorem payoff_right (h x : ℝ) (hh : 0 ≤ h) (hx : h < x) :
    payoff h x = x - h := by
  have hx0 : 0 ≤ x := by linarith
  have hx1 : 0 ≤ x - h := by linarith
  simp [payoff, abs_of_nonneg hx0, max_eq_left hx1]

theorem payoff_left (h x : ℝ) (hh : 0 ≤ h) (hx : x < -h) :
    payoff h x = -x - h := by
  have hx0 : x ≤ 0 := by linarith
  have hx1 : 0 ≤ -x - h := by linarith
  simp [payoff, abs_of_nonpos hx0, max_eq_left hx1]

theorem payoff_add_upper (h m g : ℝ) :
    payoff h (m + g) ≤ payoff h m + |g| := by
  have ht : |m + g| ≤ |m| + |g| := abs_add_le _ _
  have hl : |m| - h ≤ payoff h m := le_max_left _ _
  have hz : 0 ≤ payoff h m := le_max_right _ _
  have hg := abs_nonneg g
  change max (|m + g| - h) 0 ≤ payoff h m + |g|
  exact max_le (by linarith) (by linarith)

theorem gap_nonneg (h u v : ℝ) (hh : 0 ≤ h) :
    0 ≤ gap h u v := by
  have hl : |u| - h ≤ payoff h u := le_max_left _ _
  have hz : 0 ≤ payoff h u := le_max_right _ _
  have hup : u ≤ |u| := le_abs_self u
  have hun : -u ≤ |u| := neg_le_abs u
  by_cases hp : h < v
  · simp only [gap, slope, if_pos hp, payoff_right h v hh hp, one_mul]
    linarith
  · by_cases hm : v < -h
    · simp only [gap, slope, if_neg hp, if_pos hm, payoff_left h v hh hm]
      linarith
    · have hv : |v| ≤ h := abs_le.mpr ⟨le_of_not_gt hm, le_of_not_gt hp⟩
      simp only [gap, slope, if_neg hp, if_neg hm, payoff_inside h v hv,
        zero_mul, sub_zero]
      exact hz

theorem gap_add_upper (h m g : ℝ) :
    gap h (m + g) m ≤ 2 * |g| := by
  have hpay := payoff_add_upper h m g
  have hp : g ≤ |g| := le_abs_self g
  have hm : -g ≤ |g| := neg_le_abs g
  have hdiff : m + g - m = g := by ring
  by_cases hr : h < m
  · simp only [gap, slope, if_pos hr, hdiff, one_mul]
    linarith
  · by_cases hl : m < -h
    · simp only [gap, slope, if_neg hr, if_pos hl, hdiff]
      linarith
    · simp only [gap, slope, if_neg hr, if_neg hl, hdiff, zero_mul, sub_zero]
      linarith [abs_nonneg g]

theorem barrier_no_loss (h m g : ℝ) (hh : 0 < h)
    (hm : m = 0 ∨ 3 * h ≤ |m|) (hg : |g| ≤ h) :
    gap h (m + g) m = 0 := by
  rcases hm with rfl | hm
  · have h0 : |(0 : ℝ)| ≤ h := by simpa using le_of_lt hh
    have hp : ¬ h < (0 : ℝ) := by linarith
    have hn : ¬ (0 : ℝ) < -h := by linarith
    simp only [gap, zero_add, payoff_inside h g hg, payoff_inside h 0 h0,
      slope, if_neg hp, if_neg hn, zero_mul, sub_zero]
  · by_cases hm0 : 0 ≤ m
    · rw [abs_of_nonneg hm0] at hm
      have hr : h < m := by linarith
      have hr2 : h < m + g := by linarith [(abs_le.mp hg).1]
      simp only [gap, slope, if_pos hr, payoff_right h m (le_of_lt hh) hr,
        payoff_right h (m + g) (le_of_lt hh) hr2, one_mul]
      ring
    · have hmle : m ≤ 0 := by linarith [lt_of_not_ge hm0]
      rw [abs_of_nonpos hmle] at hm
      have hr : ¬ h < m := by linarith
      have hl : m < -h := by linarith
      have hl2 : m + g < -h := by linarith [(abs_le.mp hg).2]
      simp only [gap, slope, if_neg hr, if_pos hl, payoff_left h m (le_of_lt hh) hl,
        payoff_left h (m + g) (le_of_lt hh) hl2]
      ring

theorem barrier_envelope (h m g : ℝ) (hh : 0 < h)
    (hm : m = 0 ∨ 3 * h ≤ |m|) :
    0 ≤ gap h (m + g) m ∧
      gap h (m + g) m ≤ (if h < |g| then 2 * |g| else 0) := by
  refine ⟨gap_nonneg h (m + g) m (le_of_lt hh), ?_⟩
  by_cases hg : h < |g|
  · simpa only [if_pos hg] using gap_add_upper h m g
  · rw [if_neg hg, barrier_no_loss h m g hh hm (le_of_not_gt hg)]

theorem active_far (h m g : ℝ) (hh : 0 < h)
    (hm : 3 * h ≤ |m|) (hg : |g| ≤ h / 2) :
    2 * h < |m + g| := by
  have ht := abs_add_le (m + g) (-g)
  have he : m + g + -g = m := by ring
  rw [he, abs_neg] at ht
  linarith

theorem classifier_separation (h k m g : ℝ) (hh : 0 < h)
    (hk0 : h / 2 ≤ k) (hk1 : k ≤ h)
    (hm : m = 0 ∨ 3 * h ≤ |m|) (hg : |g| ≤ h / 2) :
    |m + g| ≤ k ↔ m = 0 := by
  rcases hm with rfl | hm
  · constructor
    · intro _
      rfl
    · intro _
      simpa only [zero_add] using le_trans hg hk0
  · have hf := active_far h m g hh hm hg
    constructor
    · intro hbad
      linarith
    · intro hbad
      rw [hbad, abs_zero] at hm
      linarith

theorem active_scale (t b : ℝ) (ht : 0 ≤ t) (hb : 0 ≤ b)
    (hbt : t / 6 ≤ b ^ 2) : 3 * (Real.sqrt t / 8) ≤ b := by
  have hs := Real.sq_sqrt ht
  have hs0 := Real.sqrt_nonneg t
  by_contra! hbad
  have hpos : 0 < 3 * (Real.sqrt t / 8) + b := by linarith
  have hp := mul_pos (sub_pos.mpr hbad) hpos
  nlinarith only [hs, hbt, hp, ht]

#print axioms payoff_add_upper
#print axioms gap_nonneg
#print axioms gap_add_upper
#print axioms barrier_no_loss
#print axioms barrier_envelope
#print axioms active_far
#print axioms classifier_separation
#print axioms active_scale

end BarrierCore
