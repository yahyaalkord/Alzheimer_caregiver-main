

import 'package:flutter/material.dart';

class CustomRowWidget extends StatelessWidget {
  final String title;
  final IconData icon;
  final double fontSize;
  final double iconSize;
  const CustomRowWidget({
    required this.title,
    required this.icon,
    required this.fontSize,
    required this.iconSize,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: iconSize,
          color: Colors.white,
        ),
        const SizedBox(width: 20,),
        Text(
          title,
          style: TextStyle(
              fontSize: fontSize,
              color: Colors.white),
        ),
      ],
    );
  }
}
