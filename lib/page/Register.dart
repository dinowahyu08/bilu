// import 'package:bilu2/theme.dart';
// import 'package:flutter/material.dart';  
// import 'package:firebase_auth/firebase_auth.dart';  
// import 'package:firebase_analytics/firebase_analytics.dart';  
  
// class RegisterScreen extends StatefulWidget {  
//   const RegisterScreen({super.key});  
  
//   @override  
//   State<RegisterScreen> createState() => _RegisterScreenState();  
// }  
  
// class _RegisterScreenState extends State<RegisterScreen> {  
//   final FirebaseAuth _auth = FirebaseAuth.instance;  
//   final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;  
//   final _usernameController = TextEditingController();  
//   final _passwordController = TextEditingController();  
//   bool _obscurePassword = true;  
  


  
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
  
//       // Navigate back to login screen  
//       Navigator.pop(context);  
//     } on FirebaseAuthException catch (e) {  
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(  
//         backgroundColor: Colors.red,  
//         content: Text("Registration Failed: ${e.message}"),  
//       ));  
//     }  
//   }  
  
//   @override  
//   Widget build(BuildContext context) {  
//     return Scaffold(  
//       appBar: AppBar( 
//         foregroundColor: blackcolor,
//         title: Text("Daftar",  
//                   style: boldTextStyle.copyWith(color: blueColor,fontSize: 32)),   
//         leading: IconButton(  
//           icon: Icon(Icons.arrow_back,size: 35,),  
//           onPressed: () {  
//             Navigator.pop(context);  
//           },  
//         ),  
//       ),  
//       body: Padding(  
//         padding: const EdgeInsets.all(15),  
//         child: SingleChildScrollView(  
//           child: Column(  
//             crossAxisAlignment: CrossAxisAlignment.start,  
//             children: [  
             
//               Column(  
//                 crossAxisAlignment: CrossAxisAlignment.start,  
//                 children: [  
//                   Text('Email',  
//                       style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),  
//                   SizedBox(height: 5),  
//                   Container(  
//                     height: 50,  
//                     child: TextField(  
//                       controller: _usernameController,  
//                       decoration: InputDecoration(  
//                         labelText: 'Email',  
//                         border: OutlineInputBorder(  
//                             borderRadius: BorderRadius.circular(10)),  
//                       ),  
//                     ),  
//                   ),  
//                   SizedBox(height: 10),  
//                   Text('Password',  
//                       style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),  
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
//                       onPressed: _register,  
//                       style: ElevatedButton.styleFrom(  
//                           backgroundColor: blueColor,  
//                           padding: EdgeInsets.symmetric(horizontal: 55),  
//                           shape: RoundedRectangleBorder(  
//                               borderRadius: BorderRadius.circular(10))),  
//                       child: Text(  
//                           'Daftar',  
//                           style: semiBoldTextStyle.copyWith(  
//                               color: whiteColor, fontSize: 16),  
//                         ),  
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

import 'package:bilu2/theme.dart';  
import 'package:flutter/material.dart';  
import 'package:firebase_auth/firebase_auth.dart';  
import 'package:firebase_analytics/firebase_analytics.dart';  
  
class RegisterScreen extends StatefulWidget {  
  const RegisterScreen({super.key});  
  
  @override  
  State<RegisterScreen> createState() => _RegisterScreenState();  
}  
  
class _RegisterScreenState extends State<RegisterScreen> {  
  final FirebaseAuth _auth = FirebaseAuth.instance;  
  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;  
  final _usernameController = TextEditingController();  
  final _passwordController = TextEditingController();  
  bool _obscurePassword = true;  
  
  void _register() async {  
  final username = _usernameController.text;  
  final password = _passwordController.text;  
  
  try {  
    // Cek apakah email sudah terdaftar  
    final signInMethods = await _auth.fetchSignInMethodsForEmail(username);  
    if (signInMethods.isNotEmpty) {  
      // Jika email sudah terdaftar, tampilkan pesan kesalahan  
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(  
        backgroundColor: Colors.red,  
        content: Text("Email sudah terdaftar. Silakan gunakan email lain."),  
      ));  
      return; // Hentikan eksekusi lebih lanjut  
    }  
  
    // Jika email belum terdaftar, lanjutkan dengan pendaftaran  
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(  
      email: username,  
      password: password,  
    );  
  
    // Kirim email verifikasi  
    await userCredential.user!.sendEmailVerification();  
  
    // Log event ke Firebase Analytics  
    await _analytics.logEvent(  
      name: 'register',  
      parameters: {  
        'username': username,  
      },  
    );  
  
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(  
      backgroundColor: Colors.green,  
      content: Text('Pendaftaran berhasil! Silakan periksa email Anda untuk verifikasi.'),  
    ));  
  
    // Navigasi kembali ke layar login  
    Navigator.pop(context);  
  } on FirebaseAuthException catch (e) {  
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(  
      backgroundColor: Colors.red,  
      content: Text("Pendaftaran gagal: ${e.message}"),  
    ));  
  }  
}  

  
  @override  
  Widget build(BuildContext context) {  
    return Scaffold(  
      appBar: AppBar(  
        foregroundColor: blackcolor,  
        title: Text(  
          "Daftar",  
          style: boldTextStyle.copyWith(color: blueColor, fontSize: 32),  
        ),  
        leading: IconButton(  
          icon: Icon(Icons.arrow_back, size: 35),  
          onPressed: () {  
            Navigator.pop(context);  
          },  
        ),  
      ),  
      body: Padding(  
        padding: const EdgeInsets.all(15),  
        child: SingleChildScrollView(  
          child: Column(  
            crossAxisAlignment: CrossAxisAlignment.start,  
            children: [  
              Column(  
                crossAxisAlignment: CrossAxisAlignment.start,  
                children: [  
                  Text(  
                    'Email',  
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),  
                  ),  
                  SizedBox(height: 5),  
                  Container(  
                    height: 50,  
                    child: TextField(  
                      controller: _usernameController,  
                      decoration: InputDecoration(  
                        labelText: 'Email',  
                        border: OutlineInputBorder(  
                          borderRadius: BorderRadius.circular(10),  
                        ),  
                      ),  
                    ),  
                  ),  
                  SizedBox(height: 10),  
                  Text(  
                    'Password',  
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),  
                  ),  
                  SizedBox(height: 5),  
                  Container(  
                    height: 50,  
                    child: TextField(  
                      obscureText: _obscurePassword,  
                      controller: _passwordController,  
                      decoration: InputDecoration(  
                        labelText: 'Password',  
                        border: OutlineInputBorder(  
                          borderRadius: BorderRadius.circular(10),  
                        ),  
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
                      onPressed: _register,  
                      style: ElevatedButton.styleFrom(  
                        backgroundColor: blueColor,  
                        padding: EdgeInsets.symmetric(horizontal: 55),  
                        shape: RoundedRectangleBorder(  
                          borderRadius: BorderRadius.circular(10),  
                        ),  
                      ),  
                      child: Text(  
                        'Daftar',  
                        style: semiBoldTextStyle.copyWith(  
                          color: whiteColor,  
                          fontSize: 16,  
                        ),  
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
