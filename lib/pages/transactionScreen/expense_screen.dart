import 'package:financify/providers/transaction_provider.dart';
import 'package:financify/screens/transactionScreen/piecharts/expensecategorypie.dart';
import 'package:financify/theme/themes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpenseScreen extends StatelessWidget {
  const ExpenseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appTheme = Provider.of<AppTheme>(context, listen: true);
    return Consumer<TransactionDataProvider>(
        builder: ((context, incomedataprovider, child) => Scaffold(
              backgroundColor: appTheme.backgroundColor,
              body: const SafeArea(
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: ExpensePieChartBox(),
                ),
              ),
            )));
  }
}
