import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme.dart';
import '../models/user_data.dart';
import 'survey_screen.dart';
import 'awareness_screen.dart';
import 'suggestions_screen.dart';
import 'profile_screen.dart';
import 'chatbot_screen.dart';

const _tips = [
  "Drink 8 glasses of water daily to flush toxins.",
  "Take a 10-min walk after meals to boost metabolism.",
  "Deep breathing for 5 minutes reduces stress significantly.",
  "Replace cigarette breaks with a healthy snack.",
  "Sleep 7–8 hours to let your body heal.",
  "Call a friend instead of reaching for a drink.",
  "Exercise releases dopamine — nature's mood booster.",
  "Track your smoke-free days for motivation.",
  "Eat green vegetables daily for natural detox.",
  "Chew gum or sunflower seeds to beat cravings.",
];

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _tab = 0;

  final _pages = const [_HomePage(), AwarenessScreen(), SuggestionsScreen(), ProfileScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_tab],
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (_) => const ChatbotScreen())),
        backgroundColor: kPrimaryBlue,
        child: const Icon(Icons.smart_toy, color: Colors.white),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _tab,
        onTap: (i) => setState(() => _tab = i),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: kPrimaryBlue,
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w600),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), activeIcon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.menu_book_outlined), activeIcon: Icon(Icons.menu_book), label: 'Awareness'),
          BottomNavigationBarItem(icon: Icon(Icons.lightbulb_outline), activeIcon: Icon(Icons.lightbulb), label: 'Suggestions'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), activeIcon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

class _HomePage extends StatelessWidget {
  const _HomePage();

  @override
  Widget build(BuildContext context) {
    final tip = _tips[DateTime.now().day % _tips.length];
    final risk = currentUser.riskLevel;
    final riskColor = risk == 'High' ? kHighRisk : risk == 'Medium' ? kMediumRisk : kLowRisk;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 180,
            pinned: true,
            backgroundColor: kPrimaryBlue,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      colors: [kDarkBlue, kAccentBlue],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight),
                ),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text('Hello, ${currentUser.name.isNotEmpty ? currentUser.name : "User"} 👋',
                            style: GoogleFonts.poppins(
                                color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                        Text('Track your health today',
                            style: GoogleFonts.poppins(color: Colors.white70, fontSize: 13)),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // Daily tip
                _TipCard(tip: tip),
                const SizedBox(height: 16),
                // Risk status (if assessed)
                if (risk.isNotEmpty) ...[
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: riskColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: riskColor.withOpacity(0.3)),
                    ),
                    child: Row(
                      children: [
                        Icon(
                            risk == 'High'
                                ? Icons.warning_amber_rounded
                                : risk == 'Medium'
                                ? Icons.info_outline
                                : Icons.check_circle_outline,
                            color: riskColor,
                            size: 36),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Current Risk Level',
                                  style: GoogleFonts.poppins(
                                      color: Colors.grey[600], fontSize: 12)),
                              Text('$risk Risk',
                                  style: GoogleFonts.poppins(
                                      color: riskColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
                // Quick Actions
                Text('Quick Actions',
                    style: GoogleFonts.poppins(
                        fontSize: 16, fontWeight: FontWeight.w600)),
                const SizedBox(height: 12),
                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1.4,
                  children: [
                    _QuickAction(
                        icon: Icons.assignment_outlined,
                        label: 'Take Survey',
                        color: kPrimaryBlue,
                        onTap: () => Navigator.push(context,
                            MaterialPageRoute(builder: (_) => const SurveyScreen()))),
                    _QuickAction(
                        icon: Icons.menu_book_outlined,
                        label: 'Awareness',
                        color: Colors.teal,
                        onTap: () {}),
                    _QuickAction(
                        icon: Icons.lightbulb_outline,
                        label: 'Suggestions',
                        color: Colors.orange,
                        onTap: () {}),
                    _QuickAction(
                        icon: Icons.smart_toy_outlined,
                        label: 'AI Chatbot',
                        color: Colors.purple,
                        onTap: () => Navigator.push(context,
                            MaterialPageRoute(builder: (_) => const ChatbotScreen()))),
                  ],
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class _TipCard extends StatelessWidget {
  final String tip;
  const _TipCard({required this.tip});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
            colors: [Color(0xFF1565C0), Color(0xFF42A5F5)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          const Icon(Icons.tips_and_updates, color: Colors.yellow, size: 32),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Daily Health Tip',
                    style: GoogleFonts.poppins(
                        color: Colors.white70,
                        fontSize: 11,
                        fontWeight: FontWeight.w500)),
                Text(tip,
                    style: GoogleFonts.poppins(
                        color: Colors.white, fontSize: 13)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _QuickAction extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;
  const _QuickAction(
      {required this.icon,
        required this.label,
        required this.color,
        required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: color.withOpacity(0.15), blurRadius: 10)],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(height: 6),
            Text(label,
                style: GoogleFonts.poppins(
                    fontSize: 12, fontWeight: FontWeight.w600, color: Colors.black87)),
          ],
        ),
      ),
    );
  }
}