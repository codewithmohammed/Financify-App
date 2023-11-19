import 'package:financify/model/category/transactioncategory/transaction_model.dart';
import 'package:financify/providers/profile_notifiers.dart';
import 'package:financify/providers/transaction_notifier.dart';
import 'package:financify/screens/operationScreens/transactionScreen.dart';

import 'package:financify/transition/fadetransition.dart';

import 'package:financify/utils/images.dart';
import 'package:financify/utils/themes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Mainscreen extends StatelessWidget {
  const Mainscreen({super.key});

  @override
  Widget build(BuildContext context) {
        final appTheme = Provider.of<AppTheme>(context, listen: true);
    return Scaffold(
        backgroundColor: appTheme.backgroundColor,
        body: Consumer<ProfileDataProvider>(
            builder: ((context, profileDataProvider, child) =>
                profileDataProvider.pages[profileDataProvider.pageIndex])),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: SafeArea(
            child: SizedBox(
          height: 70,
          width: 70,
          child: FittedBox(
            child: Visibility(
              visible: MediaQuery.of(context).viewInsets.bottom == 0.0,
              child: FloatingActionButton(
                  shape: const CircleBorder(
                      side: BorderSide(style: BorderStyle.solid)),
                  backgroundColor: appTheme.primaryColor,
                  onPressed: () {
                    Provider.of<TransactionDataProvider>(context, listen: false)
                        .type = TransactionCategoryType.income;
                    Navigator.of(context).push(
                        FadeRoute(page: const TransactionOperationScreen()));
                  },
                  child: Icon(
                    Icons.add,
                    color: appTheme.backgroundColor,
                    size: 50,
                  )),
            ),
          ),
        )),
        bottomNavigationBar: Consumer<ProfileDataProvider>(
            builder: ((context, profileDataProvider, child) => SafeArea(
                  child: Container(
                    height: 70,
                    margin:
                        const EdgeInsets.only(right: 12, left: 12, bottom: 8),
                    decoration: BoxDecoration(
                        color: appTheme.darkblue,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(56))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          onTap: () {
                            profileDataProvider.changePages(0);
                          },
                          child: SizedBox(
                            width: 40,
                            child: Image.asset(
                                profileDataProvider.pageIndex == 0
                                    ? NavICons.iconHome
                                    : NavICons.iconHomeUn),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            profileDataProvider.changePages(1);
                          },
                          child: SizedBox(
                            width: 40,
                            child: Image.asset(
                                profileDataProvider.pageIndex == 1
                                    ? NavICons.iconWatch
                                    : NavICons.iconWatchUn),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            profileDataProvider.changePages(2);
                          },
                          child: SizedBox(
                            width: 40,
                            child: Image.asset(
                                profileDataProvider.pageIndex == 2
                                    ? NavICons.iconLoop
                                    : NavICons.iconLoopUn),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            profileDataProvider.changePages(3);
                          },
                          child: SizedBox(
                            width: 40,
                            child: Image.asset(
                                profileDataProvider.pageIndex == 3
                                    ? NavICons.iconSetting
                                    : NavICons.iconSettingUn),
                          ),
                        ),
                        const SizedBox(
                          width: 30,
                        )
                      ],
                    ),
                  ),
                ))));
  }
}
