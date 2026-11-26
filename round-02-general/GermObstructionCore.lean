import Mathlib.Probability.Independence.Basic
import Mathlib.MeasureTheory.Measure.Real
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Positivity

/-!
# Event disagreement and threshold-crossing obstructions

This file uses an arbitrary probability space, actual measurable events,
and Mathlib's `ProbabilityTheory.IndepSet`. It formalizes no claim about
existence or nonexistence of a stochastic process.
-/

noncomputable section
open MeasureTheory ProbabilityTheory Set
open scoped symmDiff

namespace GermObstructionCore

section Probability

variable {Ω : Type*} [MeasurableSpace Ω]
variable {μ : Measure Ω} [IsProbabilityMeasure μ]
variable {A B : Set Ω}

/-- The exact disagreement formula for two independent measurable events. -/
theorem independent_disagreement_formula
    (hA : MeasurableSet A) (hB : MeasurableSet B)
    (hind : IndepSet A B μ) :
    μ.real (A ∆ B) = μ.real A + μ.real B - 2 * μ.real A * μ.real B := by
  have hint : μ.real (A ∩ B) = μ.real A * μ.real B := by
    change (μ (A ∩ B)).toReal = (μ A).toReal * (μ B).toReal
    rw [hind.measure_inter_eq_mul, ENNReal.toReal_mul]
  have hAB := measureReal_inter_add_diff (μ := μ) (s := A) hB
  have hBA := measureReal_inter_add_diff (μ := μ) (s := B) hA
  rw [Set.inter_comm B A] at hBA
  rw [measureReal_symmDiff_eq hA hB]
  linarith

/-- A balanced event disagrees with every independent event with probability one half. -/
theorem half_independent_disagreement
    (hA : MeasurableSet A) (hB : MeasurableSet B)
    (hind : IndepSet A B μ) (hp : μ.real A = 1 / 2) :
    μ.real (A ∆ B) = 1 / 2 := by
  rw [independent_disagreement_formula hA hB hind, hp]
  ring

theorem half_independent_disagreement_not_lt
    (hA : MeasurableSet A) (hB : MeasurableSet B)
    (hind : IndepSet A B μ) (hp : μ.real A = 1 / 2) :
    ¬ μ.real (A ∆ B) < 1 / 2 := by
  rw [half_independent_disagreement hA hB hind hp]
  exact lt_irrefl _

/-- Sharp general lower bound: independent events cannot approximate a nontrivial event. -/
theorem independent_disagreement_lower_bound
    (hA : MeasurableSet A) (hB : MeasurableSet B)
    (hind : IndepSet A B μ) :
    min (μ.real A) (1 - μ.real A) ≤ μ.real (A ∆ B) := by
  rw [independent_disagreement_formula hA hB hind]
  have hq0 : 0 ≤ μ.real B := measureReal_nonneg
  have hq1 : μ.real B ≤ 1 := measureReal_le_one
  have hleft := mul_le_mul_of_nonneg_right
    (min_le_left (μ.real A) (1 - μ.real A)) (sub_nonneg.mpr hq1)
  have hright := mul_le_mul_of_nonneg_right
    (min_le_right (μ.real A) (1 - μ.real A)) hq0
  nlinarith

/-- Arbitrarily accurate approximation by events independent of A forces A to be trivial. -/
theorem zero_one_of_independent_approximation
    (hA : MeasurableSet A)
    (happrox : ∀ ε : ℝ, 0 < ε → ∃ B : Set Ω,
      MeasurableSet B ∧ IndepSet A B μ ∧ μ.real (A ∆ B) < ε) :
    μ.real A = 0 ∨ μ.real A = 1 := by
  by_contra hn
  push_neg at hn
  have hp0 : 0 < μ.real A := lt_of_le_of_ne measureReal_nonneg (Ne.symm hn.1)
  have hp1 : μ.real A < 1 := lt_of_le_of_ne measureReal_le_one hn.2
  have hm : 0 < min (μ.real A) (1 - μ.real A) := lt_min hp0 (sub_pos.mpr hp1)
  obtain ⟨B, hB, hind, hdist⟩ := happrox _ hm
  exact (not_lt_of_ge (independent_disagreement_lower_bound hA hB hind)) hdist

end Probability

