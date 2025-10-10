import 'package:ecommerce_mobile_app/models/category.dart';
import 'package:ecommerce_mobile_app/models/product.dart';

class MockData {
  // Categories data
  static List<Category> categories = [
    const Category(
      id: '1',
      name: 'Hoodies',
      iconPath:
          'https://images.unsplash.com/photo-1556821840-3a63f95609a7?w=400&h=400&fit=crop&crop=center',
    ),
    const Category(
      id: '2',
      name: 'Shorts',
      iconPath: 'https://via.placeholder.com/64x64/8B5CF6/FFFFFF?text=S',
    ),
    const Category(
      id: '3',
      name: 'Shoes',
      iconPath:
          'https://images.unsplash.com/photo-1549298916-b41d501d3772?w=400&h=400&fit=crop&crop=center',
    ),
    const Category(
      id: '4',
      name: 'Bag',
      iconPath:
          'https://images.unsplash.com/photo-1553062407-98eeb64c6a62?w=400&h=400&fit=crop&crop=center',
    ),
    const Category(
      id: '5',
      name: 'Accessories',
      iconPath:
          'https://images.unsplash.com/photo-1524592094714-0f0654e20314?w=400&h=400&fit=crop&crop=center',
    ),
  ];

  // Sample products data - updated with real images
  static List<Product> topSellingProducts = [
    const Product(
      id: '1',
      name: 'Men\'s Harrington Jacket',
      price: 148.00,
      imageUrl:
          'https://github.com/user-attachments/assets/9561def3-eecb-468d-99ef-76323b83918e',
      category: 'jackets',
      isFavorite: false,
    ),
    const Product(
      id: '2',
      name: 'Max Cirro Men\'s Slides',
      price: 55.00,
      originalPrice: 100.97,
      imageUrl:
          'https://github.com/user-attachments/assets/adecb00a-b70f-4390-9e88-9120e6c75f92',
      category: 'shoes',
      isFavorite: true,
    ),
    const Product(
      id: '3',
      name: 'Max Comfort Shoes',
      price: 65.00,
      imageUrl:
          'https://github.com/user-attachments/assets/aeec653f-f57d-4384-8686-473ce10683c8',
      category: 'shoes',
      isFavorite: false,
    ),
  ];

  static List<Product> newInProducts = [
    const Product(
      id: '4',
      name: 'New Hoodie Design',
      price: 85.00,
      imageUrl:
          'https://github.com/user-attachments/assets/a531ec16-3ab1-42dc-8fa7-cf993cb7b220',
      category: 'hoodies',
      isFavorite: false,
    ),
    const Product(
      id: '5',
      name: 'Canvas Backpack',
      price: 45.00,
      imageUrl:
          'https://github.com/user-attachments/assets/e815ce3a-70f7-4e0c-8128-60a7ae7d9a79',
      category: 'bags',
      isFavorite: true,
    ),
  ];

  // Hoodies products - updated with real images
  static List<Product> hoodiesProducts = [
    const Product(
      id: 'h1',
      name: 'Men\'s Fleece Pullover Hoodie',
      price: 120.00,
      imageUrl:
          'https://github.com/user-attachments/assets/9561def3-eecb-468d-99ef-76323b83918e',
      category: 'hoodies',
      isFavorite: false,
    ),
    const Product(
      id: 'h2',
      name: 'Fleece Pullover Sweat Hoodie',
      price: 130.97,
      imageUrl:
          'https://github.com/user-attachments/assets/a531ec16-3ab1-42dc-8fa7-cf993cb7b220',
      category: 'hoodies',
      isFavorite: true,
    ),
    const Product(
      id: 'h3',
      name: 'Fleece Skate Hoodie',
      price: 118.00,
      imageUrl:
          'https://github.com/user-attachments/assets/2017f4cf-4e97-4bd5-ac78-31b4ea67e2fa',
      category: 'hoodies',
      isFavorite: false,
    ),
    const Product(
      id: 'h4',
      name: 'Men\'s Tie-Dye Pullover Hoodie',
      price: 135.97,
      imageUrl:
          'https://github.com/user-attachments/assets/c2cdc2f1-b04d-43b1-b74d-f2ee6718563d',
      category: 'hoodies',
      isFavorite: false,
    ),
  ];
}
