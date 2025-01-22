// // import 'dart:convert';
// // import 'package:bilu2/Widget/billStatus.dart';
// // import 'package:bilu2/page/Keuangan.dart';
// // import 'package:bilu2/page/absensi.dart';
// // import 'package:bilu2/page/videoList.dart';
// // import 'package:bilu2/theme.dart';
// // import 'package:flutter/material.dart';
// // import 'package:shared_preferences/shared_preferences.dart';
// // import 'package:http/http.dart' as http;

// // class HomeClient extends StatefulWidget {
// //   const HomeClient({super.key});

// //   @override
// //   State<HomeClient> createState() => _HomeClientState();
// // }

// // class _HomeClientState extends State<HomeClient> {
// //   String _username = '';
// //   String _name = '';
// //   String _className = ''; // Menyimpan kelas pengguna
// //   String _photoUrl = ''; // Menyimpan URL foto pengguna
// //   List<dynamic> _bill = []; // Initially empty dynamic list

// //   @override
// //   void initState() {
// //     super.initState();
// //     _loadUserData(); // Memuat data pengguna dari SharedPreferences
// //   }

// //   // Fungsi untuk mengambil data nama pengguna dari SharedPreferences
// //   Future<void> _loadUserData() async {
// //     SharedPreferences prefs = await SharedPreferences.getInstance();
// //     _username = prefs.getString('loggedInUser') ?? ''; // Ambil nama pengguna
// //     await _loadUserFromServer(); // Memuat data pengguna dari server
// //   }

// //   // Fungsi untuk memuat data pengguna dari server HTTP
// //   Future<void> _loadUserFromServer() async {
// //     try {
// //       final response = await http.get(Uri.parse('http://10.0.2.2:8000/users.json'));

// //       if (response.statusCode == 200) {
// //         final data = json.decode(response.body);
// //         print(data);
// //         // Mencari pengguna berdasarkan username
// //         final user = data['users'].firstWhere((user) => user['username'] == _username, orElse: () => null);

// //         if (user != null) {
// //           setState(() {
// //             _name = user['name'] ?? '';
// //             _className = user['className'] ?? ''; // Ambil kelas
// //             _photoUrl = user['photoUrl'] ?? ''; // Ambil URL foto
// //             _bill = user['bill'] ?? [];
// //           });
// //         }
// //       } else {
// //         print('Failed to load user data from server: ${response.statusCode}');
// //       }
// //     } catch (e) {
// //       print('Error loading user data: $e');
// //     }
// //   }
// // Future<void> _showAnnouncementDialog() async {
// //   String announcementText = ""; // Default text

// //   try {
// //     final response = await http.get(Uri.parse('http://10.0.2.2:8000/pengumuman.json')); // URL JSON pengumuman
// //     if (response.statusCode == 200) {
// //       final data = json.decode(response.body);
// //       announcementText = data['announcement']; // Ambil teks pengumuman dari JSON
// //       print('zz')
// //     } else {
// //       throw Exception('Failed to load announcement');
// //     }
// //   } catch (e) {
// //     print("Error loading announcement: $e");
// //   }

