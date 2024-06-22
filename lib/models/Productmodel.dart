class Product {
  final int id;
  final String name;
  final String description;
  final double price;
  final int stock;
  final String category;
  final String brand;
  final String imageUrl;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.stock,
    required this.category,
    required this.brand,
    required this.imageUrl,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['product_id'],
      name: json['product_name'] ?? 'Unknown Product',
      description: json['description'] ?? '',
      price: json['price'] != null ? json['price'].toDouble() : 0.0,
      stock: json['stock'] ?? 0,
      category: json['category'] ?? 'Unknown',
      brand: json['brand'] ?? 'Unknown',
      imageUrl: json['images'] != null && json['images'].isNotEmpty ? json['images'][0]['image_url'] : '',
    );
  }
}