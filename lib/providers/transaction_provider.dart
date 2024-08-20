import 'package:financify/db/account_db.dart';
import 'package:financify/db/transaction_db.dart';
import 'package:financify/model/category/accountcategory/account_model.dart';
import 'package:financify/model/category/transactioncategory/transaction_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionDataProvider extends ChangeNotifier {
  double accExpense = 0;
  double accIncome = 0;
  double accTransfered = 0;
  String? homeSortDataType;

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

  List<MapEntry<String, double>> listofincomeCategoryAdded = [];
  String? incomeCategorySortDataType;
  double incomeCategoryDateWise = 0;
  List<MapEntry<String, double>> listofexpenseCategoryAdded = [];
  String? expenseCategorySortDataType;
  double expenseCategoryDateWise = 0;

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
  String? tempfromacc;
  String? temptoacc;
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

  void reverseTransferAccounts() {
    if (fromaccountnameController.text == toaccountnameController.text) {
      toaccountnameController.text = tempfromacc!;
      notifyListeners();
    }
  }

  void reArrangeTheAccounts(String toacc) {
    toaccountnameController.text = toacc;
    notifyListeners();
  }

  void setToaccount(String toacc) {
    if (toaccountnameController.text.isNotEmpty) {
      temptoacc = toaccountnameController.text;
    }
    toaccountnameController.text = toacc;
    notifyListeners();
  }

  void setFromaccount(String fromacc) {
    if (fromaccountnameController.text.isNotEmpty) {
      tempfromacc = fromaccountnameController.text;
    }
    fromaccountnameController.text = fromacc;
    notifyListeners();
  }

  void setSelecteddateValue(String value) {
    selectedaDateValue.text = value;
    notifyListeners();
  }

  void setSelectedAccountValue(String value) {
    selectedaccountValue.text = value;

    notifyListeners();
  }

  void setSelectedCategoryValue(String value) {
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

  cancelSearch() async {
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
    await transactionDB.deleteTransaction(deleteID);
    await dBtoTransaction();
  }

  String? selectDate(String whichDate) {
    String formattedDate;
    DateTime today = DateTime.now();
    switch (whichDate) {
      case 'All Time':
        return null;
      case 'Today':
        formattedDate = DateFormat('dd/MMM/yyyy').format(today);
        return formattedDate;
      case 'Yesterday':
        DateTime yesterday = today.subtract(const Duration(days: 1));
        formattedDate = DateFormat('dd/MMM/yyyy').format(yesterday);
        return formattedDate;
      case 'This Month':
        formattedDate = DateFormat('MMM/yyyy').format(today);
        return formattedDate;
      case 'Last Month':
        DateTime lastMonth = today.subtract(const Duration(days: 30));
        formattedDate = DateFormat('MMM/yyyy').format(lastMonth);
        return formattedDate;
      case 'This Year':
        formattedDate = DateFormat('yyyy').format(today);
        return formattedDate;
      case 'Last Year':
        DateTime lastYear = today.subtract(const Duration(days: 365));
        formattedDate = DateFormat('yyyy').format(lastYear);
        return formattedDate;
      default:
        return null;
    }
  }

  void sortThePieChartforCategory(
      String filteringDate, String filteringValue, bool isForIncome) {
    if (isForIncome) {
      listofincomeCategoryAdded.clear();
      incomeCategorySortDataType = filteringValue;
      final filteringDateSalarylist =
          filterList(salaryIncomeList, filteringDate, true);
      final filteringDateFreelanceIncomelist =
          filterList(freelanceIncomeList, filteringDate, true);
      final filteringDateRentalIncomeList =
          filterList(rentalIncomeList, filteringDate, true);
      final filteringDateInvestmentIncomeList =
          filterList(investmentIncomeList, filteringDate, true);
      final filteringDateGiftIncomeList =
          filterList(giftIncomeList, filteringDate, true);
      final filteringDateReimbursementsList =
          filterList(reimbursementsList, filteringDate, true);
      final filteringDateRefundsList =
          filterList(refundsList, filteringDate, true);
      final filteringDateDividendIncomeList =
          filterList(dividendIncomeList, filteringDate, true);
      final filteringDateInterestIncomeList =
          filterList(interestIncomeList, filteringDate, true);
      final filteringDateBusinessIncomeList =
          filterList(businessIncomeList, filteringDate, true);
      final filteringDateRoyaltyIncomeList =
          filterList(royaltyIncomeList, filteringDate, true);
      final filteringDateAlimonyList =
          filterList(alimonyList, filteringDate, true);
      final filteringDateCapitalGainsList =
          filterList(capitalGainsList, filteringDate, true);
      final filteringDateScholarshipList =
          filterList(scholarshipList, filteringDate, true);
      final filteringDateLotteryWinningsList =
          filterList(lotteryWinningsList, filteringDate, true);

      if (filteringDateSalarylist.isNotEmpty) {
        sumofincomesalary =
            calculateSumIncome(filteringDateSalarylist, 'Salary');
      } else {
        sumofincomesalary = 0;
      }

      if (filteringDateFreelanceIncomelist.isNotEmpty) {
        sumofincomefreelance = calculateSumIncome(
            filteringDateFreelanceIncomelist, 'Freelance Income');
      } else {
        sumofincomefreelance = 0;
      }
      if (filteringDateRentalIncomeList.isNotEmpty) {
        sumofincomerental =
            calculateSumIncome(filteringDateRentalIncomeList, 'Rental Income');
      } else {
        sumofincomerental = 0;
      }
      if (filteringDateInvestmentIncomeList.isNotEmpty) {
        sumofincomeinvestment = calculateSumIncome(
            filteringDateInvestmentIncomeList, 'Investment Income');
      } else {
        sumofincomeinvestment = 0;
      }

      if (filteringDateGiftIncomeList.isNotEmpty) {
        sumofincomegift =
            calculateSumIncome(filteringDateGiftIncomeList, 'Gift Income');
      } else {
        sumofincomegift = 0;
      }

      if (filteringDateReimbursementsList.isNotEmpty) {
        sumofincomereimbursements = calculateSumIncome(
            filteringDateReimbursementsList, 'Reimbursements');
      } else {
        sumofincomereimbursements = 0;
      }

      if (filteringDateRefundsList.isNotEmpty) {
        sumofincomerefunds =
            calculateSumIncome(filteringDateRefundsList, 'Refunds');
      } else {
        sumofincomerefunds = 0;
      }

      if (filteringDateDividendIncomeList.isNotEmpty) {
        sumofincomedividend = calculateSumIncome(
            filteringDateDividendIncomeList, 'Dividend Income');
      } else {
        sumofincomedividend = 0;
      }

      if (filteringDateInterestIncomeList.isNotEmpty) {
        sumofincomeinterest = calculateSumIncome(
            filteringDateInterestIncomeList, 'Interest Income');
      } else {
        sumofincomeinterest = 0;
      }

      if (filteringDateBusinessIncomeList.isNotEmpty) {
        sumofincomebusiness = calculateSumIncome(
            filteringDateBusinessIncomeList, 'Business Income');
      } else {
        sumofincomebusiness = 0;
      }

      if (filteringDateRoyaltyIncomeList.isNotEmpty) {
        sumofincomeroyalty = calculateSumIncome(
            filteringDateRoyaltyIncomeList, 'Royalty Income');
      } else {
        sumofincomeroyalty = 0;
      }

      if (filteringDateAlimonyList.isNotEmpty) {
        sumofincomealimony =
            calculateSumIncome(filteringDateAlimonyList, 'Alimony');
      } else {
        sumofincomealimony = 0;
      }

      if (filteringDateCapitalGainsList.isNotEmpty) {
        sumofincomecapitalGains =
            calculateSumIncome(filteringDateCapitalGainsList, 'Capital Gains');
      } else {
        sumofincomecapitalGains = 0;
      }

      if (filteringDateScholarshipList.isNotEmpty) {
        sumofincomescholarship =
            calculateSumIncome(filteringDateScholarshipList, 'Scholarship');
      } else {
        sumofincomescholarship = 0;
      }

      if (filteringDateLotteryWinningsList.isNotEmpty) {
        sumofincomelotteryWinnings = calculateSumIncome(
            filteringDateLotteryWinningsList, 'Lottery Winnings');
      } else {
        sumofincomelotteryWinnings = 0;
      }
      incomeCategoryDateWise = listofincomeCategoryAdded.fold(0.0,
          (double sum, MapEntry<String, double> entry) => sum + entry.value);
    } else if (!isForIncome) {
      listofexpenseCategoryAdded.clear();
      expenseCategorySortDataType = filteringValue;
      final filteringDateHousinglist =
          filterList(housingExpenseList, filteringDate, true);
      final filteringDateUtilitieslist =
          filterList(utilitiesExpenseList, filteringDate, true);
      final filteringDateGroceriesList =
          filterList(groceriesExpenseList, filteringDate, true);
      final filteringDateTransportationList =
          filterList(transportationExpenseList, filteringDate, true);
      final filteringDateHealthCareList =
          filterList(healthCareExpenseList, filteringDate, true);
      final filteringDateInsuranceList =
          filterList(insuranceExpenseList, filteringDate, true);
      final filteringDateEducationList =
          filterList(educationExpenseList, filteringDate, true);
      final filteringDateEntertainmentList =
          filterList(entertainmentExpenseList, filteringDate, true);
      final filteringDateDiningOutList =
          filterList(diningOutExpenseList, filteringDate, true);
      final filteringDateShoppingList =
          filterList(shoppingExpenseList, filteringDate, true);
      final filteringDatePersonalCareList =
          filterList(personalCareExpenseList, filteringDate, true);
      final filteringDateDebtPaymentsList =
          filterList(debtPaymentsExpenseList, filteringDate, true);
      final filteringDateCharitableDonationsList =
          filterList(charitableDonationsExpenseList, filteringDate, true);
      final filteringDateTaxesList =
          filterList(taxesExpenseList, filteringDate, true);
      final filteringDateMiscellaneousList =
          filterList(miscellaneousExpenseList, filteringDate, true);

      if (filteringDateHousinglist.isNotEmpty) {
        sumofexpensehousing =
            calculateSumExpense(filteringDateHousinglist, 'Housing');
      } else {
        sumofexpensehousing = 0;
      }
      if (filteringDateUtilitieslist.isNotEmpty) {
        sumofexpenseutilities =
            calculateSumExpense(filteringDateUtilitieslist, 'Utilities');
      } else {
        sumofexpenseutilities = 0;
      }
      if (filteringDateGroceriesList.isNotEmpty) {
        sumofexpensegroceries =
            calculateSumExpense(filteringDateGroceriesList, 'Groceries');
      } else {
        sumofexpensegroceries = 0;
      }

      if (filteringDateTransportationList.isNotEmpty) {
        sumofexpensetransportation = calculateSumExpense(
            filteringDateTransportationList, 'Transportation');
      } else {
        sumofexpensetransportation = 0;
      }

      if (filteringDateHealthCareList.isNotEmpty) {
        sumofexpensehealthCare =
            calculateSumExpense(filteringDateHealthCareList, 'Health Care');
      } else {
        sumofexpensehealthCare = 0;
      }

      if (filteringDateInsuranceList.isNotEmpty) {
        sumofexpenseinsurance =
            calculateSumExpense(filteringDateInsuranceList, 'Insurance');
      } else {
        sumofexpenseinsurance = 0;
      }

      if (filteringDateEducationList.isNotEmpty) {
        sumofexpenseeducation =
            calculateSumExpense(filteringDateEducationList, 'Education');
      } else {
        sumofexpenseeducation = 0;
      }

      if (filteringDateEntertainmentList.isNotEmpty) {
        sumofexpenseentertainment = calculateSumExpense(
            filteringDateEntertainmentList, 'Entertainment');
      } else {
        sumofexpenseentertainment = 0;
      }

      if (filteringDateDiningOutList.isNotEmpty) {
        sumofexpensediningOut =
            calculateSumExpense(filteringDateDiningOutList, 'Dining Out');
      } else {
        sumofexpensediningOut = 0;
      }

      if (filteringDateShoppingList.isNotEmpty) {
        sumofexpenseshopping =
            calculateSumExpense(filteringDateShoppingList, 'Shopping');
      } else {
        sumofexpenseshopping = 0;
      }

      if (filteringDatePersonalCareList.isNotEmpty) {
        sumofexpensepersonalCare =
            calculateSumExpense(filteringDatePersonalCareList, 'Personal Care');
      } else {
        sumofexpensepersonalCare = 0;
      }

      if (filteringDateDebtPaymentsList.isNotEmpty) {
        sumofexpensedeptPayments =
            calculateSumExpense(filteringDateDebtPaymentsList, 'Debt Payments');
      } else {
        sumofexpensedeptPayments = 0;
      }

      if (filteringDateCharitableDonationsList.isNotEmpty) {
        sumofexpensecharitableDonations = calculateSumExpense(
            filteringDateCharitableDonationsList, 'Charitable Donations');
      } else {
        sumofexpensecharitableDonations = 0;
      }

      if (filteringDateTaxesList.isNotEmpty) {
        sumofexpensetaxes =
            calculateSumExpense(filteringDateTaxesList, 'Taxes');
      } else {
        sumofexpensetaxes = 0;
      }

      if (filteringDateMiscellaneousList.isNotEmpty) {
        sumofexpensemiscellaneous = calculateSumExpense(
            filteringDateMiscellaneousList, 'Miscellaneous');
      } else {
        sumofexpensemiscellaneous = 0;
      }
      expenseCategoryDateWise = listofexpenseCategoryAdded.fold(0.0,
          (double sum, MapEntry<String, double> entry) => sum + entry.value);
    }

    notifyListeners();
  }

  void sortThePieChartforHome(String filteringDate, String filteringValue) {
    homeSortDataType = filteringValue;
    final listOfSortedDateTransaction = accountList
        .where((element) => element.transactiondate.contains(filteringDate));
    final listOfSortedDateIncomeTransaction = listOfSortedDateTransaction
        .where((element) => element.type == TransactionCategoryType.income)
        .toList();
    final listOfSortedDateExpenseTransaction = listOfSortedDateTransaction
        .where((element) => element.type == TransactionCategoryType.expense)
        .toList();
    final listOfSortedDateTransferTransaction = listOfSortedDateTransaction
        .where((element) => element.type == TransactionCategoryType.transfer)
        .toList();
    accIncome = sumofIncomeAccounts(listOfSortedDateIncomeTransaction);
    accExpense = sumofExpenseAccounts(listOfSortedDateExpenseTransaction);
    accTransfered = sumofTransferAccounts(listOfSortedDateTransferTransaction);
    notifyListeners();
  }

  double calculateSumIncome(
      List<TransactionModel> transactionList, String category) {
    final double calculatedsum = transactionList
        .map((e) => double.parse(e.amount))
        .fold(0, (value, element) => value + element);
    listofincomeCategoryAdded.add(MapEntry(category, calculatedsum));
    return calculatedsum;
  }

  double calculateSumExpense(
      List<TransactionModel> transactionList, String category) {
    final double calculatedsum = transactionList
        .map((e) => double.parse(e.amount))
        .fold(0, (value, element) => value + element);
    listofexpenseCategoryAdded.add(MapEntry(category, calculatedsum));
    return calculatedsum;
  }

  List<TransactionModel> filterList(List<TransactionModel> sourceList,
      String filteringChecker, bool isforSortingIncomeDate) {
    if (!isforSortingIncomeDate) {
      return sourceList
          .where((element) => element.categoryname == filteringChecker)
          .toList();
    } else {
      return sourceList
          .where(
              (element) => element.transactiondate.contains(filteringChecker))
          .toList();
    }
  }

  Future<void> dBtoTransaction() async {
    expenseCategorySortDataType =
        incomeCategorySortDataType = homeSortDataType = 'All Time';
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
    //sort for home according to date

    filteredaccountList.sort((first, second) {
      return second.transactiondate.compareTo(first.transactiondate);
    });
    incomeaccountList = listofTransaction
        .where((element) => element.type == TransactionCategoryType.income)
        .toList();
    accIncome = sumofIncomeAccounts(incomeaccountList);

    if (incomeaccountList.isNotEmpty) {
      listofincomeCategoryAdded.clear();
      salaryIncomeList.clear();
      freelanceIncomeList.clear();
      rentalIncomeList.clear();
      investmentIncomeList.clear();
      giftIncomeList.clear();
      reimbursementsList.clear();
      refundsList.clear();
      dividendIncomeList.clear();
      interestIncomeList.clear();
      businessIncomeList.clear();
      royaltyIncomeList.clear();
      alimonyList.clear();
      capitalGainsList.clear();
      scholarshipList.clear();
      lotteryWinningsList.clear();

      salaryIncomeList = filterList(incomeaccountList, 'Salary', false);
      freelanceIncomeList =
          filterList(incomeaccountList, 'Freelance Income', false);
      rentalIncomeList = filterList(incomeaccountList, 'Rental Income', false);
      investmentIncomeList =
          filterList(incomeaccountList, 'Investment Income', false);
      giftIncomeList = filterList(incomeaccountList, 'Gift Income', false);
      reimbursementsList =
          filterList(incomeaccountList, 'Reimbursements', false);
      refundsList = filterList(incomeaccountList, 'Refunds', false);
      dividendIncomeList =
          filterList(incomeaccountList, 'Dividend Income', false);
      interestIncomeList =
          filterList(incomeaccountList, 'Interest Income', false);
      businessIncomeList =
          filterList(incomeaccountList, 'Business Income', false);
      royaltyIncomeList =
          filterList(incomeaccountList, 'Royalty Income', false);
      alimonyList = filterList(incomeaccountList, 'Alimony', false);
      capitalGainsList = filterList(incomeaccountList, 'Capital Gains', false);
      scholarshipList = filterList(incomeaccountList, 'Scholarship', false);
      lotteryWinningsList =
          filterList(incomeaccountList, 'Lottery Winnings', false);

      if (salaryIncomeList.isNotEmpty) {
        sumofincomesalary = calculateSumIncome(salaryIncomeList, 'Salary');
      } else {
        sumofincomesalary = 0;
      }

      if (freelanceIncomeList.isNotEmpty) {
        sumofincomefreelance =
            calculateSumIncome(freelanceIncomeList, 'Freelance Income');
      } else {
        sumofincomefreelance = 0;
      }

      if (rentalIncomeList.isNotEmpty) {
        sumofincomerental =
            calculateSumIncome(rentalIncomeList, 'Rental Income');
      } else {
        sumofincomerental = 0;
      }

      if (investmentIncomeList.isNotEmpty) {
        sumofincomeinvestment =
            calculateSumIncome(investmentIncomeList, 'Investment Income');
      } else {
        sumofincomeinvestment = 0;
      }

      if (giftIncomeList.isNotEmpty) {
        sumofincomegift = calculateSumIncome(giftIncomeList, 'Gift Income');
      } else {
        sumofincomegift = 0;
      }

      if (reimbursementsList.isNotEmpty) {
        sumofincomereimbursements =
            calculateSumIncome(reimbursementsList, 'Reimbursements');
      } else {
        sumofincomereimbursements = 0;
      }

      if (refundsList.isNotEmpty) {
        sumofincomerefunds = calculateSumIncome(refundsList, 'Refunds');
      } else {
        sumofincomerefunds = 0;
      }
      // ... (previous cases)

      if (dividendIncomeList.isNotEmpty) {
        sumofincomedividend =
            calculateSumIncome(dividendIncomeList, 'Dividend Income');
      } else {
        sumofincomedividend = 0;
      }

      if (interestIncomeList.isNotEmpty) {
        sumofincomeinterest =
            calculateSumIncome(interestIncomeList, 'Interest Income');
      } else {
        sumofincomeinterest = 0;
      }

      if (businessIncomeList.isNotEmpty) {
        sumofincomebusiness =
            calculateSumIncome(businessIncomeList, 'Business Income');
      } else {
        sumofincomebusiness = 0;
      }

      if (royaltyIncomeList.isNotEmpty) {
        sumofincomeroyalty =
            calculateSumIncome(royaltyIncomeList, 'Royalty Income');
      } else {
        sumofincomeroyalty = 0;
      }

      if (alimonyList.isNotEmpty) {
        sumofincomealimony = calculateSumIncome(alimonyList, 'Alimony');
      } else {
        sumofincomealimony = 0;
      }

      if (capitalGainsList.isNotEmpty) {
        sumofincomecapitalGains =
            calculateSumIncome(capitalGainsList, 'Capital Gains');
      } else {
        sumofincomecapitalGains = 0;
      }

      if (scholarshipList.isNotEmpty) {
        sumofincomescholarship =
            calculateSumIncome(scholarshipList, 'Scholarship');
      } else {
        sumofincomescholarship = 0;
      }

      if (lotteryWinningsList.isNotEmpty) {
        sumofincomelotteryWinnings =
            calculateSumIncome(lotteryWinningsList, 'Lottery Winnings');
      } else {
        sumofincomelotteryWinnings = 0;
      }
    }

    incomeCategoryDateWise = listofincomeCategoryAdded.fold(
        0.0, (double sum, MapEntry<String, double> entry) => sum + entry.value);


    expenseaccountList = listofTransaction
        .where((element) => element.type == TransactionCategoryType.expense)
        .toList();
    accExpense = sumofExpenseAccounts(expenseaccountList);

    if (expenseaccountList.isNotEmpty) {
      listofexpenseCategoryAdded.clear();
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

      housingExpenseList = filterList(expenseaccountList, 'Housing', false);
      utilitiesExpenseList = filterList(expenseaccountList, 'Utilities', false);
      groceriesExpenseList = filterList(expenseaccountList, 'Groceries', false);
      transportationExpenseList =
          filterList(expenseaccountList, 'Transportation', false);
      healthCareExpenseList =
          filterList(expenseaccountList, 'Health Care', false);
      insuranceExpenseList = filterList(expenseaccountList, 'Insurance', false);
      educationExpenseList = filterList(expenseaccountList, 'Education', false);
      entertainmentExpenseList =
          filterList(expenseaccountList, 'Entertainment', false);
      diningOutExpenseList =
          filterList(expenseaccountList, 'Dining Out', false);
      shoppingExpenseList = filterList(expenseaccountList, 'Shopping', false);
      personalCareExpenseList =
          filterList(expenseaccountList, 'Personal Care', false);
      debtPaymentsExpenseList =
          filterList(expenseaccountList, 'Debt Payments', false);
      charitableDonationsExpenseList =
          filterList(expenseaccountList, 'Charitable Donations', false);
      taxesExpenseList = filterList(expenseaccountList, 'Taxes', false);
      miscellaneousExpenseList =
          filterList(expenseaccountList, 'Miscellaneous', false);

      if (housingExpenseList.isNotEmpty) {
        sumofexpensehousing =
            calculateSumExpense(housingExpenseList, 'Housing');
      } else {
        sumofexpensehousing = 0;
      }

      if (utilitiesExpenseList.isNotEmpty) {
        sumofexpenseutilities =
            calculateSumExpense(utilitiesExpenseList, 'Utilities');
      } else {
        sumofexpenseutilities = 0;
      }

      if (groceriesExpenseList.isNotEmpty) {
        sumofexpensegroceries =
            calculateSumExpense(groceriesExpenseList, 'Groceries');
      } else {
        sumofexpensegroceries = 0;
      }

      if (transportationExpenseList.isNotEmpty) {
        sumofexpensetransportation =
            calculateSumExpense(transportationExpenseList, 'Transportation');
      } else {
        sumofexpensetransportation = 0;
      }

      if (healthCareExpenseList.isNotEmpty) {
        sumofexpensehealthCare =
            calculateSumExpense(healthCareExpenseList, 'Health Care');
      } else {
        sumofexpensehealthCare = 0;
      }

      if (insuranceExpenseList.isNotEmpty) {
        sumofexpenseinsurance =
            calculateSumExpense(insuranceExpenseList, 'Insurance');
      } else {
        sumofexpenseinsurance = 0;
      }

      if (educationExpenseList.isNotEmpty) {
        sumofexpenseeducation =
            calculateSumExpense(educationExpenseList, 'Education');
      } else {
        sumofexpenseeducation = 0;
      }

      if (entertainmentExpenseList.isNotEmpty) {
        sumofexpenseentertainment =
            calculateSumExpense(entertainmentExpenseList, 'Entertainment');
      } else {
        sumofexpenseentertainment = 0;
      }

      if (diningOutExpenseList.isNotEmpty) {
        sumofexpensediningOut =
            calculateSumExpense(diningOutExpenseList, 'Dining Out');
      } else {
        sumofexpensediningOut = 0;
      }

      if (shoppingExpenseList.isNotEmpty) {
        sumofexpenseshopping =
            calculateSumExpense(shoppingExpenseList, 'Shopping');
      } else {
        sumofexpenseshopping = 0;
      }

      if (personalCareExpenseList.isNotEmpty) {
        sumofexpensepersonalCare =
            calculateSumExpense(personalCareExpenseList, 'Personal Care');
      } else {
        sumofexpensepersonalCare = 0;
      }

      if (debtPaymentsExpenseList.isNotEmpty) {
        sumofexpensedeptPayments =
            calculateSumExpense(debtPaymentsExpenseList, 'Debt Payments');
      } else {
        sumofexpensedeptPayments = 0;
      }

      if (charitableDonationsExpenseList.isNotEmpty) {
        sumofexpensecharitableDonations = calculateSumExpense(
            charitableDonationsExpenseList, 'Charitable Donations');
      } else {
        sumofexpensecharitableDonations = 0;
      }

      if (taxesExpenseList.isNotEmpty) {
        sumofexpensetaxes = calculateSumExpense(taxesExpenseList, 'Taxes');
      } else {
        sumofexpensetaxes = 0;
      }

      if (miscellaneousExpenseList.isNotEmpty) {
        sumofexpensemiscellaneous =
            calculateSumExpense(miscellaneousExpenseList, 'Miscellaneous');
      } else {
        sumofexpensemiscellaneous = 0;
      }
      expenseCategoryDateWise = listofexpenseCategoryAdded.fold(0.0,
          (double sum, MapEntry<String, double> entry) => sum + entry.value);
    }

    transferaccountList = listofTransaction
        .where((element) => element.type == TransactionCategoryType.transfer)
        .toList();
    accTransfered = sumofTransferAccounts(transferaccountList);
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

  double sumofExpenseAccounts(List<TransactionModel> expenseaccountList) {
    final accountbalances = expenseaccountList
        .map((account) => double.parse(account.amount))
        .toList();
    double sum = accountbalances.fold(
        0, (previousValue, element) => previousValue + element);
    return sum;
  }

  double sumofIncomeAccounts(List<TransactionModel> incomeaccountList) {
    final accountbalances = incomeaccountList
        .map((account) => double.parse(account.amount))
        .toList();
    double sum = accountbalances.fold(
        0, (previousValue, element) => previousValue + element);
    return sum;
  }

  double sumofTransferAccounts(List<TransactionModel> transferaccountList) {
    final filteredTransferAccounts = transferaccountList
        .where((element) => element.toaccountname != element.fromaccountname)
        .toList();
    final accountbalances = filteredTransferAccounts
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

  Future<void> deleteAllTransactionUnderAccount(String accountname) async {
    List<TransactionModel> deletingModels = accountList
        .where((element) =>
            element.accountname == accountname ||
            element.fromaccountname == accountname ||
            element.toaccountname == accountname)
        .toList();
    if (deletingModels.isNotEmpty) {
      for (int i = 0; i < deletingModels.length; i++) {
        await deleteTransaction(deletingModels[i].id);
      }
    } else {
      return;
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
