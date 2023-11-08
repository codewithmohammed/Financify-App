import 'package:flutter/material.dart';

class FilterNotifier extends ChangeNotifier {
  final List<String> type = [
    'Income',
    'Expense',
    'Transfer',
  ];
  String? selectedtypeValue;
    String? selectedaccountValue;
  setSelectedtypeValue(String? value) {
    selectedtypeValue = value;
    notifyListeners();
  }
    setSelectedAccountValue(String? value) {
    selectedaccountValue = value;
    notifyListeners();
  }
}

