import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
final TextEditingController controller;
final String lableText;
final String hintText;
final Widget? suffixIcon;
final Widget? prefixIcon;
final Widget? prefix;
final String  validatorText;
final double borderRadius;
final bool obscureText;
final String? Function(String?)? validator;

 CustomTextFormField({
  required this.controller,
  required this.hintText,
   required this.lableText,
   this.suffixIcon,
   this.prefixIcon,
   this.prefix,
   required this.validatorText,
   this.borderRadius = 10,
   this.obscureText = false,
  this.validator,
 });

  @override
  Widget build(BuildContext context) {
    return TextFormField(

      controller: controller,
    //  onTap: ,
      decoration: InputDecoration(
        labelText: lableText,
        prefix: prefix,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
        hintText: hintText,
border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(borderRadius)))
      ),
      obscureText: obscureText,
      validator: validator,

    );
  }
}
