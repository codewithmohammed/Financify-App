import 'package:financify/db/account_db.dart';
import 'package:financify/db/transaction_db.dart';
import 'package:financify/model/category/accountcategory/account_model.dart';
import 'package:financify/model/category/transactioncategory/transaction_model.dart';
import 'package:flutter/material.dart';

class TransactionDataProvider extends ChangeNotifier {
  double accExpense = 0;
  double accIncome = 0;
  List<TransactionModel> accountList = [];
  List<TransactionModel> searchaccountList = [];
  List<TransactionModel> fromaccounts = [];
  List<TransactionModel> filteredaccountList = [];
  List<TransactionModel> incomeaccountList = [];
  List<TransactionModel> expenseaccountList = [];
  List<TransactionModel> transferaccountList = [];

  List<TransactionModel> salaryIncomeList = [];
  List<TransactionModel> freelanceIncomeList = [];
  List<TransactionModel> rentalIncomeList = [];
  List<TransactionModel> investmentIncomeList = [];
  List<TransactionModel> giftIncomeList = [];
  List<TransactionModel> reimbursementsList = [];
  List<TransactionModel> refundsList = [];
  List<TransactionModel> dividendIncomeList = [];
  List<TransactionModel> interestIncomeList = [];
  List<TransactionModel> businessIncomeList = [];
  List<TransactionModel> royaltyIncomeList = [];
  List<TransactionModel> alimonyList = [];
  List<TransactionModel> capitalGainsList = [];
  List<TransactionModel> scholarshipList = [];
  List<TransactionModel> lotteryWinningsList = [];

  List<TransactionModel> housingExpenseList = [];
  List<TransactionModel> utilitiesExpenseList = [];
  List<TransactionModel> groceriesExpenseList = [];
  List<TransactionModel> transportationExpenseList = [];
  List<TransactionModel> healthCareExpenseList = [];
  List<TransactionModel> insuranceExpenseList = [];
  List<TransactionModel> educationExpenseList = [];
  List<TransactionModel> entertainmentExpenseList = [];
  List<TransactionModel> diningOutExpenseList = [];
  List<TransactionModel> shoppingExpenseList = [];
  List<TransactionModel> personalCareExpenseList = [];
  List<TransactionModel> debtPaymentsExpenseList = [];
  List<TransactionModel> charitableDonationsExpenseList = [];
  List<TransactionModel> taxesExpenseList = [];
  List<TransactionModel> miscellaneousExpenseList = [];

  double? sumofincomesalary = 0;
  double? sumofincomefreelance = 0;
  double? sumofincomerental = 0;
  double? sumofincomeinvestment = 0;
  double? sumofincomegift = 0;
  double? sumofincomereimbursements = 0;
  double? sumofincomerefunds = 0;
  double? sumofincomedividend = 0;
  double? sumofincomeinterest = 0;
  double? sumofincomebusiness = 0;
  double? sumofincomeroyalty = 0;
  double? sumofincomealimony = 0;
  double? sumofincomecapitalGains = 0;
  double? sumofincomescholarship = 0;
  double? sumofincomelotteryWinnings = 0;

  double? sumofexpensehousing = 0;
  double? sumofexpenseutilities = 0;
  double? sumofexpensegroceries = 0;
  double? sumofexpensetransportation = 0;
  double? sumofexpensehealthCare = 0;
  double? sumofexpenseinsurance = 0;
  double? sumofexpenseeducation = 0;
  double? sumofexpenseentertainment = 0;
  double? sumofexpensediningOut = 0;
  double? sumofexpenseshopping = 0;
  double? sumofexpensepersonalCare = 0;
  double? sumofexpensedeptPayments = 0;
  double? sumofexpensecharitableDonations = 0;
  double? sumofexpensetaxes = 0;
  double? sumofexpensemiscellaneous = 0;

  String id = DateTime.now().millisecondsSinceEpoch.toString();
  TransactionCategoryType type = TransactionCategoryType.income;
  TextEditingController amountController = TextEditingController();
  TextEditingController accountnameController = TextEditingController();
  TextEditingController toaccountnameController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController fromaccountnameController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController noteController = TextEditingController();

