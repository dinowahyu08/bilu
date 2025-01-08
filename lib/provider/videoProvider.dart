// import 'package:flutter/material.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;

// class VideoProvider with ChangeNotifier {
//   List<dynamic> _videos = [];

//   List<dynamic> get videos => _videos;

//   Future<void> fetchVideos() async {
//     try {
//       final response = await http.get(Uri.parse('http://10.0.2.2:8000/videos.json'));

//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
//         _videos = data['videos']; // Store video data
//         notifyListeners(); // Notify listeners to rebuild UI
//       } else {
//         print("Failed to load videos: ${response.statusCode}");
//       }
//     } catch (e) {
//       print("Error fetching videos: $e");
//     }
//   }
// }


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class VideoProvider with ChangeNotifier {
  List<Map<String, dynamic>> _videos = [];

  List<Map<String, dynamic>> get videos => _videos;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Function to fetch videos from Firestore
  Future<void> fetchVideos() async {
    try {
      // Query Firestore for the 'videos' collection
      final querySnapshot = await _firestore.collection('videos').get();

      // Map each document to a Map and store in the _videos list
      _videos = querySnapshot.docs.map((doc) {
        return doc.data() as Map<String, dynamic>;
      }).toList();

      // Notify listeners to update the UI
      notifyListeners();
    } catch (e) {
      print("Error fetching videos from Firestore: $e");
    }
  }
}
