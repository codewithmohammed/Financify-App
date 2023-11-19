import 'package:financify/providers/account_notifier.dart';
import 'package:financify/providers/profile_notifiers.dart';
import 'package:financify/providers/transaction_notifier.dart';
import 'package:financify/utils/themes.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PieChartBox extends StatelessWidget {
  const PieChartBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    final appTheme = Provider.of<AppTheme>(context, listen: true);
    
    return Consumer<AccountDataProvider>(
        builder: ((context, accountdataprovider, child) => Visibility(
              replacement: const Text('No Account Is Added yet',
                  style: TextStyle(color: Colors.white)),
              visible: accountdataprovider.accountList.isNotEmpty,
              child: Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Column(
                    children: [
                      Container(
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: appTheme.darkblue,
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            'Total Balance & Expense',
                            style: TextStyle(
                                color: appTheme.mainTextColor, fontSize: 20),
                          ),
                        ),
                      ),
                      Container(
                        height: 350,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: appTheme.darkblue,
                          borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(12),
                              bottomRight: Radius.circular(12)),
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Consumer<ProfileDataProvider>(
                                builder: ((context, profiledataprovider,
                                        child) =>
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Balance',
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: appTheme.mainTextColor),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              profiledataprovider.currencyCode,
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color:
                                                      appTheme.mainTextColor),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              accountdataprovider.accTotal
                                                  .toString(),
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  color: Color.fromARGB(
                                                      255, 76, 201, 81)),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          'Expense',
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: appTheme.mainTextColor),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              profiledataprovider.currencyCode,
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color:
                                                      appTheme.mainTextColor),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Consumer<TransactionDataProvider>(
                                                builder: ((context,
                                                        transactiondataprovider,
                                                        child) =>
                                                    Text(
                                                      transactiondataprovider
                                                          .accExpense
                                                          .toString(),
                                                      style: const TextStyle(
                                                          fontSize: 20,
                                                          color: Colors.red),
                                                    ))),
                                          ],
                                        ),
                                      ],
                                    ))),
                            Consumer<TransactionDataProvider>(
                                builder: ((context, transactiondataprovider,
                                        child) =>
                                    PieChart(
                                        swapAnimationDuration:
                                            const Duration(milliseconds: 750),
                                        PieChartData(
                                            sectionsSpace: 0,
                                            centerSpaceRadius: 80,
                                            sections: [
                                              PieChartSectionData(
                                                  titlePositionPercentageOffset:
                                                      1.6,
                                                  titleStyle: TextStyle(
                                                      color: appTheme
                                                          .mainTextColor),
                                                  value: accountdataprovider
                                                      .accTotal,
                                                  color: const Color.fromARGB(
                                                      255, 62, 207, 67)),
                                              PieChartSectionData(
                                                  titlePositionPercentageOffset:
                                                      1.6,
                                                  titleStyle: TextStyle(
                                                      color: appTheme
                                                          .mainTextColor),
                                                  value: transactiondataprovider
                                                      .accExpense,
                                                  color: Colors.red)
                                            ])))),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )));
  }
}
