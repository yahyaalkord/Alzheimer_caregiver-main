

import 'package:flutter/material.dart';

class BuildDrawerItem extends StatelessWidget {
  String text;
  IconData icon;
  Color textIconColor;
  Color titleColor;
  VoidCallback onTap;

  BuildDrawerItem(
      {
        required this.text,
        required this.onTap,
        required this.icon,
        required this.textIconColor,
        required this.titleColor
      }
      );

  @override
  Widget build(BuildContext context) {
    return ListTile(
       leading: Icon(icon,color: textIconColor,
       size: 29,),
      title: Text(
        text,
        style: TextStyle(
          color: textIconColor,
          fontSize: 19
        ),
      ),
      tileColor: titleColor,
      onTap: onTap,
    );
  }
}


