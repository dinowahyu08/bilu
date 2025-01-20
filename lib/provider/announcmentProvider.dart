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


// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// class AnnouncementProvider with ChangeNotifier {
//   List<Map<String, dynamic>> _announcements = [];
//   bool _isLoading = false; // Status pemuatan data

//   // Getter untuk pengumuman
//   List<Map<String, dynamic>> get announcements => _announcements;

//   // Getter untuk status pemuatan
//   bool get isLoading => _isLoading;

//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   // Fungsi untuk memuat pengumuman dari Firestore
//   Future<void> loadAnnouncements() async {
//     _isLoading = true; // Set isLoading ke true sebelum mulai memuat data
//     notifyListeners();

//     try {
//       // Ambil data dari koleksi 'announcements' di Firestore
//       final querySnapshot = await _firestore.collection('announcements').get();

//       // Ubah setiap dokumen menjadi Map dan perbarui _announcements
//       _announcements = querySnapshot.docs.map((doc) {
//         return doc.data() as Map<String, dynamic>;
//       }).toList();
//     } catch (e) {
//       print("Error loading announcements from Firestore: $e");
//     } finally {
//       _isLoading = false; // Set isLoading ke false setelah selesai
//       notifyListeners();
//     }
//   }
// }




// // Announcement Provider
// import 'package:firebase_database/firebase_database.dart';  
// import 'package:flutter/material.dart';  
  
// FirebaseDatabase database = FirebaseDatabase.instance;  
  
// class AnnouncementProvider with ChangeNotifier {  
//   final DatabaseReference _database = FirebaseDatabase.instance.ref().child('announcements');  
//   List<Announcement> _announcements = [];  
//   bool _isLoading = false;  
  
//   List<Announcement> get announcements => _announcements;  
//   bool get isLoading => _isLoading;  
  
//   Future<void> fetchAnnouncements() async {  
//     print("Fetch Announcement Progress");  
//     // _isLoading = true; // Set loading state to true  
//     notifyListeners();  
  
//     try {  
//       final snapshot = await _database.get();  


//       if (snapshot.exists) {  
//         final Map<dynamic, dynamic> data = snapshot.value as Map<dynamic, dynamic>;  
//         _announcements = data.entries.map((entry) => Announcement.fromMap(entry.key, entry.value)).toList();  
//       } else {  
//         _announcements = [];  
//       }  
//     } catch (error) {  
//       print('Error fetching announcements: $error'); // Log the error  
//       throw Exception('Failed to fetch announcements: $error');  
//     } finally {  
//       _isLoading = false; // Set loading state to false  
//       print("Fetch Announcement DONE");  

//       notifyListeners();  
//     }  
//     print("ANNOUNCEMENT DONE ${_announcements} ");
//   }  
  
//   Future<void> addAnnouncement(Announcement announcement) async {  
//     try {  
//       final newAnnouncementRef = _database.push();  
//       await newAnnouncementRef.set(announcement.toMap());  
//       announcement.id = newAnnouncementRef.key; // Set the ID for the new announcement  
//       _announcements.add(announcement);  
//       notifyListeners();  
//     } catch (error) {  
//       print('Error adding announcement: $error'); // Log the error  
//       throw Exception('Failed to add announcement: $error');  
//     }  
//   }  
  
//   Future<void> updateAnnouncement(Announcement announcement) async {  
//     if (announcement.id == null) {  
//       throw Exception('Announcement ID is null');  
//     }  
//     try {  
//       await _database.child(announcement.id!).update(announcement.toMap());  
//       int index = _announcements.indexWhere((a) => a.id == announcement.id);  
//       if (index != -1) {  
//         _announcements[index] = announcement; // Update the local list  
//       }  
//       notifyListeners();  
//     } catch (error) {  
//       print('Error updating announcement: $error'); // Log the error  
//       throw Exception('Failed to update announcement: $error');  
//     }  
//   }  
  
//   Future<void> deleteAnnouncement(String id) async {  
//     try {  
//       await _database.child(id).remove();  
//       _announcements.removeWhere((announcement) => announcement.id == id); // Remove from local list  
//       notifyListeners();  
//     } catch (error) {  
//       print('Error deleting announcement: $error'); // Log the error  
//       throw Exception('Failed to delete announcement: $error');  
//     }  
//   }  
// }  
  
