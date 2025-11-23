import 'package:flutter/material.dart';
import '../widgets/custom_bottom_navbar.dart';

class MapPage extends StatelessWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map'),
        backgroundColor: const Color(0xFF7A0C0F),
        centerTitle: true,
      ),
      body: const Center(
        child: Text('Map Page Content'),
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 2),
    );
  }
}
