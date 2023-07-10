import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTaskWidget extends StatelessWidget {
  late String taskId;
  late String name;
  final IconData icon;
  final Color color1;
  final Color color2;
  final void Function()? onPressed;
  final void Function(bool)? onChange;
  final bool isActive;

  CustomTaskWidget({
    required this.taskId,
    // required this.userId,
    //required this.name,
    required this.onPressed,
    required this.color1,
    required this.color2,
    required this.onChange,
    required this.isActive,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      alignment: Alignment.center,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [color1, color2],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight),
          borderRadius: BorderRadius.circular(30),
          boxShadow: const [
            BoxShadow(
                color: Colors.black38, blurRadius: 2, offset: Offset(1, 3)),
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(
                Icons.task,
                size: 40,
                color: Colors.white,
              ),
              const SizedBox(
                width: 20,
              ),
              Text(
                "Task Id #$taskId",
                style: const TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(
            width: 70,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Switch(
                activeColor: Colors.white,
                value: isActive,
                onChanged: onChange,
              ),
              IconButton(
                  onPressed: onPressed,
                  icon: Icon(
                    icon,
                    color: Colors.white,
                    size: 31,
                  ))
            ],
          ),
        ],
      ),
    );
  }
}
