import 'package:book_restorant/controller/menus_controller.dart';
import 'package:book_restorant/controller/order_controller.dart';
import 'package:book_restorant/model/order.dart';
import 'package:book_restorant/ui/utils.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/table_controller.dart';
import '../material/order_bottomsheet.dart';

class TableManagement extends StatefulWidget {
  @override
  _TableManagementState createState() => _TableManagementState();
}

class _TableManagementState extends State<TableManagement> {
  final TableController tableController = Get.put(TableController());
  final MenusController menusController = Get.put(MenusController());
  final OrderController orderController = Get.put(OrderController());

  Order order = Order(id: 0, date: "", idTable: 0, idMenu: []);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Table Management'),
        actions: [
          IconButton(
            icon: Icon(Icons.done_all),
            onPressed: () {
              ConfirmOrderBottomSheet.show(context, order);
            },
          )
        ],
      ),
      body: Obx(() {
        for (var order in orderController.orderPick) {
          debugPrint("Order data: ${order.toJson()}");

        }
        if (tableController.sections.isEmpty) {
          return Center(child: CircularProgressIndicator());
        } else {
          return ListView.builder(
            itemCount: tableController.sections.length,
            itemBuilder: (context, sectionIndex) {
              final section = tableController.sections[sectionIndex];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Section ${section.section}',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 5,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                        childAspectRatio: 1.0,
                      ),
                      itemCount: section.tables.length,
                      itemBuilder: (context, tableIndex) {

                        final table = section.tables[tableIndex];
                        bool isTableOccupied = orderController.orderPick
                            .any((order) => order.idTable == table.id);

                        int existingOrderIndex = orderController.orderPick
                            .indexWhere((order) => order.idTable == table.id);



                        return InkWell (
                          onTap: () {
                            setState(() {

                              if (existingOrderIndex != -1) {
                                orderController.removeOrder(existingOrderIndex);
                              } else {
                                var newOrder = Order(
                                  id: DateTime.now().millisecondsSinceEpoch,
                                  date: Util.formatDateTime(),
                                  idTable: table.id,
                                  idMenu: menusController.getPickedIds(),
                                  customerName: "picked of ....",
                                );
                                order = newOrder;
                                orderController.addOrder(newOrder);
                              }

                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: existingOrderIndex == -1 // Meja kosong
                                  ? Colors.green[300]
                                  : orderController.orderPick[existingOrderIndex].idMenu.isEmpty // Pesanan ada tapi tidak ada menu
                                  ? Colors.yellow[800]
                                  : Colors.red[300],
                              borderRadius: BorderRadius.circular(8),
                            ),

                            child: Center(
                              child: Text(
                                textAlign: TextAlign.center,
                                  isTableOccupied ?
                                  table.tableNumber+"\n"+orderController.orderPick[existingOrderIndex].customerName.toString()
                                :  table.tableNumber,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),

                          ),
                        );
                      },
                    ),
                    SizedBox(height: 20),




                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: 20,
                          height: 20,
                          color: Colors.green[300],
                        ),
                        SizedBox(width: 8),
                        Text('Tersedia'),
                        SizedBox(width: 16),
                        Container(
                          width: 20,
                          height: 20,
                          color: Colors.yellow[800],
                        ),
                        SizedBox(width: 8),
                        Text('Reserved'),
                        SizedBox(width: 16),
                        Container(
                          width: 20,
                          height: 20,
                          color: Colors.red[300],
                        ),
                        SizedBox(width: 8),
                        Text('Occupied'),
                      ],
                    ),

                  ],
                ),
              );
            },
          );
        }
      }),
    );
  }
}