// // ###### Announcement Model ####################  
// class Announcement {  
//   String? id;  
//   String title;  
//   String content;  
//   String date;  
  
//   Announcement({this.id, required this.title, required this.content, required this.date});  
  
//   Map<String, dynamic> toMap() {  
//     return {  
//       'title': title,  
//       'content': content,  
//       'date': date,  
//     };  
//   }  
  
//   factory Announcement.fromMap(String id, Map<dynamic, dynamic> map) {  
//     return Announcement(  
//       id: id,  
//       title: map['title'] as String,  
//       content: map['content'] as String,  
//       date: map['date'] as String,  
//     );  
//   }  
// }  

import 'package:firebase_database/firebase_database.dart';  
import 'package:flutter/material.dart';  
  
class Announcement {  
  String? id; // ID pengumuman  
  String title; // Judul pengumuman  
  String content; // Konten pengumuman  
  String date; // Tanggal pengumuman  
  
  Announcement({this.id, required this.title, required this.content, required this.date});  
  
  Map<String, dynamic> toMap() {  
    return {  
      'title': title,  
      'content': content,  
      'date': date,  
    };  
  }  
  
  factory Announcement.fromMap(String id, Map<dynamic, dynamic> map) {  
    return Announcement(  
      id: id, // Mengambil ID dari parameter  
      title: map['title'] as String,  
      content: map['content'] as String,  
      date: map['date'] as String,  
    );  
  }  
}  


class AnnouncementProvider with ChangeNotifier {  
  final DatabaseReference _database = FirebaseDatabase.instance.ref().child('announcements');  
  List<Announcement> _announcements = [];  
  bool _isLoading = false;  
  
  List<Announcement> get announcements => _announcements;  
  bool get isLoading => _isLoading;  
  
  Future<void> fetchAnnouncements() async {  
    print("Fetch Announcement Progress");  
    _isLoading = true; // Set loading state to true  
    notifyListeners();  
  
    try {  
      final snapshot = await _database.get();  
      print(snapshot);  
      if (snapshot.exists) {  
        final data = snapshot.value as Map<dynamic, dynamic>; // Mengambil data sebagai Map  
        _announcements = data.entries.map((entry) {  
          // Menggunakan Announcement.fromMap untuk membuat objek Announcement  
          return Announcement.fromMap(entry.key, entry.value);  
        }).toList();  
      } else {  
        _announcements = [];  
      }  
    } catch (error) {  
      print('Error fetching announcements: $error'); // Log the error  
      throw Exception('Failed to fetch announcements: $error');  
    } finally {  
      _isLoading = false; // Set loading state to false  
      print("Fetch Announcement DONE");  
      notifyListeners();  
    }  
    print("ANNOUNCEMENT DONE ${_announcements}");  
  }  
  
  Future<void> addAnnouncement(Announcement announcement) async {  
    try {  
      final newAnnouncementRef = _database.push(); // Menggunakan push untuk membuat ID baru  
      await newAnnouncementRef.set(announcement.toMap());  
      announcement.id = newAnnouncementRef.key; // Set the ID for the new announcement  
      _announcements.add(announcement);  
      notifyListeners();  
    } catch (error) {  
      print('Error adding announcement: $error'); // Log the error  
      throw Exception('Failed to add announcement: $error');  
    }  
  }  
  
  Future<void> updateAnnouncement(Announcement announcement) async {  
    if (announcement.id == null) {  
      throw Exception('Announcement ID is null');  
    }  
    try {  
      await _database.child(announcement.id!).update(announcement.toMap());  
      int index = _announcements.indexWhere((a) => a.id == announcement.id);  
      if (index != -1) {  
        _announcements[index] = announcement; // Update the local list  
      }  
      notifyListeners();  
    } catch (error) {  
      print('Error updating announcement: $error'); // Log the error  
      throw Exception('Failed to update announcement: $error');  
    }  
  }  
  
  Future<void> deleteAnnouncement(String id) async {  
    try {  
      await _database.child(id).remove(); // Menghapus berdasarkan ID  
      _announcements.removeWhere((announcement) => announcement.id == id); // Remove from local list  
      notifyListeners();  
    } catch (error) {  
      print('Error deleting announcement: $error'); // Log the error  
      throw Exception('Failed to delete announcement: $error');  
    }  
  }  
}  
 
