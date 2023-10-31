import 'package:financify/db/account_db.dart';
import 'package:financify/notifierclass/account_notifier.dart';
import 'package:financify/notifierclass/profile_notifiers.dart';
import 'package:financify/utils/images.dart';
import 'package:financify/utils/themes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CashAccSet extends StatelessWidget {
  const CashAccSet({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController amountController = TextEditingController();
    return Scaffold(
        backgroundColor: AppTheme.backgroundColor,
        body: Consumer<AccountDataProvider>(
          builder: ((context, AccountDataProvider, child) => SafeArea(
                  child: Stack(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                          onPressed: () async {
                            AccountDataProvider.accBalanaceSet(
                                amountController.text);
                            AccountDataProvider.accountToDB();
                            FocusScope.of(context).unfocus();
                            await Future.delayed(
                                const Duration(milliseconds: 100));
                            Navigator.pushNamed(context, 'MainPage');
                          },
                          child: const Text(
                            'NEXT',
                            style: TextStyle(color: AppTheme.primaryColor),
                            textAlign: TextAlign.right,
                          )),
                    ],
                  ),
                  Center(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                            width: 200,
                            height: 200,
                            decoration: BoxDecoration(
                                boxShadow: const [
                                  BoxShadow(
                                      blurRadius: 1,
                                      color: AppTheme.primaryColor,
                                      offset: Offset(0, 5))
                                ],
                                color: AppTheme.darkblue,
                                borderRadius: BorderRadius.circular(100)),
                            child: Image.asset(
                              ImgIcons.iconcoin,
                              scale: 4,
                            )),
                        const Padding(
                          padding: EdgeInsets.only(top: 50),
                          child: SizedBox(
                            child: Center(
                              child: Text(
                                'Set up your cash balance',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: AppTheme.mainTextColor,
                                    fontWeight: FontWeight.w900),
                              ),
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(bottom: 50),
                          child: Text(
                            'How much cash do you have in your physical wallet?',
                            style: TextStyle(
                              color: AppTheme.accentColor,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                                width: 125,
                                child: TextFormField(
                                  controller: amountController,
                                  decoration: InputDecoration(
                                      hintText: 'AMOUNT',
                                      hintStyle: TextStyle(
                                          color: AppTheme.mainTextColor
                                              .withOpacity(0.2)),
                                      border: InputBorder.none),
                                  style: const TextStyle(
                                      color: AppTheme.mainTextColor,
                                      fontSize: 25),
                                  keyboardType: TextInputType.number,
                                )),
                            Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: Consumer<ProfileDataProvider>(
                                    builder: ((context, ProfileDataProvider,
                                            child) =>
                                        Text(
                                          ProfileDataProvider.currencyCode,
                                          style: const TextStyle(
                                              color: AppTheme.mainTextColor,
                                              fontSize: 20),
                                        ))))
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ))),
        ));
  }
}
