// import 'dart:convert';
// import 'package:bilu2/main.dart';
// import 'package:bilu2/page/HomeClient.dart';
// import 'package:bilu2/theme.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_analytics/firebase_analytics.dart';

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
//   final _usernameController = TextEditingController();
//   final _passwordController = TextEditingController();
//   bool _obscurePassword = true;

//   void _login() async {
//     final username = _usernameController.text;
//     final password = _passwordController.text;

//     try {
//       // Authenticate with Firebase
//       UserCredential userCredential = await _auth.signInWithEmailAndPassword(
//         email: username,
//         password: password,
//       );

//       // Log event to Firebase Analytics
//       await _analytics.logEvent(
//         name: 'login',
//         parameters: {
//           'username': username,
//         },
//       );

//       // Save login state to SharedPreferences
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       await prefs.setBool('isLoggedIn', true);
//       await prefs.setString('loggedInUser', username);

//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         backgroundColor: Colors.green,
//         content: Text('Login Successful!'),
//       ));

//       Navigator.push(
//         context,
//         MaterialPageRoute(builder: (context) => MainPage()),
//       );
//     } on FirebaseAuthException catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         backgroundColor: Colors.red,
//         content: Text("Username Atau Password Anda Salah !"),
//       ));
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(15),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(height: 45),
//               Text("Login!",
//                   style: boldTextStyle.copyWith(color: blueColor, fontSize: 32)),
//               SizedBox(height: 15),
//               Container(
//                 width: double.infinity,
//                 child: Image.asset('assets/images/Ilustrasi (1).png'),
//               ),
//               Container(
//                 width: double.infinity,
//                 alignment: Alignment.center,
//                 child: Text(
//                   'Halo! Selamat datang di BILU!',
//                   style: boldTextStyle.copyWith(color: blueColor, fontSize: 16),
//                 ),
//               ),
//               SizedBox(height: 45),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text('Username',
//                       style: mediumTextStyle.copyWith(
//                           color: blackcolor, fontSize: 14)),
//                   SizedBox(height: 5),
//                   Container(
//                     height: 50,
//                     child: TextField(
//                       controller: _usernameController,
//                       decoration: InputDecoration(
//                         labelText: 'Username',
//                         border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(10)),
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 10),
//                   Text('Password',
//                       style: mediumTextStyle.copyWith(
//                           color: blackcolor, fontSize: 14)),
//                   SizedBox(height: 5),
//                   Container(
//                     height: 50,
//                     child: TextField(
//                       obscureText: _obscurePassword,
//                       controller: _passwordController,
//                       decoration: InputDecoration(
//                         labelText: 'Password',
//                         border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(10)),
//                         suffixIcon: IconButton(
//                           icon: Icon(_obscurePassword
//                               ? Icons.visibility
//                               : Icons.visibility_off),
//                           onPressed: () {
//                             setState(() {
//                               _obscurePassword = !_obscurePassword;
//                             });
//                           },
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 20),
//                   SizedBox(
//                     height: 55,
//                     width: double.infinity,
//                     child: ElevatedButton(
//                       onPressed: _login,
//                       style: ElevatedButton.styleFrom(
//                           backgroundColor: blueColor,
//                           padding: EdgeInsets.symmetric(horizontal: 55),
//                           shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(10))),
//                       child: Text(
//                         'Login',
//                         style: mediumTextStyle.copyWith(
//                             color: whiteColor, fontSize: 14),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'dart:convert';
// import 'package:bilu2/main.dart';
// import 'package:bilu2/page/HomeClient.dart';
// import 'package:bilu2/page/Register.dart';
// import 'package:bilu2/page/forgotPassword.dart';
// import 'package:bilu2/theme.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_analytics/firebase_analytics.dart';

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
//   final _usernameController = TextEditingController();
//   final _passwordController = TextEditingController();
//   bool _obscurePassword = true;

//   void _login() async {
//     final username = _usernameController.text;
//     final password = _passwordController.text;

//     try {
//       // Authenticate with Firebase
//       UserCredential userCredential = await _auth.signInWithEmailAndPassword(
//         email: username,
//         password: password,
//       );

//       // Log event to Firebase Analytics
//       await _analytics.logEvent(
//         name: 'login',
//         parameters: {
//           'username': username,
//         },
//       );

//       // Save login state to SharedPreferences
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       await prefs.setBool('isLoggedIn', true);
//       await prefs.setString('loggedInUser', username);

//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         backgroundColor: Colors.green,
//         content: Text('Login Successful!'),
//       ));

//       Navigator.push(
//         context,
//         MaterialPageRoute(builder: (context) => MainPage()),
//       );
//     } on FirebaseAuthException catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         backgroundColor: Colors.red,
//         content: Text("Username Atau Password Anda Salah !"),
//       ));
//     }
//   }

//   void _register() async {
//     final username = _usernameController.text;
//     final password = _passwordController.text;

//     try {
//       // Register with Firebase
//       UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
//         email: username,
//         password: password,
//       );

