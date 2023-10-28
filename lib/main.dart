import 'package:financify/notifierclass/profileclass.dart';
import 'package:financify/screens/MainScreens/homeScreen.dart';
import 'package:financify/screens/MainScreens/mainscreen.dart';
import 'package:financify/screens/OBscreens/screenone.dart';
import 'package:financify/screens/profileset/cashAccAmt.dart';
import 'package:financify/screens/profileset/currencyselect.dart';
import 'package:financify/screens/profileset/profilescreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context)=> ProfileDataProvider())],
      child: MaterialApp(
        routes: {
          'onboarding': (context) => const OnboardingScreen(),
          'Profileset': (context) => const ProfileSetScreen(),
          'CurrencySelect': (context) => const CurrencySelect(),
          'CashAccountAmt': (context) => const CashAccSet(),
          'MainPage': (context) => const Mainscreen(),
          'HomePage': (context) => const HomeScreen(),
        },
        title: 'Financify',
        debugShowCheckedModeBanner: false,
        home: const OnboardingScreen(),
        theme: ThemeData(fontFamily: 'Test'),
      ),
    );
  }
}
