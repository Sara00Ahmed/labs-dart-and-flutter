import 'package:flutter/material.dart';
import 'package:my_app/resoursces/color_manager.dart';
import 'package:my_app/resoursces/images_manager.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.whiteColor, // خلفية بيضاء
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            ImagesManager.logo, // صورة الترحيب
            height: 250,
          ),
          SizedBox(height: 20),
          Text(
            "Welcome to Flame!",
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: ColorManager.darkColor),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              "Discover and stream your favorite movies and TV shows.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, color: ColorManager.greyColor),
            ),
          ),
          SizedBox(height: 40),
          ElevatedButton(
            onPressed: () {
              // انتقل إلى صفحة التسجيل
               Navigator.pushReplacementNamed(context, '/auth'); // انتقال إلى الصفحة الرئيسية
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorManager.blueColor,
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: Text("Get Started", style: TextStyle(fontSize: 20, color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
