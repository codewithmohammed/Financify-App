import 'package:financify/providers/account_notifier.dart';
import 'package:financify/screens/home/functions/color_generator.dart';
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


}
