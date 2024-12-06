import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class VideoProvider with ChangeNotifier {
  List<dynamic> _videos = [];

  List<dynamic> get videos => _videos;

  Future<void> fetchVideos() async {
    try {
      final response = await http.get(Uri.parse('http://10.0.2.2:8000/videos.json'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        _videos = data['videos']; // Store video data
        notifyListeners(); // Notify listeners to rebuild UI
      } else {
        print("Failed to load videos: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching videos: $e");
    }
  }
}
