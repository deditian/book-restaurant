import 'package:book_restorant/model/order.dart';

class Sales {
  final int idSales;
  final String dateSale;
  String? salesName;
  double? totalPrice;
  final List<Order> orders;

  Sales({
    required this.idSales,
    required this.dateSale,
    this.salesName,
    this.totalPrice,
    required this.orders,
  });

  factory Sales.fromJson(Map<String, dynamic> json) {
    return Sales(
      idSales: json['id_sales'],
      dateSale: json['date_sale'],
      salesName: json['sales_name'],
      totalPrice: json['total_price'],
      orders: (json['orders'] as List<dynamic>)
          .map((orderJson) => Order.fromJson(orderJson))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_sales': idSales,
      'date_sale': dateSale,
      'sales_name': salesName,
      'total_price': totalPrice,
      'orders': orders.map((order) => order.toJson()).toList(),
    };
  }
}
