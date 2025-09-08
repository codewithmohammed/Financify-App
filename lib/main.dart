import 'package:financify/pages/all_data.dart';
import 'package:financify/pages/operationScreens/transactionscreen.dart';
import 'package:financify/providers/profile_provider.dart';
import 'package:financify/providers/update_data_provider.dart';
import 'package:financify/pages/auth/initial_amount_setting_screen.dart';
import 'package:financify/model/category/accountcategory/account_model.dart';
import 'package:financify/model/category/profilecategory/profile_model.dart';
import 'package:financify/model/category/transactioncategory/transaction_model.dart';
import 'package:financify/providers/account_provider.dart';

import 'package:financify/providers/transaction_provider.dart';

import 'package:financify/providers/widget_provider.dart';
import 'package:financify/pages/home/home_screen.dart';
import 'package:financify/pages/MainScreens/main_screen.dart';
import 'package:financify/pages/setting/setting_screen.dart';
import 'package:financify/pages/auth/screen/onboarding_screen.dart';
import 'package:financify/pages/auth/splash_screen.dart';
import 'package:financify/pages/auth/currency_select_screen.dart';
import 'package:financify/widgets/profile_screen.dart';
import 'package:financify/pages/updatingPage/editall_accounts.dart';
import 'package:financify/pages/updatingPage/proile_update.dart';
import 'package:financify/pages/updatingPage/currency_update.dart';
import 'package:financify/utils/category.dart';
import 'package:financify/theme/themes.dart';
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
        ChangeNotifierProvider(create: (context) => WidgetNotifier()),
        ChangeNotifierProvider(create: (context) => Category()),
        ChangeNotifierProvider(create: (context) => UpdateDataProvider()),
        ChangeNotifierProvider(create: (context) => AppTheme()),
      ],
      child: MaterialApp(
        routes: {
          'onboarding': (context) => const OnboardingScreen(),
          'Profileset': (context) => const ProfileSetScreen(),
          'CurrencySelect': (context) => const CurrencySelectScreen(),
          'CashAccountAmt': (context) => const InitialAmountSettingScreen(),
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
