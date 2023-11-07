
import 'package:financify/notifierclass/transaction_notifier.dart';
import 'package:financify/utils/images.dart';
import 'package:financify/utils/themes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecordScreen extends StatelessWidget {
  const RecordScreen({super.key});

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
                title: const Text(
                  'RECORDS',
                  style: TextStyle(color: AppTheme.primaryColor),
                ),
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
                      return ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(13),
                        ),
                        tileColor: AppTheme.listTileColor,
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              item.categoryname,
                              style: const TextStyle(
                                  fontSize: 14, color: AppTheme.mainTextColor),
                            ),
                            Text(
                              item.accountname,
                              style: const TextStyle(
                                  fontSize: 14, color: AppTheme.mainTextColor),
                            )
                          ],
                        ),
                        subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              TransactionDataProvider
                                  .accountList[index].accountname,
                              style: const TextStyle(
                                  fontSize: 14, color: AppTheme.mainTextColor),
                            ),
                            Text(
                              item.transactiondate,
                              style: const TextStyle(
                                  fontSize: 14, color: AppTheme.mainTextColor),
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
                              child: Image.asset(NavICons.iconIncome),
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
}
