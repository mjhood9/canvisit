import 'package:flutter/material.dart';
import '../screens/auth_gate.dart';
import '../screens/home_page.dart';
import '../services/auth_service.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;

  const CustomAppBar({super.key, this.height = kToolbarHeight});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFF7A0C0F),
      elevation: 0,
      automaticallyImplyLeading: false,
      centerTitle: true, // centers the title
      title: GestureDetector(
        onTap: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const HomePage()),
          );
        },
        child: Image.asset(
          'assets/images/canvisit.png',
          height: 40,
          width: 110,
          fit: BoxFit.contain,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(
            Icons.logout,
            color: Colors.white, // make icon white
          ),
          onPressed: () async {
            await AuthService().signOut();
            // Navigate back to AuthGate and clear the stack
            if (context.mounted) {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => const AuthGate()),
                    (route) => false,
              );
            }
          },
          tooltip: 'Se déconnecter',
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
