import 'package:ecommerce_mobile_app/models/product.dart';
import 'package:ecommerce_mobile_app/shared/widgets/common_card.dart';
import 'package:ecommerce_mobile_app/shared/widgets/common_image_widget.dart';
import 'package:ecommerce_mobile_app/theme/app_color_scheme.dart';
import 'package:ecommerce_mobile_app/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback? onTap;
  final VoidCallback? onFavoriteTap;

  const ProductCard({
    super.key,
    required this.product,
    this.onTap,
    this.onFavoriteTap,
  });

  @override
  Widget build(BuildContext context) {
    return CommonCard(
      onTap: onTap,
      padding: EdgeInsets.zero,
      borderRadius: 16.r,
      backgroundColor: AppColorSchemes.white,
      child: SizedBox(
        width: 160.w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            Stack(
              children: [
                CommonImageWidget(
                  imageUrl: product.imageUrl,
                  width: double.infinity,
                  height: 160.h,
                  borderRadius: 16.r,
                  fit: BoxFit.cover,
                  errorWidget: Container(
                    color: AppColorSchemes.surface,
                    child: Icon(
                      Icons.image,
                      size: 48.r,
                      color: AppColorSchemes.grey,
                    ),
                  ),
                ),
                // Favorite Button
                Positioned(
                  top: 12.h,
                  right: 12.w,
                  child: _FavoriteButton(
                    isFavorite: product.isFavorite,
                    onTap: onFavoriteTap,
                  ),
                ),
              ],
            ),
            // Product Info
            Padding(
              padding: EdgeInsets.all(12.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: AppTypography.textFont14W500,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4.h),
                  _PriceWidget(
                    price: product.price,
                    originalPrice: product.originalPrice,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FavoriteButton extends StatelessWidget {
  final bool isFavorite;
  final VoidCallback? onTap;

  const _FavoriteButton({required this.isFavorite, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 32.w,
        height: 32.h,
        decoration: BoxDecoration(
          color: AppColorSchemes.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: AppColorSchemes.black.withOpacity(0.1),
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

class _PriceWidget extends StatelessWidget {
  final double price;
  final double? originalPrice;

  const _PriceWidget({required this.price, this.originalPrice});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '\$${price.toStringAsFixed(2)}',
          style: AppTypography.textFont16W600.copyWith(
            color: AppColorSchemes.black,
          ),
        ),
        if (originalPrice != null && originalPrice! > price) ...[
          SizedBox(width: 8.w),
          Text(
            '\$${originalPrice!.toStringAsFixed(2)}',
            style: AppTypography.textFont14W500.copyWith(
              color: AppColorSchemes.grey,
              decoration: TextDecoration.lineThrough,
            ),
          ),
        ],
      ],
    );
  }
}
