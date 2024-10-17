import 'package:get/get.dart';
import 'package:flutter/foundation.dart';
import 'package:get_storage/get_storage.dart';

import '../model/menu.dart';
import '../ui/utils.dart';

class MenusController extends GetxController {
  final storage = GetStorage();
  var itemsMenu = <Menu>[].obs;

  var allItemsMenu = <Menu>[].obs;
  var menupick = <Menu>[].obs;

  @override
  void onInit() {
    loadMenu();
    loadPicked();
    super.onInit();
  }


  Future<void> loadMenu() async {
    try {
      final data = await Util.loadJsonData('data/source_data.json');
      var list =  data.map((json) => Menu.fromJson(json)).toList();
      allItemsMenu.value = list;
      itemsMenu.value = list;
    } catch (e) {
      debugPrint("Error loading data: $e");
    }
  }




  List<int> getPickedIds() {
    return menupick.map((menu) => menu.id).toList();
  }


  void loadPicked() {
    List ordersJson = storage.read('menus_pick') ?? [];
    menupick.value = ordersJson.map((json) => Menu.fromJson(json)).toList();
  }

  void addOrder(Menu order) {
    menupick.add(order);
    _saveMenus();
  }

  void removeOrder(int index) {
    menupick.removeAt(index);
    _saveMenus();
  }

  void incrementOrderCount(int index) {
    _updateOrderCount(index, menupick[index].qty! + 1);
  }

  void decrementOrderCount(int index) {
    _updateOrderCount(index, menupick[index].qty! - 1);
  }


  void _updateOrderCount(int index, int count) {
    if (count > 0) {
      menupick[index].qty = count;
      menupick.refresh();
      _saveMenus();
    }
  }


  void clearMenus() {
    menupick.clear();
    _saveMenus();
  }

  void _saveMenus() {
    List ordersJson = menupick.map((order) => order.toJson()).toList();
    storage.write('menus_pick', ordersJson);
  }

  int get orderCount => menupick.length;


}
