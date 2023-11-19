import 'package:financify/model/category/transactioncategory/transaction_model.dart';
import 'package:financify/providers/transaction_notifier.dart';
import 'package:financify/providers/updatedataprovider.dart';
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
    color: Color.fromRGBO(201, 146, 0, 1),
  );
  Widget cusSearchBar = const Text(
    'RECORDS',
    style: TextStyle(color: Color.fromRGBO(201, 146, 0, 1)),
  );

  Color? cusOutlineButtonColor = const Color.fromRGBO(201, 146, 0, 1);
  String cusOutlineText = 'Done';
  @override
  Widget build(BuildContext context) {
    final appTheme = Provider.of<AppTheme>(context, listen: true);
    return Consumer<TransactionDataProvider>(
        builder: ((context, transactionDataProvider, child) => Scaffold(
              backgroundColor: appTheme.backgroundColor,
              appBar: AppBar(
                scrolledUnderElevation: 0,
                automaticallyImplyLeading: false,
                leading: const SizedBox(),
                backgroundColor: appTheme.darkblue,
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
                                style: TextStyle(color: appTheme.mainTextColor),
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
                            cusIcon = Icon(Icons.search,
                                color: appTheme.primaryColor);
                            cusSearchBar = Text(
                              'RECORDS',
                              style: TextStyle(color: appTheme.primaryColor),
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
                          cusIcon =
                              Icon(Icons.search, color: appTheme.primaryColor);
                          cusSearchBar = Text(
                            'RECORDS',
                            style: TextStyle(color: appTheme.primaryColor),
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
                      color: appTheme.listTileColor,
                      position: PopupMenuPosition.under,
                      itemBuilder: (ctx) => [
                        PopupMenuItem(
                            onTap: () {
                              bottomSheet(context);
                            },
                            height: 40,
                            child: Row(
                              children: [
                                Icon(
                                  Icons.find_in_page_outlined,
                                  color: appTheme.mainTextColor,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 20, 0),
                                  child: Text(
                                    'Filter',
                                    style: TextStyle(
                                        color: appTheme.mainTextColor),
                                  ),
                                ),
                              ],
                            )),
                      ],
                      child: Icon(
                        Icons.more_vert,
                        color: appTheme.primaryColor,
                      ),
                    ),
                  )
                ],
              ),
              body: SafeArea(
                child: transactionDataProvider.filteredaccountList.isEmpty
                    ? Center(
                        child: Text(
                          'No Data is Found \nPlease Add any Transaction',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: appTheme.mainTextColor.withOpacity(0.5)),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(10),
                        child: ListView.separated(
                          itemCount: transactionDataProvider
                              .filteredaccountList.length,
                          itemBuilder: (
                            context,
                            index,
                          ) {
                            final item = transactionDataProvider
                                .filteredaccountList[index];
                            return item.type == TransactionCategoryType.transfer
                                ? Slidable(
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
                                                      .filteredaccountList[
                                                          index]
                                                      .id);
                                            },
                                          )
                                        ]),
                                    child: ListTile(
                                      onTap: () {
                                        Provider.of<UpdateDataProvider>(context,
                                                listen: false)
                                            .updateDataProvider(
                                                transactionDataProvider
                                                    .filteredaccountList[index]
                                                    .id,
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
                                                    .filteredaccountList[index]
                                                    .type);
                                        Navigator.of(context).push(FadeRoute(
                                            page: const AllTransactionData()));
                                      },
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(13),
                                      ),
                                      tileColor: appTheme.listTileColor,
                                      title: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            transactionDataProvider
                                                        .filteredaccountList[
                                                            index]
                                                        .type ==
                                                    TransactionCategoryType
                                                        .transfer
                                                ? transactionDataProvider
                                                    .filteredaccountList[index]
                                                    .accountnote
                                                : transactionDataProvider
                                                    .filteredaccountList[index]
                                                    .categoryname,
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: appTheme.mainTextColor),
                                          ),
                                          Text(
                                            transactionDataProvider
                                                .filteredaccountList[index]
                                                .amount,
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: appTheme.mainTextColor),
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
                                                style: TextStyle(
                                                    color:
                                                        appTheme.mainTextColor),
                                              ),
                                              const Icon(
                                                  Icons
                                                      .arrow_right_alt_outlined,
                                                  color: Colors.blue),
                                              Text(
                                                item.toaccountname,
                                                style: TextStyle(
                                                    color:
                                                        appTheme.mainTextColor),
                                              )
                                            ],
                                          ),
                                          Text(
                                            item.transactiondate,
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: appTheme.mainTextColor),
                                          )
                                        ],
                                      ),
                                      leading: Container(
                                          height: 50,
                                          width: 50,
                                          decoration: BoxDecoration(
                                              color: appTheme.darkblue,
                                              borderRadius:
                                                  BorderRadius.circular(25)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Image.asset((transactionDataProvider
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
                                                      .filteredaccountList[
                                                          index]
                                                      .id);
                                            },
                                          )
                                        ]),
                                    child: ListTile(
                                      onTap: () {
                                        Provider.of<UpdateDataProvider>(context,
                                                listen: false)
                                            .updateDataProvider(
                                                transactionDataProvider
                                                    .filteredaccountList[index]
                                                    .id,
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
                                                    .filteredaccountList[index]
                                                    .type);
                                        Navigator.of(context).push(FadeRoute(
                                            page: const AllTransactionData()));
                                      },
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(13),
                                      ),
                                      tileColor: appTheme.listTileColor,
                                      title: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            transactionDataProvider
                                                        .filteredaccountList[
                                                            index]
                                                        .type ==
                                                    TransactionCategoryType
                                                        .transfer
                                                ? transactionDataProvider
                                                    .filteredaccountList[index]
                                                    .accountnote
                                                : transactionDataProvider
                                                    .filteredaccountList[index]
                                                    .categoryname,
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: appTheme.mainTextColor),
                                          ),
                                          Text(
                                            transactionDataProvider
                                                .filteredaccountList[index]
                                                .amount,
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: appTheme.mainTextColor),
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
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: appTheme.mainTextColor),
                                          ),
                                          Text(
                                            item.transactiondate,
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: appTheme.mainTextColor),
                                          )
                                        ],
                                      ),
                                      leading: Container(
                                          height: 50,
                                          width: 50,
                                          decoration: BoxDecoration(
                                              color: appTheme.darkblue,
                                              borderRadius:
                                                  BorderRadius.circular(25)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Image.asset((transactionDataProvider
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
    // final appTheme = Provider.of<AppTheme>(context, listen: true);
    return showModalBottomSheet(
        useRootNavigator: true,
        context: context,
        builder: (ctx) {
          return Consumer<TransactionDataProvider>(
              builder: ((context, transactionDataProvider, child) => Container(
                    height: 400,
                    width: double.infinity,
                    decoration: BoxDecoration(color: Provider.of<AppTheme>(context, listen: true).backgroundColor),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Filter',
                                style: TextStyle(
                                    color: Provider.of<AppTheme>(context, listen: true).mainTextColor,
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
                                            style: TextStyle(
                                                color: Provider.of<AppTheme>(context, listen: true).mainTextColor),
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
