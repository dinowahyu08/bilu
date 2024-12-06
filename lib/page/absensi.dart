import 'package:bilu2/theme.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class AbsensiScreen extends StatefulWidget {
  final String username;

  AbsensiScreen({required this.username});

  @override
  _AbsensiScreenState createState() => _AbsensiScreenState();
}

class _AbsensiScreenState extends State<AbsensiScreen> {
  Map<String, dynamic>? user;
  bool isLoading = true;
  String errorMessage = '';
  String currentDate = '';
  bool isDarkMode = false;

  @override
  void initState() {
    super.initState();
    currentDate = DateTime.now().toIso8601String().split('T')[0];
    _loadTheme();
    _loadUserFromServer();
  }

  Future<void> _loadTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isDarkMode = prefs.getBool('isDarkMode') ?? false;
    });
  }

  Future<void> _loadUserFromServer() async {
    try {
      final response = await http.get(Uri.parse('http://10.0.2.2:8000/users.json'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        user = data['users'].firstWhere(
          (user) => user['username'] == widget.username,
          orElse: () => null,
        );

        if (user != null) {
          _checkAndAddAttendance();
        }
      } else {
        setState(() {
          errorMessage = 'Failed to load user data: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Error loading user data: $e';
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _checkAndAddAttendance() async {
    if (user != null) {
      bool alreadyPresentToday = user!['attendance'].any((attendance) {
        return attendance['date'] == currentDate && attendance['isPresent'] == true;
      });

      if (!alreadyPresentToday) {
        setState(() {
          user!['attendance'].add({
            'date': currentDate,
            'isPresent': true,
          });
        });
        _updateUserAttendance();
      }
    }
  }

  Future<void> _updateUserAttendance() async {
    try {
      final response = await http.post(
        Uri.parse('http://10.0.2.2:8000/updateAttendance'),
        body: json.encode({
          'username': widget.username,
          'attendance': user!['attendance'],
        }),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode != 200) {
        print('Failed to update attendance');
      }
    } catch (e) {
      print('Error updating attendance: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Attendance Page',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        backgroundColor: isDarkMode ? blueColor : blueColor,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : errorMessage.isNotEmpty
              ? Center(child: Text(errorMessage, style: TextStyle(color: isDarkMode ? Colors.white : Colors.black)))
              : user == null
                  ? Center(child: Text('User not found.', style: TextStyle(color: isDarkMode ? Colors.white : Colors.black)))
                  : _buildAttendanceContent(),
      backgroundColor: isDarkMode ? Colors.black : Colors.white,
    );
  }

  Widget _buildAttendanceContent() {
    List<Widget> attendanceItems = user!['attendance'].map<Widget>((attendance) {
      return Card(
        margin: EdgeInsets.symmetric(vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 5,
        color: isDarkMode ? Colors.grey[800] : Colors.white,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                attendance['isPresent'] ? Colors.green[200]! : Colors.red[200]!,
                attendance['isPresent'] ? Colors.green[400]! : Colors.red[400]!,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          padding: EdgeInsets.all(16),
          child: Row(
            children: [
              Icon(
                attendance['isPresent'] ? Icons.check_circle : Icons.cancel,
                color: attendance['isPresent'] ? Colors.white : Colors.black,
                size: 30,
              ),
              SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Date: ${attendance['date']}',
                    style: TextStyle(fontSize: 16, color: isDarkMode ? Colors.white : Colors.black),
                  ),
                  Text(
                    attendance['isPresent'] ? 'Present' : 'Absent',
                    style: TextStyle(fontSize: 14, color: isDarkMode ? Colors.white70 : Colors.black54),
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
                backgroundImage: NetworkImage(user!['photoUrl']),
                radius: 40,
              ),
              SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user!['name'],
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: isDarkMode ? Colors.white : Colors.black),
                  ),
                  Text(
                    user!['className'],
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
