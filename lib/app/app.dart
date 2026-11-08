import 'package:flutter/material.dart';

import '../screens/auth/sign_in_screen.dart';
import '../screens/auth/sign_up_screen.dart';
import '../screens/auth/welcome_screen.dart';
import '../theme/app_theme.dart';
import 'routes.dart';

class MathMashApp extends StatelessWidget {
  const MathMashApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MathMash',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialRoute: AppRoutes.welcome,
      routes: {
        AppRoutes.welcome: (context) => const WelcomeScreen(),
        AppRoutes.signIn: (context) => const SignInScreen(),
        AppRoutes.signUp: (context) => const SignUpScreen(),
      },
    );
  }
}
