import 'package:financify/utils/themes.dart';
import 'package:flutter/material.dart';

class CustomAppBarr extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBarr({
    super.key,
    required this.appTheme,
    this.leading,
    required this.title,
  });

  final AppTheme appTheme;
  final Widget? leading;
  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0,
      backgroundColor: appTheme.darkblue,
      leading: SizedBox(height: 200, child: leading
          ),
      title: Text(
        title,
        style: TextStyle(color: appTheme.primaryColor),
      ),
    );
  }

  @override
  Size get preferredSize => const Size(double.maxFinite, 60);
}
