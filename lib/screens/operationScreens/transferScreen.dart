import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:financify/notifierclass/account_notifier.dart';
import 'package:financify/notifierclass/profile_notifiers.dart';
import 'package:financify/notifierclass/transaction_notifier.dart';
import 'package:financify/notifierclass/transferTransaction_notifier.dart';
import 'package:financify/utils/themes.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class TransferOperationScreen extends StatefulWidget {
  const TransferOperationScreen({super.key});

  @override
  State<TransferOperationScreen> createState() =>
      _TransferOperationScreenState();
}

class _TransferOperationScreenState extends State<TransferOperationScreen> {
  String? fromselectedValue;
  String? toselectedValue;
  final _amountkey = GlobalKey<FormState>();
  final TextEditingController fromAccountTextEditingController =
      TextEditingController();
  final TextEditingController toAccountTextEditingController =
      TextEditingController();
  final TextEditingController _accountnamecontroller = TextEditingController();

  final accountnameKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: Consumer<TransactionDataProvider>(
          builder: ((context, TransferTransactionDataProvider, child) =>
              SafeArea(
                child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const SizedBox(width: 50),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 150,
                                    child: Form(
                                      key: _amountkey,
                                      child: TextFormField(
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        validator: (value) {
                                          if (value == null) {
                                            return "The Amount cant be Empty";
                                          }
                                          return null;
                                        },
                                        controller:
                                            TransferTransactionDataProvider
                                                .amountController,
                                        onChanged: (value) {
                                          print(TransferTransactionDataProvider
                                              .amountController.text);
                                        },
                                        style: const TextStyle(
                                            fontSize: 50,
                                            color: AppTheme.mainTextColor),
                                        decoration: const InputDecoration(
                                            border: UnderlineInputBorder(
                                                borderSide: BorderSide.none),
                                            hintText: "0",
                                            hintStyle: TextStyle(
                                                color: AppTheme.mainTextColor)),
                                        keyboardType: const TextInputType
                                            .numberWithOptions(),
                                      ),
                                    ),
                                  ),
                                  Consumer<ProfileDataProvider>(
                                      builder: ((context, ProfileDataProvider,
                                              child) =>
                                          Text(
                                            ProfileDataProvider.currencyCode,
                                            style: const TextStyle(
                                                color: AppTheme.mainTextColor,
                                                fontSize: 30),
                                          ))),
                                ],
                              )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 150),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  children: [
                                    const Text(
                                      'From Account',
                                      style: TextStyle(
                                          color: AppTheme.accentColor),
                                    ),
                                    Consumer<AccountDataProvider>(
                                        builder: ((context, AccountDataProvider,
                                                child) =>
                                            DropdownButtonHideUnderline(
                                              child: DropdownButton2<String>(
                                                isExpanded: true,
                                                hint: const Text(
                                                  'Select Account',
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color:
                                                        AppTheme.mainTextColor,
                                                  ),
                                                ),
                                                items: AccountDataProvider
                                                    .accountList
                                                    .map((account) =>
                                                        account.accName)
                                                    .map((item) =>
                                                        DropdownMenuItem(
                                                          value: item,
                                                          child: Text(
                                                            item,
                                                            style: const TextStyle(
                                                                fontSize: 14,
                                                                color: AppTheme
                                                                    .mainTextColor),
                                                          ),
                                                        ))
                                                    .toList(),
                                                value: fromselectedValue,
                                                onChanged: (value) {
                                                  setState(() {
                                                    fromselectedValue = value;
                                                  });
                                                  if (value == null) {
                                                    return;
                                                  }
                                                  TransferTransactionDataProvider
                                                      .fromaccountnameController
                                                      .text = value;
                                                  print(TransferTransactionDataProvider
                                                      .fromaccountnameController
                                                      .text);
                                                },
                                                buttonStyleData:
                                                    const ButtonStyleData(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 0),
                                                  height: 40,
                                                  width: 100,
                                                ),
                                                dropdownStyleData:
                                                    DropdownStyleData(
                                                  maxHeight: 200,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4),
                                                    color: AppTheme.accentColor,
                                                  ),
                                                ),
                                                menuItemStyleData:
                                                    const MenuItemStyleData(
                                                  overlayColor:
                                                      MaterialStatePropertyAll(
                                                          AppTheme
                                                              .backgroundColor),
                                                  height: 40,
                                                ),
                                                dropdownSearchData:
                                                    DropdownSearchData(
                                                  searchController:
                                                      fromAccountTextEditingController,
                                                  searchInnerWidgetHeight: 50,
                                                  searchInnerWidget: Container(
                                                    height: 50,
                                                    padding:
                                                        const EdgeInsets.only(
                                                      top: 8,
                                                      bottom: 4,
                                                      right: 8,
                                                      left: 8,
                                                    ),
                                                    child: TextFormField(
                                                      expands: true,
                                                      maxLines: null,
                                                      controller:
                                                          fromAccountTextEditingController,
                                                      decoration:
                                                          InputDecoration(
                                                        isDense: true,
                                                        contentPadding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                          horizontal: 10,
                                                          vertical: 8,
                                                        ),
                                                        hintText:
                                                            'Search for an item...',
                                                        hintStyle:
                                                            const TextStyle(
                                                                fontSize: 12),
                                                        border:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  searchMatchFn:
                                                      (item, searchValue) {
                                                    return item.value
                                                        .toString()
                                                        .toLowerCase()
                                                        .contains(searchValue);
                                                  },
                                                ),
                                                //This to clear the search value when you close the menu
                                                onMenuStateChange: (isOpen) {
                                                  if (!isOpen) {
                                                    fromAccountTextEditingController
                                                        .clear();
                                                  }
                                                },
                                              ),
                                            )))
                                  ],
                                ),
                                Column(
                                  children: [
                                    const Text('Date',
                                        style: TextStyle(
                                            color: AppTheme.accentColor)),
                                    TextButton(
                                        onPressed: () async {
                                          final selectedDate =
                                              await showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime.now().subtract(
                                                const Duration(days: 30)),
                                            lastDate: DateTime.now(),
                                          ).then((pickedDate) {
                                            String? formattedDate;
                                            if (pickedDate != null) {
                                              formattedDate =
                                                  DateFormat('d/M/y').format(
                                                      pickedDate); // Format the date without leading zeros
                                              print(
                                                  formattedDate); // Use this formattedDate where needed
                                            }
                                            return formattedDate;
                                          });
                                          if (selectedDate == null) {
                                            return;
                                          } else {
                                            TransferTransactionDataProvider
                                                .setTransactionDate(
                                                    selectedDate);
                                            print(
                                                TransferTransactionDataProvider
                                                    .dateController
                                                    .text);
                                          }
                                        },
                                        child: Text(
                                          TransferTransactionDataProvider
                                                      .dateController
                                                      .text !=
                                                  ''
                                              ? TransferTransactionDataProvider
                                                  .dateController.text
                                              : 'Select',
                                          style: const TextStyle(
                                              color: AppTheme.mainTextColor),
                                        ))
                                  ],
                                ),
                                Column(
                                  children: [
                                    const Text(
                                      'To Account',
                                      style: TextStyle(
                                          color: AppTheme.accentColor),
                                    ),
                                    Consumer<AccountDataProvider>(
                                        builder: ((context, AccountDataProvider,
                                                child) =>
                                            DropdownButtonHideUnderline(
                                              child: DropdownButton2<String>(
                                                isExpanded: true,
                                                hint: const Text(
                                                  'Select Account',
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color:
                                                        AppTheme.mainTextColor,
                                                  ),
                                                ),
                                                items: AccountDataProvider
                                                    .toaccountList
                                                    .map((item) =>
                                                        DropdownMenuItem(
                                                          value: item,
                                                          child: Text(
                                                            item,
                                                            style: const TextStyle(
                                                                fontSize: 14,
                                                                color: AppTheme
                                                                    .mainTextColor),
                                                          ),
                                                        ))
                                                    .toList(),
                                                value: toselectedValue,
                                                onChanged: (value) {
                                                  if (value ==
                                                      'choose another account') {
                                                    showPopup(
                                                        context,
                                                        AccountDataProvider,
                                                        TransferTransactionDataProvider);
                                                  } else {
                                                    setState(() {
                                                      toselectedValue = value;
                                                    });
                                                    TransferTransactionDataProvider
                                                        .toaccountnameController
                                                        .text = value!;
                                                    print(TransferTransactionDataProvider
                                                        .toaccountnameController
                                                        .text);
                                                  }
                                                },
                                                buttonStyleData:
                                                    const ButtonStyleData(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 0),
                                                  height: 40,
                                                  width: 100,
                                                ),
                                                dropdownStyleData:
                                                    DropdownStyleData(
                                                  maxHeight: 200,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4),
                                                    color: AppTheme.accentColor,
                                                  ),
                                                ),
                                                menuItemStyleData:
                                                    const MenuItemStyleData(
                                                  overlayColor:
                                                      MaterialStatePropertyAll(
                                                          AppTheme
                                                              .backgroundColor),
                                                  height: 40,
                                                ),
                                                dropdownSearchData:
                                                    DropdownSearchData(
                                                  searchController:
                                                      toAccountTextEditingController,
                                                  searchInnerWidgetHeight: 50,
                                                  searchInnerWidget: Container(
                                                    height: 50,
                                                    padding:
                                                        const EdgeInsets.only(
                                                      top: 8,
                                                      bottom: 4,
                                                      right: 8,
                                                      left: 8,
                                                    ),
                                                    child: TextFormField(
                                                      expands: true,
                                                      maxLines: null,
                                                      controller:
                                                          toAccountTextEditingController,
                                                      decoration:
                                                          InputDecoration(
                                                        isDense: true,
                                                        contentPadding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                          horizontal: 10,
                                                          vertical: 8,
                                                        ),
                                                        hintText:
                                                            'Search for an item...',
                                                        hintStyle:
                                                            const TextStyle(
                                                                fontSize: 12),
                                                        border:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  searchMatchFn:
                                                      (item, searchValue) {
                                                    return item.value
                                                        .toString()
                                                        .toLowerCase()
                                                        .contains(searchValue);
                                                  },
                                                ),
                                                //This to clear the search value when you close the menu
                                                onMenuStateChange: (isOpen) {
                                                  if (!isOpen) {
                                                    toAccountTextEditingController
                                                        .clear();
                                                  }
                                                },
                                              ),
                                            )))
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 80,
                            child: TextFormField(
                              controller: TransferTransactionDataProvider
                                  .noteController,
                              style: const TextStyle(
                                  color: AppTheme.mainTextColor),
                              decoration: const InputDecoration(
                                  hintText: 'Write Any Note',
                                  hintStyle:
                                      TextStyle(color: AppTheme.accentColor),
                                  border: OutlineInputBorder()),
                            ),
                          )
                        ],
                      ),
                    )),
              ))),
    );
  }

  Future<dynamic> showPopup(
      BuildContext context,
      AccountDataProvider AccountDataProvider,
     TransactionDataProvider TransferTransactionDataProvider) {
    return showDialog(
        context: context,
        builder: (ctx) {
          return SimpleDialog(
            title: const Text('Set Account name'),
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: SizedBox(
                    height: 50,
                    child: Form(
                      key: accountnameKey,
                      child: TextFormField(
                        controller: _accountnamecontroller,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          final listAccounts = AccountDataProvider.accountList
                              .map((accname) => accname.accName)
                              .toList();
                          for (var account in listAccounts) {
                            if (account == value) {
                              return 'The account name already exists';
                            }
                          }
                          if (value == null || value.trim().isEmpty) {
                            return 'The account Name Cannot be Empty';
                          }
                          return null;
                        },
                        // controller: accountNameController,
                        decoration: const InputDecoration(
                            hintText: 'Account Name',
                            border: OutlineInputBorder()),
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('CLOSE')),
                  ElevatedButton(
                      onPressed: () async {
                        // setState(() {
                        // toselectedValue = _accountnamecontroller.text;
                        // });
                        TransferTransactionDataProvider
                            .toaccountnameController
                            .text = _accountnamecontroller.text;
                        Navigator.of(context).pop();
                      },
                      child: const Text('SET NAME'))
                ],
              )
            ],
          );
        });
  }
}
