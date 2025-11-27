import 'package:flutter/material.dart';
import '../widgets/custom_appbar.dart';

class HotelPage extends StatelessWidget {
  const HotelPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: const Center(
        child: Text('Hotel Page Content'),
      ),
    );
  }
}
