import 'package:flutter/material.dart';
import 'package:vit_hostel_repo/pages/splash_screen.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Hive.initFlutter();
  await Hive.openBox('userDetails');
  await Hive.openBox('complaints');
  await Hive.openBox('messMenu');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    precacheImage(const AssetImage("assets/images/VIT_Logo.png"), context);
    return const MaterialApp(
      home: SplashScreen(),
    );
  }
}
