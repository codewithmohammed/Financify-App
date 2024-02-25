import 'package:financify/model/category/accountcategory/account_model.dart';
import 'package:financify/providers/account_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> showAccountAddPopup(BuildContext context, bool update,
    [AccountModel? accountModel]) async {
  TextEditingController accountNameController = TextEditingController();
  TextEditingController accountBalanceController = TextEditingController();

  final nameKey = GlobalKey<FormState>();
  final numberKey = GlobalKey<FormState>();
  showDialog(
      context: context,
      builder: update == false
          ? (ctx) {
              return SimpleDialog(
                title: const Text('Add Account'),
                children: [
                  Consumer<AccountDataProvider>(
                      builder: ((context, accountdataprovider, child) =>
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              height: 80,
                              child: Form(
                                key: nameKey,
                                child: TextFormField(
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  validator: (value) {
                                    final listAccounts = accountdataprovider
                                        .accountList
                                        .map((accname) => accname.accName)
                                        .toList();
                                    for (var account in listAccounts) {
                                      if (account == value) {
                                        return 'The account name already exists';
                                      }
                                    }
                                    if (value == null || value.trim().isEmpty) {
                                      return 'The account Name Cannot be Empty';
                                    }
                                    return null;
                                  },
                                  controller: accountNameController,
                                  decoration: const InputDecoration(
                                      hintText: 'Account Name',
                                      border: OutlineInputBorder()),
                                ),
                              ),
                            ),
                          ))),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 80,
                      child: Form(
                        key: numberKey,
                        child: TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'The Account amount cannot be empty';
                            }
                            if (!RegExp(r'^\d*\.?\d+$').hasMatch(value)) {
                              return ' Please enter a valid number';
                            }
                            return null;
                          },
                          controller: accountBalanceController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                              hintText: 'Account Balance',
                              border: OutlineInputBorder()),
                        ),
                      ),
                    ),
                  ),
                  Consumer<AccountDataProvider>(
                      builder: ((context, accountdataprovider, child) => Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('CLOSE')),
                              ElevatedButton(
                                  onPressed: () async {
                                    if (nameKey.currentState!.validate() &&
                                        numberKey.currentState!.validate()) {
                                      accountdataprovider.setId();
                                      accountdataprovider.accNameSet(
                                          accountNameController.text);
                                      accountdataprovider.accBalanaceSet(
                                          accountBalanceController.text);
                                      await accountdataprovider
                                          .accountToDB()
                                          .then((value) =>
                                              Navigator.of(context).pop());
                                    }
                                  },
                                  child: const Text('ADD ACCOUNT'))
                            ],
                          )))
                ],
              );
            }
          : (ctx) {
              accountBalanceController.text = accountModel!.accBalance;
              accountNameController.text = accountModel.accName;
              return SimpleDialog(
                title: const Text('Update Account'),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 80,
                      child: Form(
                        key: nameKey,
                        child: TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            return null;
                          },
                          controller: accountNameController,
                          decoration: const InputDecoration(
                              hintText: 'Account Name',
                              border: OutlineInputBorder()),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 80,
                      child: Form(
                        key: numberKey,
                        child: TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'The Amount Cannot Be Empty';
                            }
                            if (!RegExp(r'^\d*\.?\d+$').hasMatch(value)) {
                              return ' Please enter a valid number or a decimal';
                            }
                            return null;
                          },
                          controller: accountBalanceController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                              hintText: 'Account Balance',
                              border: OutlineInputBorder()),
                        ),
                      ),
                    ),
                  ),
                  Consumer<AccountDataProvider>(
                      builder: ((context, accountdataprovider, child) => Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('CLOSE')),
                              ElevatedButton(
                                  onPressed: () async {
                                    if (nameKey.currentState!.validate() &&
                                        numberKey.currentState!.validate()) {
                                      accountdataprovider
                                          .updateId(accountModel.id);
                                      accountdataprovider.accNameSet(
                                          accountNameController.text);
                                      accountdataprovider.accBalanaceSet(
                                          accountBalanceController.text);
                                      await accountdataprovider
                                          .accountToDB()
                                          .then((value) =>
                                              Navigator.of(context).pop());
                                    }
                                  },
                                  child: const Text('UPDATE ACCOUNT'))
                            ],
                          )))
                ],
              );
            });
}
