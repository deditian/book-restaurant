class Order {
  final int id;
  final String name;
  final String imageUrl;
  final String description;
  final double price;
  final double rating;
  final int countRating;
  int countOrder;
  String dateOrder;

  Order({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.description,
    required this.price,
    required this.rating,
    required this.countRating,
    required this.countOrder,
    required this.dateOrder,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      name: json['name'],
      imageUrl: json['imageUrl'],
      description: json['description'],
      price: json['price'],
      rating: json['rating'],
      countRating: json['countRating'],
      countOrder: json['countOrder'] ?? 1,
      dateOrder: json['dateOrder'] ?? DateTime.now().toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'description': description,
      'price': price,
      'rating': rating,
      'countRating': countRating,
      'countOrder': countOrder,
      'dateOrder': dateOrder,
    };
  }
}
