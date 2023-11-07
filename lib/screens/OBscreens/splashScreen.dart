import 'package:financify/screens/MainScreens/mainScreen.dart';
import 'package:financify/screens/profileset/profilescreen.dart';
import 'package:financify/utils/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    checkUserLoggedIn();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: Center(
        child: Image.asset('assets/images/financify.png'),
      ),
    );
  }

  Future<void> checkUserLoggedIn() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    final userLoggedIn = sharedPrefs.getString('SAVE_KEY_LOGIN');
    if (userLoggedIn == 'false') {
      loginwait();
    } else {
      await sharedPrefs.setString('SAVE_KEY_LOGIN', 'true');
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const Mainscreen(),
      ));
    }
  }

  Future<void> loginwait() async {
    await Future.delayed(const Duration(seconds: 3));
    Navigator.pushReplacement((context), MaterialPageRoute(builder: (ctx) {
      return const ProfileSetScreen();
    }));
  }
}
