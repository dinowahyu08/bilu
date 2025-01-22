// import 'package:bilu2/provider/userProvider.dart';
// import 'package:flutter/material.dart';  
// import 'package:provider/provider.dart';  
  
// class StudentFinancePage extends StatelessWidget {  
//   @override  
//   Widget build(BuildContext context) {  
//     final userProvider = Provider.of<UserProvider>(context);  
  
//     return Scaffold(  
//       appBar: AppBar(  
//         title: Text('Keuangan Siswa'),  
//       ),  
//       body: FutureBuilder(  
//         future: userProvider.fetchAllStudents(),  
//         builder: (context, snapshot) {  
//           if (userProvider.isLoading) {  
//             return Center(child: CircularProgressIndicator());  
//           }  
  
//           return ListView.builder(  
//             itemCount: userProvider.role.length, // Menggunakan attendance untuk daftar siswa  
//             itemBuilder: (context, index) {  
//               final student = userProvider.attendance[index]; // Misalkan attendance berisi data siswa  
//               return ListTile(  
//                 title: Text(student['name']),  
//                 subtitle: Text('Kelas: ${userProvider.className}'),  
//                 trailing: Row(  
//                   mainAxisSize: MainAxisSize.min,  
//                   children: [  
//                     IconButton(  
//                       icon: Icon(Icons.attach_money),  
//                       onPressed: () {  
//                         Navigator.push(  
//                           context,  
//                           MaterialPageRoute(  
//                             builder: (context) => SavingsPage(studentId: student['id']),  
//                           ),  
//                         );  
//                       },  
//                     ),  
//                     IconButton(  
//                       icon: Icon(Icons.receipt),  
//                       onPressed: () {  
//                         Navigator.push(  
//                           context,  
//                           MaterialPageRoute(  
//                             builder: (context) => BillsPage(studentId: student['id']),  
//                           ),  
//                         );  
//                       },  
//                     ),  
//                   ],  
//                 ),  
//               );  
//             },  
//           );  
//         },  
//       ),  
//     );  
//   }  
// }  

// class SavingsPage extends StatelessWidget {  
//   final String studentId;  
  
//   SavingsPage({required this.studentId});  
  
//   @override  
//   Widget build(BuildContext context) {  
//     final userProvider = Provider.of<UserProvider>(context);  
  
//     return Scaffold(  
//       appBar: AppBar(  
//         title: Text('Tabungan Siswa'),  
//       ),  
//       body: Column(  
//         children: [  
//           Expanded(  
//             child: ListView.builder(  
//               itemCount: userProvider.savings['history'].length,  
//               itemBuilder: (context, index) {  
//                 final saving = userProvider.savings['history'][index];  
//                 return ListTile(  
//                   title: Text('Jumlah: ${userProvider.formatRupiah(saving['amount'].toString())}'),  
//                   trailing: IconButton(  
//                     icon: Icon(Icons.delete),  
//                     onPressed: () {  
//                       // Tambahkan logika untuk menghapus tabungan  
//                     },  
//                   ),  
//                 );  
//               },  
//             ),  
//           ),  
//           ElevatedButton(  
//             onPressed: () {  
//               // Tambahkan logika untuk menambah tabungan  
//             },  
//             child: Text('Tambah Tabungan'),  
//           ),  
//         ],  
//       ),  
//     );  
//   }  
// }  

// class BillsPage extends StatelessWidget {  
//   final String studentId;  
  
//   BillsPage({required this.studentId});  
  
//   @override  
//   Widget build(BuildContext context) {  
//     final userProvider = Provider.of<UserProvider>(context);  
  
//     return Scaffold(  
//       appBar: AppBar(  
//         title: Text('Tagihan Siswa'),  
//       ),  
//       body: Column(  
//         children: [  
//           Expanded(  
//             child: ListView.builder(  
//               itemCount: userProvider.bill.length,  
//               itemBuilder: (context, index) {  
//                 final bill = userProvider.bill[index];  
//                 return ListTile(  
//                   title: Text('Tagihan: ${userProvider.formatRupiah(bill['amount'].toString())}'),  
//                   trailing: IconButton(  
//                     icon: Icon(Icons.delete),  
//                     onPressed: () {  
//                       // Tambahkan logika untuk menghapus tagihan  
//                     },  
//                   ),  
//                 );  
//               },  
//             ),  
//           ),  
//           ElevatedButton(  
//             onPressed: () {  
//               // Tambahkan logika untuk menambah tagihan  
//             },  
//             child: Text('Tambah Tagihan'),  
//           ),  
//         ],  
//       ),  
//     );  
//   }  
// }  




// import 'package:bilu2/provider/userProvider.dart';  
// import 'package:flutter/material.dart';    
// import 'package:provider/provider.dart';    
    
// class StudentFinancePage extends StatelessWidget {    
//   @override    
//   Widget build(BuildContext context) {    
//     final userProvider = Provider.of<UserProvider>(context);    
    
//     return Scaffold(    
//       appBar: AppBar(    
//         title: Text('Keuangan Siswa'),    
//       ),    
//       body: FutureBuilder(    
//         future: userProvider.fetchAllStudents(),    
//         builder: (context, snapshot) {    
//           if (userProvider.isLoading) {    
//             return Center(child: CircularProgressIndicator());    
//           }    
    
//           if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {  
//             final students = snapshot.data as List<Map<String, dynamic>>;  
//             return ListView.builder(    
//               itemCount: students.length,    
//               itemBuilder: (context, index) {    
//                 final student = students[index];    
//                 return ListTile(    
//                   title: Text(student['name']),    
//                   subtitle: Text('Kelas: ${student['className']}'),    
//                   trailing: Row(    
//                     mainAxisSize: MainAxisSize.min,    
//                     children: [    
//                       IconButton(    
//                         icon: Icon(Icons.attach_money),    
//                         onPressed: () {    
//                           Navigator.push(    
//                             context,    
//                             MaterialPageRoute(    
//                               builder: (context) => SavingsPage(studentId: student['id']),    
//                             ),    
//                           );    
//                         },    
//                       ),    
//                       IconButton(    
//                         icon: Icon(Icons.receipt),    
//                         onPressed: () {    
//                           Navigator.push(    
//                             context,    
//                             MaterialPageRoute(    
//                               builder: (context) => BillsPage(studentId: student['id']),    
//                             ),    
//                           );    
//                         },    
//                       ),    
//                     ],    
//                   ),    
//                 );    
//               },    
//             );    
//           } else {  
//             return Center(child: Text('Tidak ada siswa ditemukan.'));  
//           }  
//         },    
//       ),    
//     );    
//   }    
// }    
  
// class SavingsPage extends StatelessWidget {    
//   final String studentId;    
    
//   SavingsPage({required this.studentId});    
    
//   @override    
//   Widget build(BuildContext context) {    
//     final userProvider = Provider.of<UserProvider>(context);    
    
//     return Scaffold(    
//       appBar: AppBar(    
//         title: Text('Tabungan Siswa'),    
//       ),    
//       body: Column(    
//         children: [    
//           Expanded(    
//             child: ListView.builder(    
//               itemCount: userProvider.savings['history'].length,    
//               itemBuilder: (context, index) {    
//                 final saving = userProvider.savings['history'][index];    
//                 return ListTile(    
//                   title: Text('Jumlah: ${userProvider.formatRupiah(saving['amount'].toString())}'),    
//                   trailing: IconButton(    
//                     icon: Icon(Icons.delete),    
//                     onPressed: () {    
//                       // Logika untuk menghapus tabungan  
//                       // userProvider.deleteSaving(saving['id']); // Implementasikan fungsi ini di UserProvider  
//                     },    
//                   ),    
//                 );    
//               },    
//             ),    
//           ),    
//           ElevatedButton(    
//             onPressed: () {    
//               // Logika untuk menambah tabungan  
//               // userProvider.addSaving(studentId, amount); // Implementasikan fungsi ini di UserProvider  
//             },    
//             child: Text('Tambah Tabungan'),    
//           ),    
//         ],    
//       ),    
//     );    
//   }    
// }    
  
// class BillsPage extends StatelessWidget {    
//   final String studentId;    
    
