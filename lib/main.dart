import 'package:financify/model/category/accountcategory/account_model.dart';
import 'package:financify/model/category/profilecategory/profile_model.dart';
import 'package:financify/notifierclass/account_notifier.dart';
import 'package:financify/notifierclass/profile_notifiers.dart';
import 'package:financify/screens/MainScreens/homeScreen.dart';
import 'package:financify/screens/MainScreens/mainscreen.dart';
import 'package:financify/screens/OBscreens/screenone.dart';
import 'package:financify/screens/operationScreens/transactionScreen.dart';
import 'package:financify/screens/profileset/cashAccAmt.dart';
import 'package:financify/screens/profileset/currencyselect.dart';
import 'package:financify/screens/profileset/profilescreen.dart';
import 'package:financify/updatingPage/proileUpdate.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(ProfileModelAdapter().typeId)) {
    Hive.registerAdapter(ProfileModelAdapter());
  }
  if (!Hive.isAdapterRegistered(AccountModelAdapter().typeId)) {
    Hive.registerAdapter(AccountModelAdapter());
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProfileDataProvider()),
       ChangeNotifierProvider(create: (context) => AccountDataProvider())
      ],
      child: MaterialApp(
        routes: {
          'onboarding': (context) => const OnboardingScreen(),
          'Profileset': (context) => const ProfileSetScreen(),
          'CurrencySelect': (context) => const CurrencySelect(),
          'CashAccountAmt': (context) => const CashAccSet(),
          'MainPage': (context) => const Mainscreen(),
          'HomePage': (context) => const HomeScreen(),
          'TransactionOperation': (context) =>
              const TransactionOperationScreen(),
               'ProfileUpdate': (context) =>
              const ProfileUpdateScreen()
        },
        title: 'Financify',
        debugShowCheckedModeBanner: false,
        home: const OnboardingScreen(),
        theme: ThemeData(fontFamily: 'Test'),
      ),
    );
  }
}
