import 'package:financify/utils/images.dart';
import 'package:financify/utils/themes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
        final appTheme = Provider.of<AppTheme>(context, listen: true);
    PageController controller = PageController();
    return Scaffold(
      backgroundColor: appTheme.backgroundColor,
      body: Stack(children: [
        PageView(
          controller: controller,
          children: [
            onboarding(
                BgImages.onboadingimg1,
                'Track your Spending',
                'Track and analyze spending immediately and\nautomatically through our App',
                context),
            onboarding(
                BgImages.onboadingimg2,
                'Set up your Goals',
                'Track and follow what matters to you. Save for \nImportant things',
                context),
            onboarding(
                BgImages.onboadingimg3,
                'Follow your plan and dreams',
                'Build your financial life. Make the right financial\ndecisions. See only what is important for you.',
                context),
          ],
        ),
        Container(
          alignment: const AlignmentDirectional(0, 0.7),
          child: SmoothPageIndicator(
              effect: JumpingDotEffect(
                  dotHeight: 10,
                  dotWidth: 10,
                  activeDotColor: appTheme.primaryColor,
                  dotColor: appTheme.mainTextColor),
              controller: controller,
              count: 3),
        ),
        Container(
          alignment: const AlignmentDirectional(0, 0.9),
          child: OutlinedButton(
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, 'Profileset', (route) => false);
            },
            style: OutlinedButton.styleFrom(
              foregroundColor: appTheme.primaryColor,
              side: BorderSide(color: appTheme.primaryColor),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            child: const Text('START NOW'),
          ),
        )
      ]),
    );
  }
}

Widget onboarding(
    String image, String title, String subtitle, BuildContext context) {
          final appTheme = Provider.of<AppTheme>(context, listen: true);
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
            style: TextStyle(color: Colors.white, fontSize: screenWidth * 0.04),
          )
        ],
      ));
}
