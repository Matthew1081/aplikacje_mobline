import 'package:flutter/material.dart';
import '../../utils/my_colors.dart';

class DecorativeCircles extends StatelessWidget {
  const DecorativeCircles({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Duży okrąg (ciemniejszy)
        Positioned(
          top: -110,
          right: -60,
          child: Container(
            width: 150,
            height: 150,
            decoration:  BoxDecoration(
              color: MyColors.purpleColor, // Ciemniejszy okrąg
              shape: BoxShape.circle,
            ),
          ),
        ),
        // Mały okrąg (jaśniejszy)
        Positioned(
          top: -20,
          right: -60,
          child: Container(
            width: 100,
            height: 100,
            decoration:  BoxDecoration(
              color: MyColors.pinkColor, // Jaśniejszy okrąg
              shape: BoxShape.circle,
            ),
          ),
        ),
      ],
    );
  }
}
