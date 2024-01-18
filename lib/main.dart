import 'dart:io';

import 'package:ecommerce_app/constant/logger.dart';
import 'package:ecommerce_app/constant/navigation_service.dart';
import 'package:ecommerce_app/constant/shared_preference_constant.dart';
import 'package:ecommerce_app/features/view/screens/home/controller/banner_list_controller.dart';
import 'package:ecommerce_app/features/view/screens/home/controller/brand_list_controller.dart';
import 'package:ecommerce_app/features/view/screens/shop/controller/product_list_controller.dart';
import 'package:ecommerce_app/features/view/screens/splash_screen/splash_screen.dart';
import 'package:ecommerce_app/utils/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nb_utils/nb_utils.dart';

import 'network_utils/network_utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  HttpOverrides.global = MyHttpOverrides();
  await initialize();

  runApp(ProviderScope(observers: [Logger()], child: const MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  bool checkLogin = getBoolAsync(isLoggedIn, defaultValue: false);

  @override
  void initState() {
    super.initState();
    initData();
  }

  initData() {
    ref.read(productListProvider.notifier).fetchShopProductList();
    ref.read(brandProvider.notifier).fetchBrand();
    ref.read(sliderProvider.notifier).fetchSliderDetails();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: NavigationService.navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'E-Commerce',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 0,
          backgroundColor: KColor.background,
          iconTheme: IconThemeData(color: KColor.black),
        ),
      ),
      home: SplashScreen(), // 
      //
    );
  }
}
