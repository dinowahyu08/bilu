import 'dart:convert';
import 'package:bilu2/page/editPassword.dart';
import 'package:bilu2/page/editProfile.dart';
import 'package:bilu2/page/login.dart';
import 'package:bilu2/page/splashScreen.dart';
import 'package:bilu2/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


class ProfilePage extends StatefulWidget {
  final String username;

  ProfilePage({required this.username});
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Map<String, dynamic>? user;

  @override
  void initState() {
    super.initState();
    _loadUserFromServer();
  }

  Future<void> _loadUserFromServer() async {
    try {
      final response = await http.get(Uri.parse(
          'http://10.0.2.2:8000/users.json'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        user = data['users'].firstWhere(
            (user) => user['username'] == widget.username,
            orElse: () => null);
        setState(() {});
      } else {
        print('Failed to load user data from server: ${response.statusCode}');
      }
    } catch (e) {
      print('Error loading user data: $e');
    }
  }


String formatRupiah(String amount) {
  final numberFormat = NumberFormat.currency(
    locale: 'id_ID', // Indonesian locale
    symbol: 'Rp ',    // Currency symbol
    decimalDigits: 0, // Set to 0 if you don't want decimal places
  );
  
  return numberFormat.format(int.parse(amount)); // Convert to int if the amount is a string
}

  String calculateTotalSavings() {
    int total = 0;
    if (user != null && user!['savings'] != null) {
      for (var entry in user!['savings']['history']) {
        total += int.parse(entry['amount']);
      }
    }
    return formatRupiah(total.toString());
  }
  @override
  Widget build(BuildContext context) {
    if (user == null) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
     String totalSavings = calculateTotalSavings();

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: AlignmentDirectional.topStart,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: blueColor,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(50),
                            bottomRight: Radius.circular(50))),
                    height: 255,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 55, 0, 0),
                    child: Text(
                      'Profile',
                      style: boldTextStyle.copyWith(
                        color: whiteColor,
                        fontSize: 24,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 120, 0, 0),
                    child: Center(
                      child: Container(
                        decoration: BoxDecoration(
                            color: whiteColor,
                            borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(35),
                            topRight: Radius.circular(35))),
                        width: 350,
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      CircleAvatar(
                                        backgroundImage:
                                            NetworkImage(user!['photoUrl']),
                                        radius: 50,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            20, 0, 0, 0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              user!['name'],
                                              style: boldTextStyle.copyWith(
                                                  color: blackcolor,
                                                  fontSize: 18),
                                            ),
                                            Text(
                                              'Tabunganku',
                                              style: mediumTextStyle.copyWith(
                                                  color: blackcolor,
                                                  fontSize: 12),
                                            ),
                                            Text(
                                              totalSavings,
                                              style: semiBoldTextStyle.copyWith(
                                                  color: blackcolor,
                                                  fontSize: 14),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Divider(),
                              SizedBox(height: 10),
                              Text(
                                'Account Settings',
                                style: semiBoldTextStyle.copyWith(
                                    color: blackcolor, fontSize: 14),
                              ),
                              SizedBox(height: 30),
                              Text(
                                'Edit Profile',
                                style: regularTextStyle.copyWith(
                                    color: blackcolor, fontSize: 14),
                              ),
                              SizedBox(height: 30),
                              TextButton(
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChangePasswordPage(username: widget.username,),
      ),
    );
  },
  child: Text('Edit Password'),
),
                              Text(
                                'Change Password',
                                style: regularTextStyle.copyWith(
                                    color: blackcolor, fontSize: 14),
                              ),
                              SizedBox(height: 25),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Notifikasi Absensi',
                                    style: regularTextStyle.copyWith(
                                        color: blackcolor, fontSize: 14),
                                  ),
                                  Switch(onChanged: (value) =>{} ,value: false,
                        
                                  ),
                                ],
                              ),
                                                          SizedBox(height: 10),
                              Divider(),
                               SizedBox(height: 10),
                              Text(
                                'More',
                                style: semiBoldTextStyle.copyWith(
                                    color: blackcolor, fontSize: 14),
                              ),
                                SizedBox(height: 30),
                              Text(
                                'Pengumuman',
                                style: regularTextStyle.copyWith(
                                    color: blackcolor, fontSize: 14),
                              ),
                                SizedBox(height: 30),
         Text(
                                'Saran / Masukan',
                                style: regularTextStyle.copyWith(
                                    color: blackcolor, fontSize: 14),
                              ),
                                SizedBox(height: 30),
                                Text(
                                'Hubungi Kami',
                                style: regularTextStyle.copyWith(
                                    color: blackcolor, fontSize: 14),

                              ),
                                SizedBox(height: 30),

                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    SharedPreferences prefs =
                                        await SharedPreferences.getInstance();
                                    prefs.setBool('isLoggedIn', false);
                                        
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SplashScreen()),
                                    );
                                  },
                                  child: Text('Logout',style:mediumTextStyle.copyWith(color: whiteColor,fontSize: 14) ,),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 30, vertical: 15),
                                  ),
                                ),
                              ),
                            ],
                          ),
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


