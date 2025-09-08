import 'package:financify/screens/transactionScreen/expense_screen.dart';
import 'package:financify/screens/transactionScreen/income_screen.dart';
import 'package:financify/theme/themes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TransactionScreen extends StatelessWidget {
  const TransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appTheme = Provider.of<AppTheme>(context, listen: true);
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: appTheme.backgroundColor,
          appBar: AppBar(
            bottom: TabBar(
              dividerColor: appTheme.darkblue,
              indicatorColor: appTheme.primaryColor,
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorWeight: 5,
              tabs: [
                Tab(
                  child: Text('INCOME',
                      style: TextStyle(color: appTheme.mainTextColor)),
                ),
                Tab(
                  child: Text('EXPENSE',
                      style: TextStyle(color: appTheme.mainTextColor)),
                ),
              ],
            ),
            automaticallyImplyLeading: false,
            leading: const SizedBox(),
            backgroundColor: appTheme.darkblue,
            title: Text(
              'OVERVIEW',
              style: TextStyle(color: appTheme.primaryColor),
            ),
          ),
          body: const TabBarView(
            children: [
              IncomeScreen(),
              ExpenseScreen(),
            ],
          ),
        ));
  }
}
