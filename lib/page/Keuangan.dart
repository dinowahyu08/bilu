import 'package:bilu2/provider/userProvider.dart';
import 'package:bilu2/theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class KeuanganScreen extends StatelessWidget {
  // Function to format date
  String formatDate(DateTime date) {
    return DateFormat('dd-MM-yyyy HH:mm').format(date); // Change format as needed
  }

  // Function to format currency
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
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        foregroundColor: whiteColor,
        backgroundColor: Colors.blue,
        title: Text(
          'Keuangan',
          style: boldTextStyle.copyWith(color: whiteColor,fontSize: 22)
        ),
        centerTitle: true
      ),
      body: userProvider.username.isEmpty
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Text(
                    'Tabungan',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: userProvider.savings['history'].length,
                    itemBuilder: (context, index) {
                      final savings = userProvider.savings['history'][index];
                      DateTime savingsDate = savings['date'].toDate(); // Convert Firestore Timestamp to DateTime
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                spreadRadius: 2,
                                blurRadius: 3,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: ListTile(
                            title: Text(
                              formatDate(savingsDate), // Format date
                              style: TextStyle(color: Colors.black, fontSize: 12),
                            ),
                            subtitle: Text(
                              '${formatRupiah(savings["amount"].toString())}',
                              style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Tagihan',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: userProvider.bill.length,
                    itemBuilder: (context, index) {
                      final bill = userProvider.bill[index];
                      DateTime dueDate = bill['dueDate'].toDate(); // Convert Firestore Timestamp to DateTime
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                spreadRadius: 2,
                                blurRadius: 3,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: ListTile(
                            title: Text(
                              '${formatDate(dueDate)} | ${bill['status']}',
                              style: TextStyle(color: Colors.black, fontSize: 12),
                            ),
                            subtitle: Text(
                              '${formatRupiah(bill['jumlah'].toString())}',
                              style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
                            ),
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
