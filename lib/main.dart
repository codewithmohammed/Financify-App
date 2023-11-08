import 'package:financify/model/category/accountcategory/account_model.dart';
import 'package:financify/model/category/profilecategory/profile_model.dart';
import 'package:financify/model/category/transactioncategory/transaction_model.dart';
import 'package:financify/providers/account_notifier.dart';
import 'package:financify/providers/filter_notifier.dart';
import 'package:financify/providers/profile_notifiers.dart';
import 'package:financify/providers/transaction_notifier.dart';
import 'package:financify/screens/MainScreens/homeScreen.dart';
import 'package:financify/screens/MainScreens/mainscreen.dart';
import 'package:financify/screens/MainScreens/settingScreen.dart';
import 'package:financify/screens/OBscreens/screenone.dart';
import 'package:financify/screens/OBscreens/splashScreen.dart';
import 'package:financify/screens/operationScreens/transactionScreen.dart';
import 'package:financify/screens/profileset/cashAccAmt.dart';
import 'package:financify/screens/profileset/currencyselect.dart';
import 'package:financify/screens/profileset/profilescreen.dart';
import 'package:financify/screens/updatingPage/editAllAccounts.dart';
import 'package:financify/screens/updatingPage/proileUpdate.dart';
import 'package:financify/screens/updatingPage/Currencyupdate.dart';
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
  if (!Hive.isAdapterRegistered(TransactionModelAdapter().typeId)) {
    Hive.registerAdapter(TransactionModelAdapter());
  }
  if (!Hive.isAdapterRegistered(TransactionCategoryTypeAdapter().typeId)) {
    Hive.registerAdapter(TransactionCategoryTypeAdapter());
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => ProfileDataProvider()..dBToName()),
        ChangeNotifierProvider(
            create: (context) => AccountDataProvider()..dBToAccount()),
        ChangeNotifierProvider(
            create: (context) => TransactionDataProvider()..dBtoTransaction()),
        ChangeNotifierProvider(create: (context) => FilterNotifier()),
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
          'ProfileUpdate': (context) => const ProfileUpdateScreen(),
          'settingPage': (context) => const SettingScreen(),
          'EditallAccount': (context) => const EditAllAccounts(),
          'UpdateCurrency': (context) => const UpdateCurrencySelect()
        },
        title: 'Financify',
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
        theme: ThemeData(fontFamily: 'Test'),
      ),
    );
  }
}
