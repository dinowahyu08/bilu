import 'dart:convert';
import 'package:bilu2/Widget/billStatus.dart';
import 'package:bilu2/page/Keuangan.dart';
import 'package:bilu2/page/absensi.dart';
import 'package:bilu2/page/videoList.dart';
import 'package:bilu2/theme.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class HomeClient extends StatefulWidget {
  const HomeClient({super.key});

  @override
  State<HomeClient> createState() => _HomeClientState();
}

class _HomeClientState extends State<HomeClient> {
  String _username = '';
  String _name = '';
  String _className = ''; // Menyimpan kelas pengguna
  String _photoUrl = ''; // Menyimpan URL foto pengguna
  List<dynamic> _bill = []; // Initially empty dynamic list

  @override
  void initState() {
    super.initState();
    _loadUserData(); // Memuat data pengguna dari SharedPreferences
  }

  // Fungsi untuk mengambil data nama pengguna dari SharedPreferences
  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _username = prefs.getString('loggedInUser') ?? ''; // Ambil nama pengguna
    await _loadUserFromServer(); // Memuat data pengguna dari server
  }

  // Fungsi untuk memuat data pengguna dari server HTTP
  Future<void> _loadUserFromServer() async {
    try {
      final response = await http.get(Uri.parse('http://10.0.2.2:8000/users.json'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print(data);
        // Mencari pengguna berdasarkan username
        final user = data['users'].firstWhere((user) => user['username'] == _username, orElse: () => null);

        if (user != null) {
          setState(() {
            _name = user['name'] ?? '';
            _className = user['className'] ?? ''; // Ambil kelas
            _photoUrl = user['photoUrl'] ?? ''; // Ambil URL foto
            _bill = user['bill'] ?? [];
          });
        }
      } else {
        print('Failed to load user data from server: ${response.statusCode}');
      }
    } catch (e) {
      print('Error loading user data: $e');
    }
  }

  void _showAnnouncementDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Pengumuman"),
          content: Text("Ini adalah pengumuman terbaru."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Tutup"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Action when the FAB is pressed
          _showAnnouncementDialog();
        },
        backgroundColor: blueColor,
        child: Icon(Icons.announcement,color: whiteColor,),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 45),
              Text(
                'Halo $_name!',
                style: boldTextStyle.copyWith(color: blueColor, fontSize: 32),
              ),
              SizedBox(height: 10),
              Text(
                'Ayo belajar bersama BILU!',
                style: regularTextStyle.copyWith(color: blackcolor, fontSize: 14),
              ),
              SizedBox(height: 27),
              BillStatusWidget(bills: _bill),
              SizedBox(height: 27),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => VideoListScreen()),
                  );
                },
                child: Image.asset('assets/images/Button Video Pembelajaran.png'),
              ),
              SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AbsensiScreen(username: _username)),
                  );
                },
                child: Image.asset('assets/images/Button Absensi.png'),
              ),
              SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => KeuanganScreen(username: _username)),
                  );
                },
                child: Image.asset('assets/images/Button Keuangan.png'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
