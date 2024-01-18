import 'package:ecommerce_app/utils/text_styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../utils/colors/app_colors.dart';

// ignore: must_be_immutable
class SearchTextField extends StatefulWidget {
  SearchTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.callbackFunction,
    this.onTap,
    required this.readOnly,
  }) : super(key: key);
  final String hintText;
  final bool readOnly;
  TextEditingController controller = TextEditingController();
  final Function(String value)? callbackFunction;
  final Function()? onTap;

  @override
  State<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        right: 10,
        left: 10,
      ),
      margin: EdgeInsets.only(top: 5),
      child: TextFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please FillUp';
          }
          return null;
        },
        readOnly: widget.readOnly,
        controller: widget.controller,
        onChanged: (val) {
          if (widget.callbackFunction != null) widget.callbackFunction!(val);
        },
        onTap: widget.readOnly
            ? () {
                widget.onTap!();
              }
            : null,
        textAlignVertical: TextAlignVertical.top,
        decoration: InputDecoration(
          prefixIcon: SvgPicture.asset(
            "assets/svg/search.svg",
            fit: BoxFit.contain,
          ),
          prefixIconConstraints: BoxConstraints.tight(const Size(45, 20)),
          hintText: widget.hintText,
          hintStyle: TextStyles.bodyText2
              .copyWith(color: KColor.textgrey, fontSize: 13, height: 2.5),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20.0,
          ),
          border: const UnderlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(22.0)),
            borderSide: BorderSide.none,
          ),
          fillColor: KColor.white,
          filled: true,
          floatingLabelBehavior: FloatingLabelBehavior.always,
        ),
      ),
    );
  }
}
