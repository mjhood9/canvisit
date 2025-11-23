import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/custom_bottom_navbar.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = AuthService().currentUser;

    final displayName = user?.displayName ?? "Utilisateur";
    final email = user?.email ?? "Email inconnu";
    final photoURL = user?.photoURL;

    return Scaffold(
      appBar: const CustomAppBar(),

      body: Center(
        child: Card(
          elevation: 6,
          margin: const EdgeInsets.all(24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [

                // ---------- PROFILE IMAGE ----------
                CircleAvatar(
                  radius: 50,
                  backgroundImage: photoURL != null
                      ? NetworkImage(photoURL)
                      : const AssetImage("assets/images/fans.png") as ImageProvider,
                ),

                const SizedBox(height: 20),

                // ---------- NAME ----------
                Text(
                  displayName,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                // ---------- EMAIL ----------
                Text(
                  email,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 3),
    );
  }
}
