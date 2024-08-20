import 'package:financify/theme/themes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CircleWidgetWithIcon extends StatelessWidget {
  const CircleWidgetWithIcon({
    super.key,
    required this.insideIcon,
  });

  final Widget insideIcon;

  @override
  Widget build(BuildContext context) {
    final appTheme = Provider.of<AppTheme>(context, listen: true);
    return Container(
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
        borderRadius: BorderRadius.circular(
          100,
        ),
      ),
      child: insideIcon,
    );
  }
}
