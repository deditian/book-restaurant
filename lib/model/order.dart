class Order {
  final int id;
  final String date;
  final int idTable;
  final List<int> idMenu;

  Order({
    required this.id,
    required this.date,
    required this.idTable,
    required this.idMenu,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      date: json['date'],
      idTable: json['id_table'],
      idMenu: List<int>.from(json['id_menu']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date,
      'id_table': idTable,
      'id_menu': idMenu,
    };
  }
}
