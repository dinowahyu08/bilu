// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

// class EditProfilePage extends StatefulWidget {
//   final Map<String, dynamic> user;

//   EditProfilePage({required this.user});

//   @override
//   _EditProfilePageState createState() => _EditProfilePageState();
// }

// class _EditProfilePageState extends State<EditProfilePage> {
//   final _formKey = GlobalKey<FormState>();
//   late String username;
//   late String name;
//   late String className;
//   File? _image;

//   @override
//   void initState() {
//     super.initState();
//     username = widget.user['username'];
//     name = widget.user['name'];
//     className = widget.user['className'];
//   }

//   Future<void> _pickImage() async {
//     final picker = ImagePicker();
//     final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    
//     if (pickedFile != null) {
//       setState(() {
//         _image = File(pickedFile.path);
//       });
//     }
//   }

//   void _saveProfile() {
//     if (_formKey.currentState!.validate()) {
//       // Simpan perubahan di sini
//       // Misalnya, kirim data ke server atau simpan ke SharedPreferences
//       print('Username: $username');
//       print('Name: $name');
//       print('Class: $className');
//       if (_image != null) {
//         print('Profile Picture: ${_image!.path}');
//       }

//       // Kembali ke halaman sebelumnya
//       Navigator.pop(context);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Edit Profile'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Center(
//                 child: GestureDetector(
//                   onTap: _pickImage,
//                   child: CircleAvatar(
//                     radius: 50,
//                     backgroundImage: _image == null
//                         ? NetworkImage(widget.user['photoUrl'])
//                         : FileImage(_image!),
//                     child: _image == null
//                         ? Icon(Icons.camera_alt, color: Colors.white)
//                         : null,
//                   ),
//                 ),
//               ),
//               SizedBox(height: 20),
//               TextFormField(
//                 initialValue: username,
//                 decoration: InputDecoration(labelText: 'Username'),
//                 onChanged: (value) {
//                   username = value;
//                 },
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your username';
//                   }
//                   return null;
//                 },
//               ),
//               TextFormField(
//                 initialValue: name,
//                 decoration: InputDecoration(labelText: 'Name'),
//                 onChanged: (value) {
//                   name = value;
//                 },
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your name';
//                   }
//                   return null;
//                 },
//               ),
//               TextFormField(
//                 initialValue: className,
//                 decoration: InputDecoration(labelText: 'Class'),
//                 onChanged: (value) {
//                   className = value;
//                 },
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your class';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: _saveProfile,
//                 child: Text('Save Changes'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:io';
import 'package:bilu2/theme.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfilePage extends StatefulWidget {
  final String currentName;
  final String currentPhotoUrl;

  EditProfilePage({required this.currentName, required this.currentPhotoUrl});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final TextEditingController _nameController = TextEditingController();
  File? _newPhoto;
  bool isDarkMode = false; // Menyimpan status mode gelap

  @override
  void initState() {
    super.initState();
    _loadProfileData();  // Memuat data profil pengguna saat halaman dimuat
    _loadTheme(); // Memuat status mode gelap
  }

  // Fungsi untuk memuat status dark mode dari SharedPreferences
  Future<void> _loadTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isDarkMode = prefs.getBool('isDarkMode') ?? false; // Memuat status dark mode
    });
  }

  // Fungsi untuk memuat data profil dari SharedPreferences berdasarkan username
  Future<void> _loadProfileData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Ambil data nama dan foto berdasarkan kunci unik (misalnya berdasarkan username)
    String? savedName = prefs.getString('${widget.currentName}_name');
    String? savedPhotoUrl = prefs.getString('${widget.currentName}_photoUrl');

    setState(() {
      // Jika data nama ada, set ke controller, jika tidak, gunakan nama yang sudah ada
      _nameController.text = savedName ?? widget.currentName;
      // Jika ada foto yang disimpan, ubah ke File baru
      _newPhoto = savedPhotoUrl != null ? File(savedPhotoUrl) : null;
    });
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final directory = await getApplicationDocumentsDirectory();
      final newPath = '${directory.path}/${pickedFile.name}';
      final newImage = File(newPath);

      await File(pickedFile.path).copy(newImage.path);

      setState(() {
        _newPhoto = newImage;
      });
    }
  }

  void _saveChanges() async {
    String newName = _nameController.text;

    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Simpan nama baru dengan kunci yang unik berdasarkan username
    await prefs.setString('${widget.currentName}_name', newName);

    // Simpan foto baru jika ada
    if (_newPhoto != null) {
      await prefs.setString('${widget.currentName}_photoUrl', _newPhoto!.path);
    } else {
      await prefs.setString('${widget.currentName}_photoUrl', widget.currentPhotoUrl);
    }

    // Kembali ke halaman sebelumnya dengan data baru
    Navigator.pop(context, {
      'name': newName,
      'photoUrl': _newPhoto?.path ?? widget.currentPhotoUrl
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isDarkMode ? Colors.black : whiteColor, // Sesuaikan latar belakang dengan mode gelap
      appBar: AppBar(
        backgroundColor: isDarkMode ? Colors.grey[900] : blueColor, // Sesuaikan warna AppBar dengan mode gelap
        title: Text(
          "Edit Profile",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: _pickImage,
                child: CircleAvatar(
                  radius: 60,
                  backgroundColor: isDarkMode ? Colors.grey.shade700 : Colors.grey.shade300, // Sesuaikan warna background foto dengan mode gelap
                  backgroundImage: _newPhoto != null
                      ? FileImage(_newPhoto!)
                      : NetworkImage(widget.currentPhotoUrl) as ImageProvider,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Tap to change profile photo',
                style: TextStyle(
                  fontSize: 14,
                  color: isDarkMode ? Colors.white : blueColor, // Sesuaikan teks dengan mode gelap
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 30),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: "Name",
                  labelStyle: TextStyle(color: isDarkMode ? Colors.white : blueColor), // Label text sesuai mode gelap
                  hintText: "Enter your name",
                  hintStyle: TextStyle(color: isDarkMode ? Colors.grey : Colors.grey), // Hint text sesuai mode gelap
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: isDarkMode ? Colors.white : blueColor, width: 1.5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: isDarkMode ? Colors.white : blueColor, width: 2),
                  ),
                ),
                style: TextStyle(color: isDarkMode ? Colors.white : blackcolor, fontSize: 16), // Teks input sesuai mode gelap
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: _saveChanges,
                style: ElevatedButton.styleFrom(
                  backgroundColor: isDarkMode ? Colors.grey[800] : Colors.red, // Tombol warna sesuai mode gelap
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                ),
                child: Text(
                  "Save Changes",
                  style: TextStyle(
                    color: whiteColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

