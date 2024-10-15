import 'package:book_restorant/model/menu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';


class OrderController extends GetxController {
  final storage = GetStorage();
  var orders = <Menu>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadOrders();
  }

  void loadOrders() {
    List ordersJson = storage.read('orders') ?? [];
    orders.value = ordersJson.map((json) => Menu.fromJson(json)).toList();
  }

  void addOrder(Menu order) {
    orders.add(order);
    _saveOrders();
  }

  void removeOrder(int index) {
    orders.removeAt(index);
    _saveOrders();
  }

  void incrementOrderCount(int index) {
    _updateOrderCount(index, orders[index].qty! + 1);
  }

  void decrementOrderCount(int index) {
    _updateOrderCount(index, orders[index].qty! - 1);
  }


  void _updateOrderCount(int index, int count) {

    if (count > 0) {
      orders[index].qty = count;
      orders.refresh();
      _saveOrders();
    }
  }

  void _saveOrders() {
    List ordersJson = orders.map((order) => order.toJson()).toList();
    storage.write('orders', ordersJson);
  }

  int get orderCount => orders.length;
}
