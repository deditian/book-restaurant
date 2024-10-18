import 'package:book_restorant/controller/order_controller.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../model/sales.dart';


class SalesController extends GetxController {
  final OrderController orderController = Get.find<OrderController>();
  final box = GetStorage();
  var salesList = <Sales>[].obs;

  @override
  void onInit() {
    loadSales();
    super.onInit();
  }

  void loadSales() {
    List salesJson = box.read('sales')??[];
    salesList.value = salesJson.map((json) => Sales.fromJson(json)).toList();
  }

  Future<void> addSales(Sales sales) async {
    salesList.add(sales);
    await _saveSales();
    orderController.clearOrders();
  }

  Future<void> _saveSales() async {
    List salesJson = salesList.map((sales) => sales.toJson()).toList();
    await box.write('sales', salesJson);
  }





}
