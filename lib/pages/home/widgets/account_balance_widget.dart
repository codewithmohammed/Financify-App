import 'package:financify/providers/account_provider.dart';
import 'package:financify/utils/color_generator.dart';
// import 'package:financify/theme/themes.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccountBalanceWidget extends StatelessWidget {
  const AccountBalanceWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // final appTheme = Provider.of<AppTheme>(context, listen: true);
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
              SizedBox(
                height: 350,
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
