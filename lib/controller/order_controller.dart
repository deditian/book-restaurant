import 'package:book_restorant/model/menu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../model/order.dart';
import 'menus_controller.dart';


class OrderController extends GetxController {
  final MenusController menusController = Get.find<MenusController>();

  final box = GetStorage();
  var orderPick = <Order>[].obs;


  @override
  void onInit() {
    loadOrder();
    super.onInit();
  }

  void addOrder(Order order) {
    orderPick.add(order);
  }



  void updateCustomerName(int idTable, String customerName) {
    debugPrint("hasilidTable == ${idTable}");
    // Temukan indeks pesanan dengan idTable yang cocok
    int index = orderPick.indexWhere((order) => order.idTable == idTable);
    debugPrint("hasilindex == ${index}");
    if (index != -1) {
      // Buat salinan dari pesanan yang ada
      var updatedOrder = Order(
        id: orderPick[index].id,
        date: orderPick[index].date,
        idTable: orderPick[index].idTable,
        idMenu: List.from(orderPick[index].idMenu), // Salin idMenu
        customerName: customerName, // Update nama pelanggan
      );

      debugPrint("hasilORDER == ${updatedOrder.toJson()}");

      // Ganti pesanan yang lama dengan pesanan yang telah diperbarui
      orderPick[index] = updatedOrder;
      _saveOrder();
    }
  }



  void removeOrder(int index) {
    orderPick.removeAt(index);
    _saveOrder();
  }

  void clearMenus() {
    menusController.clearMenus();
  }

  void loadOrder() {
    List ordersJson = box.read('order') ?? [];
    orderPick.value = ordersJson.map((json) => Order.fromJson(json)).toList();
  }


  void _saveOrder() {
    List ordersJson = orderPick.map((order) => order.toJson()).toList();
    box.write('order', ordersJson);
  }






}
