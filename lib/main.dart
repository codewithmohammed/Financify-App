import 'package:financify/auth/profileset/cash_accamt.dart';
import 'package:financify/model/category/accountcategory/account_model.dart';
import 'package:financify/model/category/profilecategory/profile_model.dart';
import 'package:financify/model/category/transactioncategory/transaction_model.dart';
import 'package:financify/providers/account_notifier.dart';
import 'package:financify/providers/profile_notifiers.dart';
import 'package:financify/providers/transaction_notifier.dart';
import 'package:financify/providers/updatedataprovider.dart';
import 'package:financify/providers/widgetnotifier.dart';
import 'package:financify/screens/All_data.dart';
import 'package:financify/screens/MainScreens/home_screen.dart';
import 'package:financify/screens/MainScreens/main_screen.dart';
import 'package:financify/screens/MainScreens/setting_screen.dart';
import 'package:financify/auth/OBscreens/screenone.dart';
import 'package:financify/auth/OBscreens/splash_screen.dart';
import 'package:financify/screens/operationScreens/transactionScreen.dart';
import 'package:financify/auth/profileset/currencyselect.dart';
import 'package:financify/auth/profileset/profilescreen.dart';
import 'package:financify/screens/updatingPage/editall_accounts.dart';
import 'package:financify/screens/updatingPage/proile_update.dart';
import 'package:financify/screens/updatingPage/currency_update.dart';
import 'package:financify/utils/category.dart';
import 'package:financify/utils/themes.dart';
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
              ChangeNotifierProvider(
            create: (context) => WidgetNotifier()),
               ChangeNotifierProvider(
            create: (context) => Category()),
                          ChangeNotifierProvider(
            create: (context) => UpdateDataProvider()),
             ChangeNotifierProvider(
            create: (context) => AppTheme()),
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
          'UpdateCurrency': (context) => const UpdateCurrencySelect(),
           'AllDataTransaction': (context) => const AllTransactionData()
        },
        title: 'Financify',
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
        theme: ThemeData(fontFamily: 'Test'),
      ),
    );
  }
}
