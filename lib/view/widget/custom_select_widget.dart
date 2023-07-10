import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomSelectWidget extends StatelessWidget {
  final Color color;
  final String title;
  final IconData icon;
  final void Function()? onTap;

  const CustomSelectWidget({
      required this.color,
      required this.title,
      required this.icon,
      required this.onTap,
}) ;

  @override
  Widget build(BuildContext context) {
    return InkWell(

      onTap: onTap,
      child: Container(
        width: 100,
        height: 100,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),

        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: 60,
            ),
            const SizedBox(height: 15,),
            Text(title,
            style: const TextStyle(
              fontSize: 23,
              color: Colors.white
            ),),
          ],
        ),


      ),
    );
  }
}
