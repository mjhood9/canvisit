import 'package:flutter/material.dart';
import '../screens/group_chat_entry_page.dart';
import '../screens/home_page.dart';
import '../screens/hotel_page.dart';
import '../screens/explore_page.dart';
import '../screens/map_page.dart';
import '../screens/profile_page.dart';
import '../services/auth_service.dart';
import '../services/notification_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

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

  @override
  void initState() {
    super.initState();
    // 🚀 Update the token as soon as the authenticated UI loads
    NotificationService.updateFcmToken();

    // 🔔 (Optional) Listen for notification taps while the app is running
    _setupInteractedMessage();
  }

  Future<void> _setupInteractedMessage() async {
    // This handles opening the app from a terminated state via notification
    RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      _handleMessageNavigation(initialMessage);
    }

    // This handles tapping a notification while the app is in the background
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessageNavigation);
  }

  void _handleMessageNavigation(RemoteMessage message) {
    if (message.data['groupId'] != null) {
      // Use your Navigator to go to TeamChatPage
    }
  }

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
