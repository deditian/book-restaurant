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
    int index = orderPick.indexWhere((order) => order.idTable == idTable);
    debugPrint("hasilindex == ${index}");
    if (index != -1) {
      var updatedOrder = Order(
        id: orderPick[index].id,
        date: orderPick[index].date,
        idTable: orderPick[index].idTable,
        idMenu: List.from(orderPick[index].idMenu),
        customerName: customerName,
      );

      debugPrint("hasilORDER == ${updatedOrder.toJson()}");

      orderPick[index] = updatedOrder;
      _saveOrder();
    }
  }


  void updatePaymentMethod(int idOrder, String paymentMethod) {
    debugPrint("hasilidTable Payment == ${idOrder}");
    int index = orderPick.indexWhere((order) => order.id == idOrder);
    debugPrint("hasilindex Payment == ${index}");
    if (index != -1) {
      var updatedOrder = Order(
        id: orderPick[index].id,
        date: orderPick[index].date,
        idTable: orderPick[index].idTable,
        customerName: orderPick[index].customerName,
        paymentMethod: paymentMethod,
        idMenu: List.from(orderPick[index].idMenu),
      );

      debugPrint("hasilORDER Payment == ${updatedOrder.toJson()}");

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

  void clearOrders() {
    orderPick.clear();
    _saveOrder();
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
