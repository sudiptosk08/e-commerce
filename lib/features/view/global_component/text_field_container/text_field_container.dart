import 'package:flutter/material.dart';
import '../../../../utils/colors/app_colors.dart';

class TextFieldContainer extends StatelessWidget {
  const TextFieldContainer({
    super.key,
    this.label,
    required this.hint,
    this.keyboardType ,
    required this.controller,
    this.obscureText = false,
    this.suffixIcon,
    this.padding = 12,
    this.radius = 12,
    this.onValidate,
  });

  final String? label;
  final String hint;
  final TextInputType? keyboardType;
  final TextEditingController controller;
  final bool obscureText;
  final Widget? suffixIcon;
  final double padding;
  final double radius;

  final Function? onValidate;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: KColor.white,
      ),
      
      margin: EdgeInsets.symmetric(horizontal: padding),
      child: TextFormField(
        obscureText: obscureText,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          labelText: label,
          labelStyle: TextStyle(color: KColor.black54),
          //labelStyle: ,//TextStyles.lightRubik16Gray94,
          hintText: hint,
          //hintStyle: TextStyles.lightRubik16Gray94,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 1,
              color: KColor.black54.withOpacity(0.25),
            ),
            borderRadius: BorderRadius.circular(radius),
          ),
          
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 1,
              color: KColor.black54.withOpacity(0.25),
            ),
            borderRadius: BorderRadius.circular(radius),
          ),
        ),
        controller: controller,
        autovalidateMode: AutovalidateMode.onUserInteraction,
      ),
    );
  }
}
