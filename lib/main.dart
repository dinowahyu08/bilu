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
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:flutter/services.dart';


// Future<void> uploadDataToFirestore() async {
//   try {
//     // Baca file JSON dari assets
//     String jsonString = await rootBundle.loadString('assets/users.json');
//     Map<String, dynamic> jsonData = json.decode(jsonString);

//     // Ambil koleksi users dari JSON
//     List<dynamic> users = jsonData['users'];

//     // Referensi ke koleksi Firestore
//     CollectionReference usersCollection =
//         FirebaseFirestore.instance.collection('users');

//     // Loop untuk memasukkan setiap user ke Firestore
//     for (var user in users) {
//       await usersCollection.doc(user['username']).set(user);
//       print('Data untuk ${user['username']} berhasil ditambahkan.');
//     }

//     print('Semua data berhasil diunggah.');
//   } catch (e) {
//     print('Terjadi kesalahan: $e');
//   }
// }
Future<void> main() async {


  WidgetsFlutterBinding.ensureInitialized();
  
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
    return FutureBuilder(
      future: _checkIfLoggedIn(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(body: Center(child: CircularProgressIndicator())); // Loading screen
        } else if (snapshot.hasData && snapshot.data == true) {
          return HomeClient(); // Jika sudah login, masuk ke halaman utama
        } else {
          return LoginScreen(); // Jika belum login, masuk ke halaman login
        }
      },
    );
  }

  Future<bool> _checkIfLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false; // Kembalikan nilai false jika tidak ada status login
  }
}
class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
  String _username = ''; // Variable to store username

  @override
  void initState() {
    super.initState();
    _loadUsername(); // Load username from SharedPreferences
  }

  Future<void> _loadUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _username = prefs.getString('loggedInUser') ?? ''; // Get username from SharedPreferences
    
    });
  }
  // Daftar halaman
   List<Widget> get _pages => [
        HomeClient(),
        ProfilePage(username: _username,), // Pass the username here
      ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {
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
