import 'package:financify/screens/MainScreens/homeScreen.dart';
import 'package:financify/screens/MainScreens/recordScreen.dart';
import 'package:financify/screens/MainScreens/settingScreen.dart';
import 'package:financify/screens/MainScreens/transactionScreen.dart';
import 'package:flutter/material.dart';

class ProfileDataProvider extends ChangeNotifier {
  late final photo;
  String currencyCode = 'USD';
  String currencyCountry = 'Select Your Country Currency';
  void replaceCurrency(String selectedCode) {
    currencyCode = selectedCode;
    notifyListeners();
  }
    int pageIndex = 0;

  final pages = [
    const HomeScreen(),
    const RecordScreen(),
    const TransactionScreen(),
    const SettingScreen(),
  ];

  changePages(int index) {
    pageIndex = index;
    notifyListeners();
  }

  void replaceCountry(String selectedCountry) {
    currencyCountry = selectedCountry;
    notifyListeners();
  }
}