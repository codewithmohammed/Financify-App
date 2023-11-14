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
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'By Category',
          style: TextStyle(color: AppTheme.mainTextColor),
        ),
        Consumer<TransactionDataProvider>(
            builder: ((context, transactiondataprovider, child) => Center(
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2<String>(
                      isExpanded: true,
                      hint: const Text(
                        'Select Category',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppTheme.mainTextColor,
                        ),
                      ),
                      items: transactiondataprovider.accountList
                          .map((e) => e.categoryname)
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
                      value: categoryselectedValue,
                      onChanged: (String? value) {
                        Provider.of<WidgetNotifier>(context, listen: false)
                            .changeToDone();
                        setState(() {
                          categoryselectedValue = value;
                        });
                        transactiondataprovider
                            .setSelectedCategoryValue(value!);
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
