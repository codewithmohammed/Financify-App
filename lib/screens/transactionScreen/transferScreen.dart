import 'package:financify/providers/transaction_notifier.dart';
import 'package:financify/utils/images.dart';
import 'package:financify/utils/themes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TransferScreen extends StatelessWidget {
  const TransferScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TransactionDataProvider>(
        builder: ((context, transferdataprovider, child) => Scaffold(
              backgroundColor: AppTheme.backgroundColor,
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: ListView.separated(
                    itemCount: transferdataprovider.transferaccountList.length,
                    itemBuilder: (
                      context,
                      index,
                    ) {
                      return ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(13),
                        ),
                        tileColor: AppTheme.listTileColor,
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              transferdataprovider
                                  .transferaccountList[index].accountnote,
                              style: const TextStyle(
                                  color: AppTheme.mainTextColor),
                            ),
                            Text(
                              transferdataprovider
                                  .transferaccountList[index].amount,
                              style: const TextStyle(color: Colors.blue),
                            )
                          ],
                        ),
                        subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  transferdataprovider
                                      .transferaccountList[index]
                                      .fromaccountname,
                                  style: const TextStyle(
                                      color: AppTheme.mainTextColor),
                                ),
                                const Icon(Icons.arrow_right_alt_outlined,
                                    color: Colors.blue),
                                Text(
                                  transferdataprovider
                                      .transferaccountList[index].toaccountname,
                                  style: const TextStyle(
                                      color: AppTheme.mainTextColor),
                                )
                              ],
                            ),
                            Text(
                              transferdataprovider
                                  .transferaccountList[index].transactiondate,
                              style: const TextStyle(
                                  color: AppTheme.mainTextColor),
                            )
                          ],
                        ),
                        leading: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                color: AppTheme.darkblue,
                                borderRadius: BorderRadius.circular(25)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(NavICons.iconTransfer),
                            )),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: 10,
                      );
                    },
                  ),
                ),
              ),
            )));
  }
}
