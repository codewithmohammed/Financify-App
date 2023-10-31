import 'package:financify/db/profile_db.dart';
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
        child: ListTile(
          onTap: () {
            Navigator.pushNamed(context, 'ProfileUpdate');
            ProfileDataProvider().dBToName();
          },
          tileColor: AppTheme.listTileColor,
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text('Change Your Profile')],
          ),
          subtitle: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text('Change your Profile Pic and Name')],
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
      ),
    );
  }
}
