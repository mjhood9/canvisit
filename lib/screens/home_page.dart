import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/custom_bottom_navbar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = AuthService().currentUser;

    return Scaffold(
      appBar: const CustomAppBar(),
      body: SingleChildScrollView( // ✅ SCROLL ENABLED
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),

            // 👋 Welcome text
            Text(
              'Bienvenue, ${user?.displayName ?? 'utilisateur'}',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            /// 🏨 HOTEL CARD
            GestureDetector(
              onTap: () {
                MainWrapper.of(context)?.setTab(1); // Hotel tab
              },
              child: _HomeCard(
                image: 'assets/images/hotel.jpg',
                title: "Trouver les meilleurs hôtels",
                subtitle:
                "Découvrez des hôtels proches des stades et attractions",
              ),
            ),

            const SizedBox(height: 20),

            /// 🌍 EXPLORE CARD
            GestureDetector(
              onTap: () {
                MainWrapper.of(context)?.setTab(2); // Explore tab
              },
              child: _HomeCard(
                image: 'assets/images/explore.jpg',
                title: "Explorer les villes hôtes",
                subtitle:
                "Découvrez les attractions, monuments et lieux incontournables",
              ),
            ),

            const SizedBox(height: 20),

            /// 🗺 MAP CARD
            GestureDetector(
              onTap: () {
                MainWrapper.of(context)?.setTab(3); // Map tab
              },
              child: _HomeCard(
                image: 'assets/images/map.jpg',
                title: "Carte des stades & Fan Zones",
                subtitle:
                "Trouvez les stades, fan zones et itinéraires depuis votre position",
              ),
            ),
            const SizedBox(height: 20),
            /// 💬 GROUP CHAT CARD
            GestureDetector(
              onTap: () {
                MainWrapper.of(context)?.setTab(4); // 4 = Group Chat tab
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Stack(
                  children: [
                    /// 🖼 Background Image
                    Image.asset(
                      'assets/images/chat.jpg', // add image
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),

                    /// 🌑 Gradient overlay
                    Container(
                      height: 200,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Colors.black.withOpacity(0.75),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),

                    /// 📝 Text on image
                    const Positioned(
                      left: 16,
                      right: 16,
                      bottom: 16,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Discuter avec les supporters",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 6),
                          Text(
                            "Rejoignez les groupes de discussion par équipe et partagez votre passion",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30), // extra bottom spacing
          ],
        ),
      ),
    );
  }
}

/// ♻️ Reusable Home Card Widget
class _HomeCard extends StatelessWidget {
  final String image;
  final String title;
  final String subtitle;

  const _HomeCard({
    required this.image,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Stack(
        children: [
          Image.asset(
            image,
            height: 200,
            width: double.infinity,
            fit: BoxFit.cover,
          ),

          // Gradient overlay
          Container(
            height: 200,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.black.withOpacity(0.7),
                  Colors.transparent,
                ],
              ),
            ),
          ),

          // Text
          Positioned(
            left: 16,
            right: 16,
            bottom: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
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