  Future<void> deleteAllTransaciion() async {
    final transactiondb = TransactionDB();
    await transactiondb.clearTransaction();
    await dBtoTransaction();
    notifyListeners();
  }

  final List<String> filtertype = [
    'Income',
    'Expense',
    'Transfer',
  ];
  TransactionCategoryType? filteringtype;
  TextEditingController selectedtypeValue = TextEditingController();
  TextEditingController selectedaccountValue = TextEditingController();
  TextEditingController selectedaDateValue = TextEditingController();
  TextEditingController selectedaCategoryValue = TextEditingController();

  filterSelection() {
    if (filteringtype != null ||
        selectedaccountValue.text.isNotEmpty ||
        selectedaDateValue.text.isNotEmpty ||
        selectedaCategoryValue.text.isNotEmpty) {
      searchaccountList.clear();
      filterByFilteringType();
      filterByAccountName();
      filterByDateValue();
      filterByCategoryName();
      // if (filteringtype != null &&
      //     selectedaccountValue.text.isNotEmpty &&
      //     selectedaDateValue.text.isNotEmpty &&
      //     selectedaCategoryValue.text.isNotEmpty) {
      //   // Combination 1
      //   searchaccountList.where((element) =>
      //       element.accountname == selectedaccountValue.text &&
      //       element.transactiondate == selectedaDateValue.text &&
      //       element.categoryname == selectedaCategoryValue.text);
      // }

      // if (filteringtype != null &&
      //     selectedaccountValue.text.isNotEmpty &&
      //     selectedaDateValue.text.isNotEmpty &&
      //     selectedaCategoryValue.text.isEmpty) {
      //   // Combination 2
      //   searchaccountList.where((element) =>
      //       element.accountname == selectedaccountValue.text &&
      //       element.transactiondate == selectedaDateValue.text);
      // }

      // if (filteringtype != null &&
      //     selectedaccountValue.text.isNotEmpty &&
      //     selectedaDateValue.text.isEmpty &&
      //     selectedaCategoryValue.text.isNotEmpty) {
      //   // Combination 3
      //   searchaccountList.where((element) =>
      //       element.accountname == selectedaccountValue.text &&
      //       element.categoryname == selectedaCategoryValue.text);
      // }

      // if (filteringtype != null &&
      //     selectedaccountValue.text.isNotEmpty &&
      //     selectedaDateValue.text.isEmpty &&
      //     selectedaCategoryValue.text.isEmpty) {
      //   // Combination 4
      //   searchaccountList.where(
      //       (element) => element.accountname == selectedaccountValue.text);
      // }
      // // Combination 5
      // if (filteringtype != null &&
      //     selectedaccountValue.text.isEmpty &&
      //     selectedaDateValue.text.isNotEmpty &&
      //     selectedaCategoryValue.text.isNotEmpty) {
      //   searchaccountList.where((element) =>
      //       element.transactiondate == selectedaDateValue.text &&
      //       element.categoryname == selectedaCategoryValue.text);
      // }

      // // Combination 6
      // if (filteringtype != null &&
      //     selectedaccountValue.text.isEmpty &&
      //     selectedaDateValue.text.isNotEmpty &&
      //     selectedaCategoryValue.text.isEmpty) {
      //   searchaccountList.where(
      //       (element) => element.transactiondate == selectedaDateValue.text);
      // }

      // // Combination 7
      // if (filteringtype != null &&
      //     selectedaccountValue.text.isEmpty &&
      //     selectedaDateValue.text.isEmpty &&
      //     selectedaCategoryValue.text.isNotEmpty) {
      //   searchaccountList.where(
      //       (element) => element.categoryname == selectedaCategoryValue.text);
      // }

      // // Combination 8
      // if (filteringtype != null &&
      //     selectedaccountValue.text.isEmpty &&
      //     selectedaDateValue.text.isEmpty &&
      //     selectedaCategoryValue.text.isEmpty) {
      //   searchaccountList;
      // }

      // // Combination 9
      // if (filteringtype == null &&
      //     selectedaccountValue.text.isNotEmpty &&
      //     selectedaDateValue.text.isNotEmpty &&
      //     selectedaCategoryValue.text.isNotEmpty) {
      //   searchaccountList.where((element) =>
      //       element.accountname == selectedaccountValue.text &&
      //       element.transactiondate == selectedaDateValue.text &&
      //       element.categoryname == selectedaCategoryValue.text);
      // }

      // // Combination 10
      // if (filteringtype == null &&
      //     selectedaccountValue.text.isNotEmpty &&
      //     selectedaDateValue.text.isNotEmpty &&
      //     selectedaCategoryValue.text.isEmpty) {
      //   searchaccountList.where((element) =>
      //       element.accountname == selectedaccountValue.text &&
      //       element.transactiondate == selectedaDateValue.text);
      // }

      // // Combination 11
      // if (filteringtype == null &&
      //     selectedaccountValue.text.isNotEmpty &&
      //     selectedaDateValue.text.isEmpty &&
      //     selectedaCategoryValue.text.isNotEmpty) {
      //   searchaccountList.where((element) =>
      //       element.accountname == selectedaccountValue.text &&
      //       element.categoryname == selectedaCategoryValue.text);
      // }

      // // Combination 12
      // if (filteringtype == null &&
      //     selectedaccountValue.text.isNotEmpty &&
      //     selectedaDateValue.text.isEmpty &&
      //     selectedaCategoryValue.text.isEmpty) {
      //   searchaccountList.where(
      //       (element) => element.accountname == selectedaccountValue.text);
      // }

      // // Combination 13
      // if (filteringtype == null &&
      //     selectedaccountValue.text.isEmpty &&
      //     selectedaDateValue.text.isNotEmpty &&
      //     selectedaCategoryValue.text.isNotEmpty) {
      //   searchaccountList.where((element) =>
      //       element.transactiondate == selectedaDateValue.text &&
      //       element.categoryname == selectedaCategoryValue.text);
      // }

      // // Combination 14
      // if (filteringtype == null &&
      //     selectedaccountValue.text.isEmpty &&
      //     selectedaDateValue.text.isNotEmpty &&
      //     selectedaCategoryValue.text.isEmpty) {
      //   searchaccountList.where(
      //       (element) => element.transactiondate == selectedaDateValue.text);
      // }

      // // Combination 15
      // if (filteringtype == null &&
      //     selectedaccountValue.text.isEmpty &&
      //     selectedaDateValue.text.isEmpty &&
      //     selectedaCategoryValue.text.isNotEmpty) {
      //   searchaccountList.where(
      //       (element) => element.categoryname == selectedaCategoryValue.text);
      // }

      // if (filteringtype == null &&
      //     selectedaccountValue.text.isEmpty &&
      //     selectedaDateValue.text.isEmpty &&
      //     selectedaCategoryValue.text.isEmpty) {
      //   searchaccountList;
      // }
    } else {
      searchaccountList.addAll(accountList);
    }
    filteredaccountList = searchaccountList.toSet().toList();
    notifyListeners();
  }

