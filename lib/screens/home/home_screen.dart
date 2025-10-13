import 'package:ecommerce_mobile_app/screens/categories/categories_screen.dart';
import 'package:ecommerce_mobile_app/screens/categories/category_products_screen.dart';
import 'package:ecommerce_mobile_app/screens/home/widgets/category_item.dart';
import 'package:ecommerce_mobile_app/screens/home/widgets/custom_search_bar.dart';
import 'package:ecommerce_mobile_app/screens/home/widgets/product_card.dart';
import 'package:ecommerce_mobile_app/screens/home/widgets/section_header.dart';
import 'package:ecommerce_mobile_app/services/product_service.dart';
import 'package:ecommerce_mobile_app/theme/app_color_scheme.dart';
import 'package:ecommerce_mobile_app/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorSchemes.background,
      appBar: AppBar(
        backgroundColor: AppColorSchemes.background,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            // User Avatar
            Container(
              width: 40.w,
              height: 40.h,
              decoration: BoxDecoration(
                color: AppColorSchemes.surface,
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColorSchemes.inputBorder,
                  width: 1,
                ),
              ),
              child: Icon(
                Icons.person,
                size: 20.r,
                color: AppColorSchemes.grey,
              ),
            ),
            const Spacer(),
            // Greeting Text
            Text(
              'Man',
              style: AppTypography.pageTitle.copyWith(fontSize: 18.sp),
            ),
            Icon(
              Icons.keyboard_arrow_down,
              color: AppColorSchemes.black,
              size: 20.r,
            ),
            const Spacer(),
            // Shopping Cart
            Container(
              width: 40.w,
              height: 40.h,
              decoration: BoxDecoration(
                color: AppColorSchemes.primary,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.shopping_bag_outlined,
                size: 20.r,
                color: AppColorSchemes.white,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16.h),

            // Search Bar
            CustomSearchBar(
              hintText: 'Search',
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
                // TODO: Implement search logic
              },
              onTap: () {
                // TODO: Handle search tap
              },
            ),

            SizedBox(height: 24.h),

            // Categories Section
            SectionHeader(
              title: 'Categories',
              onActionTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CategoriesScreen(),
                  ),
                );
              },
            ),

            SizedBox(height: 16.h),

            // Categories List
            SizedBox(
              height: 88.h,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: ProductService.getAllCategories().length,
                separatorBuilder: (context, index) => SizedBox(width: 16.w),
                itemBuilder: (context, index) {
                  final category = ProductService.getAllCategories()[index];
                  return CategoryItem(
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

            SizedBox(height: 32.h),

            // Top Selling Section
            SectionHeader(
              title: 'Top Selling',
              onActionTap: () {
                // TODO: Navigate to top selling page
              },
            ),

            SizedBox(height: 16.h),

            // Top Selling Products
            SizedBox(
              height: 250.h,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: ProductService.getTopSellingProducts().length,
                separatorBuilder: (context, index) => SizedBox(width: 16.w),
                itemBuilder: (context, index) {
                  return ProductCard(
                    product: ProductService.getTopSellingProducts()[index],
                    onTap: () {
                      // TODO: Navigate to product detail
                    },
                    onFavoriteTap: () {
                      // Leave empty - No logic for favorite handling
                    },
                  );
                },
              ),
            ),

            SizedBox(height: 32.h),

            // New In Section
            SectionHeader(
              title: 'New In',
              onActionTap: () {
                // TODO: Navigate to new in page
              },
            ),

            SizedBox(height: 16.h),

            // New In Products
            SizedBox(
              height: 250.h,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: ProductService.getNewInProducts().length,
                separatorBuilder: (context, index) => SizedBox(width: 16.w),
                itemBuilder: (context, index) {
                  return ProductCard(
                    product: ProductService.getNewInProducts()[index],
                    onTap: () {
                      // TODO: Navigate to product detail
                    },
                    onFavoriteTap: () {
                      // Leave empty - No logic for favorite handling
                    },
                  );
                },
              ),
            ),

            SizedBox(height: 32.h),
          ],
        ),
      ),
    );
  }
}
