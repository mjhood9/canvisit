import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import '../widgets/custom_back_appbar.dart';

class ChatBotPage extends StatefulWidget {
  const ChatBotPage({super.key});

  @override
  State<ChatBotPage> createState() => _ChatBotPageState();
}

class _ChatBotPageState extends State<ChatBotPage> with TickerProviderStateMixin {
  final TextEditingController _controller = TextEditingController();

  // messages: role, fullText (complete), displayText (revealed gradually), id
  final List<Map<String, String>> _messages = [];

  // simple local theme (not app-wide) — false = light, true = dark
  bool _isDark = false;

  // typing state
  bool _isTyping = false;

  late GenerativeModel model;
  late ChatSession chat;

  @override
  void initState() {
    super.initState();
    model = GenerativeModel(
      model: 'gemini-2.5-pro',
      apiKey: 'AIzaSyBdtK1VKVFmISw9b-lJWDaLw-Wl5VIdh-M',
    );
    chat = model.startChat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Add message to list (user or bot). For bot, displayText starts empty to animate reveal.
  void _addMessage(String role, String text) {
    final id = DateTime.now().millisecondsSinceEpoch.toString();
    setState(() {
      _messages.add({
        'id': id,
        'role': role,
        'fullText': text,
        'displayText': role == 'bot' ? '' : text,
      });
    });
  }

  // Reveal characters gradually for the last bot message.
  Future<void> _revealLastBotMessage(String fullText) async {
    // find index of last bot msg
    final idx = _messages.lastIndexWhere((m) => m['role'] == 'bot' && (m['displayText'] ?? '') == '');
    if (idx == -1) return;

    final total = fullText.length;
    // base speed: characters per step. Adjust timing for realism.
    final baseDelay = Duration(milliseconds: 16); // ~60 cps
    int i = 0;
    while (i < total) {
      // reveal blocks of characters to avoid UI thrash
      final nextChunk = (i + 3 <= total) ? 3 : (total - i);
      i += nextChunk;
      setState(() {
        _messages[idx]['displayText'] = fullText.substring(0, i);
      });
      // dynamic delay: longer pause on punctuation
      final char = fullText.substring(i - 1, i);
      final punctuationPause = '.!?'.contains(char) ? 180 : (char == ',' ? 80 : 0);
      await Future.delayed(baseDelay + Duration(milliseconds: punctuationPause));
    }
  }

  Future<void> sendMessage() async {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    // add user message
    _addMessage('user', text);
    _controller.clear();

    // show typing
    setState(() {
      _isTyping = true;
    });

    try {
      final response = await chat.sendMessage(Content.text(text));
      final botReply = response.text ?? "⚠️ Le modèle n’a rien renvoyé.";

      // add bot message with empty displayText (will be revealed)
      _addMessage('bot', botReply);

      // small initial delay to make typing feel natural
      await Future.delayed(const Duration(milliseconds: 300));

      // reveal gradually
      await _revealLastBotMessage(botReply);
    } catch (e) {
      _addMessage('bot', "❌ Erreur: $e");
      // reveal error normally (no progressive reveal)
      final idx = _messages.lastIndexWhere((m) => m['role'] == 'bot');
      if (idx != -1) {
        setState(() {
          _messages[idx]['displayText'] = _messages[idx]['fullText'] ?? '';
        });
      }
    } finally {
      setState(() {
        _isTyping = false;
      });
    }
  }

  // Animated entry: slide + fade (used per message)
  Widget _animatedMessageWrapper({required Widget child, required int index}) {
    // Each message will have a slight staggered delay based on index
    final delay = 60 * (index % 10); // ms
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 20.0, end: 0.0),
      duration: const Duration(milliseconds: 420),
      curve: Curves.easeOut,
      builder: (context, value, w) {
        final opacity = (1 - (value / 20)).clamp(0.0, 1.0);
        return Opacity(
          opacity: opacity,
          child: Transform.translate(
            offset: Offset(0, value),
            child: w,
          ),
        );
      },
      child: child,
    );
  }

  // Bubble builder with gradient + markdown support for bot
  Widget _buildMessageItem(Map<String, String> msg, int index) {
    final role = msg['role'] ?? 'bot';
    final display = msg['displayText'] ?? '';
    final full = msg['fullText'] ?? '';
    final isUser = role == 'user';

    final bubbleGradient = isUser
        ? LinearGradient(
      colors: _isDark
          ? [Colors.deepPurple.shade400, Colors.indigo.shade400]
          : [Colors.blue.shade400, Colors.blueAccent.shade400],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    )
        : LinearGradient(
      colors: _isDark
          ? [Colors.grey.shade800, Colors.grey.shade700]
          : [Colors.white, Colors.grey.shade100],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );

    final textColor = isUser ? Colors.white : (_isDark ? Colors.white70 : Colors.black87);

    final messageContent = isUser
        ? // user: simple Text
    Text(
      display,
      style: TextStyle(color: textColor, fontSize: 15, height: 1.35),
    )
        : // bot: render Markdown for richer formatting (code blocks, bold, lists, titles)
    MarkdownBody(
      data: display.isEmpty ? '' : display,
      selectable: true,
      styleSheet: MarkdownStyleSheet(
        p: TextStyle(color: textColor, fontSize: 15, height: 1.35),
        h1: TextStyle(color: textColor, fontSize: 20, fontWeight: FontWeight.bold),
        h2: TextStyle(color: textColor, fontSize: 18, fontWeight: FontWeight.bold),
        code: TextStyle(
          fontFamily: 'monospace',
          backgroundColor: _isDark ? Colors.grey.shade800 : Colors.grey.shade200,
          fontSize: 13,
          color: _isDark ? Colors.greenAccent.shade100 : Colors.orange.shade900,
        ),
        codeblockPadding: const EdgeInsets.all(8),
        codeblockDecoration: BoxDecoration(
          color: _isDark ? Colors.grey.shade900 : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      child: Row(
        mainAxisAlignment: isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isUser)
            Padding(
              padding: const EdgeInsets.only(right: 8.0, top: 2),
              child: CircleAvatar(
                radius: 16,
                backgroundColor: _isDark ? Colors.blueGrey.shade700 : Colors.blue.shade50,
                child: Icon(Icons.smart_toy, color: _isDark ? Colors.white70 : Colors.blue),
              ),
            ),
          Flexible(
            child: _animatedMessageWrapper(
              index: index,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 320),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  decoration: BoxDecoration(
                    gradient: bubbleGradient,
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(18),
                      topRight: const Radius.circular(18),
                      bottomLeft: Radius.circular(isUser ? 18 : 6),
                      bottomRight: Radius.circular(isUser ? 6 : 18),
                    ),
                    boxShadow: [
                      if (isUser)
                        BoxShadow(
                          color: Colors.black.withOpacity(_isDark ? 0.4 : 0.08),
                          blurRadius: 8,
                          offset: const Offset(2, 4),
                        )
                      else
                        BoxShadow(
                          color: Colors.black.withOpacity(_isDark ? 0.35 : 0.04),
                          blurRadius: 6,
                          offset: const Offset(1, 2),
                        )
                    ],
                  ),
                  child: messageContent,
                ),
              ),
            ),
          ),
          if (isUser)
            Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 2),
              child: const CircleAvatar(
                radius: 16,
                backgroundColor: Colors.grey,
                child: Icon(Icons.person, color: Colors.white, size: 18),
              ),
            ),
        ],
      ),
    );
  }

  // Typing indicator: more realistic (bouncing + fade)
  Widget _typingIndicator() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 16,
            backgroundColor: Colors.blueAccent,
            child: Icon(Icons.smart_toy, color: Colors.white, size: 18),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: _isDark ? Colors.grey.shade800 : Colors.white,
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(_isDark ? 0.3 : 0.03),
                  blurRadius: 6,
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                BouncingDot(delay: 0),
                SizedBox(width: 6),
                BouncingDot(delay: 120),
                SizedBox(width: 6),
                BouncingDot(delay: 240),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // top controls: theme toggle + instructions icon
  Widget _topControls() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        children: [
          // theme toggle
          GestureDetector(
            onTap: () => setState(() => _isDark = !_isDark),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: _isDark ? Colors.grey.shade800 : Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(_isDark ? 0.35 : 0.02),
                    blurRadius: 8,
                  ),
                ],
              ),
              child: Row(
                children: [
                  Icon(_isDark ? Icons.dark_mode : Icons.light_mode,
                      color: _isDark ? Colors.white : Colors.black87),
                  const SizedBox(width: 8),
                  Text(_isDark ? 'Sombre' : 'Clair',
                      style: TextStyle(color: _isDark ? Colors.white : Colors.black87)),
                ],
              ),
            ),
          ),
          const Spacer(),
          // small help
          IconButton(
            onPressed: () {
              final snack = SnackBar(
                content: const Text(
                  'Le bot supporte Markdown : **gras**, _italique_, `code`, listes et titres.',
                ),
                duration: const Duration(seconds: 3),
              );
              ScaffoldMessenger.of(context).showSnackBar(snack);
            },
            icon: Icon(Icons.info_outline, color: _isDark ? Colors.white70 : Colors.black54),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bg = _isDark ? Colors.grey.shade900 : Colors.grey.shade50;
    final inputBg = _isDark ? Colors.grey.shade800 : Colors.white;
    final textColor = _isDark ? Colors.white70 : Colors.black87;

    return Scaffold(
      backgroundColor: bg,
      appBar: const CustomBackAppBar(title: "ChatBot"),
      body: Column(
        children: [
          _topControls(),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(bottom: 8),
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 6),
                itemCount: _messages.length + (_isTyping ? 1 : 0),
                reverse: false,
                itemBuilder: (context, index) {
                  // if typing indicator
                  if (_isTyping && index == _messages.length) {
                    return _typingIndicator();
                  }
                  final msg = _messages[index];
                  return _buildMessageItem(msg, index);
                },
              ),
            ),
          ),

          // input area
          SafeArea(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: inputBg,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(_isDark ? 0.6 : 0.03),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          color: _isDark ? Colors.grey.shade800.withOpacity(0.6) : Colors.white.withOpacity(0.8),
                          child: TextField(
                            controller: _controller,
                            style: TextStyle(color: textColor),
                            minLines: 1,
                            maxLines: 5,
                            decoration: InputDecoration(
                              hintText: "Écrivez un message... (Markdown supporté)",
                              hintStyle: TextStyle(color: _isDark ? Colors.white54 : Colors.black45),
                              border: InputBorder.none,
                            ),
                            onSubmitted: (_) => sendMessage(),
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 10),

                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: _isDark
                            ? [Colors.blueGrey.shade700, Colors.blueGrey.shade600]
                            : [Colors.blue.shade500, Colors.blueAccent.shade400],
                      ),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.send, color: Colors.white),
                      onPressed: sendMessage,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Small bouncing dot used in typing indicator
class BouncingDot extends StatefulWidget {
  final int delay;
  const BouncingDot({super.key, this.delay = 0});

  @override
  State<BouncingDot> createState() => _BouncingDotState();
}

class _BouncingDotState extends State<BouncingDot> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _anim;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);

    _anim = Tween<double>(begin: 0.55, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,       // <--- ARGUMENT MANQUANT
        curve: Curves.easeInOut,
      ),
    );
  }


  @override
  void dispose() {
    _controller.stop();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _anim,
      child: Container(width: 8, height: 8, decoration: const BoxDecoration(color: Colors.black54, shape: BoxShape.circle)),
    );
  }
}