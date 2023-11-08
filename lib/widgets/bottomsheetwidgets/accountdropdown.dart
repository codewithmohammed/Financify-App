import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:financify/providers/account_notifier.dart';
import 'package:financify/providers/filter_notifier.dart';
import 'package:financify/utils/themes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccountDropdownwidget extends StatelessWidget {
  const AccountDropdownwidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'By Account',
          style: TextStyle(color: AppTheme.mainTextColor),
        ),
        Consumer<FilterNotifier>(
            builder: ((context, FilterNotifier, child) => Center(
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2<String>(
                      isExpanded: true,
                      hint: const Text(
                        'Select Item',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppTheme.mainTextColor,
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
                                  style: const TextStyle(
                                    color: AppTheme.mainTextColor,
                                    fontSize: 14,
                                  ),
                                ),
                              ))
                          .toList(),
                      value: FilterNotifier.selectedaccountValue,
                      onChanged: (String? value) {
                        FilterNotifier.setSelectedAccountValue(value);
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
