
import 'package:financify/providers/account_provider.dart';
import 'package:financify/providers/profile_provider.dart';
import 'package:financify/theme/themes.dart';
import 'package:financify/widgets/account_add_popup.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccountLists extends StatelessWidget {
  const AccountLists({
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
            // Account Grid
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: SizedBox(
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisExtent: 42,
                    crossAxisCount: 2,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                    childAspectRatio: 4,
                  ),
                  itemCount: accountDataProvider.accountList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        showAccountAddPopup(
                          context,
                          true,
                          accountDataProvider.accountList[index],
                        );
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
                                builder: (context, profileDataProvider, child) {
                                  return Text(
                                    '${accountDataProvider.accountList[index].accBalance}\t${profileDataProvider.currencySymbol}',
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            // Add Account Button and Total Balance
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
                      ),
                    ),
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
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}