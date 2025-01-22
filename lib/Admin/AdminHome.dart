// import 'package:flutter/material.dart';

// class AdminHome extends StatefulWidget {
//   const AdminHome({super.key});

//   @override
//   State<AdminHome> createState() => _AdminHomeState();
// }

// class _AdminHomeState extends State<AdminHome> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Dashboard Admin'),
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//          Text("Manage Video")
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'package:bilu2/Admin/VideoPageAdmin.dart';
// import 'package:bilu2/provider/userProvider.dart';
// import 'package:bilu2/theme.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class AdminHome extends StatefulWidget {
//   const AdminHome({super.key});

//   @override
//   State<AdminHome> createState() => _AdminHomeState();
// }

// class _AdminHomeState extends State<AdminHome> {
//     // double screenWidth = MediaQuery.of(context).size.width;

//   @override
//   Widget build(BuildContext context) {
//     final userProvider = Provider.of<UserProvider>(context);

//     if (userProvider.isLoading) {
//       return Scaffold(
//         body: Center(
//           child: CircularProgressIndicator(color: blueColor),
//         ),
//       );
//     }

//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(height: 45),
//               // Display user's name from the provider
//               Text(
//                 'Halo ${userProvider.name}!',
//                 style: boldTextStyle.copyWith(color: blueColor, fontSize: 32),
//               ),
//               SizedBox(height: 10),
//               Text(
//                 '',
//                 style:
//                     regularTextStyle.copyWith(color: blackcolor, fontSize: 14),
//               ),
//               SizedBox(height: 15),
//               SingleChildScrollView(scrollDirection: Axis.horizontal , child: Row(children: [Container(color: blueColor,width: MediaQuery.of(context).size.width/2-17.5,height: 150,child: Text(""),),SizedBox(width: 5,),Container(color: blueColor,width: MediaQuery.of(context).size.width/2-17.5,height: 150,)],)),

//               SizedBox(height: 15),
//               // Navigate to video list screen
//               Container(
//                 child: TextButton(
//                   style: ButtonStyle(

//                     backgroundColor:
//                         MaterialStateProperty.all<Color>(Color(0xFF487DD8)),
//                   ),
//                              onPressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => VideoPageAdmin()),
//                   );},
//                   child: Padding(
//                     padding: const EdgeInsets.all(15.0),
//                     child: Row(
//                       children: [
//                         Icon(
//                           Icons.video_collection,
//                           color: Colors.white, // Warna ikon
//                           size: 35, // Ukuran ikon
//                         ),
//                         SizedBox(width: 25), // Jarak antara ikon dan teks
//                         Text(
//                           "Video Pembelajaran",
//                           style: boldTextStyle.copyWith(color: whiteColor,fontSize: 20)
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 10),
//               // Navigate to video list screen
//               Container(
//                 child: TextButton(
//                   style: ButtonStyle(

//                     backgroundColor:
//                         MaterialStateProperty.all<Color>(Colors.teal),
//                   ),
//                   onPressed: () {
//                }
//                   ,
//                   child: Padding(
//                     padding: const EdgeInsets.all(15.0),
//                     child: Row(
//                       children: [
//                         Icon(
//                           Icons.checklist_sharp,
//                           color: Colors.white, // Warna ikon
//                           size: 35, // Ukuran ikon
//                         ),
//                         SizedBox(width: 25), // Jarak antara ikon dan teks
//                         Text(
//                           "Absensi",
//                           style: boldTextStyle.copyWith(color: whiteColor,fontSize: 20)
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 10),
//               // Navigate to video list screen
//               Container(
//                 child: TextButton(
//                   style: ButtonStyle(

//                     backgroundColor:
//                         MaterialStateProperty.all<Color>(Colors.deepOrange),
//                   ),
//                   onPressed: () {
//                   },
//                   child: Padding(
//                     padding: const EdgeInsets.all(15.0),
//                     child: Row(
//                       children: [
//                         Icon(
//                           Icons.announcement,
//                           color: Colors.white, // Warna ikon
//                           size: 35, // Ukuran ikon
//                         ),
//                         SizedBox(width: 25), // Jarak antara ikon dan teks
//                         Text(
//                           "Pengumuman",
//                           style: boldTextStyle.copyWith(color: whiteColor,fontSize: 20)
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 10),
//               // Navigate to video list screen
//               Container(
//                 child: TextButton(
//                   style: ButtonStyle(

//                     backgroundColor:
//                         MaterialStateProperty.all<Color>(Colors.green),
//                   ),
//                   onPressed: () {
//                   },
//                   child: Padding(
//                     padding: const EdgeInsets.all(15.0),
//                     child: Row(
//                       children: [
//                         Icon(
//                           Icons.monetization_on,
//                           color: Colors.white, // Warna ikon
//                           size: 35, // Ukuran ikon
//                         ),
//                         SizedBox(width: 25), // Jarak antara ikon dan teks
//                         Text(
//                           "Keuangan",
//                           style: boldTextStyle.copyWith(color: whiteColor,fontSize: 20)
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//                SizedBox(height: 10),
//               // Navigate to video list screen
//               Container(
//                 child: TextButton(
//                   style: ButtonStyle(

