import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:financify/model/category/transactioncategory/transaction_model.dart';
import 'package:financify/providers/account_notifier.dart';
import 'package:financify/providers/transaction_notifier.dart';
import 'package:financify/providers/updateData_Provider.dart';
import 'package:financify/utils/category.dart';
import 'package:financify/utils/themes.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AllTransactionData extends StatelessWidget {
  const AllTransactionData({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController textfieldcontroller = TextEditingController();
    textfieldcontroller.text =
        Provider.of<UpdateDataProvider>(context, listen: true).accountAmount;
    TextEditingController textfieldnotecontroller = TextEditingController();
    textfieldnotecontroller.text =
        Provider.of<UpdateDataProvider>(context, listen: true).transactionNote;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: AppTheme.primaryColor,
            )),
        title: const Text(
          'All Records',
          style: TextStyle(color: AppTheme.primaryColor),
        ),
        backgroundColor: AppTheme.darkblue,
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
                    icon: const Icon(
                      Icons.check,
                      color: AppTheme.primaryColor,
                    ),
                    onPressed: () async {
                      updateDataProvider
                          .updateAccountBalance(textfieldcontroller.text);
                      updateDataProvider
                          .updateAccountNote(textfieldnotecontroller.text);
                      await updateDataProvider.updatetransactionToDB();
                      await Provider.of<TransactionDataProvider>(context,
                              listen: false)
                          .dBtoTransaction();
                      Navigator.of(context).pop();
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
                                        style: const TextStyle(
                                            color: AppTheme.mainTextColor),
                                      ),
                                      isExpanded: true,
                                      style: const TextStyle(
                                          fontSize: 14,
                                          color: AppTheme.mainTextColor),
                                      items: updateDataProvider.type ==
                                              TransactionCategoryType.expense
                                          ? categorydataprovider
                                              .expenseCategories
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
                                              .toList()
                                          : updateDataProvider.type ==
                                                  TransactionCategoryType.income
                                              ? categorydataprovider
                                                  .expenseCategories
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
                                                  .toList()
                                              : accountDataProvider.accountList
                                                  .map((e) => e.accName)
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
                                          color: AppTheme.accentColor,
                                        ),
                                      ),
                                      menuItemStyleData:
                                          const MenuItemStyleData(
                                        overlayColor: MaterialStatePropertyAll(
                                            AppTheme.backgroundColor),
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
                                style: const TextStyle(
                                    color: AppTheme.mainTextColor),
                              ),
                              isExpanded: true,
                              style: const TextStyle(
                                  fontSize: 14, color: AppTheme.mainTextColor),
                              items: accountdataprovider.accountList
                                  .map((e) => e.accName)
                                  .map((item) => DropdownMenuItem(
                                        value: item,
                                        child: Text(
                                          item,
                                          style: const TextStyle(
                                              fontSize: 14,
                                              color: AppTheme.mainTextColor),
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
                                  color: AppTheme.accentColor,
                                ),
                              ),
                              menuItemStyleData: const MenuItemStyleData(
                                overlayColor: MaterialStatePropertyAll(
                                    AppTheme.backgroundColor),
                                height: 40,
                              ),
                            )))),
                    Row(children: [
                      const Text('Date',
                          style: TextStyle(color: AppTheme.accentColor)),
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
                                print(
                                    formattedDate); // Use this formattedDate where needed
                              }
                              return formattedDate;
                            });
                            if (selectedDate == null) {
                              return;
                            } else {
                              updateDataProvider
                                  .setTransactionupdateDate(selectedDate);
                              print(updateDataProvider.transactionDate);
                            }
                          },
                          child: Text(
                            updateDataProvider.transactionDate != ''
                                ? updateDataProvider.transactionDate
                                : 'Select',
                            style:
                                const TextStyle(color: AppTheme.mainTextColor),
                          )),
                    ]),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      controller: textfieldcontroller,
                      style: const TextStyle(color: AppTheme.mainTextColor),
                      decoration: const InputDecoration(
                          hintText: 'Amount',
                          hintStyle: TextStyle(
                              color: Color.fromARGB(179, 255, 255, 255))),
                    ),
                    SizedBox(
                      height: 400,
                      child: TextFormField(
                        controller: textfieldnotecontroller,
                        style: const TextStyle(color: AppTheme.mainTextColor),
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
