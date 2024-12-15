import 'package:flutter/material.dart';
import '../../utils/my_colors.dart';

class SignInLink extends StatelessWidget {
  const SignInLink({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: RichText(
          text:  TextSpan(
            text: "Already have an account? ",
            style: TextStyle(color: MyColors.blackColor, fontSize: 14),
            children: [
              TextSpan(
                text: "Sign In",
                style: TextStyle(
                  color: MyColors.purpleColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
