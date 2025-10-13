import 'package:ecommerce_mobile_app/core/constants/image_urls.dart';
import 'package:ecommerce_mobile_app/models/category.dart';
import 'package:ecommerce_mobile_app/models/product.dart';

class MockData {
  // Categories data
  static List<Category> categories = [
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

  // Sample products data - using ImageUrls constants
  static List<Product> topSellingProducts = [
    const Product(
      id: '1',
      name: 'Men\'s Harrington Jacket',
      price: 148.00,
      imageUrl: ImageUrls.hoodieIcon,
      category: 'jackets',
      isFavorite: false,
    ),
    const Product(
      id: '2',
      name: 'Max Cirro Men\'s Slides',
      price: 55.00,
      originalPrice: 100.97,
      imageUrl: ImageUrls.shoesIcon,
      category: 'shoes',
      isFavorite: true,
    ),
    const Product(
      id: '3',
      name: 'Max Comfort Shoes',
      price: 65.00,
      imageUrl: ImageUrls.shoesIcon,
      category: 'shoes',
      isFavorite: false,
    ),
  ];

  static List<Product> newInProducts = [
    const Product(
      id: '4',
      name: 'New Hoodie Design',
      price: 85.00,
      imageUrl: ImageUrls.hoodieIcon,
      category: 'hoodies',
      isFavorite: false,
    ),
    const Product(
      id: '5',
      name: 'Canvas Backpack',
      price: 45.00,
      imageUrl: ImageUrls.bagIcon,
      category: 'bags',
      isFavorite: true,
    ),
  ];

  // Hoodies products - using ImageUrls constants
  static List<Product> hoodiesProducts = [
    const Product(
      id: 'h1',
      name: 'Men\'s Fleece Pullover Hoodie',
      price: 120.00,
      imageUrl: ImageUrls.hoodieIcon,
      category: 'hoodies',
      isFavorite: false,
    ),
    const Product(
      id: 'h2',
      name: 'Fleece Pullover Sweat Hoodie',
      price: 130.97,
      imageUrl: ImageUrls.hoodieIcon,
      category: 'hoodies',
      isFavorite: true,
    ),
    const Product(
      id: 'h3',
      name: 'Fleece Skate Hoodie',
      price: 118.00,
      imageUrl: ImageUrls.hoodieIcon,
      category: 'hoodies',
      isFavorite: false,
    ),
    const Product(
      id: 'h4',
      name: 'Men\'s Tie-Dye Pullover Hoodie',
      price: 135.97,
      imageUrl: ImageUrls.hoodieIcon,
      category: 'hoodies',
      isFavorite: false,
    ),
  ];
}
