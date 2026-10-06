import 'package:flutter/material.dart';

import '../models/fitness_profile.dart';
import '../models/plan_models.dart';
import '../widgets/forge_card.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({
    super.key,
    required this.profile,
    required this.calories,
    required this.homeWorkout,
  });

  final FitnessProfile profile;
  final CaloriePlan calories;
  final List<ExerciseItem> homeWorkout;

  @override
  Widget build(BuildContext context) {
    final isDeficit = calories.adjustment < 0;

    return ListView(
      padding: const EdgeInsets.fromLTRB(18, 16, 18, 28),
      children: [
        // HEADER
        Row(
          children: [
            Image.asset(
              'assets/images/logo_fitforge.png',
              height: 62,
            ),
            const Spacer(),
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: const Color(0x22FF3B22),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: const Color(0x55FF3B22),
                ),
              ),
              child: const Icon(
                Icons.local_fire_department,
                color: Color(0xFFFF4A2A),
              ),
            ),
          ],
        ),

        const SizedBox(height: 14),

        Text(
          'CIAO ${profile.name.toUpperCase()}',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w900,
                letterSpacing: 0.4,
              ),
        ),

        const SizedBox(height: 4),

        Text(
          '${profile.goal.label} • ${profile.trainingDays} giorni a settimana',
          style: const TextStyle(
            color: Colors.white70,
            fontWeight: FontWeight.w600,
          ),
        ),

        const SizedBox(height: 18),

        // CARD PRINCIPALE CALORIE
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF24100D),
                Color(0xFF15171B),
              ],
            ),
            borderRadius: BorderRadius.circular(22),
            border: Border.all(
              color: const Color(0x66FF3B22),
            ),
            boxShadow: const [
              BoxShadow(
                color: Color(0x33000000),
                blurRadius: 18,
                offset: Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Icon(
                    Icons.local_fire_department,
                    color: Color(0xFFFF4A2A),
                  ),
                  SizedBox(width: 8),
                  Text(
                    'OBIETTIVO CALORICO',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 18),

              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${calories.targetCalories}',
                    style: const TextStyle(
                      fontSize: 42,
                      height: 1,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 7),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 5),
                    child: Text(
                      'kcal / giorno',
                      style: TextStyle(
                        color: Colors.white60,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 14),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 9,
                ),
                decoration: BoxDecoration(
                  color: isDeficit
                      ? const Color(0x22FF3B22)
                      : const Color(0x22FF7A18),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  isDeficit
                      ? '🔥 Deficit: ${calories.adjustment.abs()} kcal'
                      : '💪 Surplus: ${calories.adjustment.abs()} kcal',
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    color: Color(0xFFFF7A40),
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 14),

        // METRICHE
        ForgeCard(
          child: Row(
            children: [
              Expanded(
                child: _Metric(
                  label: 'Target',
                  value: '${calories.targetCalories}',
                  suffix: 'kcal',
                ),
              ),
              _divider(),
              Expanded(
                child: _Metric(
                  label: 'Mantenimento',
                  value: '${calories.maintenance}',
                  suffix: 'kcal',
                ),
              ),
              _divider(),
              Expanded(
                child: _Metric(
                  label: isDeficit ? 'Deficit' : 'Surplus',
                  value: '${calories.adjustment.abs()}',
                  suffix: 'kcal',
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 14),

        // MACRO
        ForgeCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Icon(
                    Icons.restaurant,
                    color: Color(0xFFFF6A20),
                  ),
                  SizedBox(width: 8),
                  Text(
                    'MACRO GIORNALIERI',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 18),

              Row(
                children: [
                  Expanded(
                    child: _Macro(
                      'Proteine',
                      '${calories.proteinG} g',
                      Icons.egg_alt_outlined,
                    ),
                  ),
                  Expanded(
                    child: _Macro(
                      'Carboidrati',
                      '${calories.carbsG} g',
                      Icons.grain,
                    ),
                  ),
                  Expanded(
                    child: _Macro(
                      'Grassi',
                      '${calories.fatG} g',
                      Icons.water_drop_outlined,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        const SizedBox(height: 14),

        // ALLENAMENTO CASA
        ForgeCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Icon(
                    Icons.home_outlined,
                    color: Color(0xFFFF4A2A),
                  ),
                  SizedBox(width: 8),
                  Text(
                    'ALLENAMENTO A CASA',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Spacer(),
                  Text(
                    '20 MIN',
                    style: TextStyle(
                      color: Color(0xFFFF6A20),
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              ...homeWorkout.take(4).map(
                    (e) => Container(
                      margin: const EdgeInsets.only(top: 7),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF111317),
                        borderRadius: BorderRadius.circular(13),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.bolt,
                            color: Color(0xFFFF4A2A),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  e.name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  e.setsReps,
                                  style: const TextStyle(
                                    color: Colors.white60,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            '${e.recoverySeconds}s',
                            style: const TextStyle(
                              color: Color(0xFFFF6A20),
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
            ],
          ),
        ),

        const SizedBox(height: 14),

        // INTEGRATORI
        const ForgeCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.medication_outlined,
                    color: Color(0xFFFF6A20),
                  ),
                  SizedBox(width: 8),
                  Text(
                    'INTEGRATORI',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 12),

              Text(
                '• Proteine in polvere: utili se servono a raggiungere il fabbisogno proteico.',
              ),
              SizedBox(height: 6),

              Text(
                '• Creatina monoidrato: integratore comunemente utilizzato per forza e prestazione.',
              ),
              SizedBox(height: 6),

              Text(
                '• Omega-3: valuta prima quanto pesce è già presente nella dieta.',
              ),

              SizedBox(height: 12),

              Text(
                'Gli integratori non sostituiscono una dieta equilibrata. '
                'In presenza di patologie, gravidanza, terapie farmacologiche '
                'o dubbi personali, confrontati con un professionista sanitario.',
                style: TextStyle(
                  color: Colors.white54,
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 20),

        const Text(
          'DISCIPLINA • COSTANZA • RISULTATI',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFFFF4A2A),
            fontWeight: FontWeight.w900,
            letterSpacing: 1.4,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _divider() {
    return Container(
      width: 1,
      height: 54,
      color: Colors.white12,
    );
  }
}

class _Metric extends StatelessWidget {
  const _Metric({
    required this.label,
    required this.value,
    required this.suffix,
  });

  final String label;
  final String value;
  final String suffix;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w900,
            color: Color(0xFFFF4A2A),
          ),
        ),
        Text(
          suffix,
          style: const TextStyle(
            fontSize: 10,
            color: Colors.white54,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class _Macro extends StatelessWidget {
  const _Macro(
    this.label,
    this.value,
    this.icon,
  );

  final String label;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 46,
          height: 46,
          decoration: BoxDecoration(
            color: const Color(0x18FF6A20),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Icon(
            icon,
            color: const Color(0xFFFF6A20),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 10,
            color: Colors.white60,
          ),
        ),
      ],
    );
  }
}