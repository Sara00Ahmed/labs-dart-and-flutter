// تنظيم عرض الشاشات

import 'package:flutter/material.dart';
import 'package:my_app/pages/auth.dart';
import 'package:my_app/pages/home.dart';
import 'package:my_app/onboarding/onboarding.dart';
import 'package:my_app/pages/movielist.dart';
import 'package:my_app/pages/profile.dart';
import 'package:my_app/pages/settings.dart';
import 'package:my_app/pages/splash.dart';

class MyApp extends StatelessWidget {
    const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,   //// يحدد الوضع بناءً على إعدادات النظام
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
      initialRoute: '/splash', // الصفحة الافتراضية للتطبيق
      routes: {
        '/splash': (context) =>  SplashScreen(),
        '/onboarding': (context) =>  OnboardingScreen(),
        '/auth': (context) =>  AuthScreen(),
        '/home': (context) =>  MyHomePage(),
        '/movielist': (context) =>  MovieListScreen(),
        '/profile': (context) =>  ProfilePage(),
        '/settings': (context) =>  SettingsPage(),
      },
    );
  }
}








