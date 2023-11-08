import 'package:financify/db/transaction_db.dart';
import 'package:financify/providers/account_notifier.dart';
import 'package:financify/providers/transaction_notifier.dart';
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
        backgroundColor: AppTheme.darkblue,
        title: const Text(
          'Edit All the Account',
          style: TextStyle(color: AppTheme.primaryColor),
        ),
      ),
      body: Consumer<AccountDataProvider>(
          builder: ((context, AccountDataProvider, child) => SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: ListView.separated(
                    itemCount: AccountDataProvider.accountList.length,
                    itemBuilder: (
                      context,
                      index,
                    ) {
                      return ListTile(
                        onTap: () {
                          showAccountAddPopup(context, true,
                              AccountDataProvider.accountList[index].id);
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(13),
                        ),
                        tileColor: AppTheme.listTileColor,
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              AccountDataProvider.accountList[index].accName,
                              style: const TextStyle(
                                  color: AppTheme.mainTextColor),
                            ),
                            Row(
                              children: [
                                Text(
                                  AccountDataProvider
                                      .accountList[index].accBalance,
                                  style: const TextStyle(color: Colors.green),
                                ),
                                IconButton(
                                    onPressed: () {
                                      AccountDataProvider.dBDeleteAccount(
                                          AccountDataProvider
                                              .accountList[index].id);
                                      // TransactionDB().deleteTransaction(
                                      //     AccountDataProvider
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
