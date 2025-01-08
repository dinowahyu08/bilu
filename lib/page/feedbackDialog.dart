import 'package:bilu2/provider/userProvider.dart';
import 'package:bilu2/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> showFeedbackDialog(BuildContext context) async {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Mengambil data pengguna dari UserProvider
  final userProvider = Provider.of<UserProvider>(context, listen: false);
  String? _username = userProvider.username;
  String? _name = userProvider.name;
  String _selectedCategory = 'Masukan'; // Default category
  final TextEditingController _feedbackController = TextEditingController();

  // Cek jika data pengguna sudah ada di UserProvider
  if (_username.isEmpty || _name.isEmpty) {
    // Tampilkan pesan jika data pengguna belum tersedia
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Data pengguna belum tersedia.')),
    );
    return;
  }

  // Menampilkan dialog untuk input feedback
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title:  Text("Kirim Masukan",style:  boldTextStyle.copyWith(color: blackcolor,fontSize: 16),),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _feedbackController,
                maxLines: 4,
                decoration: const InputDecoration(
                  hintText: 'Tulis masukan Anda di sini...',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 15),
              DropdownButtonFormField<String>(
                value: _selectedCategory,
                onChanged: (value) {
                  _selectedCategory = value!;
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Kategori',
                ),
                items: const [
                  DropdownMenuItem(value: 'Masukan', child: Text('Masukan')),
                  DropdownMenuItem(value: 'Saran', child: Text('Saran')),
                  DropdownMenuItem(value: 'Keluhan', child: Text('Keluhan')),
                ],
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () async {
              final feedbackText = _feedbackController.text.trim();
              if (feedbackText.isNotEmpty && _username.isNotEmpty && _name.isNotEmpty) {
                try {
                  final timestamp = Timestamp.fromDate(DateTime.now()); // Menyimpan timestamp

                  await _firestore.collection('feedbacks').add({
                    'username': _username,
                    'name': _name,
                    'feedback': feedbackText,
                    'category': _selectedCategory,
                    'date': timestamp, // Menggunakan Timestamp untuk menyimpan waktu
                  });

                  String message;
                  if (_selectedCategory == 'Masukan' || _selectedCategory == 'Saran') {
                    message = 'Terima kasih untuk masukan dan saran Anda!';
                  } else {
                    message = 'Mohon maaf atas keluhan Anda, kami akan segera menindaklanjuti.';
                  }

                  Navigator.of(context).pop(); // Tutup dialog feedback

                  // Tampilkan pesan hasil
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Informasi'),
                      content: Text(message),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(); // Tutup dialog informasi
                          },
                          child: const Text('Tutup'),
                        ),
                      ],
                    ),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Gagal mengirim data. Coba lagi!')),
                  );
                }
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Masukan tidak boleh kosong!')),
                );
              }
            },
            child: const Text('Kirim'),
          ),
        ],
      );
    },
  );
}
