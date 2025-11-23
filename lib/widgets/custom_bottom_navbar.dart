import 'package:flutter/material.dart';
import '../screens/hotel_page.dart';
import '../screens/explore_page.dart';
import '../screens/map_page.dart';
import '../screens/profile_page.dart';
import '../services/auth_service.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int? currentIndex;

  const CustomBottomNavBar({super.key, this.currentIndex});

  @override
  Widget build(BuildContext context) {
    final items = [
      {'icon': Icons.hotel, 'page': const HotelPage()},
      {'icon': Icons.explore, 'page': const ExplorePage()},
      {'icon': Icons.map, 'page': const MapPage()},
      {'icon': 'profile', 'page': const ProfilePage()}, // mark profile specially
    ];

    return SizedBox(
      height: 56, // minimized height
      child: BottomAppBar(
        color: const Color(0xFF7A0C0F),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(items.length, (index) {
            final isActive = currentIndex != null && currentIndex == index;

            // If the item is profile
            if (items[index]['icon'] == 'profile') {
              return GestureDetector(
                onTap: () {
                  if (currentIndex != 3) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const ProfilePage()),
                    );
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: currentIndex == 3
                        ? Border.all(color: Colors.white, width: 2) // Active white border
                        : null,
                  ),
                  child: CircleAvatar(
                    radius: 18,
                    backgroundImage: AuthService().currentUser?.photoURL != null
                        ? NetworkImage(AuthService().currentUser!.photoURL!)
                        : const AssetImage('assets/images/fans.png') as ImageProvider,
                  ),
                ),
              );
            }

            // Normal icon button
            return IconButton(
              icon: Icon(
                items[index]['icon'] as IconData,
                color: Colors.white,
                size: isActive ? 28 : 24,
              ),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => items[index]['page'] as Widget),
                );
              },
              padding: const EdgeInsets.symmetric(vertical: 4),
              splashRadius: 20,
            );
          }),
        ),
      ),
    );
  }
}
