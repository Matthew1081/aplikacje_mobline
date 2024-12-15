import 'package:flutter/material.dart';
import '../views/register/register_view.dart';
import '../../utils/my_colors.dart';

class SignUpLink extends StatelessWidget {
  const SignUpLink({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const RegisterView(),
            ),
          );
        },
        child: Text(
          "Don't have an account? Sign up",
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
