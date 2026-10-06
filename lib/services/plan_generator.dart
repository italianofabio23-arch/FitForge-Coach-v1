import '../models/fitness_profile.dart';
import '../models/plan_models.dart';

class PlanGenerator {
  static List<WorkoutDay> workouts(FitnessProfile p) {
    final days = <WorkoutDay>[
      const WorkoutDay('Giorno 1', 'Push • Petto, spalle, tricipiti', [
        ExerciseItem('Panca piana', '4 × 6-10', 120),
        ExerciseItem('Spinte manubri inclinata', '3 × 8-12', 90),
        ExerciseItem('Shoulder press', '3 × 8-12', 90),
        ExerciseItem('Alzate laterali', '3 × 12-15', 60),
        ExerciseItem('Push down cavo', '3 × 10-15', 60),
      ]),
      const WorkoutDay('Giorno 2', 'Pull • Schiena, bicipiti', [
        ExerciseItem('Lat machine / trazioni', '4 × 6-10', 120),
        ExerciseItem('Rematore', '4 × 8-12', 90),
        ExerciseItem('Pulley', '3 × 10-12', 75),
        ExerciseItem('Curl manubri', '3 × 10-12', 60),
        ExerciseItem('Curl martello', '2 × 12-15', 60),
      ]),
      const WorkoutDay('Giorno 3', 'Lower • Gambe e glutei', [
        ExerciseItem('Squat / hack squat', '4 × 6-10', 150),
        ExerciseItem('Romanian deadlift', '3 × 8-10', 120),
        ExerciseItem('Leg press', '3 × 10-15', 90),
        ExerciseItem('Leg curl', '3 × 10-15', 75),
        ExerciseItem('Calf raise', '4 × 12-20', 60),
      ]),
      const WorkoutDay('Giorno 4', 'Upper • Richiamo completo', [
        ExerciseItem('Chest press', '3 × 8-12', 90),
        ExerciseItem('Lat machine presa neutra', '3 × 8-12', 90),
        ExerciseItem('Military press', '3 × 8-10', 90),
        ExerciseItem('Rematore macchina', '3 × 10-12', 75),
        ExerciseItem('Superset braccia', '3 × 12+12', 60),
      ]),
      const WorkoutDay('Giorno 5', 'Lower + Core • Gambe, glutei, addome', [
        ExerciseItem('Hip thrust', '4 × 8-12', 120),
        ExerciseItem('Affondi', '3 × 10 per lato', 90),
        ExerciseItem('Leg extension', '3 × 12-15', 60),
        ExerciseItem('Plank', '3 × 45-60 sec', 45),
        ExerciseItem('Crunch cavo', '3 × 12-15', 45),
      ]),
    ];

    if (p.trainingDays <= 3) {
      return [days[0], days[2], days[3]];
    }
    if (p.trainingDays == 4) return days.take(4).toList();
    return days.take(p.trainingDays.clamp(3, 5).toInt()).toList();
  }

  static List<ExerciseItem> homeWorkout() => const [
        ExerciseItem('Push-up', '4 × max tecnico', 60),
        ExerciseItem('Squat a corpo libero', '4 × 20', 60),
        ExerciseItem('Affondi indietro', '3 × 12 per lato', 60),
        ExerciseItem('Pike push-up', '3 × 8-12', 75),
        ExerciseItem('Plank', '3 × 45 sec', 45),
      ];

