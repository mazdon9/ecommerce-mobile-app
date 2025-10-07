import 'package:ecommerce_mobile_app/screens/home/home_screen.dart';
import 'package:ecommerce_mobile_app/screens/notifications/notifications_screen.dart';
import 'package:ecommerce_mobile_app/screens/orders/orders_screen.dart';
import 'package:ecommerce_mobile_app/screens/profile/profile_screen.dart';
import 'package:ecommerce_mobile_app/theme/app_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [HomeScreen(), NotificationsScreen(), OrdersScreen(), ProfileScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorSchemes.background,
      body: IndexedStack(index: _currentIndex, children: _screens),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppColorSchemes.white,
          boxShadow: [BoxShadow(color: AppColorSchemes.black.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, -2))],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.transparent,
          elevation: 0,
          selectedItemColor: AppColorSchemes.primary,
          unselectedItemColor: AppColorSchemes.grey,
          selectedFontSize: 12.sp,
          unselectedFontSize: 12.sp,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined, size: 24.w),
              activeIcon: Icon(Icons.home, size: 24.w),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications_outlined, size: 24.w),
              activeIcon: Icon(Icons.notifications, size: 24.w),
              label: 'Notifications',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.receipt_long_outlined, size: 24.w),
              activeIcon: Icon(Icons.receipt_long, size: 24.w),
              label: 'Orders',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline, size: 24.w),
              activeIcon: Icon(Icons.person, size: 24.w),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
