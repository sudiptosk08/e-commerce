import 'package:flutter/material.dart';

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
    return Padding(
      padding: const EdgeInsets.only(right: 10, left: 10),
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
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          prefixIcon: const Padding(
            padding: EdgeInsets.all(14.0),
            child: Icon(
              Icons.search,
              color: KColor.black,
            ),
          ),
          hintText: widget.hintText,
          hintStyle:const TextStyle(color: KColor.textgrey),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12),
          border: const UnderlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
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
