import 'package:financify/pages/transactionScreen/piecharts/incomecategorypie.dart';
import 'package:financify/providers/transaction_provider.dart';
import 'package:financify/theme/themes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IncomeScreen extends StatelessWidget {
  const IncomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appTheme = Provider.of<AppTheme>(context, listen: true);
    return Consumer<TransactionDataProvider>(
        builder: ((context, incomedataprovider, child) => Scaffold(
              backgroundColor: appTheme.backgroundColor,
              body: const SafeArea(
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: IncomesPieChartBox(),
                ),
              ),
            )));
  }
}
