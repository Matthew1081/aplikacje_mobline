import 'package:flutter/material.dart';
import '../../utils/my_colors.dart';
import '../views/forget_password/forget_password.dart';

class ForgotPasswordLink extends StatelessWidget {
  const ForgotPasswordLink({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ForgotPasswordView(),
            ),
          );
        },
        child: Text(
          'Forget Password?',
          style: TextStyle(
            fontSize: 16,
            color: MyColors.purpleColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
