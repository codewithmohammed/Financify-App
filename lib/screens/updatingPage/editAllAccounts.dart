import 'package:financify/providers/account_notifier.dart';
import 'package:financify/utils/themes.dart';
import 'package:financify/widgets/account_add_popup.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditAllAccounts extends StatelessWidget {
  const EditAllAccounts({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: AppTheme.primaryColor,
            )),
        backgroundColor: AppTheme.darkblue,
        title: const Text(
          'Edit All the Account',
          style: TextStyle(color: AppTheme.primaryColor),
        ),
      ),
      body: Consumer<AccountDataProvider>(
          builder: ((context, accountdataprovider, child) => SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: ListView.separated(
                    itemCount: accountdataprovider.accountList.length,
                    itemBuilder: (
                      context,
                      index,
                    ) {
                      return ListTile(
                        onTap: () {
                          showAccountAddPopup(context, true,
                              accountdataprovider.accountList[index].id);
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(13),
                        ),
                        tileColor: AppTheme.listTileColor,
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              accountdataprovider.accountList[index].accName,
                              style: const TextStyle(
                                  color: AppTheme.mainTextColor),
                            ),
                            Row(
                              children: [
                                Text(
                                  accountdataprovider
                                      .accountList[index].accBalance,
                                  style: const TextStyle(color: Colors.green),
                                ),
                                IconButton(
                                    onPressed: () {
                                      accountdataprovider.dBDeleteAccount(
                                          accountdataprovider
                                              .accountList[index].id);
                                      // TransactionDB().deleteTransaction(
                                      //     accountdataprovider
                                      //         .accountList[index].accBalance);
                                      // Provider.of<TransactionDataProvider>(context, listen: false).dBtoTransaction();
                                    },
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.redAccent,
                                    ))
                              ],
                            )
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: 10,
                      );
                    },
                  ),
                ),
              ))),
    );
  }
}
