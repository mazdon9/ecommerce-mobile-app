import 'package:ecommerce_mobile_app/models/product.dart';
import 'package:ecommerce_mobile_app/services/product_service.dart';
import 'package:ecommerce_mobile_app/shared/widgets/common_card.dart';
import 'package:ecommerce_mobile_app/shared/widgets/common_image_widget.dart';
import 'package:ecommerce_mobile_app/theme/app_color_scheme.dart';
import 'package:ecommerce_mobile_app/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryProductsScreen extends StatelessWidget {
  final String categoryName;
  final String categoryId;

  const CategoryProductsScreen({
    super.key,
    required this.categoryName,
    required this.categoryId,
  });

  @override
  Widget build(BuildContext context) {
    // Get products for the category
    final List<Product> products = ProductService.getProductsByCategory(categoryName);

    return Scaffold(
      backgroundColor: AppColorSchemes.background,
      appBar: AppBar(
        backgroundColor: AppColorSchemes.background,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios,
            color: AppColorSchemes.black,
            size: 20.r,
          ),
        ),
        title: Text(
          '$categoryName (${products.length})',
          style: AppTypography.pageTitle.copyWith(fontSize: 20.sp),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              // TODO: Show filter options
            },
            icon: Icon(Icons.tune, color: AppColorSchemes.black, size: 24.r),
          ),
        ],
      ),
      body: products.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.inventory_2_outlined,
                    size: 64.r,
                    color: AppColorSchemes.grey,
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'No products found',
                    style: AppTypography.bodyLarge.copyWith(
                      color: AppColorSchemes.grey,
                    ),
                  ),
                ],
              ),
            )
          : Padding(
              padding: EdgeInsets.all(16.w),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12.w,
                  mainAxisSpacing: 16.h,
                  childAspectRatio: 0.7,
                ),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return _ProductCard(
                    product: product,
                    onTap: () {
                      // TODO: Navigate to product detail screen
                    },
                    onFavoritePressed: () {
                      // TODO: Toggle favorite
                    },
                  );
                },
              ),
            ),
    );
  }

  List<Product> _getDummyProducts() {
    // Return different products based on category
    switch (categoryId) {
      case '1': // Hoodies
        return [
          Product(
            id: 'h1',
            name: "Men's Fleece Pullover Hoodie",
            price: 120.00,
            originalPrice: 150.00,
            imageUrl:
                'https://github.com/user-attachments/assets/9561def3-eecb-468d-99ef-76323b83918e',
            isFavorite: false,
            category: 'Hoodies',
          ),
          Product(
            id: 'h2',
            name: "Fleece Pullover Sweat Hoodie",
            price: 110.00,
            imageUrl:
                'https://github.com/user-attachments/assets/a531ec16-3ab1-42dc-8fa7-cf993cb7b220',
            isFavorite: true,
            category: 'Hoodies',
          ),
          Product(
            id: 'h3',
            name: "Fleece Skate Hoodie",
            price: 118.00,
            imageUrl:
                'https://github.com/user-attachments/assets/2017f4cf-4e97-4bd5-ac78-31b4ea67e2fa',
            isFavorite: false,
            category: 'Hoodies',
          ),
          Product(
            id: 'h4',
            name: "Men's Ice-Dye Pullover Hoodie",
            price: 125.99,
            imageUrl:
                'https://github.com/user-attachments/assets/c2cdc2f1-b04d-43b1-b74d-f2ee6718563d',
            isFavorite: true,
            category: 'Hoodies',
          ),
          Product(
            id: 'h5',
            name: "Premium Cotton Hoodie",
            price: 135.97,
            imageUrl:
                'https://github.com/user-attachments/assets/37ccc9d3-acf3-4a92-9e44-bdae946d116a',
            isFavorite: false,
            category: 'Hoodies',
          ),
          Product(
            id: 'h6',
            name: "Classic Style Hoodie",
            price: 128.50,
            imageUrl:
                'https://github.com/user-attachments/assets/98e9b3e7-4c03-48a6-afc7-938723a3b29f',
            isFavorite: false,
            category: 'Hoodies',
          ),
        ];
      case '2': // Shorts
        return [
          Product(
            id: 's1',
            name: "Cotton Casual Shorts",
            price: 45.00,
            imageUrl:
                'https://via.placeholder.com/400x400/F1F5F9/64748B?text=Shorts+1',
            isFavorite: false,
            category: 'Shorts',
          ),
          Product(
            id: 's2',
            name: "Athletic Running Shorts",
            price: 35.00,
            originalPrice: 50.00,
            imageUrl:
                'https://via.placeholder.com/400x400/F1F5F9/64748B?text=Shorts+2',
            isFavorite: false,
            category: 'Shorts',
          ),
        ];
      case '3': // Shoes
        return [
          Product(
            id: 'sh1',
            name: "Classic Sneakers",
            price: 85.00,
            imageUrl:
                'https://github.com/user-attachments/assets/aeec653f-f57d-4384-8686-473ce10683c8',
            isFavorite: true,
            category: 'Shoes',
          ),
          Product(
            id: 'sh2',
            name: "Running Shoes",
            price: 120.00,
            originalPrice: 150.00,
            imageUrl:
                'https://github.com/user-attachments/assets/adecb00a-b70f-4390-9e88-9120e6c75f92',
            isFavorite: false,
            category: 'Shoes',
          ),
          Product(
            id: 'sh3',
            name: "Premium Sports Shoes",
            price: 145.00,
            imageUrl:
                'https://github.com/user-attachments/assets/f72a90e1-5d3d-4178-b530-072caf1dd1f1',
            isFavorite: false,
            category: 'Shoes',
          ),
          Product(
            id: 'sh4',
            name: "Casual Walking Shoes",
            price: 95.00,
            imageUrl:
                'https://github.com/user-attachments/assets/d8401d3a-deb3-4862-9777-1ffb620e4909',
            isFavorite: true,
            category: 'Shoes',
          ),
          Product(
            id: 'sh5',
            name: "High-Top Sneakers",
            price: 130.00,
            imageUrl:
                'https://github.com/user-attachments/assets/e44a36e5-5a98-4249-a9bf-4577bd5ceece',
            isFavorite: false,
            category: 'Shoes',
          ),
          Product(
            id: 'sh6',
            name: "Athletic Performance Shoes",
            price: 165.00,
            originalPrice: 200.00,
            imageUrl:
                'https://github.com/user-attachments/assets/0a348896-099b-4cde-9c8a-ef40993fd6ff',
            isFavorite: false,
            category: 'Shoes',
          ),
        ];
      case '4': // Bags
        return [
          Product(
            id: 'b1',
            name: "Canvas Backpack",
            price: 65.00,
            imageUrl:
                'https://github.com/user-attachments/assets/e815ce3a-70f7-4e0c-8128-60a7ae7d9a79',
            isFavorite: false,
            category: 'Bags',
          ),
          Product(
            id: 'b2',
            name: "Leather Messenger Bag",
            price: 95.00,
            imageUrl:
                'https://github.com/user-attachments/assets/424e0c25-0d1a-4aae-80ca-5b3d80245d8f',
            isFavorite: true,
            category: 'Bags',
          ),
          Product(
            id: 'b3',
            name: "Premium Travel Bag",
            price: 125.00,
            originalPrice: 150.00,
            imageUrl:
                'https://github.com/user-attachments/assets/08c14cbe-018c-48b9-bb34-84265bb7ce2a',
            isFavorite: false,
            category: 'Bags',
          ),
          Product(
            id: 'b4',
            name: "Compact Crossbody Bag",
            price: 45.00,
            imageUrl:
                'https://github.com/user-attachments/assets/d766ff59-e1e3-4ac4-8bb1-57e4a50556f4',
            isFavorite: false,
            category: 'Bags',
          ),
        ];
      case '5': // Accessories
        return [
          Product(
            id: 'a1',
            name: "Classic Watch",
            price: 199.00,
            originalPrice: 250.00,
            imageUrl:
                'https://github.com/user-attachments/assets/b43fe446-1ea5-4cc7-b70c-1a87791f3be5',
            isFavorite: false,
            category: 'Accessories',
          ),
          Product(
            id: 'a2',
            name: "Leather Wallet",
            price: 45.00,
            imageUrl:
                'https://github.com/user-attachments/assets/9edd9661-04ee-4f2f-b0df-0b7941656ba9',
            isFavorite: true,
            category: 'Accessories',
          ),
        ];
      default:
        return [];
    }
  }
}

