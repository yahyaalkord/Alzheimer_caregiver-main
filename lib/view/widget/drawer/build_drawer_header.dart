import 'package:flutter/material.dart';

class BuildDrawerHeader extends StatelessWidget {
  final String accountName;
  //String accountEmail;
  final String name;

  const BuildDrawerHeader(
      {required this.accountName,
      //required this.accountEmail,
      required this.name});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 170,
      color: Color(0xff08B5B6),
      margin: const EdgeInsets.only(bottom: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: Colors.white,
            radius: 40,
            child: Text(
              name,
              style: TextStyle(
                  fontSize: 32,
                  color: Color(0xff08B5B6),
                  fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            accountName,
            style: const TextStyle(
                fontWeight: FontWeight.bold, fontSize: 21, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
