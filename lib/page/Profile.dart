import 'dart:convert';
import 'package:bilu2/page/changePassword.dart';
import 'package:bilu2/page/editProfile.dart';
import 'package:bilu2/page/splashScreen.dart';
import 'package:bilu2/provider/userProvider.dart';
import 'package:bilu2/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  final String username;

  ProfilePage({required this.username});
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    Provider.of<UserProvider>(context, listen: false).loadUserData();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    if (userProvider.username.isEmpty) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

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
                                            NetworkImage(userProvider.photoUrl),
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
                                              userProvider.name,
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
                                              userProvider
                                                  .calculateTotalSavings(),
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
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ChangePasswordScreen(
                                            )),
                                  );
                                },
                                child: Text(
                                  'Change Password',
                                  style: regularTextStyle.copyWith(
                                      color: blackcolor, fontSize: 14),
                                ),
                              ),
                             SizedBox(height: 25),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Notifikasi Absensi',
                                    style: regularTextStyle.copyWith(
                                        color: blackcolor, fontSize: 14),
                                  ),
                                  Switch(
                                    onChanged: (value) => {},
                                    value: false,
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
                                        await prefs.setString('loggedInUser', '');


                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SplashScreen()),
                                    );
                                  },
                                  child: Text(
                                    'Logout',
                                    style: mediumTextStyle.copyWith(
                                        color: whiteColor, fontSize: 14),
                                  ),
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