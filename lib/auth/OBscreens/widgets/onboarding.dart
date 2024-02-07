import 'package:financify/utils/themes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Onboarding extends StatelessWidget {
  const Onboarding(
      {super.key,
      required this.image,
      required this.title,
      required this.subtitle});

  final String image;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final appTheme = Provider.of<AppTheme>(context, listen: false);
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Padding(
        padding: EdgeInsets.only(
            top: screenHeight * 0.1,
            left: screenWidth * 0.01,
            right: screenWidth * 0.01),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(screenWidth * 0.06),
              child: Image.asset(
                image,
              ),
            ),
            SizedBox(
              height: screenHeight * 0.19,
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: appTheme.mainTextColor,
                  fontSize: screenWidth * 0.05,
                  fontFamily: 'Test',
                  fontWeight: FontWeight.w900),
            ),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style:
                  TextStyle(color: Colors.white, fontSize: screenWidth * 0.04),
            )
          ],
        ));
  }
}