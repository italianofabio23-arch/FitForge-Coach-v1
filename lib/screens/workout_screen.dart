import 'package:flutter/material.dart';

import '../models/plan_models.dart';
import '../widgets/forge_card.dart';

class WorkoutScreen extends StatelessWidget {
  const WorkoutScreen({
  super.key,
  required this.workouts,
  this.weekInBlock = 1,
  this.trainingBlock = 0,
    this.daysUntilNextBlock = 28,
});

  final List<WorkoutDay> workouts;
  final int weekInBlock;
final int trainingBlock;
  final int daysUntilNextBlock;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(18, 16, 18, 28),
      children: [
        Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: const Color(0x22FF3B22),
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: const Color(0x55FF3B22),
                ),
              ),
              child: const Icon(
                Icons.fitness_center,
                color: Color(0xFFFF4A2A),
                size: 27,
              ),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'PIANO ALLENAMENTO',
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 0.5,
                    ),
                  ),
                  SizedBox(height: 3),
                  Text(
                    'Progressione base di 4 settimane',
                    style: TextStyle(
                      color: Colors.white60,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

        const SizedBox(height: 20),
ForgeCard(
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'SETTIMANA $weekInBlock / 4',
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w900,
        ),
      ),
      const SizedBox(height: 8),
      Text(
        'SCHEDA ${trainingBlock.isEven ? 'A' : 'B'}',
        style: const TextStyle(
          color: Color(0xFFFF4A2A),
          fontSize: 16,
          fontWeight: FontWeight.w900,
        ),
      ),
      const SizedBox(height: 8),
      Text(
        'Cambio scheda tra $daysUntilNextBlock giorni',
        style: const TextStyle(
          color: Colors.white70,
          fontWeight: FontWeight.w600,
        ),
      ),
    ],
  ),
),

const SizedBox(height: 20),
        ...workouts.asMap().entries.map(
          (entry) {
            final index = entry.key;
            final day = entry.value;

            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: ForgeCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 42,
                          height: 42,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xFFFF3B22),
                                Color(0xFFFF7A18),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(13),
                          ),
                          child: Text(
                            '${index + 1}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                            ),
                          ),
                        ),

                        const SizedBox(width: 12),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                day.title,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              const SizedBox(height: 3),
                              Text(
                                day.focus,
                                style: const TextStyle(
                                  color: Color(0xFFFF6A20),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const Icon(
                          Icons.local_fire_department,
                          color: Color(0xFFFF4A2A),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    ...day.exercises.asMap().entries.map(
                      (exerciseEntry) {
                        final exercise = exerciseEntry.value;

                        return Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: const Color(0xFF111317),
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: Colors.white10,
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 42,
                                height: 42,
                                decoration: BoxDecoration(
                                  color: const Color(0x18FF3B22),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Icon(
                                  Icons.fitness_center,
                                  color: Color(0xFFFF4A2A),
                                  size: 21,
                                ),
                              ),

                              const SizedBox(width: 12),

                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      exercise.name,
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      exercise.setsReps,
                                      style: const TextStyle(
                                        color: Colors.white60,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              const SizedBox(width: 8),

                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0x22FF7A18),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  children: [
                                    const Text(
                                      'RECUPERO',
                                      style: TextStyle(
                                        fontSize: 8,
                                        color: Colors.white60,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      '${exercise.recoverySeconds}s',
                                      style: const TextStyle(
                                        fontSize: 15,
                                        color: Color(0xFFFF6A20),
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 3),

                    Row(
                      children: [
                        const Icon(
                          Icons.info_outline,
                          size: 15,
                          color: Colors.white38,
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            'Completa tutte le serie mantenendo tecnica e controllo.',
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.white.withValues(alpha: 0.45),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),

        const SizedBox(height: 4),

        const Text(
          'FORZA • CONTROLLO • PROGRESSIONE',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFFFF4A2A),
            fontWeight: FontWeight.w900,
            letterSpacing: 1.3,
            fontSize: 11,
          ),
        ),
      ],
    );
  }
}