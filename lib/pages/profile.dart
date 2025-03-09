


import 'package:flutter/material.dart';
import 'package:my_app/resoursces/color_manager.dart';

class  ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profile")),
      backgroundColor: ColorManager.primaryColor ,
      body: Center(child: Text("Profile Page")),
    );
  }
}
















