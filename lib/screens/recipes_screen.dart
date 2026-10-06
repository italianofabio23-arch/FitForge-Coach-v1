import 'package:flutter/material.dart';

import '../models/plan_models.dart';
import '../widgets/forge_card.dart';

class RecipesScreen extends StatelessWidget {
  const RecipesScreen({
    super.key,
    required this.nutrition,
  });

  final List<NutritionDay> nutrition;

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

  void _openRecipe(
    BuildContext context,
    MealItem meal,
  ) {
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
              20,
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
                        width: 52,
                        height: 52,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xFFFF3B22),
                              Color(0xFFFF7A18),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Icon(
                          _mealIcon(meal.title),
                          color: Colors.white,
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

                  const SizedBox(height: 24),

                  const Text(
                    'INGREDIENTI E GRAMMATURE',
                    style: TextStyle(
                      color: Color(0xFFFF6A20),
                      fontWeight: FontWeight.w900,
                      letterSpacing: 0.8,
                    ),
                  ),

                  const SizedBox(height: 12),

                  ...meal.ingredients.map(
                    (ingredient) => Padding(
                      padding: const EdgeInsets.only(bottom: 9),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.check_circle,
                            color: Color(0xFFFF4A2A),
                            size: 18,
                          ),
                          const SizedBox(width: 9),
                          Expanded(
                            child: Text(
                              ingredient,
                              style: const TextStyle(
                                fontSize: 15,
                                height: 1.3,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 22),

                  const Text(
                    'PREPARAZIONE',
                    style: TextStyle(
                      color: Color(0xFFFF6A20),
                      fontWeight: FontWeight.w900,
                      letterSpacing: 0.8,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF181A1F),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: Colors.white10,
                      ),
                    ),
                    child: Text(
                      meal.recipe,
                      style: const TextStyle(
                        fontSize: 15,
                        height: 1.5,
                        color: Colors.white70,
                      ),
                    ),
                  ),

                  const SizedBox(height: 18),

                  const Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.lightbulb_outline,
                        color: Color(0xFFFF6A20),
                        size: 19,
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Mantieni le grammature previste dal tuo piano '
                          'e preferisci cotture semplici.',
                          style: TextStyle(
                            color: Colors.white54,
                            fontSize: 11,
                          ),
                        ),
                      ),
                    ],
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
    final uniqueMeals = <String, MealItem>{};

    for (final day in nutrition) {
      for (final meal in day.meals) {
      uniqueMeals.putIfAbsent(
  '${meal.title}|${meal.ingredients.join('|')}',
  () => meal,
);
      }
    }

    final meals = uniqueMeals.values.toList();

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
                Icons.menu_book_outlined,
                color: Color(0xFFFF4A2A),
              ),
            ),

            const SizedBox(width: 12),

            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'RICETTE FITFORGE',
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 0.5,
                    ),
                  ),
                  SizedBox(height: 3),
                  Text(
                    'Semplici • equilibrate • facili da preparare',
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

        ForgeCard(
          child: Row(
            children: [
              const Icon(
                Icons.restaurant_menu,
                color: Color(0xFFFF6A20),
                size: 28,
              ),

              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${meals.length} ricette nel tuo piano',
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 3),
                    const Text(
                      'Tocca una ricetta per vedere ingredienti e preparazione.',
                      style: TextStyle(
                        color: Colors.white54,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        ...meals.asMap().entries.map(
          (entry) {
            final index = entry.key;
            final meal = entry.value;

            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: InkWell(
                borderRadius: BorderRadius.circular(18),
                onTap: () => _openRecipe(
                  context,
                  meal,
                ),
                child: ForgeCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              gradient: index < 3
                                  ? const LinearGradient(
                                      colors: [
                                        Color(0xFFFF3B22),
                                        Color(0xFFFF7A18),
                                      ],
                                    )
                                  : null,
                              color: index < 3
                                  ? null
                                  : const Color(0xFF202329),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Icon(
                              _mealIcon(meal.title),
                              color: Colors.white,
                            ),
                          ),

                          const SizedBox(width: 12),

                          Expanded(
                            child: Text(
                              meal.title,
                              style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),

                          const Icon(
                            Icons.arrow_forward_ios,
                            color: Color(0xFFFF6A20),
                            size: 16,
                          ),
                        ],
                      ),

                      const SizedBox(height: 14),

                      ...meal.ingredients.take(3).map(
                        (ingredient) => Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      if (meal.ingredients.length > 3)
                        Text(
                          '+ altri ${meal.ingredients.length - 3} ingredienti',
                          style: const TextStyle(
                            color: Colors.white38,
                            fontSize: 10,
                          ),
                        ),

                      const SizedBox(height: 12),

                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0x18FF3B22),
                          borderRadius: BorderRadius.circular(11),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.menu_book_outlined,
                              color: Color(0xFFFF4A2A),
                              size: 18,
                            ),
                            SizedBox(width: 7),
                            Text(
                              'APRI RICETTA',
                              style: TextStyle(
                                color: Color(0xFFFF6A20),
                                fontWeight: FontWeight.w900,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),

        const SizedBox(height: 8),

        const Text(
          'MANGIA BENE • ALLENATI FORTE • MIGLIORA',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFFFF4A2A),
            fontWeight: FontWeight.w900,
            letterSpacing: 1.1,
            fontSize: 10,
          ),
        ),
      ],
    );
  }
}