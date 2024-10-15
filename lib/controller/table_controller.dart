import 'dart:convert';

import 'package:book_restorant/model/table.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart';

import '../ui/utils.dart';

class TableController extends GetxController {
  var sections = <SectionsTable>[].obs;

  @override
  void onInit() {
    loadTable();
    super.onInit();
  }

  Future<void> loadTable() async {
    try {
      final data = await Util.loadJsonString('data/tables.json');
      final Map<String, dynamic> jsonData = jsonDecode(data);
      var sectionsJson = jsonData['sections_table'] as List<dynamic>;
      var list = sectionsJson
          .map((json) => SectionsTable.fromJson(json as Map<String, dynamic>))
          .toList();
      sections.value = list;
    } catch (e) {
      debugPrint("Error loading data: $e");
    }
  }




}
