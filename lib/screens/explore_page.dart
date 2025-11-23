import 'package:flutter/material.dart';
import '../widgets/custom_bottom_navbar.dart';

class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Explore'),
        backgroundColor: const Color(0xFF7A0C0F),
        centerTitle: true,
      ),
      body: const Center(
        child: Text('Explore Page Content'),
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 1),
    );
  }
}
