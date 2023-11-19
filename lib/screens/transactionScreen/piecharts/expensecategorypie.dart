import 'package:financify/providers/profile_notifiers.dart';
import 'package:financify/providers/transaction_notifier.dart';
import 'package:financify/utils/themes.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpensePieChartBox extends StatelessWidget {
  const ExpensePieChartBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
        final appTheme = Provider.of<AppTheme>(context, listen: true);
    return Provider.of<TransactionDataProvider>(context, listen: true)
            .expenseaccountList
            .isEmpty
        ? const Center(
            child: Text(
              'No Expense is Added yet',
              style: TextStyle(color: Colors.grey),
            ),
          )
        : ListView(
            children: [
              SizedBox(
                height: 350,
                width: double.infinity,
                child: Consumer<TransactionDataProvider>(
                    builder: ((context, transactionDataProvider, child) =>
                        PieChart(
                            swapAnimationDuration:
                                const Duration(milliseconds: 750),
                            PieChartData(
                                startDegreeOffset: 50,
                                sectionsSpace: 0,
                                centerSpaceRadius: 0,
                                sections: [
                                  // Example function calls with different arguments and colors
                                  piechartdata(
                                      transactionDataProvider
                                          .sumofexpensehousing!,
                                      Colors.amber),
                                  piechartdata(
                                      transactionDataProvider
                                          .sumofexpenseutilities!,
                                      Colors.blue),
                                  piechartdata(
                                      transactionDataProvider
                                          .sumofexpensegroceries!,
                                      Colors.green),
                                  piechartdata(
                                      transactionDataProvider
                                          .sumofexpensetransportation!,
                                      Colors.orange),
                                  piechartdata(
                                      transactionDataProvider
                                          .sumofexpensehealthCare!,
                                      Colors.purple),
                                  piechartdata(
                                      transactionDataProvider
                                          .sumofexpenseinsurance!,
                                      Colors.yellow),
                                  piechartdata(
                                      transactionDataProvider
                                          .sumofexpenseeducation!,
                                      Colors.teal),
                                  piechartdata(
                                      transactionDataProvider
                                          .sumofexpenseentertainment!,
                                      Colors.pink),
                                  piechartdata(
                                      transactionDataProvider
                                          .sumofexpensediningOut!,
                                      Colors.red),
                                  piechartdata(
                                      transactionDataProvider
                                          .sumofexpenseshopping!,
                                      Colors.indigo),
                                  piechartdata(
                                      transactionDataProvider
                                          .sumofexpensepersonalCare!,
                                      Colors.brown),
                                  piechartdata(
                                      transactionDataProvider
                                          .sumofexpensedeptPayments!,
                                      Colors.cyan),
                                  piechartdata(
                                      transactionDataProvider
                                          .sumofexpensecharitableDonations!,
                                      Colors.deepOrange),
                                  piechartdata(
                                      transactionDataProvider
                                          .sumofexpensetaxes!,
                                      Colors.lime),
                                  piechartdata(
                                      transactionDataProvider
                                          .sumofexpensemiscellaneous!,
                                      Colors.blueGrey),
// Add more function calls as needed with different arguments and colors
                                ])))),
              ),
              Container(
                height: 300,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: appTheme.darkblue,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          piechartcolorIndicator(Colors.amber, 'Housing'),
                          piechartcolorIndicator(Colors.blue, 'Utilities'),
                          piechartcolorIndicator(Colors.green, 'Groceries'),
                          piechartcolorIndicator(
                              Colors.orange, 'Transportation'),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          piechartcolorIndicator(Colors.purple, 'Health Care'),
                          piechartcolorIndicator(Colors.yellow, 'Insurance'),
                          piechartcolorIndicator(Colors.teal, 'Education'),
                          piechartcolorIndicator(Colors.pink, 'Entertainment'),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          piechartcolorIndicator(Colors.red, 'Dining Out'),
                          piechartcolorIndicator(Colors.indigo, 'Shopping'),
                          piechartcolorIndicator(Colors.brown, 'Personal Care'),
                          piechartcolorIndicator(Colors.cyan, 'Dept Payments'),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          piechartcolorIndicator(
                              Colors.deepOrange, 'Charitable Donations'),
                          piechartcolorIndicator(Colors.lime, 'Taxes'),
                          piechartcolorIndicator(
                              Colors.blueGrey, 'Miscellaneous'),
                        ],
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Text(
                        'Total Expense',
                        style: TextStyle(
                            color: appTheme.mainTextColor, fontSize: 20),
                      ),
                      Consumer<ProfileDataProvider>(
                          builder: ((context, accountDataProvider, child) =>
                              Container(
                                  height: 75,
                                  width: 150,
                                  decoration: const BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  child: Consumer<TransactionDataProvider>(
                                      builder: ((context,
                                              transactionDataProvider, child) =>
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Text(
                                                ' ${transactionDataProvider.accExpense}',
                                                style: const TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.white),
                                              ),
                                              Text(
                                                accountDataProvider
                                                    .currencyCode,
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.amberAccent),
                                              ),
                                            ],
                                          ))))))
                    ],
                  ),
                ),
              )
            ],
          );
  }

  Row piechartcolorIndicator(Color? incdicatorcolor, String categoryName) {
    return Row(
      children: [
        Icon(
          size: 15,
          Icons.pie_chart,
          color: incdicatorcolor,
        ),
        const SizedBox(width: 5),
        Text(
          categoryName,
          style: TextStyle(color: incdicatorcolor, fontSize: 12),
        )
      ],
    );
  }

  PieChartSectionData piechartdata(double categorizedexpense, Color? piecolor) {
    return PieChartSectionData(
      showTitle: false,
      badgePositionPercentageOffset: 1.2,
      badgeWidget: Container(
        alignment: Alignment.center,
        height: 20,
        width: 35,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3),
            color: Colors.deepOrangeAccent),
        child: Text(
            style: const TextStyle(color: Colors.white), '$categorizedexpense'),
      ),
      radius: 115,
      value: categorizedexpense,
      color: piecolor,
    );
  }
}
