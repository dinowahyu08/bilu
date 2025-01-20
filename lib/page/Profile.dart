// import 'dart:convert';
// import 'package:bilu2/page/changePassword.dart';
// import 'package:bilu2/page/editProfile.dart';
// import 'package:bilu2/page/splashScreen.dart';
// import 'package:bilu2/provider/userProvider.dart';
// import 'package:bilu2/theme.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class ProfilePage extends StatefulWidget {
//   final String username;

//   ProfilePage({required this.username});
//   @override
//   _ProfilePageState createState() => _ProfilePageState();
// }

// class _ProfilePageState extends State<ProfilePage> {
//   @override
//   void initState() {
//     super.initState();
//     Provider.of<UserProvider>(context, listen: false).loadUserData();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final userProvider = Provider.of<UserProvider>(context);

//     if (userProvider.username.isEmpty) {
//       return Scaffold(
//         body: Center(child: CircularProgressIndicator()),
//       );
//     }

//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Container(
//           decoration: BoxDecoration(),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Stack(
//                 alignment: AlignmentDirectional.topStart,
//                 children: [
//                   Container(
//                     decoration: BoxDecoration(
//                         color: blueColor,
//                         borderRadius: BorderRadius.only(
//                             bottomLeft: Radius.circular(50),
//                             bottomRight: Radius.circular(50))),
//                     height: 255,
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.fromLTRB(15, 55, 0, 0),
//                     child: Text(
//                       'Profile',
//                       style: boldTextStyle.copyWith(
//                         color: whiteColor,
//                         fontSize: 24,
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.fromLTRB(0, 120, 0, 0),
//                     child: Center(
//                       child: Container(
//                         decoration: BoxDecoration(
//                             color: whiteColor,
//                             borderRadius: BorderRadius.only(
//                                 topLeft: Radius.circular(35),
//                                 topRight: Radius.circular(35))),
//                         width: 350,
//                         child: Padding(
//                           padding: const EdgeInsets.all(20),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Column(
//                                 children: [
//                                   Row(
//                                     mainAxisAlignment: MainAxisAlignment.start,
//                                     children: [
//                                       CircleAvatar(
//                                         backgroundImage:
//                                             NetworkImage(userProvider.photoUrl),
//                                         radius: 50,
//                                       ),
//                                       Padding(
//                                         padding: const EdgeInsets.fromLTRB(
//                                             20, 0, 0, 0),
//                                         child: Column(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: [
//                                             Text(
//                                               userProvider.name,
//                                               style: boldTextStyle.copyWith(
//                                                   color: blackcolor,
//                                                   fontSize: 18),
//                                             ),
//                                             Text(
//                                               'Tabunganku',
//                                               style: mediumTextStyle.copyWith(
//                                                   color: blackcolor,
//                                                   fontSize: 12),
//                                             ),
//                                             Text(
//                                               userProvider
//                                                   .calculateTotalSavings(),
//                                               style: semiBoldTextStyle.copyWith(
//                                                   color: blackcolor,
//                                                   fontSize: 14),
//                                             )
//                                           ],
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                               SizedBox(height: 10),
//                               Divider(),
//                               SizedBox(height: 10),
//                               Text(
//                                 'Account Settings',
//                                 style: semiBoldTextStyle.copyWith(
//                                     color: blackcolor, fontSize: 14),
//                               ),
//                               SizedBox(height: 30),
//                               Text(
//                                 'Edit Profile',
//                                 style: regularTextStyle.copyWith(
//                                     color: blackcolor, fontSize: 14),
//                               ),
//                               SizedBox(height: 30),
//                               GestureDetector(
//                                 onTap: () {
//                                   Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (context) =>
//                                             ChangePasswordScreen(
//                                             )),
//                                   );
//                                 },
//                                 child: Text(
//                                   'Change Password',
//                                   style: regularTextStyle.copyWith(
//                                       color: blackcolor, fontSize: 14),
//                                 ),
//                               ),
//                              SizedBox(height: 25),
//                               Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Text(
//                                     'Notifikasi Absensi',
//                                     style: regularTextStyle.copyWith(
//                                         color: blackcolor, fontSize: 14),
//                                   ),
//                                   Switch(
//                                     onChanged: (value) => {},
//                                     value: false,
//                                   ),
//                                 ],
//                               ),
//                               SizedBox(height: 10),
//                               Divider(),
//                               SizedBox(height: 10),
//                               Text(
//                                 'More',
//                                 style: semiBoldTextStyle.copyWith(
//                                     color: blackcolor, fontSize: 14),
//                               ),
//                               SizedBox(height: 30),
//                               Text(
//                                 'Pengumuman',
//                                 style: regularTextStyle.copyWith(
//                                     color: blackcolor, fontSize: 14),
//                               ),
//                               SizedBox(height: 30),
//                               Text(
//                                 'Saran / Masukan',
//                                 style: regularTextStyle.copyWith(
//                                     color: blackcolor, fontSize: 14),
//                               ),
//                               SizedBox(height: 30),
//                               Text(
//                                 'Hubungi Kami',
//                                 style: regularTextStyle.copyWith(
//                                     color: blackcolor, fontSize: 14),
//                               ),
//                               SizedBox(height: 30),
//                               SizedBox(
//                                 width: double.infinity,
//                                 child: ElevatedButton(
//                                   onPressed: () async {
//                                     SharedPreferences prefs =
//                                         await SharedPreferences.getInstance();
//                                     prefs.setBool('isLoggedIn', false);
//                                         await prefs.setString('loggedInUser', '');

