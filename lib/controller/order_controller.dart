import 'package:book_restorant/model/menu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../model/order.dart';


class OrderController extends GetxController {
  final box = GetStorage();

  void saveOrder(Order order) {
    debugPrint("SAVENYA  ${order.toJson()}");
    box.write('order', order.toJson());
  }


  List<Order> getAllOrders() {
    List storedOrders = box.read('order') ?? [];
    // List<dynamic> storedOrders = box.read<List<Order>>('order') ?? [];
    return storedOrders.map((json) => Order.fromJson(json)).toList();
  }


  Order? loadOrder() {
    final box = GetStorage();

    Map<String, dynamic>? json = box.read<Map<String, dynamic>>('order');

    if (json != null) {
      return Order.fromJson(json);
    }

    return null;
  }

}
