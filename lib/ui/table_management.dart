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

  @override
  Widget build(BuildContext context) {
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
                        crossAxisCount: 5, // 5 columns
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                        childAspectRatio: 1.0,
                      ),
                      itemCount: section.tables.length,
                      itemBuilder: (context, tableIndex) {
                        final table = section.tables[tableIndex];
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              // Simulate table booking status change on tap
                              table.status = table.status == 'available'
                                  ? 'occupied'
                                  : 'available';
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: table.status == 'available'
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
