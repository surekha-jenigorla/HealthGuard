import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme.dart';
import '../models/user_data.dart';
import 'result_screen.dart';

class SurveyScreen extends StatefulWidget {
  const SurveyScreen({super.key});
  @override
  State<SurveyScreen> createState() => _SurveyScreenState();
}

class _SurveyScreenState extends State<SurveyScreen> {
  bool _smokes = false;
  String _alcohol = 'never';
  String _stress = 'low';
  int _age = 22;
  bool _analyzing = false;

  void _submit() async {
    setState(() => _analyzing = true);
    await Future.delayed(const Duration(seconds: 2));
    currentUser.smokes = _smokes;
    currentUser.alcoholFrequency = _alcohol;
    currentUser.stressLevel = _stress;
    currentUser.age = _age;
    currentUser.riskLevel = currentUser.calculateRisk();
    if (mounted) {
      setState(() => _analyzing = false);
      Navigator.push(context, MaterialPageRoute(builder: (_) => const ResultScreen()));
    }
  }

  Widget _choiceChip(String label, String value, String groupValue, Function(String) onTap) {
    final selected = value == groupValue;
    return GestureDetector(
      onTap: () => onTap(value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: selected ? kPrimaryBlue : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: selected ? kPrimaryBlue : Colors.grey.shade300),
        ),
        child: Text(label,
            style: GoogleFonts.poppins(
                color: selected ? Colors.white : Colors.black87,
                fontWeight: FontWeight.w500)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_analyzing) {
      return Scaffold(
        appBar: AppBar(title: const Text('AI Risk Analysis')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.psychology, size: 80, color: kPrimaryBlue),
              const SizedBox(height: 20),
              Text('Analyzing Your Data...',
                  style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold)),
              Text('Please wait a moment.',
                  style: GoogleFonts.poppins(color: Colors.grey)),
              const SizedBox(height: 32),
              ...[
                'Checking smoking habit',
                'Checking alcohol intake',
                'Checking stress level',
                'Calculating risk score',
              ].map((s) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.check_circle, color: Colors.green),
                    const SizedBox(width: 8),
                    Text(s, style: GoogleFonts.poppins()),
                  ],
                ),
              )),
              const SizedBox(height: 20),
              const CircularProgressIndicator(),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Habit Assessment')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _Question(
              number: '1',
              question: 'Do you smoke?',
              child: Row(
                children: [
                  _choiceChip('Yes', true.toString(), _smokes.toString(),
                          (v) => setState(() => _smokes = v == 'true')),
                  const SizedBox(width: 12),
                  _choiceChip('No', false.toString(), _smokes.toString(),
                          (v) => setState(() => _smokes = v == 'true')),
                ],
              ),
            ),
            _Question(
              number: '2',
              question: 'How often do you drink alcohol?',
              child: Wrap(
                spacing: 10,
                children: ['never', 'sometimes', 'daily'].map((v) {
                  final labels = {'never': 'Never', 'sometimes': 'Sometimes', 'daily': 'Daily'};
                  return _choiceChip(labels[v]!, v, _alcohol,
                          (val) => setState(() => _alcohol = val));
                }).toList(),
              ),
            ),
            _Question(
              number: '3',
              question: 'Stress Level',
              child: Wrap(
                spacing: 10,
                children: ['low', 'medium', 'high'].map((v) {
                  final labels = {'low': '😊 Low', 'medium': '😐 Medium', 'high': '😟 High'};
                  return _choiceChip(labels[v]!, v, _stress,
                          (val) => setState(() => _stress = val));
                }).toList(),
              ),
            ),
            _Question(
              number: '4',
              question: 'Your Age',
              child: Row(
                children: [
                  Expanded(
                    child: Slider(
                      value: _age.toDouble(),
                      min: 10,
                      max: 80,
                      divisions: 70,
                      activeColor: kPrimaryBlue,
                      onChanged: (v) => setState(() => _age = v.round()),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                        color: kLightBlue, borderRadius: BorderRadius.circular(10)),
                    child: Text('$_age yrs',
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold, color: kPrimaryBlue)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: _submit,
                    child: const Text('Submit & Analyze'))),
          ],
        ),
      ),
    );
  }
}

class _Question extends StatelessWidget {
  final String number, question;
  final Widget child;
  const _Question({required this.number, required this.question, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8)]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                  radius: 12,
                  backgroundColor: kPrimaryBlue,
                  child: Text(number,
                      style: GoogleFonts.poppins(color: Colors.white, fontSize: 12))),
              const SizedBox(width: 10),
              Text(question,
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 14)),
            ],
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}