// import 'package:bilu2/provider/videoProvider.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class VideoPageAdmin extends StatefulWidget {
//   @override
//   _VideoPageAdminState createState() => _VideoPageAdminState();
// }

// class _VideoPageAdminState extends State<VideoPageAdmin> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _titleController = TextEditingController();
//   final TextEditingController _descriptionController = TextEditingController();
//   final TextEditingController _urlController = TextEditingController();

//   String? _editingId;

//   @override
//   void initState() {
//     super.initState();
//     Provider.of<VideoProvider>(context, listen: false).fetchVideos();
//   }

//   void _resetForm() {
//     _formKey.currentState?.reset();
//     _titleController.clear();
//     _descriptionController.clear();
//     _urlController.clear();
//     _editingId = null;
//   }

//   @override
//   Widget build(BuildContext context) {
//     final videoProvider = Provider.of<VideoProvider>(context);

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Manage Videos'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             // Form for adding or editing videos
//             Form(
//               key: _formKey,
//               child: Column(
//                 children: [
//                   TextFormField(
//                     controller: _titleController,
//                     decoration: InputDecoration(labelText: 'Title'),
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter a title';
//                       }
//                       return null;
//                     },
//                   ),
//                   TextFormField(
//                     controller: _descriptionController,
//                     decoration: InputDecoration(labelText: 'Description'),
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter a description';
//                       }
//                       return null;
//                     },
//                   ),
//                   TextFormField(
//                     controller: _urlController,
//                     decoration: InputDecoration(labelText: 'URL'),
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter a URL';
//                       }
//                       return null;
//                     },
//                   ),
//                   SizedBox(height: 16),
//                   ElevatedButton(
//                     onPressed: () async {
//                       if (_formKey.currentState!.validate()) {
//                         if (_editingId == null) {
//                           // Add new video
//                           await videoProvider.addVideo(
//                             title: _titleController.text,
//                             description: _descriptionController.text,
//                             url: _urlController.text,
//                           );
//                         } else {
//                           // Edit existing video
//                           await videoProvider.editVideo(
//                             id: _editingId!,
//                             title: _titleController.text,
//                             description: _descriptionController.text,
//                             url: _urlController.text,
//                           );
//                         }

//                         _resetForm();
//                       }
//                     },
//                     child: Text(_editingId == null ? 'Add Video' : 'Update Video'),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: 24),

//             // Video list
//             Expanded(
//   child: videoProvider.videos.isEmpty
//       ? Center(child: Text('No videos available.'))
//       : ListView.builder(
//           itemCount: videoProvider.videos.length,
//           itemBuilder: (context, index) {
//             final video = videoProvider.videos[index];
//             return Card(
//               margin: EdgeInsets.symmetric(vertical: 8),
//               child: ListTile(
//                 title: Text(video['title']),
//                 subtitle: Text(video['description']),
//                 trailing: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     IconButton(
//                       icon: Icon(Icons.edit, color: Colors.blue),
//                       onPressed: () {
//                         setState(() {
//                           _editingId = video['id'];
//                           _titleController.text = video['title'];
//                           _descriptionController.text = video['description'];
//                           _urlController.text = video['url'];
//                         });
//                       },
//                     ),
//                     IconButton(
//                       icon: Icon(Icons.delete, color: Colors.red),
//                       onPressed: () async {
//                         await videoProvider.deleteVideo(id: video['id']);
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
// ),
//           ],
//         ),
//       ),

//     );
//   }
// }

import 'package:bilu2/provider/videoProvider.dart';
import 'package:bilu2/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VideoPageAdmin extends StatefulWidget {
  @override
  _VideoPageAdminState createState() => _VideoPageAdminState();
}

