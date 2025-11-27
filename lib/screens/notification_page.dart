import 'package:flutter/material.dart';
import '../widgets/custom_back_appbar.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomBackAppBar(title: "Notification"),
      body: const Center(
        child: Text('Notification Page Content'),
      ),
    );
  }
}
