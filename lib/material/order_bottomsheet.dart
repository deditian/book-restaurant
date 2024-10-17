import 'package:book_restorant/model/order.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../controller/order_controller.dart';

class ConfirmOrderBottomSheet {
  static void show(BuildContext context, Order order) {
    TextEditingController nameController = TextEditingController();
    final OrderController orderController = Get.find<OrderController>();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Konfirmasi Pemesanan",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),

              // Input Nama Pemesan
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: "Nama Pemesan",
                  border: OutlineInputBorder(),
                ),
              ),

              SizedBox(height: 20),

              ElevatedButton(
                onPressed: () {
                  String customerName = nameController.text;

                  if (customerName.isEmpty) {

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Nama pemesan harus diisi'),
                        backgroundColor: Colors.red,
                      ),
                    );
                    Navigator.pop(context);

                  } else if (orderController.orderPick.isEmpty) {

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Tidak ada pesanan yang dipilih.'),
                        backgroundColor: Colors.red,
                      ),
                    );
                    Navigator.pop(context);

                  } else {


                      orderController.updateCustomerName(order.idTable, customerName);

                    orderController.clearMenus();

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Pemesanan atas nama $customerName telah disimpan'),
                        backgroundColor: Colors.green,
                      ),
                    );

                    Navigator.pop(context);
                  }
                },
                child: Text("Simpan Pemesanan"),
              ),
            ],
          ),
        );
      },
    );
  }


}
