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
    final updateDataProvider = Provider.of<UpdateDataProvider>(context, listen: true);
    final categoryProvider = Provider.of<Category>(context, listen: true);
    final accountProvider = Provider.of<AccountDataProvider>(context, listen: true);

    TextEditingController textfieldcontroller = TextEditingController();
    textfieldcontroller.text = updateDataProvider.accountAmount;

    TextEditingController textfieldnotecontroller = TextEditingController();
    textfieldnotecontroller.text = updateDataProvider.transactionNote;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: appTheme.backgroundColor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(
            Icons.arrow_back,
            color: appTheme.primaryColor,
          ),
        ),
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
            builder: (context, updateDataProvider, child) => IconButton(
              icon: Icon(
                Icons.check,
                color: appTheme.primaryColor,
              ),
              onPressed: () async {
                updateDataProvider.updateAccountBalance(textfieldcontroller.text);
                updateDataProvider.updateAccountNote(textfieldnotecontroller.text);
                await updateDataProvider.updatetransactionToDB().then(
                  (value) async => await Provider.of<TransactionDataProvider>(context, listen: false)
                      .dBtoTransaction()
                      .then((value) => Navigator.of(context).pop())
                );
              },
            ),
          ),
        ],
      ),
      body: Consumer<UpdateDataProvider>(
        builder: (context, updateDataProvider, child) => SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                buildDropdownButton(context, updateDataProvider, categoryProvider, accountProvider, appTheme),
                const SizedBox(height: 16),
                buildDateSelector(context, updateDataProvider, appTheme),
                const SizedBox(height: 16),
                buildAmountTextField(textfieldcontroller, appTheme),
                const SizedBox(height: 16),
                buildNoteTextField(textfieldnotecontroller, appTheme),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildDropdownButton(
    BuildContext context,
    UpdateDataProvider updateDataProvider,
    Category categoryProvider,
    AccountDataProvider accountProvider,
    AppTheme appTheme
  ) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        hint: Text(
          updateDataProvider.type == TransactionCategoryType.transfer
              ? updateDataProvider.fromaccountName
              : updateDataProvider.categoryName,
          style: TextStyle(color: appTheme.mainTextColor),
        ),
        isExpanded: true,
        style: TextStyle(fontSize: 14, color: appTheme.mainTextColor),
        items: getDropdownItems(updateDataProvider, categoryProvider, accountProvider, appTheme),
        onChanged: (value) {
          if (updateDataProvider.type == TransactionCategoryType.transfer) {
            updateDataProvider.updatefromAccountName(value!);
          } else {
            updateDataProvider.setUpdatedCategory(value!);
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
          overlayColor: WidgetStatePropertyAll(appTheme.backgroundColor),
          height: 40,
        ),
      ),
    );
  }

  List<DropdownMenuItem<String>> getDropdownItems(
    UpdateDataProvider updateDataProvider,
    Category categoryProvider,
    AccountDataProvider accountProvider,
    AppTheme appTheme
  ) {
    if (updateDataProvider.type == TransactionCategoryType.expense) {
      return categoryProvider.expenseCategories.map((item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: TextStyle(fontSize: 14, color: appTheme.mainTextColor),
        ),
      )).toList();
    } else if (updateDataProvider.type == TransactionCategoryType.income) {
      return categoryProvider.incomeCategories.map((item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: TextStyle(fontSize: 14, color: appTheme.mainTextColor),
        ),
      )).toList();
    } else {
      return accountProvider.accountList.map((e) => e.accName).map((item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: TextStyle(fontSize: 14, color: appTheme.mainTextColor),
        ),
      )).toList();
    }
  }

  Widget buildDateSelector(
    BuildContext context,
    UpdateDataProvider updateDataProvider,
    AppTheme appTheme
  ) {
    return Row(
      children: [
        Text('Date', style: TextStyle(color: appTheme.accentColor)),
        TextButton(
          onPressed: () async {
            final selectedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime.now().subtract(const Duration(days: 30)),
              lastDate: DateTime.now(),
            ).then((pickedDate) {
              String? formattedDate;
              if (pickedDate != null) {
                formattedDate = DateFormat('d/M/y').format(pickedDate);
              }
              return formattedDate;
            });
            if (selectedDate != null) {
              updateDataProvider.setTransactionupdateDate(selectedDate);
            }
          },
          child: Text(
            updateDataProvider.transactionDate != '' ? updateDataProvider.transactionDate : 'Select',
            style: TextStyle(color: appTheme.mainTextColor),
          ),
        ),
      ],
    );
  }

  Widget buildAmountTextField(TextEditingController controller, AppTheme appTheme) {
    return TextFormField(
      keyboardType: TextInputType.number,
      controller: controller,
      style: TextStyle(color: appTheme.mainTextColor),
      decoration: InputDecoration(
        hintText: 'Amount',
        hintStyle: TextStyle(color: Color.fromARGB(179, 255, 255, 255)),
        filled: true,
        fillColor: appTheme.accentColor.withOpacity(0.2),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  Widget buildNoteTextField(TextEditingController controller, AppTheme appTheme) {
    return Expanded(
      child: TextFormField(
        controller: controller,
        style: TextStyle(color: appTheme.mainTextColor),
        maxLines: null,
        decoration: InputDecoration(
          hintText: 'Note',
          hintStyle: TextStyle(color: Color.fromARGB(179, 255, 255, 255)),
          filled: true,
          fillColor: appTheme.accentColor.withOpacity(0.2),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
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
                    Provider.of<TransactionDataProvider>(context, listen: false).deleteTransaction(id);
                    Navigator.of(context).pop();
                    Navigator.of(ctx).pop();
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
