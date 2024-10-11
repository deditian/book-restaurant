import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../controller/DataController.dart';
import 'package:get/get.dart';

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
              Text("Restorant",style: TextStyle(fontSize: 16),),
              Container(

              ),
            ],
          ),
        ),

      body: SalesTransactionScreen()
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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Category", style: TextStyle(fontSize: 15),),

          Container(
            height: 120,
            child: Obx(() {
              return controller.items.isNotEmpty
                  ? ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: controller.items.length,
                itemBuilder: (context, index) {
                  return
                    Card(
                      elevation: 1,
                      child: InkWell(
                        onTap: (){

                        },
                        child: Center(
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 70,
                                  height: 70,
                                  child: Center(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15.0), // Ganti nilai sesuai keinginan
                                      child: Image.network(
                                        controller.items[index]['image_url'],
                                        width: 50, // Sesuaikan ukuran
                                        height: 50, // Sesuaikan ukuran
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
                                    style: TextStyle(fontSize: 14),
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

          SizedBox(height: 10,),

          Text("Menu", style: TextStyle(fontSize: 15),),

          Expanded(
            child: Center(
              child: Obx(() {
                return controller.itemsMenu.isNotEmpty
                    ? GridView.count(
                    crossAxisCount: 3,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    children: controller.itemsMenu.map((menu) {
                      return
                        Card(
                          elevation: 1,
                          child: InkWell(
                            onTap: (){

                            },
                            child: Center(
                              child: Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 70,
                                      height: 70,
                                      child: Center(
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(15.0), // Ganti nilai sesuai keinginan
                                          child: Image.network(
                                            menu['image_url'],
                                            width: 50, // Sesuaikan ukuran
                                            height: 50, // Sesuaikan ukuran
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
                    }).toList()

                )
                    : Center(child: CircularProgressIndicator());
              }),
            ),
          ),
        ],
      ),
    );
  }
}







