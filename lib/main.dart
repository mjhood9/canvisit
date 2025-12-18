// import 'package:canvisit/seeders/agadir_seeder.dart';
// import 'package:canvisit/seeders/fes_seeder.dart';
// import 'package:canvisit/seeders/marrakech_seeder.dart';
// import 'package:canvisit/seeders/rabat_seeder.dart';
// import 'package:canvisit/seeders/tangier_seeder.dart';
// import './seeders/casablanca_seeder.dart';
import 'package:canvisit/seeders/groupchat_seeder.dart';
import 'package:canvisit/services/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'firebase_options.dart';
import 'screens/auth_gate.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 1️⃣ Initialize Firebase FIRST
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await NotificationService.initialize();
  // await seedCan2025GroupChats();
  // await seedCasablancaAttractions();
  // await seedRabatAttractions();
  // await seedTangierAttractions();
  // await seedMarrakechAttractions();
  // await seedFesAttractions();
  // await seedAgadirAttractions();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData base = ThemeData.light();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Auth Zellige',
      theme: base.copyWith(
        textTheme: GoogleFonts.cairoTextTheme(base.textTheme),
        colorScheme: base.colorScheme.copyWith(
          primary: const Color(0xFFB71C1C),
          secondary: const Color(0xFF2E7D32),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFB71C1C),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(
              vertical: 14,
              horizontal: 24,
            ),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(
              vertical: 14,
              horizontal: 24,
            ),
          ),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
        ),
      ),
      home: const AuthGate(),
    );
  }
}
