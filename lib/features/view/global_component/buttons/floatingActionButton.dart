// ignore_for_file: must_be_immutable, file_names

import 'package:ecommerce_app/constant/shared_preference_constant.dart';
import 'package:ecommerce_app/features/view/screens/auth/login/login_page.dart';
import 'package:ecommerce_app/features/view/screens/cart/cart_page.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../../../utils/colors/app_colors.dart';

class FloatingActionBottom extends StatelessWidget {
  FloatingActionBottom({super.key});
  bool checkLogin = getBoolAsync(isLoggedIn, defaultValue: false);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      checkLogin ? const CartPage() : const LoginPage(),
                ));
          },
          child: Container(
            padding: const EdgeInsets.all((3.3)),
            height: 50,
            width: 50,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: KColor.primary,
                border: Border.all(color: KColor.white, width: 1.5)),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Image.asset(
                'assets/images/cart.png',
                color: KColor.white,
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
