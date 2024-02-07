import 'package:financify/auth/OBscreens/widgets/onboarding.dart';
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
          children: const [
            Onboarding(
              image: BgImages.onboadingimg1,
              title: 'Track your Spending',
              subtitle:
                  'Track and analyze spending immediately and\nautomatically through our App',
            ),
            Onboarding(
              image: BgImages.onboadingimg2,
              title: 'Set up your Goals',
              subtitle:
                  'Track and follow what matters to you. Save for \nImportant things',
            ),
            Onboarding(
              image: BgImages.onboadingimg3,
              title: 'Follow your plan and dreams',
              subtitle:
                  'Build your financial life. Make the right financial\ndecisions. See only what is important for you.',
            ),
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

// Widget onboarding(
//     String image, String title, String subtitle, BuildContext context) {
//           final appTheme = Provider.of<AppTheme>(context, listen: true);
//   double screenHeight = MediaQuery.of(context).size.height;
//   double screenWidth = MediaQuery.of(context).size.width;

//       );
// }
