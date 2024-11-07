import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChangePasswordPage extends StatefulWidget {
  final String username; // Pastikan username diteruskan untuk identifikasi pengguna

  ChangePasswordPage({required this.username});

  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _updatePassword() async {
    // Ambil data pengguna
    final response = await http.get(Uri.parse('http://10.0.2.2:8000/users.json'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final user = data['users'].firstWhere(
          (user) => user['username'] == widget.username,
          orElse: () => null);

      // Verifikasi kata sandi lama
      if (user != null && user['password'] == _currentPasswordController.text) {
        if (_newPasswordController.text == _confirmPasswordController.text) {
          // Update kata sandi baru
          user['password'] = _newPasswordController.text;

          // Kirim perubahan ke server
          final updateResponse = await http.put(
            Uri.parse('http://10.0.2.2:8000/users.json'),
            headers: {'Content-Type': 'application/json'},
            body: json.encode(data), // Encode data dengan kata sandi baru
          );

          if (updateResponse.statusCode == 200) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Password berhasil diubah')),
            );
            Navigator.pop(context);
          } else {
            print('Gagal memperbarui password: ${updateResponse.statusCode}');
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Konfirmasi password tidak cocok')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Kata sandi lama salah')),
        );
      }
    } else {
      print('Gagal memuat data pengguna: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Change Password'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _currentPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Current Password',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Masukkan kata sandi saat ini';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _newPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'New Password',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Masukkan kata sandi baru';
                  } else if (value.length < 6) {
                    return 'Kata sandi harus minimal 6 karakter';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _confirmPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Confirm New Password',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Konfirmasi kata sandi baru';
                  } else if (value != _newPasswordController.text) {
                    return 'Kata sandi tidak cocok';
                  }
                  return null;
                },
              ),
              SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _updatePassword();
                    }
                  },
                  child: Text('Change Password'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
