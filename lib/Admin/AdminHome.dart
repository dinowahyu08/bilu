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
import 'package:bilu2/Admin/KeuanganSiswa.dart';
import 'package:bilu2/Admin/VideoPageAdmin.dart';
import 'package:bilu2/provider/userProvider.dart';
import 'package:bilu2/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    if (userProvider.isLoading) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(color: blueColor),
        ),
      );
    }

    return Scaffold(
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
                '',
                style:
                    regularTextStyle.copyWith(color: blackcolor, fontSize: 14),
              ),
              SizedBox(height: 15),

              // Visualization Section
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    // Financial Analytics Container
                    Container(
                      color: blueColor,
                      width: MediaQuery.of(context).size.width / 2 - 17.5,
                      height: 180,
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Keuangan',
                            style: boldTextStyle.copyWith(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Tabungan: Rp 1.500.000',
                            style: regularTextStyle.copyWith(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            'Tertunggak: Rp 200.000',
                            style: regularTextStyle.copyWith(
                              color: Colors.redAccent,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            'Lunas: Rp 800.000',
                            style: regularTextStyle.copyWith(
                              color: Colors.greenAccent,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 5),

                    // Attendance Analytics Container
                    Container(
                      color: blueColor,
                      width: MediaQuery.of(context).size.width / 2 - 17.5,
                      height: 180,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Kehadiran',
                            style: boldTextStyle.copyWith(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(height: 16),
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              // Background Circle
                              Container(
                                width: 70,
                                height: 70,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white.withOpacity(0.2),
                                ),
                              ),
                              // Progress Circle
                              SizedBox(
                                width: 70,
                                height: 70,
                                child: CircularProgressIndicator(
                                  value: 0.75, // 75% attendance
                                  strokeWidth: 6,
                                  color: Colors.greenAccent,
                                  backgroundColor: Colors.white,
                                ),
                              ),
                              // Attendance Percentage
                              Text(
                                '75%',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
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
                  );},
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
                        Text(
                          "Video Pembelajaran",
                          style: boldTextStyle.copyWith(color: whiteColor,fontSize: 20)
                        ),
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
                    MaterialPageRoute(builder: (context) => AttendancePageAdmin()),
                  );},
                  
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
                        Text(
                          "Absensi",
                          style: boldTextStyle.copyWith(color: whiteColor,fontSize: 20)
                        ),
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
                    MaterialPageRoute(builder: (context) => AnnouncementPageAdmin()),
                  );},
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
                        Text(
                          "Pengumuman",
                          style: boldTextStyle.copyWith(color: whiteColor,fontSize: 20)
                        ),
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
                    MaterialPageRoute(builder: (context) => StudentFinancePage()),
                  );},
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
                        Text(
                          "Keuangan",
                          style: boldTextStyle.copyWith(color: whiteColor,fontSize: 20)
                        ),
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
                        Text(
                          "Students",
                          style: boldTextStyle.copyWith(color: whiteColor,fontSize: 20)
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              // Other buttons
              // Add other sections like Absensi, Pengumuman, Keuangan, Students
            ],
          ),
        ),
      ),
    );
  }
}

