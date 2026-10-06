import '../models/fitness_profile.dart';
import '../models/plan_models.dart';

class CalorieService {
  static CaloriePlan build(FitnessProfile p) {
    final sexConstant = p.gender == Gender.male ? 5.0 : -161.0;
    final bmr = (10 * p.weightKg + 6.25 * p.heightCm - 5 * p.age + sexConstant).round();

    final activityFactor = switch (p.jobActivity) {
      JobActivity.sedentary => 1.35,
      JobActivity.light => 1.48,
      JobActivity.active => 1.62,
      JobActivity.veryActive => 1.75,
    };
    final trainingBonus = (p.trainingDays * 0.025).clamp(0.0, 0.12);
    final maintenance = (bmr * (activityFactor + trainingBonus)).round();

    final adjustment = switch (p.goal) {
      Goal.loseWeight => -450,
      Goal.definition => -300,
      Goal.muscleGain => 280,
      Goal.tone => -180,
      Goal.cellulite => -150,
    };

    final target = (maintenance + adjustment).clamp(1400, 4200).toInt();
    final protein = (p.weightKg * (p.goal == Goal.muscleGain ? 2.0 : 1.8)).round();
    final fat = (p.weightKg * 0.85).round();
    final remaining = target - protein * 4 - fat * 9;
    final carbs = (remaining / 4).clamp(80, 600).round();

    return CaloriePlan(
      bmr: bmr,
      maintenance: maintenance,
      targetCalories: target,
      proteinG: protein,
      carbsG: carbs,
      fatG: fat,
      adjustment: adjustment,
    );
  }
}