//   BillsPage({required this.studentId});    
    
//   @override    
//   Widget build(BuildContext context) {    
//     final userProvider = Provider.of<UserProvider>(context);    
    
//     return Scaffold(    
//       appBar: AppBar(    
//         title: Text('Tagihan Siswa'),    
//       ),    
//       body: Column(    
//         children: [    
//           Expanded(    
//             child: ListView.builder(    
//               itemCount: userProvider.bill.length,    
//               itemBuilder: (context, index) {    
//                 final bill = userProvider.bill[index];    
//                 return ListTile(    
//                   title: Text('Tagihan: ${userProvider.formatRupiah(bill['amount'].toString())}'),    
//                   trailing: IconButton(    
//                     icon: Icon(Icons.delete),    
//                     onPressed: () {    
//                       // Logika untuk menghapus tagihan  
//                       // userProvider.deleteBill(bill['id']); // Implementasikan fungsi ini di UserProvider  
//                     },    
//                   ),    
//                 );    
//               },    
//             ),    
//           ),    
//           ElevatedButton(    
//             onPressed: () {    
//               // Logika untuk menambah tagihan  
//               // userProvider.addBill(studentId, amount); // Implementasikan fungsi ini di UserProvider  
//             },    
//             child: Text('Tambah Tagihan'),    
//           ),    
//         ],    
//       ),    
//     );    
//   }    
// }    



// import 'package:bilu2/provider/userProvider.dart';  
// import 'package:cloud_firestore/cloud_firestore.dart';    
// import 'package:flutter/material.dart';    
// import 'package:provider/provider.dart';    
    
// class StudentFinancePage extends StatefulWidget {    
//   @override    
//   _StudentFinancePageState createState() => _StudentFinancePageState();    
// }    
    
// class _StudentFinancePageState extends State<StudentFinancePage> {    
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;  
//   String? _selectedClass;  
//   Map<String, List<Map<String, dynamic>>> _studentsPerClass = {};  
//   List<Map<String, dynamic>> _bills = [];  
    
//   @override  
//   void initState() {  
//     _fetchAllStudents();  
//     super.initState();  
//   }  
  
//   Future<void> _fetchAllStudents() async {  
//     try {  
//       final snapshot = await _firestore  
//           .collection('users')  
//           .where('role', isEqualTo: 'student')  
//           .get();  
  
//       final students = snapshot.docs.map((doc) {  
//         final data = doc.data();  
//         return {  
//           'id': doc.id,  
//           'name': data['name'],  
//           'photoUrl': data['photoUrl'],  
//           'className': data['className'],  
//           'bill': data['bill'], // Ambil data tagihan  
//           'savings': data['savings'], // Ambil data tabungan  
//         };  
//       }).toList();  
  
//       final Map<String, List<Map<String, dynamic>>> groupedStudents = {};  
//       for (var student in students) {  
//         final className = student['className'] as String;  
//         if (!groupedStudents.containsKey(className)) {  
//           groupedStudents[className] = [];  
//         }  
//         groupedStudents[className]?.add(student);  
//       }  
  
//       setState(() {  
//         _studentsPerClass = groupedStudents;  
//       });  
//     } catch (e) {  
//       print('Error fetching students: $e');  
//     }  
//   }  
  
//   Future<void> _fetchBill() async {    
//     if (_selectedClass == null) return;    
    
//     try {    
//       final snapshot = await _firestore    
//           .collection('users')    
//           .where('className', isEqualTo: _selectedClass)    
//           .get();    
    
//       final List<Map<String, dynamic>> fetchedBills = [];    
    
//       for (var doc in snapshot.docs) {    
//         final data = doc.data();    
//         final bills = data['bill'] as List<dynamic>?;    
    
//         if (bills != null) {    
//           for (var record in bills) {    
//             fetchedBills.add({    
//               'studentId': doc.id,    
//               'status': record['status'],    
//               'jumlah': record['jumlah'],    
//               'dueDate': DateTime.parse(record['dueDate']), // Mengonversi string ke DateTime    
//               'paymentDate': record['paymentDate'] != null    
//                   ? DateTime.parse(record['paymentDate']) // Mengonversi string ke DateTime jika ada    
//                   : null,    
//             });    
//           }    
//         }    
//       }    
    
//       setState(() {    
//         _bills = fetchedBills;    
//       });    
//     } catch (e) {    
//       print('Error fetching bills: $e');    
//     }    
//   }  
  
//   @override    
//   Widget build(BuildContext context) {    
//     final userProvider = Provider.of<UserProvider>(context);    
    
//     return Scaffold(    
//       appBar: AppBar(    
//         title: Text('Keuangan Siswa'),    
//       ),    
//       body: Column(    
//         children: [    
//           // Dropdown untuk memilih kelas    
//           Padding(    
//             padding: const EdgeInsets.all(16.0),    
//             child: DropdownButton<String>(    
//               value: _selectedClass,    
//               hint: Text('Pilih Kelas'),    
//               onChanged: (value) {    
//                 setState(() {    
//                   _selectedClass = value;    
//                 });    
//                 _fetchBill(); // Ambil tagihan saat kelas dipilih    
//               },    
//               items: _studentsPerClass.keys.map((className) {    
//                 return DropdownMenuItem<String>(    
//                   value: className,    
//                   child: Text(className),    
//                 );    
//               }).toList(),    
//             ),    
//           ),    
//           // Menampilkan daftar siswa    
//           Expanded(    
//             child: ListView.builder(    
//               itemCount: _studentsPerClass[_selectedClass]?.length ?? 0,    
//               itemBuilder: (context, index) {    
//                 final student = _studentsPerClass[_selectedClass]![index];    
//                 return ListTile(    
//                   title: Text(student['name']),    
//                   subtitle: Text('Kelas: ${student['className']}'),    
//                   trailing: Row(    
//                     mainAxisSize: MainAxisSize.min,    
//                     children: [    
//                       IconButton(    
//                         icon: Icon(Icons.attach_money),    
//                         onPressed: () {    
//                           Navigator.push(    
//                             context,    
//                             MaterialPageRoute(    
//                               builder: (context) => SavingsPage(studentId: student['id'], savings: student['savings']),    
//                             ),    
//                           );    
//                         },    
//                       ),    
//                       IconButton(    
//                         icon: Icon(Icons.receipt),    
//                         onPressed: () {    
//                           Navigator.push(    
//                             context,    
//                             MaterialPageRoute(    
//                               builder: (context) => BillsPage(studentId: student['id'], bills: student['bill']),    
//                             ),    
//                           );    
//                         },    
//                       ),    
//                     ],    
//                   ),    
//                 );    
//               },    
//             ),    
//           ),    
//         ],    
//       ),    
//     );    
//   }    
// }    
  
// class BillsPage extends StatelessWidget {      
//   final String studentId;      
//   final List<dynamic> bills; // Tambahkan parameter bills  
      
//   BillsPage({required this.studentId, required this.bills});      
      
//   @override      
//   Widget build(BuildContext context) {      
//     return Scaffold(      
//       appBar: AppBar(      
//         title: Text('Tagihan Siswa'),      
//       ),      
//       body: Column(      
//         children: [      
//           Expanded(      
//             child: ListView.builder(      
//               itemCount: bills.length,      
//               itemBuilder: (context, index) {      
//                 final bill = bills[index];      
//                 return ListTile(      
//                   title: Text('Tagihan: ${bill['jumlah']}'),      
//                   subtitle: Text('Status: ${bill['status']}'),      
//                   trailing: IconButton(      
//                     icon: Icon(Icons.delete),      
//                     onPressed: () {      
//                       // Logika untuk menghapus tagihan    
//                       // userProvider.deleteBill(bill['id']); // Implementasikan fungsi ini di UserProvider    
//                     },      
//                   ),      
//                 );      
//               },      
//             ),      
//           ),      
//           ElevatedButton(      
//             onPressed: () {      
//               // Logika untuk menambah tagihan    
//               // userProvider.addBill(studentId, amount); // Implementasikan fungsi ini di UserProvider    
//             },      
//             child: Text('Tambah Tagihan'),      
//           ),      
//         ],      
//       ),      
//     );      
//   }      
// }      
  
