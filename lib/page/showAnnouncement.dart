import 'package:bilu2/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:bilu2/provider/announcmentProvider.dart';
 
Future<void> showAnnouncementDialog(BuildContext context) async {
   String formatDate(DateTime date) {
    return DateFormat('dd-MM-yyyy HH:mm').format(date); // Change format as needed
  }
  final announcements = Provider.of<AnnouncementProvider>(context, listen: false).announcements;
  
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text("Pengumuman",style: boldTextStyle.copyWith(color: blackcolor,fontSize: 20),),
        content: announcements.isNotEmpty
            ? SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: announcements.map((announcement) {
                    DateTime announcementDate = announcement['date'].toDate(); 
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            announcement['title'] ?? 'No title',
                            style: semiBoldTextStyle.copyWith(color: blackcolor,fontSize: 16),
                          ),
                          SizedBox(height: 5),
                          Text(announcement['content'] ?? 'No content',style: regularTextStyle.copyWith(color: blackcolor,fontSize: 12)),
                          SizedBox(height: 10),
                          
                          Text(formatDate(announcementDate),
                            
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
          TextButton(style: TextButton.styleFrom(
    backgroundColor: blueColor, // Background color
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10), // Padding
  ), 
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("Tutup",style: boldTextStyle.copyWith(color: whiteColor,fontSize: 14),),
          ),
        ],
      );
    },
  );
}
