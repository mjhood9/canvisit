import 'package:flutter/material.dart';
import '../screens/home_page.dart';
import '../screens/hotel_page.dart';
import '../screens/explore_page.dart';
import '../screens/map_page.dart';
import '../screens/group_chat_page.dart';
import '../screens/profile_page.dart';
import '../services/auth_service.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  int currentIndex = 0;

  final pages = const [
    HomePage(),
    HotelPage(),
    ExplorePage(),
    MapPage(),
    GroupChatPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    final user = AuthService().currentUser;

    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: SizedBox(
        height: 70, // Increased height
        child: BottomNavigationBar(
          backgroundColor: const Color(0xFF7A0C0F),
          currentIndex: currentIndex,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white70,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          onTap: (index) {
            setState(() => currentIndex = index);
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined, size: 26),
              activeIcon: Icon(Icons.home, size: 30), // solid when active
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.hotel_outlined, size: 26),
              activeIcon: Icon(Icons.hotel, size: 30),
              label: "Hotel",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.explore_outlined, size: 26),
              activeIcon: Icon(Icons.explore, size: 30),
              label: "Explore",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.map_outlined, size: 26),
              activeIcon: Icon(Icons.map, size: 30),
              label: "Map",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.forum_outlined, size: 26),
              activeIcon: Icon(Icons.forum, size: 30),
              label: "Chat",
            ),
            BottomNavigationBarItem(
              icon: CircleAvatar(
                radius: 14,
                backgroundImage: (user != null && user.photoURL != null)
                    ? NetworkImage(user.photoURL!)
                    : const AssetImage("assets/images/fans.png") as ImageProvider,
              ),
              activeIcon: Container(
                padding: const EdgeInsets.all(2), // small padding for the border
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: CircleAvatar(
                  radius: 14,
                  backgroundImage: (user != null && user.photoURL != null)
                      ? NetworkImage(user.photoURL!)
                      : const AssetImage("assets/images/fans.png") as ImageProvider,
                ),
              ),
              label: "Profile",
            ),
          ],
        ),
      ),
    );
  }
}
