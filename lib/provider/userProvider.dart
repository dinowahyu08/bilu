import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider with ChangeNotifier {
  String _username = '';
  String _name = '';
  String _className = '';
  String _photoUrl = '';
  List<Map<String, dynamic>> _bill = [];
  List<Map<String, dynamic>> _attendance = [];
  Map<String, dynamic> _savings = {
    'history': [],
  };

  // Getters
  String get username => _username;
  String get name => _name;
  String get className => _className;
  String get photoUrl => _photoUrl;
  List<Map<String, dynamic>> get bill => _bill;
  List<Map<String, dynamic>> get attendance => _attendance;
  Map<String, dynamic> get savings => _savings;

  // Fungsi untuk memuat data pengguna dari SharedPreferences dan server
  Future<void> loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _username = prefs.getString('loggedInUser') ?? '';
    await _loadUserFromServer();
  }

  // Fungsi untuk memuat data pengguna dari server
  Future<void> _loadUserFromServer() async {
    try {
      final response = await http.get(Uri.parse('http://10.0.2.2:8000/users.json?username=$_username'));

      // final response = await http.get(Uri.parse('http://10.0.2.2:8000/users.json'));
      if (response.statusCode == 200) { 
        final data = json.decode(response.body);
        print(data);
        final user = data['users'].firstWhere((user) => user['username'] == _username, orElse: () => null);
        if (user != null) {
          _name = user['name'] ?? '';
          _className = user['className'] ?? '';
          _photoUrl = user['photoUrl'] ?? '';
          _bill = List<Map<String, dynamic>>.from(user['bill'] ?? []);
          _attendance = List<Map<String, dynamic>>.from(user['attendance'] ?? []);
          _savings = user['savings'] ?? {'history': []};
          notifyListeners();
        }
      }
    } catch (e) {
      print('Error loading user data: $e');
    }
  }
    // Method to format currency
  String formatRupiah(String amount) {
    final numberFormat = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );
    return numberFormat.format(int.parse(amount));
  }

  // Calculate total savings
  String calculateTotalSavings() {
    int total = 0;
    for (var entry in _savings['history']) {
      total += int.parse(entry['amount']);
    }
    return formatRupiah(total.toString());
  }
}


