import 'package:bilu2/theme.dart';
import 'package:flutter/material.dart';  
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';  
  
class FeedbackAdminPage extends StatefulWidget {  
  @override  
  _FeedbackAdminPageState createState() => _FeedbackAdminPageState();  
}  
  
class _FeedbackAdminPageState extends State<FeedbackAdminPage> {  
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;  
  
  @override  
  Widget build(BuildContext context) {  
    return Scaffold(  backgroundColor: whiteColor,
      appBar: AppBar(  foregroundColor: whiteColor,
        title: Text('Daftar Feedback',  style: boldTextStyle.copyWith(
            color: whiteColor,
            fontSize: 20,
          ),),  
        backgroundColor: Colors.blue,  
      ),  
      body: Padding(
        padding: const EdgeInsets.fromLTRB(8,15,8,0),
        child: StreamBuilder<QuerySnapshot>(  
          stream: _firestore.collection('feedbacks').snapshots(),  
          builder: (context, snapshot) {  
            if (snapshot.connectionState == ConnectionState.waiting) {  
              return Center(child: CircularProgressIndicator());  
            }  
          
            if (snapshot.hasError) {  
              return Center(child: Text('Terjadi kesalahan: ${snapshot.error}'));  
            }  
          
            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {  
              return Center(child: Text('Tidak ada feedback.'));  
            }  
          
            return ListView.builder(  
              itemCount: snapshot.data!.docs.length,  
              itemBuilder: (context, index) {  
                final feedbackData = snapshot.data!.docs[index];  
                final feedback = feedbackData['feedback'];  
                final username = feedbackData['username'];  
                final name = feedbackData['name'];  
                final category = feedbackData['category'];  
                final date = feedbackData['date'];  
          
                return Container(  
                  decoration: BoxDecoration(
                              color: Colors.grey[100], // Warna putih abu-abu
                              borderRadius: BorderRadius.circular(
                                  8), // Opsional: untuk memberi sudut melengkung
                            ),
                            margin: const EdgeInsets.symmetric(
                                vertical: 5,
                                horizontal:
                                    15), 
                  child: Padding(  
                    padding: EdgeInsets.all(15),  
                    child: Column(  
                      crossAxisAlignment: CrossAxisAlignment.start,  
                      children: [  
                        Text(  
                          'Username: $username',  
                          style: boldTextStyle.copyWith(color: blackcolor,fontSize: 14),  
                        ),  
                        SizedBox(height: 5),  
        
                        Text('Nama: $name',style: semiBoldTextStyle.copyWith(color: blackcolor,fontSize: 14)),  
                        SizedBox(height: 5),  
                        Text(  
                          'Feedback: $feedback',  
                          style: regularTextStyle.copyWith(color: blackcolor,fontSize: 14),  
                        ),  
                        SizedBox(height: 5),  
                        Text('Kategori: $category',style: regularTextStyle.copyWith(color: blackcolor,fontSize: 14)),  
                        SizedBox(height: 5),  
                        Text(  
                          'Tanggal: ${DateFormat('yyyy-MM-dd').format(date.toDate())}',  
                          style: TextStyle(fontSize: 12, color: grey),  
                        ),  
                        SizedBox(height: 5),  
                        Align(  
                          alignment: Alignment.centerRight,  
                          child: ElevatedButton(  
                            
                            onPressed: () => _deleteFeedback(feedbackData.id),  
                            child: Text('Hapus',style: semiBoldTextStyle.copyWith(color: whiteColor,fontSize: 12),),  
                            style: ElevatedButton.styleFrom(  shadowColor: blackcolor,backgroundColor: Colors.blueAccent,
                            ),  
                          ),  
                        ),  
                      ],  
                    ),  
                  ),  
                );  
              },  
            );  
          },  
        ),
      ),  
    );  
  }  
  
  Future<void> _deleteFeedback(String feedbackId) async {  
    try {  
      await _firestore.collection('feedbacks').doc(feedbackId).delete();  
      ScaffoldMessenger.of(context).showSnackBar(  
        SnackBar(content: Text('Feedback berhasil dihapus.')),  
      );  
    } catch (e) {  
      ScaffoldMessenger.of(context).showSnackBar(  
        SnackBar(content: Text('Gagal menghapus feedback: $e')),  
      );  
    }  
  }  
}  