  filterClear() {
    filteringtype = null;
    selectedtypeValue.clear();
    selectedaccountValue.clear();
    selectedaDateValue.clear();
    selectedaCategoryValue.clear();
    notifyListeners();
  }

  filterByFilteringType() {
    if (filteringtype != null) {
      searchaccountList.addAll(accountList
          .where((element) => element.type == filteringtype)
          .toList());
    } else {
      return;
    }
  }

  filterByAccountName() {
    if (selectedaccountValue.text.isNotEmpty) {
      searchaccountList.addAll(accountList
          .where((element) => element.accountname == selectedaccountValue.text)
          .toList());
    } else {
      return;
    }
  }

  filterByDateValue() {
    if (selectedaDateValue.text.isNotEmpty) {
      searchaccountList.addAll(accountList
          .where(
              (element) => element.transactiondate == selectedaDateValue.text)
          .toList());
    } else {
      return;
    }
  }

  filterByCategoryName() {
    if (selectedaCategoryValue.text.isNotEmpty) {
      searchaccountList.addAll(accountList
          .where(
              (element) => element.categoryname == selectedaCategoryValue.text)
          .toList());
    } else {
      return;
    }
  }

  setSelectedtypeValue(String value) {
    if (value == 'Income') {
      selectedtypeValue.text = value;
      filteringtype = TransactionCategoryType.income;
    } else if (value == 'Expense') {
      selectedtypeValue.text = value;
      filteringtype = TransactionCategoryType.expense;
    } else {
      selectedtypeValue.text = value;
      filteringtype = TransactionCategoryType.transfer;
    }
    notifyListeners();
  }

