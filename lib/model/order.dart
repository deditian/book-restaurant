class Order {
  final int id;
  final String date;
  final int idTable;
  String? customerName;
  final List<int> idMenu;

  Order({
    required this.id,
    required this.date,
    required this.idTable,
    this.customerName,
    required this.idMenu

  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      date: json['date'],
      idTable: json['id_table'],
      customerName: json['customer_name'],
      idMenu: List<int>.from(json['id_menu']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date,
      'id_table': idTable,
      'customer_name': customerName,
      'id_menu': idMenu,
    };
  }
}
