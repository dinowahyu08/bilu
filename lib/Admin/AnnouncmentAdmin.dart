import 'package:bilu2/provider/announcmentProvider.dart';
import 'package:flutter/material.dart';  
import 'package:provider/provider.dart';  
import 'package:bilu2/theme.dart';  
  
class AnnouncementPageAdmin extends StatefulWidget {  
  @override  
  _AnnouncementPageAdminState createState() => _AnnouncementPageAdminState();  
}  
  
class _AnnouncementPageAdminState extends State<AnnouncementPageAdmin> {  
  final _formKey = GlobalKey<FormState>();  
  final TextEditingController _titleController = TextEditingController();  
  final TextEditingController _contentController = TextEditingController();  
  String? _editingId;  
  
  @override  
  void initState() {  
    super.initState();  
    Provider.of<AnnouncementProvider>(context, listen: false).fetchAnnouncements();  
  }  
  
  void _resetForm() {  
    _formKey.currentState?.reset();  
    _titleController.clear();  
    _contentController.clear();  
    _editingId = null;  
  }  
  
  @override  
  Widget build(BuildContext context) {  
    final announcementProvider = Provider.of<AnnouncementProvider>(context);  
    
    if (announcementProvider.isLoading) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(color: blueColor),
        ),
      );
    }

    return Scaffold(  
      appBar: AppBar(  
        backgroundColor: blueColor,  
        foregroundColor: whiteColor,  
        title: Text(  
          'Manage Announcements',  
          style: boldTextStyle.copyWith(  
            color: whiteColor,  
            fontSize: 24,  
          ),  
        ),  
      ),  
      body: Padding(  
        padding: const EdgeInsets.all(10.0),  
        child: Column(  
          children: [  
            // Form for adding or editing announcements  
            Form(  
              key: _formKey,  
              child: Column(  
                children: [  
                  SizedBox(height: 10),  
                  Container(  
                    height: 60,  
                    child: TextFormField(  
                      validator: (value) {  
                        if (value == null || value.isEmpty) {  
                          return 'Please enter a title';  
                        }  
                        return null;  
                      },  
                      controller: _titleController,  
                      decoration: InputDecoration(  
                        labelText: 'Judul',  
                        border: OutlineInputBorder(  
                            borderRadius: BorderRadius.circular(10)),  
                      ),  
                    ),  
                  ),  
                  SizedBox(height: 10),  
                  Container(  
                    height: 60,  
                    child: TextFormField(  
                      controller: _contentController,  
                      decoration: InputDecoration(  
                        labelText: 'Konten',  
                        border: OutlineInputBorder(  
                            borderRadius: BorderRadius.circular(10)),  
                      ),  
                      validator: (value) {  
                        if (value == null || value.isEmpty) {  
                          return 'Please enter content';  
                        }  
                        return null;  
                      },  
                    ),  
                  ),  
                  SizedBox(height: 16),  
                  SizedBox(  
                    height: 55,  
                    width: double.infinity,  
                    child: ElevatedButton(  
                      style: ElevatedButton.styleFrom(  
                          backgroundColor: blueColor,  
                          padding: EdgeInsets.symmetric(horizontal: 55),  
                          shape: RoundedRectangleBorder(  
                              borderRadius: BorderRadius.circular(10))),  
                      onPressed: () async {  
                        if (_formKey.currentState!.validate()) {  
                          if (_editingId == null) {  
                            // Add new announcement  
                            await announcementProvider.addAnnouncement(  
                              Announcement(  
                                title: _titleController.text,  
                                content: _contentController.text,  
                                date: DateTime.now().toIso8601String(), // Menggunakan DateTime sebagai string  
                              ),  
                            );  
                          } else {  
                            // Edit existing announcement  
                            await announcementProvider.updateAnnouncement(  
                              Announcement(  
                                id: _editingId,  
                                title: _titleController.text,  
                                content: _contentController.text,  
                                date: DateTime.now().toIso8601String(), // Menggunakan DateTime sebagai string  
                              ),  
                            );  
                          }  
  
                          _resetForm();  
                        }  
                      },  
                      child: Text(  
                        _editingId == null ? 'Add Announcement' : 'Update Announcement',  
                        style: semiBoldTextStyle.copyWith(  
                            color: whiteColor, fontSize: 18),  
                      ),  
                    ),  
                  ),  
                ],  
              ),  
            ),  
            SizedBox(height: 15),  
  
            // Announcement list  
            Expanded(  
              child: announcementProvider.announcements.isEmpty  
                  ? Center(child: Text('No announcements available.', style: mediumTextStyle.copyWith(color: blackcolor, fontSize: 14)))  
                  : ListView.builder(  
                      itemCount: announcementProvider.announcements.length,  
                      itemBuilder: (context, index) {  
                        final announcement = announcementProvider.announcements[index];  
                        return Card(  
                          color: whiteColor,  
                          margin: EdgeInsets.symmetric(vertical: 8),  
                          child: ListTile(  
                            title: Text(announcement.title, style: semiBoldTextStyle.copyWith(color: blackcolor, fontSize: 14)),  
                            subtitle: Text(announcement.content, style: regularTextStyle.copyWith(color: blackcolor, fontSize: 12)),  
                            trailing: Row(  
                              mainAxisSize: MainAxisSize.min,  
                              children: [  
                                IconButton(  
                                  icon: Icon(Icons.edit, color: blueColor),  
                                  onPressed: () {  
                                    setState(() {  
                                      _editingId = announcement.id;  
                                      _titleController.text = announcement.title;  
                                      _contentController.text = announcement.content;  
                                    });  
                                  },  
                                ),  
                                IconButton(  
                                  icon: Icon(Icons.delete, color: Colors.red),  
                                  onPressed: () async {  
                                    // Show a dialog to confirm the deletion  
                                    final confirmDelete = await showDialog<bool>(  
                                      context: context,  
                                      builder: (context) {  
                                        return AlertDialog(  
                                          title: Text('Konfirmasi Penghapusan', style: semiBoldTextStyle.copyWith(color: blackcolor, fontSize: 18)),  
                                          content: RichText(  
                                            text: TextSpan(  
                                              style: regularTextStyle.copyWith(color: blackcolor, fontSize: 14),  
                                              children: [  
                                                TextSpan(  
                                                  text: 'Apakah Kamu Yakin Menghapus Pengumuman ',  
                                                  style: regularTextStyle.copyWith(color: blackcolor, fontSize: 14),  
                                                ),  
                                                TextSpan(  
                                                  text: announcement.title,  
                                                  style: boldTextStyle.copyWith(color: blackcolor, fontSize: 14),  
                                                ),  
                                                TextSpan(  
                                                  text: '?',  
                                                  style: regularTextStyle.copyWith(color: blackcolor, fontSize: 14),  
                                                ),  
                                              ],  
                                            ),  
                                          ),  
                                          actions: [  
                                            TextButton(  
                                              onPressed: () {  
                                                Navigator.of(context).pop(false); // Cancel deletion  
                                              },  
                                              child: Text('Cancel', style: boldTextStyle.copyWith(color: blackcolor, fontSize: 12)),  
                                            ),  
                                            TextButton(  
                                              onPressed: () {  
                                                Navigator.of(context).pop(true); // Confirm deletion  
                                              },  
                                              child: Container(  
                                                decoration: BoxDecoration(color: Colors.redAccent, borderRadius: BorderRadius.all(Radius.circular(5))),  
                                                child: Padding(  
                                                  padding: const EdgeInsets.all(8.0),  
                                                  child: Text('Delete', style: boldTextStyle.copyWith(color: whiteColor, fontSize: 12)),  
                                                ),  
                                              ),  
                                            ),  
                                          ],  
                                        );  
                                      },  
                                    );  
  
                                    // If confirmed, delete the announcement  
                                    if (confirmDelete == true) {  
                                      await announcementProvider.deleteAnnouncement(announcement.id!);  
                                    }  
                                  },  
                                ),  
                              ],  
                            ),  
                          ),  
                        );  
                      },  
                    ),  
            ),  
          ],  
        ),  
      ),  
    );  
  }  
}  
