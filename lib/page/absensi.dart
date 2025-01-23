import 'package:bilu2/provider/userProvider.dart';
import 'package:bilu2/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';  // Import the provider package
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import the Firestore package for Timestamp

class AbsensiScreen extends StatefulWidget {
  final String username;

  AbsensiScreen({required this.username});

  @override
  _AbsensiScreenState createState() => _AbsensiScreenState();
}

class _AbsensiScreenState extends State<AbsensiScreen> {
  bool isDarkMode = false;

  @override
  void initState() {
    super.initState();
    // Load user data when the screen is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<UserProvider>(context, listen: false).loadUserData();
    });

    // Load theme setting for dark mode (assuming you have this setting in your app)
  }


  @override
  Widget build(BuildContext context) {
    // Access the UserProvider from the context
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(backgroundColor: blueColor,foregroundColor: whiteColor,
        title: Text(
          'Absensi',
          style: boldTextStyle.copyWith(color: whiteColor,fontSize: 22),
        ),

        centerTitle: true,
      ),
      body: userProvider.isLoading
          ? Center(child: CircularProgressIndicator())
          : userProvider.attendance.isEmpty
              ? Center(child: Text('No attendance data found.', style: TextStyle(color: isDarkMode ? Colors.white : Colors.black)))
              : _buildAttendanceContent(userProvider),
    );
  }

  Widget _buildAttendanceContent(UserProvider userProvider) {
    List<Widget> attendanceItems = userProvider.attendance.map<Widget>((attendance) {
      // Convert Firestore timestamp to date string
      Timestamp timestamp = attendance['date'];
      String formattedDate = DateFormat('yyyy-MM-dd').format(timestamp.toDate());

      return Card(
        margin: EdgeInsets.symmetric(vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 5,
        color: isDarkMode ? Colors.grey[800] : Colors.white,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
          colors: attendance['status'] == 'Hadir'
    ? [Colors.green[200]!, Colors.green[400]!]
    : attendance['status'] == 'Sakit'
        ? [Colors.yellow[200]!, Colors.yellow[400]!]
        : [Colors.red[200]!, Colors.red[400]!],

              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          padding: EdgeInsets.all(16),
          child: Row(
            children: [
              Icon(
  attendance['status'] == 'Hadir'
      ? Icons.check_circle
      : attendance['status'] == 'Sakit'
          ? Icons.local_hospital
          : Icons.cancel,
  color: attendance['status'] == 'Hadir'
      ? Colors.green
      : attendance['status'] == 'Sakit'
          ? Colors.orange
          : Colors.red,
  size: 30,
),

              SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tanggal : $formattedDate',
                    style: boldTextStyle.copyWith(color: blackcolor,fontSize: 16),
                  ),
 Text(
  attendance['status'] == 'Hadir'
      ? 'Hadir'
      : attendance['status'] == 'Sakit'
          ? 'Sakit'
          : 'Absen',
  style: TextStyle(
    fontSize: 14,
    color: isDarkMode
        ? (attendance['status'] == 'Hadir'
            ? Colors.green[200]
            : attendance['status'] == 'Sakit'
                ? Colors.orange[200]
                : Colors.red[200])
        : (attendance['status'] == 'Hadir'
            ? Colors.green[800]
            : attendance['status'] == 'Sakit'
                ? Colors.orange[800]
                : Colors.red[800]),
  ),
),

                ],
              ),
            ],
          ),
        ),
      );
    }).toList();

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(userProvider.photoUrl),
                radius: 40,
              ),
              SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userProvider.name,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: isDarkMode ? Colors.white : Colors.black),
                  ),
                  Text(
                    userProvider.className,
                    style: TextStyle(fontSize: 14, color: isDarkMode ? Colors.white70 : Colors.grey),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 20),
          Text(
            'Attendance History:',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: isDarkMode ? Colors.white : Colors.black),
          ),
          SizedBox(height: 10),
          Expanded(
            child: ListView(
              children: attendanceItems,
            ),
          ),
        ],
      ),
    );
  }
}
