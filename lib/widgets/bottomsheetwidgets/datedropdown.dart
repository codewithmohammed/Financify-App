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
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'By date',
          style: TextStyle(color: AppTheme.mainTextColor),
        ),
        Consumer<TransactionDataProvider>(
            builder: ((context, TransactionDataProvider, child) => Center(
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2<String>(
                      isExpanded: true,
                      hint: const Text(
                        'Select date',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppTheme.mainTextColor,
                        ),
                      ),
                      items: TransactionDataProvider.accountList
                          .map((e) => e.transactiondate)
                          .toSet()
                          .map((String item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  style: const TextStyle(
                                    color: AppTheme.mainTextColor,
                                    fontSize: 14,
                                  ),
                                ),
                              ))
                          .toList(),
                      value: dateselectedValue,
                      onChanged: (String? value) {
                        Provider.of<WidgetNotifier>(context, listen: false)
                            .changeToDone();
                        setState(() {
                          dateselectedValue = value;
                        });
                        TransactionDataProvider.setSelecteddateValue(value!);
                      },
                      dropdownStyleData: DropdownStyleData(
                        maxHeight: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: AppTheme.darkblue,
                        ),
                      ),
                      buttonStyleData: const ButtonStyleData(
                        overlayColor:
                            MaterialStatePropertyAll(AppTheme.mainTextColor),
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        height: 40,
                        width: 140,
                      ),
                      menuItemStyleData: const MenuItemStyleData(
                        overlayColor:
                            MaterialStatePropertyAll(AppTheme.mainTextColor),
                        height: 40,
                      ),
                    ),
                  ),
                ))),
      ],
    );
  }
}
