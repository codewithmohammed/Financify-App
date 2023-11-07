import 'package:financify/model/category/transactioncategory/transaction_model.dart';
import 'package:financify/notifierclass/expensetransaction_notifier.dart';
import 'package:financify/notifierclass/account_notifier.dart';
import 'package:financify/notifierclass/incometransaction_notifier.dart';
import 'package:financify/notifierclass/record_notifier.dart';
import 'package:financify/notifierclass/transaction_notifier.dart';
import 'package:financify/notifierclass/transferTransaction_notifier.dart';
import 'package:financify/screens/operationScreens/expenseScreen.dart';
import 'package:financify/screens/operationScreens/incomeScreen.dart';
import 'package:financify/screens/operationScreens/transferScreen.dart';
import 'package:financify/utils/themes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TransactionOperationScreen extends StatefulWidget {
  const TransactionOperationScreen({super.key});

  @override
  State<TransactionOperationScreen> createState() =>
      _TransactionOperationScreenState();
}

class _TransactionOperationScreenState extends State<TransactionOperationScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    if (_tabController.index == 0) {
      Provider.of<TransactionDataProvider>(context, listen: false).clearAll();
      Provider.of<TransactionDataProvider>(context, listen: false).type =
          TransactionCategoryType.income;
      print("First tab selected");
    } else if (_tabController.index == 1) {
      Provider.of<TransactionDataProvider>(context, listen: false).clearAll();
        Provider.of<TransactionDataProvider>(context, listen: false).type =
          TransactionCategoryType.expense;
      print("Second tab selected");
    } else if (_tabController.index == 2) {
      Provider.of<TransactionDataProvider>(context, listen: false).clearAll();
        Provider.of<TransactionDataProvider>(context, listen: false).type =
          TransactionCategoryType.transfer;
      print("Third tab selected");
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: AppTheme.backgroundColor,
          appBar: AppBar(
            bottom: TabBar(
              controller: _tabController,
              dividerColor: AppTheme.darkblue,
              indicatorColor: AppTheme.primaryColor,
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorWeight: 5,
              tabs: const [
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
              onPressed: () {
                Provider.of<TransactionDataProvider>(context, listen: false)
                    .clearAll();
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.close, size: 40),
              color: AppTheme.primaryColor,
            ),
            actions: [
              IconButton(
                onPressed: () async {
                  if (_tabController.index == 0) {
                    final incomeprovider = Provider.of<TransactionDataProvider>(
                        context,
                        listen: false);
                    final accountProvider = Provider.of<AccountDataProvider>(
                        context,
                        listen: false);
                    if (incomeprovider.categoryController.text.isEmpty) {
                      print('The Category must be selected');
                    }
                    if (incomeprovider.accountnameController.text.isEmpty) {
                      print('Account must not be empty');
                    }
                    if (incomeprovider.amountController.text.isEmpty) {
                      print('the amount must not be empty');
                    }
                    if (incomeprovider.dateController.text.isEmpty) {
                      print('The date must be given');
                    }
                    if (incomeprovider.dateController.text.isNotEmpty &&
                        incomeprovider.amountController.text.isNotEmpty &&
                        incomeprovider.accountnameController.text.isNotEmpty &&
                        incomeprovider.categoryController.text.isNotEmpty) {
                      incomeprovider.setid();
                      await incomeprovider.transactionToDB();
                      await accountProvider.dBToAccount();
                      incomeprovider.clearAll();
                      Navigator.of(context).pop();
                    }
                  } else if (_tabController.index == 1) {
                    final expenseprovider =
                        Provider.of<TransactionDataProvider>(context,
                            listen: false);
                    final accountProvider = Provider.of<AccountDataProvider>(
                        context,
                        listen: false);
                    if (expenseprovider.categoryController.text.isEmpty) {
                      print('The Category must be selected');
                    }
                    if (expenseprovider.accountnameController.text.isEmpty) {
                      print('Account must not be empty');
                    }

                    if (expenseprovider.amountController.text.isEmpty) {
                      print('the amount must not be empty');
                    }
                    if (expenseprovider.dateController.text.isEmpty) {
                      print('The date must be given');
                    }
                    if (expenseprovider.dateController.text.isNotEmpty &&
                        expenseprovider
                            .amountController.text.isNotEmpty &&
                        expenseprovider
                            .accountnameController.text.isNotEmpty &&
                        expenseprovider.categoryController.text.isNotEmpty) {
                      expenseprovider.setid();
                      await expenseprovider.transactionToDB();
                      await accountProvider.dBToAccount();
                      expenseprovider.clearAll();
                      Navigator.of(context).pop();
                    }
                  } else if (_tabController.index == 2) {
                    final transferprovider =
                        Provider.of<TransactionDataProvider>(context,
                            listen: false);
                    final accountProvider = Provider.of<AccountDataProvider>(
                        context,
                        listen: false);
                    if (transferprovider
                        .fromaccountnameController.text.isEmpty) {
                      print('The Category must be selected');
                    }
                    if (transferprovider
                        .toaccountnameController.text.isEmpty) {
                      print('Account must not be empty');
                    }
                    if (transferprovider
                        .amountController.text.isEmpty) {
                      print('the amount must not be empty');
                    }
                    if (transferprovider.dateController.text.isEmpty) {
                      print('The date must be given');
                    }
                    if (transferprovider
                            .dateController.text.isNotEmpty &&
                        transferprovider
                            .amountController.text.isNotEmpty &&
                        transferprovider
                            .fromaccountnameController.text.isNotEmpty &&
                        transferprovider
                            .toaccountnameController.text.isNotEmpty) {
                      transferprovider.setid();
                      await transferprovider.transactionToDB();
                      await accountProvider.dBToAccount();
                      transferprovider.clearAll();
                      Navigator.of(context).pop();
                    }
                  }
                },
                icon: const Icon(Icons.check, size: 40),
                color: AppTheme.primaryColor,
              )
            ],
            backgroundColor: AppTheme.darkblue,
          ),
          body: TabBarView(
            controller: _tabController,
            children: const [
              IncomeOperationScreen(),
              ExpenseOperationScreen(),
              TransferOperationScreen(),
            ],
          ),
        ));
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabSelection);
    _tabController.dispose();
    super.dispose();
  }
}
