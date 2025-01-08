  import 'package:bilu2/theme.dart';
  import 'package:flutter/material.dart';

  class BillStatusWidget extends StatelessWidget {
    final List<dynamic> bills; // The list of bills from user data

    BillStatusWidget({required this.bills});

    @override
    Widget build(BuildContext context) {
      print(bills);

      // Check if any bill has "Belum Lunas" status
      bool hasUnpaidBill = bills.any((bill) => bill['status'] == 'Belum Lunas');
      return Container(height: 55,alignment: Alignment.center,
        decoration: BoxDecoration(
          color: hasUnpaidBill
              ? Colors.red
              : Colors.green, // Red for unpaid, green otherwise
          borderRadius: BorderRadius.circular(10), // Rounded corners
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(
            hasUnpaidBill
                ? 'Ada Tagihan Yang Belum Lunas !'
                : 'Tidak Ada Tagihan Yang Menunggak',
            style: semiBoldTextStyle.copyWith(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ),
      );
    }
  }
