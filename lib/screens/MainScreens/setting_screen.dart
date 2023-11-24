import 'package:financify/providers/profile_notifiers.dart';
import 'package:financify/screens/updatingPage/about_app.dart';
import 'package:financify/screens/updatingPage/privacy_and_policy.dart';
import 'package:financify/utils/images.dart';
import 'package:financify/utils/themes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appTheme = Provider.of<AppTheme>(context, listen: true);
    return Scaffold(
      backgroundColor: appTheme.backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: const SizedBox(),
        backgroundColor: appTheme.darkblue,
        title: Text(
          'SETTINGS',
          style: TextStyle(color: appTheme.primaryColor),
        ),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Consumer<ProfileDataProvider>(
              builder: (context, profileDataProvider, child) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 150,
                  decoration: BoxDecoration(
                      boxShadow: const [BoxShadow(blurRadius: 10)],
                      color: appTheme.accentColor,
                      borderRadius: BorderRadius.circular(5)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 1,
                                      color: appTheme.primaryColor,
                                      offset: const Offset(0, 5))
                                ],
                                color: appTheme.darkblue,
                                borderRadius: BorderRadius.circular(75)),
                            child: profileDataProvider.imageData != null
                                ? ClipOval(
                                    child: Image.memory(
                                        profileDataProvider.imageData!,
                                        fit: BoxFit.cover))
                                : ClipOval(
                                  child: Image.asset(
                                      ImgIcons.iconperson,
                                      fit: BoxFit.contain
                                    ),
                                )),
                        Padding(
                          padding: const EdgeInsets.only(left: 50),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                profileDataProvider.nameController.text,
                                style: TextStyle(
                                    fontSize: 20,
                                    color: appTheme.darkblue,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(profileDataProvider.currencyCountry,
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: appTheme.darkblue,
                                      fontWeight: FontWeight.bold)),
                              Text(profileDataProvider.currencyCode,
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: appTheme.darkblue,
                                      fontWeight: FontWeight.bold))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                alignment: Alignment.center,
                height: 80,
                child: ListTile(
                  onTap: () {
                    Navigator.pushNamed(context, 'ProfileUpdate');
                  },
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Change Your Profile',
                          style: TextStyle(color: appTheme.mainTextColor))
                    ],
                  ),
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Change your Profile Pic and Name',
                          style:
                              TextStyle(color: appTheme.settingSubtitleColor))
                    ],
                  ),
                  leading: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          color: appTheme.darkblue,
                          borderRadius: BorderRadius.circular(25)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(ImgIcons.iconperson),
                      )),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                alignment: Alignment.center,
                child: ListTile(
                  onTap: () {
                    Navigator.pushNamed(context, 'EditallAccount');
                    ProfileDataProvider().dBToName();
                  },
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Edit All the Accounts',
                        style: TextStyle(color: appTheme.mainTextColor),
                      )
                    ],
                  ),
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Edit all the account balance and name \nif needed.',
                          style:
                              TextStyle(color: appTheme.settingSubtitleColor))
                    ],
                  ),
                  leading: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          color: appTheme.darkblue,
                          borderRadius: BorderRadius.circular(25)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(NavICons.editAllIcon),
                      )),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                alignment: Alignment.center,
                child: ListTile(
                  onTap: () {
                    Navigator.pushNamed(context, 'UpdateCurrency');
                    ProfileDataProvider().dBToName();
                  },
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Change the Currency',
                        style: TextStyle(color: appTheme.mainTextColor),
                      )
                    ],
                  ),
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('change the base currency to your wish.',
                          style:
                              TextStyle(color: appTheme.settingSubtitleColor))
                    ],
                  ),
                  leading: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          color: appTheme.darkblue,
                          borderRadius: BorderRadius.circular(25)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(ImgIcons.iconcash),
                      )),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                alignment: Alignment.center,
                child: ListTile(
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (ctx) {
                      return const PrivacyAndPolicy();
                    }));
                    ProfileDataProvider().dBToName();
                  },
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Personal Data & Policy',
                        style: TextStyle(color: appTheme.mainTextColor),
                      )
                    ],
                  ),
                  leading: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          color: appTheme.darkblue,
                          borderRadius: BorderRadius.circular(25)),
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.security,
                            size: 30,
                            color: appTheme.primaryColor,
                          ))),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                alignment: Alignment.center,
                child: ListTile(
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (ctx) {
                      return const AboutApp();
                    }));
                    ProfileDataProvider().dBToName();
                  },
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'About Financify',
                        style: TextStyle(color: appTheme.mainTextColor),
                      )
                    ],
                  ),
                  leading: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          color: appTheme.darkblue,
                          borderRadius: BorderRadius.circular(25)),
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.details,
                            size: 30,
                            color: appTheme.primaryColor,
                          ))),
                ),
              ),
            ),
            SizedBox(
                height: 80,
                child: Image.asset(
                  'assets/images/financify.png',
                )),
          ],
        ),
      ),
    );
  }
}
