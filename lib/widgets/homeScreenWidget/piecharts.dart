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
    return Consumer<AccountDataProvider>(
        builder: ((context, accountdataprovider, child) => Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                Column(
                  children: [
                    Container(
                      height: 50,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: AppTheme.darkblue,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12)),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          'Total Balance & Expense',
                          style: TextStyle(
                              color: AppTheme.mainTextColor, fontSize: 20),
                        ),
                      ),
                    ),
                    Container(
                      height: 350,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: AppTheme.darkblue,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(12),
                            bottomRight: Radius.circular(12)),
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Consumer<ProfileDataProvider>(
                              builder: ((context, profiledataprovider, child) =>
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(
                                        'Balance',
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: AppTheme.mainTextColor),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            profiledataprovider.currencyCode,
                                            style: const TextStyle(
                                                fontSize: 20,
                                                color: AppTheme.mainTextColor),
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
                                      const Text(
                                        'Expense',
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: AppTheme.mainTextColor),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            profiledataprovider.currencyCode,
                                            style: const TextStyle(
                                                fontSize: 20,
                                                color: AppTheme.mainTextColor),
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
                                          centerSpaceRadius: 120,
                                          sections: [
                                            PieChartSectionData(
                                                titleStyle: const TextStyle(
                                                    color:
                                                        AppTheme.mainTextColor),
                                                value: accountdataprovider
                                                    .accTotal,
                                                color: const Color.fromARGB(
                                                    255, 62, 207, 67)),
                                            PieChartSectionData(
                                                titleStyle: const TextStyle(
                                                    color:
                                                        AppTheme.mainTextColor),
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
            )));
  }
}
