import 'dart:io';
import 'dart:typed_data';
import 'package:financify/db/profile_db.dart';
import 'package:financify/model/category/profilecategory/profile_model.dart';
import 'package:financify/screens/MainScreens/home_screen.dart';
import 'package:financify/screens/MainScreens/record_screen.dart';
import 'package:financify/screens/MainScreens/setting_screen.dart';
import 'package:financify/screens/transactionScreen/transaction_screen.dart';
import 'package:flutter/material.dart';

class ProfileDataProvider extends ChangeNotifier {
  int id = 1;
  TextEditingController nameController = TextEditingController();
  Uint8List? imageData;
  String currencyCode = 'ABC';
  String currencySymbol = '';
  String currencyCountry = 'Select Your Country Currency';

  Future<void> deleteProfile() async {
    final profiledb = ProfileDB();
    await profiledb.clearProfile();
    await dBToName();
  }

  void replaceCurrency(String selectedCode) {
    currencyCode = selectedCode;
    notifyListeners();
  }

  void replaceCountrySymbol(String selectedSymbol) {
    currencySymbol = selectedSymbol;
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
  ) async {
    imageData = await imageSelected.readAsBytes();
    notifyListeners();
  }

  void setprofilepicinweb(Uint8List image) {
    imageData = image;
    notifyListeners();
  }

  void setProfileName(
    String typedname,
  ) {
    nameController.text = typedname;
    notifyListeners();
  }

  Future<void> dBToName() async {
    final profileDB = ProfileDB();
    final profiledata = await profileDB.getProfile();
    if (profiledata != null) {
      nameController.text = profiledata.name;
      imageData = profiledata.imageData;
      currencySymbol = profiledata.currencySymbol;
      currencyCode = profiledata.currencyCode;
      currencyCountry = profiledata.currencyCountry;
    } else {
      imageData = null;
    }
    notifyListeners();
  }

  void profileToBD() async {
    final profilevalue = ProfileModel(
        id: id,
        imageData: imageData!,
        name: nameController.text,
        currencyCode: currencyCode,
        currencySymbol: currencySymbol,
        currencyCountry: currencyCountry);
    final profileDB = ProfileDB();
    profileDB.insertProfile(profilevalue);
    dBToName();
  }
}
