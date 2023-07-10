import 'package:flutter/material.dart';

class CustomTaskWidgetDetails extends StatelessWidget {
  final String taskId;
  final String taskTitle;
  final String taskDes;
  final String taskHour;
  final IconData icon;
  final Color color1;
  final Color color2;
  final void Function()? onPressed;
  final void Function(bool)? onChange;
  final bool isActive;

  const CustomTaskWidgetDetails(
      {required this.taskId,
      required this.taskDes,
      required this.taskHour,
      required this.onPressed,
      required this.color1,
      required this.color2,
      required this.onChange,
      required this.isActive,
      required this.icon,
      required this.taskTitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 230,
      alignment: Alignment.center,
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
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
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.task,
                      size: 30,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      "Task Id #$taskId",
                      style: const TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.title,
                      size: 30,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      "title #$taskTitle",
                      style: const TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Wrap(
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.description,
                          size: 30,
                          color: Colors.white,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          "Description # $taskDes",
                          style: const TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.lock_clock_outlined,
                      size: 30,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      "hour #$taskHour",
                      style: const TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ),
          //const SizedBox(width: 40,),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
// Row(
// children: [
// const Icon(
// Icons.task,
// size: 40,
// color: Colors.white,
// ),
// const SizedBox(width: 20,),
// Column(
// mainAxisAlignment: MainAxisAlignment.center,
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// Text(
// "Task Id #$taskId",
// style: const TextStyle(fontSize: 22,
// color: Colors.white,
// fontWeight: FontWeight.bold),
// ),
//
//
// ],
// ),
// const SizedBox(width: 45,),
// Column(
// mainAxisSize: MainAxisSize.min,
// children: [
// Switch(
// activeColor: Colors.white,
// value:isActive , onChanged: onChange,
// ),
// IconButton(onPressed: onPressed, icon: Icon(
// icon,
// color: Colors.white,
// size: 31,
// ))
// ],
// ),
//
// ],
// ),
