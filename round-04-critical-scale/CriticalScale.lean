import Mathlib

/-!
Round 04: scalar algebra underlying the coupling recursion and convex crossing
bound. Candidate for Lean 4.19.0 / Mathlib v4.19.0. Not yet compiler-verified.
The continuous-time stochastic-process arguments are not formalized here.
-/

namespace CriticalScale

theorem coupling_recursion (p : ℕ → ℝ) (e c : ℝ)
    (he : e ≤ 1) (h0 : p 0 ≤ 1)
    (hstep : ∀ n : ℕ, p (n + 1) ≤ (1 - e) * p n + e * c) :
    ∀ n : ℕ, p n ≤ (1 - e) ^ n + c * (1 - (1 - e) ^ n) := by
  intro n
  induction n with
  | zero => simpa using h0
  | succ n ih =>
    have hn := mul_le_mul_of_nonneg_left ih (sub_nonneg.mpr he)
    calc
      p (n + 1) ≤ (1 - e) * p n + e * c := hstep n
      _ ≤ (1 - e) * ((1 - e) ^ n + c * (1 - (1 - e) ^ n)) + e * c :=
        add_le_add_right hn (e * c)
      _ = (1 - e) ^ (n + 1) + c * (1 - (1 - e) ^ (n + 1)) := by
        rw [pow_succ]
        ring

theorem coupling_bound (p : ℕ → ℝ) (e c : ℝ)
    (he : e ≤ 1) (hc : 0 ≤ c) (h0 : p 0 ≤ 1)
    (hstep : ∀ n : ℕ, p (n + 1) ≤ (1 - e) * p n + e * c)
    (n : ℕ) : p n ≤ (1 - e) ^ n + c := by
  have hr := coupling_recursion p e c he h0 hstep n
  have hp : 0 ≤ c * (1 - e) ^ n :=
    mul_nonneg hc (pow_nonneg (sub_nonneg.mpr he) n)
  linarith only [hr, hp]

def callAbs (h x : ℝ) : ℝ := max (|x| - h) 0
def callSlope (h x : ℝ) : ℝ :=
  if h < x then 1 else if x < -h then -1 else 0
def callGap (h u v : ℝ) : ℝ :=
  callAbs h u - callAbs h v - callSlope h v * (u - v)

theorem callAbs_inside (h x : ℝ) (hx : |x| ≤ h) :
    callAbs h x = 0 := by
  exact max_eq_right (sub_nonpos.mpr hx)

theorem callAbs_right (h x : ℝ) (hh : 0 ≤ h) (hx : h < x) :
    callAbs h x = x - h := by
  have hx0 : 0 ≤ x := by linarith
  have hx1 : 0 ≤ x - h := by linarith
  simp [callAbs, abs_of_nonneg hx0, max_eq_left hx1]

theorem callAbs_left (h x : ℝ) (hh : 0 ≤ h) (hx : x < -h) :
    callAbs h x = -x - h := by
  have hx0 : x ≤ 0 := by linarith
  have hx1 : 0 ≤ -x - h := by linarith
  simp [callAbs, abs_of_nonpos hx0, max_eq_left hx1]

theorem callGap_nonneg (h u v : ℝ) (hh : 0 ≤ h) :
    0 ≤ callGap h u v := by
  have hl : |u| - h ≤ callAbs h u := le_max_left _ _
  have hz : 0 ≤ callAbs h u := le_max_right _ _
  have hup : u ≤ |u| := le_abs_self u
  have hun : -u ≤ |u| := neg_le_abs u
  by_cases hp : h < v
  · simp only [callGap, callSlope, if_pos hp, callAbs_right h v hh hp, one_mul]
    linarith
  · by_cases hm : v < -h
    · simp only [callGap, callSlope, if_neg hp, if_pos hm, callAbs_left h v hh hm]
      linarith
    · have hv : |v| ≤ h :=
        abs_le.mpr ⟨le_of_not_gt hm, le_of_not_gt hp⟩
      simp only [callGap, callSlope, if_neg hp, if_neg hm, callAbs_inside h v hv,
        zero_mul, sub_zero]
      exact hz

theorem far_cross_out (h u v : ℝ) (hv : |v| ≤ h)
    (hu : 2 * h ≤ |u|) : h ≤ callGap h u v := by
  have hp : ¬ h < v := not_lt_of_ge (abs_le.mp hv).2
  have hm : ¬ v < -h := not_lt_of_ge (abs_le.mp hv).1
  have hl : |u| - h ≤ callAbs h u := le_max_left _ _
  simp only [callGap, callSlope, if_neg hp, if_neg hm, callAbs_inside h v hv,
    zero_mul, sub_zero]
  linarith

theorem far_cross_in (h u v : ℝ) (hh : 0 ≤ h) (hv : h < |v|)
    (hu : |u| ≤ h / 2) : h / 2 ≤ callGap h u v := by
  have hu' : |u| ≤ h := by linarith
  have hup : u ≤ h / 2 := (abs_le.mp hu).2
  have hun : -(h / 2) ≤ u := (abs_le.mp hu).1
  by_cases hp : h < v
  · simp only [callGap, callSlope, if_pos hp, callAbs_right h v hh hp,
      callAbs_inside h u hu', one_mul]
    linarith
  · have hm : v < -h := by
      by_contra! hbad
      have ha : |v| ≤ h := abs_le.mpr ⟨hbad, le_of_not_gt hp⟩
      linarith
    simp only [callGap, callSlope, if_neg hp, if_pos hm, callAbs_left h v hh hm,
      callAbs_inside h u hu']
    linarith

theorem crossing_certificate (h u v : ℝ) (hh : 0 < h)
    (hc : (|v| ≤ h ∧ h < |u|) ∨ (h < |v| ∧ |u| ≤ h)) :
    h / 2 ≤ callGap h u v ∨ (h / 2 < |u| ∧ |u| ≤ 2 * h) := by
  rcases hc with h1 | h2
  · by_cases hb : 2 * h ≤ |u|
    · left
      have hd := far_cross_out h u v h1.1 hb
      linarith
    · right
      exact ⟨by linarith [h1.2], le_of_lt (lt_of_not_ge hb)⟩
  · by_cases hb : |u| ≤ h / 2
    · left
      exact far_cross_in h u v (le_of_lt hh) h2.1 hb
    · right
      exact ⟨lt_of_not_ge hb, by linarith [h2.2]⟩

#print axioms coupling_recursion
#print axioms coupling_bound
#print axioms callGap_nonneg
#print axioms far_cross_out
#print axioms far_cross_in
#print axioms crossing_certificate

end CriticalScale
