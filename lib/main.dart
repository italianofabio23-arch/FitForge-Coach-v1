import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'models/fitness_profile.dart';
import 'screens/home_shell.dart';
import 'screens/profile_screen.dart';
import 'theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final saved = prefs.getString('fitforge_profile');
  final profile = saved == null ? null : FitnessProfile.fromJsonString(saved);
  runApp(FitForgeApp(initialProfile: profile));
}

class FitForgeApp extends StatefulWidget {
  const FitForgeApp({super.key, this.initialProfile});

  final FitnessProfile? initialProfile;

  @override
  State<FitForgeApp> createState() => _FitForgeAppState();
}

class _FitForgeAppState extends State<FitForgeApp> {
  FitnessProfile? _profile;

  @override
  void initState() {
    super.initState();
    _profile = widget.initialProfile;
  }

  Future<void> _saveProfile(FitnessProfile profile) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('fitforge_profile', profile.toJsonString());
    if (!mounted) return;
    setState(() => _profile = profile);
  }

  Future<void> _resetProfile() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('fitforge_profile');
    if (!mounted) return;
    setState(() => _profile = null);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FitForge Coach',
      debugShowCheckedModeBanner: false,
      theme: buildFitForgeTheme(),
      home: _profile == null
          ? ProfileScreen(onCompleted: _saveProfile)
          : HomeShell(profile: _profile!, onResetProfile: _resetProfile),
    );
  }
}
