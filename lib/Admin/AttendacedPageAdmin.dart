import 'package:bilu2/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AttendancePageAdmin extends StatefulWidget {
  @override
  _AttendancePageAdminState createState() => _AttendancePageAdminState();
}

class _AttendancePageAdminState extends State<AttendancePageAdmin> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  DateTime _selectedDate = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
    8,
  );
  String? _selectedClass;
  Map<String, List<Map<String, dynamic>>> _studentsPerClass = {};
  Map<String, String> _attendanceStatus = {};
  bool _isMarkedAllPresent = false;

  @override
  void initState() {
    super.initState();
    _fetchAllStudents();
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

  Future<void> _fetchAttendance() async {
    if (_selectedClass == null) return;

    try {
      final snapshot = await _firestore
          .collection('users')
          .where('className', isEqualTo: _selectedClass)
          .get();

      final Map<String, String> fetchedAttendance = {};
      for (var doc in snapshot.docs) {
        final data = doc.data();
        final attendance = data['attendance'] as List<dynamic>?;
        if (attendance != null) {
          for (var record in attendance) {
            if ((record['date'] as Timestamp)
                .toDate()
                .isAtSameMomentAs(_selectedDate)) {
              fetchedAttendance[doc.id] = record['status'];
              break;
            }
          }
        }
      }

      setState(() {
        _attendanceStatus = fetchedAttendance;
      });
    } catch (e) {
      print('Error fetching attendance: $e');
    }
  }

  Future<void> _deleteAttendance() async {
    if (_selectedClass == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select a class')),
      );
      return;
    }

    try {
      // Iterasi melalui semua siswa di kelas yang dipilih
      for (var student in _studentsPerClass[_selectedClass] ?? []) {
        final userDoc = _firestore.collection('users').doc(student['id']);
        final snapshot = await userDoc.get();

        if (snapshot.exists) {
          final data = snapshot.data() as Map<String, dynamic>;
          final attendance = data['attendance'] as List<dynamic>? ?? [];

          // Hapus absensi pada tanggal yang dipilih
          attendance.removeWhere((record) => (record['date'] as Timestamp)
              .toDate()
              .isAtSameMomentAs(_selectedDate));

          // Perbarui data absensi di Firestore
          await userDoc.update({'attendance': attendance});
        }
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Absensi Berhasil Dihapus'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      print('Error deleting attendance: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to delete attendance'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _saveAttendance() async {
    if (_selectedClass == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select a class')),
      );
      return;
    }

    try {
      for (var entry in _attendanceStatus.entries) {
        final userDoc = _firestore.collection('users').doc(entry.key);
        final snapshot = await userDoc.get();

        if (snapshot.exists) {
          final data = snapshot.data() as Map<String, dynamic>;
          final attendance = data['attendance'] as List<dynamic>? ?? [];

          attendance.removeWhere((record) => (record['date'] as Timestamp)
              .toDate()
              .isAtSameMomentAs(_selectedDate));

          attendance.add({
            'date': Timestamp.fromDate(_selectedDate),
            'status': entry.value,
          });

          await userDoc.update({'attendance': attendance});
        }
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Absensi Berhasil Disimpan'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      print('Error saving attendance: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gagal Menyimpan Absensi'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _markAllPresent() {
    setState(() {
      if (_isMarkedAllPresent) {
        // Kosongkan semua data
        _attendanceStatus.clear();
        _isMarkedAllPresent = false;
      } else {
        // Tandai semua hadir
        _attendanceStatus.clear();
        for (var student in _studentsPerClass[_selectedClass] ?? []) {
          _attendanceStatus[student['id']] = 'Hadir';
        }
        _isMarkedAllPresent = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        foregroundColor: whiteColor,
        title: Text(
          'Management Absensi',
          style: boldTextStyle.copyWith(
            color: whiteColor,
            fontSize: 18,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: whiteColor,
// border: Border.all(color: Colors.grey.shade500),
                      borderRadius: BorderRadius.all(Radius.circular(12))),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                    child: DropdownButton<String>(
                      dropdownColor: Colors.white,
                      value: _selectedClass,
                      hint: Text(
                        'Pilih Kelas',
                        style: mediumTextStyle.copyWith(
                            color: blackcolor, fontSize: 14),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _selectedClass = value;
                          _attendanceStatus.clear();
                        });
                        _fetchAttendance();
                      },
                      items: _studentsPerClass.keys
                          .map((className) => DropdownMenuItem<String>(
                                value: className,
                                child: Text(
                                  className,
                                  style: semiBoldTextStyle.copyWith(
                                      color: blackcolor),
                                ),
                              ))
                          .toList(),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Container(
                  decoration: BoxDecoration(
                      color: blueColor,
                      borderRadius: BorderRadius.all(Radius.circular(12))),
                  child: TextButton(
                    onPressed: () async {
                      final pickedDate = await showDatePicker(
                        context: context,
                        initialDate: _selectedDate,
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );

                      if (pickedDate != null) {
                        setState(() {
                          _selectedDate = DateTime(
                            pickedDate.year,
                            pickedDate.month,
                            pickedDate.day,
                            8,
                          );
                        });
                        _fetchAttendance();
                      }
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.calendar_month_rounded,
                          size: 20,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          DateFormat('EEEE, dd-MM-yyyy', 'id_ID')
                              .format(_selectedDate),
                          style: semiBoldTextStyle.copyWith(
                              color: Colors.white, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextButton(
                  onPressed: _markAllPresent,
                  child: Container(
                    decoration: BoxDecoration(
                      color: _isMarkedAllPresent ? Colors.red : Colors.green,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                        padding: const EdgeInsets.all(7.0),
                        child: Row(
                          children: [
                            Text(
                              _isMarkedAllPresent
                                  ? 'Kosongkan Semua'
                                  : 'Semua Hadir',
                              style: TextStyle(
                                  color: _isMarkedAllPresent
                                      ? Colors.white
                                      : Colors.white,
                                  fontSize: 12),
                            ),
                            SizedBox(width: 5),
                            Icon(
                              _isMarkedAllPresent
                                  ? Icons.cancel
                                  : Icons.check_box,
                              color: _isMarkedAllPresent
                                  ? Colors.white
                                  : Colors.white,
                              size: 15,
                            ),
                          ],
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                        )),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Expanded(
              child: _selectedClass == null
                  ? Center(
                      child: Text('Please select a class to view students'))
                  : ListView.builder(
                      itemCount: _studentsPerClass[_selectedClass]?.length ?? 0,
                      itemBuilder: (context, index) {
                        final student =
                            _studentsPerClass[_selectedClass]![index];
                        final studentId = student['id'];
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[100], // Warna putih abu-abu
                            borderRadius: BorderRadius.circular(
                                8), // Opsional: untuk memberi sudut melengkung
                          ),
                          margin: const EdgeInsets.symmetric(
                              vertical: 4,
                              horizontal:
                                  8), // Opsional: untuk jarak antar tile
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundImage:
                                  NetworkImage(student['photoUrl'] ?? ''),
                            ),
                            title: Text(
                              student['name'] ?? '',
                              style: semiBoldTextStyle,
                            ),
                            subtitle: Text(student['className'] ?? ''),
                            trailing: DropdownButton<String>(
                              value: _attendanceStatus[studentId],
                              onChanged: (value) {
                                setState(() {
                                  _attendanceStatus[studentId] = value!;
                                });
                              },
                              items: [
                                DropdownMenuItem(
                                  value: 'Hadir',
                                  child: Text('Hadir'),
                                ),
                                DropdownMenuItem(
                                  value: 'Alpa',
                                  child: Text('Alpa'),
                                ),
                                DropdownMenuItem(
                                  value: 'Sakit',
                                  child: Text('Sakit'),
                                ),
                              ],
                              hint: Text('Status'),
                            ),
                          ),
                        );
                      },
                    ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width / 2 - 20,
                  decoration: BoxDecoration(
                      color: blueColor,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: TextButton(
                    onPressed: _saveAttendance,
                    child: Text('Simpan Absen',
                        style: semiBoldTextStyle.copyWith(
                            color: whiteColor, fontSize: 14)),
                  ),
                ),
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width / 2 - 20,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: TextButton(
                    onPressed: _deleteAttendance,
                    child: Text(
                      'Hapus Absen',
                      style: semiBoldTextStyle.copyWith(
                          color: whiteColor, fontSize: 14),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