class _ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback? onTap;
  final VoidCallback? onFavoritePressed;

  const _ProductCard({
    required this.product,
    this.onTap,
    this.onFavoritePressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColorSchemes.surface,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColorSchemes.background,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12.r),
                        topRight: Radius.circular(12.r),
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12.r),
                        topRight: Radius.circular(12.r),
                      ),
                      child: Image.network(
                        product.imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: AppColorSchemes.background,
                            child: Icon(
                              Icons.image_not_supported_outlined,
                              size: 32.r,
                              color: AppColorSchemes.grey,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Positioned(
                    top: 8.h,
                    right: 8.w,
                    child: GestureDetector(
                      onTap: onFavoritePressed,
                      child: Container(
                        width: 28.w,
                        height: 28.h,
                        decoration: BoxDecoration(
                          color: AppColorSchemes.surface,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Icon(
                          product.isFavorite
                              ? Icons.favorite
                              : Icons.favorite_border,
                          size: 16.r,
                          color: AppColorSchemes.grey,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.all(12.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      product.name,
                      style: AppTypography.bodyMedium.copyWith(
                        color: AppColorSchemes.black,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        Text(
                          '\$${product.price.toStringAsFixed(2)}',
                          style: AppTypography.bodyMedium.copyWith(
                            color: AppColorSchemes.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        if (product.originalPrice != null) ...[
                          SizedBox(width: 8.w),
                          Text(
                            '\$${product.originalPrice!.toStringAsFixed(2)}',
                            style: AppTypography.bodyMedium.copyWith(
                              color: AppColorSchemes.grey,
                              fontWeight: FontWeight.w400,
                              decoration: TextDecoration.lineThrough,
                              fontSize: 12.sp,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
