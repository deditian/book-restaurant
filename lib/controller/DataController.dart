import 'package:get/get.dart';
import 'package:flutter/foundation.dart';

import '../ui/utils.dart';

class DataController extends GetxController {
  var items = <dynamic>[].obs;
  var itemsMenu = <dynamic>[].obs;
  var allItemsMenu = <dynamic>[].obs;
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
      items.value = data;
    } catch (e) {
      debugPrint("Error loading data: $e");
    }
  }

  Future<void> loadMenu() async {
    try {
      final data = await Util.loadJsonData('data/source_data.json');
      allItemsMenu.value = data;
      itemsMenu.value = data;
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
          .where((item) => item['category'] == selectedCategory.value)
          .toList();
    }
  }


}
