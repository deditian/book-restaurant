import 'package:flutter/material.dart';

class PaymentBottomSheet {
  static void show(BuildContext context, Function(String) onMethodSelected) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'Select Payment Method',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 20),

              // Cash Payment Option
              ListTile(
                leading: Icon(Icons.attach_money, color: Colors.green),
                title: Text('Cash'),
                onTap: () {
                  Navigator.pop(context);
                  onMethodSelected('Cash'); // Call the callback
                },
              ),
              Divider(),

              // Credit/Debit Payment Option
              ListTile(
                leading: Icon(Icons.credit_card, color: Colors.blue),
                title: Text('Credit/Debit'),
                onTap: () {
                  Navigator.pop(context);
                  onMethodSelected('Credit/Debit'); // Call the callback
                },
              ),
              Divider(),

              // QRIS Payment Option
              ListTile(
                leading: Icon(Icons.qr_code, color: Colors.orange),
                title: Text('QRIS'),
                onTap: () {
                  Navigator.pop(context);
                  onMethodSelected('QRIS'); // Call the callback
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
