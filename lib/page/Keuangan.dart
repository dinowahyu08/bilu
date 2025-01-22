import 'package:bilu2/Widget/billStatus.dart';
import 'package:bilu2/provider/userProvider.dart';
import 'package:bilu2/theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class KeuanganScreen extends StatefulWidget {
  @override
  State<KeuanganScreen> createState() => _KeuanganScreenState();
}

class _KeuanganScreenState extends State<KeuanganScreen> {
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
  void initState() {
    super.initState();
    // Load user data and announcements when the app first starts
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<UserProvider>(context, listen: false).loadUserData();
    });
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
                      return 
                        
                        
                          
                          Container(
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
                              title: Text(
                                formatDate(savingsDate), // Format date
                                style: TextStyle(color: Colors.black, fontSize: 12),
                              ),
                              subtitle: Text(
                                '${formatRupiah(savings["amount"].toString())}',
                                style: boldTextStyle.copyWith(color: blackcolor,fontSize: 18),
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
                itemCount: userProvider.bills.length,  
                itemBuilder: (context, index) {  
                  final bill = userProvider.bills[index];  
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
                      title: Column(  
                        crossAxisAlignment: CrossAxisAlignment.start,  
                        children: [  
                          Text(  
                            ' ${userProvider.formatRupiah(bill['amount'].toString())}',  
                            style: boldTextStyle.copyWith(color: blackcolor,fontSize: 18), // Styling: Add style to text  
                          ),  
                          Text(  
                            'Tanggal Jatuh Tempo: ${DateFormat('EEEE, dd-MM-yyyy', 'id_ID').format(bill['dueDate'].toDate())}',  
                            style: regularTextStyle.copyWith(color: blackcolor,fontSize: 12), // Styling: Add style to text  
                          ),  
                          Text(  
                            'Tanggal Pembayaran: ${bill['paymentDate'] != null ? DateFormat('EEEE, dd-MM-yyyy', 'id_ID').format(bill['paymentDate'].toDate()) : 'Belum dibayar'}',  
                           style: regularTextStyle.copyWith(color: blackcolor,fontSize: 12), //ling: Add style to text  
                          ),  
                          Text(  
                            'Status: ${bill['status']}',  
                            style: regularTextStyle.copyWith(color: blackcolor,fontSize: 12), //// Styling: Add style to text  
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
