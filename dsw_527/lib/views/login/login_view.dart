import 'package:dsw_527/utils/my_images.dart';
import 'package:flutter/material.dart';

import '../../utils/my_colors.dart';
import '../register/register_view.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              const SizedBox(height: 62),
              Image.asset(MyImages.logo),
              Text('Sing in',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w700,
                color: MyColors.purpleColor
              ),),



              ElevatedButton(
                child: const Text('Sing up'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RegisterView()),
                  );
                },
              ),
              GestureDetector(
                onTap: () {
                  print('xxx');
                },
                  child: const Text(
                'Sing Up',
                style: TextStyle(fontSize: 20),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
