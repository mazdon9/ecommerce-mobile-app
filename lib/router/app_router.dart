import 'package:ecommerce_mobile_app/router/route_name.dart';
import 'package:ecommerce_mobile_app/screens/splash/splash_screen.dart';
import 'package:go_router/go_router.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: RouteName.splashPath,
  routes: [
    GoRoute(
      path: RouteName.splashPath,
      name: RouteName.splashPath,
      builder: (context, state) => const SplashScreen(),
    ),
    // GoRoute(
    //   path: RouteName.onboardingPath,
    //   name: RouteName.onboardingName,
    //   builder: (context, state) => const OnboardingScreen(),
    // ),
    // GoRoute(
    //   path: RouteName.loginPath,
    //   name: RouteName.loginName,
    //   builder: (context, state) => const LoginScreen(),
    // ),
  ],
);
