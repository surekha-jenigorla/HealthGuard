import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme.dart';
import '../models/user_data.dart';
import 'home_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();

  void _register() {
    if (_nameCtrl.text.isNotEmpty && _emailCtrl.text.isNotEmpty) {
      currentUser.name = _nameCtrl.text;
      currentUser.email = _emailCtrl.text;
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const HomeScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Icon(Icons.health_and_safety, size: 70, color: kPrimaryBlue),
            const SizedBox(height: 8),
            Text('Create Account',
                style: GoogleFonts.poppins(
                    fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 24),
            TextFormField(
                controller: _nameCtrl,
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.person_outline), hintText: 'Full Name')),
            const SizedBox(height: 14),
            TextFormField(
                controller: _emailCtrl,
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.email_outlined), hintText: 'Email')),
            const SizedBox(height: 14),
            TextFormField(
                controller: _passCtrl,
                obscureText: true,
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.lock_outline), hintText: 'Password')),
            const SizedBox(height: 24),
            SizedBox(
                width: double.infinity,
                child:
                ElevatedButton(onPressed: _register, child: const Text('Register'))),
          ],
        ),
      ),
    );
  }
}