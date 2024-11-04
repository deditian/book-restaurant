import 'package:book_restorant/model/order.dart';
import 'package:book_restorant/ui/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/order_controller.dart';

class ConfirmOrderBottomSheet {
  static void show(
      BuildContext context,
      Order order, {
        required void Function() onOrderConfirmed,
      }) {
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

                    Util.showSnackbar(
                      context,
                      message: 'Nama pemesan harus diisi',
                      backgroundColor: Colors.red,
                    );

                  } else if (orderController.orderPick.isEmpty) {

                    Util.showSnackbar(
                      context,
                      message: 'Tidak ada pesanan yang dipilih.',
                      backgroundColor: Colors.red,
                    );

                  } else {
                    orderController.updateCustomerName(order.idTable, customerName);

                    orderController.clearMenus();

                    Util.showSnackbar(
                      context,
                      message: 'Pemesanan atas nama $customerName telah disimpan',
                      backgroundColor: Colors.green,
                    );

                    onOrderConfirmed();

                  }
                  Navigator.pop(context);
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
