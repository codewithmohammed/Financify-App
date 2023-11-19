import 'package:financify/auth/OBscreens/screenone.dart';
import 'package:financify/screens/MainScreens/main_screen.dart';
import 'package:financify/utils/themes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
    final appTheme = Provider.of<AppTheme>(context, listen: true);
    return Scaffold(
      backgroundColor: appTheme.backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                width: 200, child: Image.asset('assets/images/financify.png')),
            SizedBox(
                width: 150,
                child: LinearProgressIndicator(
                  color: appTheme.primaryColor,
                  minHeight: 15,
                  borderRadius: BorderRadius.circular(20),
                ))
          ],
        ),
      ),
    );
  }

  Future<void> checkUserLoggedIn() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    final userLoggedIn = sharedPrefs.getString('SAVE_KEY_LOGIN');
    final theme = sharedPrefs.getInt('mode');
    if (theme == 0) {
      Provider.of<AppTheme>(context, listen: false).changeToDark();
    } else {
      Provider.of<AppTheme>(context, listen: false).changeToLight();
    }
    if (userLoggedIn == 'false') {
      loginwait();
    } else {
      await sharedPrefs.setString('SAVE_KEY_LOGIN', 'true');
      toMainScreen();
    }
  }

  Future<void> loginwait() async {
    await Future.delayed(const Duration(seconds: 3));
    toOnboardingScreen();
  }

  void toMainScreen() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => const Mainscreen(),
    ));
  }

  void toOnboardingScreen() {
    Navigator.pushReplacement((context), MaterialPageRoute(builder: (ctx) {
      return const OnboardingScreen();
    }));
  }
}
