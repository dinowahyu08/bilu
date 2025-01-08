// import 'package:cloud_firestore/cloud_firestore.dart';

// class Bill {
//   final String status;
//   final int jumlah;
//   final DateTime dueDate;
//   final DateTime? paymentDate;

//   Bill({
//     required this.status,
//     required this.jumlah,
//     required this.dueDate,
//     this.paymentDate,
//   });

//   factory Bill.fromMap(Map<String, dynamic> map) {
//     return Bill(
//       status: map['status'] ?? '',
//       jumlah: map['jumlah'] ?? 0,
//       dueDate: DateTime.parse(map['dueDate']),
//       paymentDate: map['paymentDate'] != null ? DateTime.parse(map['paymentDate']) : null,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'status': status,
//       'jumlah': jumlah,
//       'dueDate': dueDate.toIso8601String(),
//       'paymentDate': paymentDate?.toIso8601String(),
//     };
//   }
// }

// class Attendance {
//   final DateTime date;
//   final bool isPresent;

//   Attendance({
//     required this.date,
//     required this.isPresent,
//   });

//   factory Attendance.fromMap(Map<String, dynamic> map) {
//     return Attendance(
//       date: DateTime.parse(map['date']),
//       isPresent: map['isPresent'] ?? false,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'date': date.toIso8601String(),
//       'isPresent': isPresent,
//     };
//   }
// }

// class SavingsHistory {
//   final DateTime date;
//   final int amount;

//   SavingsHistory({
//     required this.date,
//     required this.amount,
//   });

//   factory SavingsHistory.fromMap(Map<String, dynamic> map) {
//     return SavingsHistory(
//       date: DateTime.parse(map['date']),
//       amount: map['amount'] ?? 0,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'date': date.toIso8601String(),
//       'amount': amount,
//     };
//   }
// }

// class User {
//   final String username;
//   final String name;
//   final String className;
//   final String photoUrl;
//   final List<Bill> bill;
//   final List<Attendance> attendance;
//   final List<SavingsHistory> savingsHistory;

//   User({
//     required this.username,
//     required this.name,
//     required this.className,
//     required this.photoUrl,
//     required this.bill,
//     required this.attendance,
//     required this.savingsHistory,
//   });

//   factory User.fromMap(Map<String, dynamic> map) {
//     return User(
//       username: map['username'] ?? '',
//       name: map['name'] ?? '',
//       className: map['className'] ?? '',
//       photoUrl: map['photoUrl'] ?? '',
//       bill: (map['bill'] as List).map((b) => Bill.fromMap(b)).toList(),
//       attendance: (map['attendance'] as List).map((a) => Attendance.fromMap(a)).toList(),
//       savingsHistory: (map['savings']['history'] as List)
//           .map((s) => SavingsHistory.fromMap(s))
//           .toList(),
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'username': username,
//       'name': name,
//       'className': className,
//       'photoUrl': photoUrl,
//       'bill': bill.map((b) => b.toMap()).toList(),
//       'attendance': attendance.map((a) => a.toMap()).toList(),
//       'savings': {
//         'history': savingsHistory.map((s) => s.toMap()).toList(),
//       },
//     };
//   }
// }
// class FirestoreService {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   // Mendapatkan pengguna berdasarkan username
//   Future<User?> getUserByUsername(String username) async {
//     QuerySnapshot querySnapshot = await _firestore
//         .collection('users')
//         .where('username', isEqualTo: username)
//         .get();

//     if (querySnapshot.docs.isNotEmpty) {
//       return User.fromMap(querySnapshot.docs.first.data() as Map<String, dynamic>);
//     }
//     return null;
//   }

//   // Mendapatkan pengumuman
//   Future<List<Map<String, dynamic>>> getAnnouncements() async {
//     QuerySnapshot querySnapshot = await _firestore.collection('announcements').get();
//     return querySnapshot.docs.map((doc) {
//       return doc.data() as Map<String, dynamic>;
//     }).toList();
//   }

//   // Mendapatkan video
//   Future<List<Map<String, dynamic>>> getVideos() async {
//     QuerySnapshot querySnapshot = await _firestore.collection('videos').get();
//     return querySnapshot.docs.map((doc) {
//       return doc.data() as Map<String, dynamic>;
//     }).toList();
//   }
// }
