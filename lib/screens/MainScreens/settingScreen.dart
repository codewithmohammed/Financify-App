import 'package:financify/notifierclass/profile_notifiers.dart';
import 'package:financify/utils/images.dart';
import 'package:financify/utils/themes.dart';
import 'package:flutter/material.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: const SizedBox(),
        backgroundColor: AppTheme.darkblue,
        title: const Text(
          'SETTINGS',
          style: TextStyle(color: AppTheme.primaryColor),
        ),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, 'ProfileUpdate');
              },
              tileColor: AppTheme.listTileColor,
              title: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text('Change Your Profile',style: TextStyle(color: AppTheme.mainTextColor))],
              ),
              subtitle: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text('Change your Profile Pic and Name',style: TextStyle(color: AppTheme.settingSubtitleColor))],
              ),
              leading: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      color: AppTheme.darkblue,
                      borderRadius: BorderRadius.circular(25)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(ImgIcons.iconperson),
                  )),
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, 'EditallAccount');
                ProfileDataProvider().dBToName();
              },
              tileColor: AppTheme.listTileColor,
              title: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text('Edit All the Accounts',style: TextStyle(color: AppTheme.mainTextColor),)],
              ),
              subtitle: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text('Edit all the account balance and name \nif needed.',style: TextStyle(color: AppTheme.settingSubtitleColor))],
              ),
              leading: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      color: AppTheme.darkblue,
                      borderRadius: BorderRadius.circular(25)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(NavICons.editAllIcon),
                  )),
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, 'UpdateCurrency');
                ProfileDataProvider().dBToName();
              },
              tileColor: AppTheme.listTileColor,
              title: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text('Change the Currency',style: TextStyle(color: AppTheme.mainTextColor),)],
              ),
              subtitle: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text('change the base currency to your wish.',style: TextStyle(color: AppTheme.settingSubtitleColor))],
              ),
              leading: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      color: AppTheme.darkblue,
                      borderRadius: BorderRadius.circular(25)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(ImgIcons.iconcash),
                  )),
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, 'ProfileUpdate');
                ProfileDataProvider().dBToName();
              },
              tileColor: AppTheme.listTileColor,
              title: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text('Delete all data',style: TextStyle(color: AppTheme.mainTextColor),)],
              ),
              subtitle: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      '''Delete all the app data,this will lose \nall your data from
the beginning of the app''',style: TextStyle(color: AppTheme.settingSubtitleColor),)
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
                    child: Image.asset(NavICons.deleteIcon),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
