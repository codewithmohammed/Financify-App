import 'package:financify/providers/account_notifier.dart';
import 'package:financify/providers/profile_notifiers.dart';
import 'package:financify/providers/transaction_notifier.dart';
import 'package:financify/utils/category.dart';
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
        final appTheme = Provider.of<AppTheme>(context, listen: true);
    return Scaffold(
        backgroundColor: appTheme.backgroundColor,
        body: SingleChildScrollView(
          child: Consumer<TransactionDataProvider>(
            builder: ((context, incometransactiondataprovider, child) =>
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
                                Icon(
                                  Icons.add,
                                  color: appTheme.mainTextColor,
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
                                              incometransactiondataprovider
                                                  .amountController,
                                          onChanged: (value) {},
                                          style: TextStyle(
                                              fontSize: 50,
                                              color: appTheme.mainTextColor),
                                          decoration: InputDecoration(
                                              border: const UnderlineInputBorder(
                                                  borderSide: BorderSide.none),
                                              hintText: "0",
                                              hintStyle: TextStyle(
                                                  color: appTheme.mainTextColor)),
                                          keyboardType: const TextInputType
                                              .numberWithOptions(),
                                        ),
                                      ),
                                    ),
                                    Consumer<ProfileDataProvider>(
                                        builder: ((context, profiledataprovider,
                                                child) =>
                                            Text(
                                              profiledataprovider.currencyCode,
                                              style: TextStyle(
                                                  color: appTheme.mainTextColor,
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
                                      Text(
                                        'Account',
                                        style: TextStyle(
                                            color: appTheme.accentColor),
                                      ),
                                      Consumer<AccountDataProvider>(
                                          builder: ((context, accountdataprovider,
                                                  child) =>
                                              DropdownButtonHideUnderline(
                                                child: DropdownButton2<String>(
                                                  isExpanded: true,
                                                  hint: Text(
                                                    'Select Account',
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      color:
                                                          appTheme.mainTextColor,
                                                    ),
                                                  ),
                                                  items: accountdataprovider
                                                      .accountList
                                                      .map((accname) =>
                                                          accname.accName)
                                                      .map((item) =>
                                                          DropdownMenuItem(
                                                            value: item,
                                                            child: Text(
                                                              item,
                                                              style: TextStyle(
                                                                  fontSize: 14,
                                                                  color: appTheme
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
                                                    incometransactiondataprovider
                                                        .accountnameController
                                                        .text = value!;
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
                                                      color: appTheme.accentColor,
                                                    ),
                                                  ),
                                                  menuItemStyleData:
                                                      MenuItemStyleData(
                                                    overlayColor:
                                                        MaterialStatePropertyAll(
                                                            appTheme
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
                                      Text('Date',
                                          style: TextStyle(
                                              color: appTheme.accentColor)),
                                      TextButton(
                                          onPressed: () async {
                                            final selectedDate =
                                                await showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime.now().subtract(
                                                  const Duration(days: 400)),
                                              lastDate: DateTime.now(),
                                            ).then((pickedDate) {
                                              String? formattedDate;
                                              if (pickedDate != null) {
                                                formattedDate = formattedDate =
                                                    DateFormat('dd/MMM/yyyy').format(
                                                        pickedDate);
                                              }
                                              return formattedDate;
                                            });
                                            if (selectedDate == null) {
                                              return;
                                            } else {
                                              incometransactiondataprovider
                                                  .setTransactionDate(
                                                      selectedDate);
                                            }
                                          },
                                          child: Text(
                                            incometransactiondataprovider
                                                        .dateController.text !=
                                                    ''
                                                ? incometransactiondataprovider
                                                    .dateController.text
                                                : 'Select',
                                            style: TextStyle(
                                                color: appTheme.mainTextColor),
                                          ))
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text('Category',
                                          style: TextStyle(
                                              color: appTheme.accentColor)),
                                      Consumer<Category>(
                                          builder: ((context, incomeCategories,
                                                  child) =>
                                              DropdownButtonHideUnderline(
                                                child: DropdownButton2<String>(
                                                  isExpanded: true,
                                                  hint: Text(
                                                    'Select Category',
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      color:
                                                          appTheme.mainTextColor,
                                                    ),
                                                  ),
                                                  items: incomeCategories
                                                      .incomeCategories
                                                      .map((item) =>
                                                          DropdownMenuItem(
                                                            value: item,
                                                            child: Text(
                                                              item,
                                                              style: TextStyle(
                                                                  fontSize: 14,
                                                                  color: appTheme
                                                                      .mainTextColor),
                                                            ),
                                                          ))
                                                      .toList(),
                                                  value: categoryselectedValue,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      categoryselectedValue =
                                                          value;
                                                    });
                                                    incometransactiondataprovider
                                                        .categoryController
                                                        .text = value!;
                                                  },
                                                  buttonStyleData:
                                                      const ButtonStyleData(
                                                    padding: EdgeInsets.symmetric(
                                                        horizontal: 0),
                                                    height: 40,
                                                    width: 150,
                                                  ),
                                                  dropdownStyleData:
                                                      DropdownStyleData(
                                                    maxHeight: 200,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4),
                                                      color: appTheme.accentColor,
                                                    ),
                                                  ),
                                                  menuItemStyleData:
                                                      MenuItemStyleData(
                                                    overlayColor:
                                                        MaterialStatePropertyAll(
                                                            appTheme
                                                                .backgroundColor),
                                                    height: 40,
                                                  ),
                                                  dropdownSearchData:
                                                      DropdownSearchData(
                                                    searchController:
                                                        categorytextEditingController,
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
                                                            categorytextEditingController,
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
                                                      categorytextEditingController
                                                          .clear();
                                                    }
                                                  },
                                                ),
                                              )))
                                    ],
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 80,
                              child: TextFormField(
                                controller:
                                    incometransactiondataprovider.noteController,
                                style: TextStyle(color: appTheme.mainTextColor),
                                decoration: InputDecoration(
                                    hintText: 'Write Any Note',
                                    hintStyle:
                                        TextStyle(color: appTheme.accentColor),
                                    border: const OutlineInputBorder()),
                              ),
                            )
                          ],
                        ),
                      )),
                ))),
          ),
        ));
  }
}
