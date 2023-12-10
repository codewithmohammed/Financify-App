import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:financify/providers/account_notifier.dart';
import 'package:financify/providers/profile_notifiers.dart';
import 'package:financify/providers/transaction_notifier.dart';
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
    List<String> toAccountItems =
        Provider.of<AccountDataProvider>(context, listen: true).toaccountList;
    List<String> fromAccountItems =
        Provider.of<AccountDataProvider>(context, listen: true).fromaccountList;

    final appTheme = Provider.of<AppTheme>(context, listen: true);
    return Scaffold(
      backgroundColor: appTheme.backgroundColor,
      body: SingleChildScrollView(
        child: Consumer<TransactionDataProvider>(
            builder: ((context, transfertransactiondataprovider, child) =>
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
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          validator: (value) {
                                            if (value == null) {
                                              return "The Amount cant be Empty";
                                            }
                                            return null;
                                          },
                                          controller:
                                              transfertransactiondataprovider
                                                  .amountController,
                                          onChanged: (value) {},
                                          style: TextStyle(
                                              fontSize: 50,
                                              color: appTheme.mainTextColor),
                                          decoration: InputDecoration(
                                              border:
                                                  const UnderlineInputBorder(
                                                      borderSide:
                                                          BorderSide.none),
                                              hintText: "0",
                                              hintStyle: TextStyle(
                                                  color:
                                                      appTheme.mainTextColor)),
                                          keyboardType: const TextInputType
                                              .numberWithOptions(),
                                        ),
                                      ),
                                    ),
                                    Consumer<ProfileDataProvider>(
                                        builder: ((context, profileDataProvider,
                                                child) =>
                                            Text(
                                              profileDataProvider.currencyCode,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        'From Account',
                                        style: TextStyle(
                                            color: appTheme.accentColor),
                                      ),
                                      Consumer<AccountDataProvider>(
                                          builder: ((context,
                                                  accountDataProvider, child) =>
                                              DropdownButtonHideUnderline(
                                                child: DropdownButton2<String>(
                                                  isExpanded: true,
                                                  hint: Text(
                                                    transfertransactiondataprovider
                                                            .fromaccountnameController
                                                            .text
                                                            .isEmpty
                                                        ? 'Select Account'
                                                        : transfertransactiondataprovider
                                                            .fromaccountnameController
                                                            .text,
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      color: appTheme
                                                          .mainTextColor,
                                                    ),
                                                  ),
                                                  items: fromAccountItems
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

                                                  onChanged: (value) {
                                                    if (value == null) {
                                                      return;
                                                    }
                                                    // setState(() {
                                                    //   fromselectedValue = value;
                                                    // });
                                                    // if (value == null) {
                                                    //   return;
                                                    // }

                                                    if (transfertransactiondataprovider
                                                            .fromaccountnameController
                                                            .text
                                                            .isNotEmpty &&
                                                        transfertransactiondataprovider
                                                            .toaccountnameController
                                                            .text
                                                            .isNotEmpty) {
                                                      transfertransactiondataprovider
                                                          .setFromaccount(
                                                              value);
                                                      transfertransactiondataprovider
                                                          .reverseTransferAccounts();
                                                      accountDataProvider
                                                          .removeFromtoAccount(
                                                              value);
                                                    } else if (transfertransactiondataprovider
                                                            .fromaccountnameController
                                                            .text
                                                            .isEmpty &&
                                                        transfertransactiondataprovider
                                                            .toaccountnameController
                                                            .text
                                                            .isNotEmpty) {
                                                   
                                                      accountDataProvider
                                                          .removeFromtoAccount(
                                                              value);
                                                      if (value ==
                                                          transfertransactiondataprovider
                                                              .toaccountnameController
                                                              .text) {
                                                        transfertransactiondataprovider
                                                            .reArrangeTheAccounts(
                                                                accountDataProvider
                                                                    .toaccountList
                                                                    .first);
                                                      }
                                                      transfertransactiondataprovider
                                                          .setFromaccount(
                                                              value);
                                                    } else {
                                                      transfertransactiondataprovider
                                                          .setFromaccount(
                                                              value);
                                                      accountDataProvider
                                                          .removeFromtoAccount(
                                                              value);
                                                    }
                                                  },
                                                  buttonStyleData:
                                                      const ButtonStyleData(
                                                    padding:
                                                        EdgeInsets.symmetric(
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
                                                      color:
                                                          appTheme.accentColor,
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
                                                        fromAccountTextEditingController,
                                                    searchInnerWidgetHeight: 50,
                                                    searchInnerWidget:
                                                        Container(
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
                                                                    .circular(
                                                                        8),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    searchMatchFn:
                                                        (item, searchValue) {
                                                      return item.value
                                                          .toString()
                                                          .toLowerCase()
                                                          .contains(
                                                              searchValue);
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
                                      Text('Date',
                                          style: TextStyle(
                                              color: appTheme.accentColor)),
                                      TextButton(
                                          onPressed: () async {
                                            final selectedDate =
                                                await showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime.now()
                                                  .subtract(const Duration(
                                                      days: 400)),
                                              lastDate: DateTime.now(),
                                            ).then((pickedDate) {
                                              String? formattedDate;
                                              if (pickedDate != null) {
                                                formattedDate =
                                                    DateFormat('dd/MMM/yyyy')
                                                        .format(pickedDate);
                                              }
                                              return formattedDate;
                                            });
                                            if (selectedDate == null) {
                                              return;
                                            } else {
                                              transfertransactiondataprovider
                                                  .setTransactionDate(
                                                      selectedDate);
                                            }
                                          },
                                          child: Text(
                                            transfertransactiondataprovider
                                                        .dateController.text !=
                                                    ''
                                                ? transfertransactiondataprovider
                                                    .dateController.text
                                                : 'Select',
                                            style: TextStyle(
                                                color: appTheme.mainTextColor),
                                          ))
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        'To Account',
                                        style: TextStyle(
                                            color: appTheme.accentColor),
                                      ),
                                      Consumer<AccountDataProvider>(
                                          builder: ((context,
                                                  accountDataProvider, child) =>
                                              DropdownButtonHideUnderline(
                                                child: DropdownButton2<String>(
                                                  isExpanded: true,
                                                  hint: Text(
                                                    transfertransactiondataprovider
                                                            .toaccountnameController
                                                            .text
                                                            .isNotEmpty
                                                        ? transfertransactiondataprovider
                                                            .toaccountnameController
                                                            .text
                                                        : 'Select Account',
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      color: appTheme
                                                          .mainTextColor,
                                                    ),
                                                  ),
                                                  items: toAccountItems
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
                                                  onChanged: (value) {
                                                    if (value == null) {
                                                      return;
                                                    }
                                                    if (value ==
                                                        'choose another account') {
                                                      showPopup(
                                                          context,
                                                          accountDataProvider,
                                                          transfertransactiondataprovider);
                                                    }
                                                    // else if (transfertransactiondataprovider
                                                    //     .fromaccountnameController
                                                    //     .text
                                                    //     .isEmpty) {
                                                    //   transfertransactiondataprovider
                                                    //       .setToaccount(value);
                                                    // }
                                                    else {
                                                      transfertransactiondataprovider
                                                          .setToaccount(value);
                                                      // accountDataProvider
                                                      //     .removeFromtoAccount(
                                                      //         value, false);
                                                    }
                                                  },
                                                  buttonStyleData:
                                                      const ButtonStyleData(
                                                    padding:
                                                        EdgeInsets.symmetric(
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
                                                      color:
                                                          appTheme.accentColor,
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
                                                        toAccountTextEditingController,
                                                    searchInnerWidgetHeight: 50,
                                                    searchInnerWidget:
                                                        Container(
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
                                                                    .circular(
                                                                        8),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    searchMatchFn:
                                                        (item, searchValue) {
                                                      return item.value
                                                          .toString()
                                                          .toLowerCase()
                                                          .contains(
                                                              searchValue);
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
                                controller: transfertransactiondataprovider
                                    .noteController,
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
    );
  }

  Future<dynamic> showPopup(
      BuildContext context,
      AccountDataProvider accountDataProvider,
      TransactionDataProvider transfertransactiondataprovider) {
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
                          final listAccounts = accountDataProvider.accountList
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
                        if (accountnameKey.currentState!.validate()) {
                          transfertransactiondataprovider
                              .setToaccount(_accountnamecontroller.text);
                          Navigator.of(context).pop();
                        }
                      },
                      child: const Text('SET NAME'))
                ],
              )
            ],
          );
        });
  }
}
