import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppTheme extends ChangeNotifier {
  bool appthemeDarkMode = true;
  Color primaryColor = const Color.fromRGBO(201, 146, 0, 1);
  Color accentColor = const Color.fromRGBO(90, 82, 60, 1);
  Color backgroundColor = const Color.fromRGBO(21, 31, 44, 1);
  Color mainTextColor = Colors.white;
  Color darkblue = const Color.fromRGBO(13, 21, 31, 1);
  Color black = Colors.black;
  Color listTileColor = const Color.fromRGBO(90, 82, 60, 0.4);
  Color settingSubtitleColor = const Color.fromRGBO(149, 149, 149, 1);

  changeToLight() async {
    final theme = await SharedPreferences.getInstance();
    theme.setInt('mode', 1);
    appthemeDarkMode = false;
    primaryColor = const Color.fromRGBO(201, 146, 0, 1);
    accentColor = const Color.fromRGBO(90, 82, 60, 1);
    backgroundColor = const Color.fromRGBO(204, 204, 204, 1);
    mainTextColor = Colors.black;
    darkblue = const Color.fromARGB(255, 126, 126, 126);
    black = Colors.white;
    listTileColor = const Color.fromRGBO(90, 82, 60, 0.4);
    settingSubtitleColor = const Color.fromRGBO(90, 82, 60, 1);
    notifyListeners();
  }

  changeToDark() async{
      final theme = await SharedPreferences.getInstance();
    theme.setInt('mode', 0);
    appthemeDarkMode = true;
    primaryColor = const Color.fromRGBO(201, 146, 0, 1);
    accentColor = const Color.fromRGBO(90, 82, 60, 1);
    backgroundColor = const Color.fromRGBO(21, 31, 44, 1);
    mainTextColor = Colors.white;
    darkblue = const Color.fromRGBO(13, 21, 31, 1);
    black = Colors.black;
    listTileColor = const Color.fromRGBO(90, 82, 60, 0.4);
    settingSubtitleColor = const Color.fromRGBO(149, 149, 149, 1);
    notifyListeners();
  }
}
