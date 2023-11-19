import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:financify/providers/transaction_notifier.dart';
import 'package:financify/providers/widgetnotifier.dart';
import 'package:financify/utils/themes.dart';
import 'package:flutter/material.dart';
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
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2<String>(
                      isExpanded: true,
                      hint: Text(
                        transactionDataProvider
                                .selectedaDateValue.text.isNotEmpty
                            ? transactionDataProvider.selectedaDateValue.text
                            : 'Select date',
                        style: TextStyle(
                          fontSize: 14,
                          color: appTheme.mainTextColor,
                        ),
                      ),
                      items: transactionDataProvider.accountList
                          .map((e) => e.transactiondate)
                          .toSet()
                          .map((String item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  style: TextStyle(
                                    color: appTheme.mainTextColor,
                                    fontSize: 14,
                                  ),
                                ),
                              ))
                          .toList(),
                      onChanged: (String? value) {
                        Provider.of<WidgetNotifier>(context, listen: false)
                            .changeToDone();

                        transactionDataProvider.setSelecteddateValue(value!);
                      },
                      dropdownStyleData: DropdownStyleData(
                        maxHeight: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: appTheme.darkblue,
                        ),
                      ),
                      buttonStyleData: ButtonStyleData(
                        overlayColor:
                            MaterialStatePropertyAll(appTheme.mainTextColor),
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        height: 40,
                        width: 140,
                      ),
                      menuItemStyleData: MenuItemStyleData(
                        overlayColor:
                            MaterialStatePropertyAll(appTheme.mainTextColor),
                        height: 40,
                      ),
                    ),
                  ),
                ))),
      ],
    );
  }
}