// //   // Tampilkan dialog pengumuman
// //   showDialog(
// //     context: context,
// //     builder: (context) {
// //       return AlertDialog(
// //         title: Text("Pengumuman"),
// //         content: Text(announcementText),
// //         actions: [
// //           TextButton(
// //             onPressed: () {
// //               Navigator.of(context).pop();
// //             },
// //             child: Text("Tutup"),
// //           ),
// //         ],
// //       );
// //     },
// //   );
// // }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       floatingActionButton: FloatingActionButton(
// //         onPressed: () {
// //           // Action when the FAB is pressed
// //           _showAnnouncementDialog();
// //         },
// //         backgroundColor: blueColor,
// //         child: Icon(Icons.announcement,color: whiteColor,),
// //       ),
// //       body: Padding(
// //         padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
// //         child: SingleChildScrollView(
// //           child: Column(
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             children: [
// //               SizedBox(height: 45),
// //               Text(
// //                 'Halo $_name!',
// //                 style: boldTextStyle.copyWith(color: blueColor, fontSize: 32),
// //               ),
// //               SizedBox(height: 10),
// //               Text(
// //                 'Ayo belajar bersama BILU!',
// //                 style: regularTextStyle.copyWith(color: blackcolor, fontSize: 14),
// //               ),
// //               SizedBox(height: 27),
// //               BillStatusWidget(bills: _bill),
// //               SizedBox(height: 27),
// //               GestureDetector(
// //                 onTap: () {
// //                   Navigator.push(
// //                     context,
// //                     MaterialPageRoute(builder: (context) => VideoListScreen()),
// //                   );
// //                 },
// //                 child: Image.asset('assets/images/Button Video Pembelajaran.png'),
// //               ),
// //               SizedBox(height: 10),
// //               GestureDetector(
// //                 onTap: () {
// //                   Navigator.push(
// //                     context,
// //                     MaterialPageRoute(builder: (context) => AbsensiScreen(username: _username)),
// //                   );
// //                 },
// //                 child: Image.asset('assets/images/Button Absensi.png'),
// //               ),
// //               SizedBox(height: 10),
// //               GestureDetector(
// //                 onTap: () {
// //                   Navigator.push(
// //                     context,
// //                     MaterialPageRoute(builder: (context) => KeuanganScreen(username: _username)),
// //                   );
// //                 },
// //                 child: Image.asset('assets/images/Button Keuangan.png'),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }


// //#####################

 
// // import 'dart:convert';
// // import 'package:bilu2/Widget/billStatus.dart';
// // import 'package:bilu2/page/Keuangan.dart';
// // import 'package:bilu2/page/absensi.dart';
// // import 'package:bilu2/page/videoList.dart';
// // import 'package:bilu2/theme.dart';
// // import 'package:flutter/material.dart';
// // import 'package:shared_preferences/shared_preferences.dart';
// // import 'package:http/http.dart' as http;

// // class HomeClient extends StatefulWidget {
// //   const HomeClient({super.key});

// //   @override
// //   State<HomeClient> createState() => _HomeClientState();
// // }

// // class _HomeClientState extends State<HomeClient> {
// //   String _username = '';
// //   String _name = '';
// //   String _className = ''; // Menyimpan kelas pengguna
// //   String _photoUrl = ''; // Menyimpan URL foto pengguna
// //   List<dynamic> _bill = []; // Tagihan
// //   List<dynamic> _announcements = []; // Pengumuman

// //   @override
// //   void initState() {
// //     super.initState();
// //     _loadUserData(); // Memuat data pengguna dari SharedPreferences
// //     _loadAnnouncements(); // Memuat pengumuman dari server
// //   }

// //   // Fungsi untuk mengambil data nama pengguna dari SharedPreferences
// //   Future<void> _loadUserData() async {
// //     SharedPreferences prefs = await SharedPreferences.getInstance();
// //     _username = prefs.getString('loggedInUser') ?? '';
// //     await _loadUserFromServer();
// //   }

// //   // Fungsi untuk memuat data pengguna dari server HTTP
// //   Future<void> _loadUserFromServer() async {
// //     try {
// //       final response = await http.get(Uri.parse('http://10.0.2.2:8000/users.json'));
// //       if (response.statusCode == 200) {
// //         final data = json.decode(response.body);
// //         final user = data['users'].firstWhere((user) => user['username'] == _username, orElse: () => null);
// //         if (user != null) {
// //           setState(() {
// //             _name = user['name'] ?? '';
// //             _className = user['className'] ?? '';
// //             _photoUrl = user['photoUrl'] ?? '';
// //             _bill = user['bill'] ?? [];
// //           });
// //         }
// //       } else {
// //         print('Failed to load user data from server: ${response.statusCode}');
// //       }
// //     } catch (e) {
// //       print('Error loading user data: $e');
// //     }
// //   }

// //   // Fungsi untuk memuat pengumuman dari server
// //   Future<void> _loadAnnouncements() async {
// //     try {
// //       final response = await http.get(Uri.parse('http://10.0.2.2:8000/pengumuman.json'));
// //       if (response.statusCode == 200) {
// //         final data = json.decode(response.body);
// //         setState(() {
// //           _announcements = data['announcements']; // Memuat daftar pengumuman
// //         });
// //       } else {
// //         throw Exception('Failed to load announcements');
// //       }
// //     } catch (e) {
// //       print("Error loading announcements: $e");
// //     }
// //   }

// //   // Menampilkan dialog pengumuman
// //   void _showAnnouncementDialog() {
// //     showDialog(
// //       context: context,
// //       builder: (context) {
// //         return AlertDialog(
// //           title: Text("Pengumuman"),
// //           content: _announcements.isNotEmpty
// //               ? SingleChildScrollView(
// //                   child: Column(
// //                     crossAxisAlignment: CrossAxisAlignment.start,
// //                     children: _announcements.map((announcement) {
// //                       return Padding(
// //                         padding: const EdgeInsets.symmetric(vertical: 5.0),
// //                         child: Column(
// //                           crossAxisAlignment: CrossAxisAlignment.start,
// //                           children: [
// //                             Text(
// //                               announcement['title'],
// //                               style: TextStyle(fontWeight: FontWeight.bold),
// //                             ),
// //                             SizedBox(height: 5),
// //                             Text(announcement['content']),
// //                             SizedBox(height: 10),
// //                             Text(
// //                               announcement['date'],
// //                               style: TextStyle(color: Colors.grey, fontSize: 12),
// //                             ),
// //                             Divider(),
// //                           ],
// //                         ),
// //                       );
// //                     }).toList(),
// //                   ),
// //                 )
// //               : Text("Tidak ada pengumuman terbaru."),
// //           actions: [
// //             TextButton(
// //               onPressed: () {
// //                 Navigator.of(context).pop();
// //               },
// //               child: Text("Tutup"),
// //             ),
// //           ],
// //         );
// //       },
// //     );
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       floatingActionButton: FloatingActionButton(
// //         onPressed: _showAnnouncementDialog,
// //         backgroundColor: blueColor,
// //         child: Icon(Icons.announcement, color: whiteColor),
// //       ),
// //       body: Padding(
// //         padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
// //         child: SingleChildScrollView(
// //           child: Column(
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             children: [
// //               SizedBox(height: 45),
// //               Text(
// //                 'Halo $_name!',
// //                 style: boldTextStyle.copyWith(color: blueColor, fontSize: 32),
// //               ),
// //               SizedBox(height: 10),
// //               Text(
// //                 'Ayo belajar bersama BILU!',
// //                 style: regularTextStyle.copyWith(color: blackcolor, fontSize: 14),
// //               ),
// //               SizedBox(height: 27),
// //               BillStatusWidget(bills: _bill),
// //               SizedBox(height: 27),
// //               GestureDetector(
// //                 onTap: () {
// //                   Navigator.push(
// //                     context,
// //                     MaterialPageRoute(builder: (context) => VideoListScreen()),
// //                   );
// //                 },
// //                 child: Image.asset('assets/images/Button Video Pembelajaran.png'),
// //               ),
// //               SizedBox(height: 10),
// //               GestureDetector(
// //                 onTap: () {
// //                   Navigator.push(
// //                     context,
// //                     MaterialPageRoute(builder: (context) => AbsensiScreen(username: _username)),
// //                   );
// //                 },
// //                 child: Image.asset('assets/images/Button Absensi.png'),
// //               ),
// //               SizedBox(height: 10),
// //               GestureDetector(
// //                 onTap: () {
// //                   Navigator.push(
// //                     context,
// //                     MaterialPageRoute(builder: (context) => KeuanganScreen(username: _username)),
// //                   );
// //                 },
// //                 child: Image.asset('assets/images/Button Keuangan.png'),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }

// // ##############

// // import 'package:bilu2/provider/announcmentProvider.dart';
// // import 'package:bilu2/provider/userProvider.dart';
// // import 'package:flutter/material.dart';
// // import 'package:provider/provider.dart';
// // import 'package:bilu2/Widget/billStatus.dart';
// // import 'package:bilu2/page/Keuangan.dart';
// // import 'package:bilu2/page/absensi.dart';
// // import 'package:bilu2/page/videoList.dart';
// // import 'package:bilu2/theme.dart';

// // class HomeClient extends StatefulWidget {
// //   const HomeClient({super.key});

// //   @override
// //   State<HomeClient> createState() => _HomeClientState();
// // }

// // class _HomeClientState extends State<HomeClient> {
// //   @override
// //   void initState() {
// //     super.initState();
// //     // Memuat data pengguna dan pengumuman saat pertama kali aplikasi berjalan
// //     WidgetsBinding.instance.addPostFrameCallback((_) {
// //       Provider.of<UserProvider>(context, listen: false).loadUserData();
// //       Provider.of<AnnouncementProvider>(context, listen: false).loadAnnouncements();
// //     });
// //   }

// //   void _showAnnouncementDialog() {
// //     final announcements = Provider.of<AnnouncementProvider>(context, listen: false).announcements;

// //     showDialog(
// //       context: context,
// //       builder: (context) {
// //         return AlertDialog(
// //           title: Text("Pengumuman"),
// //           content: announcements.isNotEmpty
// //               ? SingleChildScrollView(
// //                   child: Column(
// //                     crossAxisAlignment: CrossAxisAlignment.start,
// //                     children: announcements.map((announcement) {
// //                       return Padding(
// //                         padding: const EdgeInsets.symmetric(vertical: 5.0),
// //                         child: Column(
// //                           crossAxisAlignment: CrossAxisAlignment.start,
// //                           children: [
// //                             Text(
// //                               announcement['title'],
// //                               style: TextStyle(fontWeight: FontWeight.bold),
// //                             ),
// //                             SizedBox(height: 5),
// //                             Text(announcement['content']),
// //                             SizedBox(height: 10),
// //                             Text(
// //                               announcement['date'],
// //                               style: TextStyle(color: Colors.grey, fontSize: 12),
// //                             ),
// //                             Divider(),
// //                           ],
// //                         ),
// //                       );
// //                     }).toList(),
// //                   ),
// //                 )
// //               : Text("Tidak ada pengumuman terbaru."),
// //           actions: [
// //             TextButton(
// //               onPressed: () {
// //                 Navigator.of(context).pop();
// //               },
// //               child: Text("Tutup"),
// //             ),
// //           ],
// //         );
// //       },
// //     );
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     final userProvider = Provider.of<UserProvider>(context);
// //     return Scaffold(
// //       floatingActionButton: FloatingActionButton(
// //         onPressed: _showAnnouncementDialog,
// //         backgroundColor: blueColor,
// //         child: Icon(Icons.announcement, color: whiteColor),
// //       ),
// //       body: Padding(
// //         padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
// //         child: SingleChildScrollView(
// //           child: Column(
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             children: [
// //               SizedBox(height: 45),
// //               Text(
// //                 'Halo ${userProvider.name}!',
// //                 style: boldTextStyle.copyWith(color: blueColor, fontSize: 32),
// //               ),
// //               SizedBox(height: 10),
// //               Text(
// //                 'Ayo belajar bersama BILU!',
// //                 style: regularTextStyle.copyWith(color: blackcolor, fontSize: 14),
// //               ),
// //               SizedBox(height: 27),
// //               BillStatusWidget(bills: userProvider.bill),
// //               SizedBox(height: 27),
// //               GestureDetector(
// //                 onTap: () {
// //                   Navigator.push(
// //                     context,
// //                     MaterialPageRoute(builder: (context) => VideoListScreen()),
// //                   );
// //                 },
// //                 child: Image.asset('assets/images/Button Video Pembelajaran.png'),
// //               ),
// //               SizedBox(height: 10),
// //               GestureDetector(
// //                 onTap: () {
// //                   Navigator.push(
// //                     context,
// //                     MaterialPageRoute(builder: (context) => AbsensiScreen(username: userProvider.username)),
// //                   );
// //                 },
// //                 child: Image.asset('assets/images/Button Absensi.png'),
// //               ),
// //               SizedBox(height: 10),
// //               GestureDetector(
// //                 onTap: () {
// //                   Navigator.push(
// //                     context,
// //                     MaterialPageRoute(builder: (context) => KeuanganScreen()),
// //                   );
// //                 },
// //                 child: Image.asset('assets/images/Button Keuangan.png'),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }


// // #################

import 'package:bilu2/page/showAnnouncement.dart';
import 'package:bilu2/provider/announcmentProvider.dart';
import 'package:bilu2/provider/userProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bilu2/Widget/billStatus.dart';
import 'package:bilu2/page/Keuangan.dart';
import 'package:bilu2/page/absensi.dart';
import 'package:bilu2/page/videoList.dart';
import 'package:bilu2/theme.dart';

class HomeClient extends StatefulWidget {
  const HomeClient({super.key});

  @override
  State<HomeClient> createState() => _HomeClientState();
}

class _HomeClientState extends State<HomeClient> {
  @override
  void initState() {
    super.initState();
    // Load user data and announcements when the app first starts
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<UserProvider>(context, listen: false).loadUserData();
      Provider.of<AnnouncementProvider>(context, listen: false).fetchAnnouncements();
    });
  }

  // Future <void> showAnnouncementDialog() async {
  //   final announcements = Provider.of<AnnouncementProvider>(context, listen: false).announcements;

  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return AlertDialog(
  //         title: Text("Pengumuman"),
  //         content: announcements.isNotEmpty
  //             ? SingleChildScrollView(
  //                 child: Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: announcements.map((announcement) {
  //                     return Padding(
  //                       padding: const EdgeInsets.symmetric(vertical: 5.0),
  //                       child: Column(
  //                         crossAxisAlignment: CrossAxisAlignment.start,
  //                         children: [
  //                           Text(
  //                             announcement['title'] ?? 'No title',
  //                             style: TextStyle(fontWeight: FontWeight.bold),
  //                           ),
  //                           SizedBox(height: 5),
  //                           Text(announcement['content'] ?? 'No content'),
  //                           SizedBox(height: 10),
  //                           Text(
  //                             announcement['date'] ?? 'No date',
  //                             style: TextStyle(color: Colors.grey, fontSize: 12),
  //                           ),
  //                           Divider(),
  //                         ],
  //                       ),
  //                     );
  //                   }).toList(),
  //                 ),
  //               )
  //             : Text("Tidak ada pengumuman terbaru."),
  //         actions: [
  //           TextButton(
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //             child: Text("Tutup"),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    
    final userProvider = Provider.of<UserProvider>(context);
    final announcementProvider = Provider.of<AnnouncementProvider>(context);
    int announcementCount = announcementProvider.announcements.length;
 if (userProvider.isLoading || announcementProvider.isLoading) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(color: blueColor),
        ),
      );
    }


    return Scaffold(
      floatingActionButton: FloatingActionButton(



        child: Container(height: 100,width: 100,
          child: Stack(  
                alignment: Alignment.center,  
                children: [  
                  
                Icon(Icons.announcement, color: whiteColor,size: 30,),
                   if (announcementCount > 0)  
                    Positioned(  
                      right: 30,
                    
                      top: 5,  
                      child: Container(  
                        padding: EdgeInsets.all(2),  
                        decoration: BoxDecoration(  
                          color: Colors.red,  
                          borderRadius: BorderRadius.circular(10),  
                        ),  
                        constraints: BoxConstraints(  
                          minWidth: 20,  
                          minHeight: 20,  
                        ),  
                        child: Text(  
                          '$announcementCount',  
                          style: TextStyle(  
                            color: Colors.white,  
                            fontSize: 12,  
                          ),  
                          textAlign: TextAlign.center,  
                        ),  
                      ),  
                    ), 
                ],  
              ),
        ),
        
        onPressed: (){showAnnouncementDialog(context); },
        backgroundColor: blueColor,
        
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 45),
              // Display user's name from the provider
              Text(
                'Halo ${userProvider.name}!',
                style: boldTextStyle.copyWith(color: blueColor, fontSize: 32),
              ),
              SizedBox(height: 10),
              Text(
                'Ayo belajar bersama BILU!',
                style: regularTextStyle.copyWith(color: blackcolor, fontSize: 14),
              ),
              SizedBox(height: 27),
              // Display bill status
              BillStatusWidget(bills: userProvider.bills),
              SizedBox(height: 27),
              // Navigate to video list screen
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => VideoListScreen()),
                  );
                },
                child: Image.asset('assets/images/Button Video Pembelajaran.png',width: double.infinity,),
              ),
              SizedBox(height: 10),
              // Navigate to attendance screen
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AbsensiScreen(username: userProvider.username)),
                  );
                },
                child: Image.asset('assets/images/Button Absensi.png',width: double.infinity),
              ),
              SizedBox(height: 10),
              // Navigate to finance screen
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => KeuanganScreen()),
                  );
                },
                child: Image.asset('assets/images/Button Keuangan.png',width: double.infinity),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
