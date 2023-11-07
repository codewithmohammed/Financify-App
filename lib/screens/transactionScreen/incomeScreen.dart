import 'package:financify/notifierclass/incometransaction_notifier.dart';
import 'package:financify/notifierclass/transaction_notifier.dart';
import 'package:financify/utils/images.dart';
import 'package:financify/utils/themes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IncomeScreen extends StatelessWidget {
  const IncomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TransactionDataProvider>(
        builder: ((context, IncomeTransactionDataProvider, child) => Scaffold(
              backgroundColor: AppTheme.backgroundColor,
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: ListView.separated(
                    itemCount: IncomeTransactionDataProvider.incomeaccountList.length,
                    itemBuilder: (
                      context,
                      index,
                    ) {
                      return ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(13),
                        ),
                        tileColor: AppTheme.listTileColor,
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              IncomeTransactionDataProvider
                                  .incomeaccountList[index].accountname,
                              style: const TextStyle(
                                  color: AppTheme.mainTextColor),
                            ),
                            Text(
                              IncomeTransactionDataProvider
                                  .incomeaccountList[index].amount,
                              style: const TextStyle(color: Colors.green),
                            )
                          ],
                        ),
                        subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              IncomeTransactionDataProvider
                                  .incomeaccountList[index].categoryname,
                              style: const TextStyle(
                                  color: AppTheme.mainTextColor),
                            ),
                            Text(
                              IncomeTransactionDataProvider
                                  .incomeaccountList[index].transactiondate,
                              style: const TextStyle(
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
                              child: Image.asset(NavICons.iconIncome),
                            )),
                      );
                    },
                    separatorBuilder: (context, index) {
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
