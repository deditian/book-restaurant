import 'dart:math';

import 'package:book_restorant/controller/menus_controller.dart';
import 'package:book_restorant/controller/order_controller.dart';
import 'package:book_restorant/model/order.dart';
import 'package:book_restorant/ui/utils.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/table_controller.dart';

class TableManagement extends StatefulWidget {
  @override
  _TableManagementState createState() => _TableManagementState();
}

class _TableManagementState extends State<TableManagement> {
  final TableController tableController = Get.put(TableController());
  final MenusController menusController = Get.put(MenusController());
  final OrderController orderController = Get.put(OrderController());



  @override
  Widget build(BuildContext context) {

    // debugPrint("isinyaaa   ${orderController.getAllOrders()}");
    debugPrint("isinyaaaORDER   ${orderController.loadOrder()?.toJson()}");

    return Scaffold(
      appBar: AppBar(
        title: Text('Table Management'),
      ),
      body: Obx(() {
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
                        return InkWell (
                          onTap: () {
                            setState(() {
                              var order = Order(id: DateTime.now().microsecond,
                                  date: Util.formatDateTime(),
                                  idTable: table.id ,
                                  idMenu: menusController.getPickedIds());
                              orderController.saveOrder(order);


                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: table.idOrder == null // kalo meja kosong maka hijau
                                  ? Colors.green[300]
                                  : Colors.red[300],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Text(
                                table.tableNumber,
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
