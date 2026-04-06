import 'package:flutter/material.dart';
import 'theme.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(const HealthGuardApp());
}

class HealthGuardApp extends StatelessWidget {
  const HealthGuardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HealthGuard',
      debugShowCheckedModeBanner: false,
      theme: healthGuardTheme,
      home: const LoginScreen(),
    );
  }
}