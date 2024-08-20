import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:financify/providers/transaction_provider.dart';
import 'package:financify/providers/widget_provider.dart';
import 'package:financify/theme/themes.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//

import '../../utils/category.dart';

class TypeDropdownwidget extends StatefulWidget {
  const TypeDropdownwidget({super.key});

  @override
  State<TypeDropdownwidget> createState() => _TypeDropdownwidgetState();
}

class _TypeDropdownwidgetState extends State<TypeDropdownwidget> {
  String? typeselectedValue;
  @override
  Widget build(BuildContext context) {
    final appTheme = Provider.of<AppTheme>(context, listen: true);
    final category = Provider.of<Category>(context, listen: true);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Type',
          style: TextStyle(color: appTheme.mainTextColor),
        ),
        Consumer<TransactionDataProvider>(
            builder: ((context, transactiondataprovider, child) => Center(
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2<String>(
                      isExpanded: true,
                      hint: Text(
                        transactiondataprovider
                                .selectedtypeValue.text.isNotEmpty
                            ? transactiondataprovider.selectedtypeValue.text
                            : 'Select type',
                        style: TextStyle(
                          fontSize: 14,
                          color: appTheme.mainTextColor,
                        ),
                      ),
                      items: category.filtertype
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
                        transactiondataprovider.setSelectedtypeValue(value!);
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
