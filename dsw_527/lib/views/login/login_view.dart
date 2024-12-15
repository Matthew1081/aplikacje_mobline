import 'package:flutter/material.dart';
import 'package:dsw_527/databse/database_helper.dart';
import '../../utils/my_images.dart';
import '../../utils/my_colors.dart';
import '../../widgets/header_section.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/submit_button.dart';
import '../../widgets/forgot_password_link.dart';
import '../../widgets/sign_up_link.dart';
import '../homeview/home_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final _emailOrUsernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _dbHelper = DatabaseHelper();
  bool _obscureText = true;

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      final emailOrUsername = _emailOrUsernameController.text.trim();
      final password = _passwordController.text.trim();

      final user = await _dbHelper.getUser(emailOrUsername, password);
      if (user != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login Successful!')),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeView()),
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

                  // Nagłówek z logo
                  const  HeaderSection(
                      title: "Sign In",
                      showLogo: true,
                      alignTitleLeft: true,
                    ),

                  const SizedBox(height: 40),

                  // Email lub Username
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

                  // Password
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

                  // Link do "Forgot Password"
                  const ForgotPasswordLink(),
                  const SizedBox(height: 40),

                  // Przycisk Sign In
                  SubmitButton(
                    label: "Sign In",
                    onPressed: _login,
                  ),
                  const SizedBox(height: 40),

                  // Link do rejestracji
                  const Center(
                    child: SignUpLink(),
                  ),
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