  setToaccount(String toacc) {
    toaccountnameController.text = toacc;
    notifyListeners();
  }

  setSelecteddateValue(String value) {
    selectedaDateValue.text = value;
    notifyListeners();
  }

  setSelectedAccountValue(String value) {
    selectedaccountValue.text = value;

    notifyListeners();
  }

  setSelectedCategoryValue(String value) {
    selectedaCategoryValue.text = value;
    notifyListeners();
  }

  void setid() {
    id = DateTime.now().millisecondsSinceEpoch.toString();
  }

  void setTransactionDate(String selectedDate) {
    dateController.text = selectedDate;
    notifyListeners();
  }

  void runFilter(String enteredKeyword) {
    if (enteredKeyword.trim().isEmpty) {
      searchaccountList = accountList;
    } else {
      searchaccountList = accountList
          .where((element) =>
              element.accountname
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()) ||
              element.accountnote
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()) ||
              element.categoryname
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()) ||
              element.fromaccountname
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()) ||
              element.toaccountname
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()) ||
              element.transactiondate
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()) ||
              element.amount
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()))
          .toList();
    }
    filteredaccountList = searchaccountList.toList();
    notifyListeners();
  }

  cancelSearch() async{
   await dBtoTransaction();
    // filteredaccountList = accountList;
    notifyListeners();
  }

  Future<void> transactionToDB() async {
    final transaction = TransactionModel(
      id: id,
      amount: amountController.text,
      accountname: accountnameController.text,
      toaccountname: toaccountnameController.text,
      transactiondate: dateController.text,
      fromaccountname: fromaccountnameController.text,
      categoryname: categoryController.text,
      accountnote:
          noteController.text.isEmpty ? 'No Notes' : noteController.text,
      type: type,
    );
    final transactionDB = TransactionDB();
    await transactionDB.insertTransaction(transaction);
    await calculateAccountAmount(
        amounttoBeOperated: amountController.text,
        accountName: accountnameController.text,
        toaccountname: toaccountnameController.text,
        fromaccountname: fromaccountnameController.text,
        type: type);
    await dBtoTransaction();
    notifyListeners();
  }

  Future<void> deleteTransaction(String deleteID) async {
    final transactionDB = TransactionDB();
    transactionDB.deleteTransaction(deleteID);
    await dBtoTransaction();
  }

  Future<void> dBtoTransaction() async {
    final transactionDB = TransactionDB();
    final listofTransaction = await transactionDB.getTransaction();
    accountList.clear();
    incomeaccountList.clear();
    expenseaccountList.clear();
    transferaccountList.clear();
    filteredaccountList = accountList = listofTransaction.toList();
    accountList.sort((first, second) {
      return second.transactiondate.compareTo(first.transactiondate);
    });
    filteredaccountList.sort((first, second) {
      return second.transactiondate.compareTo(first.transactiondate);
    });

    incomeaccountList = listofTransaction
        .where((element) => element.type == TransactionCategoryType.income)
        .toList();
    accIncome = sumOfIncomeAccounts();

    List<TransactionModel> filterList(
        List<TransactionModel> sourceList, String categoryName) {
      return sourceList
          .where((element) => element.categoryname == categoryName)
          .toList();
    }

    double calculateSum(List<TransactionModel> transactionList) {
      return transactionList
          .map((e) => double.parse(e.amount))
          .fold(0, (value, element) => value + element);
    }

    if (incomeaccountList.isNotEmpty) {
      salaryIncomeList.clear();
      freelanceIncomeList.clear();
      rentalIncomeList.clear();
      investmentIncomeList.clear();
      giftIncomeList.clear();
      reimbursementsList.clear();
      refundsList.clear();

      salaryIncomeList = filterList(incomeaccountList, 'Salary');
      if (salaryIncomeList.isNotEmpty) {
        sumofincomesalary = calculateSum(salaryIncomeList);
      } else {
        sumofincomesalary = 0;
      }

      freelanceIncomeList = filterList(incomeaccountList, 'Freelance Income');
      if (freelanceIncomeList.isNotEmpty) {
        sumofincomefreelance = calculateSum(freelanceIncomeList);
      } else {
        sumofincomefreelance = 0;
      }

      rentalIncomeList = filterList(incomeaccountList, 'Rental Income');
      if (rentalIncomeList.isNotEmpty) {
        sumofincomerental = calculateSum(rentalIncomeList);
      } else {
        sumofincomerental = 0;
      }

      investmentIncomeList = filterList(incomeaccountList, 'Investment Income');
      if (investmentIncomeList.isNotEmpty) {
        sumofincomeinvestment = calculateSum(investmentIncomeList);
      } else {
        sumofincomeinvestment = 0;
      }

      giftIncomeList = filterList(incomeaccountList, 'Gift Income');
      if (giftIncomeList.isNotEmpty) {
        sumofincomegift = calculateSum(giftIncomeList);
      } else {
        sumofincomegift = 0;
      }

      reimbursementsList = filterList(incomeaccountList, 'Reimbursements');
      if (reimbursementsList.isNotEmpty) {
        sumofincomereimbursements = calculateSum(reimbursementsList);
      } else {
        sumofincomereimbursements = 0;
      }

      refundsList = filterList(incomeaccountList, 'Refunds');
      if (refundsList.isNotEmpty) {
        sumofincomerefunds = calculateSum(refundsList);
      } else {
        sumofincomerefunds = 0;
      }
      // ... (previous cases)
      dividendIncomeList = filterList(incomeaccountList, 'Dividend Income');
      interestIncomeList = filterList(incomeaccountList, 'Interest Income');
      businessIncomeList = filterList(incomeaccountList, 'Business Income');
      royaltyIncomeList = filterList(incomeaccountList, 'Royalty Income');
      alimonyList = filterList(incomeaccountList, 'Alimony');
      capitalGainsList = filterList(incomeaccountList, 'Capital Gains');
      scholarshipList = filterList(incomeaccountList, 'Scholarship');
      lotteryWinningsList = filterList(incomeaccountList, 'Lottery Winnings');
      if (dividendIncomeList.isNotEmpty) {
        sumofincomedividend = calculateSum(dividendIncomeList);
      } else {
        sumofincomedividend = 0;
      }

      if (interestIncomeList.isNotEmpty) {
        sumofincomeinterest = calculateSum(interestIncomeList);
      } else {
        sumofincomeinterest = 0;
      }

      if (businessIncomeList.isNotEmpty) {
        sumofincomebusiness = calculateSum(businessIncomeList);
      } else {
        sumofincomebusiness = 0;
      }

      if (royaltyIncomeList.isNotEmpty) {
        sumofincomeroyalty = calculateSum(royaltyIncomeList);
      } else {
        sumofincomeroyalty = 0;
      }

      if (alimonyList.isNotEmpty) {
        sumofincomealimony = calculateSum(alimonyList);
      } else {
        sumofincomealimony = 0;
      }

      if (capitalGainsList.isNotEmpty) {
        sumofincomecapitalGains = calculateSum(capitalGainsList);
      } else {
        sumofincomecapitalGains = 0;
      }

      if (scholarshipList.isNotEmpty) {
        sumofincomescholarship = calculateSum(scholarshipList);
      } else {
        sumofincomescholarship = 0;
      }

      if (lotteryWinningsList.isNotEmpty) {
        sumofincomelotteryWinnings = calculateSum(lotteryWinningsList);
      } else {
        sumofincomelotteryWinnings = 0;
      }
    }

    expenseaccountList = listofTransaction
        .where((element) => element.type == TransactionCategoryType.expense)
        .toList();
    accExpense = sumofAccounts();

    if (expenseaccountList.isNotEmpty) {
      housingExpenseList.clear();
      utilitiesExpenseList.clear();
      groceriesExpenseList.clear();
      transportationExpenseList.clear();
      healthCareExpenseList.clear();
      insuranceExpenseList.clear();
      educationExpenseList.clear();
      entertainmentExpenseList.clear();
      diningOutExpenseList.clear();
      shoppingExpenseList.clear();
      personalCareExpenseList.clear();
      debtPaymentsExpenseList.clear();
      charitableDonationsExpenseList.clear();
      taxesExpenseList.clear();
      miscellaneousExpenseList.clear();

      housingExpenseList = filterList(expenseaccountList, 'Housing');
      if (housingExpenseList.isNotEmpty) {
        sumofexpensehousing = calculateSum(housingExpenseList);
      } else {
        sumofexpensehousing = 0;
      }

      utilitiesExpenseList = filterList(expenseaccountList, 'Utilities');
      if (utilitiesExpenseList.isNotEmpty) {
        sumofexpenseutilities = calculateSum(utilitiesExpenseList);
      } else {
        sumofexpenseutilities = 0;
      }

      groceriesExpenseList = filterList(expenseaccountList, 'Groceries');
      if (groceriesExpenseList.isNotEmpty) {
        sumofexpensegroceries = calculateSum(groceriesExpenseList);
      } else {
        sumofexpensegroceries = 0;
      }

      transportationExpenseList =
          filterList(expenseaccountList, 'Transportation');
      if (transportationExpenseList.isNotEmpty) {
        sumofexpensetransportation = calculateSum(transportationExpenseList);
      } else {
        sumofexpensetransportation = 0;
      }

      healthCareExpenseList = filterList(expenseaccountList, 'Health Care');
      if (healthCareExpenseList.isNotEmpty) {
        sumofexpensehealthCare = calculateSum(healthCareExpenseList);
      } else {
        sumofexpensehealthCare = 0;
      }

      insuranceExpenseList = filterList(expenseaccountList, 'Insurance');
      if (insuranceExpenseList.isNotEmpty) {
        sumofexpenseinsurance = calculateSum(insuranceExpenseList);
      } else {
        sumofexpenseinsurance = 0;
      }

      educationExpenseList = filterList(expenseaccountList, 'Education');
      if (educationExpenseList.isNotEmpty) {
        sumofexpenseeducation = calculateSum(educationExpenseList);
      } else {
        sumofexpenseeducation = 0;
      }

      entertainmentExpenseList =
          filterList(expenseaccountList, 'Entertainment');
      if (entertainmentExpenseList.isNotEmpty) {
        sumofexpenseentertainment = calculateSum(entertainmentExpenseList);
      } else {
        sumofexpenseentertainment = 0;
      }

      diningOutExpenseList = filterList(expenseaccountList, 'Dining Out');
      if (diningOutExpenseList.isNotEmpty) {
        sumofexpensediningOut = calculateSum(diningOutExpenseList);
      } else {
        sumofexpensediningOut = 0;
      }

      shoppingExpenseList = filterList(expenseaccountList, 'Shopping');
      if (shoppingExpenseList.isNotEmpty) {
        sumofexpenseshopping = calculateSum(shoppingExpenseList);
      } else {
        sumofexpenseshopping = 0;
      }

      personalCareExpenseList = filterList(expenseaccountList, 'Personal Care');
      if (personalCareExpenseList.isNotEmpty) {
        sumofexpensepersonalCare = calculateSum(personalCareExpenseList);
      } else {
        sumofexpensepersonalCare = 0;
      }

      debtPaymentsExpenseList = filterList(expenseaccountList, 'Debt Payments');
      if (debtPaymentsExpenseList.isNotEmpty) {
        sumofexpensedeptPayments = calculateSum(debtPaymentsExpenseList);
      } else {
        sumofexpensedeptPayments = 0;
      }

      charitableDonationsExpenseList =
          filterList(expenseaccountList, 'Charitable Donations');
      if (charitableDonationsExpenseList.isNotEmpty) {
        sumofexpensecharitableDonations =
            calculateSum(charitableDonationsExpenseList);
      } else {
        sumofexpensecharitableDonations = 0;
      }

      taxesExpenseList = filterList(expenseaccountList, 'Taxes');
      if (taxesExpenseList.isNotEmpty) {
        sumofexpensetaxes = calculateSum(taxesExpenseList);
      } else {
        sumofexpensetaxes = 0;
      }

      miscellaneousExpenseList =
          filterList(expenseaccountList, 'Miscellaneous');
      if (miscellaneousExpenseList.isNotEmpty) {
        sumofexpensemiscellaneous = calculateSum(miscellaneousExpenseList);
      } else {
        sumofexpensemiscellaneous = 0;
      }
    }

    transferaccountList = listofTransaction
        .where((element) => element.type == TransactionCategoryType.transfer)
        .toList();
    notifyListeners();
  }

  TransactionModel? generateTheinnerList(List<String> listofuniquecategory,
      List<TransactionModel> incomeaccountList, int index) {
    for (var element in incomeaccountList) {
      if (element.categoryname == listofuniquecategory[index]) {
        return element;
      }
    }
    return null;
  }

  double sumofAccounts() {
    final accountbalances = expenseaccountList
        .map((account) => double.parse(account.amount))
        .toList();
    double sum = accountbalances.fold(
        0, (previousValue, element) => previousValue + element);
    return sum;
  }

  double sumOfIncomeAccounts() {
    final accountbalances = incomeaccountList
        .map((account) => double.parse(account.amount))
        .toList();
    double sum = accountbalances.fold(
        0, (previousValue, element) => previousValue + element);
    return sum;
  }

  Future<void> calculateAccountAmount(
      {required String amounttoBeOperated,
      String? accountName,
      String? fromaccountname,
      String? toaccountname,
      required TransactionCategoryType type}) async {
    final accountDB = AccountDB();
    List<AccountModel> listofaccountmodel = await accountDB.getAccount();

    if (type == TransactionCategoryType.expense) {
      for (var account in listofaccountmodel) {
        if (account.accName == accountName) {
          double accountBalance = double.parse(account.accBalance);
          double substract = double.parse(amounttoBeOperated);
          final sum = (accountBalance - substract).toString();
          final accountmodel = AccountModel(
              id: account.id, accName: account.accName, accBalance: sum);
          await accountDB.insertAccount(accountmodel);
        }
      }
    } else if (type == TransactionCategoryType.income) {
      for (var account in listofaccountmodel) {
        if (account.accName == accountName) {
          double accountBalance = double.parse(account.accBalance);
          double incomeAdded = double.parse(amounttoBeOperated);
          final sum = (accountBalance + incomeAdded).toString();
          final accountmodel = AccountModel(
              id: account.id, accName: account.accName, accBalance: sum);
          await accountDB.insertAccount(accountmodel);
        }
      }
    } else if (type == TransactionCategoryType.transfer) {
      for (var account in listofaccountmodel) {
        if (account.accName == toaccountname) {
          try {
            double accountBalance = double.parse(account.accBalance);
            double transfercalculated = double.parse(amounttoBeOperated);
            final sum = (accountBalance + transfercalculated).toString();
            final accountmodel = AccountModel(
                id: account.id, accName: account.accName, accBalance: sum);
            await accountDB.insertAccount(accountmodel);
          } catch (e) {
            // print('Error parsing values for toaccount: $e');
          }
        }
      }

      for (var account in listofaccountmodel) {
        if (account.accName == fromaccountname) {
          try {
            double accountBalance = double.parse(account.accBalance);
            double transfercalculated = double.parse(amounttoBeOperated);
            final sum = (accountBalance - transfercalculated).toString();
            final accountmodel = AccountModel(
                id: account.id, accName: account.accName, accBalance: sum);
            await accountDB.insertAccount(accountmodel);
          } catch (e) {
            // print('Error parsing values for fromaccount: $e');
          }
        }
      }
    }
  }

  void clearAll() {
    accountnameController.clear();
    amountController.clear();
    toaccountnameController.clear();
    fromaccountnameController.clear();
    dateController.clear();
    categoryController.clear();
    noteController.clear();
    notifyListeners();
  }

  void disposecontrollers() {
    accountnameController.dispose();
    amountController.dispose();
    toaccountnameController.dispose();
    fromaccountnameController.dispose();
    dateController.dispose();
    categoryController.dispose();
    noteController.dispose();
    notifyListeners();
  }
}
