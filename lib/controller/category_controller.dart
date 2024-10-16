import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart';

import '../model/category.dart';

import '../ui/utils.dart';
import 'menus_controller.dart';

class CategoryController extends GetxController {
  final MenusController menuController = Get.find<MenusController>();
  var itemsCategory = <CategoryModel>[].obs;
  var selectedCategory = 'All'.obs;


  @override
  void onInit() {
    loadData();
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


  void setCategory(String category) {
    selectedCategory.value = category;
    filterMenuByCategory();
  }

  void filterMenuByCategory() {
    if (selectedCategory.value == 'All') {
      menuController.itemsMenu.value = menuController.allItemsMenu;
    } else {
      menuController.itemsMenu.value = menuController.allItemsMenu
          .where((item) => item.category == selectedCategory.value)
          .toList();
    }
  }


}
