import 'package:flutter/material.dart';
import '../widgets/custom_appbar.dart';

class GroupChatPage extends StatelessWidget {
  const GroupChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Center(
        child: Text(
          "Group Chat Page",
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
