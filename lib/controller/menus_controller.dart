import 'package:get/get.dart';
import 'package:flutter/foundation.dart';

import '../model/category.dart';
import '../model/menu.dart';
import '../ui/utils.dart';

class MenusController extends GetxController {
  var itemsCategory = <CategoryModel>[].obs;
  var itemsMenu = <Menu>[].obs;
  var allItemsMenu = <Menu>[].obs;
  var selectedCategory = 'All'.obs;


  @override
  void onInit() {
    loadData();
    loadMenu();
    super.onInit();
  }

  Future<void> loadData() async {
    try {
      final data = await Util.loadJsonData('data/category.json');
      var list =  data.map((json) => CategoryModel.fromJson(json)).toList();
      itemsCategory.value = list;
    } catch (e) {
      debugPrint("Error loading data: $e");
    }
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


  void setCategory(String category) {
    selectedCategory.value = category;
    filterMenuByCategory();
  }

  void filterMenuByCategory() {
    if (selectedCategory.value == 'All') {
      itemsMenu.value = allItemsMenu;
    } else {
      itemsMenu.value = allItemsMenu
          .where((item) => item.category == selectedCategory.value)
          .toList();
    }
  }


}
