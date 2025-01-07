import 'package:flutter/material.dart';
import '../../utils/my_colors.dart';

class CirclesLoading extends StatefulWidget {
  const CirclesLoading({super.key});

  @override
  State<CirclesLoading> createState() => _CirclesLoadingState();
}

class _CirclesLoadingState extends State<CirclesLoading>
    with TickerProviderStateMixin {
  late AnimationController _sizeController;
  late AnimationController _colorController;

  // Animacje rozmiarów
  late Animation<double> _sizeTopLeft;
  late Animation<double> _sizeTopRight;
  late Animation<double> _sizeBottomLeft;
  late Animation<double> _sizeBottomRight;

  // Animacje kolorów
  late Animation<Color?> _colorTopLeft;
  late Animation<Color?> _colorTopRight;
  late Animation<Color?> _colorBottomLeft;
  late Animation<Color?> _colorBottomRight;

  @override
  void initState() {
    super.initState();

    // Kontroler dla rozmiarów (szybsza animacja)
    _sizeController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4), // Animacja rozmiaru co 4 sekundy
    )..repeat(reverse: true); // Pętla w przód i w tył

    // Kontroler dla kolorów (wolniejsza animacja)
    _colorController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10), // Animacja koloru co 10 sekund
    )..repeat(reverse: true); // Pętla w przód i w tył

    // Animacje rozmiarów
    _sizeTopLeft = Tween<double>(begin: 300, end: 400).animate(
      CurvedAnimation(parent: _sizeController, curve: Curves.easeInOut),
    );
    _sizeTopRight = Tween<double>(begin: 400, end: 300).animate(
      CurvedAnimation(parent: _sizeController, curve: Curves.easeInOut),
    );
    _sizeBottomLeft = Tween<double>(begin: 400, end: 300).animate(
      CurvedAnimation(parent: _sizeController, curve: Curves.easeInOut),
    );
    _sizeBottomRight = Tween<double>(begin: 300, end: 400).animate(
      CurvedAnimation(parent: _sizeController, curve: Curves.easeInOut),
    );

    // Animacje kolorów
    _colorTopLeft = ColorTween(begin: MyColors.pinkColor, end: MyColors.purpleColor).animate(
      CurvedAnimation(parent: _colorController, curve: Curves.easeInOut),
    );
    _colorTopRight = ColorTween(begin: MyColors.purpleColor, end: MyColors.pinkColor).animate(
      CurvedAnimation(parent: _colorController, curve: Curves.easeInOut),
    );
    _colorBottomLeft = ColorTween(begin: MyColors.purpleColor, end: MyColors.pinkColor).animate(
      CurvedAnimation(parent: _colorController, curve: Curves.easeInOut),
    );
    _colorBottomRight = ColorTween(begin: MyColors.pinkColor, end: MyColors.purpleColor).animate(
      CurvedAnimation(parent: _colorController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _sizeController.dispose();
    _colorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([_sizeController, _colorController]),
      builder: (context, child) {
        return Stack(
          children: [
            // Górny lewy okrąg
            Positioned(
              top: -200,
              left: -120,
              child: Container(
                width: _sizeTopLeft.value,
                height: _sizeTopLeft.value,
                decoration: BoxDecoration(
                  color: _colorTopLeft.value,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            // Górny prawy okrąg
            Positioned(
              top: -200,
              right: -120,
              child: Container(
                width: _sizeTopRight.value,
                height: _sizeTopRight.value,
                decoration: BoxDecoration(
                  color: _colorTopRight.value,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            // Dolny lewy okrąg
            Positioned(
              bottom: -250,
              left: -50,
              child: Container(
                width: _sizeBottomLeft.value,
                height: _sizeBottomLeft.value,
                decoration: BoxDecoration(
                  color: _colorBottomLeft.value,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            // Dolny prawy okrąg
            Positioned(
              bottom: -200,
              right: -170,
              child: Container(
                width: _sizeBottomRight.value,
                height: _sizeBottomRight.value,
                decoration: BoxDecoration(
                  color: _colorBottomRight.value,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

