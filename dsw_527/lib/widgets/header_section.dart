import 'package:flutter/material.dart';
import '../utils/my_colors.dart';
import '../utils/my_images.dart';

class HeaderSection extends StatelessWidget {
  final String title;
  final bool showLogo;
  final double logoSize;
  final double spacing;
  final bool alignTitleLeft; // Nowy parametr dla wyrównania tytułu

  const HeaderSection({
    super.key,
    required this.title,
    this.showLogo = true,
    this.logoSize = 129.0, // Domyślny rozmiar logo
    this.spacing = 20.0,  // Domyślny odstęp między logo a tytułem
    this.alignTitleLeft = false, // Domyślnie tytuł jest wyśrodkowany
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (showLogo)
          Center(
            child: Image.asset(
              MyImages.logo,
              width: logoSize,
              height: logoSize,
              fit: BoxFit.contain,
            ),
          ),
        SizedBox(height: spacing),
        Align(
          alignment: alignTitleLeft ? Alignment.centerLeft : Alignment.center, // Kontrola wyrównania
          child: Text(
            title,
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: MyColors.purpleColor,
            ),
          ),
        ),
      ],
    );
  }
}
