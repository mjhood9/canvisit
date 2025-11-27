import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../screens/auth_gate.dart';
import '../widgets/custom_appbar.dart';

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

                CircleAvatar(
                  radius: 50,
                  backgroundImage: photoURL != null
                      ? NetworkImage(photoURL)
                      : const AssetImage("assets/images/fans.png") as ImageProvider,
                ),

                const SizedBox(height: 20),

                Text(
                  displayName,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  email,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),

                const SizedBox(height: 24),

                // ---------- LOGOUT BUTTON ----------
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFC62828),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 28, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  icon: const Icon(Icons.logout),
                  label: const Text("Se déconnecter"),
                  onPressed: () async {
                    await AuthService().signOut();

                    if (context.mounted) {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (_) => const AuthGate()),
                            (route) => false,
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
