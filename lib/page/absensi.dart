import 'package:bilu2/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


class AbsensiScreen extends StatefulWidget {
  final String username;

  AbsensiScreen({required this.username});

  @override
  _AbsensiScreenState createState() => _AbsensiScreenState();
}

class _AbsensiScreenState extends State<AbsensiScreen> {
  Map<String, dynamic>? user;

  @override
  void initState() {
    super.initState();
    // Memuat data pengguna saat widget diinisialisasi
    _loadUserFromServer();
  }

  
  Future<void> _loadUserFromServer() async {
    try {
      final response = await http.get(Uri.parse('http://10.0.2.2:8000/users.json'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print(data);
        // Mencari pengguna berdasarkan username
        user = data['users'].firstWhere(
        (user) => user['username'] == widget.username,
        orElse: () => null);

    // Memanggil setState untuk memperbarui UI setelah data dimuat
    setState(() {});
      } else {
        print('Failed to load user data from server: ${response.statusCode}');
      }
    } catch (e) {
      print('Error loading user data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (user == null) {
      return Scaffold(
        appBar: AppBar(title: Text('Profil Pengguna')),
        body: Center(
            child:
                CircularProgressIndicator()), // Menampilkan loading indicator
      );
    }

    if (user == null) {
      return Scaffold(
        appBar: AppBar(title: Text('Profil Pengguna')),
        body: Center(child: Text('Pengguna tidak ditemukan.')),
      );
    }

    // Memeriksa status tagihan
    String billStatus = "Lunas";
    if (user!['bill'] != null && user!['bill'].isNotEmpty) {
      // Jika ada tagihan, ambil statusnya
      billStatus = user!['bill'][0]['status'];
    }

    return Scaffold(
      appBar: AppBar(title: Text('Profil Pengguna')),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(user!['photoUrl']),
                    radius: 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user!['name'],
                          style: boldTextStyle.copyWith(
                              color: blueColor, fontSize: 18),
                        ),
                        Text(user!['className'],style: mediumTextStyle.copyWith(fontSize: 14),),
                        Text(
                          'Status Tagihan: $billStatus',
                          style: boldTextStyle.copyWith(
                              color: billStatus == "Lunas"
                                  ? Colors.green
                                  : Colors.red,
                              fontSize: 14),
                        ),
                      ],
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
