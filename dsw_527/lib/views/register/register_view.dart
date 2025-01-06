import 'package:flutter/material.dart';
import '../../databse/database_helper.dart';
import '../../utils/my_colors.dart';
import '../../widgets/custom_back_button.dart';
import '../../widgets/custom_header.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/custom_password_field.dart';
import '../../widgets/submit_button.dart';
import '../../widgets/sign_in_link.dart';
import '../../widgets/decorative_circles.dart'; // Import widgetu DecorativeCircles

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _dbHelper = DatabaseHelper();

  Future<void> _register() async {
    if (_formKey.currentState!.validate()) {
      final emailExists = await _dbHelper.emailExists(_emailController.text.trim());
      if (emailExists) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Email already exists!')),
        );
        return;
      }

      await _dbHelper.insertUser(
        _fullNameController.text.trim(),
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registration Successful!')),
      );

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            const DecorativeCircles(), // Dodanie dekoracyjnych okręgów w tle
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 30),
                      CustomBackButton(onTap: () => Navigator.pop(context)),
                      const SizedBox(height: 80),
                      const CustomHeader(title: "Sign Up"),
                      const SizedBox(height: 30),
                      CustomTextField(
                        controller: _fullNameController,
                        hintText: "Full Name",
                        prefixImage: 'assets/images/person.png',
                        validator: (value) =>
                        value!.isEmpty ? 'Full Name cannot be empty' : null,
                      ),
                      const SizedBox(height: 20),
                      CustomTextField(
                        controller: _emailController,
                        hintText: "Email",
                        prefixImage: 'assets/images/mail.png',
                        validator: (value) {
                          if (value!.isEmpty) return 'Email cannot be empty';
                          if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
                              .hasMatch(value)) {
                            return 'Enter a valid email';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      CustomPasswordField(
                        controller: _passwordController,
                        hintText: "Password",
                        validator: (value) {
                          if (value!.isEmpty) return 'Password cannot be empty';
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      CustomPasswordField(
                        controller: _confirmPasswordController,
                        hintText: "Confirm Password",
                        validator: (value) {
                          if (value != _passwordController.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 30),
                      SubmitButton(label: "Sign Up", onPressed: _register),
                      const SizedBox(height: 80),
                      const SignInLink(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
