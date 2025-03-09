

import 'package:flutter/material.dart';
import 'package:my_app/resoursces/color_manager.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: const Text("Settings")),
      backgroundColor:ColorManager.blueColor ,
      body: Center(
            child: Text("Settings Page"),
      ),
    );
  }
}