import 'package:financify/providers/account_notifier.dart';
import 'package:financify/providers/profile_notifiers.dart';
import 'package:financify/providers/transaction_notifier.dart';
import 'package:financify/utils/themes.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class IncomeOperationScreen extends StatefulWidget {
  const IncomeOperationScreen({super.key});

  @override
  State<IncomeOperationScreen> createState() => _IncomeOperationScreenState();
}

class _IncomeOperationScreenState extends State<IncomeOperationScreen> {
  String? accountselectedValue;
  String? categoryselectedValue;
  final _amountkey = GlobalKey<FormState>();
  final TextEditingController categorytextEditingController =
      TextEditingController();
  final TextEditingController accounttextEditingController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    List<String> incomeCategories = [
      'Salary',
      'Freelance Income',
      'Rental Income',
      'Investment Income',
      'Gift Income',
      'Reimbursements',
      'Refunds',
    ];

    return Scaffold(
        backgroundColor: AppTheme.backgroundColor,
        body: Consumer<TransactionDataProvider>(
          builder: ((context, IncomeTransactionDataProvider, child) =>
              (SafeArea(
                child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Icon(
                                Icons.add,
                                color: AppTheme.mainTextColor,
                                size: 50,
                              ),
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
                                            IncomeTransactionDataProvider
                                                .amountController,
                                        onChanged: (value) {
                                          print(IncomeTransactionDataProvider
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
                                      'Account',
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
                                                    .map((accname) =>
                                                        accname.accName)
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
                                                value: accountselectedValue,
                                                onChanged: (value) {
                                                  setState(() {
                                                    accountselectedValue =
                                                        value;
                                                  });
                                                  IncomeTransactionDataProvider
                                                      .accountnameController
                                                      .text = value!;
                                                  print(
                                                      IncomeTransactionDataProvider
                                                          .accountnameController
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
                                                      accounttextEditingController,
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
                                                          accounttextEditingController,
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
                                                onMenuStateChange: (isOpen) {
                                                  if (!isOpen) {
                                                    accounttextEditingController
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
                                            IncomeTransactionDataProvider
                                                .setTransactionDate(
                                                    selectedDate);
                                            print(IncomeTransactionDataProvider
                                                .dateController.text);
                                          }
                                        },
                                        child: Text(
                                          IncomeTransactionDataProvider
                                                      .dateController.text !=
                                                  ''
                                              ? IncomeTransactionDataProvider
                                                  .dateController.text
                                              : 'Select',
                                          style: const TextStyle(
                                              color: AppTheme.mainTextColor),
                                        ))
                                  ],
                                ),
                                Column(
                                  children: [
                                    const Text('Category',
                                        style: TextStyle(
                                            color: AppTheme.accentColor)),
                                    DropdownButtonHideUnderline(
                                      child: DropdownButton2<String>(
                                        isExpanded: true,
                                        hint: const Text(
                                          'Select Category',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: AppTheme.mainTextColor,
                                          ),
                                        ),
                                        items: incomeCategories
                                            .map((item) => DropdownMenuItem(
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
                                        value: categoryselectedValue,
                                        onChanged: (value) {
                                          setState(() {
                                            categoryselectedValue = value;
                                          });
                                          IncomeTransactionDataProvider
                                              .categoryController.text = value!;
                                          print(IncomeTransactionDataProvider
                                              .categoryController.text);
                                        },
                                        buttonStyleData: const ButtonStyleData(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 0),
                                          height: 40,
                                          width: 150,
                                        ),
                                        dropdownStyleData: DropdownStyleData(
                                          maxHeight: 200,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(4),
                                            color: AppTheme.accentColor,
                                          ),
                                        ),
                                        menuItemStyleData:
                                            const MenuItemStyleData(
                                          overlayColor:
                                              MaterialStatePropertyAll(
                                                  AppTheme.backgroundColor),
                                          height: 40,
                                        ),
                                        dropdownSearchData: DropdownSearchData(
                                          searchController:
                                              categorytextEditingController,
                                          searchInnerWidgetHeight: 50,
                                          searchInnerWidget: Container(
                                            height: 50,
                                            padding: const EdgeInsets.only(
                                              top: 8,
                                              bottom: 4,
                                              right: 8,
                                              left: 8,
                                            ),
                                            child: TextFormField(
                                              expands: true,
                                              maxLines: null,
                                              controller:
                                                  categorytextEditingController,
                                              decoration: InputDecoration(
                                                isDense: true,
                                                contentPadding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 10,
                                                  vertical: 8,
                                                ),
                                                hintText:
                                                    'Search for an item...',
                                                hintStyle: const TextStyle(
                                                    fontSize: 12),
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                              ),
                                            ),
                                          ),
                                          searchMatchFn: (item, searchValue) {
                                            return item.value
                                                .toString()
                                                .toLowerCase()
                                                .contains(searchValue);
                                          },
                                        ),
                                        onMenuStateChange: (isOpen) {
                                          if (!isOpen) {
                                            categorytextEditingController
                                                .clear();
                                          }
                                        },
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 80,
                            child: TextFormField(
                              controller:
                                  IncomeTransactionDataProvider.noteController,
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
        ));
  }
}
