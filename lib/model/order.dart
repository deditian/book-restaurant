import 'package:book_restorant/model/menu.dart';

class Order {
  final int id;
  final String date;
  final int idTable;
  String? customerName;
  String? paymentMethod;
  final List<Menu> idMenu;

  Order({
    required this.id,
    required this.date,
    required this.idTable,
    this.customerName,
    this.paymentMethod,
    required this.idMenu,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      date: json['date'],
      idTable: json['id_table'],
      customerName: json['customer_name'],
      paymentMethod: json['payment_method'],
      idMenu: (json['id_menu'] as List<dynamic>)
          .map((menuJson) => Menu.fromJson(menuJson))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date,
      'id_table': idTable,
      'customer_name': customerName,
      'payment_method': paymentMethod,
      'id_menu': idMenu.map((menu) => menu.toJson()).toList(),
    };
  }
}
