import 'dart:io';
import 'dart:typed_data';
import 'package:financify/db/profile_db.dart';
import 'package:financify/model/category/profilecategory/profile_model.dart';
import 'package:financify/screens/MainScreens/homeScreen.dart';
import 'package:financify/screens/MainScreens/recordScreen.dart';
import 'package:financify/screens/MainScreens/settingScreen.dart';
import 'package:financify/screens/transactionScreen/transactionScreen.dart';
import 'package:flutter/material.dart';

class ProfileDataProvider extends ChangeNotifier {
  int id = 1;
  TextEditingController nameController = TextEditingController();
  Uint8List? imageData;
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

  void setProfilePic(
    File imageSelected,
  ) async{
    imageData = await imageSelected.readAsBytes();
    notifyListeners();
  }

  void setProfileName(
    String typedname,
  ) {
    nameController.text = typedname;
    notifyListeners();
  }

  void dBToName() async {
    final profileDB = ProfileDB();
    final profiledata = await profileDB.getProfile();
    if (profiledata == null) {
      return;
    }
    nameController.text = profiledata.name;
    imageData = profiledata.imageData;
    currencyCode = profiledata.currencyCode;
    currencyCountry = profiledata.currencyCountry;
    notifyListeners();
  }

  void profileToBD() async {
    final profilevalue = ProfileModel(
        id: id,
        imageData: imageData!,
        name: nameController.text,
        currencyCode: currencyCode,
        currencyCountry: currencyCountry);
    final profileDB = ProfileDB();
    profileDB.insertProfile(profilevalue);
    dBToName();
  }
}
