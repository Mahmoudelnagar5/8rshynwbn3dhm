import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:expense_tracker/features/auth/presentation/view/screens/sign_in_screen.dart';
import 'package:expense_tracker/features/home/presentation/views/home_screen.dart';
import 'package:expense_tracker/features/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  Future<void> _navigateToNextScreen() async {
    await Future.delayed(const Duration(seconds: 3));

    var box = await Hive.openBox('auth');
    bool hasCompletedOnboarding = box.get(
      'hasCompletedOnboarding',
      defaultValue: false,
    );
    bool isLoggedIn = box.get('isLoggedIn', defaultValue: false);
    User? currentUser = FirebaseAuth.instance.currentUser;

    if (!hasCompletedOnboarding) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const OnboardingView()),
      );
    } else if (isLoggedIn && currentUser != null && currentUser.emailVerified) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const SignInScreen()),
      );
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(247, 247, 247, 247),

      body: Center(
        child: ZoomIn(
          duration: const Duration(milliseconds: 1500),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/logo.png', height: 150, width: 300),
              const SizedBox(height: 20),
              const Text(
                "Monex",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
