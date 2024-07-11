import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:financify/providers/account_notifier.dart';
import 'package:financify/providers/transaction_notifier.dart';
import 'package:financify/providers/widgetnotifier.dart';
import 'package:financify/utils/themes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccountDropdownwidget extends StatefulWidget {
  const AccountDropdownwidget({super.key});

  @override
  State<AccountDropdownwidget> createState() => _AccountDropdownwidgetState();
}

class _AccountDropdownwidgetState extends State<AccountDropdownwidget> {
  String? accountselectedValue;
  @override
  Widget build(BuildContext context) {
    final appTheme = Provider.of<AppTheme>(context, listen: true);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'By Account',
          style: TextStyle(color: appTheme.mainTextColor),
        ),
        Consumer<TransactionDataProvider>(
            builder: ((context, transactiondataprovider, child) => Center(
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2<String>(
                      isExpanded: true,
                      hint: Text(
                        transactiondataprovider
                                .selectedaccountValue.text.isNotEmpty
                            ? transactiondataprovider.selectedaccountValue.text
                            : 'Select Account',
                        style: TextStyle(
                          fontSize: 14,
                          color: appTheme.mainTextColor,
                        ),
                      ),
                      items: Provider.of<AccountDataProvider>(context,
                              listen: false)
                          .accountList
                          .map((e) => e.accName)
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
                      value: accountselectedValue,
                      onChanged: (String? value) {
                        Provider.of<WidgetNotifier>(context, listen: false)
                            .changeToDone();
                        setState(() {
                          accountselectedValue = value;
                        });
                        transactiondataprovider.setSelectedAccountValue(value!);
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
                            WidgetStatePropertyAll(appTheme.mainTextColor),
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        height: 40,
                        width: 140,
                      ),
                      menuItemStyleData: MenuItemStyleData(
                        overlayColor:
                            WidgetStatePropertyAll(appTheme.mainTextColor),
                        height: 40,
                      ),
                    ),
                  ),
                ))),
      ],
    );
  }
}
