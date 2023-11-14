import 'package:financify/model/category/transactioncategory/transaction_model.dart';
import 'package:financify/providers/updateData_Provider.dart';
import 'package:financify/providers/transaction_notifier.dart';
import 'package:financify/providers/widgetnotifier.dart';
import 'package:financify/screens/all_data.dart';
import 'package:financify/transition/fadetransition.dart';
import 'package:financify/utils/images.dart';
import 'package:financify/utils/themes.dart';
import 'package:financify/widgets/bottomsheetwidgets/accountdropdown.dart';
import 'package:financify/widgets/bottomsheetwidgets/categorydropdown.dart';
import 'package:financify/widgets/bottomsheetwidgets/datedropdown.dart';
import 'package:financify/widgets/bottomsheetwidgets/typedropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
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

  Color? cusOutlineButtonColor = AppTheme.primaryColor;
  String cusOutlineText = 'Done';
  @override
  Widget build(BuildContext context) {
    return Consumer<TransactionDataProvider>(
        builder: ((context, transactionDataProvider, child) => Scaffold(
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
                            transactionDataProvider.filterClear();
                            transactionDataProvider.cancelSearch();
                            Provider.of<WidgetNotifier>(context, listen: false)
                                .changeToDone();
                            cusIcon =
                                const Icon(Icons.cancel, color: Colors.red);
                            cusSearchBar = SizedBox(
                              height: 40,
                              child: TextField(
                                onChanged: (value) =>
                                    transactionDataProvider.runFilter(value),
                                textAlignVertical: TextAlignVertical.center,
                                style: const TextStyle(
                                    color: AppTheme.mainTextColor),
                                decoration: const InputDecoration(
                                    contentPadding:
                                        EdgeInsets.only(top: 3, left: 10),
                                    hintText: 'Search with your account name',
                                    hintStyle: TextStyle(
                                        color:
                                            Color.fromARGB(172, 255, 255, 255)),
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
                            transactionDataProvider.cancelSearch();
                            transactionDataProvider.filterClear();
                          }
                        });
                      },
                      icon: cusIcon),
                  SizedBox(
                    height: 200,
                    child: PopupMenuButton(
                      onOpened: () {
                        setState(() {
                          // transactionDataProvider.filterClear();
                          // transactionDataProvider.cancelSearch();
                          cusIcon = const Icon(Icons.search,
                              color: AppTheme.primaryColor);
                          cusSearchBar = const Text(
                            'RECORDS',
                            style: TextStyle(color: AppTheme.primaryColor),
                          );
                          if ((transactionDataProvider
                                  .selectedaCategoryValue.text.isEmpty &&
                              transactionDataProvider
                                  .selectedaDateValue.text.isEmpty &&
                              transactionDataProvider
                                  .selectedaccountValue.text.isEmpty &&
                              transactionDataProvider.filteringtype == null)) {
                            transactionDataProvider.cancelSearch();
                          }
                        });
                      },
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
                    itemCount:
                        transactionDataProvider.filteredaccountList.length,
                    itemBuilder: (
                      context,
                      index,
                    ) {
                      final item =
                          transactionDataProvider.filteredaccountList[index];
                      return item.type == TransactionCategoryType.transfer
                          ? Slidable(
                              startActionPane: ActionPane(
                                  motion: const StretchMotion(),
                                  children: [
                                    SlidableAction(
                                      backgroundColor: Colors.green,
                                      icon: Icons.edit,
                                      label: 'Update',
                                      onPressed: (context) {},
                                    )
                                  ]),
                              endActionPane: ActionPane(
                                  motion: const StretchMotion(),
                                  children: [
                                    SlidableAction(
                                      backgroundColor: Colors.red,
                                      icon: Icons.delete,
                                      label: 'Delete',
                                      onPressed: (context) {
                                        _editTheTransaction(
                                            transactionDataProvider
                                                .filteredaccountList[index].id);
                                      },
                                    )
                                  ]),
                              child: ListTile(
                                onTap: () {
                                  Provider.of<UpdateDataProvider>(context,
                                          listen: false)
                                      .updateDataProvider(
                                          transactionDataProvider
                                              .filteredaccountList[index].id,
                                          transactionDataProvider
                                              .filteredaccountList[index]
                                              .categoryname,
                                          transactionDataProvider
                                              .filteredaccountList[index]
                                              .accountname,
                                          transactionDataProvider
                                              .filteredaccountList[index]
                                              .fromaccountname,
                                          transactionDataProvider
                                              .filteredaccountList[index]
                                              .toaccountname,
                                          transactionDataProvider
                                              .filteredaccountList[index]
                                              .amount,
                                          transactionDataProvider
                                              .filteredaccountList[index]
                                              .transactiondate,
                                          transactionDataProvider
                                              .filteredaccountList[index]
                                              .accountnote,
                                          transactionDataProvider
                                              .filteredaccountList[index].type);
                                  Navigator.of(context).push(FadeRoute(
                                      page: const AllTransactionData()));
                                },
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(13),
                                ),
                                tileColor: AppTheme.listTileColor,
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      transactionDataProvider
                                                  .filteredaccountList[index]
                                                  .type ==
                                              TransactionCategoryType.transfer
                                          ? transactionDataProvider
                                              .filteredaccountList[index]
                                              .accountnote
                                          : transactionDataProvider
                                              .filteredaccountList[index]
                                              .categoryname,
                                      style: const TextStyle(
                                          fontSize: 14,
                                          color: AppTheme.mainTextColor),
                                    ),
                                    Text(
                                      transactionDataProvider
                                          .filteredaccountList[index].amount,
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
                                        const Icon(
                                            Icons.arrow_right_alt_outlined,
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
                                        borderRadius:
                                            BorderRadius.circular(25)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Image.asset(
                                          (transactionDataProvider
                                                      .filteredaccountList[
                                                          index]
                                                      .type ==
                                                  TransactionCategoryType
                                                      .income)
                                              ? NavICons.iconIncome
                                              : (transactionDataProvider
                                                          .filteredaccountList[
                                                              index]
                                                          .type ==
                                                      TransactionCategoryType
                                                          .expense)
                                                  ? NavICons.iconExpense
                                                  : NavICons.iconTransfer),
                                    )),
                              ),
                            )
                          : Slidable(
                              startActionPane: ActionPane(
                                  motion: const StretchMotion(),
                                  children: [
                                    SlidableAction(
                                      backgroundColor: Colors.green,
                                      icon: Icons.edit,
                                      label: 'Update',
                                      onPressed: (context) {},
                                    )
                                  ]),
                              endActionPane: ActionPane(
                                  motion: const StretchMotion(),
                                  children: [
                                    SlidableAction(
                                      backgroundColor: Colors.red,
                                      icon: Icons.delete,
                                      label: 'Delete',
                                      onPressed: (context) {
                                        _editTheTransaction(
                                            transactionDataProvider
                                                .filteredaccountList[index].id);
                                      },
                                    )
                                  ]),
                              child: ListTile(
                                onTap: () {
                                  Provider.of<UpdateDataProvider>(context,
                                          listen: false)
                                      .updateDataProvider(
                                          transactionDataProvider
                                              .filteredaccountList[index].id,
                                          transactionDataProvider
                                              .filteredaccountList[index]
                                              .categoryname,
                                          transactionDataProvider
                                              .filteredaccountList[index]
                                              .accountname,
                                          transactionDataProvider
                                              .filteredaccountList[index]
                                              .fromaccountname,
                                          transactionDataProvider
                                              .filteredaccountList[index]
                                              .toaccountname,
                                          transactionDataProvider
                                              .filteredaccountList[index]
                                              .amount,
                                          transactionDataProvider
                                              .filteredaccountList[index]
                                              .transactiondate,
                                          transactionDataProvider
                                              .filteredaccountList[index]
                                              .accountnote,
                                          transactionDataProvider
                                              .filteredaccountList[index].type);
                                  Navigator.of(context).push(FadeRoute(
                                      page: const AllTransactionData()));
                                },
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(13),
                                ),
                                tileColor: AppTheme.listTileColor,
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      transactionDataProvider
                                                  .filteredaccountList[index]
                                                  .type ==
                                              TransactionCategoryType.transfer
                                          ? transactionDataProvider
                                              .filteredaccountList[index]
                                              .accountnote
                                          : transactionDataProvider
                                              .filteredaccountList[index]
                                              .categoryname,
                                      style: const TextStyle(
                                          fontSize: 14,
                                          color: AppTheme.mainTextColor),
                                    ),
                                    Text(
                                      transactionDataProvider
                                          .filteredaccountList[index].amount,
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
                                      transactionDataProvider
                                          .filteredaccountList[index]
                                          .accountname,
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
                                        borderRadius:
                                            BorderRadius.circular(25)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Image.asset(
                                          (transactionDataProvider
                                                      .filteredaccountList[
                                                          index]
                                                      .type ==
                                                  TransactionCategoryType
                                                      .income)
                                              ? NavICons.iconIncome
                                              : (transactionDataProvider
                                                          .filteredaccountList[
                                                              index]
                                                          .type ==
                                                      TransactionCategoryType
                                                          .expense)
                                                  ? NavICons.iconExpense
                                                  : NavICons.iconTransfer),
                                    )),
                              ),
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
          return Consumer<TransactionDataProvider>(
              builder: ((context, transactionDataProvider, child) => Container(
                    height: 400,
                    width: double.infinity,
                    decoration:
                        const BoxDecoration(color: AppTheme.backgroundColor),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Filter',
                                style: TextStyle(
                                    color: AppTheme.mainTextColor,
                                    fontSize: 20),
                              ),
                              Consumer<WidgetNotifier>(
                                  builder: ((context, widgetNotifier, child) =>
                                      OutlinedButton(
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStatePropertyAll(
                                                      widgetNotifier
                                                          .cusOutlineButtonColor)),
                                          onPressed: () {
                                            if ((transactionDataProvider
                                                        .selectedaCategoryValue
                                                        .text
                                                        .isNotEmpty ||
                                                    transactionDataProvider
                                                        .selectedaDateValue
                                                        .text
                                                        .isNotEmpty ||
                                                    transactionDataProvider
                                                        .selectedaccountValue
                                                        .text
                                                        .isNotEmpty ||
                                                    transactionDataProvider
                                                            .filteringtype !=
                                                        null) &&
                                                widgetNotifier.cusOutlineText !=
                                                    'Cancel') {
                                              transactionDataProvider
                                                  .filterSelection();
                                              widgetNotifier.changeToCancel();
                                              Navigator.of(context).pop();
                                            } else if (widgetNotifier
                                                        .cusOutlineText ==
                                                    'Cancel' &&
                                                widgetNotifier.cusOutlineText !=
                                                    'Done') {
                                              transactionDataProvider
                                                  .filterClear();
                                              transactionDataProvider
                                                  .cancelSearch();
                                              widgetNotifier.changeToDone();
                                            } else {
                                              Navigator.of(context).pop();
                                            }
                                          },
                                          child: Text(
                                            widgetNotifier.cusOutlineText,
                                            style: const TextStyle(
                                                color: AppTheme.mainTextColor),
                                          ))))
                            ],
                          ),
                        ),
                        const TypeDropdownwidget(),
                        const AccountDropdownwidget(),
                        const DateDropdownwidget(),
                        const CategoryDropdownwidget(),
                      ],
                    ),
                  )));
        });
  }

  void _editTheTransaction(String id) {
    showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: const Text('Delete Transaction?'),
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('CLOSE')),
                  ElevatedButton(
                      onPressed: () async {
                        Provider.of<TransactionDataProvider>(context,
                                listen: false)
                            .deleteTransaction(id);
                        Navigator.of(context).pop();
                      },
                      child: const Text('DELETE'))
                ],
              )
            ],
          );
        });
  }
}
