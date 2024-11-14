import 'dart:convert';
import 'package:bilu2/main.dart';
import 'package:bilu2/page/HomeClient.dart';
import 'package:bilu2/theme.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Menggunakan FirebaseAnalytics.instance untuk mendapatkan instance
  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  List<dynamic> _users = [];
  bool _obscurePassword = true;

  @override
  void initState() {
    super.initState();
    loadUsers(); // Memuat data pengguna dari server
  }

  Future<void> loadUsers() async {
    try {
      final response = await http.get(Uri.parse('http://192.168.100.7:8000/users.json')); // Ganti dengan URL server
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _users = data['users'];
        });
      } else {
        throw Exception('Failed to load users');
      }
    } catch (e) {
      print("Error loading users: $e"); // Menangkap dan mencetak error
    }
  }

  void _login() async {
    final username = _usernameController.text;
    final password = _passwordController.text;
    // Memeriksa apakah pengguna terdaftar
    bool userExists = _users.any(
        (user) => user['username'] == username && user['password'] == password);

    if (userExists) {
      final user = _users.firstWhere((user) =>
          user['username'] == username && user['password'] == password);
      final String name = user['name'];

      // Simpan status login dan nama pengguna ke SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      await prefs.setString('loggedInUser', username);
      print('Login $username');

      // Log event ke Firebase Analytics
      await _analytics.logEvent(
        name: 'login',
        parameters: {
          'username': username,
          'name': name,
        },
      );

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.green,
        content: Text('Login Berhasil!'),
      ));
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MainPage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.red,
        content: Text('Username atau Password Salah!'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 45,
                ),
                Text("Login!",
                    style:
                        boldTextStyle.copyWith(color: blueColor, fontSize: 32)),
                SizedBox(
                  height: 15,
                ),
                Container(
                  width: double.infinity,
                  child: Image.asset('assets/images/Ilustrasi (1).png'),
                ),
                Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: Text(
                      'Halo! Selamat datang di BILU!',
                      style: boldTextStyle.copyWith(
                          color: blueColor, fontSize: 16),
                    )),
                SizedBox(
                  height: 45,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Username',
                      style: mediumTextStyle.copyWith(
                          color: blackcolor, fontSize: 14),
                    ),
                    SizedBox(
                      height: 5,
                    ),
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
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Password',
                      style: mediumTextStyle.copyWith(
                          color: blackcolor, fontSize: 14),
                    ),
                    SizedBox(
                      height: 5,
                    ),
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
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscurePassword =
                                    !_obscurePassword; // Mengubah status obscure
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 55,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _login,
                        style: ElevatedButton.styleFrom(
                            backgroundColor: blueColor,
                            padding: EdgeInsets.symmetric(
                              horizontal: 55,
                            ),
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
