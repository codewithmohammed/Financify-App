import 'package:currency_picker/currency_picker.dart';
import 'package:financify/providers/account_notifier.dart';
import 'package:financify/providers/profile_notifiers.dart';
import 'package:financify/utils/images.dart';
import 'package:financify/utils/themes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CurrencySelect extends StatefulWidget {
  const CurrencySelect({super.key});

  @override
  State<CurrencySelect> createState() => _CurrencySelectState();
}

class _CurrencySelectState extends State<CurrencySelect> {
  @override
  Widget build(BuildContext context) {
    final appTheme = Provider.of<AppTheme>(context, listen: true);
    return Scaffold(
      backgroundColor: appTheme.backgroundColor,
      body: Consumer<ProfileDataProvider>(
        builder: ((context, profiledataprovider, child) => SafeArea(
              child: Center(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 1,
                                  color: appTheme.primaryColor,
                                  offset: const Offset(0, 5))
                            ],
                            color: appTheme.darkblue,
                            borderRadius: BorderRadius.circular(100)),
                        child: Image.asset(
                          ImgIcons.iconcash,
                          scale: 4,
                        )),
                    SizedBox(
                      height: 100,
                      child: Center(
                        child: Text(
                          'Select base currency',
                          style: TextStyle(
                              fontSize: 20,
                              color: appTheme.mainTextColor,
                              fontWeight: FontWeight.w900),
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                        child: InkWell(
                      onTap: () {
                        showCurrencyPicker(
                          theme: CurrencyPickerThemeData(
                              backgroundColor: appTheme.backgroundColor,
                              currencySignTextStyle:
                                  TextStyle(color: appTheme.primaryColor),
                              subtitleTextStyle:
                                  TextStyle(color: appTheme.primaryColor),
                              titleTextStyle:
                                  TextStyle(color: appTheme.mainTextColor)),
                          context: context,
                          showFlag: true,
                          showCurrencyName: true,
                          onSelect: (Currency currency) {
                            profiledataprovider.replaceCurrency(currency.code);
                            profiledataprovider
                                .replaceCountrySymbol(currency.symbol);
                            profiledataprovider.replaceCountry(currency.name);
                          },
                        );
                      },
                      child: Container(
                          decoration: BoxDecoration(
                              boxShadow: const [
                                BoxShadow(
                                    offset: Offset(0, 5),
                                    blurRadius: 5,
                                    blurStyle: BlurStyle.normal)
                              ],
                              color: appTheme.black,
                              borderRadius: BorderRadius.circular(5)),
                          width: 350,
                          height: 60,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 10, left: 20, right: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      profiledataprovider.currencyCode,
                                      style: TextStyle(
                                          color: appTheme.mainTextColor),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      profiledataprovider.currencyCountry,
                                      style: TextStyle(
                                          color: appTheme.mainTextColor),
                                    ),
                                  ],
                                ),
                                Icon(
                                  Icons.arrow_drop_down,
                                  color: appTheme.mainTextColor,
                                )
                              ],
                            ),
                          )),
                    )),
                    Padding(
                      padding: const EdgeInsets.only(top: 40, ),
                      child: Text(
                        'Your base currency  should be ideally be the one you use most \noften.  Your balance & statistics will be shown in this currency.',
                        style: TextStyle(
                            color: appTheme.accentColor, fontSize: 12),
                      ),
                    ),
                    Expanded(child: Container(),),
                    Consumer<AccountDataProvider>(
                        builder: ((context, accountDataProvider, child) =>
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                  width: 350,
                                  height: 54,
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      accountDataProvider.accountToDB();
                                      final sharedPrefs =
                                          await SharedPreferences.getInstance();
                                      await sharedPrefs.setString(
                                          'SAVE_KEY_LOGIN', 'true');
                                      profiledataprovider.profileToBD();
                                      toCashSelect();
                                    },
                                    style: ButtonStyle(
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(17.0),
                                      )),
                                      textStyle: MaterialStateProperty.all(
                                          TextStyle(
                                              color: appTheme.accentColor,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w900)),
                                      foregroundColor:
                                          MaterialStateProperty.all<Color>(
                                              appTheme.mainTextColor),
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              appTheme.black),
                                      surfaceTintColor:
                                          MaterialStateProperty.all<Color>(
                                              appTheme.primaryColor),
                                    ),
                                    child: const Text(
                                      'CONFIRM',
                                      style: TextStyle(fontSize: 25),
                                    ),
                                  )),
                            )))
                  ],
                ),
              ),
            )),
      ),
    );
  }

  void toCashSelect() {
    Navigator.of(context)
        .pushNamedAndRemoveUntil('CashAccountAmt', (route) => false);
  }
}
