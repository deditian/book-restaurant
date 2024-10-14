class Menu {
  final int id;
  final String name;
  final String imageUrl;
  final String description;
  final double price;
  final double rating;
  final int countRating;
  int? qtyOrder;
  String? dateOrder;
  String? category;

  Menu({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.description,
    required this.price,
    required this.rating,
    required this.countRating,
    this.qtyOrder,
    this.dateOrder,
    this.category,
  });

  factory Menu.fromJson(Map<String, dynamic> json) {
    return Menu(
      id: json['id'],
      name: json['name'],
      imageUrl: json['image_url'],
      description: json['description'],
      price: json['price'].toDouble(),
      rating: json['rating'].toDouble(),
      countRating: json['count_rating'],
      qtyOrder: json['qty_order'] ?? 0,
      dateOrder: json['date_order'],
      category: json['category'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image_url': imageUrl,
      'description': description,
      'price': price,
      'rating': rating,
      'count_rating': countRating,
      'qty_order': qtyOrder,
      'date_order': dateOrder,
      'category': category,
    };
  }
}
