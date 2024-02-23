
import 'package:financify/utils/themes.dart';
import 'package:flutter/material.dart';

class Switchrow extends StatefulWidget {
  const Switchrow({
    super.key,
    required this.appTheme,
  });

  final AppTheme appTheme;

  @override
  State<Switchrow> createState() => _SwitchrowState();
}

class _SwitchrowState extends State<Switchrow> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.dark_mode,
          color: widget.appTheme.mainTextColor,
          size: 20,
        ),
        Text(
          'Dark Mode',
          style: TextStyle(color: widget.appTheme.mainTextColor, fontSize: 12),
        ),
        Padding(
            padding: const EdgeInsets.only(right: 8, left: 8),
            child: SizedBox(
              width: 40,
              child: Transform.scale(
                scale: 0.7,
                child: Switch(
                    value: widget.appTheme.appthemeDarkMode,
                    onChanged: (value) {
                      if (value == false) {
                        widget.appTheme.changeToLight();
                      } else {
                        widget.appTheme.changeToDark();
                      }
                      setState(() {});
                    }),
              ),
            ))
      ],
    );
  }
}