import 'package:bilu2/Admin/AdminHome.dart';
import 'package:bilu2/Admin/AdminProfilePage.dart';
import 'package:bilu2/page/HomeClient.dart';
import 'package:bilu2/page/Profile.dart';
import 'package:bilu2/page/login.dart';
import 'package:bilu2/page/splashScreen.dart';
import 'package:bilu2/provider/announcmentProvider.dart';
import 'package:bilu2/provider/userProvider.dart';
import 'package:bilu2/provider/videoProvider.dart';
import 'package:bilu2/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:flutter/services.dart';


// Future<void> uploadDataToFirestore() async {
  // try {
  //   // Baca file JSON dari assets
  //   String jsonString = await rootBundle.loadString('assets/users.json');
  //   Map<String, dynamic> jsonData = json.decode(jsonString);

  //   // Ambil koleksi users dari JSON
  //   List<dynamic> users = jsonData['users'];

  //   // Referensi ke koleksi Firestore
  //   CollectionReference usersCollection =
  //       FirebaseFirestore.instance.collection('users');

  //   // Loop untuk memasukkan setiap user ke Firestore
  //   for (var user in users) {
  //     await usersCollection.doc(user['username']).set(user);
  //     print('Data untuk ${user['username']} berhasil ditambahkan.');
  //   }

  //   print('Semua data berhasil diunggah.');
  // } catch (e) {
  //   print('Terjadi kesalahan: $e');
  // }
// Upload Announcement
//   try {
//     // Baca file JSON dari assets
//     String jsonString = await rootBundle.loadString('assets/pengumuman.json');
//     Map<String, dynamic> jsonData = json.decode(jsonString);

//     // Ambil data pengumuman dari JSON
//     List<dynamic> announcements = jsonData['announcements'];

//     // Referensi ke koleksi Firestore untuk announcements
//     CollectionReference announcementsCollection =
//         FirebaseFirestore.instance.collection('announcements');

//     // Loop untuk memasukkan setiap pengumuman ke Firestore
//     for (var announcement in announcements) {
//       // Membuat dokumen untuk setiap pengumuman menggunakan field title sebagai id
//       await announcementsCollection.add({
//         'title': announcement['title'],
//         'content': announcement['content'],
//         'date': announcement['date'],
//       });

//       print('Pengumuman "${announcement['title']}" berhasil ditambahkan.');
//     }

//     print('Semua pengumuman berhasil diunggah.');
//   } catch (e) {
//     print('Terjadi kesalahan: $e');
//   }
// Upload Video
// try {
//     // Baca file JSON dari assets
//     String jsonString = await rootBundle.loadString('assets/videos.json');
//     Map<String, dynamic> jsonData = json.decode(jsonString);

//     // Ambil data video dari JSON
//     List<dynamic> videos = jsonData['videos'];

//     // Referensi ke koleksi Firestore untuk videos
//     CollectionReference videosCollection =
//         FirebaseFirestore.instance.collection('videos');

//     // Loop untuk memasukkan setiap video ke Firestore
//     for (var video in videos) {
//       // Membuat dokumen untuk setiap video menggunakan field id sebagai id
//       await videosCollection.add({
//         'title': video['title'],
//         'description': video['description'],
//         'url': video['url'],
//       });

//       print('Video "${video['title']}" berhasil ditambahkan.');
//     }

//     print('Semua video berhasil diunggah.');
//   } catch (e) {
//     print('Terjadi kesalahan: $e');
//   }
// }


Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('id_ID', null);
  
  try {
    await Firebase.initializeApp();
  } catch (e) {
    print("Error initializing Firebase: $e");  // Log error jika terjadi
  }
  
  runApp(MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => AnnouncementProvider()),
          ChangeNotifierProvider(create: (_) => VideoProvider()),
  ], child: MyApp()));
  // await uploadDataToFirestore();
  // print('firestore done');
}
class CheckAuth extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    return FutureBuilder(
      future: userProvider.loadUserData(), // Memuat data user
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(body: Center(child: CircularProgressIndicator())); // Loading screen
        } else if (snapshot.connectionState == ConnectionState.done) {
          final role = userProvider.role; // Ambil role dari UserProvider

          if (role == 'admin') {
            return AdminHome(); // Halaman untuk admin
          } else if (role == 'user') {
            return MainPage(); // Halaman utama untuk user
          } else {
            return LoginScreen(); // Jika role tidak valid
          }
        } else {
          return LoginScreen(); // Jika ada error atau belum login
        }
      },
    );
  }
}


  Future<bool> _checkIfLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false; // Kembalikan nilai false jika tidak ada status login
  }

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(theme: ThemeData(colorSchemeSeed: blueColor),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0; // Indeks halaman yang dipilih
  String _role = ''; // Variable to store role

  @override
  void initState() {
    super.initState();
    _loadRole(); // Load role from UserProvider
  }

  Future<void> _loadRole() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    await userProvider.loadUserData(); // Memuat data dari Firestore
    setState(() {
      _role = userProvider.role; // Ambil role dari UserProvider
    });
  }

  // Daftar halaman untuk role "user"
  List<Widget> get _userPages => [
        HomeClient(),
        ProfilePage(username: Provider.of<UserProvider>(context).username),
      ];

  // Daftar halaman untuk role "admin"
  List<Widget> get _adminPages => [
        AdminHome(),
        AdminProfilePage(username: Provider.of<UserProvider>(context).username),
      ];

  // Tentukan halaman berdasarkan role
  List<Widget> get _pages => _role == 'admin' ? _adminPages : _userPages;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Tampilkan indikator loading jika role belum dimuat
    if (_role.isEmpty) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      body: _pages[_selectedIndex], // Menampilkan halaman sesuai dengan indeks yang dipilih
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex, // Menunjukkan halaman yang dipilih
        onTap: _onItemTapped, // Memanggil metode ketika item ditekan
        selectedItemColor: blueColor,
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}
