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
    return Column(
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
                  'Account Balances',
                  style: TextStyle(color: AppTheme.mainTextColor, fontSize: 20),
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
                  PieChart(
                      swapAnimationDuration: const Duration(milliseconds: 750),
                      PieChartData(
                        sectionsSpace: 0,
                        centerSpaceRadius: 120,
                        sections: getSections(context),
                      )),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  //The Logic behind the generation of colors and piechart.

  List<PieChartSectionData> getSections(BuildContext context) {
    final accountProvider =
        Provider.of<AccountDataProvider>(context, listen: true);
    int length = accountProvider.accountList.length;

    final Color startColor =
        const HSVColor.fromAHSV(1.0, 120.0, 1.0, 1.0).toColor();
    final Color endColor =
        const HSVColor.fromAHSV(1.0, 0.0, 1.0, 1.0).toColor();

    final double step = 1.0 / length;
    List<Color> colors = List.generate(length, (index) {
      final double t = step * index;
      return Color.lerp(startColor, endColor, t)!;
    });

    List<PieChartSectionData> sections = List.generate(
      accountProvider.accountList.length,
      (index) {
        String accBalanceString = accountProvider.accountList[index].accBalance;
        double accBalance = double.tryParse(accBalanceString) ?? 0.0;
        return PieChartSectionData(
          color: colors[index % colors.length],
          value: accBalance,
          title:
              '''${accountProvider.accountList[index].accName} \n ${accountProvider.accountList[index].accBalance}''',
          radius: 40,
          titleStyle: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 255, 255, 255),
          ),
        );
      },
    );

    return sections;
  }
}
