import 'package:financify/utils/themes.dart';
import 'package:flutter/material.dart';

class WidgetNotifier extends ChangeNotifier {
  Color? cusOutlineButtonColor = AppTheme.primaryColor;
  String cusOutlineText = 'Done';

  changeToDone() {
    cusOutlineText = 'Done';
    cusOutlineButtonColor = AppTheme.primaryColor;
    notifyListeners();
  }

  changeToCancel() {
    cusOutlineButtonColor = Colors.red;
    cusOutlineText = 'Cancel';
    notifyListeners();
  }
}
