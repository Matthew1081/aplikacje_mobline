import 'package:flutter/material.dart';
import '../utils/my_colors.dart';
import '../utils/my_images.dart';

class CustomBackButton extends StatelessWidget {
  final VoidCallback onTap;

  const CustomBackButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Image.asset(MyImages.back, width: 20, height: 20),
          const SizedBox(width: 5),
          Text(
            "Back",
            style: TextStyle(
              color: MyColors.purpleColor,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
