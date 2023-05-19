import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wasty_bin/screens/home_screen.dart';
import 'package:wasty_bin/screens/auth/login_screen.dart';
import 'package:wasty_bin/screens/profile_screen.dart';

import '../main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late StreamSubscription<User?> user;
  @override
  void initState() {
    user = FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user == null) {
        Fluttertoast.showToast(msg: 'signed out!');
      } else {
        Fluttertoast.showToast(msg: 'signed in!');
      }
    });
    super.initState();
    navigateToHome();
  }

  @override
  void dispose() {
    user.cancel();
    super.dispose();
  }

  navigateToHome() async {
    await Future.delayed(const Duration(milliseconds: 1500), () {});
    FirebaseAuth.instance.currentUser == null
        ? Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
          )
        : Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset("assets/images/recycle.png"),
      ),
    );
  }
}
