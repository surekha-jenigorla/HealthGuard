import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme.dart';

class AwarenessScreen extends StatelessWidget {
  const AwarenessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Health Awareness')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _AwarenessCard(
            title: 'Tobacco / Smoking',
            color: Colors.red.shade700,
            icon: Icons.smoking_rooms,
            effects: [
              ('Lung Cancer', Icons.warning_amber),
              ('Heart Disease', Icons.favorite_border),
              ('Weak Immunity', Icons.shield_outlined),
              ('Breathing Problems', Icons.air),
              ('Premature Aging', Icons.face),
            ],
            fact: 'Smoking kills over 8 million people per year worldwide (WHO).',
          ),
          const SizedBox(height: 16),
          _AwarenessCard(
            title: 'Alcohol Consumption',
            color: Colors.orange.shade800,
            icon: Icons.local_bar,
            effects: [
              ('Liver Damage', Icons.warning_amber),
              ('Brain Problems', Icons.psychology),
              ('High Blood Pressure', Icons.monitor_heart),
              ('Addiction Risk', Icons.loop),
              ('Mental Health Issues', Icons.mood_bad),
            ],
            fact: '3 million deaths every year are linked to alcohol use (WHO).',
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.green.shade200),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  const Icon(Icons.tips_and_updates, color: Colors.green),
                  const SizedBox(width: 8),
                  Text('Daily Tip',
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold, color: Colors.green.shade800)),
                ]),
                const SizedBox(height: 8),
                Text('Keep away from people who encourage smoking or drinking. Your environment shapes your habits.',
                    style: GoogleFonts.poppins(fontSize: 13, color: Colors.green.shade900)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AwarenessCard extends StatelessWidget {
  final String title, fact;
  final Color color;
  final IconData icon;
  final List<(String, IconData)> effects;
  const _AwarenessCard(
      {required this.title,
        required this.color,
        required this.icon,
        required this.effects,
        required this.fact});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.07), blurRadius: 10)]),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: color,
              borderRadius:
              const BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: Row(
              children: [
                Icon(icon, color: Colors.white),
                const SizedBox(width: 8),
                Text(title,
                    style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                ...effects.map((e) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Row(
                    children: [
                      Icon(e.$2, color: color, size: 20),
                      const SizedBox(width: 10),
                      Text(e.$1, style: GoogleFonts.poppins(fontSize: 13)),
                    ],
                  ),
                )),
                const Divider(),
                Row(
                  children: [
                    const Icon(Icons.info_outline, size: 16, color: Colors.grey),
                    const SizedBox(width: 6),
                    Expanded(
                        child: Text(fact,
                            style: GoogleFonts.poppins(
                                fontSize: 11, color: Colors.grey[600]))),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}