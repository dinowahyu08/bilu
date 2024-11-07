import 'package:bilu2/main.dart';
import 'package:bilu2/page/login.dart';
import 'package:bilu2/theme.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkLoginStatus(); // Cek status login saat splash screen ditampilkan
  }

  // Fungsi untuk mengecek apakah pengguna sudah login atau belum
  Future<void> _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false; // Cek status login

    // Arahkan pengguna ke halaman yang sesuai setelah beberapa detik
    await Future.delayed(Duration(seconds: 2)); // Durasi splash screen

    if (isLoggedIn) {
      // Jika sudah login, arahkan ke HomeClient
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainPage()),
      );
    } else {
      // Jika belum login, arahkan ke LoginScreen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.school, size: 100, color: Colors.blue), // Icon splash
            SizedBox(height: 20),
            Text(
              'Welcome to BILU App',
              style: boldTextStyle.copyWith(fontSize: 24, color: blackcolor),
            ),
          ],
        ),
      ),
    );
  }
}
