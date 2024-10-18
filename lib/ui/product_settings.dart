import 'package:book_restorant/controller/sales_controller.dart';
import 'package:book_restorant/material/payment_bottomsheet.dart';
import 'package:book_restorant/model/sales.dart';
import 'package:book_restorant/ui/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/order_controller.dart';
import '../model/menu.dart';

class ProductSettings extends StatefulWidget {
  @override
  _ProductSettingsState createState() => _ProductSettingsState();
}

class _ProductSettingsState extends State<ProductSettings> {
  final OrderController orderController = Get.put(OrderController());
  final SalesController salesController = Get.put(SalesController());
  double totalPrice = 0;
  double totalPriceOrderPerDay = 0 ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Settings'),
      ),
      body: Obx(() {
        if (orderController.orderPick.isEmpty) {
          return Center(child: Text('No orders available.'));
        }
        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: orderController.orderPick.length,
                itemBuilder: (context, index) {
                  final order = orderController.orderPick[index];


                  return Card(
                    margin: EdgeInsets.all(8.0),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Order ID: ${order.id}'),
                          Text('Date: ${order.date}'),
                          Text('Table ID: ${order.idTable}'),
                          Text('Customer Name: ${order.customerName ?? 'N/A'}'),

                          // Expandable list for menu items
                          ExpansionTile(
                            title: Text('Menu Items (${order.idMenu.length})'),
                            children: order.idMenu.map((menu) {
                              int qty = menu.qty!;
                              double total = menu.price * qty;

                              totalPrice += total;

                              return ListTile(
                                title: Text(menu.name),
                                trailing: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text('Qty: $qty'),
                                    Text('Total: ${Util.formatRupiah(total)}', style: TextStyle(color: Colors.blue[900])),
                                  ],
                                ),
                                leading: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    menu.imageUrl,
                                    width: 70,
                                    height: 70,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                subtitle: Text('${Util.formatRupiah(menu.price)}'),
                              );
                            }).toList(),
                          ),

                          // Display total price for the order
                          SizedBox(height: 10),
                          Text('Total Price: ${Util.formatRupiah(totalPrice)}'),

                          SizedBox(height: 10),

                          if (order.paymentMethod != null)
                            Text(
                              'Sudah dibayar pakai ${order.paymentMethod}',
                              style: TextStyle(color: Colors.green, fontSize: 16),
                            )
                          else
                            ElevatedButton(
                              onPressed: () {
                                PaymentBottomSheet.show(context, (selectedMethod) {
                                  orderController.updatePaymentMethod(order.id, selectedMethod);
                                  setState(() {
                                  });
                                });
                              },
                              child: Text('Payment'),
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            if (orderController.orderPick.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      totalPriceOrderPerDay+= totalPrice;
                      var sales = Sales(
                          idSales: DateTime.now().millisecond,
                          dateSale: Util.currentDate(),
                          salesName: "Usop",
                          totalPriceOrderPerDay: totalPriceOrderPerDay,
                          orders: orderController.orderPick);
                      salesController.addSales(sales);
                      orderController.clearOrders();

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Success Complete All Orders'),
                          backgroundColor: Colors.green,
                        ),
                      );
                    });
                  },
                  child: Text('Complete All Orders'),
                ),
              ),
          ],
        );
      }),
    );
  }
}
