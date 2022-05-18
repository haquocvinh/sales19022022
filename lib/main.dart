import 'package:flutter/material.dart';
import 'package:phanam/common/app_constant.dart';
import 'package:phanam/presentation/features/cart/cart_screen.dart';
import 'package:phanam/presentation/features/login/login_screen.dart';
import 'package:phanam/presentation/features/product/product_screen.dart';
import 'package:phanam/presentation/features/sign_up/sign_up_screen.dart';
import 'package:phanam/presentation/features/splash/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Pha Nam's eCommerce - Version 1.0",
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      routes: {
        AppConstant.splashRouteName: (context) => const SplashScreen(),
        AppConstant.loginRouteName: (context) => const LoginScreen(),
        AppConstant.signupRouteName: (context) => const SignUpScreen(),
        AppConstant.productRouteName: (context) => const ProductScreen(),
        AppConstant.cartRouteName: (context) => const CartScreen(),
      },
      initialRoute: AppConstant.splashRouteName,
    );
  }
}
