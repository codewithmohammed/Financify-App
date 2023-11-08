import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:financify/model/category/transactioncategory/transaction_model.dart';
import 'package:financify/providers/filter_notifier.dart';
import 'package:financify/providers/transaction_notifier.dart';
import 'package:financify/utils/images.dart';
import 'package:financify/utils/themes.dart';
import 'package:financify/widgets/bottomsheetwidgets/accountdropdown.dart';
import 'package:financify/widgets/bottomsheetwidgets/typedropdown.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecordScreen extends StatefulWidget {
  const RecordScreen({super.key});

  @override
  State<RecordScreen> createState() => _RecordScreenState();
}

class _RecordScreenState extends State<RecordScreen> {
  Icon cusIcon = const Icon(
    Icons.search,
    color: AppTheme.primaryColor,
  );
  Widget cusSearchBar = const Text(
    'RECORDS',
    style: TextStyle(color: AppTheme.primaryColor),
  );
  @override
  Widget build(BuildContext context) {
    return Consumer<TransactionDataProvider>(
        builder: ((context, TransactionDataProvider, child) => Scaffold(
              backgroundColor: AppTheme.backgroundColor,
              appBar: AppBar(
                scrolledUnderElevation: 0,
                automaticallyImplyLeading: false,
                leading: const SizedBox(),
                backgroundColor: AppTheme.darkblue,
                title: cusSearchBar,
                actions: [
                  IconButton(
                      onPressed: () {
                        setState(() {
                          if (cusIcon.icon == Icons.search) {
                            cusIcon =
                                const Icon(Icons.cancel, color: Colors.red);
                            cusSearchBar = SizedBox(
                              height: 40,
                              child: TextField(
                                onChanged: (value) =>
                                    TransactionDataProvider.runFilter(value),
                                textAlignVertical: TextAlignVertical.center,
                                style: const TextStyle(
                                    color: AppTheme.mainTextColor),
                                decoration: const InputDecoration(
                                    contentPadding:
                                        EdgeInsets.only(top: 3, left: 10),
                                    hintText: 'Search',
                                    hintStyle: TextStyle(
                                        color: AppTheme.mainTextColor),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(22)))),
                              ),
                            );
                          } else {
                            cusIcon = const Icon(Icons.search,
                                color: AppTheme.primaryColor);
                            cusSearchBar = const Text(
                              'RECORDS',
                              style: TextStyle(color: AppTheme.primaryColor),
                            );
                          }
                        });
                      },
                      icon: cusIcon),
                  SizedBox(
                    height: 200,
                    child: PopupMenuButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24)),
                      color: AppTheme.listTileColor,
                      position: PopupMenuPosition.under,
                      itemBuilder: (ctx) => [
                        PopupMenuItem(
                            onTap: () {
                              bottomSheet(context);
                            },
                            height: 40,
                            child: const Row(
                              children: [
                                Icon(
                                  Icons.find_in_page_outlined,
                                  color: AppTheme.mainTextColor,
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                                  child: Text(
                                    'Filter',
                                    style: TextStyle(
                                        color: AppTheme.mainTextColor),
                                  ),
                                ),
                              ],
                            )),
                      ],
                      child: const Icon(
                        Icons.more_vert,
                        color: AppTheme.primaryColor,
                      ),
                    ),
                  )
                ],
              ),
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: ListView.separated(
                    itemCount: TransactionDataProvider.accountList.length,
                    itemBuilder: (
                      context,
                      index,
                    ) {
                      final item = TransactionDataProvider.accountList[index];
                      return item.type == TransactionCategoryType.transfer
                          ? ListTile(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(13),
                              ),
                              tileColor: AppTheme.listTileColor,
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    TransactionDataProvider
                                                .accountList[index].type ==
                                            TransactionCategoryType.transfer
                                        ? TransactionDataProvider
                                            .accountList[index].accountnote
                                        : TransactionDataProvider
                                            .accountList[index].categoryname,
                                    style: const TextStyle(
                                        fontSize: 14,
                                        color: AppTheme.mainTextColor),
                                  ),
                                  Text(
                                    TransactionDataProvider
                                        .accountList[index].amount,
                                    style: const TextStyle(
                                        fontSize: 14,
                                        color: AppTheme.mainTextColor),
                                  )
                                ],
                              ),
                              subtitle: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        item.fromaccountname,
                                        style: const TextStyle(
                                            color: AppTheme.mainTextColor),
                                      ),
                                      const Icon(Icons.arrow_right_alt_outlined,
                                          color: Colors.blue),
                                      Text(
                                        item.toaccountname,
                                        style: const TextStyle(
                                            color: AppTheme.mainTextColor),
                                      )
                                    ],
                                  ),
                                  Text(
                                    item.transactiondate,
                                    style: const TextStyle(
                                        fontSize: 14,
                                        color: AppTheme.mainTextColor),
                                  )
                                ],
                              ),
                              leading: Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                      color: AppTheme.darkblue,
                                      borderRadius: BorderRadius.circular(25)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.asset((TransactionDataProvider
                                                .accountList[index].type ==
                                            TransactionCategoryType.income)
                                        ? ImgIcons.iconcash
                                        : (TransactionDataProvider
                                                    .accountList[index].type ==
                                                TransactionCategoryType.expense)
                                            ? NavICons.iconExpense
                                            : NavICons.iconTransfer),
                                  )),
                            )
                          : ListTile(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(13),
                              ),
                              tileColor: AppTheme.listTileColor,
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    TransactionDataProvider
                                                .accountList[index].type ==
                                            TransactionCategoryType.transfer
                                        ? TransactionDataProvider
                                            .accountList[index].accountnote
                                        : TransactionDataProvider
                                            .accountList[index].categoryname,
                                    style: const TextStyle(
                                        fontSize: 14,
                                        color: AppTheme.mainTextColor),
                                  ),
                                  Text(
                                    TransactionDataProvider
                                        .accountList[index].amount,
                                    style: const TextStyle(
                                        fontSize: 14,
                                        color: AppTheme.mainTextColor),
                                  )
                                ],
                              ),
                              subtitle: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    TransactionDataProvider
                                        .accountList[index].accountname,
                                    style: const TextStyle(
                                        fontSize: 14,
                                        color: AppTheme.mainTextColor),
                                  ),
                                  Text(
                                    item.transactiondate,
                                    style: const TextStyle(
                                        fontSize: 14,
                                        color: AppTheme.mainTextColor),
                                  )
                                ],
                              ),
                              leading: Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                      color: AppTheme.darkblue,
                                      borderRadius: BorderRadius.circular(25)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.asset((TransactionDataProvider
                                                .accountList[index].type ==
                                            TransactionCategoryType.income)
                                        ? ImgIcons.iconcash
                                        : (TransactionDataProvider
                                                    .accountList[index].type ==
                                                TransactionCategoryType.expense)
                                            ? NavICons.iconExpense
                                            : NavICons.iconTransfer),
                                  )),
                            );
                    },
                    separatorBuilder: (
                      context,
                      index,
                    ) {
                      return const SizedBox(
                        height: 10,
                      );
                    },
                  ),
                ),
              ),
            )));
  }

  Future<dynamic> bottomSheet(BuildContext context) {
    return showModalBottomSheet(
        useRootNavigator: true,
        context: context,
        builder: (ctx) {
          return Consumer<FilterNotifier>(
              builder: ((context, FilterNotifier, child) => Container(
                    height: 400,
                    width: double.infinity,
                    decoration:
                        const BoxDecoration(color: AppTheme.backgroundColor),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Text(
                            'Filter',
                            style: TextStyle(
                                color: AppTheme.mainTextColor, fontSize: 20),
                          ),
                        ),
                        TypeDropdownwidget(),
                        AccountDropdownwidget()
                      ],
                    ),
                  )));
        });
  }
}
