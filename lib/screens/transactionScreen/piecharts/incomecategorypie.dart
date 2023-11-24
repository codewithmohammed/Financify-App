
import 'package:financify/providers/profile_notifiers.dart';
import 'package:financify/providers/transaction_notifier.dart';
import 'package:financify/utils/themes.dart';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IncomesPieChartBox extends StatelessWidget {
  const IncomesPieChartBox({
    super.key,
  });

  List<PieChartSectionData> getSections(BuildContext context) {
    final appTheme = Provider.of<AppTheme>(context, listen: true);
    final transactionDataProvider =
        Provider.of<TransactionDataProvider>(context, listen: true);
    int length = transactionDataProvider.listofincomeCategoryAdded.length;
    List<Color> colors = [
      Colors.amber,
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.yellow,
      Colors.teal,
      Colors.pink,
      Colors.red,
      Colors.indigo,
      Colors.brown,
      Colors.cyan,
      Colors.deepOrange,
      Colors.lime,
      Colors.blueGrey,
      // Add more colors as needed
    ];
    List<PieChartSectionData> sections = List.generate(
      length,
      (index) {
        String accBalanceString = transactionDataProvider
            .listofincomeCategoryAdded[index].value
            .toString();
        double accBalance = double.tryParse(accBalanceString) ?? 0.0;
        return PieChartSectionData(
          titlePositionPercentageOffset: 1.4,
          color: colors[index],
          value: accBalance,
          radius: 100,
          // title:
          //     '''${accountProvider.accountList[index].accName} \n ${accountProvider.accountList[index].accBalance}''',
          titleStyle: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: appTheme.mainTextColor,
          ),
        );
      },
    );

    return sections;
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = Provider.of<AppTheme>(context, listen: true);
    return Provider.of<TransactionDataProvider>(context, listen: true)
            .incomeaccountList
            .isEmpty
        ? const Center(
            child: Text(
              'No Income is Added yet',
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
                              sections: getSections(context),

                              // [

                              //   piechartdata(
                              //       transactionDataProvider
                              //           .sumofincomesalary!,
                              //       Colors.amber),
                              //   piechartdata(
                              //       transactionDataProvider
                              //           .sumofincomefreelance!,
                              //       Colors.blue),
                              //   piechartdata(
                              //       transactionDataProvider
                              //           .sumofincomerental!,
                              //       Colors.green),
                              //   piechartdata(
                              //       transactionDataProvider
                              //           .sumofincomeinvestment!,
                              //       Colors.orange),
                              //   piechartdata(
                              //       transactionDataProvider.sumofincomegift!,
                              //       Colors.purple),
                              //   piechartdata(
                              //       transactionDataProvider
                              //           .sumofincomereimbursements!,
                              //       Colors.yellow),
                              //   piechartdata(
                              //       transactionDataProvider
                              //           .sumofincomerefunds!,
                              //       Colors.teal),
                              //   piechartdata(
                              //       transactionDataProvider
                              //           .sumofincomedividend!,
                              //       Colors.pink),
                              //   piechartdata(
                              //       transactionDataProvider
                              //           .sumofincomeinterest!,
                              //       Colors.red),
                              //   piechartdata(
                              //       transactionDataProvider
                              //           .sumofincomebusiness!,
                              //       Colors.indigo),
                              //   piechartdata(
                              //       transactionDataProvider
                              //           .sumofincomeroyalty!,
                              //       Colors.brown),
                              //   piechartdata(
                              //       transactionDataProvider
                              //           .sumofincomealimony!,
                              //       Colors.cyan),
                              //   piechartdata(
                              //       transactionDataProvider
                              //           .sumofincomecapitalGains!,
                              //       Colors.deepOrange),
                              //   piechartdata(
                              //       transactionDataProvider
                              //           .sumofincomescholarship!,
                              //       Colors.lime),
                              //   piechartdata(
                              //       transactionDataProvider
                              //           .sumofincomelotteryWinnings!,
                              //       Colors.blueGrey),
                              // ]
                            )))),
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
                      SizedBox(
                        height: 150,
                        child: GridView.builder(
                          itemCount: Provider.of<TransactionDataProvider>(
                                  context,
                                  listen: false)
                              .listofincomeCategoryAdded
                              .length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  mainAxisSpacing: 1.0,
                                  childAspectRatio: 5),
                          itemBuilder: (context, index) {
                            List<Color> colors = [
                              Colors.amber,
                              Colors.blue,
                              Colors.green,
                              Colors.orange,
                              Colors.purple,
                              Colors.yellow,
                              Colors.teal,
                              Colors.pink,
                              Colors.red,
                              Colors.indigo,
                              Colors.brown,
                              Colors.cyan,
                              Colors.deepOrange,
                              Colors.lime,
                              Colors.blueGrey,
                            ];
                            return Consumer<TransactionDataProvider>(
                                builder: ((context, transactionDataProvider,
                                        child) =>
                                    Row(
                                      children: [
                                        Icon(
                                          size: 15,
                                          Icons.pie_chart,
                                          color: colors[index],
                                        ),
                                        const SizedBox(width: 5),
                                        Text(
                                          transactionDataProvider
                                              .listofincomeCategoryAdded[index]
                                              .key,
                                          style: TextStyle(
                                              color: colors[index],
                                              fontSize: 10),
                                        )
                                      ],
                                    )));
                          },
                        ),
                      ),
                      Consumer<ProfileDataProvider>(
                          builder: ((context, accountDataProvider, child) =>
                              Container(
                                  height: 75,
                                  width: 150,
                                  decoration: const BoxDecoration(
                                      color: Colors.green,
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
                                                ' ${transactionDataProvider.accIncome}',
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
          style: TextStyle(color: incdicatorcolor, fontSize: 10),
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
