import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme.dart';
import '../models/user_data.dart';
import 'login_screen.dart';
import 'survey_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final risk = currentUser.riskLevel;
    final riskColor = risk == 'High' ? kHighRisk : risk == 'Medium' ? kMediumRisk : kLowRisk;

    return Scaffold(
      appBar: AppBar(title: const Text('Your Profile'), actions: [
        IconButton(icon: const Icon(Icons.settings_outlined), onPressed: () {}),
      ]),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Avatar + name
          Center(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: kLightBlue,
                  child: Text(
                    currentUser.name.isNotEmpty
                        ? currentUser.name[0].toUpperCase()
                        : 'U',
                    style: GoogleFonts.poppins(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: kPrimaryBlue),
                  ),
                ),
                const SizedBox(height: 10),
                Text(currentUser.name.isNotEmpty ? currentUser.name : 'User',
                    style: GoogleFonts.poppins(
                        fontSize: 18, fontWeight: FontWeight.bold)),
                Text(currentUser.email,
                    style: GoogleFonts.poppins(color: Colors.grey, fontSize: 13)),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Habits Summary
          _Card(
            title: 'User Habits Summary',
            children: [
              _InfoRow('Smoking', currentUser.smokes ? 'Yes' : 'No'),
              _InfoRow('Alcohol', currentUser.alcoholFrequency.isEmpty ? '—' : currentUser.alcoholFrequency),
              _InfoRow('Stress Level', currentUser.stressLevel.isEmpty ? '—' : currentUser.stressLevel),
              _InfoRow('Age', currentUser.age == 0 ? '—' : '${currentUser.age} years'),
            ],
          ),
          const SizedBox(height: 16),

          // Current Status
          if (risk.isNotEmpty)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: riskColor.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: riskColor.withOpacity(0.3))),
              child: Row(
                children: [
                  Icon(Icons.monitor_heart_outlined, color: riskColor, size: 30),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Current Status',
                          style: GoogleFonts.poppins(
                              color: Colors.grey[600], fontSize: 12)),
                      Text('$risk Risk',
                          style: GoogleFonts.poppins(
                              color: riskColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                ],
              ),
            ),
          const SizedBox(height: 16),

          ElevatedButton.icon(
            icon: const Icon(Icons.assignment_return_outlined),
            label: const Text('Retake Assessment'),
            onPressed: () => Navigator.push(
                context, MaterialPageRoute(builder: (_) => const SurveyScreen())),
          ),
          const SizedBox(height: 10),
          OutlinedButton.icon(
            icon: const Icon(Icons.logout, color: Colors.red),
            label: Text('Log Out',
                style: GoogleFonts.poppins(color: Colors.red)),
            onPressed: () => Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const LoginScreen()),
                  (route) => false,
            ),
            style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}

class _Card extends StatelessWidget {
  final String title;
  final List<Widget> children;
  const _Card({required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8)]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 15)),
          const Divider(),
          ...children,
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label, value;
  const _InfoRow(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: GoogleFonts.poppins(color: Colors.grey[600], fontSize: 13)),
          Row(children: [
            Text(value,
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600, fontSize: 13)),
            const SizedBox(width: 4),
            const Icon(Icons.arrow_forward_ios, size: 12, color: Colors.grey),
          ]),
        ],
      ),
    );
  }
}