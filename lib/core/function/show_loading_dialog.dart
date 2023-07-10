import 'package:flutter/material.dart';

showUpload({required BuildContext context}) {
  showDialog(context: context,
      builder: (context) {
        return AlertDialog(
          content: Container(
            height: 90,
            child: const Center(
              child: CircularProgressIndicator(

              ),
            ),

          ),
          title: const Text("Please Await",
            textAlign: TextAlign.center,),

        );
      });
}