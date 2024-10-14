import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../controller/DataController.dart';
import 'package:get/get.dart';

import '../material/order_bottomsheet.dart';
import '../model/menu.dart';

class SalesTransaction extends StatefulWidget {
  const SalesTransaction({super.key});

  @override
  State<SalesTransaction> createState() => _SalesTransactionState();
}

class _SalesTransactionState extends State<SalesTransaction> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Restaurant", style: TextStyle(fontSize: 16)),
            Container(),
          ],
        ),
      ),
      body: SalesTransactionScreen(),
    );
  }
}

class SalesTransactionScreen extends StatefulWidget {
  const SalesTransactionScreen({super.key});

  @override
  State<SalesTransactionScreen> createState() => _SalesTransactionScreenState();
}

class _SalesTransactionScreenState extends State<SalesTransactionScreen> {
  final DataController controller = Get.put(DataController());





  void showOrderBottomSheet(Menu selectedMenu) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Membuat BottomSheet scrollable
      builder: (BuildContext context) {
        return OrderBottomSheet(
          menu: selectedMenu,
          onMenu: (orderedMenu) {
            print('Ordered Menu: ${orderedMenu.name} with count: ${orderedMenu.countOrder}   Date: ${orderedMenu.dateOrder}');

          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Category", style: TextStyle(fontSize: 15)),
          Container(
            height: 140,
            child: Obx(() {
              return controller.items.isNotEmpty
                  ? ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: controller.items.length,
                itemBuilder: (context, index) {
                  bool isSelected = controller.selectedCategory.value == controller.items[index]['name'];

                  return Card(
                    elevation: isSelected ? 4 : 1,
                    color: isSelected ? Colors.blue.withOpacity(0.2) : Colors.white,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          controller.setCategory(controller.items[index]['name']);
                        });

                      },
                      child: Center(
                        child: Container(
                          padding: EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 70,
                                height: 70,
                                child: Center(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15.0),
                                    child: Image.network(
                                      controller.items[index]['image_url'],
                                      width: 50,
                                      height: 50,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: 80,
                                child: Text(
                                  textAlign: TextAlign.center,
                                  controller.items[index]['name'],
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                    color: isSelected ? Colors.white : Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              )
                  : Center(child: CircularProgressIndicator());
            }),
          ),
          SizedBox(height: 10),
          Text("Menu", style: TextStyle(fontSize: 15)),
          Expanded(
            child: Center(
              child: Obx(() {
                return controller.itemsMenu.isNotEmpty
                    ? GridView.count(
                  crossAxisCount: 3,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  children: controller.itemsMenu.map((menu) {
                    return Card(
                      elevation: 1,
                      child: InkWell(
                        onTap: () {
                            showOrderBottomSheet(Menu.fromJson(menu));
                        },
                        child: Center(
                          child: Container(
                            padding: EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 70,
                                  height: 70,
                                  child: Center(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15.0),
                                      child: Image.network(
                                        menu['image_url'],
                                        width: 50,
                                        height: 50,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 80,
                                  child: Text(
                                    textAlign: TextAlign.center,
                                    menu['name'],
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                )
                    : Center(child: Text('No menu items available.'));
              }),
            ),
          ),
        ],
      ),
    );
  }


}

