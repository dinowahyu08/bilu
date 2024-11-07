import 'dart:convert';
import 'package:bilu2/theme.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class KeuanganScreen extends StatefulWidget {
  final String username;

  KeuanganScreen({required this.username});

  @override
  State<KeuanganScreen> createState() => _KeuanganScreenState();
}

class _KeuanganScreenState extends State<KeuanganScreen> {
  Map<String, dynamic>? user;
  List<Map<String, dynamic>> savingsList = [];
  List<Map<String, dynamic>> billList = [];
  DateTime? selectedDate;

  @override
  void initState() {
    super.initState();
    _loadUserFromServer();
  }

  Future<void> _loadUserFromServer() async {
    try {
      final response = await http.get(Uri.parse(
          'http://10.0.2.2:8000/users.json'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        user = data['users'].firstWhere(
          (user) => user['username'] == widget.username,
          orElse: () => null,
        );

        // Load savings and bills
        if (user != null) {
          savingsList =
              user!['savings']['history'].cast<Map<String, dynamic>>();
          billList = user!['bill'].cast<Map<String, dynamic>>();
        }

        setState(() {});
      } else {
        print('Failed to load user data from server: ${response.statusCode}');
      }
    } catch (e) {
      print('Error loading user data: $e');
    }
  }

  String formatRupiah(String amount) {
    final numberFormat = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );
    return numberFormat.format(int.parse(amount));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: whiteColor,
      appBar: AppBar(foregroundColor: whiteColor,
        backgroundColor: blueColor,
        title: Text(
          'Keuangan',
          style: semiBoldTextStyle.copyWith(color: whiteColor, fontSize: 18),
        ),
      ),
      body: user == null
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Text(
                    'Tabungan',
                    style: boldTextStyle.copyWith(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: savingsList.length,
                    itemBuilder: (context, index) {
                      final savings = savingsList[index];
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(15,5,15,5),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white, // Background color
                            borderRadius:
                                BorderRadius.circular(10), // Rounded corners
                            boxShadow: [
                              BoxShadow(
                                color:
                                    Colors.black.withOpacity(0.2), // Shadow color
                                spreadRadius: 2, // Spread radius
                                blurRadius: 3, // Blur radius
                                offset: Offset(0, 2), // Shadow position
                              ),
                            ],
                          ),
                          child: ListTile(
                            title: Text('${savings['date']}',style: semiBoldTextStyle.copyWith(color: blackcolor,fontSize: 12),),
                            subtitle: Text(
                                ' ${formatRupiah(savings['amount'])}',style:boldTextStyle.copyWith(color: blackcolor,fontSize: 18) ,),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 20),
                Text(
                    'Tagihan',
                    style: boldTextStyle.copyWith(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                
                Expanded(
                  child: ListView.builder(
                    itemCount: billList.length,
                    itemBuilder: (context, index) {
                      final bill = billList[index];
                      return Padding(
                         padding: const EdgeInsets.fromLTRB(15,5,15,5),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white, // Background color
                              borderRadius:
                                  BorderRadius.circular(10), // Rounded corners
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      Colors.black.withOpacity(0.2), // Shadow color
                                  spreadRadius: 2, // Spread radius
                                  blurRadius: 3, // Blur radius
                                  offset: Offset(0, 2), // Shadow position
                                ),
                              ],
                            ),
                          child: ListTile(
                            title: Text(' ${bill['dueDate']} | ${bill['status']}',style: semiBoldTextStyle.copyWith(color: blackcolor,fontSize: 12),),
                            subtitle:
                                Text('${formatRupiah(bill['jumlah'])}',style:boldTextStyle.copyWith(color: blackcolor,fontSize: 18) ),
                                
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
