import 'dart:convert';
import 'package:flutter/services.dart' as root_bundle;

class Util {
  static Future<List<dynamic>> loadJsonData(String filePath) async {
    final jsonString = await root_bundle.rootBundle.loadString(filePath);
    return jsonDecode(jsonString);
  }
}