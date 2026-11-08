import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'onboarding_screen.dart';
import 'sebha_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var preferences = await SharedPreferences.getInstance();
  var onboardingSeen = preferences.getBool('onboardingSeen') ?? false;

  runApp(
    MaterialApp(
      title: 'Islami App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: onboardingSeen ? const SebhaScreen() : const OnboardingScreen(),
    ),
  );
}
