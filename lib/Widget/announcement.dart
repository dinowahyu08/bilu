//  import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:flutter/material.dart';

// class AnnouncementScreen extends StatefulWidget {
//   const AnnouncementScreen({Key? key}) : super(key: key);

//   @override
//   _AnnouncementScreenState createState() => _AnnouncementScreenState();
// }

// class _AnnouncementScreenState extends State<AnnouncementScreen> {
//   List<dynamic> _announcements = [];

//   @override
//   void initState() {
//     super.initState();
//     _loadAnnouncements();
//   }

//   Future<void> _loadAnnouncements() async {
//     try {
//       final response = await http.get(Uri.parse('http://10.0.2.2:8000/pengumuman.json')); // URL JSON pengumuman
//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
//         setState(() {
//           _announcements = data['announcements'];
//         });
//       } else {
//         throw Exception('Failed to load announcements');
//       }
//     } catch (e) {
//       print("Error loading announcements: $e");
//     }
//   }

//   void _showAnnouncementsDialog() {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text("Daftar Pengumuman"),
//           content: SizedBox(
//             width: double.maxFinite,
//             child: ListView.builder(
//               shrinkWrap: true,
//               itemCount: _announcements.length,
//               itemBuilder: (context, index) {
//                 final announcement = _announcements[index];
//                 return ListTile(
//                   title: Text(announcement['title']),
//                   subtitle: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(announcement['content']),
//                       Text(
//                         announcement['date'],
//                         style: TextStyle(fontSize: 12, color: Colors.grey),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             ),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text("Tutup"),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Pengumuman")),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: _showAnnouncementsDialog,
//           child: Text("Lihat Pengumuman"),
//         ),
//       ),
//     );
//   }
// }
