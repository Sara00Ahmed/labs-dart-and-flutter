import 'package:flutter/material.dart';
import 'package:my_app/resoursces/color_manager.dart';
import 'package:my_app/resoursces/images_manager.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _isLogin = true; // Default to login
  bool _obscurePassword = true; // Toggle for password visibility
  bool _obscureConfirmPassword = true; // Toggle for password visibility


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 50),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [ColorManager.blueColor, ColorManager.whiteColor],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // App Logo
                Image.asset(ImagesManager.logo, height: 100),
                SizedBox(height: 10),

                // Login / Register Title
                Text(
                  _isLogin ? 'Welcome Back' : 'Create an Account',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: ColorManager.darkColor),
                ),
                SizedBox(height: 20),

              // Username Field
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Username',
                    prefixIcon: Icon(Icons.person, color: ColorManager.blueColor),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
                SizedBox(height: 15),

                // Email Field
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Email',
                    prefixIcon: Icon(Icons.email, color: ColorManager.blueColor),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
                SizedBox(height: 15),

                // Password Field
                TextField(
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    prefixIcon: Icon(Icons.lock, color: ColorManager.blueColor),
                    suffixIcon: IconButton(
                      icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility),
                      onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                    ),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),

                if (!_isLogin) ...[
                  SizedBox(height: 15),

                  // Confirm Password (For Register)
                  TextField(
                    obscureText: _obscureConfirmPassword,
                    decoration: InputDecoration(
                      hintText: 'Confirm Password',
                      prefixIcon: Icon(Icons.lock, color: ColorManager.blueColor),
                      suffixIcon: IconButton(
                        onPressed: () => setState(() => _obscureConfirmPassword = !_obscureConfirmPassword),
                        icon:Icon(_obscureConfirmPassword ? Icons.visibility_off : Icons.visibility),),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                      filled: true,
                      fillColor:ColorManager.whiteColor,
                    ),
                  ),
                ],

                SizedBox(height: 20),

                // Login / Register Button
                ElevatedButton(
                  onPressed: () {
                    if (_isLogin) {
                          // إذا كان تسجيل دخول، انتقل إلى الهوم
                   Navigator.pushReplacementNamed(context, '/home'); // انتقل لشاشة الرئيسية
                    } else {
                       // إذا كان تسجيل جديد، قم بتغيير الحالة إلى تسجيل دخول
                      setState(() {
                        _isLogin = true;
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorManager.blueColor,
                    padding: EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    minimumSize: Size(double.infinity, 50),
                  ),
                  child: Text(
                    _isLogin ? 'Login' : 'Register',
                    style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),

                SizedBox(height: 15),

                // Divider with "OR"
                Row(
                  children: [
                    Expanded(child: Divider(thickness: 1, color: ColorManager.greyColor)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text("OR", style: TextStyle(color: ColorManager.greyColor)),
                    ),
                    Expanded(child: Divider(thickness: 1, color: ColorManager.greyColor)),
                  ],
                ),
                SizedBox(height: 10),

                // Toggle between Login & Register
                TextButton(
                  onPressed: () {
                    setState(() {
                      _isLogin = !_isLogin;
                    });
                  },
                  child: Text(
                    _isLogin ? "Don't have an account? Register" : "Already have an account? Login",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: ColorManager.blueColor),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
