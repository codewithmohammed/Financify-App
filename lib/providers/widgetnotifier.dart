import 'package:flutter/material.dart';

class WidgetNotifier extends ChangeNotifier {
  Color? cusOutlineButtonColor = const Color.fromRGBO(201, 146, 0, 1);
  String cusOutlineText = 'Done';

  changeToDone() {
    cusOutlineText = 'Done';
    cusOutlineButtonColor = const Color.fromRGBO(201, 146, 0, 1);
    notifyListeners();
  }

  changeToCancel() {
    cusOutlineButtonColor = Colors.red;
    cusOutlineText = 'Cancel';
    notifyListeners();
  }
}
