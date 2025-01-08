// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// class AnnouncementProvider with ChangeNotifier {
//   List<dynamic> _announcements = [];

//   // Getter
//   List<dynamic> get announcements => _announcements;

//   // Fungsi untuk memuat pengumuman dari server
//   Future<void> loadAnnouncements() async {
//     try {
//       final response = await http.get(Uri.parse('http://10.0.2.2:8000/pengumuman.json'));
//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
//         _announcements = data['announcements'] ?? [];
//         notifyListeners();
        
//       }
//     } catch (e) {
//       print("Error loading announcements: $e");
//     }
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AnnouncementProvider with ChangeNotifier {
  List<Map<String, dynamic>> _announcements = [];
  bool _isLoading = false; // Status pemuatan data

  // Getter untuk pengumuman
  List<Map<String, dynamic>> get announcements => _announcements;

  // Getter untuk status pemuatan
  bool get isLoading => _isLoading;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Fungsi untuk memuat pengumuman dari Firestore
  Future<void> loadAnnouncements() async {
    _isLoading = true; // Set isLoading ke true sebelum mulai memuat data
    notifyListeners();

    try {
      // Ambil data dari koleksi 'announcements' di Firestore
      final querySnapshot = await _firestore.collection('announcements').get();

      // Ubah setiap dokumen menjadi Map dan perbarui _announcements
      _announcements = querySnapshot.docs.map((doc) {
        return doc.data() as Map<String, dynamic>;
      }).toList();
    } catch (e) {
      print("Error loading announcements from Firestore: $e");
    } finally {
      _isLoading = false; // Set isLoading ke false setelah selesai
      notifyListeners();
    }
  }
}

