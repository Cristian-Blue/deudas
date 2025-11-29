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
      id: _parseId(json['id']),
      title: json['title'] ?? 'No title',
      price: json['price'] ?? 0,
      description: json['description'] ?? 'No description',
      images: List<String>.from(json['images'] ?? []),
      category: json['category']?['name']?.toString() ?? 'No category',
    );
  }

  static int _parseId(dynamic value) {
    if (value is int) return value;
    if (value is String) {
      return int.tryParse(value) ?? 0;
    }
    return 0;
  }
}
