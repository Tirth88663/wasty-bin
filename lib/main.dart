import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wasty_bin/screens/auth/email_verification_screen.dart';
import 'package:wasty_bin/screens/auth/forgot_password_screen.dart';
import 'package:wasty_bin/screens/auth/signup_screen.dart';
import 'package:wasty_bin/screens/home_screen.dart';
import 'package:wasty_bin/screens/auth/login_screen.dart';
import 'package:wasty_bin/screens/profile_screen.dart';
import 'package:wasty_bin/screens/splash_screen.dart';
import 'package:wasty_bin/theme/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      // options: const FirebaseOptions(
      //   apiKey: "AIzaSyDnS9Vq8mgWg4FyGiQ_6L2j3nC0nLsL1ak", // Your apiKey
      //   appId: "1:21489994861:android:1c4e29bc93f39a0b8f8364", // Your appId
      //   messagingSenderId: "XXX", // Your messagingSenderId
      //   projectId: "wasty-bin-327ed", // Your projectId
      // ),
      );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
        primaryColor: Colors.white,
        appBarTheme: AppBarTheme(
            centerTitle: true,
            backgroundColor: primaryColor,
            elevation: 0.0,
            iconTheme: IconThemeData(color: primaryColor)),
        brightness: Brightness.light,
      ),
      initialRoute: "/",
      routes: {
        '/': (context) => const SplashScreen(),
        // '/': (context) => const EmailVerficationScreen(),
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignUpScreen(),
        '/email': (context) => const EmailVerficationScreen(),
        '/forgot': (context) => const ForgotPasswordScreen(),
        '/home': (context) => const HomeScreen(),
        '/profile': (context) => const ProfileScreen(),
      },
    );
  }
}
