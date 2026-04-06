import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme.dart';
import '../models/user_data.dart';

class SuggestionsScreen extends StatelessWidget {
  const SuggestionsScreen({super.key});

  List<Map<String, dynamic>> _getSuggestions() {
    final risk = currentUser.riskLevel;
    List<Map<String, dynamic>> base = [
      {'icon': Icons.water_drop_outlined, 'title': 'Drink More Water', 'desc': 'Aim for 8 glasses daily to detox your body naturally.', 'color': Colors.blue},
      {'icon': Icons.directions_walk, 'title': 'Walk Daily', 'desc': '30 minutes of walking daily boosts mood and reduces cravings.', 'color': Colors.green},
      {'icon': Icons.bedtime_outlined, 'title': 'Sleep Better', 'desc': '7–8 hours of quality sleep helps your body recover.', 'color': Colors.indigo},
    ];
    if (currentUser.smokes) {
      base.insert(0, {'icon': Icons.smoke_free, 'title': 'Reduce Smoking Today', 'desc': 'Start by cutting one cigarette per day. Every step counts!', 'color': Colors.red});
    }
    if (currentUser.alcoholFrequency != 'never') {
      base.insert(0, {'icon': Icons.no_drinks, 'title': 'Limit Alcohol', 'desc': 'Set a weekly alcohol limit and stick to it. Replace with juice or water.', 'color': Colors.orange});
    }
    if (currentUser.stressLevel == 'high' || currentUser.stressLevel == 'medium') {
      base.add({'icon': Icons.self_improvement, 'title': 'Manage Stress', 'desc': 'Try 5-minute breathing exercises or meditation apps daily.', 'color': Colors.purple});
    }
    return base;
  }

  @override
  Widget build(BuildContext context) {
    final suggestions = _getSuggestions();
    final risk = currentUser.riskLevel;

    return Scaffold(
      appBar: AppBar(title: const Text('Your Suggestions')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          if (risk.isNotEmpty)
            Container(
              padding: const EdgeInsets.all(14),
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                  color: kLightBlue,
                  borderRadius: BorderRadius.circular(12)),
              child: Text(
                'Personalized for you based on your $risk Risk profile',
                style: GoogleFonts.poppins(color: kDarkBlue, fontWeight: FontWeight.w500),
              ),
            ),
          if (risk.isEmpty)
            Container(
              padding: const EdgeInsets.all(14),
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                  color: Colors.orange.shade50,
                  borderRadius: BorderRadius.circular(12)),
              child: Text(
                'Take the survey first for personalized suggestions!',
                style: GoogleFonts.poppins(color: Colors.orange.shade800),
              ),
            ),
          ...suggestions.map((s) => Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                      color: (s['color'] as Color).withOpacity(0.1),
                      blurRadius: 10)
                ]),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: (s['color'] as Color).withOpacity(0.1),
                      shape: BoxShape.circle),
                  child: Icon(s['icon'] as IconData,
                      color: s['color'] as Color, size: 24),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(s['title'],
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600, fontSize: 14)),
                      Text(s['desc'],
                          style: GoogleFonts.poppins(
                              fontSize: 12, color: Colors.grey[600])),
                    ],
                  ),
                ),
                const Icon(Icons.arrow_forward_ios,
                    size: 14, color: Colors.grey),
              ],
            ),
          )),
        ],
      ),
    );
  }
}