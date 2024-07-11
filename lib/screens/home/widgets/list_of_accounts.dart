import 'package:financify/providers/account_notifier.dart';
import 'package:financify/providers/profile_notifiers.dart';
import 'package:financify/screens/home/functions/functions.dart';
import 'package:financify/utils/themes.dart';
import 'package:financify/widgets/account_add_popup.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListOfAccounts extends StatelessWidget {
  const ListOfAccounts({
    super.key,
    required this.appTheme,
  });

  final AppTheme appTheme;

  @override
  Widget build(BuildContext context) {
    return Consumer<AccountDataProvider>(
        builder: (context, accountDataProvider, child) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'List of Accounts',
            style: TextStyle(color: appTheme.mainTextColor, fontSize: 20),
          ),
          Padding(
              padding: const EdgeInsets.only(top: 10),
              child: SizedBox(
                // height: accountDataProvider.accountList.length > 2 &&
                //         accountDataProvider.accountList.length % 2 != 0
                //     ? increaseheight(accountDataProvider.accountList.length, 60)
                //     : accountDataProvider.accountList.length > 2 &&
                //             accountDataProvider.accountList.length % 2 == 0
                //         ? increaseheight(
                //             accountDataProvider.accountList.length, 60)
                //         : 60,
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisExtent: 42,
                      crossAxisCount: 2,
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0,
                      childAspectRatio: 4),
                  itemCount: accountDataProvider.accountList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        showAccountAddPopup(context, true,
                            accountDataProvider.accountList[index]);
                      },
                      child: Container(
                          decoration: BoxDecoration(
                            color: Colors.amber,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(accountDataProvider
                                    .accountList[index].accName),
                                Consumer<ProfileDataProvider>(
                                    builder: ((context, profileDataProvider,
                                            child) =>
                                        Text(
                                            '${accountDataProvider.accountList[index].accBalance}\t${profileDataProvider.currencySymbol}')))
                              ],
                            ),
                          )),
                    );
                  },
                ),
              )),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 30,
                  child: OutlinedButton(
                      onPressed: () {
                        showAccountAddPopup(context, false);
                      },
                      child: Text(
                        'ADD ACCOUNT',
                        style: TextStyle(color: appTheme.mainTextColor),
                      )),
                ),
                Consumer<ProfileDataProvider>(
                    builder: (context, profileDataProvider, child) {
                  return Row(
                    children: [
                      Text(
                        'Total Balance :',
                        style: TextStyle(color: appTheme.mainTextColor),
                      ),
                      Text(
                        ' ${accountDataProvider.accTotal}${profileDataProvider.currencySymbol}',
                        style:
                            const TextStyle(fontSize: 16, color: Colors.green),
                      ),
                    ],
                  );
                }),
              ],
            ),
          )
        ],
      );
    });
  }
}