/-- Deterministic threshold crossing. The strict lower and weak upper boundaries
are valid even when either event is exactly on its threshold. -/
theorem threshold_crossing
    (u v r h : ℝ) (hr : 0 < r) (hr1 : r ≤ 1) (hh : 0 < h)
    (hdiff : (|u| ≤ h ∧ ¬ |v| ≤ r * h) ∨
      (¬ |u| ≤ h ∧ |v| ≤ r * h)) :
    r * h / 2 < |u - v| ∨
      (r * h / 2 < |u| ∧ |u| ≤ (1 + r / 2) * h) := by
  by_cases hlarge : r * h / 2 < |u - v|
  · exact Or.inl hlarge
  · right
    have hclose : |u - v| ≤ r * h / 2 := le_of_not_gt hlarge
    have huv : |u| ≤ |v| + |u - v| := by
      calc
        |u| = |v + (u - v)| := by congr 1; ring
        _ ≤ |v| + |u - v| := abs_add _ _
    have hvu : |v| ≤ |u| + |u - v| := by
      calc
        |v| = |u + (v - u)| := by congr 1; ring
        _ ≤ |u| + |v - u| := abs_add _ _
        _ = |u| + |u - v| := by rw [abs_sub_comm v u]
    have hrh : r * h ≤ h := by nlinarith
    have hrh0 : 0 < r * h := mul_pos hr hh
    rcases hdiff with ⟨hu, hv⟩ | ⟨hu, hv⟩
    · have hv' : r * h < |v| := lt_of_not_ge hv
      constructor <;> nlinarith
    · have hu' : h < |u| := lt_of_not_ge hu
      constructor <;> nlinarith

/-- The threshold criterion as an actual inclusion of events. -/
theorem threshold_event_symmDiff_subset {Ω : Type*}
    (u v : Ω → ℝ) (r h : ℝ) (hr : 0 < r) (hr1 : r ≤ 1) (hh : 0 < h) :
    {ω | |u ω| ≤ h} ∆ {ω | |v ω| ≤ r * h} ⊆
      {ω | r * h / 2 < |u ω - v ω|} ∪
        {ω | r * h / 2 < |u ω| ∧ |u ω| ≤ (1 + r / 2) * h} := by
  intro ω hω
  apply threshold_crossing (u ω) (v ω) r h hr hr1 hh
  rcases Set.mem_symmDiff.mp hω with hω | hω
  · exact Or.inl hω
  · exact Or.inr ⟨hω.2, hω.1⟩

/-- Passing from the event inclusion to a genuine probability bound.
The assertion also holds for any finite measure and arbitrary functions. -/
theorem threshold_disagreement_probability_bound {Ω : Type*} [MeasurableSpace Ω]
    (μ : Measure Ω) [IsFiniteMeasure μ] (u v : Ω → ℝ)
    (r h : ℝ) (hr : 0 < r) (hr1 : r ≤ 1) (hh : 0 < h) :
    μ.real ({ω | |u ω| ≤ h} ∆ {ω | |v ω| ≤ r * h}) ≤
      μ.real {ω | r * h / 2 < |u ω - v ω|} +
        μ.real {ω | r * h / 2 < |u ω| ∧ |u ω| ≤ (1 + r / 2) * h} := by
  exact (measureReal_mono (threshold_event_symmDiff_subset u v r h hr hr1 hh)).trans
    (measureReal_union_le _ _)

/-- Quantitative obstruction: a balanced threshold event and an independent
contracted threshold force at least one half of disagreement mass into the
large-increment event or the specified annulus. -/
theorem independent_threshold_obstruction {Ω : Type*} [MeasurableSpace Ω]
    (μ : Measure Ω) [IsProbabilityMeasure μ] (u v : Ω → ℝ)
    (r h : ℝ) (hr : 0 < r) (hr1 : r ≤ 1) (hh : 0 < h)
    (hA : MeasurableSet {ω | |u ω| ≤ h})
    (hB : MeasurableSet {ω | |v ω| ≤ r * h})
    (hind : IndepSet {ω | |u ω| ≤ h} {ω | |v ω| ≤ r * h} μ)
    (hp : μ.real {ω | |u ω| ≤ h} = 1 / 2) :
    1 / 2 ≤ μ.real {ω | r * h / 2 < |u ω - v ω|} +
      μ.real {ω | r * h / 2 < |u ω| ∧ |u ω| ≤ (1 + r / 2) * h} := by
  rw [← half_independent_disagreement hA hB hind hp]
  exact threshold_disagreement_probability_bound μ u v r h hr hr1 hh

end GermObstructionCore

#print axioms GermObstructionCore.independent_disagreement_formula
#print axioms GermObstructionCore.half_independent_disagreement
#print axioms GermObstructionCore.half_independent_disagreement_not_lt
#print axioms GermObstructionCore.independent_disagreement_lower_bound
#print axioms GermObstructionCore.zero_one_of_independent_approximation
#print axioms GermObstructionCore.threshold_crossing
#print axioms GermObstructionCore.threshold_event_symmDiff_subset
#print axioms GermObstructionCore.threshold_disagreement_probability_bound
#print axioms GermObstructionCore.independent_threshold_obstruction
