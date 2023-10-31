import 'package:financify/notifierclass/account_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> showAccountAddPopup(BuildContext context) async {
  TextEditingController accountNameController = TextEditingController();
  TextEditingController accountBalanceController = TextEditingController();
  showDialog(
      context: context,
      builder: (ctx) {
        return SimpleDialog(
          title: const Text('Add Account'),
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 50,
                child: TextFormField(
                  controller: accountNameController,
                  decoration: const InputDecoration(
                      hintText: 'Account Name', border: OutlineInputBorder()),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 50,
                child: TextFormField(
                  controller: accountBalanceController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      hintText: 'Account Balance',
                      border: OutlineInputBorder()),
                ),
              ),
            ),
            Consumer<AccountDataProvider>(
                builder: ((context, AccountDataProvider, child) => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('CLOSE')),
                        ElevatedButton(
                            onPressed: () async {
                              AccountDataProvider.setId();
                              AccountDataProvider.accNameSet(
                                  accountNameController.text);
                              AccountDataProvider.accBalanaceSet(
                                  accountBalanceController.text);
                              await AccountDataProvider.accountToDB();
                              Navigator.of(context).pop();
                            },
                            child: const Text('ADD ACCOUNT'))
                      ],
                    )))
          ],
        );
      });
}
