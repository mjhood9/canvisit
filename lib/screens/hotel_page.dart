import 'package:flutter/material.dart';
import '../widgets/custom_bottom_navbar.dart';

class HotelPage extends StatelessWidget {
  const HotelPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hotels'),
        backgroundColor: const Color(0xFF7A0C0F),
        centerTitle: true,
      ),
      body: const Center(
        child: Text('Hotel Page Content'),
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 0),
    );
  }
}
