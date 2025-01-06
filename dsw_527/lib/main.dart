import 'package:dsw_527/views/login/login_view.dart';
import 'package:flutter/material.dart';
import 'package:dsw_527/views/loading/loading_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My App',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const LoadingScreen(), // Start z LoadingScreen
    );
  }
}
