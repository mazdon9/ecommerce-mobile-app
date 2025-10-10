class Product {
  final String id;
  final String name;
  final double price;
  final double? originalPrice;
  final String imageUrl;
  final bool isFavorite;
  final String category;

  const Product({
    required this.id,
    required this.name,
    required this.price,
    this.originalPrice,
    required this.imageUrl,
    this.isFavorite = false,
    required this.category,
  });

  bool get isOnSale => originalPrice != null && originalPrice! > price;
  double get discountPercentage {
    if (!isOnSale) return 0;
    return ((originalPrice! - price) / originalPrice!) * 100;
  }

  Product copyWith({
    String? id,
    String? name,
    double? price,
    double? originalPrice,
    String? imageUrl,
    bool? isFavorite,
    String? category,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      originalPrice: originalPrice ?? this.originalPrice,
      imageUrl: imageUrl ?? this.imageUrl,
      isFavorite: isFavorite ?? this.isFavorite,
      category: category ?? this.category,
    );
  }
}
