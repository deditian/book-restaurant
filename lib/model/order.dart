class Order {
  final int id;
  final String date;
  final List<String> idMenu;

  Order({
    required this.id,
    required this.date,
    required this.idMenu
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
        date: json['date'],
      idMenu: json['id_menu']

    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date,
      'id_menu' : idMenu
    };
  }
}
