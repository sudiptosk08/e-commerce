import 'package:ecommerce_app/features/view/screens/cart/cart_page.dart';
import 'package:flutter/material.dart';
import '../../../../utils/colors/app_colors.dart';

class FloatingActionBottom extends StatelessWidget {
  const FloatingActionBottom({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CartPage(),
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