// class SavingsPage extends StatelessWidget {      
//   final String studentId;      
//   final Map<String, dynamic> savings; // Tambahkan parameter savings  
      
//   SavingsPage({required this.studentId, required this.savings});      
      
//   @override    
//   Widget build(BuildContext context) {      
//     return Scaffold(      
//       appBar: AppBar(      
//         title: Text('Tabungan Siswa'),      
//       ),      
//       body: Column(      
//         children: [      
//           Expanded(      
//             child: ListView.builder(      
//               itemCount: savings['history'].length,      
//               itemBuilder: (context, index) {      
//                 final saving = savings['history'][index];      
//                 return ListTile(      
//                   title: Text('Jumlah: ${saving['amount']}'),      
//                   trailing: IconButton(      
//                     icon: Icon(Icons.delete),      
//                     onPressed: () {      
//                       // Logika untuk menghapus tabungan    
//                       // userProvider.deleteSaving(saving['id']); // Implementasikan fungsi ini di UserProvider    
//                     },      
//                   ),      
//                 );      
//               },      
//             ),      
//           ),      
//           ElevatedButton(      
//             onPressed: () {      
//               // Logika untuk menambah tabungan    
//               // userProvider.addSaving(studentId, amount); // Implementasikan fungsi ini di UserProvider    
//             },      
//             child: Text('Tambah Tabungan'),      
//           ),      
//         ],      
//       ),      
//     );      
//   }      
// }      
  

import 'package:bilu2/provider/userProvider.dart';
import 'package:bilu2/theme.dart';  
import 'package:cloud_firestore/cloud_firestore.dart';    
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';    
import 'package:provider/provider.dart';    
    
class StudentFinancePage extends StatefulWidget {    
  @override    
  _StudentFinancePageState createState() => _StudentFinancePageState();    
}    
    
class _StudentFinancePageState extends State<StudentFinancePage> {    
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;  
  String? _selectedClass;  
  Map<String, List<Map<String, dynamic>>> _studentsPerClass = {};  
  List<Map<String, dynamic>> _bills = [];  
    
  @override  
  void initState() {  
    _fetchAllStudents();  
    super.initState();  
  }  
  
  Future<void> _fetchAllStudents() async {  
    try {  
      final snapshot = await _firestore  
          .collection('users')  
          .where('role', isEqualTo: 'student')  
          .get();  
  
      final students = snapshot.docs.map((doc) {  
        final data = doc.data();  
        return {  
          'id': doc.id,  
          'name': data['name'],  
          'photoUrl': data['photoUrl'],  
          'className': data['className'],  
          'bill': data['bill'], // Ambil data tagihan  
          'savings': data['savings'], // Ambil data tabungan  
        };  
      }).toList();  
  
      final Map<String, List<Map<String, dynamic>>> groupedStudents = {};  
      for (var student in students) {  
        final className = student['className'] as String;  
        if (!groupedStudents.containsKey(className)) {  
          groupedStudents[className] = [];  
        }  
        groupedStudents[className]?.add(student);  
      }  
  
      setState(() {  
        _studentsPerClass = groupedStudents;  
      });  
    } catch (e) {  
      print('Error fetching students: $e');  
    }  
  }  
  
  

