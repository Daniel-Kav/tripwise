import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:billiard_champ/src/features/auth/presentation/splash_screen.dart';
import 'package:billiard_champ/src/features/auth/presentation/login_screen.dart';
import 'package:billiard_champ/src/features/auth/presentation/signup_screen.dart';
import 'package:billiard_champ/src/features/auth/presentation/otp_verification_screen.dart';
import 'package:billiard_champ/src/features/home/presentation/home_screen.dart';
import 'package:billiard_champ/src/core/theme/app_theme.dart';

class BilliardChampApp extends StatelessWidget {
  const BilliardChampApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Billiard Champ',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      routerConfig: _router,
    );
  }
}

// Define routes using GoRouter
final _router = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(
      path: '/splash',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/signup',
      builder: (context, state) => const SignupScreen(),
    ),
    GoRoute(
      path: '/otp-verification',
      builder: (context, state) => const OtpVerificationScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomeScreen(),
    ),
  ],
);
