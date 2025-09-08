import 'package:financify/providers/account_provider.dart';
import 'package:financify/pages/home/widgets/account_list.dart';
import 'package:financify/pages/home/widgets/transaction_pie_chart.dart';
import 'package:financify/theme/themes.dart';
import 'package:financify/widgets/container_body.dart';
import 'package:financify/widgets/custom_appbar.dart';
import 'package:financify/pages/home/widgets/account_balance_widget.dart';
import 'package:financify/widgets/dark_blue_container.dart';
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
                        DarkBlueContainer(
                          appTheme: appTheme,
                          child: AccountSection(
                            heading: 'List Of Accounts',
                            appTheme: appTheme,
                            children: [
                              AccountLists(appTheme: appTheme),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        DarkBlueContainer(
                          appTheme: appTheme,
                          child: AccountSection(
                            heading: 'Income,Expense & Tranfer',
                            appTheme: appTheme,
                            children: const [
                              TransactionPieChart()
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        DarkBlueContainer(
                          appTheme: appTheme,
                          child: AccountSection(
                            heading:    'Account Balances',
                            appTheme: appTheme,
                            children: const [AccountBalanceWidget()],
                          ),
                        ),
                        // const IncomeExpenseAndTransferPieChart(),
                      ],
                    ),
                  ),
                ))),
      ),
    );
  }
}




// import 'package:flutter/material.dart';
