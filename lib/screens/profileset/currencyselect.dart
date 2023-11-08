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
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: Consumer<ProfileDataProvider>(
        builder: ((context, ProfileDataProvider, child) => SafeArea(
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
                            boxShadow: const [
                              BoxShadow(
                                  blurRadius: 1,
                                  color: AppTheme.primaryColor,
                                  offset: Offset(0, 5))
                            ],
                            color: AppTheme.darkblue,
                            borderRadius: BorderRadius.circular(100)),
                        child: Image.asset(
                          ImgIcons.iconcash,
                          scale: 4,
                        )),
                    const SizedBox(
                      height: 100,
                      child: Center(
                        child: Text(
                          'Select base currency',
                          style: TextStyle(
                              fontSize: 20,
                              color: AppTheme.mainTextColor,
                              fontWeight: FontWeight.w900),
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                        child: InkWell(
                      onTap: () {
                        showCurrencyPicker(
                          theme: CurrencyPickerThemeData(
                              backgroundColor: AppTheme.backgroundColor,
                              currencySignTextStyle:
                                  const TextStyle(color: AppTheme.primaryColor),
                              subtitleTextStyle:
                                  const TextStyle(color: AppTheme.primaryColor),
                              titleTextStyle: const TextStyle(
                                  color: AppTheme.mainTextColor)),
                          context: context,
                          showFlag: true,
                          showCurrencyName: true,
                          onSelect: (Currency currency) {
                            ProfileDataProvider.replaceCurrency(currency.code);
                            ProfileDataProvider.replaceCountry(currency.name);
                            print('Selected currency: ${currency.code}');
                            print('Selected currency: ${currency.name}');
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
                              color: AppTheme.black,
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
                                      ProfileDataProvider.currencyCode,
                                      style: const TextStyle(
                                          color: AppTheme.mainTextColor),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      ProfileDataProvider.currencyCountry,
                                      style: const TextStyle(
                                          color: AppTheme.mainTextColor),
                                    ),
                                  ],
                                ),
                                const Icon(
                                  Icons.arrow_drop_down,
                                  color: AppTheme.mainTextColor,
                                )
                              ],
                            ),
                          )),
                    )),
                    const Padding(
                      padding: EdgeInsets.only(top: 40, bottom: 250),
                      child: Text(
                        'Your base currency  should be ideally be the one you use most \noften.  Your balance & statistics will be shown in this currency.',
                        style: TextStyle(
                            color: AppTheme.accentColor, fontSize: 12),
                      ),
                    ),
                    Consumer<AccountDataProvider>(
                        builder: ((context, AccountDataProvider, child) =>
                            SizedBox(
                                width: 350,
                                height: 54,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    AccountDataProvider.accountToDB();
                                    final sharedPrefs =
                                        await SharedPreferences.getInstance();
                                    await sharedPrefs.setString(
                                        'SAVE_KEY_LOGIN', 'true');
                                    ProfileDataProvider.profileToBD();
                                    Navigator.pushNamedAndRemoveUntil(context,
                                        'CashAccountAmt', (route) => false);
                                  },
                                  style: ButtonStyle(
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(17.0),
                                    )),
                                    textStyle: MaterialStateProperty.all(
                                        const TextStyle(
                                            color: AppTheme.accentColor,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w900)),
                                    foregroundColor:
                                        MaterialStateProperty.all<Color>(
                                            AppTheme.mainTextColor),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            AppTheme.black),
                                    surfaceTintColor:
                                        MaterialStateProperty.all<Color>(
                                            AppTheme.primaryColor),
                                  ),
                                  child: const Text(
                                    'CONFIRM',
                                    style: TextStyle(fontSize: 25),
                                  ),
                                ))))
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
