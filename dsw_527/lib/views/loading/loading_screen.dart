import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/my_colors.dart';
import '../../utils/my_images.dart';
import '../homeview/home_view.dart';
import '../login/login_view.dart';
import '../../widgets/circles_loading.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  int? userIdFromDatabase;

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();

    // Sprawdź, czy użytkownik jest zalogowany
    final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    if (isLoggedIn) {
      // Pobierz `userId` z SharedPreferences
      userIdFromDatabase = prefs.getInt('userId');
      print('User ID from database: $userIdFromDatabase');
    }

    // Poczekaj 2 sekundy
    await Future.delayed(const Duration(seconds: 10));

    // Przejdź do odpowiedniego ekranu
    if (mounted) {
      if (isLoggedIn && userIdFromDatabase != null) {
        print('Navigating to HomeView with userId: $userIdFromDatabase');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomeView(userId: userIdFromDatabase!),
          ),
        );
      } else {
        print('Navigating to LoginView');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginView(),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const CirclesLoading(), // Dekoracyjne okręgi
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  MyImages.logo_bg,
                  width: 200, // Szerokość logo
                  height: 200, // Wysokość logo
                ),
                const SizedBox(height: 20),
                const CircularProgressIndicator(), // Indykator ładowania
              ],
            ),
          ),
        ],
      ),
    );
  }
}