//       // Log event to Firebase Analytics
//       await _analytics.logEvent(
//         name: 'register',
//         parameters: {
//           'username': username,
//         },
//       );

//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         backgroundColor: Colors.green,
//         content: Text('Registration Successful!'),
//       ));
//     } on FirebaseAuthException catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         backgroundColor: Colors.red,
//         content: Text("Registration Failed: ${e.message}"),
//       ));
//     }
//   }

//   void _forgotPassword() async {
//     final username = _usernameController.text;

//     if (username.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         backgroundColor: Colors.red,
//         content: Text("Please enter your email!"),
//       ));
//       return;
//     }

//     try {
//       await _auth.sendPasswordResetEmail(email: username);
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         backgroundColor: Colors.green,
//         content: Text('Password reset email sent!'),
//       ));
//     } on FirebaseAuthException catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         backgroundColor: Colors.red,
//         content: Text("Error: ${e.message}"),
//       ));
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(15),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(height: 45),
//               Text("Login!",
//                   style: boldTextStyle.copyWith(color: blueColor, fontSize: 32)),
//               SizedBox(height: 15),
//               Container(
//                 width: double.infinity,
//                 child: Image.asset('assets/images/Ilustrasi (1).png'),
//               ),
//               Container(
//                 width: double.infinity,
//                 alignment: Alignment.center,
//                 child: Text(
//                   'Halo! Selamat datang di BILU!',
//                   style: boldTextStyle.copyWith(color: blueColor, fontSize: 16),
//                 ),
//               ),
//               SizedBox(height: 45),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text('Username',
//                       style: mediumTextStyle.copyWith(
//                           color: blackcolor, fontSize: 14)),
//                   SizedBox(height: 5),
//                   Container(
//                     height: 50,
//                     child: TextField(
//                       controller: _usernameController,
//                       decoration: InputDecoration(
//                         labelText: 'Username',
//                         border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(10)),
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 10),
//                   Text('Password',
//                       style: mediumTextStyle.copyWith(
//                           color: blackcolor, fontSize: 14)),
//                   SizedBox(height: 5),
//                   Container(
//                     height: 50,
//                     child: TextField(
//                       obscureText: _obscurePassword,
//                       controller: _passwordController,
//                       decoration: InputDecoration(
//                         labelText: 'Password',
//                         border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(10)),
//                         suffixIcon: IconButton(
//                           icon: Icon(_obscurePassword
//                               ? Icons.visibility
//                               : Icons.visibility_off),
//                           onPressed: () {
//                             setState(() {
//                               _obscurePassword = !_obscurePassword;
//                             });
//                           },
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 20),
//                   SizedBox(
//                     height: 55,
//                     width: double.infinity,
//                     child: ElevatedButton(
//                       onPressed: _login,
//                       style: ElevatedButton.styleFrom(
//                           backgroundColor: blueColor,
//                           padding: EdgeInsets.symmetric(horizontal: 55),
//                           shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(10))),
//                       child: Text(
//                         'Login',
//                         style: mediumTextStyle.copyWith(
//                             color: whiteColor, fontSize: 14),
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 5),
//                   // Registration Button
//                   Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       TextButton(
//                         onPressed: (){Navigator.push(
//   context,
//   MaterialPageRoute(builder: (context) => RegisterScreen()),
// );  },
//                         child: Text(
//                           'Register',
//                           style: TextStyle(color: blueColor),
//                         ),
//                       ),
//                       TextButton(
//                     onPressed: (){Navigator.push(
//   context,
//   MaterialPageRoute(builder: (context) => ForgotPasswordScreen()),
// );  },
//                     child: Text(
//                       'Forgot Password?',
//                       style: TextStyle(color: blueColor),
//                     ),
//                   ),
//                     ],
//                   ),
//                   // Forgot Password Button

//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'dart:convert';
// import 'package:bilu2/main.dart';
// import 'package:bilu2/page/HomeClient.dart';
// import 'package:bilu2/page/Register.dart';
// import 'package:bilu2/page/forgotPassword.dart';
// import 'package:bilu2/theme.dart';
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_analytics/firebase_analytics.dart';
// import 'package:google_sign_in/google_sign_in.dart';

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
//   final _usernameController = TextEditingController();
//   final _passwordController = TextEditingController();
//   bool _obscurePassword = true;

//   void _login() async {
//     final username = _usernameController.text;
//     final password = _passwordController.text;

//     try {
//       // Authenticate with Firebase
//       UserCredential userCredential = await _auth.signInWithEmailAndPassword(
//         email: username,
//         password: password,
//       );

//       // Log event to Firebase Analytics
//       await _analytics.logEvent(
//         name: 'login',
//         parameters: {
//           'username': username,
//         },
//       );

//       // Save login state to SharedPreferences
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       await prefs.setBool('isLoggedIn', true);
//       await prefs.setString('loggedInUser', username);

//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         backgroundColor: Colors.green,
//         content: Text('Login Successful!'),
//       ));

