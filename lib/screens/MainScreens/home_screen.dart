import 'package:financify/providers/account_notifier.dart';
import 'package:financify/providers/profile_notifiers.dart';
import 'package:financify/utils/themes.dart';
import 'package:financify/widgets/account_add_popup.dart';
import 'package:financify/widgets/homeScreenWidget/piecharts.dart';
import 'package:financify/widgets/homeScreenWidget/totalaccountschart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  increaseheight(int length, double initialHeight) {
    if (length % 2 != 0) {
      final iterate = (length + 1) / 2;
      for (int i = 1; i < iterate; i++) {
        initialHeight = initialHeight + 50;
      }
      return initialHeight;
    } else {
      final iterate = length / 2;
      for (int i = 1; i < iterate; i++) {
        initialHeight = initialHeight + 50;
      }
      return initialHeight;
    }
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = Provider.of<AppTheme>(context, listen: true);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: appTheme.darkblue,
        leading: SizedBox(
          height: 200,
          child: PopupMenuButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
            color: appTheme.darkblue,
            position: PopupMenuPosition.under,
            itemBuilder: (ctx) => [
              PopupMenuItem(child: Switchrow(appTheme: appTheme)),
            ],
            child: Icon(
              Icons.menu,
              color: appTheme.primaryColor,
            ),
          ),
        ),
        title: Text(
          'HOME',
          style: TextStyle(color: appTheme.primaryColor),
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
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'List of Accounts',
                                  style: TextStyle(
                                      color: appTheme.mainTextColor,
                                      fontSize: 20),
                                ),
                                Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: SingleChildScrollView(
                                      child: SizedBox(
                                        height: accountdataprovider
                                                        .accountList.length >
                                                    2 &&
                                                accountdataprovider.accountList
                                                            .length %
                                                        2 !=
                                                    0
                                            ? increaseheight(
                                                accountdataprovider
                                                    .accountList.length,
                                                60)
                                            : accountdataprovider.accountList
                                                            .length >
                                                        2 &&
                                                    accountdataprovider
                                                                .accountList
                                                                .length %
                                                            2 ==
                                                        0
                                                ? increaseheight(
                                                    accountdataprovider
                                                        .accountList.length,
                                                    60)
                                                : 60,
                                        child: GridView.builder(
                                          gridDelegate:
                                              const SliverGridDelegateWithFixedCrossAxisCount(
                                                  mainAxisExtent: 40,
                                                  crossAxisCount: 2,
                                                  crossAxisSpacing: 10.0,
                                                  mainAxisSpacing: 10.0,
                                                  childAspectRatio: 4),
                                          itemCount: accountdataprovider
                                              .accountList.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return InkWell(
                                              onTap: () {
                                                showAccountAddPopup(
                                                    context,
                                                    true,
                                                    accountdataprovider
                                                        .accountList[index]);
                                              },
                                              child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.amber,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
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
                                                        Text(accountdataprovider
                                                            .accountList[index]
                                                            .accName),
                                                        Consumer<
                                                                ProfileDataProvider>(
                                                            builder: ((context,
                                                                    profileDataProvider,
                                                                    child) =>
                                                                Text(
                                                                    '${accountdataprovider.accountList[index].accBalance}\t${profileDataProvider.currencySymbol}')))
                                                      ],
                                                    ),
                                                  )),
                                            );
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
                                        child: Text(
                                          'ADD ACCOUNT',
                                          style: TextStyle(
                                              color: appTheme.mainTextColor),
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

class Switchrow extends StatefulWidget {
  const Switchrow({
    super.key,
    required this.appTheme,
  });

  final AppTheme appTheme;

  @override
  State<Switchrow> createState() => _SwitchrowState();
}

class _SwitchrowState extends State<Switchrow> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.dark_mode,
          color: widget.appTheme.mainTextColor,
          size: 20,
        ),
        Text(
          'Dark Mode',
          style: TextStyle(color: widget.appTheme.mainTextColor, fontSize: 12),
        ),
        Padding(
            padding: const EdgeInsets.only(right: 8, left: 8),
            child: SizedBox(
              width: 40,
              child: Transform.scale(
                scale: 0.7,
                child: Switch(
                    value: widget.appTheme.appthemeDarkMode,
                    onChanged: (value) {
                      if (value == false) {
                        widget.appTheme.changeToLight();
                      } else {
                        widget.appTheme.changeToDark();
                      }
                      setState(() {});
                    }),
              ),
            ))
      ],
    );
  }
}
