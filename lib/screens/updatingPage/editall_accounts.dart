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
    final appTheme = Provider.of<AppTheme>(context, listen: true);
    final transactionDataprovider =
        Provider.of<TransactionDataProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: appTheme.backgroundColor,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back,
              color: appTheme.primaryColor,
            )),
        backgroundColor: appTheme.darkblue,
        title: Text(
          'Edit All the Account',
          style: TextStyle(color: appTheme.primaryColor),
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
                              accountdataprovider.accountList[index]);
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(13),
                        ),
                        tileColor: appTheme.listTileColor,
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              accountdataprovider.accountList[index].accName,
                              style: TextStyle(color: appTheme.mainTextColor),
                            ),
                            Row(
                              children: [
                                Text(
                                  accountdataprovider
                                      .accountList[index].accBalance,
                                  style: const TextStyle(
                                      color: Color.fromARGB(255, 43, 236, 49)),
                                ),
                                IconButton(
                                    onPressed: () async {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext ctx) {
                                          return AlertDialog(
                                            title: const Text('Are you sure?'),
                                            content: const Text(
                                                'All the Transaction data from this account will be Deleted'),
                                            actions: [
                                              TextButton(
                                                child: const Text('CANCEL'),
                                                onPressed: () {
                                                  Navigator.of(ctx).pop();
                                                },
                                              ),
                                              Consumer<AccountDataProvider>(
                                                  builder: ((context,
                                                          accountDataProvider,
                                                          child) =>
                                                      TextButton(
                                                        child: const Text(
                                                            'DELETE'),
                                                        onPressed: () async {
                                                          await transactionDataprovider
                                                              .deleteAllTransactionUnderAccount(
                                                                  accountdataprovider
                                                                      .accName);

                                                          await accountdataprovider
                                                              .dBDeleteAccount(
                                                                  accountdataprovider
                                                                      .accountList[
                                                                          index]
                                                                      .id)
                                                              .then((value) =>
                                                                  Navigator.of(
                                                                          ctx)
                                                                      .pop());
                                                        },
                                                      ))),
                                            ],
                                          );
                                        },
                                      );
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
