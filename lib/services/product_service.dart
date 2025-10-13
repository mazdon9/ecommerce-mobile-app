import 'package:ecommerce_mobile_app/core/constants/image_urls.dart';
import 'package:ecommerce_mobile_app/models/category.dart';
import 'package:ecommerce_mobile_app/models/product.dart';

class ProductService {
  // Get products by category
  static List<Product> getProductsByCategory(String categoryName) {
    switch (categoryName.toLowerCase()) {
      case 'hoodies':
        return _generateProductsForCategory(
          categoryName: 'hoodies',
          images: ImageUrls.hoodieProducts,
          baseNames: [
            'Classic Hoodie',
            'Premium Pullover',
            'Fleece Hoodie',
            'Zip-up Hoodie',
            'Oversized Hoodie',
            'Cotton Blend Hoodie',
          ],
          basePrices: [89.99, 109.99, 79.99, 129.99, 99.99, 119.99],
        );
      case 'shoes':
        return _generateProductsForCategory(
          categoryName: 'shoes',
          images: ImageUrls.shoeProducts,
          baseNames: [
            'Running Sneakers',
            'Casual Loafers',
            'Sport Shoes',
            'Canvas Sneakers',
            'Leather Boots',
            'Athletic Trainers',
          ],
          basePrices: [159.99, 89.99, 199.99, 69.99, 249.99, 179.99],
        );
      case 'bag':
        return _generateProductsForCategory(
          categoryName: 'bags',
          images: ImageUrls.bagProducts,
          baseNames: [
            'Leather Backpack',
            'Canvas Tote',
            'Crossbody Bag',
            'Travel Duffel',
          ],
          basePrices: [149.99, 79.99, 99.99, 199.99],
        );
      case 'accessories':
        return _generateProductsForCategory(
          categoryName: 'accessories',
          images: ImageUrls.accessoryProducts,
          baseNames: ['Classic Watch', 'Leather Belt'],
          basePrices: [299.99, 59.99],
        );
      case 'shorts':
        return _generateProductsForCategory(
          categoryName: 'shorts',
          images: ImageUrls.shortsProducts,
          baseNames: ['Athletic Shorts', 'Casual Shorts'],
          basePrices: [49.99, 39.99],
        );
      default:
        return [];
    }
  }

  // Generate random products for a category
  static List<Product> _generateProductsForCategory({
    required String categoryName,
    required List<String> images,
    required List<String> baseNames,
    required List<double> basePrices,
  }) {
    List<Product> products = [];

    for (int i = 0; i < images.length && i < baseNames.length; i++) {
      final hasDiscount = i % 3 == 1; // Every 3rd product has discount
      final originalPrice = basePrices[i % basePrices.length];
      final price = hasDiscount ? originalPrice * 0.8 : originalPrice;

      products.add(
        Product(
          id: '${categoryName}_${i + 1}',
          name: baseNames[i % baseNames.length],
          price: price,
          originalPrice: hasDiscount ? originalPrice : null,
          imageUrl: images[i],
          category: categoryName,
          isFavorite: i % 4 == 0, // Every 4th product is favorite
        ),
      );
    }

    return products;
  }

  // Get all categories
  static List<Category> getAllCategories() {
    return [
      const Category(id: '1', name: 'Hoodies', iconPath: ImageUrls.hoodieIcon),
      const Category(id: '2', name: 'Shorts', iconPath: ImageUrls.shortsIcon),
      const Category(id: '3', name: 'Shoes', iconPath: ImageUrls.shoesIcon),
      const Category(id: '4', name: 'Bag', iconPath: ImageUrls.bagIcon),
      const Category(
        id: '5',
        name: 'Accessories',
        iconPath: ImageUrls.accessoriesIcon,
      ),
    ];
  }

  // Get featured products (top selling)
  static List<Product> getTopSellingProducts() {
    return [
      const Product(
        id: 'ts1',
        name: 'Premium Hoodie',
        price: 148.00,
        imageUrl: ImageUrls.hoodieIcon,
        category: 'hoodies',
        isFavorite: false,
      ),
      const Product(
        id: 'ts2',
        name: 'Athletic Sneakers',
        price: 55.00,
        originalPrice: 100.97,
        imageUrl: ImageUrls.shoesIcon,
        category: 'shoes',
        isFavorite: true,
      ),
      const Product(
        id: 'ts3',
        name: 'Casual Runners',
        price: 65.00,
        imageUrl: ImageUrls.shoesIcon,
        category: 'shoes',
        isFavorite: false,
      ),
    ];
  }

  // Get new arrival products
  static List<Product> getNewInProducts() {
    return [
      const Product(
        id: 'ni1',
        name: 'New Design Hoodie',
        price: 85.00,
        imageUrl: ImageUrls.hoodieIcon,
        category: 'hoodies',
        isFavorite: false,
      ),
      const Product(
        id: 'ni2',
        name: 'Canvas Backpack',
        price: 45.00,
        imageUrl: ImageUrls.bagIcon,
        category: 'bags',
        isFavorite: true,
      ),
    ];
  }
}
