import 'package:flutter/material.dart';
import '../widgets/custom_appbar.dart';

class MapPage extends StatelessWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: const Center(
        child: Text('Map Page Content'),
      ),
    );
  }
}
