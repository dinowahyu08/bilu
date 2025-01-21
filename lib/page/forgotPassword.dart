import 'package:bilu2/theme.dart';
import 'package:flutter/material.dart';  
import 'package:firebase_auth/firebase_auth.dart';  
  
class ForgotPasswordScreen extends StatefulWidget {  
  const ForgotPasswordScreen({super.key});  
  
  @override  
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();  
}  
  
class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {  
  final FirebaseAuth _auth = FirebaseAuth.instance;  
  final _emailController = TextEditingController();  
  
  void _resetPassword() async {  
    final email = _emailController.text;  
  
    if (email.isEmpty) {  
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(  
        backgroundColor: Colors.red,  
        content: Text("Please enter your email!"),  
      ));  
      return;  
    }  
  
    try {  
      await _auth.sendPasswordResetEmail(email: email);  
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(  
        backgroundColor: Colors.green,  
        content: Text('Password reset email sent!'),  
      ));  
  
      // Navigate back to login screen  
      Navigator.pop(context);  
    } on FirebaseAuthException catch (e) {  
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(  
        backgroundColor: Colors.red,  
        content: Text("Error: ${e.message}"),  
      ));  
    }  
  }  
  
  @override  
  Widget build(BuildContext context) {  
    return Scaffold(  
      appBar: AppBar(  
        title: Text("Lupa Password",  
                  style: boldTextStyle.copyWith(color: blueColor,fontSize: 32)),    
        leading: IconButton(  
          icon: Icon(Icons.arrow_back,size: 35,),  
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
                  Text('Email',  
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),  
                  SizedBox(height: 5),  
                  Container(  
                    height: 50,  
                    child: TextField(  
                      controller: _emailController,  
                      decoration: InputDecoration(  
                        labelText: 'Email',  
                        border: OutlineInputBorder(  
                            borderRadius: BorderRadius.circular(10)),  
                      ),  
                    ),  
                  ),  
                  SizedBox(height: 20),  
                  SizedBox(  
                    height: 55,  
                    width: double.infinity,  
                    child: ElevatedButton(  
                      onPressed: _resetPassword,  
                      style: ElevatedButton.styleFrom(  
                          backgroundColor: blueColor,  
                          padding: EdgeInsets.symmetric(horizontal: 55),  
                          shape: RoundedRectangleBorder(  
                              borderRadius: BorderRadius.circular(10))),  
                      child: Text(  
                          'Lupa Password',  
                          style: semiBoldTextStyle.copyWith(  
                              color: whiteColor, fontSize: 16),  
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
