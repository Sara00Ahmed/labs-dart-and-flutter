import 'package:flutter/material.dart';
import 'dart:async'; // لاستعمال Timer
import 'package:my_app/resoursces/color_manager.dart';
import 'package:my_app/resoursces/images_manager.dart'; // شاشة الترحيب

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
   Timer(Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/onboarding'); // انتقل لشاشة الترحيب
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.darkColor, // خلفية داكنة
      body: Center(
        child: Image.asset(
          ImagesManager.logo, // اللوجو
          height: 200,
        ),
      ),
    );
  }
}
