import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/sales_controller.dart';
import '../ui/utils.dart';
import '../model/sales.dart';

class SalesReport extends StatefulWidget {
  @override
  _SalesReportState createState() => _SalesReportState();
}

class _SalesReportState extends State<SalesReport> {
  final SalesController salesController = Get.put(SalesController());



  @override
  void initState() {
    salesController.loadSales();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sales Report'),
      ),
      body: Obx(() {
        if (salesController.salesList.isEmpty) {
          return Center(child: Text('No sales data available.'));
        }
        for(var asd in salesController.salesList){
          debugPrint("sales woi  ${asd.toJson()}");
        }

        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: salesController.salesList.length,
                itemBuilder: (context, index) {
                  double totalnya= 0;
                  final Sales sales = salesController.salesList[index];

                  double totalOrderPrice = sales.orders.fold(
                    0,
                        (sum, order) => sum + order.idMenu.fold(
                      0,
                          (menuSum, menu) => menuSum + (menu.price * menu.qty!),
                    ),
                  );
                  totalnya += totalOrderPrice;
                  return Card(
                    margin: EdgeInsets.all(8.0),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Sales ID: ${sales.idSales}'),
                          Text('Date: ${sales.dateSale}'),
                          Text('Sales Name: ${sales.salesName ?? 'N/A'}'),
                          Text('Total Price: ${Util.formatRupiah(totalnya)}'),


                          ExpansionTile(
                            title: Text('Orders (${sales.orders.length})'),
                            children: sales.orders.map((order) {
                              double totalOrderPrice = order.idMenu.fold(
                                0, (sum, menu) => sum + (menu.price * menu.qty!),
                              );

                              return ListTile(
                                title: Text('Order ID: ${order.id}'),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Customer: ${order.customerName ?? 'N/A'}'),
                                    Text('Total Order Price: ${Util.formatRupiah(totalOrderPrice)}'),
                                  ],
                                ),
                                trailing: Text('Table: ${order.idTable}'),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            // Settlement Button
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Settlement completed!')),
                  );
                },
                child: Text('Settlement'),
              ),
            ),
          ],
        );
      }),
    );
  }
}
