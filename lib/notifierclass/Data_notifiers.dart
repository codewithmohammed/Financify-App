import 'package:financify/db/profile_db.dart';
import 'package:financify/model/category/profilecategory/profile_model.dart';
import 'package:financify/screens/MainScreens/homeScreen.dart';
import 'package:financify/screens/MainScreens/recordScreen.dart';
import 'package:financify/screens/MainScreens/settingScreen.dart';
import 'package:financify/screens/transactionScreen/transactionScreen.dart';
import 'package:flutter/material.dart';

class ProfileDataProvider extends ChangeNotifier {
  int id = 1;
  late String name;
  String currencyCode = 'ABC';
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

  void changePages(int index) {
    pageIndex = index;
    notifyListeners();
  }

  void replaceCountry(String selectedCountry) {
    currencyCountry = selectedCountry;
    notifyListeners();
  }

  void setName(String typedname) {
    name = typedname;
    notifyListeners();
  }

  void dBToName() async {
    final profileDB = ProfileDB();
    final profiledata = await profileDB.getProfile();
    setName(profiledata!.name);
  }

  void profileToBD() {
    // if (name == '' && currencyCode == '' && currencyCountry == '') {
    //   return;
    // }else{
    final profilevalue = ProfileModel(
        id: id,
        name: name,
        currencyCode: currencyCode,
        currencyCountry: currencyCountry);
    final profileDB = ProfileDB();
    profileDB.insertProfile(profilevalue);
  }
  // }
}
