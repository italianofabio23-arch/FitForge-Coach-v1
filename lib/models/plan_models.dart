class CaloriePlan {
  const CaloriePlan({
    required this.bmr,
    required this.maintenance,
    required this.targetCalories,
    required this.proteinG,
    required this.carbsG,
    required this.fatG,
    required this.adjustment,
  });

  final int bmr;
  final int maintenance;
  final int targetCalories;
  final int proteinG;
  final int carbsG;
  final int fatG;
  final int adjustment;
}

class ExerciseItem {
  const ExerciseItem(this.name, this.setsReps, this.recoverySeconds);
  final String name;
  final String setsReps;
  final int recoverySeconds;
}

class WorkoutDay {
  const WorkoutDay(this.title, this.focus, this.exercises);
  final String title;
  final String focus;
  final List<ExerciseItem> exercises;
}

class MealItem {
  const MealItem(this.title, this.ingredients, this.recipe);
  final String title;
  final List<String> ingredients;
  final String recipe;
}

class NutritionDay {
  const NutritionDay(this.day, this.meals);
  final String day;
  final List<MealItem> meals;
}
