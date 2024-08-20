import 'package:financify/theme/themes.dart';
import 'package:flutter/material.dart';

class DarkBlueContainer extends StatelessWidget {
  const DarkBlueContainer({
    super.key,
    required this.appTheme,
    required this.child,
  });

  final AppTheme appTheme;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: appTheme.darkblue,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(padding: const EdgeInsets.all(15), child: child),
    );
  }
}