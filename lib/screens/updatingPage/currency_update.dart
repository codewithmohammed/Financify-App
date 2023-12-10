import 'package:currency_picker/currency_picker.dart';
import 'package:financify/providers/profile_notifiers.dart';
import 'package:financify/utils/images.dart';
import 'package:financify/utils/themes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpdateCurrencySelect extends StatefulWidget {
  const UpdateCurrencySelect({super.key});

  @override
  State<UpdateCurrencySelect> createState() => _UpdateCurrencySelectState();
}

class _UpdateCurrencySelectState extends State<UpdateCurrencySelect> {
  @override
  Widget build(BuildContext context) {
    final appTheme = Provider.of<AppTheme>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon:  Icon(Icons.arrow_back,color: appTheme.primaryColor,)),
      ),
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
                            profiledataprovider.replaceCountry(currency.name);
                            profiledataprovider
                                .replaceCountrySymbol(currency.symbol);
                            profiledataprovider.profileToBD();
                            Navigator.of(context).pop();
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
                      padding: const EdgeInsets.only(top: 40, bottom: 250),
                      child: Text(
                        'Your base currency  should be ideally be the one you use most \noften.  Your balance & statistics will be shown in this currency.',
                        style: TextStyle(
                            color: appTheme.accentColor, fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
