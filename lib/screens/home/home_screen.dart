import 'package:financify/providers/account_notifier.dart';
import 'package:financify/screens/home/functions/functions.dart';
import 'package:financify/screens/home/widgets/list_of_accounts.dart';
import 'package:financify/screens/home/widgets/piecharts.dart';
import 'package:financify/utils/themes.dart';
import 'package:financify/widgets/custom_appbar.dart';
import 'package:financify/screens/home/widgets/totalaccountschart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appTheme = Provider.of<AppTheme>(context, listen: true);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBarr(
        appTheme: appTheme,
        title: 'HOME',
        leading: IconButton(
          onPressed: () {
            appTheme.appthemeDarkMode
                ? appTheme.changeToLight()
                : appTheme.changeToDark();
          },
          icon: Icon(
            appTheme.appthemeDarkMode ? Icons.light_mode : Icons.dark_mode,
            color: appTheme.primaryColor,
          ),
        ),
      ),
      backgroundColor: appTheme.backgroundColor,
      body: SingleChildScrollView(
        child: Consumer<AccountDataProvider>(
            builder: ((context, accountdataprovider, child) => SafeArea(
                  child: Padding(
                    padding: kIsWeb
                        ? EdgeInsets.symmetric(
                            vertical: 20,
                            horizontal:
                                MediaQuery.of(context).size.width * 0.25)
                        : const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          height: accountdataprovider.accountList.length > 2 &&
                                  accountdataprovider.accountList.length % 2 !=
                                      0
                              ? increaseheight(
                                  accountdataprovider.accountList.length, 175)
                              : accountdataprovider.accountList.length > 2 &&
                                      accountdataprovider.accountList.length %
                                              2 ==
                                          0
                                  ? increaseheight(
                                      accountdataprovider.accountList.length,
                                      175)
                                  : 175,
                          decoration: BoxDecoration(
                            color: appTheme.darkblue,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: ListOfAccounts(appTheme: appTheme),
                          ),
                        ),
                        const IncomeExpenseAndTransferPieChart(),
                        const AccountsPieChartBox()
                      ],
                    ),
                  ),
                ))),
      ),
    );
  }
}
