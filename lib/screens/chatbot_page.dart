import 'package:flutter/material.dart';
import '../widgets/custom_back_appbar.dart';

class ChatBotPage extends StatelessWidget {
  const ChatBotPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomBackAppBar(title: "ChatBot"),
      body: const Center(
        child: Text('ChatBot Page Content'),
      ),
    );
  }
}
