import 'package:flutter/material.dart';

import '../models/fitness_profile.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, required this.onCompleted});
  final Future<void> Function(FitnessProfile profile) onCompleted;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _name = TextEditingController();
  final _age = TextEditingController(text: '30');
  final _weight = TextEditingController(text: '75');
  final _height = TextEditingController(text: '175');
  Gender _gender = Gender.male;
  Goal _goal = Goal.definition;
  JobActivity _job = JobActivity.active;
  int _trainingDays = 4;

  @override
  void dispose() {
    _name.dispose();
    _age.dispose();
    _weight.dispose();
    _height.dispose();
    super.dispose();
  }

  Future<void> _continue() async {
    final age = int.tryParse(_age.text);
    final weight = double.tryParse(_weight.text.replaceAll(',', '.'));
    final height = double.tryParse(_height.text.replaceAll(',', '.'));
    if (age == null || weight == null || height == null || age < 18 || weight < 35 || height < 130) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Inserisci dati validi. Questa versione è pensata per utenti maggiorenni.')),
      );
      return;
    }
    await widget.onCompleted(FitnessProfile(
      name: _name.text.trim().isEmpty ? 'Atleta' : _name.text.trim(),
      gender: _gender,
      age: age,
      weightKg: weight,
      heightCm: height,
      jobActivity: _job,
      goal: _goal,
      trainingDays: _trainingDays,
      planStartDate: DateTime.now(),
    ));
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    body: Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF08090B),
            Color(0xFF111318),
            Color(0xFF08090B),
          ],
        ),
      ),
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(18, 18, 18, 30),
          children: [
            Center(
              child: Image.asset(
                'assets/images/logo_fitforge.png',
                height: 145,
              ),
            ),

            const SizedBox(height: 6),

            const Text(
              'COSTRUISCI IL TUO PIANO',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.2,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 6),

            const Text(
              'Allenamento • Nutrizione • Risultati',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFFFF5A2A),
                fontWeight: FontWeight.w700,
              ),
            ),

            const SizedBox(height: 22),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Row(
                      children: [
                        Icon(
                          Icons.person_outline,
                          color: Color(0xFFFF3B22),
                        ),
                        SizedBox(width: 8),
                        Text(
                          'PROFILO CLIENTE',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    TextField(
                      controller: _name,
                      decoration: const InputDecoration(
                        labelText: 'Nome',
                        prefixIcon: Icon(Icons.person),
                      ),
                    ),

                    const SizedBox(height: 14),

                    SegmentedButton<Gender>(
                      segments: const [
                        ButtonSegment(
                          value: Gender.male,
                          label: Text('Uomo'),
                          icon: Icon(Icons.male),
                        ),
                        ButtonSegment(
                          value: Gender.female,
                          label: Text('Donna'),
                          icon: Icon(Icons.female),
                        ),
                      ],
                      selected: {_gender},
                      onSelectionChanged: (v) {
                        setState(() => _gender = v.first);
                      },
                    ),

                    const SizedBox(height: 14),

                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _age,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: 'Età',
                              prefixIcon: Icon(Icons.cake_outlined),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            controller: _weight,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: 'Peso kg',
                              prefixIcon: Icon(Icons.monitor_weight_outlined),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 14),

                    TextField(
                      controller: _height,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Altezza cm',
                        prefixIcon: Icon(Icons.height),
                      ),
                    ),

                    const SizedBox(height: 14),

                    DropdownButtonFormField<JobActivity>(
                      initialValue: _job,
                      decoration: const InputDecoration(
                        labelText: 'Lavoro / attività quotidiana',
                        prefixIcon: Icon(Icons.work_outline),
                      ),
                      items: JobActivity.values
                          .map(
                            (e) => DropdownMenuItem(
                              value: e,
                              child: Text(e.label),
                            ),
                          )
                          .toList(),
                      onChanged: (v) {
                        setState(() => _job = v ?? _job);
                      },
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 14),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Row(
                      children: [
                        Icon(
                          Icons.local_fire_department,
                          color: Color(0xFFFF3B22),
                        ),
                        SizedBox(width: 8),
                        Text(
                          'IL TUO OBIETTIVO',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    DropdownButtonFormField<Goal>(
                      initialValue: _goal,
                      decoration: const InputDecoration(
                        labelText: 'Obiettivo',
                        prefixIcon: Icon(Icons.flag_outlined),
                      ),
                      items: Goal.values
                          .map(
                            (e) => DropdownMenuItem(
                              value: e,
                              child: Text(e.label),
                            ),
                          )
                          .toList(),
                      onChanged: (v) {
                        setState(() => _goal = v ?? _goal);
                      },
                    ),

                    const SizedBox(height: 20),

                    Text(
                      'Giorni di allenamento: $_trainingDays',
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 16,
                      ),
                    ),

                    Slider(
                      value: _trainingDays.toDouble(),
                      min: 3,
                      max: 5,
                      divisions: 2,
                      label: '$_trainingDays giorni',
                      onChanged: (v) {
                        setState(() => _trainingDays = v.round());
                      },
                    ),

                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('3 giorni'),
                        Text('4 giorni'),
                        Text('5 giorni'),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 18),

            SizedBox(
              height: 58,
              child: FilledButton.icon(
                onPressed: _continue,
                icon: const Icon(Icons.local_fire_department),
                label: const Text(
                  'CREA IL MIO PIANO',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 16,
                    letterSpacing: 0.7,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 14),

            const Text(
              'FitForge Coach offre indicazioni generali di fitness e alimentazione. '
              'Non sostituisce medico, dietista o altro professionista sanitario.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white54,
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
}
