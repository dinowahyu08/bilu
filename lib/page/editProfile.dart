import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditProfilePage extends StatefulWidget {
  final Map<String, dynamic> user;

  EditProfilePage({required this.user});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  late String username;
  late String name;
  late String className;
  File? _image;

  @override
  void initState() {
    super.initState();
    username = widget.user['username'];
    name = widget.user['name'];
    className = widget.user['className'];
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void _saveProfile() {
    if (_formKey.currentState!.validate()) {
      // Simpan perubahan di sini
      // Misalnya, kirim data ke server atau simpan ke SharedPreferences
      print('Username: $username');
      print('Name: $name');
      print('Class: $className');
      if (_image != null) {
        print('Profile Picture: ${_image!.path}');
      }

      // Kembali ke halaman sebelumnya
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: GestureDetector(
                  onTap: _pickImage,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: _image == null
                        ? NetworkImage(widget.user['photoUrl'])
                        : FileImage(_image!),
                    child: _image == null
                        ? Icon(Icons.camera_alt, color: Colors.white)
                        : null,
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                initialValue: username,
                decoration: InputDecoration(labelText: 'Username'),
                onChanged: (value) {
                  username = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your username';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: name,
                decoration: InputDecoration(labelText: 'Name'),
                onChanged: (value) {
                  name = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: className,
                decoration: InputDecoration(labelText: 'Class'),
                onChanged: (value) {
                  className = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your class';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveProfile,
                child: Text('Save Changes'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}