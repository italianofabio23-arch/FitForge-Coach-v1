import 'dart:convert';

enum Gender { male, female }

enum Goal { loseWeight, definition, muscleGain, tone, cellulite }

enum JobActivity { sedentary, light, active, veryActive }

class FitnessProfile {
  const FitnessProfile({
    required this.name,
    required this.gender,
    required this.age,
    required this.weightKg,
    required this.heightCm,
    required this.jobActivity,
    required this.goal,
    required this.trainingDays,
    required this.planStartDate,
  });

  final String name;
  final Gender gender;
  final int age;
  final double weightKg;
  final double heightCm;
  final JobActivity jobActivity;
  final Goal goal;
  final int trainingDays;
  final DateTime planStartDate;

  Map<String, dynamic> toJson() => {
        'name': name,
        'gender': gender.name,
        'age': age,
        'weightKg': weightKg,
        'heightCm': heightCm,
        'jobActivity': jobActivity.name,
        'goal': goal.name,
        'trainingDays': trainingDays,
    'planStartDate': planStartDate.toIso8601String(),
      };

  String toJsonString() => jsonEncode(toJson());

  factory FitnessProfile.fromJsonString(String value) {
    final map = jsonDecode(value) as Map<String, dynamic>;
    return FitnessProfile(
      name: map['name'] as String? ?? 'Atleta',
      gender: Gender.values.byName(map['gender'] as String),
      age: map['age'] as int,
      weightKg: (map['weightKg'] as num).toDouble(),
      heightCm: (map['heightCm'] as num).toDouble(),
      jobActivity: JobActivity.values.byName(map['jobActivity'] as String),
      goal: Goal.values.byName(map['goal'] as String),
      trainingDays: map['trainingDays'] as int,
      planStartDate: DateTime.tryParse(
      map['planStartDate'] as String? ?? '',
    ) ??
    DateTime.now(),
    );
  }
}

extension GoalLabel on Goal {
  String get label => switch (this) {
        Goal.loseWeight => 'Dimagrire',
        Goal.definition => 'Definizione',
        Goal.muscleGain => 'Massa muscolare',
        Goal.tone => 'Rassodare',
        Goal.cellulite => 'Benessere & tonicità',
      };
}

extension JobLabel on JobActivity {
  String get label => switch (this) {
        JobActivity.sedentary => 'Sedentario / ufficio',
        JobActivity.light => 'Leggermente attivo',
        JobActivity.active => 'Attivo / molte ore in piedi',
        JobActivity.veryActive => 'Molto attivo / lavoro fisico',
      };
}
