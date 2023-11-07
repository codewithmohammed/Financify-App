import 'package:financify/screens/transactionScreen/expenseScreen.dart';
import 'package:financify/screens/transactionScreen/incomeScreen.dart';
import 'package:financify/screens/transactionScreen/transferScreen.dart';
import 'package:financify/utils/themes.dart';
import 'package:flutter/material.dart';

class TransactionScreen extends StatelessWidget {
  const TransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3, // Specify the number of tabs
        child: Scaffold(
          backgroundColor: AppTheme.backgroundColor,
          appBar: AppBar(
            bottom: const TabBar(
              dividerColor: AppTheme.darkblue,
              indicatorColor: AppTheme.primaryColor,
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorWeight: 5,
              tabs: [
                Tab(
                  child: Text('INCOME',
                      style: TextStyle(color: AppTheme.mainTextColor)),
                ),
                Tab(
                  child: Text('EXPENSE',
                      style: TextStyle(color: AppTheme.mainTextColor)),
                ),
                Tab(
                  child: Text('TRANSFER',
                      style: TextStyle(color: AppTheme.mainTextColor)),
                ),
              ],
            ),
            automaticallyImplyLeading: false,
            leading: const SizedBox(),
            backgroundColor: AppTheme.darkblue,
            title: const Text(
              'TRANSACTIONS',
              style: TextStyle(color: AppTheme.primaryColor),
            ),
          ),
          body: const TabBarView(
            children: [
              IncomeScreen(),
              ExpenseScreen(),
              TransferScreen(),
            ],
          ),
        ));
  }
}
