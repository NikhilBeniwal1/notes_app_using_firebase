import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
 final TextEditingController controller;
 final String labelText;
 final bool showOutlineborder;
 final double  borderRadius;
 final Widget? suffixIcon;
 final Widget? prefixIcon;
  CustomTextField({
    required this.controller,
    required this.labelText,
    this.showOutlineborder = true,
    this.borderRadius = 12,
    this.prefixIcon,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
          labelText: labelText,
        suffix: suffixIcon,
        prefix: prefixIcon,
        border: showOutlineborder ? OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(borderRadius))
        ) : null

      ),

    );
  }
}
