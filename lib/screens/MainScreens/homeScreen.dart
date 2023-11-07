import 'package:financify/db/account_db.dart';
import 'package:financify/db/profile_db.dart';
import 'package:financify/notifierclass/account_notifier.dart';
import 'package:financify/utils/themes.dart';
import 'package:financify/widgets/account_add_popup.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: AppTheme.darkblue,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () async {
            final sharedPrefs = await SharedPreferences.getInstance();
            sharedPrefs.setString('SAVE_KEY_LOGIN', 'false');
            AccountDB().clearAccount();
            ProfileDB().clearProfile();
          },
          color: AppTheme.primaryColor,
        ),
        title: const Text(
          'HOME',
          style: TextStyle(color: AppTheme.primaryColor),
        ),
      ),
      backgroundColor: AppTheme.backgroundColor,
      body: SingleChildScrollView(
        child: Consumer<AccountDataProvider>(
            builder: ((context, AccountDataProvider, child) => SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 215,
                          decoration: BoxDecoration(
                            color: AppTheme.darkblue,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'List of Accounts',
                                  style: TextStyle(
                                      color: AppTheme.mainTextColor,
                                      fontSize: 20),
                                ),
                                Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: SingleChildScrollView(
                                      child: SizedBox(
                                        height: 100,
                                        child: GridView.builder(
                                          gridDelegate:
                                              const SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: 2,
                                                  crossAxisSpacing: 10.0,
                                                  mainAxisSpacing: 10.0,
                                                  childAspectRatio: 4),
                                          itemCount: AccountDataProvider
                                              .accountList.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.amber,
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(AccountDataProvider
                                                          .accountList[index]
                                                          .accName),
                                                      Text(AccountDataProvider
                                                          .accountList[index]
                                                          .accBalance)
                                                    ],
                                                  ),
                                                ));
                                          },
                                        ),
                                      ),
                                    )),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: SizedBox(
                                    height: 30,
                                    child: OutlinedButton(
                                        onPressed: () {
                                          showAccountAddPopup(context, false);
                                        },
                                        child: const Text(
                                          'ADD ACCOUNT',
                                          style: TextStyle(
                                              color: AppTheme.mainTextColor),
                                        )),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
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
                                padding: EdgeInsets.all(15),
                                child: Text(
                                  'Total Amount',
                                  style: TextStyle(
                                      color: AppTheme.mainTextColor,
                                      fontSize: 20),
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
                                  const Text(
                                    'data',
                                    style: TextStyle(
                                        color: AppTheme.mainTextColor),
                                  ),
                                  PieChart(
                                      swapAnimationDuration:
                                          const Duration(milliseconds: 750),
                                      PieChartData(
                                          sectionsSpace: 0,
                                          centerSpaceRadius: 120,
                                          sections: [
                                            PieChartSectionData(
                                                titleStyle: const TextStyle(
                                                    color:
                                                        AppTheme.mainTextColor),
                                                value: AccountDataProvider
                                                    .accTotal,
                                                color: Colors.green),
                                            PieChartSectionData(
                                                titleStyle: const TextStyle(
                                                    color:
                                                        AppTheme.mainTextColor),
                                                value: 51,
                                                color: Colors.red)
                                          ])),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ))),
      ),
    );
  }
}