//                                     Navigator.pushReplacement(
//                                       context,
//                                       MaterialPageRoute(
//                                           builder: (context) => SplashScreen()),
//                                     );
//                                   },
//                                   child: Text(
//                                     'Logout',
//                                     style: mediumTextStyle.copyWith(
//                                         color: whiteColor, fontSize: 14),
//                                   ),
//                                   style: ElevatedButton.styleFrom(
//                                     backgroundColor: Colors.red,
//                                     padding: EdgeInsets.symmetric(
//                                         horizontal: 30, vertical: 15),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
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
// import 'package:bilu2/page/changePassword.dart';
// import 'package:bilu2/page/editProfile.dart';
// import 'package:bilu2/page/splashScreen.dart';
// import 'package:bilu2/provider/userProvider.dart';
// import 'package:bilu2/theme.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class ProfilePage extends StatefulWidget {
//   final String username;

//   ProfilePage({required this.username});

//   @override
//   _ProfilePageState createState() => _ProfilePageState();
// }

// class _ProfilePageState extends State<ProfilePage> {
//   @override
//   void initState() {
//     super.initState();
//     // Load user data when the profile page is created
//     Provider.of<UserProvider>(context, listen: false).loadUserData();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final userProvider = Provider.of<UserProvider>(context);

//     // Show loading indicator while user data is being fetched
//     if (userProvider.username.isEmpty) {
//       return Scaffold(
//         body: Center(child: CircularProgressIndicator()),
//       );
//     }

