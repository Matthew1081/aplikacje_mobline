import 'dart:async';
import 'package:flutter/material.dart';
import '../../utils/my_colors.dart';

class CirclesLoading extends StatefulWidget {
  const CirclesLoading({super.key});

  @override
  State<CirclesLoading> createState() => _CirclesLoadingState();
}

class _CirclesLoadingState extends State<CirclesLoading> {
  late Timer _timer;

  // Rozmiary okręgów
  double _topLeftCircleSize = 400;
  double _topRightCircleSize = 300;
  double _bottomLeftCircleSize = 300;
  double _bottomRightCircleSize = 400;

  // Kolory okręgów
  Color _topLeftCircleColor = MyColors.pinkColor;
  Color _topRightCircleColor = MyColors.purpleColor;
  Color _bottomLeftCircleColor = MyColors.purpleColor;
  Color _bottomRightCircleColor = MyColors.pinkColor;

  int _cycleCount = 0; // Licznik cykli dla zmiany kolorów

  @override
  void initState() {
    super.initState();
    _startAnimation();
  }

  void _startAnimation() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      setState(() {
        // Góra: Zmiana rozmiarów między okręgami
        if (_topLeftCircleSize == 400) {
          _topLeftCircleSize = 300;
          _topRightCircleSize = 400;
        } else {
          _topLeftCircleSize = 400;
          _topRightCircleSize = 300;
        }

        // Dół: Zmiana rozmiarów między okręgami
        if (_bottomLeftCircleSize == 300) {
          _bottomLeftCircleSize = 400;
          _bottomRightCircleSize = 300;
        } else {
          _bottomLeftCircleSize = 300;
          _bottomRightCircleSize = 400;
        }

        // Zmiana kolorów po każdym 4. cyklu
        _cycleCount++;
        if (_cycleCount % 3 == 0) {
          final tempTopLeftColor = _topLeftCircleColor;
          final tempBottomLeftColor = _bottomLeftCircleColor;

          _topLeftCircleColor = _topRightCircleColor;
          _topRightCircleColor = tempTopLeftColor;

          _bottomLeftCircleColor = _bottomRightCircleColor;
          _bottomRightCircleColor = tempBottomLeftColor;
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Górny lewy okrąg
        Positioned(
          top: -200,
          left: -120,
          child: AnimatedContainer(
            duration: const Duration(seconds: 4),
            width: _topLeftCircleSize,
            height: _topLeftCircleSize,
            decoration: BoxDecoration(
              color: _topLeftCircleColor,
              shape: BoxShape.circle,
            ),
          ),
        ),
        // Górny prawy okrąg
        Positioned(
          top: -200,
          right: -120,
          child: AnimatedContainer(
            duration: const Duration(seconds: 4),
            width: _topRightCircleSize,
            height: _topRightCircleSize,
            decoration: BoxDecoration(
              color: _topRightCircleColor,
              shape: BoxShape.circle,
            ),
          ),
        ),
        // Dolny lewy okrąg
        Positioned(
          bottom: -250,
          left: -50,
          child: AnimatedContainer(
            duration: const Duration(seconds: 4),
            width: _bottomLeftCircleSize,
            height: _bottomLeftCircleSize,
            decoration: BoxDecoration(
              color: _bottomLeftCircleColor,
              shape: BoxShape.circle,
            ),
          ),
        ),
        // Dolny prawy okrąg
        Positioned(
          bottom: -200,
          right: -170,
          child: AnimatedContainer(
            duration: const Duration(seconds: 4),
            width: _bottomRightCircleSize,
            height: _bottomRightCircleSize,
            decoration: BoxDecoration(
              color: _bottomRightCircleColor,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ],
    );
  }
}