//                     backgroundColor:
//                         MaterialStateProperty.all<Color>(Colors.pink),
//                   ),
//                   onPressed: () {
//                   },
//                   child: Padding(
//                     padding: const EdgeInsets.all(15.0),
//                     child: Row(
//                       children: [
//                         Icon(
//                           Icons.people,
//                           color: Colors.white, // Warna ikon
//                           size: 35, // Ukuran ikon
//                         ),
//                         SizedBox(width: 25), // Jarak antara ikon dan teks
//                         Text(
//                           "Students",
//                           style: boldTextStyle.copyWith(color: whiteColor,fontSize: 20)
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// ############# analitic# ############

import 'package:bilu2/Admin/AnnouncmentAdmin.dart';
import 'package:bilu2/Admin/AttendacedPageAdmin.dart';
import 'package:bilu2/Admin/FeedbackAdmin.dart';
import 'package:bilu2/Admin/KeuanganSiswa.dart';
import 'package:bilu2/Admin/UserManagement.dart';
import 'package:bilu2/Admin/VideoPageAdmin.dart';
import 'package:bilu2/provider/userProvider.dart';
import 'package:bilu2/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  late BannerAd _bannerAd;
  bool _isBannerAdReady = false;
  int _widthBanner =0;

  @override
  void initState() {
    super.initState();
    _loadBannerAd();
  }

  void _loadBannerAd() {
    _bannerAd = BannerAd(
      adUnitId: 'ca-app-pub-7987994707204046/9643415718',
      size: AdSize.leaderboard,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isBannerAdReady = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          print('Failed to load a banner ad: ${error.message}');
          ad.dispose();
        },
      ),
    );
    _bannerAd.load();
  }

  @override
  void dispose() {
    _bannerAd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
     _widthBanner = MediaQuery.of(context).size.width.toInt();  

    if (userProvider.isLoading) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(color: blueColor),
        ),
      );
    }

    return Scaffold(
      backgroundColor: whiteColor,
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
              SizedBox(height: 15),

              // Visualization Section
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    // Financial Analytics Container
                    if (_isBannerAdReady)
                      Container(
                       
                        color: whiteColor,
                        width: _widthBanner.toDouble(),
                        height: 100,
                        child: AdWidget(ad: _bannerAd),
                      ),

                    // Attendance Analytics Container
                  ],
                ),
              ),

              SizedBox(height: 15),

              Container(
                child: TextButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Color(0xFF487DD8)),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => VideoPageAdmin()),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.video_collection,
                          color: Colors.white, // Warna ikon
                          size: 35, // Ukuran ikon
                        ),
                        SizedBox(width: 25), // Jarak antara ikon dan teks
                        Text("Video Pembelajaran",
                            style: boldTextStyle.copyWith(
                                color: whiteColor, fontSize: 20)),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              // Navigate to video list screen
              Container(
                child: TextButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.teal),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AttendancePageAdmin()),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.checklist_sharp,
                          color: Colors.white, // Warna ikon
                          size: 35, // Ukuran ikon
                        ),
                        SizedBox(width: 25), // Jarak antara ikon dan teks
                        Text("Absensi",
                            style: boldTextStyle.copyWith(
                                color: whiteColor, fontSize: 20)),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              // Navigate to video list screen
              Container(
                child: TextButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.deepOrange),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AnnouncementPageAdmin()),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.announcement,
                          color: Colors.white, // Warna ikon
                          size: 35, // Ukuran ikon
                        ),
                        SizedBox(width: 25), // Jarak antara ikon dan teks
                        Text("Pengumuman",
                            style: boldTextStyle.copyWith(
                                color: whiteColor, fontSize: 20)),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),

              // Navigate to video list screen
              Container(
                child: TextButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.green),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => StudentFinancePage()),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.monetization_on,
                          color: Colors.white, // Warna ikon
                          size: 35, // Ukuran ikon
                        ),
                        SizedBox(width: 25), // Jarak antara ikon dan teks
                        Text("Keuangan",
                            style: boldTextStyle.copyWith(
                                color: whiteColor, fontSize: 20)),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              // Navigate to video list screen
              Container(
                child: TextButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.pink),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => UserManagement()),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.people,
                          color: Colors.white, // Warna ikon
                          size: 35, // Ukuran ikon
                        ),
                        SizedBox(width: 25), // Jarak antara ikon dan teks
                        Text("Students",
                            style: boldTextStyle.copyWith(
                                color: whiteColor, fontSize: 20)),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                child: TextButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.purple),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FeedbackAdminPage()),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.message,
                          color: Colors.white, // Warna ikon
                          size: 35, // Ukuran ikon
                        ),
                        SizedBox(width: 25), // Jarak antara ikon dan teks
                        Text("Saran & Masukan",
                            style: boldTextStyle.copyWith(
                                color: whiteColor, fontSize: 20)),
                      ],
                    ),
                  ),
                ),
              ),
              // Other buttons
              // Add other sections like Absensi, Pengumuman, Keuangan, Students
            ],
          ),
        ),
      ),
    );
  }
}
