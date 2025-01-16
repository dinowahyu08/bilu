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

// ########## Video Provider Tampilkan Saja ##########

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// class VideoProvider with ChangeNotifier {
//   List<Map<String, dynamic>> _videos = [];

//   List<Map<String, dynamic>> get videos => _videos;

//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   // Function to fetch videos from Firestore
//   Future<void> fetchVideos() async {
//     try {
//       // Query Firestore for the 'videos' collection
//       final querySnapshot = await _firestore.collection('videos').get();

//       // Map each document to a Map and store in the _videos list
//       _videos = querySnapshot.docs.map((doc) {
//         return doc.data() as Map<String, dynamic>;
//       }).toList();

//       // Notify listeners to update the UI
//       notifyListeners();
//     } catch (e) {
//       print("Error fetching videos from Firestore: $e");
//     }
//   }
// }

// ############## VIdeo Provider Tampilkan, edit delete ##################

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class VideoProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> _videos = [];
  

  List<Map<String, dynamic>> get videos => _videos;

Future<void> fetchVideos() async {
  print('Video Provider Ongoing');
  try {
    final querySnapshot = await _firestore
        .collection('videos')
        .orderBy('createdAt', descending: true) // Order by createdAt
        .get();

    _videos = querySnapshot.docs.map((doc) {
      final data = doc.data();
      return {
        'id': doc.id,
        ...data,
      } as Map<String, dynamic>;
    }).toList();
    notifyListeners();
  } catch (e) {
    print("Error fetching videos: $e");
  }
}



  // // Fetch videos from Firestore
  // Future<void> fetchVideos() async {
  //   print('Video Provider Ongoing');
  //   try {
  //     final querySnapshot = await _firestore.collection('videos').get();
  //     _videos = querySnapshot.docs.map((doc) {
  //       final data = doc.data();
  //       return {
  //         'id': doc.id, // Include document ID for editing purposes
  //         ...data,
  //       } as Map<String, dynamic>;
  //     }).toList();
  //     notifyListeners();
  //   } catch (e) {
  //     print("Error fetching videos: $e");
  //   }
  // }

  // // Add a new video
  // Future<void> addVideo({
  //   required String title,
  //   required String description,
  //   required String url,
  // }) async {
  //   try {
  //     final newVideo = {
  //       'title': title,
  //       'description': description,
  //       'url': url,
  //     };

  //     // Add to Firestore
  //     await _firestore.collection('videos').add(newVideo);

  //     // Update local list
  //     _videos.add({'id': '', ...newVideo}); // Temp data; refetch to get IDs
  //     notifyListeners();
  //   } catch (e) {
  //     print("Error adding video: $e");
  //   }
  // }

// Add a new video
Future<void> addVideo({
  required String title,
  required String description,
  required String url,
}) async {
  try {
    final newVideo = {
      'title': title,
      'description': description,
      'url': url,
      'createdAt': FieldValue.serverTimestamp(), // Add timestamp
    };

    // Add to Firestore
    final docRef = await _firestore.collection('videos').add(newVideo);

    // Update local list (refetch to get accurate timestamps)
    _videos.add({'id': docRef.id, ...newVideo});
    fetchVideos();
    notifyListeners();
  } catch (e) {
    print("Error adding video: $e");
  }
}


  // Delete a video
Future<void> deleteVideo({required String id}) async {
  try {
    await _firestore.collection('videos').doc(id).delete();
    _videos.removeWhere((video) => video['id'] == id);
    notifyListeners();
  } catch (e) {
    print("Error deleting video: $e");
  }
}


  // Edit an existing video
  Future<void> editVideo({
    required String id,
    required String title,
    required String description,
    required String url,
  }) async {
    try {
      final updatedVideo = {
        'title': title,
        'description': description,
        'url': url,
      };

      // Update Firestore document
      await _firestore.collection('videos').doc(id).update(updatedVideo);

      // Update local list
      final index = _videos.indexWhere((video) => video['id'] == id);
      if (index != -1) {
        _videos[index] = {'id': id, ...updatedVideo};
        notifyListeners();
      }
    } catch (e) {
      print("Error editing video: $e");
    }
  }
}

