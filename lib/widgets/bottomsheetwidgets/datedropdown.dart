
import 'package:financify/providers/transaction_notifier.dart';
import 'package:financify/providers/widgetnotifier.dart';
import 'package:financify/utils/themes.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DateDropdownwidget extends StatefulWidget {
  const DateDropdownwidget({super.key});

  @override
  State<DateDropdownwidget> createState() => _DateDropdownwidgetState();
}

class _DateDropdownwidgetState extends State<DateDropdownwidget> {
  String? dateselectedValue;
  @override
  Widget build(BuildContext context) {
    final appTheme = Provider.of<AppTheme>(context, listen: true);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'By date',
          style: TextStyle(color: appTheme.mainTextColor),
        ),
        Consumer<TransactionDataProvider>(
            builder: ((context, transactionDataProvider, child) => Center(
                child: TextButton(
                    onPressed: () async {
                      final selectedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate:
                            DateTime.now().subtract(const Duration(days: 30)),
                        lastDate: DateTime.now(),
                      ).then((pickedDate) {
                        String? formattedDate;
                        if (pickedDate != null) {
                          formattedDate = formattedDate =
                              DateFormat('dd/MMM/yyyy').format(pickedDate);
                        }
                        return formattedDate;
                      });
                      if (selectedDate != null) {
                        Provider.of<WidgetNotifier>(context, listen: false)
                            .changeToDone();
                        transactionDataProvider
                            .setSelecteddateValue(selectedDate);
                      }
                    },
                    child: Text(
                      transactionDataProvider.selectedaDateValue.text.isEmpty
                          ? 'Select\n Date'
                          : transactionDataProvider.selectedaDateValue.text,
                      style: TextStyle(color: appTheme.mainTextColor),
                    ))))),
      ],
    );
  }

  // Future<String> pickDate() async {

  // }
}
