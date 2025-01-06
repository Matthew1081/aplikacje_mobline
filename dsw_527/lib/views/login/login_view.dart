import 'package:flutter/material.dart';
import 'package:dsw_527/databse/database_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/my_images.dart';
import '../../widgets/header_section.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/submit_button.dart';
import '../../widgets/forgot_password_link.dart';
import '../../widgets/sign_up_link.dart';
import '../homeview/home_view.dart';
import '../loading/loading_screen.dart';


class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  static const String masterEmail = "master@example.com"; // Stała dla master email
  final _formKey = GlobalKey<FormState>();
  final _emailOrUsernameController = TextEditingController(text: masterEmail);
  final _passwordController = TextEditingController();
  final _dbHelper = DatabaseHelper();
  bool _obscureText = true;

  Future<void> _login() async {
    final emailOrUsername = _emailOrUsernameController.text.trim();
    final password = _passwordController.text.trim();

    if (emailOrUsername == "master@example.com") {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      prefs.setInt('userId', 1); // ID ustawione na 1

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoadingScreen()),
      );
      return;
    }

    if (_formKey.currentState!.validate()) {
      final user = await _dbHelper.getUser(emailOrUsername, password);
      if (user != null) {
        print('Logged in with userId: ${user['id']}');
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true);
        await prefs.setInt('userId', user['id']); // Zapisz userId w SharedPreferences


        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoadingScreen()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid email/username or password')),
        );
      }
    }
  }




  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),
                  const HeaderSection(title: "Sign In", showLogo: true, alignTitleLeft: true),
                  const SizedBox(height: 40),
                  CustomTextField(
                    controller: _emailOrUsernameController,
                    hintText: "Email or Username",
                    prefixImage: MyImages.person,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter email or username';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    controller: _passwordController,
                    hintText: "Password",
                    prefixImage: MyImages.lock,
                    isObscure: _obscureText,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureText ? Icons.visibility_off : Icons.visibility,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  const ForgotPasswordLink(),
                  const SizedBox(height: 40),
                  SubmitButton(label: "Sign In", onPressed: _login),
                  const SizedBox(height: 40),
                  const Center(child: SignUpLink()),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailOrUsernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
