import 'dart:convert';
import 'package:bilu2/main.dart';
import 'package:bilu2/page/HomeClient.dart';
import 'package:bilu2/theme.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  void _login() async {
    final username = _usernameController.text;
    final password = _passwordController.text;

    try {
      // Authenticate with Firebase
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: username,
        password: password,
      );

      // Log event to Firebase Analytics
      await _analytics.logEvent(
        name: 'login',
        parameters: {
          'username': username,
        },
      );

      // Save login state to SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      await prefs.setString('loggedInUser', username);

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.green,
        content: Text('Login Successful!'),
      ));

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MainPage()),
      );
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.red,
        content: Text("Username Atau Password Anda Salah !"),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 45),
              Text("Login!",
                  style: boldTextStyle.copyWith(color: blueColor, fontSize: 32)),
              SizedBox(height: 15),
              Container(
                width: double.infinity,
                child: Image.asset('assets/images/Ilustrasi (1).png'),
              ),
              Container(
                width: double.infinity,
                alignment: Alignment.center,
                child: Text(
                  'Halo! Selamat datang di BILU!',
                  style: boldTextStyle.copyWith(color: blueColor, fontSize: 16),
                ),
              ),
              SizedBox(height: 45),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Username',
                      style: mediumTextStyle.copyWith(
                          color: blackcolor, fontSize: 14)),
                  SizedBox(height: 5),
                  Container(
                    height: 50,
                    child: TextField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                        labelText: 'Username',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text('Password',
                      style: mediumTextStyle.copyWith(
                          color: blackcolor, fontSize: 14)),
                  SizedBox(height: 5),
                  Container(
                    height: 50,
                    child: TextField(
                      obscureText: _obscurePassword,
                      controller: _passwordController,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        suffixIcon: IconButton(
                          icon: Icon(_obscurePassword
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    height: 55,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _login,
                      style: ElevatedButton.styleFrom(
                          backgroundColor: blueColor,
                          padding: EdgeInsets.symmetric(horizontal: 55),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      child: Text(
                        'Login',
                        style: mediumTextStyle.copyWith(
                            color: whiteColor, fontSize: 14),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
