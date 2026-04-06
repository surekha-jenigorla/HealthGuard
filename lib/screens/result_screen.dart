import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme.dart';
import '../models/user_data.dart';
import 'survey_screen.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final risk = currentUser.riskLevel;
    final reasons = currentUser.getRiskReasons();
    final riskColor = risk == 'High' ? kHighRisk : risk == 'Medium' ? kMediumRisk : kLowRisk;
    final riskIcon = risk == 'High'
        ? Icons.warning_amber_rounded
        : risk == 'Medium'
        ? Icons.info_outline
        : Icons.check_circle_outline;

    return Scaffold(
      appBar: AppBar(title: const Text('Your Health Result')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Risk Banner
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: riskColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: riskColor, width: 2),
              ),
              child: Column(
                children: [
                  Icon(riskIcon, color: riskColor, size: 60),
                  const SizedBox(height: 8),
                  Text('$risk Risk',
                      style: GoogleFonts.poppins(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: riskColor)),
                  if (risk == 'High')
                    Text('⚠️ Immediate Attention Needed!',
                        style: GoogleFonts.poppins(
                            color: riskColor, fontWeight: FontWeight.w500)),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Reasons
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8)
                  ]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Why you are at risk:',
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold, fontSize: 15)),
                  const SizedBox(height: 10),
                  ...reasons.map((r) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      children: [
                        Icon(Icons.circle, size: 8, color: riskColor),
                        const SizedBox(width: 10),
                        Expanded(child: Text(r, style: GoogleFonts.poppins(fontSize: 13))),
                      ],
                    ),
                  )),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Health Message
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(16)),
              child: Row(
                children: [
                  const Icon(Icons.tips_and_updates, color: kPrimaryBlue),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      risk == 'High'
                          ? 'Please consult a doctor immediately and start your journey to quit smoking and alcohol.'
                          : risk == 'Medium'
                          ? 'You have some risk factors. Start making small changes for a healthier life.'
                          : 'Great job! Keep maintaining your healthy habits.',
                      style: GoogleFonts.poppins(fontSize: 13, color: kDarkBlue),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.refresh),
                label: const Text('Re-Check Your Risk'),
                onPressed: () => Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => const SurveyScreen())),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Back to Home'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}