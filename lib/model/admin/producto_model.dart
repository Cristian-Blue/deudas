class ProductoModel {
  final int id;
  final String title;
  final int price;
  final String description;
  final List<String> images;
  final String category;

  ProductoModel({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.images,
    required this.category,
  });

  factory ProductoModel.fromJson(Map<String, dynamic> json) {
    return ProductoModel(
      id: json['id'],
      title: json['title'],
      price: json['price'],
      description: json['description'],
      images: List<String>.from(json['images']),
      category: json['category']['name'],
    );
  }
}
