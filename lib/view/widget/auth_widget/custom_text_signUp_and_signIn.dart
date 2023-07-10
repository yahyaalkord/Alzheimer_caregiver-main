import 'package:flutter/material.dart';

class CustomTextSignUpAndSignIn extends StatelessWidget {
  final String text1;
  final String text2;
  final void Function() onPressed;
  const CustomTextSignUpAndSignIn(
      {Key? key,
      required this.text1,
      required this.text2,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text1,
          style: const TextStyle(fontSize: 20),
        ),
        TextButton(
            onPressed: onPressed,
            child: Text(
              text2,
              style: TextStyle(
                  color: Color(0xff08B5B6),
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ))
      ],
    );
  }
}
