// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:intl/intl.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class UserProvider with ChangeNotifier {
//   String _username = '';
//   String _name = '';
//   String _className = '';
//   String _photoUrl = '';
//   List<Map<String, dynamic>> _bill = [];
//   List<Map<String, dynamic>> _attendance = [];
//   Map<String, dynamic> _savings = {
//     'history': [],
//   };

//   // Getters
//   String get username => _username;
//   String get name => _name;
//   String get className => _className;
//   String get photoUrl => _photoUrl;
//   List<Map<String, dynamic>> get bill => _bill;
//   List<Map<String, dynamic>> get attendance => _attendance;
//   Map<String, dynamic> get savings => _savings;

//   // Fungsi untuk memuat data pengguna dari SharedPreferences dan server
//   Future<void> loadUserData() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     _username = prefs.getString('loggedInUser') ?? '';
//     await _loadUserFromServer();
//   }

//   // Fungsi untuk memuat data pengguna dari server
//   Future<void> _loadUserFromServer() async {
//     try {
//       final response = await http.get(Uri.parse('http://10.0.2.2:8000/users.json?username=$_username'));

//       // final response = await http.get(Uri.parse('http://10.0.2.2:8000/users.json'));
//       if (response.statusCode == 200) { 
//         final data = json.decode(response.body);
//         print(data);
//         final user = data['users'].firstWhere((user) => user['username'] == _username, orElse: () => null);
//         if (user != null) {
//           _name = user['name'] ?? '';
//           _className = user['className'] ?? '';
//           _photoUrl = user['photoUrl'] ?? '';
//           _bill = List<Map<String, dynamic>>.from(user['bill'] ?? []);
//           _attendance = List<Map<String, dynamic>>.from(user['attendance'] ?? []);
//           _savings = user['savings'] ?? {'history': []};
//           notifyListeners();
//         }
//       }
//     } catch (e) {
//       print('Error loading user data: $e');
//     }
//   }
//     // Method to format currency
//   String formatRupiah(String amount) {
//     final numberFormat = NumberFormat.currency(
//       locale: 'id_ID',
//       symbol: 'Rp ',
//       decimalDigits: 0,
//     );
//     return numberFormat.format(int.parse(amount));
//   }

//   // Calculate total savings
//   String calculateTotalSavings() {
//     int total = 0;
//     for (var entry in _savings['history']) {
//       total += int.parse(entry['amount']);
//     }
//     return formatRupiah(total.toString());
//   }
// }


// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart' as auth;
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// class UserProvider with ChangeNotifier {
//   String _username = '';
//   String _name = '';
//   String _className = '';
//   String _photoUrl = '';
//   List<Map<String, dynamic>> _bill = [];
//   List<Map<String, dynamic>> _attendance = [];
//   Map<String, dynamic> _savings = {
//     'history': [],
//   };

//   // Getters
//   String get username => _username;
//   String get name => _name;
//   String get className => _className;
//   String get photoUrl => _photoUrl;
//   List<Map<String, dynamic>> get bill => _bill;
//   List<Map<String, dynamic>> get attendance => _attendance;
//   Map<String, dynamic> get savings => _savings;

//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;

//   // Fungsi untuk memuat data pengguna dari Firestore
//   Future<void> loadUserData() async {
//     // Get the current user from FirebaseAuth
//     final user = _firebaseAuth.currentUser;

//     if (user != null) {
//       _username = user.email ?? ''; // Assuming the username is stored in the displayName
//       await _loadUserFromFirestore();
//       print(user);
//       print('GET USER PROVIDER DONE');

//     }

//   }

//   // Fungsi untuk memuat data pengguna dari Firestore
//   Future<void> _loadUserFromFirestore() async {
//     try {
//       // Fetch user data from Firestore collection
//       final userSnapshot = await _firestore
//           .collection('users')
//           .where('username', isEqualTo: _username)
//           .get();

//       if (userSnapshot.docs.isNotEmpty) {
//         final user = userSnapshot.docs.first.data();
//         _name = user['name'] ?? '';
//         _className = user['className'] ?? '';
//         _photoUrl = user['photoUrl'] ?? '';
//         _bill = List<Map<String, dynamic>>.from(user['bill'] ?? []);
//         _attendance = List<Map<String, dynamic>>.from(user['attendance'] ?? []);
//         _savings = user['savings'] ?? {'history': []};
//         notifyListeners();
//       }
//     } catch (e) {
//       print('Error loading user data from Firestore: $e');
//     }
//   }

//   // Method to format currency
//   String formatRupiah(String amount) {
//     final numberFormat = NumberFormat.currency(
//       locale: 'id_ID',
//       symbol: 'Rp ',
//       decimalDigits: 0,
//     );
//     return numberFormat.format(int.parse(amount));
//   }

