import 'package:flutter/material.dart';
import '../screens/group_chat_entry_page.dart';
import '../screens/home_page.dart';
import '../screens/hotel_page.dart';
import '../screens/explore_page.dart';
import '../screens/map_page.dart';
import '../screens/profile_page.dart';
import '../services/auth_service.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key});

  static _MainWrapperState? of(BuildContext context) {
    return context.findAncestorStateOfType<_MainWrapperState>();
  }

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  int currentIndex = 0;

  void setTab(int index) {
    setState(() => currentIndex = index);
  }

  final pages = const [
    HomePage(),
    HotelPage(),
    ExplorePage(),
    MapPage(),
    GroupChatEntryPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    final user = AuthService().currentUser;

    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: SizedBox(
        height: 70,
        child: BottomNavigationBar(
          backgroundColor: const Color(0xFF7A0C0F),
          currentIndex: currentIndex,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white70,
          type: BottomNavigationBarType.fixed,
          onTap: setTab,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.hotel), label: "Hotel"),
            BottomNavigationBarItem(icon: Icon(Icons.explore), label: "Explore"),
            BottomNavigationBarItem(icon: Icon(Icons.map), label: "Map"),
            BottomNavigationBarItem(icon: Icon(Icons.forum), label: "Chat"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
          ],
        ),
      ),
    );
  }
}
