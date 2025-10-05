import 'package:ecommerce_mobile_app/router/route_name.dart';
import 'package:ecommerce_mobile_app/screens/auth/sign_in_screen.dart';
import 'package:ecommerce_mobile_app/screens/auth/sign_up_screen.dart';
import 'package:ecommerce_mobile_app/screens/auth/forgot_password_screen.dart';
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
    GoRoute(
      path: RouteName.signInPath,
      name: RouteName.signInPath,
      builder: (context, state) => const SignInScreen(),
    ),
    GoRoute(
      path: RouteName.signUpPath,
      name: RouteName.signUpPath,
      builder: (context, state) => const SignUpScreen(),
    ),
    GoRoute(
      path: RouteName.forgotPasswordPath,
      name: RouteName.forgotPasswordPath,
      builder: (context, state) => const ForgotPasswordScreen(),
    ),
  ],
);