  Future<void> _fetchBill() async {    
    if (_selectedClass == null) return;    
        if (_selectedClass == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select a class')),
      );
      return;
    }
    try {    
      final snapshot = await _firestore    
          .collection('users')    
          .where('className', isEqualTo: _selectedClass)    
          .get();    
    
      final List<Map<String, dynamic>> fetchedBills = [];    
    
      for (var doc in snapshot.docs) {    
        final data = doc.data();    
        final bills = data['bill'] as List<dynamic>?;    
    
        if (bills != null) {    
          for (var record in bills) {    
            fetchedBills.add({    
              'studentId': doc.id,    
              'status': record['status'],    
              'jumlah': record['jumlah'],    
              'dueDate': record['dueDate'], // Mengonversi string ke DateTime    
              'paymentDate': record['paymentDate'] != null &&
                      record['paymentDate'] is String
                  ? DateTime.parse(record[
                      'paymentDate']) // Mengonversi string ke DateTime jika ada
                  : null, // Jika paymentDate null, maka tipe data menjadi null  
            });    
          }    
        }    
      }    
    
      setState(() {    
        _bills = fetchedBills;    
      });    
    } catch (e) {    
      print('Error fetching bills: $e');    
    }    
  }  
  
  @override    
  Widget build(BuildContext context) {    
    final userProvider = Provider.of<UserProvider>(context);    
    
    return Scaffold(    backgroundColor: whiteColor,
      appBar: AppBar(  
         backgroundColor: Colors.green,
        foregroundColor: whiteColor, 
        title: Text('Keuangan Siswa',style: boldTextStyle.copyWith(
            color: whiteColor,
            fontSize: 24,
          ),),    
      ),    
      body: Column(    
        children: [    
          // Dropdown untuk memilih kelas    
          Padding(    
            padding: const EdgeInsets.all(16.0),    
            child: DropdownButton<String>(  icon: Icon(Icons.arrow_drop_down),  
  iconSize: 24,  
  iconEnabledColor: blueColor,  
  iconDisabledColor: Colors.grey,  
  dropdownColor: whiteColor,  
  elevation: 16,  
  focusColor: blueColor,  
  underline: Container(  
    height: 2,  
    color: Colors.blue,  
  ),  
              value: _selectedClass,    
              hint: Text('Pilih Kelas'),    
              onChanged: (value) {    
                setState(() {    
                  _selectedClass = value;    
                });    
                _fetchBill(); // Ambil tagihan saat kelas dipilih    
              },    
              items: _studentsPerClass.keys.map((className) {    
                return DropdownMenuItem<String>(    
                  value: className,    
                  child: Text(className,style: mediumTextStyle.copyWith(color: blackcolor),),    
                );    
              }).toList(),    
            ),    
          ),    
          // Menampilkan daftar siswa    
          Expanded(    

            child: _selectedClass == null
                  ? Center(
                      child: Text('Please select a class to view students')):
            ListView.builder(    
              itemCount: _studentsPerClass[_selectedClass]?.length ?? 0,    
              itemBuilder: (context, index) {    
                final student = _studentsPerClass[_selectedClass]![index];    
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
                  child: ListTile(    
                    title: Text(student['name'],style: boldTextStyle.copyWith(color: blackcolor,fontSize: 18),),    
                    subtitle: Text('Kelas: ${student['className']}'),    
                    trailing: Row(    
                      mainAxisSize: MainAxisSize.min,    
                      children: [    
                        IconButton(    
                          icon: Icon(Icons.attach_money,color: Colors.green,),    
                          onPressed: () {    
                            Navigator.push(    
                              context,    
                              MaterialPageRoute(    
                                builder: (context) => SavingsPage(studentId: student['id'], savings: student['savings']),    
                              ),    
                            );    
                          },    
                        ),    
                        IconButton(    
                          icon: Icon(Icons.receipt,color: Colors.red,),    
                          onPressed: () {    
                            Navigator.push(    
                              context,    
                              MaterialPageRoute(    
                                builder: (context) => BillsPage(studentId: student['id'], bills: student['bill']),    
                              ),    
                            );    
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
    );    
  }    
}    
  
// class BillsPage extends StatefulWidget {      
//   final String studentId;      
//   final List<dynamic> bills; // Tambahkan parameter bills  
  
      
//  BillsPage({required this.studentId, List<dynamic>? bills})  
//       : bills = bills ?? [];       

//   @override
//   State<BillsPage> createState() => _BillsPageState();
// }

// class _BillsPageState extends State<BillsPage> {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;  
//   String? _selectedClass;  
//   Map<String, List<Map<String, dynamic>>> _studentsPerClass = {};  
//   List<Map<String, dynamic>> _bills = [];  
    
//   @override  
//   void initState() {  
//     _fetchAllStudents();  
//     _fetchBill();
//     super.initState();  
//   }  
  
//   Future<void> _fetchAllStudents() async {  
//     try {  
//       final snapshot = await _firestore  
//           .collection('users')  
//           .where('role', isEqualTo: 'student')  
//           .get();  
  
//       final students = snapshot.docs.map((doc) {  
//         final data = doc.data();  
//         return {  
//           'id': doc.id,  
//           'name': data['name'],  
//           'photoUrl': data['photoUrl'],  
//           'className': data['className'],  
//           'bill': data['bill'], // Ambil data tagihan  
//           'savings': data['savings'], // Ambil data tabungan  
//         };  
//       }).toList();  
  
//       final Map<String, List<Map<String, dynamic>>> groupedStudents = {};  
//       for (var student in students) {  
//         final className = student['className'] as String;  
//         if (!groupedStudents.containsKey(className)) {  
//           groupedStudents[className] = [];  
//         }  
//         groupedStudents[className]?.add(student);  
//       }  
  
//       setState(() {  
//         _studentsPerClass = groupedStudents;  
//       });  
//     } catch (e) {  
//       print('Error fetching students: $e');  
//     }  
//   }  
  
  

//   Future<void> _fetchBill() async {    
//     if (_selectedClass == null) return;    
//         if (_selectedClass == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Please select a class')),
//       );
//       return;
//     }
//     try {    
//       final snapshot = await _firestore    
//           .collection('users')    
//           .where('className', isEqualTo: _selectedClass)    
//           .get();    
    
//       final List<Map<String, dynamic>> fetchedBills = [];    
    
//       for (var doc in snapshot.docs) {    
//         final data = doc.data();    
//         final bills = data['bill'] as List<dynamic>?;    
    
//         if (bills != null) {    
//           for (var record in bills) {    
//             fetchedBills.add({    
//               'studentId': doc.id,    
//               'status': record['status'],    
//               'jumlah': record['jumlah'],    
//               'dueDate': record['dueDate'], // Mengonversi string ke DateTime    
//               'paymentDate': record['paymentDate'] != null &&
//                       record['paymentDate'] is String
//                   ? DateTime.parse(record[
//                       'paymentDate']) // Mengonversi string ke DateTime jika ada
//                   : null, // Jika paymentDate null, maka tipe data menjadi null  
//             });    
//           }    
//         }    
//       }    
    
//       setState(() {    
//         _bills = fetchedBills;    
//       });    
//     } catch (e) {    
//       print('Error fetching bills: $e');    
//     }    
//   }  


//   @override      
//   Widget build(BuildContext context) {   
//     final userProvider = Provider.of<UserProvider>(context); // Ambil UserProvider    

//     return Scaffold(      
//       appBar: AppBar(      
//         title: Text('Tagihan Siswa'),      
//       ),      
//       body: Column(      
//         children: [      
//           Expanded(      
//             child: ListView.builder(      
//               itemCount: widget.bills.length,      
//               itemBuilder: (context, index) {      
//                 final bill = widget.bills[index];      
//                 return ListTile(      
//                   title: Text('Tagihan: ${bill['jumlah']}'),      
//                   subtitle: Text('Status: ${bill['status']}'),      
//                   trailing: IconButton(      
//                     icon: Icon(Icons.delete),      
//                     onPressed: () async{      
//                       // Logika untuk menghapus tagihan    
//                       await userProvider.deleteBill(widget.studentId, index); // Implementasikan fungsi ini di UserProvider    
//                     },      
//                   ),      
//                 );      
//               },      
//             ),      
//           ),      
//           ElevatedButton(      
//             onPressed: () {      
//               // Logika untuk menambah tagihan    
//               // userProvider.addBill(studentId, amount); // Implementasikan fungsi ini di UserProvider    
//             },      
//             child: Text('Tambah Tagihan'),      
//           ),      
//         ],      
//       ),      
//     );      
//   }      
// }  
//

  
// class BillsPage extends StatefulWidget {  
//   final String studentId;  
//   final List<dynamic> bills;  
  
//   BillsPage({required this.studentId, List<dynamic>? bills})  
//       : bills = bills ?? [];  
  
//   @override  
//   State<BillsPage> createState() => _BillsPageState();  
// }  
  
// class _BillsPageState extends State<BillsPage> {  
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;  
//   String? _selectedClass;  
//   Map<String, List<Map<String, dynamic>>> _studentsPerClass = {};  
//   List<Map<String, dynamic>> _bills = [];  
//   DateTime? _dueDate;  
//   DateTime? _paymentDate;  
  
//   @override  
//   void initState() {  
//     _fetchAllStudents();  
//     _fetchBill();  
//     super.initState();  
//   }  
  
//   Future<void> _fetchAllStudents() async {  
//     try {  
//       final snapshot = await _firestore  
//           .collection('users')  
//           .where('role', isEqualTo: 'student')  
//           .get();  
  
//       final students = snapshot.docs.map((doc) {  
//         final data = doc.data();  
//         return {  
//           'id': doc.id,  
//           'name': data['name'],  
//           'photoUrl': data['photoUrl'],  
//           'className': data['className'],  
//           'bill': data['bill'],  
//           'savings': data['savings'],  
//         };  
//       }).toList();  
  
//       final Map<String, List<Map<String, dynamic>>> groupedStudents = {};  
//       for (var student in students) {  
//         final className = student['className'] as String;  
//         if (!groupedStudents.containsKey(className)) {  
//           groupedStudents[className] = [];  
//         }  
//         groupedStudents[className]?.add(student);  
//       }  
  
//       setState(() {  
//         _studentsPerClass = groupedStudents;  
//       });  
//     } catch (e) {  
//       print('Error fetching students: $e');  
//     }  
//   }  
  
//   Future<void> _fetchBill() async {  
//     if (_selectedClass == null) return;  
  
//     try {  
//       final snapshot = await _firestore  
//           .collection('users')  
//           .where('className', isEqualTo: _selectedClass)  
//           .get();  
  
//       final List<Map<String, dynamic>> fetchedBills = [];  
//       print('BILLLL FETCHEDDB BROOO');
//       for (var doc in snapshot.docs) {  
//         final data = doc.data();  
//         final bills = data['bill'] as List<dynamic>?;  
  
//         if (bills != null) {  
//           for (var record in bills) {  
//             fetchedBills.add({  
//               'studentId': doc.id,  
//               'status': record['status'],  
//               'jumlah': record['jumlah'],  
//               'dueDate': record['dueDate'] != null  
//                   ? DateTime.parse(record['dueDate'])  
//                   : null,  
//               'paymentDate': record['paymentDate'] != null &&  
//                       record['paymentDate'] is String  
//                   ? DateTime.parse(record['paymentDate'])  
//                   : null,  
//             });  
//           }  
//         }  
//       }  
  
//       setState(() {  
//         _bills = fetchedBills;  
//       });  
//     } catch (e) {  
//       print('Error fetching bills: $e');  
//     }  
//   }  
//   Future<void> _showAddEditBillDialog({Map<String, dynamic>? bill}) async {  
//   final userProvider = Provider.of<UserProvider>(context, listen: false);  
//   final TextEditingController amountController = TextEditingController();  
//   final TextEditingController statusController = TextEditingController();  
    
//   // Mengonversi dueDate dan paymentDate dengan memeriksa null  
//   DateTime? dueDate = bill != null && bill['dueDate'] != null  
//       ? DateTime.tryParse(bill['dueDate']) // Mengonversi string ke DateTime  
//       : null;  
    
//   DateTime? paymentDate = bill != null && bill['paymentDate'] != null  
//       ? DateTime.tryParse(bill['paymentDate']) // Mengonversi string ke DateTime  
//       : null;  
  
//   // Jika bill tidak null, isi controller dengan nilai yang ada  
//   if (bill != null) {  
//     amountController.text = bill['jumlah'].toString();  
//     statusController.text = bill['status'];  
//   }  
  
//   await showDialog(  
//     context: context,  
//     builder: (BuildContext context) {  
//       return AlertDialog(  
//         title: Text(bill != null ? 'Edit Bill' : 'Add Bill'),  
//         content: SingleChildScrollView(  
//           child: Column(  
//             mainAxisSize: MainAxisSize.min,  
//             children: <Widget>[  
//               TextField(  
//                 controller: amountController,  
//                 keyboardType: TextInputType.number,  
//                 decoration: InputDecoration(labelText: 'Amount'),  
//               ),  
//               TextField(  
//                 controller: statusController,  
//                 decoration: InputDecoration(labelText: 'Status'),  
//               ),  
//               ListTile(  
//                 title: Text('Due Date: ${dueDate != null ? DateFormat('yyyy-MM-dd').format(dueDate!) : 'Select Date'}'),  
//                 onTap: () async {  
//                   final DateTime? picked = await showDatePicker(  
//                     context: context,  
//                     initialDate: dueDate ?? DateTime.now(),  
//                     firstDate: DateTime(2000),  
//                     lastDate: DateTime(2101),  
//                   );  
//                   if (picked != null && picked != dueDate) {  
//                     setState(() {  
//                       dueDate = picked; // Memperbarui dueDate  
//                     });  
//                   }  
//                 },  
//               ),  
//               ListTile(  
//                 title: Text('Payment Date: ${paymentDate != null ? DateFormat('yyyy-MM-dd').format(paymentDate!) : 'Select Date'}'),  
//                 onTap: () async {  
//                   final DateTime? picked = await showDatePicker(  
//                     context: context,  
//                     initialDate: paymentDate ?? DateTime.now(),  
//                     firstDate: DateTime(2000),  
//                     lastDate: DateTime(2101),  
//                   );  
//                   if (picked != null && picked != paymentDate) {  
//                     setState(() {  
//                       paymentDate = picked; // Memperbarui paymentDate  
//                     });  
//                   }  
//                 },  
//               ),  
//             ],  
//           ),  
//         ),  
//         actions: <Widget>[  
//           TextButton(  
//             child: Text('Cancel'),  
//             onPressed: () {  
//               Navigator.of(context).pop();  
//             },  
//           ),  
//           TextButton(  
//             child: Text(bill != null ? 'Save' : 'Add'),  
//             onPressed: () async {  
//               final amount = int.tryParse(amountController.text);  
//               final status = statusController.text;  
  
//               if (amount != null && status.isNotEmpty && dueDate != null) {  
//                 if (bill != null) {  
//                   await userProvider.editBill(  
//                     widget.studentId,  
//                     bill['id'],  
//                     amount,  
//                     status,  
//                     dueDate!, // Menggunakan null assertion operator  
//                     paymentDate, // paymentDate bisa null  
//                   );  
//                 } else {  
//                   await userProvider.addBill(  
//                     widget.studentId,  
//                     amount,  
//                     status,  
//                     dueDate!, // Menggunakan null assertion operator  
//                     paymentDate, // paymentDate bisa null  
//                   );  
//                 }  
//                 Navigator.of(context).pop();  
//                 _fetchBill(); // Memperbarui daftar tagihan  
//               }  
//             },  
//           ),  
//         ],  
//       );  
//     },  
//   );  
// }  

  
//   @override  
//   Widget build(BuildContext context) {  
//     final userProvider = Provider.of<UserProvider>(context);  
  
//     return Scaffold(  
//       appBar: AppBar(  
//         title: Text('Tagihan Siswa'),  
//       ),  
//       body: Column(  
//         children: [  
//           Expanded(  
//             child: ListView.builder(  
//               itemCount: _bills.length,  
//               itemBuilder: (context, index) {  
//                 final bill = _bills[index];  
//                 print('${bill} INII bill');
//                 return ListTile(  
//                   title: Text('Tagihan: ${bill['jumlah']}'),  
//                   subtitle: Text('Status: ${bill['status']}'),  
//                   trailing: Row(  
//                     mainAxisSize: MainAxisSize.min,  
//                     children: [  
//                       IconButton(  
//                         icon: Icon(Icons.edit),  
//                         onPressed: () {  
//                           _showAddEditBillDialog(bill: bill);  
//                         },  
//                       ),  
//                       IconButton(  
//                         icon: Icon(Icons.delete),  
//                         onPressed: () async {  
//                           await userProvider.deleteBill(widget.studentId, bill['id']);  
//                           _fetchBill();  
//                         },  
//                       ),  
//                     ],  
//                   ),  
//                 );  
//               },  
//             ),  
//           ),  
//           ElevatedButton(  
//             onPressed: () {  
//               _showAddEditBillDialog();  
//             },  
//             child: Text('Tambah Tagihan'),  
//           ),  
//         ],  
//       ),  
//     );  
//   }  
// }  



  
// class BillsPage extends StatefulWidget {  
//   final String studentId;  
//   final List<dynamic> bills;  
  
//   BillsPage({required this.studentId, List<dynamic>? bills})  
//       : bills = bills ?? [];  
  
//   @override  
//   State<BillsPage> createState() => _BillsPageState();  
// }  
  
// class _BillsPageState extends State<BillsPage> {  
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;  
//   DateTime selectedDate = DateTime.now();  
  
//   @override  
//   void initState() {  
//     super.initState();  
//     _fetchBills(widget.studentId);  
//   }  
  
//   Future<void> _fetchBills(String studentId) async {  
//     try {  
//       final snapshot = await _firestore  
//           .collection('users')  
//           .doc(studentId)  
//           .get();  
  
//       if (snapshot.exists) {  
//         final data = snapshot.data();  
//         if (data != null && data['bills'] != null) {  
//           setState(() {  
//             widget.bills.clear();  
//             widget.bills.addAll(data['bills']);  
//           });  
//         }  
//       }  
//     } catch (e) {  
//       print('Error fetching bills: $e');  
//     }  
//   }  
  
//   Future<void> _selectDate(BuildContext context) async {  
//     final DateTime? picked = await showDatePicker(  
//       context: context,  
//       initialDate: selectedDate,  
//       firstDate: DateTime(2000),  
//       lastDate: DateTime(2101),  
//     );  
//     if (picked != null && picked != selectedDate) {  
//       setState(() {  
//         selectedDate = picked;  
//       });  
//     }  
//   }  
  
//   void _addBill() async {  
//     final amountController = TextEditingController();  
//     selectedDate = DateTime.now(); // Reset to current date  
  
//     await showDialog(  
//       context: context,  
//       builder: (context) {  
//         return AlertDialog(  
//           title: Text('Tambah Tagihan'),  
//           content: Column(  
//             mainAxisSize: MainAxisSize.min,  
//             children: [  
//               TextField(  
//                 controller: amountController,  
//                 decoration: InputDecoration(labelText: 'Jumlah'),  
//                 keyboardType: TextInputType.number,  
//               ),  
//               SizedBox(height: 10),  
//               Text("Tanggal: ${DateFormat('dd-MM-yyyy').format(selectedDate)}"),  
//               TextButton(  
//                 onPressed: () => _selectDate(context),  
//                 child: Text('Pilih Tanggal'),  
//               ),  
//             ],  
//           ),  
//           actions: [  
//             TextButton(  
//               onPressed: () {  
//                 Navigator.of(context).pop();  
//               },  
//               child: Text('Batal'),  
//             ),  
//             TextButton(  
//               onPressed: () async {  
//                 final amount = int.tryParse(amountController.text);  
//                 if (amount != null) {  
//                   await _firestore.collection('users').doc(widget.studentId).update({  
//                     'bills': FieldValue.arrayUnion([  
//                       {'amount': amount, 'date': selectedDate}  
//                     ])  
//                   });  
//                   await _fetchBills(widget.studentId);  
//                   Navigator.of(context).pop();  
//                 } else {  
//                   ScaffoldMessenger.of(context).showSnackBar(  
//                     SnackBar(  
//                       content: Text('Masukkan jumlah yang valid'),  
//                       backgroundColor: Colors.red,  
//                     ),  
//                   );  
//                 }  
//               },  
//               child: Text('Tambah'),  
//             ),  
//           ],  
//         );  
//       },  
//     );  
//   }  
  
//   void _editBill(int index) async {  
//     final amountController = TextEditingController(  
//         text: widget.bills[index]['amount'].toString());  
//     selectedDate = widget.bills[index]['date'];  
  
//     await showDialog(  
//       context: context,  
//       builder: (context) {  
//         return AlertDialog(  
//           title: Text('Edit Tagihan'),  
//           content: Column(  
//             mainAxisSize: MainAxisSize.min,  
//             children: [  
//               TextField(  
//                 controller: amountController,  
//                 decoration: InputDecoration(labelText: 'Jumlah'),  
//                 keyboardType: TextInputType.number,  
//               ),  
//               SizedBox(height: 10),  
//               Text("Tanggal: ${DateFormat('dd-MM-yyyy').format(selectedDate)}"),  
//               TextButton(  
//                 onPressed: () => _selectDate(context),  
//                 child: Text('Pilih Tanggal'),  
//               ),  
//             ],  
//           ),  
//           actions: [  
//             TextButton(  
//               onPressed: () {  
//                 Navigator.of(context).pop();  
//               },  
//               child: Text('Batal'),  
//             ),  
//             TextButton(  
//               onPressed: () async {  
//                 final amount = int.tryParse(amountController.text);  
//                 if (amount != null) {  
//                   widget.bills[index]['amount'] = amount;  
//                   widget.bills[index]['date'] = selectedDate;  
  
//                   await _firestore.collection('users').doc(widget.studentId).update({  
//                     'bills': widget.bills,  
//                   });  
//                   await _fetchBills(widget.studentId);  
//                   Navigator.of(context).pop();  
//                 } else {  
//                   ScaffoldMessenger.of(context).showSnackBar(  
//                     SnackBar(  
//                       content: Text('Masukkan jumlah yang valid'),  
//                       backgroundColor: Colors.red,  
//                     ),  
//                   );  
//                 }  
//               },  
//               child: Text('Simpan'),  
//             ),  
//           ],  
//         );  
//       },  
//     );  
//   }  
  
//   void _deleteBill(int index) async {  
//     final confirmDelete = await showDialog<bool>(  
//       context: context,  
//       builder: (context) {  
//         return AlertDialog(  
//           title: Text('Konfirmasi Hapus'),  
//           content: Text('Apakah Anda yakin ingin menghapus tagihan ini?'),  
//           actions: [  
//             TextButton(  
//               onPressed: () => Navigator.of(context).pop(false),  
//               child: Text('Batal'),  
//             ),  
//             TextButton(  
//               onPressed: () => Navigator.of(context).pop(true),  
//               child: Text('Hapus'),  
//             ),  
//           ],  
//         );  
//       },  
//     );  
  
//     if (confirmDelete == true) {  
//       widget.bills.removeAt(index);  
//       await _firestore.collection('users').doc(widget.studentId).update({  
//         'bills': widget.bills,  
//       });  
//       await _fetchBills(widget.studentId);  
//     }  
//   }  
  
//   @override  
//   Widget build(BuildContext context) {  
//     return Scaffold(  
//       appBar: AppBar(  
//         title: Text('Tagihan Siswa'),  
//       ),  
//       body: ListView.builder(  
//         itemCount: widget.bills.length,  
//         itemBuilder: (context, index) {  
//           final bill = widget.bills[index];  
//           return ListTile(  
//             title: Text('Jumlah: ${bill['amount']}'),  
//             subtitle: Text('Tanggal: ${DateFormat('dd-MM-yyyy').format(bill['date'].toDate())}'),  
//             trailing: Row(  
//               mainAxisSize: MainAxisSize.min,  
//               children: [  
//                 IconButton(  
//                   icon: Icon(Icons.edit),  
//                   onPressed: () => _editBill(index),  
//                 ),  
//                 IconButton(  
//                   icon: Icon(Icons.delete),  
//                   onPressed: () => _deleteBill(index),  
//                 ),  
//               ],  
//             ),  
//           );  
//         },  
//       ),  
//       floatingActionButton: FloatingActionButton(  
//         onPressed: _addBill,  
//         child: Icon(Icons.add),  
//         tooltip: 'Tambah Tagihan',  
//       ),  
//     );  
//   }  
// }  



  


  
class BillsPage extends StatefulWidget {  
  final String studentId;  
  List<Map<String, dynamic>> bills;  
  
  BillsPage({required this.studentId, List<Map<String, dynamic>>? bills})  
      : bills = bills ?? [];  
  
  @override  
  State<BillsPage> createState() => _BillsPageState();  
}  
  
class _BillsPageState extends State<BillsPage> {  
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;  
  DateTime selectedDueDate = DateTime.now(); // Default to current date  
  DateTime? selectedPaymentDate;  
  
  @override  
  void initState() {  
    super.initState();  
    _fetchBills(widget.studentId);  
  }  
  
  Future<void> _fetchBills(String studentId) async {  
    try {  
      final snapshot = await _firestore.collection('users').doc(studentId).get();  
  
      if (snapshot.exists) {  
        final data = snapshot.data();  
        if (data != null && data['bills'] != null) {  
          setState(() {  
            widget.bills.clear();  
            widget.bills.addAll(List<Map<String, dynamic>>.from(data['bills']));  
          });  
        } else {  
          setState(() {  
            widget.bills = [];  
          });  
        }  
      }  
    } catch (e) {  
      print('Error fetching bills: $e');  
    }  
  }  
  
  Future<void> _selectDate(BuildContext context, DateTime? initialDate, Function(DateTime?) onDateSelected) async {  
    final DateTime? picked = await showDatePicker(  
      context: context,  
      initialDate: initialDate ?? DateTime.now(),  
      firstDate: DateTime(2000),  
      lastDate: DateTime(2101),  
    );  
    if (picked != null && picked != initialDate) {  
      onDateSelected(picked);  
    }  
  }  
  
  void _addBill() async {  
    final amountController = TextEditingController();  
    selectedDueDate = DateTime.now(); // Reset to current date  
    selectedPaymentDate = null;  
  
    await showDialog(  
      context: context,  
      builder: (context) {  
        return AlertDialog(  
          title: Text('Tambah Tagihan'),  
          content: Column(  
            mainAxisSize: MainAxisSize.min,  
            children: [  
              TextField(  
                controller: amountController,  
                decoration: InputDecoration(labelText: 'Jumlah'),  
                keyboardType: TextInputType.number,  
              ),  
              SizedBox(height: 10),  
              Text("Tanggal Jatuh Tempo: ${DateFormat('dd-MM-yyyy').format(selectedDueDate)}"),  
              TextButton(  
                onPressed: () => _selectDate(context, selectedDueDate, (date) => setState(() => selectedDueDate = date!)),  
                child: Text('Pilih Tanggal Jatuh Tempo'),  
              ),  
              SizedBox(height: 10),  
              Text("Tanggal Pembayaran: ${selectedPaymentDate != null ? DateFormat('dd-MM-yyyy').format(selectedPaymentDate!) : 'Belum dibayar'}"),  
              TextButton(  
                onPressed: () => _selectDate(context, selectedPaymentDate, (date) => setState(() => selectedPaymentDate = date)),  
                child: Text('Pilih Tanggal Pembayaran'),  
              ),  
            ],  
          ),  
          actions: [  
            TextButton(  
              onPressed: () {  
                Navigator.of(context).pop();  
              },  
              child: Text('Batal'),  
            ),  
            TextButton(  
              onPressed: () async {  
                final amount = int.tryParse(amountController.text);  
                if (amount != null) {  
                  final status = selectedPaymentDate != null ? 'paid' : 'unpaid';  
                  await _firestore.collection('users').doc(widget.studentId).update({  
                    'bills': FieldValue.arrayUnion([  
                      {  
                        'amount': amount,  
                        'dueDate': selectedDueDate,  
                        'paymentDate': selectedPaymentDate,  
                        'status': status  
                      }  
                    ])  
                  });  
                  await _fetchBills(widget.studentId);  
                  Navigator.of(context).pop();  
                } else {  
                  ScaffoldMessenger.of(context).showSnackBar(  
                    SnackBar(  
                      content: Text('Masukkan jumlah yang valid'),  
                      backgroundColor: Colors.red,  
                    ),  
                  );  
                }  
              },  
              child: Text('Tambah'),  
            ),  
          ],  
        );  
      },  
    );  
  }  
  
  void _editBill(int index) async {  
    final amountController = TextEditingController(text: widget.bills[index]['amount'].toString());  
    selectedDueDate = widget.bills[index]['dueDate'].toDate();  
    selectedPaymentDate = widget.bills[index]['paymentDate']?.toDate();  
  
    await showDialog(  
      context: context,  
      builder: (context) {  
        return AlertDialog(  
          title: Text('Edit Tagihan'),  
          content: Column(  
            mainAxisSize: MainAxisSize.min,  
            children: [  
              TextField(  
                controller: amountController,  
                decoration: InputDecoration(labelText: 'Jumlah'),  
                keyboardType: TextInputType.number,  
              ),  
              SizedBox(height: 10),  
              Text("Tanggal Jatuh Tempo: ${DateFormat('dd-MM-yyyy').format(selectedDueDate)}"),  
              TextButton(  
                onPressed: () => _selectDate(context, selectedDueDate, (date) => setState(() => selectedDueDate = date!)),  
                child: Text('Pilih Tanggal Jatuh Tempo'),  
              ),  
              SizedBox(height: 10),  
              Text("Tanggal Pembayaran: ${selectedPaymentDate != null ? DateFormat('dd-MM-yyyy').format(selectedPaymentDate!) : 'Belum dibayar'}"),  
              TextButton(  
                onPressed: () => _selectDate(context, selectedPaymentDate, (date) => setState(() => selectedPaymentDate = date)),  
                child: Text('Pilih Tanggal Pembayaran'),  
              ),  
            ],  
          ),  
          actions: [  
            TextButton(  
              onPressed: () {  
                Navigator.of(context).pop();  
              },  
              child: Text('Batal'),  
            ),  
            TextButton(  
              onPressed: () async {  
                final amount = int.tryParse(amountController.text);  
                if (amount != null) {  
                  final status = selectedPaymentDate != null ? 'paid' : 'unpaid';  
                  widget.bills[index]['amount'] = amount;  
                  widget.bills[index]['dueDate'] = selectedDueDate;  
                  widget.bills[index]['paymentDate'] = selectedPaymentDate;  
                  widget.bills[index]['status'] = status;  
  
                  await _firestore.collection('users').doc(widget.studentId).update({  
                    'bills': widget.bills,  
                  });  
                  await _fetchBills(widget.studentId);  
                  Navigator.of(context).pop();  
                } else {  
                  ScaffoldMessenger.of(context).showSnackBar(  
                    SnackBar(  
                      content: Text('Masukkan jumlah yang valid'),  
                      backgroundColor: Colors.red,  
                    ),  
                  );  
                }  
              },  
              child: Text('Simpan'),  
            ),  
          ],  
        );  
      },  
    );  
  }  
  
  void _deleteBill(int index) async {  
    final confirmDelete = await showDialog<bool>(  
      context: context,  
      builder: (context) {  
        return AlertDialog(  
          title: Text('Konfirmasi Hapus'),  
          content: Text('Apakah Anda yakin ingin menghapus tagihan ini?'),  
          actions: [  
            TextButton(  
              onPressed: () => Navigator.of(context).pop(false),  
              child: Text('Batal'),  
            ),  
            TextButton(  
              onPressed: () => Navigator.of(context).pop(true),  
              child: Text('Hapus'),  
            ),  
          ],  
        );  
      },  
    );  
  
    if (confirmDelete == true) {  
      widget.bills.removeAt(index);  
      await _firestore.collection('users').doc(widget.studentId).update({  
        'bills': widget.bills,  
      });  
      await _fetchBills(widget.studentId);  
    }  
  }  
  
  @override  
  Widget build(BuildContext context) {  
    final userProvider = Provider.of<UserProvider>(context);  
  
    return Scaffold(  backgroundColor: whiteColor,
      appBar: AppBar(  
        foregroundColor: Colors.white,  
        title: Text('Tagihan Siswa', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),  
        backgroundColor: Colors.blue, // Styling: Change app bar color  
      ),  
      body: Padding(  
        padding: const EdgeInsets.all(5.0), // Styling: Add padding to body  
        child: Column(  
          children: [  
            Expanded(  
              child: ListView.builder(  
                itemCount: widget.bills.length,  
                itemBuilder: (context, index) {  
                  final bill = widget.bills[index];  
                  return Container(  decoration: BoxDecoration(
                            color: Colors.grey[100], // Warna putih abu-abu
                            borderRadius: BorderRadius.circular(
                                8), // Opsional: untuk memberi sudut melengkung
                          ),
                          margin: const EdgeInsets.symmetric(
                              vertical: 5,
                              horizontal:
                                  5), 
                   // Styling: Add elevation to cards  
                    child: ListTile(  
                      title: Column(  
                        crossAxisAlignment: CrossAxisAlignment.start,  
                        children: [  
                          Text(  
                            ' ${userProvider.formatRupiah(bill['amount'].toString())}',  
                            style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold), // Styling: Add style to text  
                          ),  
                          Text(  
                            'Jatuh Tempo: ${DateFormat('EEEE, dd-MM-yyyy', 'id_ID').format(bill['dueDate'].toDate())}',  
                            style: regularTextStyle.copyWith(color: blackcolor,fontSize: 12), // Styling: Add style to text  
                          ),  
                          Text(  
                            'Pembayaran: ${bill['paymentDate'] != null ? DateFormat('EEEE, dd-MM-yyyy', 'id_ID').format(bill['paymentDate'].toDate()) : 'Belum dibayar'}',  
                            style: regularTextStyle.copyWith(color: blackcolor,fontSize: 12), // Styling: Add style to text  
                          ),  
                          Text(  
                            'Status: ${bill['status']}',  
                            style: regularTextStyle.copyWith(color: blackcolor,fontSize: 12), // Styling: Add style to text  
                          ),  
                        ],  
                      ),  
                      trailing: Row(  
                        mainAxisSize: MainAxisSize.min,  
                        children: [  
                          IconButton(  
                            icon: Icon(Icons.edit,color: Colors.red,),  
                            onPressed: () => _editBill(index),  
                          ),  
                          IconButton(  
                            icon: Icon(Icons.delete,color: blueColor,),  
                            onPressed: () => _deleteBill(index),  
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
      floatingActionButton: FloatingActionButton(  
        onPressed: _addBill,  
        child: Icon(Icons.add, color: Colors.white),  
        backgroundColor: Colors.blue, // Styling: Change FAB color  
      ),  
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat, // Styling: Position FAB at bottom right  
    );  
  }  
}  
   


   
  
class SavingsPage extends StatefulWidget {  
  final String studentId;  
  final Map<String, dynamic> savings;  
  
  SavingsPage({required this.studentId, Map<String, dynamic>? savings})  
      : savings = savings ?? {};  
  
  @override  
  State<SavingsPage> createState() => _SavingsPageState();  
}  
  
class _SavingsPageState extends State<SavingsPage> {  
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;  
  Map<String, dynamic> savings = {  
    'history': [],  
  };  
  
  DateTime selectedDate = DateTime.now(); // Default to current date  
  
  @override  
  void initState() {  
    super.initState();  
    _fetchSavings(widget.studentId);  
  }  
  
  Future<void> _fetchSavings(String studentId) async {  
    try {  
      final snapshot = await _firestore  
          .collection('users')  
          .doc(studentId)  
          .get();  
  
      if (snapshot.exists) {  
        final data = snapshot.data();  
        if (data != null && data['savings'] != null) {  
          setState(() {  
            savings = data['savings'];  
          });  
        } else {  
          setState(() {  
            savings = {  
              'history': [],  
            };  
          });  
        }  
      }  
    } catch (e) {  
      print('Error fetching savings: $e');  
    }  
  }  
  
  Future<void> _selectDate(BuildContext context) async {  
    final DateTime? picked = await showDatePicker(  
      context: context,  
      initialDate: selectedDate,  
      firstDate: DateTime(2000),  
      lastDate: DateTime(2101),  
    );  
    if (picked != null && picked != selectedDate) {  
      setState(() {  
        selectedDate = picked;  
      });  
    }  
  }  
  
  @override  
  Widget build(BuildContext context) {  
    final userProvider = Provider.of<UserProvider>(context);  
  
    return Scaffold( backgroundColor: whiteColor, 
      appBar: AppBar(  foregroundColor: whiteColor,
        title: Text('Tabungan Siswa',style: boldTextStyle.copyWith(color: whiteColor,fontSize: 22,)),  
        backgroundColor: Colors.blue, // Styling: Change app bar color  
      ),  
      body: Padding(  
        padding: const EdgeInsets.all(16.0), // Styling: Add padding to body  
        child: Column(  
          children: [  
            Expanded(  
              child: ListView.builder(  
                itemCount: savings['history'].length,  
                itemBuilder: (context, index) {  
                  final saving = savings['history'][index];  
                  return Container(  
                   decoration: BoxDecoration(
                            color: Colors.grey[100], // Warna putih abu-abu
                            borderRadius: BorderRadius.circular(
                                8), // Opsional: untuk memberi sudut melengkung
                          ),
                          margin: const EdgeInsets.symmetric(
                              vertical: 5,
                              horizontal:
                                  5),  
                    child: ListTile(  
                      title: Column(  
                        crossAxisAlignment: CrossAxisAlignment.start,  
                        children: [  
                          Text(  
                            ' ${userProvider.formatRupiah(saving['amount'].toString())}',  
                            style: boldTextStyle.copyWith(color: blackcolor,fontSize: 16), // Styling: Add style to text  
                          ),  
                          Text(  
                            '${DateFormat('EEEE, dd-MM-yyyy', 'id_ID').format(saving['date'].toDate())}',  
                            style: regularTextStyle.copyWith(color: blackcolor,fontSize: 12), // Styling: Add style to text  
                          ),  
                        ],  
                      ),  
                      trailing: Row(  
                        mainAxisSize: MainAxisSize.min,  
                        children: [  
                          IconButton(  
                            icon: Icon(Icons.edit,color: blueColor,),  
                            onPressed: () async {  
                              // Show dialog to edit the amount and date  
                              final amountController = TextEditingController(  
                                  text: saving['amount'].toString());  
                              selectedDate = saving['date'].toDate(); // Set the selected date  
  
                              final newAmount = await showDialog<int>(  
                                context: context,  
                                builder: (context) {  
                                  return AlertDialog(  
                                    title: Text('Edit Tabungan'),  
                                    content: Column(  
                                      mainAxisSize: MainAxisSize.min,  
                                      children: [  
                                        TextField(  
                                          controller: amountController,  
                                          decoration:  
                                              InputDecoration(labelText: 'Jumlah'),  
                                          keyboardType: TextInputType.number,  
                                        ),  
                                        SizedBox(height: 10),  
                                        Text(  
                                          "Tanggal: ${DateFormat('dd-MM-yyyy').format(selectedDate)}",  
                                        ),  
                                        TextButton(  
                                          onPressed: () => _selectDate(context),  
                                          child: Text('Pilih Tanggal'),  
                                        ),  
                                      ],  
                                    ),  
                                    actions: [  
                                      TextButton(  
                                        onPressed: () {  
                                          Navigator.of(context).pop();  
                                        },  
                                        child: Text('Batal'),  
                                      ),  
                                      TextButton(  
                                        onPressed: () {  
                                          final amount =  
                                              int.tryParse(amountController.text);  
                                          if (amount != null) {  
                                            Navigator.of(context).pop(amount);  
                                          } else {  
                                            ScaffoldMessenger.of(context)  
                                                .showSnackBar(  
                                              SnackBar(  
                                                content: Text(  
                                                    'Masukkan jumlah yang valid'),  
                                                backgroundColor: Colors.red,  
                                              ),  
                                            );  
                                          }  
                                        },  
                                        child: Text('Simpan'),  
                                      ),  
                                    ],  
                                  );  
                                },  
                              );  
  
                              if (newAmount != null) {  
                                // Update the amount and date in Firestore  
                                try {  
                                  await userProvider.editSaving(  
                                      widget.studentId, index, newAmount, selectedDate);  
                                  ScaffoldMessenger.of(context).showSnackBar(  
                                    SnackBar(  
                                      content: Text('Tabungan berhasil diperbarui'),  
                                      backgroundColor: Colors.green,  
                                    ),  
                                  );  
                                  // Refresh the savings data  
                                  await _fetchSavings(widget.studentId);  
                                } catch (e) {  
                                  print("Error: ${e}");  
                                  ScaffoldMessenger.of(context).showSnackBar(  
                                    SnackBar(  
                                      content: Text('Gagal memperbarui tabungan'),  
                                      backgroundColor: Colors.red,  
                                    ),  
                                  );  
                                }  
                              }  
                            },  
                          ),  
                          IconButton(  
                            icon: Icon(Icons.delete,color: Colors.red,),  
                            onPressed: () async {  
                              final confirmDelete = await showDialog<bool>(  
                                context: context,  
                                builder: (context) {  
                                  return AlertDialog(  
                                    title: Text('Konfirmasi Hapus'),  
                                    content: Text(  
                                        'Apakah Anda yakin ingin menghapus tabungan ini?'),  
                                    actions: [  
                                      TextButton(  
                                        onPressed: () =>  
                                            Navigator.of(context).pop(false),  
                                        child: Text('Batal'),  
                                      ),  
                                      TextButton(  
                                        onPressed: () =>  
                                            Navigator.of(context).pop(true),  
                                        child: Text('Hapus'),  
                                      ),  
                                    ],  
                                  );  
                                },  
                              );  
  
                              if (confirmDelete == true) {  
                                try {  
                                  await userProvider.deleteSaving(  
                                      widget.studentId, index);  
                                  ScaffoldMessenger.of(context).showSnackBar(  
                                    SnackBar(  
                                      content: Text('Tabungan berhasil dihapus'),  
                                      backgroundColor: Colors.green,  
                                    ),  
                                  );  
                                  await _fetchSavings(widget.studentId);  
                                } catch (e) {  
                                  print("Error: ${e}");  
                                  ScaffoldMessenger.of(context).showSnackBar(  
                                    SnackBar(  
                                      content: Text('Gagal menghapus tabungan'),  
                                      backgroundColor: Colors.red,  
                                    ),  
                                  );  
                                }  
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
      floatingActionButton: FloatingActionButton(  
        onPressed: () async {  
          final amountController = TextEditingController();  
          selectedDate = DateTime.now(); // Reset to current date  
  
          await showDialog(  
            context: context,  
            builder: (context) {  
              return AlertDialog(  
                title: Text('Tambah Tabungan'),  
                content: Column(  
                  mainAxisSize: MainAxisSize.min,  
                  children: [  
                    TextField(  
                      controller: amountController,  
                      decoration: InputDecoration(labelText: 'Jumlah'),  
                      keyboardType: TextInputType.number,  
                    ),  
                    SizedBox(height: 10),  
                    Text(  
                      "Tanggal: ${DateFormat('dd-MM-yyyy').format(selectedDate)}",  
                    ),  
                    TextButton(  
                      onPressed: () => _selectDate(context),  
                      child: Text('Pilih Tanggal'),  
                    ),  
                  ],  
                ),  
                actions: [  
                  TextButton(  
                    onPressed: () {  
                      Navigator.of(context).pop();  
                    },  
                    child: Text('Batal'),  
                  ),  
                  TextButton(  
                    onPressed: () async {  
                      final amount =  
                          int.tryParse(amountController.text);  
                      if (amount != null) {  
                        await userProvider.addSaving(  
                            widget.studentId, amount, selectedDate);  
                        await _fetchSavings(widget.studentId);  
                        Navigator.of(context).pop();  
                      } else {  
                        ScaffoldMessenger.of(context).showSnackBar(  
                          SnackBar(  
                            content: Text('Masukkan jumlah yang valid'),  
                            backgroundColor: Colors.red,  
                          ),  
                        );  
                      }  
                    },  
                    child: Text('Tambah'),  
                  ),  
                ],  
              );  
            },  
          );  
        },  
        child: Icon(Icons.add,color: whiteColor,),  
        backgroundColor: Colors.blue, // Styling: Change FAB color  
      ),  
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat, // Styling: Position FAB at bottom right  
    );  
  }  
}  
  



