import 'package:flutter/material.dart';
import '../utils/my_colors.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String? prefixImage;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final bool isObscure;
  final String? Function(String?)? validator;
  final double verticalSpacing;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.prefixImage,
    this.prefixIcon,
    this.suffixIcon,
    this.isObscure = false,
    this.validator,
    this.verticalSpacing = 20.0, // Domyślny odstęp między polami
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: verticalSpacing),
      child: TextFormField(
        controller: controller,
        obscureText: isObscure,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey.shade400),
          prefixIcon: prefixImage != null
              ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(prefixImage!),
          )
              : (prefixIcon != null ? Icon(prefixIcon, color: MyColors.purpleColor) : null),
          suffixIcon: suffixIcon,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(color: MyColors.borderColor, width: 2.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(color: MyColors.borderColor, width: 2.0),
          ),
        ),
        validator: validator,
      ),
    );
  }
}
