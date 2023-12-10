import 'package:dropdown_button2/dropdown_button2.dart';
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

  List<PieChartSectionData> getSections(BuildContext context) {
    final appTheme = Provider.of<AppTheme>(context, listen: true);
    final transactionDataProvider =
        Provider.of<TransactionDataProvider>(context, listen: true);
    int length = transactionDataProvider.listofexpenseCategoryAdded.length;
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
            .listofexpenseCategoryAdded[index].value
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
     final List<String> items = [
      'All Time',
      'Today',
      'Yesterday',
      'This Month',
      'Last Month',
      'This Year',
      'Last Year',
    ];
    final appTheme = Provider.of<AppTheme>(context, listen: true);
    final transactionDataProvider =
        Provider.of<TransactionDataProvider>(context, listen: true);
    int length = transactionDataProvider.listofexpenseCategoryAdded.length;
    return transactionDataProvider.expenseaccountList
            .isEmpty
        ? const Center(
            child: Text(
              'No Expense is Added yet',
              style: TextStyle(color: Colors.grey),
            ),
          )
        : ListView(
            children: [
              Consumer<TransactionDataProvider>(
                  builder: ((context, transactionDataProvider, child) =>
                      SizedBox(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20,left: 20, right: 20),
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                                color: appTheme.primaryColor,
                                borderRadius: BorderRadius.circular(5)),
                            child: DropdownButtonHideUnderline(
                                child: DropdownButton2<String>(
                              isExpanded: true,
                              hint: Text(
                                transactionDataProvider.expenseCategorySortDataType!,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: appTheme.mainTextColor,
                                ),
                              ),
                              items: items
                                  .map(
                                      (String item) => DropdownMenuItem<String>(
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
                                  transactionDataProvider.sortThePieChartforCategory(
                                      sortingDate, value,false);
                                } else {
                                  transactionDataProvider.dBtoTransaction();
                                }
                              },
                              buttonStyleData: const ButtonStyleData(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                height: 40,
                                width: 140,
                              ),
                              menuItemStyleData: const MenuItemStyleData(
                                height: 40,
                              ),
                            )),
                          ),
                        ),
                      ))),
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
                                sections: getSections(context))))),
              ),
              Container(
                height: length <= 3
                    ? 150
                    : length <= 6
                        ? 180
                        : length <= 9
                            ? 210
                            : length <= 12
                                ? 240
                                : length <= 15
                                    ? 270
                                    : null,
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
                        height: length <= 3
                            ? 50
                            : length <= 6
                                ? 60
                                : length <= 9
                                    ? 70
                                    : length <= 12
                                        ? 80
                                        : length <= 15
                                            ? 90
                                            : null,
                        child: GridView.builder(
                          itemCount:length,
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
                                              .listofexpenseCategoryAdded[index]
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
                                                ' ${transactionDataProvider.expenseCategoryDateWise}',
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