//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Container(
//           decoration: BoxDecoration(),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Stack(
//                 alignment: AlignmentDirectional.topStart,
//                 children: [
//                   Container(
//                     decoration: BoxDecoration(
//                       color: blueColor,
//                       borderRadius: BorderRadius.only(
//                         bottomLeft: Radius.circular(50),
//                         bottomRight: Radius.circular(50),
//                       ),
//                     ),
//                     height: 255,
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.fromLTRB(15, 55, 0, 0),
//                     child: Text(
//                       'Profile',
//                       style: boldTextStyle.copyWith(
//                         color: whiteColor,
//                         fontSize: 24,
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.fromLTRB(0, 120, 0, 0),
//                     child: Center(
//                       child: Container(
//                         decoration: BoxDecoration(
//                           color: whiteColor,
//                           borderRadius: BorderRadius.only(
//                             topLeft: Radius.circular(35),
//                             topRight: Radius.circular(35),
//                           ),
//                         ),
//                         width: 350,
//                         child: Padding(
//                           padding: const EdgeInsets.all(20),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Column(
//                                 children: [
//                                   Row(
//                                     mainAxisAlignment: MainAxisAlignment.start,
//                                     children: [
//                                       CircleAvatar(
//                                         backgroundImage:
//                                             NetworkImage(userProvider.photoUrl),
//                                         radius: 50,
//                                       ),
//                                       Padding(
//                                         padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
//                                         child: Column(
//                                           crossAxisAlignment: CrossAxisAlignment.start,
//                                           children: [
//                                             Text(
//                                               userProvider.name,
//                                               style: boldTextStyle.copyWith(
//                                                   color: blackcolor,
//                                                   fontSize: 18),
//                                             ),
//                                             Text(
//                                               'Tabunganku',
//                                               style: mediumTextStyle.copyWith(
//                                                   color: blackcolor,
//                                                   fontSize: 12),
//                                             ),
//                                             Text(
//                                               userProvider.calculateTotalSavings(),
//                                               style: semiBoldTextStyle.copyWith(
//                                                   color: blackcolor,
//                                                   fontSize: 14),
//                                             )
//                                           ],
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                               SizedBox(height: 10),
//                               Divider(),
//                               SizedBox(height: 10),
//                               Text(
//                                 'Account Settings',
//                                 style: semiBoldTextStyle.copyWith(
//                                     color: blackcolor, fontSize: 14),
//                               ),
//                               SizedBox(height: 30),
//                               Text(
//                                 'Edit Profile',
//                                 style: regularTextStyle.copyWith(
//                                     color: blackcolor, fontSize: 14),
//                               ),
//                               SizedBox(height: 30),
//                               GestureDetector(
//                                 onTap: () {
//                                   Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (context) => ChangePasswordScreen()),
//                                   );
//                                 },
//                                 child: Text(
//                                   'Change Password',
//                                   style: regularTextStyle.copyWith(
//                                       color: blackcolor, fontSize: 14),
//                                 ),
//                               ),
//                               SizedBox(height: 25),
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Text(
//                                     'Notifikasi Absensi',
//                                     style: regularTextStyle.copyWith(
//                                         color: blackcolor, fontSize: 14),
//                                   ),
//                                   Switch(
//                                     onChanged: (value) => {},
//                                     value: false,
//                                   ),
//                                 ],
//                               ),
//                               SizedBox(height: 10),
//                               Divider(),
//                               SizedBox(height: 10),
//                               Text(
//                                 'More',
//                                 style: semiBoldTextStyle.copyWith(
//                                     color: blackcolor, fontSize: 14),
//                               ),
//                               SizedBox(height: 30),
//                               Text(
//                                 'Pengumuman',
//                                 style: regularTextStyle.copyWith(
//                                     color: blackcolor, fontSize: 14),
//                               ),
//                               SizedBox(height: 30),
//                               Text(
//                                 'Saran / Masukan',
//                                 style: regularTextStyle.copyWith(
//                                     color: blackcolor, fontSize: 14),
//                               ),
//                               SizedBox(height: 30),
//                               Text(
//                                 'Hubungi Kami',
//                                 style: regularTextStyle.copyWith(
//                                     color: blackcolor, fontSize: 14),
//                               ),
//                               SizedBox(height: 30),
//                               SizedBox(
//                                 width: double.infinity,
//                                 child: ElevatedButton(
//                                   onPressed: () async {
//                                     SharedPreferences prefs =
//                                         await SharedPreferences.getInstance();
//                                     prefs.setBool('isLoggedIn', false);
//                                     await prefs.setString('loggedInUser', '');

//                                     Navigator.pushReplacement(
//                                       context,
//                                       MaterialPageRoute(
//                                           builder: (context) => SplashScreen()),
//                                     );
//                                   },
//                                   child: Text(
//                                     'Logout',
//                                     style: mediumTextStyle.copyWith(
//                                         color: whiteColor, fontSize: 14),
//                                   ),
//                                   style: ElevatedButton.styleFrom(
//                                     backgroundColor: Colors.red,
//                                     padding: EdgeInsets.symmetric(
//                                         horizontal: 30, vertical: 15),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
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
// import 'package:bilu2/page/changePassword.dart';
// import 'package:bilu2/page/editProfile.dart';
// import 'package:bilu2/page/splashScreen.dart';
// import 'package:bilu2/provider/userProvider.dart';
// import 'package:bilu2/theme.dart';
// import 'package:flutter/material.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class ProfilePage extends StatefulWidget {
//   final String username;

//   ProfilePage({required this.username});

//   @override
//   _ProfilePageState createState() => _ProfilePageState();
// }

// class _ProfilePageState extends State<ProfilePage> {
//   bool isAttendanceNotificationEnabled = false;

//   @override
//   void initState() {
//     super.initState();
//     Provider.of<UserProvider>(context, listen: false).loadUserData();
//     _loadNotificationPreferences();
//   }

//   Future<void> _loadNotificationPreferences() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     setState(() {
//       isAttendanceNotificationEnabled =
//           prefs.getBool('attendanceNotification') ?? false;
//     });
//   }

//   Future<void> _toggleAttendanceNotification(bool value) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     if (value) {
//       PermissionStatus status = await Permission.notification.request();
//       if (status.isGranted) {
//         setState(() {
//           isAttendanceNotificationEnabled = true;
//         });
//         prefs.setBool('attendanceNotification', true);
//         _showNotification('Attendance Notification Enabled');
//       } else {
//         _showNotification('Permission Denied');
//       }
//     } else {
//       setState(() {
//         isAttendanceNotificationEnabled = false;
//       });
//       prefs.setBool('attendanceNotification', false);
//     }
//   }

//   void _showNotification(String message) {
//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//       content: Text(message),
//       duration: Duration(seconds: 2),
//     ));
//   }
//   bool notif =false;
//   @override
//   Widget build(BuildContext context) {
//     final userProvider = Provider.of<UserProvider>(context);

//     if (userProvider.username.isEmpty) {
//       return Scaffold(
//         body: Center(child: CircularProgressIndicator()),
//       );
//     }

//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Container(
//           decoration: BoxDecoration(),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Stack(
//                 alignment: AlignmentDirectional.topStart,
//                 children: [
//                   Container(
//                     decoration: BoxDecoration(
//                       color: blueColor,
//                       borderRadius: BorderRadius.only(
//                         bottomLeft: Radius.circular(50),
//                         bottomRight: Radius.circular(50),
//                       ),
//                     ),
//                     height: 255,
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.fromLTRB(15, 55, 0, 0),
//                     child: Text(
//                       'Profile',
//                       style: boldTextStyle.copyWith(
//                         color: whiteColor,
//                         fontSize: 24,
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.fromLTRB(0, 120, 0, 0),
//                     child: Center(
//                       child: Container(
//                         decoration: BoxDecoration(
//                           color: whiteColor,
//                           borderRadius: BorderRadius.only(
//                             topLeft: Radius.circular(35),
//                             topRight: Radius.circular(35),
//                           ),
//                         ),
//                         width: 350,
//                         child: Padding(
//                           padding: const EdgeInsets.all(20),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Row(
//                                 children: [
//                                   CircleAvatar(
//                                     backgroundImage: NetworkImage(
//                                         userProvider.photoUrl),
//                                     radius: 50,
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.fromLTRB(
//                                         20, 0, 0, 0),
//                                     child: Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         Text(
//                                           userProvider.name,
//                                           style: boldTextStyle.copyWith(
//                                               color: blackcolor, fontSize: 18),
//                                         ),
//                                         Text(
//                                           'Tabunganku',
//                                           style: mediumTextStyle.copyWith(
//                                               color: blackcolor, fontSize: 12),
//                                         ),
//                                         Text(
//                                           userProvider.calculateTotalSavings(),
//                                           style: semiBoldTextStyle.copyWith(
//                                               color: blackcolor, fontSize: 14),
//                                         )
//                                       ],
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               SizedBox(height: 10),
//                               Divider(),
//                               SizedBox(height: 10),
//                               Text(
//                                 'Account Settings',
//                                 style: semiBoldTextStyle.copyWith(
//                                     color: blackcolor, fontSize: 14),
//                               ),
//                               SizedBox(height: 30),
//                               GestureDetector(
//                                 onTap: () {

//                                 },
//                                 child: Text(
//                                   'Edit Profile',
//                                   style: regularTextStyle.copyWith(
//                                       color: blackcolor, fontSize: 14),
//                                 ),
//                               ),
//                               SizedBox(height: 30),
//                               GestureDetector(
//                                 onTap: () {
//                                   Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (context) =>
//                                             ChangePasswordScreen()),
//                                   );
//                                 },
//                                 child: Text(
//                                   'Change Password',
//                                   style: regularTextStyle.copyWith(
//                                       color: blackcolor, fontSize: 14),
//                                 ),
//                               ),
//                               SizedBox(height: 25),
//                               Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Text(
//                                     'Notifikasi Absensi',
//                                     style: regularTextStyle.copyWith(
//                                         color: blackcolor, fontSize: 14),
//                                   ),
//                                   Switch(value: notif,
//                                     onChanged: notification;
//                                   ),
//                                 ],
//                               ),
//                               SizedBox(height: 10),
//                               Divider(),
//                               SizedBox(height: 10),
//                               Text(
//                                 'More',
//                                 style: semiBoldTextStyle.copyWith(
//                                     color: blackcolor, fontSize: 14),
//                               ),
//                               SizedBox(height: 30),
//                               Text(
//                                 'Pengumuman',
//                                 style: regularTextStyle.copyWith(
//                                     color: blackcolor, fontSize: 14),
//                               ),
//                               SizedBox(height: 30),
//                               Text(
//                                 'Saran / Masukan',
//                                 style: regularTextStyle.copyWith(
//                                     color: blackcolor, fontSize: 14),
//                               ),
//                               SizedBox(height: 30),
//                               Text(
//                                 'Hubungi Kami',
//                                 style: regularTextStyle.copyWith(
//                                     color: blackcolor, fontSize: 14),
//                               ),
//                               SizedBox(height: 30),
//                               SizedBox(
//                                 width: double.infinity,
//                                 child: ElevatedButton(
//                                   onPressed: () async {
//                                     SharedPreferences prefs =
//                                         await SharedPreferences.getInstance();
//                                     prefs.setBool('isLoggedIn', false);
//                                     await prefs.setString('loggedInUser', '');

//                                     Navigator.pushReplacement(
//                                       context,
//                                       MaterialPageRoute(
//                                           builder: (context) =>
//                                               SplashScreen()),
//                                     );
//                                   },
//                                   child: Text(
//                                     'Logout',
//                                     style: mediumTextStyle.copyWith(
//                                         color: whiteColor, fontSize: 14),
//                                   ),
//                                   style: ElevatedButton.styleFrom(
//                                     backgroundColor: Colors.red,
//                                     padding: EdgeInsets.symmetric(
//                                         horizontal: 30, vertical: 15),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
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

//   void notification(notif) async{
//     if (await Permission.notification.status.isGranted) {
//       notif =true;

//     } else {
//       var status = await Permission.contacts.request();
//       print(status);
//       if (status == PermissionStatus.granted) {
//         AlertDialog(title: Text('Notifikasi Sudah Aktif'),);

//       }
//       else if (status == PermissionStatus.permanentlyDenied){
//         openAppSettings();

//       }

//     }

//   }
// }
import 'dart:convert';
import 'package:bilu2/page/changePassword.dart';
import 'package:bilu2/page/editProfile.dart';
import 'package:bilu2/page/feedbackDialog.dart';
import 'package:bilu2/page/showAnnouncement.dart';
import 'package:bilu2/page/splashScreen.dart';
import 'package:bilu2/provider/announcmentProvider.dart';
import 'package:bilu2/provider/userProvider.dart';
import 'package:bilu2/theme.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  final String username;

  ProfilePage({required this.username});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isAttendanceNotificationEnabled = false;

  @override
  void initState() {
    super.initState();
    // Load data user dan pengumuman saat aplikasi dimulai
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<UserProvider>(context, listen: false).loadUserData();
      Provider.of<AnnouncementProvider>(context, listen: false)
          .fetchAnnouncements();
    });
  }

  Future<void> _loadNotificationPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isAttendanceNotificationEnabled =
          prefs.getBool('attendanceNotification') ?? false;
    });
  }

  Future<void> _toggleAttendanceNotification(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (value) {
      final status = await Permission.notification.request();

      if (status.isGranted) {
        setState(() {
          isAttendanceNotificationEnabled = true;
        });
        prefs.setBool('attendanceNotification', true);
        _showNotification('Notifikasi berhasil diaktifkan');
      } else if (status.isPermanentlyDenied) {
        _showDialogPermissionDenied();
      } else {
        _showNotification('Izin notifikasi tidak diberikan');
      }
    } else {
      bool? confirm = await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Matikan Notifikasi'),
          content: Text(
            'Mematikan notifikasi dari aplikasi ini juga akan memengaruhi pengaturan notifikasi sistem. Apakah Anda yakin ingin melanjutkan?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text('Batal'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: Text('Matikan'),
            ),
          ],
        ),
      );

      if (confirm == true) {
        setState(() {
          isAttendanceNotificationEnabled = false;
        });
        prefs.setBool('attendanceNotification', false);

        _showNotification(
          'Notifikasi telah dimatikan. Harap nonaktifkan notifikasi di pengaturan sistem.',
        );
        openAppSettings(); // Arahkan ke pengaturan aplikasi
      }
    }
  }

  void _showNotification(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      duration: Duration(seconds: 2),
    ));
  }

