// import 'package:bilu2/theme.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:intl/intl.dart';
// import 'package:bilu2/provider/announcmentProvider.dart';
 
// Future<void> showAnnouncementDialog(BuildContext context) async {
//    String formatDate(DateTime date) {
//     return DateFormat('dd-MM-yyyy HH:mm').format(date); // Change format as needed
//   }
//   final announcements = Provider.of<AnnouncementProvider>(context, listen: false).announcements;
  
//   showDialog(
//     context: context,
//     builder: (context) {
//       return AlertDialog(
//         title: Text("Pengumuman",style: boldTextStyle.copyWith(color: blackcolor,fontSize: 20),),
//         content: announcements.isNotEmpty
//             ? SingleChildScrollView(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: announcements.map((announcement) {
//                     DateTime announcementDate = announcement['date'].toDate(); 
//                     return Padding(
//                       padding: const EdgeInsets.symmetric(vertical: 5.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             announcement['title'] ?? 'No title',
//                             style: semiBoldTextStyle.copyWith(color: blackcolor,fontSize: 16),
//                           ),
//                           SizedBox(height: 5),
//                           Text(announcement['content'] ?? 'No content',style: regularTextStyle.copyWith(color: blackcolor,fontSize: 12)),
//                           SizedBox(height: 10),
                          
//                           Text(formatDate(announcementDate),
                            
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
//           TextButton(style: TextButton.styleFrom(
//     backgroundColor: blueColor, // Background color
//     padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10), // Padding
//   ), 
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//             child: Text("Tutup",style: boldTextStyle.copyWith(color: whiteColor,fontSize: 14),),
//           ),
//         ],
//       );
//     },
//   );
// }


import 'package:bilu2/provider/announcmentProvider.dart';
import 'package:bilu2/theme.dart';  
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';  
import 'package:provider/provider.dart';  
import 'package:intl/intl.dart';  
  
Future<void> showAnnouncementDialog(BuildContext context) async {  
  String formatDate(DateTime date) {  
    return DateFormat('dd-MM-yyyy HH:mm').format(date); // Change format as needed  
  }  
  
  // Fetch announcements from the provider  
  final announcementProvider = Provider.of<AnnouncementProvider>(context, listen: false);  
  List<Announcement> announcements = announcementProvider.announcements;  
  
  final BannerAd myBanner = BannerAd(
    adUnitId: 'ca-app-pub-7987994707204046/2388281224',
    size: AdSize.banner,
    request: AdRequest(),
    listener: BannerAdListener(),
    
  );

  myBanner.load();


  showDialog(  
    context: context,  
    builder: (context) {  
      return Stack(
        children: [
          AlertDialog(  
            title: Text(  
              "Pengumuman",  
              style: boldTextStyle.copyWith(color: blackcolor, fontSize: 20),  
            ),  
            content: announcements.isNotEmpty  
                ? SingleChildScrollView(  
                    child: Column(  
                      crossAxisAlignment: CrossAxisAlignment.start,  
                      children: announcements.map((announcement) {  
                        DateTime announcementDate = DateTime.parse(announcement.date); // Parse the date string  
                        return Padding(  
                          padding: const EdgeInsets.symmetric(vertical: 5.0),  
                          child: Column(  
                            crossAxisAlignment: CrossAxisAlignment.start,  
                            children: [  
                              Text(  
                                announcement.title,  
                                style: semiBoldTextStyle.copyWith(color: blackcolor, fontSize: 16),  
                              ),  
                              SizedBox(height: 5),  
                              Text(  
                                announcement.content,  
                                style: regularTextStyle.copyWith(color: blackcolor, fontSize: 12),  
                              ),  
                              SizedBox(height: 10),  
                              Text(  
                                formatDate(announcementDate),  
                                style: TextStyle(color: Colors.grey, fontSize: 12),  
                              ),  
                              Divider(),  
                            ],  
                          ),  
                        );  
                      }).toList(),  
                    ),  
                  )  
                : Text("Tidak ada pengumuman terbaru."),  
            actions: [  
              TextButton(  
                style: TextButton.styleFrom(  
                  backgroundColor: blueColor, // Background color  
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10), // Padding  
                ),  
                onPressed: () {  
                  Navigator.of(context).pop();  
                  myBanner.dispose();
                },  
                child: Text(  
                  "Tutup",  
                  style: boldTextStyle.copyWith(color: whiteColor, fontSize: 14),  
                ),  
              ),  
            ],  
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.white,
              child: Container(
                width: myBanner.size.width.toDouble(),
                height: myBanner.size.height.toDouble(),
                child: AdWidget(ad: myBanner),
              ),
            ),
          ),
        ],
      );  
    },  
  );  
}  
