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
    final List<Product> products = ProductService.getProductsByCategory(
      categoryName,
    );

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
          ? _EmptyState(categoryName: categoryName)
          : Padding(
              padding: EdgeInsets.all(16.w),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12.w,
                  mainAxisSpacing: 16.h,
                  childAspectRatio: 0.75,
                ),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return _ProductCard(
                    product: products[index],
                    onTap: () {
                      // TODO: Navigate to product details
                    },
                    onFavoritePressed: () {
                      // TODO: Handle favorite toggle - Leave empty as requested
                    },
                  );
                },
              ),
            ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  final String categoryName;

  const _EmptyState({required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_bag_outlined,
            size: 64.r,
            color: AppColorSchemes.grey,
          ),
          SizedBox(height: 16.h),
          Text(
            'No products found',
            style: AppTypography.bodyLarge.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColorSchemes.black,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'We don\'t have any products in $categoryName yet.',
            style: AppTypography.bodyMedium.copyWith(
              color: AppColorSchemes.grey,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
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
    return CommonCard(
      onTap: onTap,
      padding: EdgeInsets.zero,
      backgroundColor: AppColorSchemes.surface,
      borderRadius: 12.r,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Stack(
              children: [
                CommonImageWidget(
                  imageUrl: product.imageUrl,
                  width: double.infinity,
                  height: double.infinity,
                  borderRadius: 12.r,
                  fit: BoxFit.cover,
                  errorWidget: Container(
                    color: AppColorSchemes.background,
                    child: Icon(
                      Icons.image_not_supported_outlined,
                      size: 32.r,
                      color: AppColorSchemes.grey,
                    ),
                  ),
                ),
                Positioned(
                  top: 8.h,
                  right: 8.w,
                  child: _FavoriteButton(
                    isFavorite: product.isFavorite,
                    onPressed: onFavoritePressed,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: EdgeInsets.all(8.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    product.name,
                    style: AppTypography.bodyMedium.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  _PriceSection(
                    price: product.price,
                    originalPrice: product.originalPrice,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FavoriteButton extends StatelessWidget {
  final bool isFavorite;
  final VoidCallback? onPressed;

  const _FavoriteButton({required this.isFavorite, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
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
          isFavorite ? Icons.favorite : Icons.favorite_border,
          size: 16.r,
          color: AppColorSchemes.grey,
        ),
      ),
    );
  }
}

class _PriceSection extends StatelessWidget {
  final double price;
  final double? originalPrice;

  const _PriceSection({required this.price, this.originalPrice});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '\$${price.toStringAsFixed(2)}',
          style: AppTypography.bodyMedium.copyWith(
            fontWeight: FontWeight.w700,
            color: AppColorSchemes.black,
          ),
        ),
        if (originalPrice != null && originalPrice! > price) ...[
          SizedBox(height: 2.h),
          Text(
            '\$${originalPrice!.toStringAsFixed(2)}',
            style: AppTypography.bodyMedium.copyWith(
              color: AppColorSchemes.grey,
              decoration: TextDecoration.lineThrough,
            ),
          ),
        ],
      ],
    );
  }
}
