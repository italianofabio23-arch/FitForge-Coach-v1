import 'package:flutter/material.dart';

import '../models/fitness_profile.dart';
import '../widgets/forge_card.dart';

class ProgressScreen extends StatefulWidget {
  const ProgressScreen({
    super.key,
    required this.profile,
    required this.onResetProfile,
  });

  final FitnessProfile profile;
  final Future<void> Function() onResetProfile;

  @override
  State<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  late double weight;
  final entries = <double>[];

  @override
  void initState() {
    super.initState();
    weight = widget.profile.weightKg;
    entries.add(weight);
  }

  void _saveCheckIn() {
    setState(() {
      entries.add(weight);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Check-in salvato: ${weight.toStringAsFixed(1)} kg',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final initialWeight = widget.profile.weightKg;
    final difference = weight - initialWeight;

    String variationText;

    if (difference > 0) {
      variationText = '+${difference.toStringAsFixed(1)} kg';
    } else if (difference < 0) {
      variationText = '${difference.toStringAsFixed(1)} kg';
    } else {
      variationText = '0.0 kg';
    }

    return ListView(
      padding: const EdgeInsets.fromLTRB(18, 16, 18, 28),
      children: [
        // HEADER
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
                Icons.trending_up,
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
                    'I TUOI PROGRESSI',
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 0.5,
                    ),
                  ),
                  SizedBox(height: 3),
                  Text(
                    'Controlla la tua evoluzione nel tempo',
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

        // PESO ATTUALE
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF25100E),
                Color(0xFF15171B),
              ],
            ),
            borderRadius: BorderRadius.circular(22),
            border: Border.all(
              color: const Color(0x66FF3B22),
            ),
          ),
          child: Column(
            children: [
              const Text(
                'PESO ATTUALE',
                style: TextStyle(
                  color: Colors.white60,
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1,
                ),
              ),

              const SizedBox(height: 8),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    weight.toStringAsFixed(1),
                    style: const TextStyle(
                      fontSize: 46,
                      height: 1,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(width: 6),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 5),
                    child: Text(
                      'kg',
                      style: TextStyle(
                        color: Color(0xFFFF6A20),
                        fontSize: 17,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 18),

              Slider(
                value: weight.clamp(40.0, 160.0).toDouble(),
                min: 40,
                max: 160,
                divisions: 1200,
                label: '${weight.toStringAsFixed(1)} kg',
                onChanged: (value) {
                  setState(() {
                    weight = value;
                  });
                },
              ),

              const SizedBox(height: 8),

              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: _saveCheckIn,
                  icon: const Icon(Icons.add_chart),
                  label: const Text(
                    'SALVA CHECK-IN',
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 14),

        // RIEPILOGO
        ForgeCard(
          child: Row(
            children: [
              Expanded(
                child: _ProgressMetric(
                  icon: Icons.flag_outlined,
                  label: 'Peso iniziale',
                  value: '${initialWeight.toStringAsFixed(1)} kg',
                ),
              ),
              Container(
                width: 1,
                height: 65,
                color: Colors.white12,
              ),
              Expanded(
                child: _ProgressMetric(
                  icon: difference >= 0
                      ? Icons.arrow_upward
                      : Icons.arrow_downward,
                  label: 'Variazione',
                  value: variationText,
                ),
              ),
              Container(
                width: 1,
                height: 65,
                color: Colors.white12,
              ),
              Expanded(
                child: _ProgressMetric(
                  icon: Icons.check_circle_outline,
                  label: 'Check-in',
                  value: '${entries.length}',
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 14),

        // OBIETTIVO
        ForgeCard(
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: const Color(0x18FF7A18),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(
                  Icons.track_changes,
                  color: Color(0xFFFF6A20),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'OBIETTIVO ATTUALE',
                      style: TextStyle(
                        color: Colors.white54,
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.8,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      widget.profile.goal.label,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFFFF6A20),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 18),

        const Text(
          'STORICO CHECK-IN',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w900,
            letterSpacing: 0.5,
          ),
        ),

        const SizedBox(height: 10),

        // STORICO
        ForgeCard(
          child: entries.isEmpty
              ? const Text(
                  'Nessun check-in registrato.',
                  style: TextStyle(
                    color: Colors.white54,
                  ),
                )
              : Column(
                  children: entries
                      .asMap()
                      .entries
                      .toList()
                      .reversed
                      .map(
                        (entry) {
                          final index = entry.key;
                          final value = entry.value;

                          double change = 0;

                          if (index > 0) {
                            change = value - entries[index - 1];
                          }

                          return Container(
                            margin: const EdgeInsets.only(bottom: 8),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 11,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFF111317),
                              borderRadius: BorderRadius.circular(13),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 38,
                                  height: 38,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: const Color(0x18FF3B22),
                                    borderRadius: BorderRadius.circular(11),
                                  ),
                                  child: Text(
                                    '${index + 1}',
                                    style: const TextStyle(
                                      color: Color(0xFFFF4A2A),
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                ),

                                const SizedBox(width: 12),

                                Expanded(
                                  child: Text(
                                    'Check-in ${index + 1}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ),

                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      '${value.toStringAsFixed(1)} kg',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w900,
                                        fontSize: 15,
                                      ),
                                    ),
                                    if (index > 0)
                                      Text(
                                        change > 0
                                            ? '+${change.toStringAsFixed(1)} kg'
                                            : '${change.toStringAsFixed(1)} kg',
                                        style: const TextStyle(
                                          color: Colors.white54,
                                          fontSize: 10,
                                        ),
                                      ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      )
                      .toList(),
                ),
        ),

        const SizedBox(height: 22),

        // RESET PROFILO
        OutlinedButton.icon(
          onPressed: widget.onResetProfile,
          icon: const Icon(Icons.manage_accounts_outlined),
          label: const Text(
            'MODIFICA / RIFAI PROFILO',
            style: TextStyle(
              fontWeight: FontWeight.w900,
            ),
          ),
        ),

        const SizedBox(height: 16),

        const Text(
          'MISURA • ANALIZZA • MIGLIORA',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFFFF4A2A),
            fontWeight: FontWeight.w900,
            letterSpacing: 1.3,
            fontSize: 10,
          ),
        ),
      ],
    );
  }
}

class _ProgressMetric extends StatelessWidget {
  const _ProgressMetric({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          color: const Color(0xFFFF6A20),
          size: 22,
        ),
        const SizedBox(height: 7),
        Text(
          value,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 3),
        Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white54,
            fontSize: 9,
          ),
        ),
      ],
    );
  }
}