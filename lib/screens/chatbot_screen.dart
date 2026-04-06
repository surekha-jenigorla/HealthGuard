import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme.dart';

class ChatbotScreen extends StatefulWidget {
  const ChatbotScreen({super.key});
  @override
  State<ChatbotScreen> createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  final _ctrl = TextEditingController();
  final _scroll = ScrollController();
  final List<_Msg> _messages = [
    _Msg(false, 'Hi! I am HealthGuard AI 🤖\nHow can I assist you today?'),
    _Msg(false,
        'You can ask me about:\n• Quitting smoking\n• Reducing alcohol\n• Managing stress\n• Healthy habits'),
  ];

  static const _qa = [
    (['quit smoking', 'stop smoking', 'how to quit', 'cigarette'],
    'To quit smoking:\n1. Set a quit date and commit.\n2. Tell friends & family for support.\n3. Use nicotine patches or gum for cravings.\n4. Avoid triggers like coffee or alcohol.\n5. Reward yourself for every smoke-free day! 🎉'),
    (['craving', 'urge', 'temptation'],
    'When a craving hits, try the 4 D\'s:\n• Delay — wait it out (cravings last 3–5 min)\n• Deep breathe\n• Drink water\n• Do something else!\nYou got this! 💪'),
    (['alcohol', 'drink', 'reduce drinking'],
    'To reduce alcohol:\n1. Set a weekly drink limit.\n2. Keep alcohol out of your home.\n3. Replace drinks with sparkling water or juice.\n4. Track your drinks in a journal.\n5. Find stress-free hobbies.'),
    (['stress', 'anxiety', 'relaxation'],
    'To manage stress:\n• Practice 5-min deep breathing daily.\n• Go for a 20-min walk.\n• Listen to calming music.\n• Talk to a trusted friend.\n• Try yoga or meditation apps.'),
    (['tip', 'advice', 'habit', 'healthy'],
    'Healthy habit tips:\n1. Drink 8 glasses of water daily.\n2. Sleep 7–8 hours per night.\n3. Exercise at least 30 min/day.\n4. Eat fruits and vegetables.\n5. Avoid junk food and processed sugar.'),
    (['risk', 'danger', 'effect', 'harm'],
    'Smoking & alcohol can cause:\n• Lung cancer & heart disease\n• Liver damage\n• High blood pressure\n• Mental health issues\n• Shortened lifespan\n\nQuitting even partially helps a lot!'),
  ];

  String _getReply(String input) {
    final lower = input.toLowerCase();
    for (final (keys, reply) in _qa) {
      if (keys.any((k) => lower.contains(k))) return reply;
    }
    return 'I\'m here to help with smoking, alcohol, stress, and healthy habits. Try asking about quitting smoking or managing stress! 😊';
  }

  void _send() {
    final text = _ctrl.text.trim();
    if (text.isEmpty) return;
    setState(() {
      _messages.add(_Msg(true, text));
      _ctrl.clear();
    });
    Future.delayed(const Duration(milliseconds: 700), () {
      if (mounted) {
        setState(() => _messages.add(_Msg(false, _getReply(text))));
        Future.delayed(const Duration(milliseconds: 100), () {
          _scroll.animateTo(_scroll.position.maxScrollExtent,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(children: [
          const CircleAvatar(
              radius: 16,
              backgroundColor: Colors.white,
              child: Icon(Icons.smart_toy, color: kPrimaryBlue, size: 18)),
          const SizedBox(width: 10),
          Text('Health AI',
              style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600)),
        ]),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scroll,
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (_, i) => _BubbleWidget(msg: _messages[i]),
            ),
          ),
          // Input
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _ctrl,
                    decoration: InputDecoration(
                      hintText: 'Ask anything about health...',
                      hintStyle: GoogleFonts.poppins(fontSize: 13),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                    ),
                    onSubmitted: (_) => _send(),
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: _send,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: const BoxDecoration(
                        color: kPrimaryBlue, shape: BoxShape.circle),
                    child: const Icon(Icons.send, color: Colors.white, size: 18),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Msg {
  final bool isUser;
  final String text;
  _Msg(this.isUser, this.text);
}

class _BubbleWidget extends StatelessWidget {
  final _Msg msg;
  const _BubbleWidget({required this.msg});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: msg.isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
        decoration: BoxDecoration(
          color: msg.isUser ? kPrimaryBlue : Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: Radius.circular(msg.isUser ? 16 : 4),
            bottomRight: Radius.circular(msg.isUser ? 4 : 16),
          ),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.07), blurRadius: 6)],
        ),
        child: Text(
          msg.text,
          style: GoogleFonts.poppins(
              color: msg.isUser ? Colors.white : Colors.black87, fontSize: 13),
        ),
      ),
    );
  }
}