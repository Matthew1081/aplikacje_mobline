import 'package:flutter/material.dart';
import '../utils/my_colors.dart';

class CustomHeader extends StatelessWidget {
  final String title;

  const CustomHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: MyColors.purpleColor,
      ),
    );
  }
}
