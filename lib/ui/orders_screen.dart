import 'package:book_restorant/ui/table_management.dart';
import 'package:book_restorant/ui/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/menus_controller.dart';

class OrderListScreen extends StatefulWidget {
  @override
  _OrderListScreenState createState() => _OrderListScreenState();
}

class _OrderListScreenState extends State<OrderListScreen> {
  final MenusController menusController = Get.put(MenusController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order List"),
        actions: [
          IconButton(
            icon: Icon(Icons.book_rounded),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TableManagement()),
              );
            },
          )
        ],
      ),
      body: Obx(() {
        if (menusController.menupick.isEmpty) {
          return Center(child: Text("No orders found"));
        } else {
          return ListView.builder(
            itemCount: menusController.menupick.length,
            itemBuilder: (context, index) {
              var order = menusController.menupick[index];
              return Card(
                elevation: 2,
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          order.imageUrl,
                          width: 70,
                          height: 70,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              order.name,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Price: ${Util.formatRupiah(order.price)}',
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          Row(
                            children: [
                              IconButton(
                                icon: Icon(Icons.remove),
                                onPressed: () {
                                  if (order.qty! > 1) {
                                    menusController.decrementOrderCount(index);
                                  }
                                },
                              ),
                              Text('${order.qty}'),
                              IconButton(
                                icon: Icon(Icons.add),
                                onPressed: () {
                                  menusController.incrementOrderCount(index);
                                },
                              ),
                            ],
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              menusController.removeOrder(index);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }
      }),
    );
  }
}