//   // Calculate total savings
// String calculateTotalSavings() {
//   int total = 0;
//   int temp=0;
//   // Loop through the history and add the amounts
//   for (var entry in _savings['history']) {
//     temp = entry['amount'];
//     total += temp;
//   }

//   return formatRupiah(total.toString());
// }
// }



  import 'package:cloud_firestore/cloud_firestore.dart';
  import 'package:firebase_auth/firebase_auth.dart' as auth;
  import 'package:flutter/material.dart';
  import 'package:intl/intl.dart';

  class UserProvider with ChangeNotifier {
    String _username = '';
    String _name = '';
    String _role='';
    String _className = '';
    String _photoUrl = '';
    List<Map<String, dynamic>> _bill = [];
    List<Map<String, dynamic>> _attendance = [];
    Map<String, dynamic> _savings = {
      'history': [],
    };
    bool _isLoading = false; // Tambahkan properti isLoading untuk melacak status pemuatan

    // Getters
    String get username => _username;
    String get name => _name;
    String get role => _role;
    String get className => _className;
    String get photoUrl => _photoUrl;
    List<Map<String, dynamic>> get bill => _bill;
    List<Map<String, dynamic>> get attendance => _attendance;
    Map<String, dynamic> get savings => _savings;
    bool get isLoading => _isLoading; // Getter untuk status pemuatan

    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;

    // Fungsi untuk memuat data pengguna dari Firestore
    Future<void> loadUserData() async {
      _isLoading = true; // Mulai pemuatan
      // notifyListeners();

      final user = _firebaseAuth.currentUser;

      if (user != null) {
        _username = user.email ?? '';
        await _loadUserFromFirestore();
        // print(user);
        print('GET USER PROVIDER DONE');
        print(user);
        

      }

      _isLoading = false; // Selesai pemuatan
      notifyListeners();
    }





   // Fungsi untuk menambah tabungan  
  Future<void> addSaving(String studentId, int amount) async {  
    try {  
      // Dapatkan dokumen pengguna berdasarkan studentId  
      final userDoc = _firestore.collection('users').doc(studentId);  
      final snapshot = await userDoc.get();  
  
      if (!snapshot.exists) {  
        throw Exception('Siswa tidak ditemukan');  
      }  
  
      // Ambil data pengguna  
      final data = snapshot.data() as Map<String, dynamic>;  
      final savings = data['savings'] as Map<String, dynamic>? ?? {'history': []};  
  
      // Tambahkan tabungan baru ke history  
      final newSaving = {  
        'date': Timestamp.now(), // Menyimpan tanggal saat ini  
        'amount': amount,  
      };  
  
      savings['history'].add(newSaving);  
  
      // Perbarui dokumen pengguna dengan tabungan yang baru ditambahkan  
      await userDoc.update({'savings': savings});  
      
      notifyListeners(); // Notifikasi perubahan  
    } catch (e) {  
      print('Error adding saving: $e');  
      throw e; // Lemparkan error untuk ditangani di UI  
    }  
  }  
    

Future<void> deleteBill(String studentId, String billId) async {  
  try {  
    final studentRef = _firestore.collection('users').doc(studentId);  
    final studentDoc = await studentRef.get();  
    final bills = studentDoc.data()?['bill'] as List<dynamic>?;  
  
    if (bills != null) {  
      final billToRemove = bills.firstWhere(  
        (bill) => bill['id'] == billId,  
        orElse: () => null,  
      );  
  
      if (billToRemove != null) {  
        await studentRef.update({  
          'bill': FieldValue.arrayRemove([billToRemove]),  
        });  
  
        notifyListeners();  
      } else {  
        throw Exception('Bill not found');  
      }  
    } else {  
      throw Exception('No bills found for this student');  
    }  
  } catch (e) {  
    print('Error deleting bill: $e');  
    throw e;  
  }  
}  


    Future<void> editBill(  
  String studentId,  
  String billId,  
  int amount,  
  String status,  
  DateTime dueDate,  
  DateTime? paymentDate,  
) async {  
  try {  
    final studentRef = _firestore.collection('users').doc(studentId);  
    final studentDoc = await studentRef.get();  
    final bills = studentDoc.data()?['bill'] as List<dynamic>?;  
  
    if (bills != null) {  
      final billToUpdate = bills.firstWhere(  
        (bill) => bill['id'] == billId,  
        orElse: () => null,  
      );  
  
      if (billToUpdate != null) {  
        final updatedBill = {  
          'id': billId,  
          'status': status,  
          'jumlah': amount,  
          'dueDate': dueDate.toIso8601String(),  
          'paymentDate': paymentDate?.toIso8601String(),  
        };  
  
        final updatedBills = bills.map((bill) {  
          return bill['id'] == billId ? updatedBill : bill;  
        }).toList();  
  
        await studentRef.update({  
          'bill': updatedBills,  
        });  
  
        notifyListeners();  
      } else {  
        throw Exception('Bill not found');  
      }  
    } else {  
      throw Exception('No bills found for this student');  
    }  
  } catch (e) {  
    print('Error editing bill: $e');  
    throw e;  
  }  
}  


 Future<void> addBill(  
  String studentId,  
  int amount,  
  String status,  
  DateTime dueDate,  
  DateTime? paymentDate,  
) async {  
  try {  
    final newBill = {  
      'id': DateTime.now().millisecondsSinceEpoch.toString(),  
      'status': status,  
      'jumlah': amount,  
      'dueDate': dueDate,  
      'paymentDate': paymentDate,  
    };  
  
    final studentRef = _firestore.collection('users').doc(studentId);  
    await studentRef.update({  
      'bill': FieldValue.arrayUnion([newBill]),  
    });  
  
    notifyListeners();  
  } catch (e) {  
    print('Error adding bill: $e');  
    throw e;  
  }  
}  


  Future<void> deleteSaving(String studentId,  savingId) async {  
    try {  
      final userDoc = FirebaseFirestore.instance.collection('users').doc(studentId);  
      final snapshot = await userDoc.get();  
  
      if (!snapshot.exists) {  
        throw Exception('User not found');  
      }  
  
      final data = snapshot.data() as Map<String, dynamic>;  
      final savings = data['savings']['history'] as List<dynamic>? ?? [];  
      print(savings);
  
      // Temukan indeks tabungan yang akan dihapus  
      final savingIndex = savingId;  
      print(savingIndex);

      if (savingIndex == -1) {  
        throw Exception('Saving not found');  
      }  
  
      // Hapus tabungan dari daftar  
      savings.removeAt(savingIndex);  
  
      // Perbarui dokumen pengguna dengan daftar tabungan yang telah dihapus  
      await userDoc.update({'savings.history': savings});  
  
      notifyListeners(); // Notifikasi perubahan state  
    } catch (e) {  
      print('Error deleting saving: $e');  
      throw e; // Lempar kembali error untuk ditangani di UI  
    }  
  }


  // Fungsi untuk mengambil semua data pengguna dengan role 'student'  
  Future<List<Map<String, dynamic>>> fetchAllStudents() async {  
    List<Map<String, dynamic>> students = [];  
    try {  
      // Ambil data pengguna dari koleksi Firestore dengan role 'student'  
      final studentSnapshot = await _firestore  
          .collection('users')  
          .where('role', isEqualTo: 'student')  
          .get();  
    
      // Jika ada dokumen yang ditemukan, tambahkan ke daftar students  
      for (var doc in studentSnapshot.docs) {  
        students.add(doc.data() as Map<String, dynamic>);  
      }  
    } catch (e) {  
      print('Error fetching students from Firestore: $e');  
    }  
    print("ALL STUDENT${students}");
    
    return students; // Kembalikan daftar pengguna dengan role 'student'  
  }  


 // Method to fetch all students by class  
  Future<void> fetchStudentsByClass(String className) async {  
    _isLoading = true;  
    notifyListeners();  
  
    try {  
      final snapshot = await _firestore  
          .collection('users')  
          .where('role', isEqualTo: 'student')  
          .where('className', isEqualTo: className)  
          .get();  
  
      _students = snapshot.docs.map((doc) {  
        final data = doc.data();  
        return {  
          'id': doc.id,  
          'name': data['name'],  
          'photoUrl': data['photoUrl'],  
          'className': data['className'],  
        };  
      }).toList();  
    } catch (e) {  
      print('Error fetching students: $e');  
    }  
  
    _isLoading = false;  
    notifyListeners();  
  }  
  


  List<Map<String, dynamic>> _students = [];  
  List<Map<String, dynamic>> get students => _students;  



    // Fungsi untuk memuat data pengguna dari Firestore
    Future<void> _loadUserFromFirestore() async {
      try {
        // Fetch user data from Firestore collection
        final userSnapshot = await _firestore
            .collection('users')
            .where('username', isEqualTo: _username)
            .get();

        if (userSnapshot.docs.isNotEmpty) {
          final user = userSnapshot.docs.first.data();
          _name = user['name'] ?? '';
          _role=user['role'] ?? '';
          _className = user['className'] ?? '';
          _photoUrl = user['photoUrl'] ?? '';
          _bill = List<Map<String, dynamic>>.from(user['bill'] ?? []);
          _attendance = List<Map<String, dynamic>>.from(user['attendance'] ?? []);
          _savings = user['savings'] ?? {'history': []};
        }
      } catch (e) {
        print('Error loading user data from Firestore: $e');
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
    int temp=0;
    // Loop through the history and add the amounts
    for (var entry in _savings['history']) {
      temp = entry['amount'];
      total += temp;
    }
      return formatRupiah(total.toString());
    }
  }

