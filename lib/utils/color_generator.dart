//The Logic behind the generation of colors and piechart.

import 'package:financify/providers/account_provider.dart';
import 'package:financify/theme/themes.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
