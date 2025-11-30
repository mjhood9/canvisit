import 'package:flutter/material.dart';
import '../screens/chatbot_page.dart';
import '../screens/notification_page.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;

  const CustomAppBar({super.key, this.height = kToolbarHeight});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFF7A0C0F),
      elevation: 0,
      automaticallyImplyLeading: false,
      centerTitle: true,
      title: GestureDetector(
        child: Image.asset(
          'assets/images/canvisit.png',
          height: 40,
          width: 110,
          fit: BoxFit.contain,
        ),
      ),
      leading: IconButton(
        icon: const Icon(Icons.chat_bubble_outline, color: Colors.white),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ChatBotPage()),
          );
        },
        tooltip: 'Chatbot',
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications_none, color: Colors.white),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const NotificationPage()),
            );
          },
          tooltip: 'Notifications',
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
