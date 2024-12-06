import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AnnouncementProvider with ChangeNotifier {
  List<dynamic> _announcements = [];

  // Getter
  List<dynamic> get announcements => _announcements;

  // Fungsi untuk memuat pengumuman dari server
  Future<void> loadAnnouncements() async {
    try {
      final response = await http.get(Uri.parse('http://10.0.2.2:8000/pengumuman.json'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        _announcements = data['announcements'] ?? [];
        notifyListeners();
      }
    } catch (e) {
      print("Error loading announcements: $e");
    }
  }
}
