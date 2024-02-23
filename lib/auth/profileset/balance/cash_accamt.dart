// ignore: file_names
import 'package:financify/auth/profileset/name&profile/widgets/circle_widget_with_icon.dart';
import 'package:financify/providers/account_notifier.dart';
import 'package:financify/providers/profile_notifiers.dart';
import 'package:financify/utils/images.dart';
import 'package:financify/utils/themes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CashAccSet extends StatelessWidget {
  const CashAccSet({super.key});

  @override
  Widget build(BuildContext context) {
    final appTheme = Provider.of<AppTheme>(context, listen: true);
    TextEditingController amountController = TextEditingController();
    return Scaffold(
        backgroundColor: appTheme.backgroundColor,
        body: Consumer<AccountDataProvider>(
          builder: ((context, accountdataprovider, child) => SafeArea(
                  child: Stack(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                          onPressed: () async {
                            if (amountController.text.isEmpty) {
                              accountdataprovider.accBalanaceSet('0');
                              accountdataprovider.accountToDB();
                              FocusScope.of(context).unfocus();
                              await Future.delayed(
                                  const Duration(milliseconds: 100)).then((value) => toMainPage(context));
                            } else {
                              accountdataprovider
                                  .accBalanaceSet(amountController.text);
                              accountdataprovider.accountToDB();
                              FocusScope.of(context).unfocus();
                              await Future.delayed(
                                  const Duration(milliseconds: 100)).then((value) => toMainPage(context));
                            }
                          },
                          child: Text(
                            'NEXT',
                            style: TextStyle(color: appTheme.primaryColor),
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
                        CircleWidgetWithIcon(insideIcon: Image.asset(
                              ImgIcons.iconcoin,
                              scale: 4,
                            ),),
                        Padding(
                          padding: const EdgeInsets.only(top: 50),
                          child: SizedBox(
                            child: Center(
                              child: Text(
                                'Set up your cash balance',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: appTheme.mainTextColor,
                                    fontWeight: FontWeight.w900),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 50),
                          child: Text(
                            'How much cash do you have in your physical wallet?',
                            style: TextStyle(
                              color: appTheme.accentColor,
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
                                          color: appTheme.mainTextColor
                                              .withOpacity(0.2)),
                                      border: InputBorder.none),
                                  style: TextStyle(
                                      color: appTheme.mainTextColor,
                                      fontSize: 25),
                                  keyboardType: TextInputType.number,
                                )),
                            Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: Consumer<ProfileDataProvider>(
                                    builder: ((context, profiledataprovider,
                                            child) =>
                                        Text(
                                          profiledataprovider.currencyCode,
                                          style: TextStyle(
                                              color: appTheme.mainTextColor,
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

  void toMainPage(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, 'MainPage', (route) => false);
  }
}