  static List<NutritionDay> nutrition(int targetCalories) {
    final scale = (targetCalories / 2300).clamp(0.78, 1.35);
    int g(int base) => (base * scale).round();

    MealItem meal(String title, List<String> ingredients, String recipe) =>
        MealItem(title, ingredients, recipe);

    return [
      NutritionDay('Lunedì', [
        meal('Colazione salata', ['Pane integrale ${g(90)} g', 'Uova 2', 'Albume ${g(120)} g', 'Pomodori e spinaci', 'Olio EVO ${g(8)} g'], 'Tosta il pane. Cuoci uova e albume in padella antiaderente con spinaci; aggiungi olio a crudo.'),
        meal('Pranzo', ['Riso basmati ${g(90)} g', 'Pollo ${g(160)} g', 'Zucchine ${g(220)} g', 'Olio EVO ${g(10)} g'], 'Cuoci il riso. Griglia il pollo con spezie; salta le zucchine e unisci tutto.'),
        meal('Cena', ['Salmone ${g(160)} g', 'Patate ${g(280)} g', 'Broccoli ${g(220)} g', 'Olio EVO ${g(8)} g'], 'Cuoci salmone e patate al forno; broccoli al vapore, olio a crudo.'),
      ]),
      NutritionDay('Martedì', [
        meal('Colazione', ['Yogurt greco ${g(250)} g', 'Avena ${g(60)} g', 'Frutti di bosco ${g(120)} g', 'Noci ${g(15)} g'], 'Mescola yogurt e avena; completa con frutti di bosco e noci.'),
        meal('Pranzo', ['Pasta integrale ${g(95)} g', 'Tonno al naturale ${g(150)} g', 'Pomodorini ${g(180)} g', 'Olio EVO ${g(10)} g'], 'Cuoci la pasta al dente e condisci con tonno, pomodorini e olio a crudo.'),
        meal('Cena', ['Tacchino ${g(170)} g', 'Cous cous ${g(85)} g', 'Peperoni ${g(220)} g', 'Avocado ${g(50)} g'], 'Griglia il tacchino, reidrata il cous cous e servi con verdure e avocado.'),
      ]),
      NutritionDay('Mercoledì', [
        meal('Colazione salata', ['Pane di segale ${g(90)} g', 'Ricotta magra ${g(120)} g', 'Bresaola ${g(70)} g', 'Rucola'], 'Tosta il pane e farcisci con ricotta, bresaola e rucola.'),
        meal('Pranzo', ['Gnocchi di patate ${g(250)} g', 'Manzo magro ${g(150)} g', 'Passata di pomodoro', 'Verdure grigliate ${g(200)} g'], 'Prepara un ragù rapido con carne magra e passata; condisci gli gnocchi e accompagna con verdure.'),
        meal('Cena', ['Merluzzo ${g(200)} g', 'Orzo ${g(85)} g', 'Insalata mista ${g(220)} g', 'Olio EVO ${g(10)} g'], 'Cuoci l’orzo; cuoci il merluzzo al vapore o piastra e servi con insalata.'),
      ]),
      NutritionDay('Giovedì', [
        meal('Colazione', ['Porridge: avena ${g(65)} g', 'Latte o bevanda senza zucchero ${g(200)} ml', 'Proteine in polvere ${g(25)} g', 'Banana ${g(100)} g'], 'Cuoci avena e latte 4-5 minuti; spegni, aggiungi proteine e banana.'),
        meal('Pranzo', ['Quinoa ${g(85)} g', 'Ceci cotti ${g(170)} g', 'Verdure miste ${g(250)} g', 'Olio EVO ${g(10)} g'], 'Cuoci la quinoa; unisci ceci e verdure saltate, poi olio a crudo.'),
        meal('Cena', ['Uova 2', 'Albume ${g(180)} g', 'Pane integrale ${g(80)} g', 'Verdure ${g(250)} g'], 'Prepara una frittata al forno o in padella antiaderente e accompagna con pane e verdure.'),
      ]),
      NutritionDay('Venerdì', [
        meal('Colazione salata', ['Piadina integrale ${g(90)} g', 'Fesa di tacchino ${g(100)} g', 'Formaggio fresco light ${g(60)} g', 'Insalata'], 'Scalda la piadina e farcisci con tacchino, formaggio e insalata.'),
        meal('Pranzo', ['Riso venere ${g(90)} g', 'Gamberi ${g(180)} g', 'Zucchine ${g(220)} g', 'Olio EVO ${g(10)} g'], 'Cuoci riso e gamberi separatamente; salta le zucchine e unisci.'),
        meal('Cena', ['Manzo magro ${g(170)} g', 'Patate dolci ${g(260)} g', 'Insalata ${g(220)} g'], 'Griglia la carne; cuoci le patate dolci al forno e servi con insalata.'),
      ]),
      NutritionDay('Sabato', [
        meal('Colazione', ['Skyr ${g(250)} g', 'Muesli senza zuccheri ${g(65)} g', 'Kiwi o mela ${g(150)} g', 'Mandorle ${g(15)} g'], 'Unisci tutto in una bowl.'),
        meal('Pranzo', ['Farro ${g(90)} g', 'Mozzarella light ${g(120)} g', 'Pomodori ${g(200)} g', 'Olio EVO ${g(10)} g'], 'Cuoci il farro, raffredda e condisci con mozzarella, pomodori e olio.'),
        meal('Pasto libero controllato', ['1 pasto a scelta', 'Mantieni una porzione normale', 'Aggiungi verdure', 'Evita di trasformarlo in un’intera giornata libera'], 'Scegli ciò che preferisci e mangia con calma; il pasto libero resta dentro una settimana equilibrata.'),
      ]),
      NutritionDay('Domenica', [
        meal('Colazione salata', ['Pane integrale ${g(90)} g', 'Salmone affumicato ${g(80)} g', 'Uova 2', 'Frutta ${g(150)} g'], 'Tosta il pane, aggiungi salmone e uova; completa con frutta.'),
        meal('Pranzo', ['Pasta di legumi ${g(90)} g', 'Pomodoro', 'Parmigiano ${g(15)} g', 'Verdure ${g(220)} g'], 'Cuoci la pasta di legumi e condisci con salsa semplice, parmigiano e verdure.'),
        meal('Cena', ['Pollo ${g(170)} g', 'Pane di segale ${g(80)} g', 'Verdure ${g(250)} g', 'Olio EVO ${g(10)} g'], 'Griglia il pollo e servi con pane, verdure e olio a crudo.'),
      ]),
    ];
  }
}
