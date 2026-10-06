import 'package:flutter/material.dart';

import '../models/plan_models.dart';
import '../widgets/forge_card.dart';

class NutritionScreen extends StatefulWidget {
  const NutritionScreen({
    super.key,
    required this.calories,
    required this.nutrition,
  });

  final CaloriePlan calories;
  final List<NutritionDay> nutrition;

  @override
  State<NutritionScreen> createState() => _NutritionScreenState();
}

class _NutritionScreenState extends State<NutritionScreen> {
  int consumed = 0;

  void _add(int kcal) {
    setState(() {
      consumed += kcal;
    });
  }

  void _reset() {
    setState(() {
      consumed = 0;
    });
  }

  IconData _mealIcon(String title) {
    final value = title.toLowerCase();

    if (value.contains('colazione')) {
      return Icons.free_breakfast;
    }

    if (value.contains('pranzo')) {
      return Icons.lunch_dining;
    }

    if (value.contains('cena')) {
      return Icons.dinner_dining;
    }

    if (value.contains('spuntino')) {
      return Icons.apple;
    }

    if (value.contains('libero')) {
      return Icons.local_pizza;
    }

    return Icons.restaurant;
  }

  bool _isFreeMeal(String title) {
    return title.toLowerCase().contains('libero');
  }

  void _openRecipe(MealItem meal) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF111317),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              20,
              22,
              20,
              30,
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 50,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Colors.white24,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),

                  const SizedBox(height: 22),

                  Row(
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: const Color(0x22FF3B22),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Icon(
                          _mealIcon(meal.title),
                          color: const Color(0xFFFF4A2A),
                        ),
                      ),

                      const SizedBox(width: 12),

                      Expanded(
                        child: Text(
                          meal.title,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 22),

                  const Text(
                    'INGREDIENTI',
                    style: TextStyle(
                      color: Color(0xFFFF6A20),
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1,
                    ),
                  ),

                  const SizedBox(height: 10),

                  ...meal.ingredients.map(
                    (ingredient) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.check_circle,
                            color: Color(0xFFFF4A2A),
                            size: 18,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              ingredient,
                              style: const TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    'COME PREPARARLO',
                    style: TextStyle(
                      color: Color(0xFFFF6A20),
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    meal.recipe,
                    style: const TextStyle(
                      fontSize: 15,
                      height: 1.5,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final target = widget.calories.targetCalories <= 0
        ? 1
        : widget.calories.targetCalories;

    final ratio =
        (consumed / target).clamp(0.0, 1.0).toDouble();

    final remaining =
        (widget.calories.targetCalories - consumed).clamp(
      0,
      widget.calories.targetCalories,
    );

    return ListView(
      padding: const EdgeInsets.fromLTRB(18, 16, 18, 28),
      children: [
        const Row(
          children: [
            Icon(
              Icons.restaurant_menu,
              color: Color(0xFFFF4A2A),
              size: 30,
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'NUTRIZIONE',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 0.6,
                    ),
                  ),
                  Text(
                    'Il tuo piano alimentare FitForge',
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

        const SizedBox(height: 18),

        // TRACKER CALORIE
        ForgeCard(
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 135,
                    height: 135,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          width: 120,
                          height: 120,
                          child: CircularProgressIndicator(
                            value: ratio,
                            strokeWidth: 11,
                            backgroundColor: Colors.white10,
                            color: const Color(0xFFFF4A2A),
                          ),
                        ),

                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '$consumed',
                              style: const TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            const Text(
                              'kcal ingerite',
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.white60,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(width: 14),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'OGGI',
                          style: TextStyle(
                            color: Color(0xFFFF6A20),
                            fontWeight: FontWeight.w900,
                          ),
                        ),

                        const SizedBox(height: 6),

                        Text(
                          '${widget.calories.targetCalories} kcal',
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w900,
                          ),
                        ),

                        const Text(
                          'Target giornaliero',
                          style: TextStyle(
                            color: Colors.white60,
                            fontSize: 11,
                          ),
                        ),

                        const SizedBox(height: 12),

                        Text(
                          '$remaining kcal rimanenti',
                          style: const TextStyle(
                            color: Color(0xFFFF6A20),
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              Wrap(
                spacing: 8,
                runSpacing: 8,
                alignment: WrapAlignment.center,
                children: [
                  ActionChip(
                    avatar: const Icon(
                      Icons.add,
                      size: 17,
                    ),
                    label: const Text('+250 kcal'),
                    onPressed: () => _add(250),
                  ),

                  ActionChip(
                    avatar: const Icon(
                      Icons.add,
                      size: 17,
                    ),
                    label: const Text('+500 kcal'),
                    onPressed: () => _add(500),
                  ),

                  ActionChip(
                    avatar: const Icon(
                      Icons.restart_alt,
                      size: 17,
                    ),
                    label: const Text('Azzera'),
                    onPressed: _reset,
                  ),
                ],
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
              const Text(
                'MACRO TARGET',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                ),
              ),

              const SizedBox(height: 14),

              Row(
                children: [
                  Expanded(
                    child: _MacroBox(
                      icon: Icons.egg_alt_outlined,
                      label: 'Proteine',
                      value: '${widget.calories.proteinG} g',
                    ),
                  ),

                  const SizedBox(width: 8),

                  Expanded(
                    child: _MacroBox(
                      icon: Icons.grain,
                      label: 'Carbo',
                      value: '${widget.calories.carbsG} g',
                    ),
                  ),

                  const SizedBox(width: 8),

                  Expanded(
                    child: _MacroBox(
                      icon: Icons.water_drop_outlined,
                      label: 'Grassi',
                      value: '${widget.calories.fatG} g',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        const SizedBox(height: 20),

        const Text(
          'DIETA SETTIMANALE',
          style: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.w900,
            letterSpacing: 0.6,
          ),
        ),

        const SizedBox(height: 5),

        const Text(
          'Tocca un giorno per vedere i pasti e le grammature.',
          style: TextStyle(
            color: Colors.white60,
            fontSize: 12,
          ),
        ),

        const SizedBox(height: 12),

        // GIORNI
        ...widget.nutrition.asMap().entries.map(
          (entry) {
            final dayIndex = entry.key;
            final day = entry.value;

            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: const Color(0xFF15171B),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: dayIndex == 0
                      ? const Color(0x55FF3B22)
                      : Colors.white10,
                ),
              ),
              child: ExpansionTile(
                shape: const Border(),
                collapsedShape: const Border(),
                leading: Container(
                  width: 42,
                  height: 42,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    gradient: dayIndex == 0
                        ? const LinearGradient(
                            colors: [
                              Color(0xFFFF3B22),
                              Color(0xFFFF7A18),
                            ],
                          )
                        : null,
                    color: dayIndex == 0
                        ? null
                        : const Color(0xFF202329),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${dayIndex + 1}',
                    style: const TextStyle(
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),

                title: Text(
                  day.day,
                  style: const TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 16,
                  ),
                ),

                subtitle: Text(
                  '${day.meals.length} pasti programmati',
                  style: const TextStyle(
                    color: Colors.white54,
                    fontSize: 11,
                  ),
                ),

                children: day.meals.map(
                  (meal) {
                    final freeMeal = _isFreeMeal(meal.title);

                    return Container(
                      margin: const EdgeInsets.fromLTRB(
                        12,
                        0,
                        12,
                        12,
                      ),
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: freeMeal
                            ? const Color(0x18FF7A18)
                            : const Color(0xFF101216),
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: freeMeal
                              ? const Color(0x55FF7A18)
                              : Colors.white10,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: const Color(0x18FF3B22),
                                  borderRadius: BorderRadius.circular(11),
                                ),
                                child: Icon(
                                  _mealIcon(meal.title),
                                  color: const Color(0xFFFF4A2A),
                                  size: 21,
                                ),
                              ),

                              const SizedBox(width: 10),

                              Expanded(
                                child: Text(
                                  meal.title,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 15,
                                  ),
                                ),
                              ),

                              if (freeMeal)
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 5,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(0x22FF7A18),
                                    borderRadius:
                                        BorderRadius.circular(8),
                                  ),
                                  child: const Text(
                                    'LIBERO',
                                    style: TextStyle(
                                      fontSize: 9,
                                      color: Color(0xFFFF7A18),
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                ),
                            ],
                          ),

                          const SizedBox(height: 12),

                          ...meal.ingredients.map(
                            (ingredient) => Padding(
                              padding:
                                  const EdgeInsets.only(bottom: 5),
                              child: Row(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    '• ',
                                    style: TextStyle(
                                      color: Color(0xFFFF6A20),
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      ingredient,
                                      style: const TextStyle(
                                        color: Colors.white70,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                                      const SizedBox(height: 10),

                          SizedBox(
                            width: double.infinity,
                            child: OutlinedButton.icon(
                              onPressed: () => _openRecipe(meal),
                              icon: const Icon(
                                Icons.menu_book_outlined,
                              ),
                              label: const Text(
                                'VEDI RICETTA',
                                style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ).toList(),
              ),
            );
          },
        ),

        const SizedBox(height: 8),

        const ForgeCard(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.info_outline,
                color: Color(0xFFFF6A20),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Il pasto libero deve restare controllato e inserito nel '
                  'contesto della settimana. Le quantità del piano possono '
                  'essere adattate quando cambiano peso, attività e obiettivo.',
                  style: TextStyle(
                    color: Colors.white60,
                    fontSize: 11,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _MacroBox extends StatelessWidget {
  const _MacroBox({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 14,
        horizontal: 8,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF101216),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: const Color(0xFFFF6A20),
          ),
          const SizedBox(height: 7),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white54,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}