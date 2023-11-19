import 'package:financify/providers/account_notifier.dart';
import 'package:financify/providers/profile_notifiers.dart';
import 'package:financify/providers/transaction_notifier.dart';
import 'package:financify/utils/themes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrivacyAndPolicy extends StatelessWidget {
  const PrivacyAndPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    final appTheme = Provider.of<AppTheme>(context, listen: true);
    return Scaffold(
      backgroundColor: appTheme.backgroundColor,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: appTheme.primaryColor,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: appTheme.darkblue,
        title: Text(
          'Personal Data & Privacy',
          style: TextStyle(color: appTheme.primaryColor),
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const Titleandcaption(
                title: '1. Introduction',
                caption:
                    '''Welcome to Financify! We are committed to protecting your privacy and ensuring the security of your personal information. This Privacy Policy outlines how we collect, use, and safeguard your data when you use our offline money management application.''',
              ),
              const Titleandcaption(
                title: '2. Information We Collect',
                caption:
                    '''We do not collect any personally identifiable information. Financify operates offline, and all data is stored locally on your device using the Hive database. This ensures that no personal information is transmitted or accessible to us as developers.''',
              ),
              const Titleandcaption(
                title: '2.2 Financial Data:',
                caption:
                    '''The app may collect and store financial data entered by the user for the purpose of money management. This information is stored locally on your device and is not accessible or transmitted to us.''',
              ),
              const Titleandcaption(
                title: '3. How We Use Your Information',
                caption:
                    '''We do not have access to any user data, and therefore, we do not use or process your information. Your financial data is solely used for the functionality of the app and remains within the confines of your device.''',
              ),
              const Titleandcaption(
                title: '4. Data Security',
                caption:
                    '''We take the security of your data seriously. Financify uses the Hive database to store information locally on your device, ensuring that your data is secure and not susceptible to unauthorized access or external breaches.''',
              ),
              const Titleandcaption(
                title: '5. Data Access by Developers',
                caption:
                    '''As developers, we do not have any means to access or retrieve your personal or financial data. The data stored in the Hive database is exclusively controlled by you, the user.''',
              ),
              const Titleandcaption(
                title: '6. Updates and Maintenance',
                caption:
                    '''In the event of app updates or maintenance, any data processing occurs exclusively on your device. We do not transfer or store any data on external servers during these processes.''',
              ),
              const Titleandcaption(
                title: '7. Changes to the Privacy Policy',
                caption:
                    '''If there are changes to this privacy policy, we will provide notice through the app, ensuring you are informed about how your data is handled.''',
              ),
              const Titleandcaption(
                title: '8. Contact Information',
                caption:
                    '''If you have any questions or concerns about this Privacy Policy, please contact us at rayidrasal@gmail.com.''',
              ),
              const SizedBox(
                height: 20,
              ),
              Consumer<TransactionDataProvider>(
                builder: (ctx, transactionDataProvider, child) => InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext ctx) {
                        return AlertDialog(
                          title: const Text('Delete all user data?'),
                          content: const Text(
                              'All your data including records, etc., will be lost. It will not affect your login information.'),
                          actions: [
                            TextButton(
                              child: const Text('CANCEL'),
                              onPressed: () {
                                Navigator.of(ctx).pop();
                              },
                            ),
                            Consumer<AccountDataProvider>(
                                builder: ((context, accountDataProvider,
                                        child) =>
                                    TextButton(
                                      child: const Text('DELETE'),
                                      onPressed: () async {
                                        await transactionDataProvider
                                            .deleteAllTransaciion();
                                        await accountDataProvider
                                            .deleteAccount()
                                            .then((value) => Navigator.of(ctx)
                                                .popUntil(
                                                    (route) => route.isFirst));
                                      },
                                    ))),
                          ],
                        );
                      },
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                        child: Text(
                          'DELETE ALL USER DATA',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Consumer<TransactionDataProvider>(
                  builder: ((ctx, transactionDataProvider, child) => InkWell(
                        onTap: () async {
                          await showDialog(
                            context: context,
                            builder: (BuildContext ctx) {
                              return AlertDialog(
                                title: const Text('Delete all user data?'),
                                content: const Text(
                                    '''All financial transaction and profile information is irreversibly deleted and all data is lost'''),
                                actions: [
                                  TextButton(
                                    child: const Text('CANCEL'),
                                    onPressed: () {
                                      Navigator.of(ctx).pop();
                                    },
                                  ),
                                  TextButton(
                                    child: const Text('DELETE'),
                                    onPressed: () async {
                                      final sharedPrefs =
                                          await SharedPreferences.getInstance();
                                      sharedPrefs.setString(
                                          'SAVE_KEY_LOGIN', 'false');
                                      await transactionDataProvider
                                          .deleteAllTransaciion()
                                          .then((value) => Provider.of<AccountDataProvider>(ctx, listen: false)
                                              .deleteAccount()
                                              .then((value) =>
                                                  Provider.of<ProfileDataProvider>(
                                                          ctx,
                                                          listen: false)
                                                      .deleteProfile())
                                              .then((value) =>
                                                  Navigator.of(ctx).pop())
                                              .then((value) => Navigator.of(ctx)
                                                  .pushNamedAndRemoveUntil(
                                                      'Profileset', (route) => false)));
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              height: 50,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(10)),
                              child: const Center(
                                child: Text(
                                  'DELETE PROFILE AND ALL DATA',
                                  style: TextStyle(color: Colors.white),
                                ),
                              )),
                        ),
                      ))),
            ],
          ),
        ),
      )),
    );
  }
}

class Titleandcaption extends StatelessWidget {
  final String? title;
  final String? caption;
  const Titleandcaption(
      {super.key, required this.title, required this.caption});

  @override
  Widget build(BuildContext context) {
    final appTheme = Provider.of<AppTheme>(context, listen: true);
    return Column(
      children: [
        const SizedBox(
          height: 15,
        ),
        Text(
          title!,
          style: const TextStyle(color: Colors.grey, fontSize: 20),
        ),
        const SizedBox(
          height: 15,
        ),
        Text(
          caption!,
          textAlign: TextAlign.center,
          style: TextStyle(color: appTheme.mainTextColor, fontSize: 15),
        ),
      ],
    );
  }
}
