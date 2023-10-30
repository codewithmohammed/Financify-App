import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:financify/utils/themes.dart';
import 'package:flutter/material.dart';

class ExpenseOperationScreen extends StatefulWidget {
  const ExpenseOperationScreen({super.key});

  @override
  State<ExpenseOperationScreen> createState() => _ExpenseOperationScreenState();
}

class _ExpenseOperationScreenState extends State<ExpenseOperationScreen> {
  @override
  final List<String> items = [
    'A_Item1',
    'A_Item2',
    'A_Item3',
    'A_Item4',
    'B_Item1',
    'B_Item2',
    'B_Item3',
    'B_Item4',
  ];

  String? selectedValue;
  final TextEditingController textEditingController = TextEditingController();

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.all(10),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Icon(
                        Icons.minimize,
                        color: AppTheme.mainTextColor,
                        size: 50,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 150,
                            child: TextFormField(
                              style: const TextStyle(
                                  fontSize: 50, color: AppTheme.mainTextColor),
                              decoration: const InputDecoration(
                                  border: UnderlineInputBorder(
                                      borderSide: BorderSide.none),
                                  hintText: "0",
                                  hintStyle:
                                      TextStyle(color: AppTheme.mainTextColor)),
                              keyboardType:
                                  const TextInputType.numberWithOptions(),
                            ),
                          ),
                          const Text(
                            'AED',
                            style: TextStyle(
                                color: AppTheme.mainTextColor, fontSize: 30),
                          ),
                        ],
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 150),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            const Text(
                              'Account',
                              style: TextStyle(color: AppTheme.accentColor),
                            ),
                            DropdownButtonHideUnderline(
                              child: DropdownButton2<String>(
                                isExpanded: true,
                                hint: const Text(
                                  'Select Item',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: AppTheme.mainTextColor,
                                  ),
                                ),
                                items: items
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
                                value: selectedValue,
                                onChanged: (value) {
                                  setState(() {
                                    selectedValue = value;
                                  });
                                },
                                buttonStyleData: const ButtonStyleData(
                                  padding: EdgeInsets.symmetric(horizontal: 16),
                                  height: 40,
                                  width: 100,
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
                                dropdownSearchData: DropdownSearchData(
                                  searchController: textEditingController,
                                  searchInnerWidgetHeight: 50,
                                  searchInnerWidget: Container(
                                    height: 50,
                                    padding: const EdgeInsets.only(
                                      top: 8,
                                      bottom: 4,
                                      right: 8,
                                      left: 8,
                                    ),
                                    child: TextFormField(
                                      expands: true,
                                      maxLines: null,
                                      controller: textEditingController,
                                      decoration: InputDecoration(
                                        isDense: true,
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                          horizontal: 10,
                                          vertical: 8,
                                        ),
                                        hintText: 'Search for an item...',
                                        hintStyle:
                                            const TextStyle(fontSize: 12),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                      ),
                                    ),
                                  ),
                                  searchMatchFn: (item, searchValue) {
                                    return item.value
                                        .toString()
                                        .contains(searchValue);
                                  },
                                ),
                                //This to clear the search value when you close the menu
                                onMenuStateChange: (isOpen) {
                                  if (!isOpen) {
                                    textEditingController.clear();
                                  }
                                },
                              ),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            const Text('Date',
                                style: TextStyle(color: AppTheme.accentColor)),
                            TextButton(
                                onPressed: () {},
                                child: const Text(
                                  'Select',
                                  style:
                                      TextStyle(color: AppTheme.mainTextColor),
                                ))
                          ],
                        ),
                        Column(
                          children: [
                            const Text('Category',
                                style: TextStyle(color: AppTheme.accentColor)),
                            SizedBox(
                                width: 100,
                                height: 50,
                                child: TextFormField(
                                  style: const TextStyle(
                                      color: AppTheme.mainTextColor),
                                  decoration: InputDecoration(
                                      hintText: 'eg.salary',
                                      hintStyle: TextStyle(
                                          color: AppTheme.mainTextColor
                                              .withOpacity(0.5)),
                                      border: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                              style: BorderStyle.solid))),
                                ))
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }
}
