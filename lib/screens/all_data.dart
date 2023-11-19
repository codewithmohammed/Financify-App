import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:financify/model/category/transactioncategory/transaction_model.dart';
import 'package:financify/providers/account_notifier.dart';
import 'package:financify/providers/transaction_notifier.dart';
import 'package:financify/providers/updatedataprovider.dart';
import 'package:financify/utils/category.dart';
import 'package:financify/utils/themes.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AllTransactionData extends StatelessWidget {
  const AllTransactionData({super.key});

  @override
  Widget build(BuildContext context) {
    final appTheme = Provider.of<AppTheme>(context, listen: true);
    TextEditingController textfieldcontroller = TextEditingController();
    textfieldcontroller.text =
        Provider.of<UpdateDataProvider>(context, listen: true).accountAmount;
    TextEditingController textfieldnotecontroller = TextEditingController();
    textfieldnotecontroller.text =
        Provider.of<UpdateDataProvider>(context, listen: true).transactionNote;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: appTheme.backgroundColor,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back,
              color: appTheme.primaryColor,
            )),
        title: Text(
          'All Records',
          style: TextStyle(color: appTheme.primaryColor),
        ),
        backgroundColor: appTheme.darkblue,
        actions: [
          Consumer<UpdateDataProvider>(
            builder: (context, updateDataProvider, child) => IconButton(
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              ),
              onPressed: () {
                _deleteTransaction(context, updateDataProvider.id);
              },
            ),
          ),
          Consumer<UpdateDataProvider>(
              builder: ((context, updateDataProvider, child) => IconButton(
                    icon: Icon(
                      Icons.check,
                      color: appTheme.primaryColor,
                    ),
                    onPressed: () async {
                      updateDataProvider
                          .updateAccountBalance(textfieldcontroller.text);
                      updateDataProvider
                          .updateAccountNote(textfieldnotecontroller.text);
                      await updateDataProvider.updatetransactionToDB().then(
                          (value) async => await Provider.of<
                                      TransactionDataProvider>(context,
                                  listen: false)
                              .dBtoTransaction()
                              .then((value) => Navigator.of(context).pop()));
                    },
                  ))),
        ],
      ),
      body: Consumer<UpdateDataProvider>(
          builder: ((context, updateDataProvider, child) => SafeArea(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Consumer<Category>(
                        builder: ((context, categorydataprovider, child) =>
                            Consumer<AccountDataProvider>(
                                builder: ((context, accountDataProvider,
                                        child) =>
                                    DropdownButtonHideUnderline(
                                        child: DropdownButton2<String>(
                                      hint: Text(
                                        updateDataProvider.type ==
                                                TransactionCategoryType.transfer
                                            ? updateDataProvider.fromaccountName
                                            : updateDataProvider.categoryName,
                                        style: TextStyle(
                                            color: appTheme.mainTextColor),
                                      ),
                                      isExpanded: true,
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: appTheme.mainTextColor),
                                      items: updateDataProvider.type ==
                                              TransactionCategoryType.expense
                                          ? categorydataprovider
                                              .expenseCategories
                                              .map((item) => DropdownMenuItem(
                                                    value: item,
                                                    child: Text(
                                                      item,
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          color: appTheme
                                                              .mainTextColor),
                                                    ),
                                                  ))
                                              .toList()
                                          : updateDataProvider.type ==
                                                  TransactionCategoryType.income
                                              ? categorydataprovider
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
                                                  .toList()
                                              : accountDataProvider.accountList
                                                  .map((e) => e.accName)
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
                                        if (updateDataProvider.type ==
                                            TransactionCategoryType.transfer) {
                                          updateDataProvider
                                              .updatefromAccountName(value!);
                                        } else {
                                          updateDataProvider
                                              .setUpdatedCategory(value!);
                                        }
                                      },
                                      buttonStyleData: const ButtonStyleData(
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 0),
                                        height: 60,
                                        width: double.infinity,
                                      ),
                                      dropdownStyleData: DropdownStyleData(
                                        maxHeight: 200,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          color: appTheme.accentColor,
                                        ),
                                      ),
                                      menuItemStyleData: MenuItemStyleData(
                                        overlayColor: MaterialStatePropertyAll(
                                            appTheme.backgroundColor),
                                        height: 40,
                                      ),
                                    )))))),
                    Consumer<AccountDataProvider>(
                        builder: ((context, accountdataprovider, child) =>
                            DropdownButtonHideUnderline(
                                child: DropdownButton2<String>(
                              hint: Text(
                                updateDataProvider.type ==
                                        TransactionCategoryType.transfer
                                    ? updateDataProvider.toaccountName
                                    : updateDataProvider.accountName,
                                style: TextStyle(color: appTheme.mainTextColor),
                              ),
                              isExpanded: true,
                              style: TextStyle(
                                  fontSize: 14, color: appTheme.mainTextColor),
                              items: accountdataprovider.accountList
                                  .map((e) => e.accName)
                                  .map((item) => DropdownMenuItem(
                                        value: item,
                                        child: Text(
                                          item,
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: appTheme.mainTextColor),
                                        ),
                                      ))
                                  .toList(),
                              onChanged: (value) {
                                if (updateDataProvider.type ==
                                    TransactionCategoryType.transfer) {
                                  updateDataProvider
                                      .updatetoAccountName(value!);
                                } else {
                                  updateDataProvider.updateAccountName(value!);
                                }
                              },
                              buttonStyleData: const ButtonStyleData(
                                padding: EdgeInsets.symmetric(horizontal: 0),
                                height: 60,
                                width: double.infinity,
                              ),
                              dropdownStyleData: DropdownStyleData(
                                maxHeight: 200,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: appTheme.accentColor,
                                ),
                              ),
                              menuItemStyleData: MenuItemStyleData(
                                overlayColor: MaterialStatePropertyAll(
                                    appTheme.backgroundColor),
                                height: 40,
                              ),
                            )))),
                    Row(children: [
                      Text('Date',
                          style: TextStyle(color: appTheme.accentColor)),
                      TextButton(
                          onPressed: () async {
                            final selectedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now()
                                  .subtract(const Duration(days: 30)),
                              lastDate: DateTime.now(),
                            ).then((pickedDate) {
                              String? formattedDate;
                              if (pickedDate != null) {
                                formattedDate = DateFormat('d/M/y').format(
                                    pickedDate); // Format the date without leading zeros
                              }
                              return formattedDate;
                            });
                            if (selectedDate == null) {
                              return;
                            } else {
                              updateDataProvider
                                  .setTransactionupdateDate(selectedDate);
                            }
                          },
                          child: Text(
                            updateDataProvider.transactionDate != ''
                                ? updateDataProvider.transactionDate
                                : 'Select',
                            style: TextStyle(color: appTheme.mainTextColor),
                          )),
                    ]),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      controller: textfieldcontroller,
                      style: TextStyle(color: appTheme.mainTextColor),
                      decoration: const InputDecoration(
                          hintText: 'Amount',
                          hintStyle: TextStyle(
                              color: Color.fromARGB(179, 255, 255, 255))),
                    ),
                    SizedBox(
                      height: 400,
                      child: TextFormField(
                        controller: textfieldnotecontroller,
                        style: TextStyle(color: appTheme.mainTextColor),
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Amount',
                            hintStyle: TextStyle(
                                color: Color.fromARGB(179, 255, 255, 255))),
                      ),
                    )
                  ],
                ),
              )))),
    );
  }

  void _deleteTransaction(BuildContext ctx, String id) {
    showDialog(
      context: ctx,
      builder: (context) {
        return SimpleDialog(
          title: const Text('Delete Transaction?'),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('CLOSE'),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () async {
                    Provider.of<TransactionDataProvider>(context, listen: false)
                        .deleteTransaction(id);
                    Navigator.of(context).pop(); // Move this line here
                    Navigator.of(ctx).pop(); // Cl
                  },
                  child: const Text('DELETE'),
                ),
              ],
            )
          ],
        );
      },
    );
  }
}
