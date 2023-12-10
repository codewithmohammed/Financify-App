import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:financify/providers/account_notifier.dart';
import 'package:financify/providers/profile_notifiers.dart';
import 'package:financify/providers/transaction_notifier.dart';
import 'package:financify/utils/themes.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PieChartBox extends StatefulWidget {
  const PieChartBox({
    super.key,
  });

  @override
  State<PieChartBox> createState() => _PieChartBoxState();
}

class _PieChartBoxState extends State<PieChartBox> {
  @override
  Widget build(BuildContext context) {
    final appTheme = Provider.of<AppTheme>(context, listen: true);
    final List<String> items = [
      'All Time',
      'Today',
      'Yesterday',
      'This Month',
      'Last Month',
      'This Year',
      'Last Year',
    ];


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
                            'Income,Expense & Tranfer',
                            style: TextStyle(
                                color: appTheme.mainTextColor, fontSize: 20),
                          ),
                        ),
                      ),
                      Consumer<TransactionDataProvider>(
                          builder: ((context, transactionDataProvider, child) =>
                              Container(
                                height: 50,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: appTheme.darkblue,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: appTheme.primaryColor,
                                        borderRadius: BorderRadius.circular(5)),
                                    child: DropdownButtonHideUnderline(
                                        child: DropdownButton2<String>(
                                      isExpanded: true,
                                      hint: Text(
                                        transactionDataProvider.homeSortDataType!,
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: appTheme.mainTextColor,
                                        ),
                                      ),
                                      items: items
                                          .map((String item) =>
                                              DropdownMenuItem<String>(
                                                value: item,
                                                child: Text(
                                                  item,
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ))
                                          .toList(),
                                    
                                      onChanged: (value) {
                                        if (value == null) {
                                          return;
                                        }
                                        final sortingDate =transactionDataProvider.selectDate(value);

                                        if (sortingDate != null) {
                                          transactionDataProvider
                                              .sortThePieChartforHome(
                                                  sortingDate, value);
                                        } else {
                                          transactionDataProvider
                                              .dBtoTransaction();
                                        }
                                      },
                                      buttonStyleData: const ButtonStyleData(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 16),
                                        height: 40,
                                        width: 140,
                                      ),
                                      menuItemStyleData:
                                          const MenuItemStyleData(
                                        height: 40,
                                      ),
                                    )),
                                  ),
                                ),
                              ))),
                      Container(
                        height: 350,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: appTheme.darkblue,
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
                                                  value: transactiondataprovider
                                                      .accIncome,
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
                                                  color: Colors.red),
                                              PieChartSectionData(
                                                  titlePositionPercentageOffset:
                                                      1.6,
                                                  titleStyle: TextStyle(
                                                      color: appTheme
                                                          .mainTextColor),
                                                  value: transactiondataprovider
                                                      .accTransfered,
                                                  color: Colors.blue)
                                            ])))),
                          ],
                        ),
                      ),
                      Container(
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: appTheme.darkblue,
                          borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(12),
                              bottomRight: Radius.circular(12)),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              PieIndication(
                                color: Color.fromARGB(255, 62, 207, 67),
                                text: "Income",
                              ),
                              PieIndication(
                                color: Colors.red,
                                text: "Expense",
                              ),
                              PieIndication(
                                color: Colors.blue,
                                text: "Transfer",
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )));
  }

  String? selectDate(String whichDate) {
    String formattedDate;
    DateTime today = DateTime.now();
    switch (whichDate) {
      case 'All Time':
        return null;
      case 'Today':
        formattedDate = DateFormat('dd/MMM/yyyy').format(today);
        return formattedDate;
      case 'Yesterday':
        DateTime yesterday = today.subtract(const Duration(days: 1));
        formattedDate = DateFormat('dd/MMM/yyyy').format(yesterday);
        return formattedDate;
      case 'This Month':
        formattedDate = DateFormat('MMM/yyyy').format(today);
        return formattedDate;
      case 'Last Month':
        DateTime lastMonth = today.subtract(const Duration(days: 30));
        formattedDate = DateFormat('MMM/yyyy').format(lastMonth);
        return formattedDate;
      case 'This Year':
        formattedDate = DateFormat('yyyy').format(today);
        return formattedDate;
      case 'Last Year':
        DateTime lastYear = today.subtract(const Duration(days: 365));
        formattedDate = DateFormat('yyyy').format(lastYear);
        return formattedDate;
      default:
        return null;
    }
  }
}

class PieIndication extends StatelessWidget {
  final Color color;
  final String text;
  const PieIndication({
    super.key,
    required this.color,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.pie_chart,
          color: color,
          size: 12,
        ),
        Text(text,
            style: TextStyle(
              color: color,
            )),
      ],
    );
  }
}
