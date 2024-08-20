
import 'package:financify/theme/themes.dart';
import 'package:flutter/material.dart';

class AccountSection extends StatelessWidget {
  final String heading;
  final List<Widget> children;
  final AppTheme appTheme;

  const AccountSection({
    Key? key,
    required this.appTheme,
    required this.heading,
    required this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          heading,
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: appTheme.mainTextColor),
        ),
        ...children,
      ],
    );
  }
}