// Mengecek status izin notifikasi secara berkala
  Future<void> _checkPermissionStatus() async {
    final status = await Permission.notification.status;

    if (status.isGranted) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (!isAttendanceNotificationEnabled) {
        setState(() {
          isAttendanceNotificationEnabled = true;
        });
        prefs.setBool('attendanceNotification', true);
      }
    }
  }

  void _showDialogPermissionDenied() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Izin Diperlukan'),
        content: Text(
          'Izin notifikasi ditolak secara permanen. Harap aktifkan izin di pengaturan aplikasi.',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              openAppSettings(); // Membuka pengaturan aplikasi
            },
            child: Text('Buka Pengaturan'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Batal'),
          ),
        ],
      ),
    );
  }

  Future<void> _requestNotificationPermission() async {
    final status = await Permission.notification.status;

    if (status.isDenied || status.isPermanentlyDenied) {
      // Tampilkan dialog penjelasan sebelum meminta izin
      bool? confirm = await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Izin Diperlukan'),
          content: Text(
            'Aplikasi memerlukan izin notifikasi untuk memberikan pemberitahuan tentang absensi siswa. Harap izinkan agar fitur ini dapat berjalan dengan baik.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false), // Pilihan Batal
              child: Text('Batal'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true), // Pilihan Setuju
              child: Text('Izinkan'),
            ),
          ],
        ),
      );

      if (confirm == true) {
        final requestStatus = await Permission.notification.request();

        if (requestStatus.isGranted) {
          setState(() {
            isAttendanceNotificationEnabled = true;
          });
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setBool('attendanceNotification', true);
          _showNotification('Notifikasi berhasil diaktifkan');
        } else if (requestStatus.isPermanentlyDenied) {
          _showDialogPermissionDenied();
        } else {
          _showNotification('Izin notifikasi tidak diberikan');
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final announcementProvider = Provider.of<AnnouncementProvider>(context);

    if (userProvider.isLoading || announcementProvider.isLoading) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    if (userProvider.username.isEmpty) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: blueColor,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(50),
                        bottomRight: Radius.circular(50),
                      ),
                    ),
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
                            topRight: Radius.circular(35),
                          ),
                        ),
                        width: 350,
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    backgroundImage:
                                        NetworkImage(userProvider.photoUrl),
                                    radius: 50,
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(20, 0, 0, 0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          userProvider.name,
                                          style: boldTextStyle.copyWith(
                                              color: blackcolor, fontSize: 18),
                                        ),
                                                Text('Kelas : ${userProvider.className}'
                                          ,
                                          style: boldTextStyle.copyWith(
                                              color: blackcolor, fontSize: 14),
                                        ),
                                        Text(
                                          'Tabunganku',
                                          style: boldTextStyle.copyWith(
                                              color: blackcolor, fontSize: 12),
                                        ),
                                        Text(
                                          userProvider.calculateTotalSavings(),
                                          style: semiBoldTextStyle.copyWith(
                                              color: blackcolor, fontSize: 14),
                                        )
                                      ],
                                    ),
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
                              GestureDetector(
                                onTap: () {showDialog(context: context, builder: (context) {return AlertDialog(
          title: Text('Edit Profil'),
          content: Text('Hubungi tenaga pendidik untuk mengubah profil Anda.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Tutup'),
            ),
          ],
        );});
                        
                                },
                                child: Text(
                                  'Edit Profile',
                                  style: regularTextStyle.copyWith(
                                      color: blackcolor, fontSize: 14),
                                ),
                              ),
                              SizedBox(height: 30),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ChangePasswordScreen()),
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
                                    'Notifikasi Absensi & Pengumuman',
                                    style: regularTextStyle.copyWith(
                                        color: blackcolor, fontSize: 14),
                                  ),
                                  Switch(
                                    value: isAttendanceNotificationEnabled,
                                    onChanged: _toggleAttendanceNotification,
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
                              GestureDetector(
                                onTap: () {
                                  showAnnouncementDialog(context);
                                },
                                child: Text(
                                  'Pengumuman',
                                  style: regularTextStyle.copyWith(
                                      color: blackcolor, fontSize: 14),
                                ),
                              ),
                              SizedBox(height: 30),
                        

                               GestureDetector(
                                onTap: () {
                                  showFeedbackDialog(context);
                                },
                                child:  Text(
                                'Saran / Masukan / Keluhan',
                                style: regularTextStyle.copyWith(
                                    color: blackcolor, fontSize: 14),
                              ),
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
                                    prefs.setString('loggedInUser', '');

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