class _VideoPageAdminState extends State<VideoPageAdmin> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _urlController = TextEditingController();

  String? _editingId;

  @override
  void initState() {
    super.initState();
    Provider.of<VideoProvider>(context, listen: false).fetchVideos();
  }

  void _resetForm() {
    _formKey.currentState?.reset();
    _titleController.clear();
    _descriptionController.clear();
    _urlController.clear();
    _editingId = null;
  }

  @override
  Widget build(BuildContext context) {
    final videoProvider = Provider.of<VideoProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: blueColor,
        foregroundColor: whiteColor,
        title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Manage Videos',
              style: boldTextStyle.copyWith(
                color: whiteColor,
                fontSize: 24,
              ),
            ),
            GestureDetector(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text('Panduan Key Video'),
                                          content: Text.rich(TextSpan(children:<TextSpan> [TextSpan(text: 'Cari Video YouTube, Lalu Share Dan Salin Linknya Seperti ini'),TextSpan(text: ' https://youtu.be/1C7fG8F5c2S?si=FXkPAg96IrpFrACc ',style: boldTextStyle),TextSpan(text: 'Perhatikan Key Video Setelah "/" Dan Sebelum "?" Key Videonya https://youtu.be/'),TextSpan(text: ' 1C7fG8F5c2S ',style: boldTextStyle),TextSpan(text: '?si=FXkPAg96IrpFrACc') ])
                                              ),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text('Tutup'),
                                            ),
                                          ],
                                        );
                                      });
                        
                                },
                                child: Icon(Icons.info_outline)
                              ),
          ],
        ),
        
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            // Form for adding or editing videos
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
                      controller: _descriptionController,
                      decoration: InputDecoration(
                          labelText: 'Deskripsi',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a description';
                        }
                        return null;
                      },
                    ),
                  ),
                      SizedBox(height: 10),
                  Container(
                    height: 60,
                    child: TextFormField(
                      controller: _urlController,
                                  decoration: InputDecoration(
                          labelText: 'Masukkan Key Video',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a URL';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 16),
                  SizedBox(
                          height: 55,
                    width: double.infinity,
                    child: 
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: blueColor,
                          padding: EdgeInsets.symmetric(horizontal: 55),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        if (_editingId == null) {
                          // Add new video
                          await videoProvider.addVideo(
                            title: _titleController.text,
                            description: _descriptionController.text,
                            url: _urlController.text,
                          );
                        } else {
                          // Edit existing video
                          await videoProvider.editVideo(
                            id: _editingId!,
                            title: _titleController.text,
                            description: _descriptionController.text,
                            url: _urlController.text,
                          );
                        }

                        _resetForm();
                      }
                    },
                    child:
                        Text(_editingId == null ? 'Add Video' : 'Update Video',style: semiBoldTextStyle.copyWith(
                            color: whiteColor, fontSize: 18)),
                  ),),
                ],
              ),
            ),
            SizedBox(height: 15),

            // Video list
            Expanded(
              child: videoProvider.videos.isEmpty
                  ? Center(child: Text('No videos available.',style: mediumTextStyle.copyWith(
                            color: blackcolor, fontSize: 14)))
                  : ListView.builder(
                      itemCount: videoProvider.videos.length,
                      itemBuilder: (context, index) {
                        final video = videoProvider.videos[index];
                        return Card(color: whiteColor,
                          margin: EdgeInsets.symmetric(vertical: 8),
                          child: ListTile(
                            title: Text(video['title'], style: semiBoldTextStyle.copyWith(
                            color: blackcolor, fontSize: 14)),
                            subtitle: Text(video['description'],style: regularTextStyle.copyWith(
                            color: blackcolor, fontSize: 12)),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.edit, color: blueColor),
                                  onPressed: () {
                                    setState(() {
                                      _editingId = video['id'];
                                      _titleController.text = video['title'];
                                      _descriptionController.text =
                                          video['description'];
                                      _urlController.text = video['url'];
                                    });
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete, color: Colors.red),
                                  onPressed: () async {
                                    // Show a dialog to confirm the deletion
                                    final confirmDelete =
                                        await showDialog<bool>(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text('Konfirmasi Penghapusan',style: semiBoldTextStyle.copyWith(color: blackcolor,fontSize: 18)),
                                          content: RichText(
                                            text: TextSpan(
                                              style: regularTextStyle.copyWith(color: blackcolor,fontSize: 14) ,// Style default untuk teks
                                              children: [
                                                TextSpan(
                                                  text:
                                                      'Apakah Kamu Yakin Menghapus Video ',
                                                 style: regularTextStyle.copyWith(color: blackcolor,fontSize: 14)  // Teks biasa
                                                ),
                                                TextSpan(
                                                  text: video['title'],
                                                 style: boldTextStyle.copyWith(color: blackcolor,fontSize: 14)  // Title bold
                                                ),
                                                TextSpan(
                                                  text: '?',
                                                 style: regularTextStyle.copyWith(color: blackcolor,fontSize: 14)  // Teks biasa lagi
                                                ),
                                              ],
                                            ),
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop(
                                                    false); // Cancel deletion
                                              },
                                              child: Text('Cancel',style: boldTextStyle.copyWith(color: blackcolor,fontSize: 12)),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop(
                                                    true); // Confirm deletion
                                              },
                                              child: Container(decoration: BoxDecoration(color: Colors.redAccent,borderRadius: BorderRadius.all(Radius.circular(5))),child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Text('Delete',style: boldTextStyle.copyWith(color: whiteColor,fontSize: 12),),
                                              )),
                                            ),
                                          ],
                                        );
                                      },
                                    );

                                    // If confirmed, delete the video
                                    if (confirmDelete == true) {
                                      await videoProvider.deleteVideo(
                                          id: video['id']);
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
