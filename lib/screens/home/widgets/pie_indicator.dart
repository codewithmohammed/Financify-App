import 'package:flutter/material.dart';

class PieIndication extends StatelessWidget {
  final Color color;
  final String text;
  const PieIndication({
    super.key,
    required this.color,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.pie_chart,
          color: color,
          size: 12,
        ),
        Text(text,
            style: TextStyle(
              color: color,
            )),
      ],
    );
  }
}
