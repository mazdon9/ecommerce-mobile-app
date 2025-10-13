import 'package:ecommerce_mobile_app/models/category.dart';
import 'package:ecommerce_mobile_app/screens/categories/category_products_screen.dart';
import 'package:ecommerce_mobile_app/services/product_service.dart';
import 'package:ecommerce_mobile_app/shared/widgets/common_card.dart';
import 'package:ecommerce_mobile_app/shared/widgets/common_image_widget.dart';
import 'package:ecommerce_mobile_app/theme/app_color_scheme.dart';
import 'package:ecommerce_mobile_app/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
          'Shop by Categories',
          style: AppTypography.pageTitle.copyWith(fontSize: 20.sp),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16.w,
            mainAxisSpacing: 16.h,
            childAspectRatio: 1.0,
          ),
          itemCount: ProductService.getAllCategories().length,
          itemBuilder: (context, index) {
            final category = ProductService.getAllCategories()[index];
            return _CategoryCard(
              category: category,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CategoryProductsScreen(
                      categoryName: category.name,
                      categoryId: category.id,
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class _CategoryCard extends StatelessWidget {
  final Category category;
  final VoidCallback? onTap;

  const _CategoryCard({required this.category, this.onTap});

  @override
  Widget build(BuildContext context) {
    return CommonCard(
      onTap: onTap,
      backgroundColor: AppColorSchemes.surface,
      borderRadius: 16.r,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80.w,
            height: 80.h,
            decoration: BoxDecoration(
              color: AppColorSchemes.surface,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: CommonImageWidget(
              imageUrl: category.iconPath,
              width: 80.w,
              height: 80.h,
              isCircular: true,
              fit: BoxFit.cover,
              errorWidget: Container(
                color: AppColorSchemes.primary.withOpacity(0.1),
                child: Icon(
                  Icons.category,
                  size: 40.r,
                  color: AppColorSchemes.primary,
                ),
              ),
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            category.name,
            style: AppTypography.bodyLarge.copyWith(
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 4.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.arrow_forward_ios,
                size: 12.r,
                color: AppColorSchemes.grey,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
