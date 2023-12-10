import 'package:financify/model/category/accountcategory/account_model.dart';
import 'package:financify/model/category/transactioncategory/transaction_model.dart';
import 'package:financify/providers/account_notifier.dart';
import 'package:financify/providers/transaction_notifier.dart';
import 'package:financify/screens/operationScreens/expense_screen.dart';
import 'package:financify/screens/operationScreens/income_screen.dart';
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
  void showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text(message),
        duration: const Duration(seconds: 2),
        action: SnackBarAction(
          label: 'Close',
          onPressed: () {},
        ),
      ),
    );
  }

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
       Provider.of<AccountDataProvider>(context, listen: false).dBToAccount();
      Provider.of<TransactionDataProvider>(context, listen: false).type =
          TransactionCategoryType.income;
    } else if (_tabController.index == 1) {
      Provider.of<TransactionDataProvider>(context, listen: false).clearAll();
           Provider.of<AccountDataProvider>(context, listen: false).dBToAccount();
      Provider.of<TransactionDataProvider>(context, listen: false).type =
          TransactionCategoryType.expense;
    } else if (_tabController.index == 2) {
      Provider.of<TransactionDataProvider>(context, listen: false).clearAll();
           Provider.of<AccountDataProvider>(context, listen: false).dBToAccount();
      Provider.of<TransactionDataProvider>(context, listen: false).type =
          TransactionCategoryType.transfer;
    }
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = Provider.of<AppTheme>(context, listen: true);
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: appTheme.backgroundColor,
          appBar: AppBar(
            bottom: TabBar(
              controller: _tabController,
              dividerColor: appTheme.darkblue,
              indicatorColor: appTheme.primaryColor,
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorWeight: 5,
              tabs: [
                Tab(
                  child: Text(
                    'INCOME',
                    style: TextStyle(color: appTheme.mainTextColor),
                  ),
                ),
                Tab(
                  child: Text('EXPENSE',
                      style: TextStyle(color: appTheme.mainTextColor)),
                ),
                Tab(
                  child: Text('TRANSFER',
                      style: TextStyle(color: appTheme.mainTextColor)),
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
              color: appTheme.primaryColor,
            ),
            actions: [
              IconButton(
                onPressed: () async {
                  final accountProvider =
                      Provider.of<AccountDataProvider>(context, listen: false);
                  final incomeExpenseprovider =
                      Provider.of<TransactionDataProvider>(context,
                          listen: false);
                  if (incomeExpenseprovider.type ==
                          TransactionCategoryType.income ||
                      incomeExpenseprovider.type ==
                          TransactionCategoryType.expense) {
                    if (incomeExpenseprovider.categoryController.text.isEmpty ||
                        incomeExpenseprovider
                            .accountnameController.text.isEmpty ||
                        incomeExpenseprovider.dateController.text.isEmpty ||
                        incomeExpenseprovider.amountController.text.isEmpty) {
                      showSnackBar('Please fill in all required fields.');
                    }
                  }
                  if (_tabController.index == 0) {
                    if (incomeExpenseprovider.dateController.text.isNotEmpty &&
                        incomeExpenseprovider
                            .amountController.text.isNotEmpty &&
                        incomeExpenseprovider
                            .accountnameController.text.isNotEmpty &&
                        incomeExpenseprovider
                            .categoryController.text.isNotEmpty) {
                      incomeExpenseprovider.setid();
                      await incomeExpenseprovider.transactionToDB();
                      await accountProvider.dBToAccount();
                      incomeExpenseprovider.clearAll();
                      popit();
                      showSnackBar('Your Transaction is Added Successfully');
                    }
                  } else if (_tabController.index == 1) {
                    if (incomeExpenseprovider.dateController.text.isNotEmpty &&
                        incomeExpenseprovider
                            .amountController.text.isNotEmpty &&
                        incomeExpenseprovider
                            .accountnameController.text.isNotEmpty &&
                        incomeExpenseprovider
                            .categoryController.text.isNotEmpty) {
                      if (await expenseChecker(true)) {
                        const snackBar = SnackBar(
                          content: Text(
                              "You don't have enough balance in this account"),
                          duration: Duration(
                              seconds: 3), // Adjust the duration as needed
                        );

                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      } else {
                        incomeExpenseprovider.setid();
                        await incomeExpenseprovider.transactionToDB();
                        await accountProvider.dBToAccount();
                        incomeExpenseprovider.clearAll();
                        popit();
                        showSnackBar('Your Transaction is Added Successfully');
                      }
                    }
                  } else if (_tabController.index == 2) {
                    final transferprovider =
                        Provider.of<TransactionDataProvider>(context,
                            listen: false);
                    if (transferprovider
                            .fromaccountnameController.text.isEmpty ||
                        transferprovider.toaccountnameController.text.isEmpty ||
                        transferprovider.amountController.text.isEmpty ||
                        transferprovider.dateController.text.isEmpty || transferprovider.toaccountnameController.text == 'choose another account') {
                      showSnackBar('Please fill in all required fields.');
                    } else {
                      if (await expenseChecker(false)) {
                        const snackBar = SnackBar(
                          content: Text(
                              "You don't have enough balance in this account"),
                          duration: Duration(
                              seconds: 3), // Adjust the duration as needed
                        );

                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      } else {
                        transferprovider.setid();
                        await transferprovider.transactionToDB();
                        await accountProvider.dBToAccount();
                        transferprovider.clearAll();
                        popit();
                        showSnackBar('Your Transaction is Added Successfully');
                      }
                    }
                  }
                },
                icon: const Icon(Icons.check, size: 40),
                color: appTheme.primaryColor,
              )
            ],
            backgroundColor: appTheme.darkblue,
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

  void popit() {
    Navigator.of(context).pop();
  }

  Future<bool> expenseChecker(bool isExpenseTransaction) async {
    final accountProvider =
        Provider.of<AccountDataProvider>(context, listen: false);
    final incomeExpenseprovider =
        Provider.of<TransactionDataProvider>(context, listen: false);
    final double enteredexpenseAmount =
        double.parse(incomeExpenseprovider.amountController.text);
    //if its a expense transaction
    if (isExpenseTransaction == true) {
      final AccountModel theaccount = accountProvider.accountList.firstWhere(
          (element) =>
              element.accName ==
              incomeExpenseprovider.accountnameController.text);
      final double acctotalbalance = double.parse(theaccount.accBalance);

      if (acctotalbalance < enteredexpenseAmount) {
        return true;
      } else {
        return false;
      }
      //if its a tranfer transaction
    } else {
      final AccountModel theaccount = accountProvider.accountList.firstWhere(
          (element) =>
              element.accName ==
              incomeExpenseprovider.fromaccountnameController.text);
      final double acctotalbalance = double.parse(theaccount.accBalance);
      if (acctotalbalance < enteredexpenseAmount) {
        return true;
      } else {
        return false;
      }
    }
  }
}
