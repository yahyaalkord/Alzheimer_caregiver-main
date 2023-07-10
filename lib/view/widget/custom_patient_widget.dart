import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomPatientWidget extends StatelessWidget {
  late String userName;
  late String name;
  late String userId;
  final void Function()? onPressed;

  CustomPatientWidget(
      {required this.userName,
      required this.userId,
      required this.name,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      child: Container(
        height: 85,
        margin: const EdgeInsets.only(
          top: 16,
        ),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                  color: Colors.black38, blurRadius: 5, offset: Offset(1, 3)),
            ]),
        child: Row(
          children: [
            CircleAvatar(
              radius: 24,
              backgroundColor: Color(0xff096b6c),
              child: Text(
                name.toUpperCase(),
                style: const TextStyle(
                    // fontFamily: 'Raleway',
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: Colors.white),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userName,
                  style: const TextStyle(
                    fontSize: 20,
                    // fontWeight: FontWeight.bold,
                    // fontFamily: 'Raleway',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
