import 'package:connectme/screens/onboard_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure binding initialization

  // If you're using Firebase, you should also initialize it like this:
  await Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: 'AIzaSyCiKDZpkWyf72qEDJtw4EesBeH6NL_TB1Y',
    appId: '1:1055435009144:android:a64685bcb7bd42f9a6518d',
    messagingSenderId: 'messagingSenderId',
    projectId: 'connectme-c9041',
    storageBucket: 'connectme-c9041.appspot.com',
  ));

  runApp(const MyApp());

  print("started properly");
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: OnboardingScreen(),
    );
  }
}
