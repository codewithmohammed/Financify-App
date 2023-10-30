import 'package:financify/screens/operationScreens/expenseScreen.dart';
import 'package:financify/screens/operationScreens/incomeScreen.dart';
import 'package:financify/screens/operationScreens/transferScreen.dart';
import 'package:financify/utils/themes.dart';
import 'package:flutter/material.dart';

class TransactionOperationScreen extends StatelessWidget {
  const TransactionOperationScreen({super.key});

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
                  child: Text(
                    'INCOME',
                    style: TextStyle(color: AppTheme.mainTextColor),
                  ),
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
            leading: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.close, size: 40),
              color: AppTheme.primaryColor,
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.check, size: 40),
                color: AppTheme.primaryColor,
              )
            ],
            backgroundColor: AppTheme.darkblue,
          ),
          body: const TabBarView(
            children: [
              IncomeOperationScreen(),
              ExpenseOperationScreen(),
              TransferOperationScreen(),
            ],
          ),
        ));
  }
}
