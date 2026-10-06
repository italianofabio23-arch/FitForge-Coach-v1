import 'package:flutter/material.dart';

import '../models/fitness_profile.dart';
import '../services/calorie_service.dart';
import '../services/plan_generator.dart';
import 'dashboard_screen.dart';
import 'nutrition_screen.dart';
import 'progress_screen.dart';
import 'recipes_screen.dart';
import 'workout_screen.dart';

class HomeShell extends StatefulWidget {
  const HomeShell({super.key, required this.profile, required this.onResetProfile});
  final FitnessProfile profile;
  final Future<void> Function() onResetProfile;

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final calories = CalorieService.build(widget.profile);
    final workouts = PlanGenerator.workouts(widget.profile);
    final nutrition = PlanGenerator.nutrition(calories.targetCalories);

    final pages = [
      DashboardScreen(profile: widget.profile, calories: calories, homeWorkout: PlanGenerator.homeWorkout()),
      WorkoutScreen(workouts: workouts),
      NutritionScreen(calories: calories, nutrition: nutrition),
      RecipesScreen(nutrition: nutrition),
      ProgressScreen(profile: widget.profile, onResetProfile: widget.onResetProfile),
    ];

    return Scaffold(
  body: SafeArea(
    child: IndexedStack(
      index: _index,
      children: pages,
    ),
  ),
  bottomNavigationBar: Container(
    decoration: const BoxDecoration(
      border: Border(
        top: BorderSide(
          color: Color(0x33FF3B22),
          width: 1,
        ),
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black54,
          blurRadius: 18,
          offset: Offset(0, -4),
        ),
      ],
    ),
    child: NavigationBar(
      height: 72,
      selectedIndex: _index,
      labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
      onDestinationSelected: (v) {
        setState(() => _index = v);
      },
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.home_outlined),
          selectedIcon: Icon(
            Icons.home,
            color: Color(0xFFFF3B22),
          ),
          label: 'Home',
        ),
        NavigationDestination(
          icon: Icon(Icons.fitness_center_outlined),
          selectedIcon: Icon(
            Icons.fitness_center,
            color: Color(0xFFFF3B22),
          ),
          label: 'Workout',
        ),
        NavigationDestination(
          icon: Icon(Icons.restaurant_menu_outlined),
          selectedIcon: Icon(
            Icons.restaurant_menu,
            color: Color(0xFFFF3B22),
          ),
          label: 'Dieta',
        ),
        NavigationDestination(
          icon: Icon(Icons.menu_book_outlined),
          selectedIcon: Icon(
            Icons.menu_book,
            color: Color(0xFFFF3B22),
          ),
          label: 'Ricette',
        ),
        NavigationDestination(
          icon: Icon(Icons.trending_up_outlined),
          selectedIcon: Icon(
            Icons.trending_up,
            color: Color(0xFFFF3B22),
          ),
          label: 'Progressi',
        ),
      ],
    ),
  ),
);
  }
}
