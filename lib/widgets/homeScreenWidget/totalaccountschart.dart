import 'package:financify/providers/account_notifier.dart';
import 'package:financify/utils/themes.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccountsPieChartBox extends StatelessWidget {
  const AccountsPieChartBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final appTheme = Provider.of<AppTheme>(context, listen: true);
    return Visibility(
      visible: Provider.of<AccountDataProvider>(context, listen: false)
          .accountList
          .isNotEmpty,
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
                    'Account Balances',
                    style:
                        TextStyle(color: appTheme.mainTextColor, fontSize: 20),
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
                    PieChart(
                        swapAnimationDuration:
                            const Duration(milliseconds: 750),
                        PieChartData(
                          sectionsSpace: 0,
                          centerSpaceRadius: 0,
                          sections: getSections(context),
                        )),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  //The Logic behind the generation of colors and piechart.

  List<PieChartSectionData> getSections(BuildContext context) {
    final appTheme = Provider.of<AppTheme>(context, listen: true);
    final accountProvider =
        Provider.of<AccountDataProvider>(context, listen: true);
    int length = accountProvider.accountList.length;


    final double step = 360 / length;
    List<Color> colors = List.generate(length, (index) {
    final double hue = step * index;
    final Color color = HSVColor.fromAHSV(1.0, hue, 1.0, 1.0).toColor();
    return color;
  });

    List<PieChartSectionData> sections = List.generate(
      accountProvider.accountList.length,
      (index) {
        String accBalanceString = accountProvider.accountList[index].accBalance;
        double accBalance = double.tryParse(accBalanceString) ?? 0.0;
        return PieChartSectionData(
          titlePositionPercentageOffset: 1.4,
          color: colors[index % colors.length],
          value: accBalance,
          radius: 100,
          title:
              '''${accountProvider.accountList[index].accName} \n ${accountProvider.accountList[index].accBalance}''',
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
}
