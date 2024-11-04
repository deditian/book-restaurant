import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as root_bundle;

class Util {
  static Future<List<dynamic>> loadJsonData(String filePath) async {
    final jsonString = await root_bundle.rootBundle.loadString(filePath);
    return jsonDecode(jsonString);
  }

  static Future<String> loadJsonString(String path) async {
    try {
      return await root_bundle.rootBundle.loadString(path);
    } catch (e) {
      throw Exception("Failed to load JSON data: $e");
    }
  }

  static String formatDateTime(){
    DateTime now = DateTime.now();
    String currentDate = "${now.day}-${now.month}-${now.year}";
    String currentTime = "${now.hour}:${now.minute}";
    return "${currentDate} - ${currentTime}";
  }

  static String currentDate(){
    DateTime now = DateTime.now();
    String currentDate = "${now.day}-${now.month}-${now.year}";
    return "${currentDate}";
  }

  static String formatRupiah(double amount) {
    return 'Rp. ${amount.toStringAsFixed(0).replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (match) => '.')}';
  }

  static void showSnackbar(
      BuildContext context, {
        required String message,
        Color backgroundColor = Colors.black,
        Duration duration = const Duration(seconds: 2),
      }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor,
        duration: duration,
      ),
    );
  }
}