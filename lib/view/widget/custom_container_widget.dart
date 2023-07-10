import 'package:flutter/material.dart';

class CustomContainerWidget extends StatelessWidget {
  final Widget widget;
  const CustomContainerWidget({required this.widget});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 260,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(70),
              bottomLeft: Radius.circular(70)),
          gradient: LinearGradient(
            colors: [
              // Colors.purple.shade100,
              // Colors.purple.shade200,
              // Colors.purple.shade300,
              // Colors.purple.shade400,
              // Colors.purple.shade500,
              // Colors.purple.shade600,
              Color(0xff8becec),

              Color(0xff5ab9b9),
              Color(0xff388c8c),

              Color(0xff207979),

              Color(0xff096b6c),
            ],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          )),
      child: widget,
    );
  }
}
