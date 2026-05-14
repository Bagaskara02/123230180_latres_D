import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'models/cart_item_model.dart';
import 'controllers/auth_controller.dart';
import 'controllers/product_controller.dart';
import 'controllers/cart_controller.dart';
import 'pages/login_page.dart';
import 'pages/main_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  await Hive.initFlutter();
  Hive.registerAdapter(CartItemAdapter());
  await Hive.openBox<CartItem>('cartBox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize controllers
    final authController = Get.put(AuthController());
    Get.put(ProductController());
    Get.put(CartController());

    return GetMaterialApp(
      title: 'Toko Online',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Roboto',
        appBarTheme: const AppBarTheme(
          centerTitle: true,
        ),
      ),
      home: Obx(() {
        // Show loading while checking session
        if (authController.isLoading.value) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(color: Color(0xFF5B8DEF)),
            ),
          );
        }
        // Navigate based on login state
        if (authController.isLoggedIn.value) {
          return const MainPage();
        }
        return const LoginPage();
      }),
    );
  }
}
