import 'package:financify/providers/account_notifier.dart';
import 'package:financify/providers/profile_notifiers.dart';
import 'package:financify/utils/themes.dart';
import 'package:financify/widgets/account_add_popup.dart';
import 'package:financify/widgets/homeScreenWidget/piecharts.dart';
import 'package:financify/widgets/homeScreenWidget/totalaccountschart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: AppTheme.darkblue,
        leading: SizedBox(
          height: 200,
          child: PopupMenuButton(
            onOpened: () {},
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
            color: AppTheme.listTileColor,
            position: PopupMenuPosition.under,
            itemBuilder: (ctx) => [
              PopupMenuItem(
                  onTap: () {
                    // bottomSheet(context);
                  },
                  height: 40,
                  child: const Row(
                    children: [
                      // Switch(value: true, onChanged: (){})
                    ],
                  )),
            ],
            child: const Icon(
              Icons.menu,
              color: AppTheme.primaryColor,
            ),
          ),
        ),

        // IconButton(
        //   icon: const Icon(Icons.menu),
        //   onPressed: () async {
        //     final sharedPrefs = await SharedPreferences.getInstance();
        //     sharedPrefs.setString('SAVE_KEY_LOGIN', 'false');
        //     TransactionDB().clearTransaction();
        //     AccountDB().clearAccount();
        //     ProfileDB().clearProfile();
        //   },
        //   color: AppTheme.primaryColor,
        // ),
        title: const Text(
          'HOME',
          style: TextStyle(color: AppTheme.primaryColor),
        ),
      ),
      backgroundColor: AppTheme.backgroundColor,
      body: SingleChildScrollView(
        child: Consumer<AccountDataProvider>(
            builder: ((context, acoountdataprovider, child) => SafeArea(
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
                                          itemCount: acoountdataprovider
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
                                                      Text(acoountdataprovider
                                                          .accountList[index]
                                                          .accName),
                                                      Consumer<
                                                              ProfileDataProvider>(
                                                          builder: ((context,
                                                                  profileDataProvider,
                                                                  child) =>
                                                              Text(
                                                                  '${acoountdataprovider.accountList[index].accBalance}\t${profileDataProvider.currencyCode}')))
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
                        const PieChartBox(),
                        const AccountsPieChartBox()
                      ],
                    ),
                  ),
                ))),
      ),
    );
  }
}
