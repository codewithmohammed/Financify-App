import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:financify/providers/transaction_notifier.dart';
import 'package:financify/providers/widgetnotifier.dart';
import 'package:financify/utils/themes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryDropdownwidget extends StatefulWidget {
  const CategoryDropdownwidget({super.key});

  @override
  State<CategoryDropdownwidget> createState() => _CategoryDropdownwidgetState();
}

class _CategoryDropdownwidgetState extends State<CategoryDropdownwidget> {
  String? categoryselectedValue;
  @override
  Widget build(BuildContext context) {
    final appTheme = Provider.of<AppTheme>(context, listen: true);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'By Category',
          style: TextStyle(color: appTheme.mainTextColor),
        ),
        Consumer<TransactionDataProvider>(
            builder: ((context, transactiondataprovider, child) => Center(
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2<String>(
                      isExpanded: true,
                      hint: Text(
                        transactiondataprovider
                                .selectedaCategoryValue.text.isNotEmpty
                            ? transactiondataprovider
                                .selectedaCategoryValue.text
                            : 'Select Category',
                        style: TextStyle(
                          fontSize: 14,
                          color: appTheme.mainTextColor,
                        ),
                      ),
                      items: transactiondataprovider.accountList
                          .map((e) => e.categoryname)
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
                        transactiondataprovider
                            .setSelectedCategoryValue(value!);
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
