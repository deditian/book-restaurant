import 'package:get/get.dart';
import 'package:flutter/foundation.dart';

import '../ui/utils.dart';

class DataController extends GetxController {
  var items = <dynamic>[].obs;
  var itemsMenu = <dynamic>[].obs;

  @override
  void onInit() {
    loadData('data/category.json');
    loadMenu('data/source_data.json');
    super.onInit();
  }

  Future<void> loadData(String path) async {
    try {
      final data = await Util.loadJsonData(path);
      items.value = data;
    } catch (e) {
      debugPrint("Error loading data: $e");
    }
  }

  Future<void> loadMenu(String path) async {
    try {
      final data = await Util.loadJsonData(path);
      itemsMenu.value = data;
    } catch (e) {
      debugPrint("Error loading data: $e");
    }
  }


}