//       Navigator.push(
//         context,
//         MaterialPageRoute(builder: (context) => MainPage()),
//       );
//     } on FirebaseAuthException catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         backgroundColor: Colors.red,
//         content: Text("Username Atau Password Anda Salah !"),
//       ));
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Scaffold(  backgroundColor: whiteColor,
//         body: Padding(
//           padding: const EdgeInsets.all(15),
//           child: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 SizedBox(height: 45),
//                 Text("Login!",
//                     style: boldTextStyle.copyWith(color: blueColor, fontSize: 32)),
//                 SizedBox(height: 15),
//                 Container(
//                   width: double.infinity,
//                   child: Image.asset('assets/images/Ilustrasi (1).png'),
//                 ),
//                 Container(
//                   width: double.infinity,
//                   alignment: Alignment.center,
//                   child: Text(
//                     'Halo! Selamat datang di BILU!',
//                     style: boldTextStyle.copyWith(color: blueColor, fontSize: 16),
//                   ),
//                 ),
//                 SizedBox(height: 45),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text('Username',
//                         style: mediumTextStyle.copyWith(
//                             color: blackcolor, fontSize: 14)),
//                     SizedBox(height: 5),
//                     Container(
//                       height: 50,
//                       child: TextField(
//                         controller: _usernameController,
//                         decoration: InputDecoration(
//                           labelText: 'Username',
//                           border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(10)),
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 10),
//                     Text('Password',
//                         style: mediumTextStyle.copyWith(
//                             color: blackcolor, fontSize: 14)),
//                     SizedBox(height: 5),
//                     Container(
//                       height: 50,
//                       child: TextField(
//                         obscureText: _obscurePassword,
//                         controller: _passwordController,
//                         decoration: InputDecoration(
//                           labelText: 'Password',
//                           border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(10)),
//                           suffixIcon: IconButton(
//                             icon: Icon(_obscurePassword
//                                 ? Icons.visibility
//                                 : Icons.visibility_off),
//                             onPressed: () {
//                               setState(() {
//                                 _obscurePassword = !_obscurePassword;
//                               });
//                             },
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 20),
//                     SizedBox(
//                       height: 55,
//                       width: double.infinity,
//                       child: ElevatedButton(
//                         onPressed: _login,
//                         style: ElevatedButton.styleFrom(
//                             backgroundColor: blueColor,
//                             padding: EdgeInsets.symmetric(horizontal: 55),
//                             shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(10))),
//                         child: Text(
//                           'Masuk',
//                           style: semiBoldTextStyle.copyWith(
//                               color: whiteColor, fontSize: 16),
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 15),

//                     Divider(),

//                     // Google Sign-In Button
//                     // Registration and Forgot Password Buttons
//                     Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         TextButton(
//                           onPressed: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(builder: (context) => RegisterScreen()),
//                             );
//                           },
//                           child: Text(
//                             'Daftar',
//                             style: semiBoldTextStyle.copyWith(color: blueColor,fontSize: 14),
//                           ),
//                         ),
//                         TextButton(
//                           onPressed: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(builder: (context) => ForgotPasswordScreen()),
//                             );
//                           },
//                           child: Text(
//                             'Lupa Password?',
//                             style: semiBoldTextStyle.copyWith(color: blueColor,fontSize: 14),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:convert';
import 'package:bilu2/main.dart';
import 'package:bilu2/page/HomeClient.dart';
import 'package:bilu2/page/Register.dart';
import 'package:bilu2/page/forgotPassword.dart';
import 'package:bilu2/theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:google_sign_in/google_sign_in.dart';

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

      // Cek apakah email sudah terverifikasi
      if (userCredential.user != null && !userCredential.user!.emailVerified) {
        // Jika email belum terverifikasi, tampilkan pesan kesalahan
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text("Silakan verifikasi email Anda sebelum login."),
        ));
        // Logout pengguna
        await _auth.signOut();
        return; // Hentikan eksekusi lebih lanjut
      }

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
    return Center(
      child: Scaffold(
        backgroundColor: whiteColor,
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 25),
                Text("Login!",
                    style:
                        boldTextStyle.copyWith(color: blueColor, fontSize: 32)),
                SizedBox(height: 35),
                Container(
                  width: double.infinity,
                  child: Image.asset('assets/images/Ilustrasi (1).png'),
                ),
                Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: Text(
                    'Halo! Selamat datang di BILU!',
                    style:
                        boldTextStyle.copyWith(color: blueColor, fontSize: 16),
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

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegisterScreen()),
                            );
                          },
                          child: Text(
                            'Belum Punya Akun ?',
                            style: mediumTextStyle.copyWith(
                                color: blackcolor, fontSize: 14),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ForgotPasswordScreen()),
                            );
                          },
                          child: Text(
                            'Lupa Password?',
                            style: semiBoldTextStyle.copyWith(
                                color: blueColor, fontSize: 14),
                          ),
                        ),
                      ],
                    ),
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
                          'Masuk',
                          style: semiBoldTextStyle.copyWith(
                              color: whiteColor, fontSize: 16),
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    // Google Sign-In Button
                    // Registration and Forgot Password Buttons
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
