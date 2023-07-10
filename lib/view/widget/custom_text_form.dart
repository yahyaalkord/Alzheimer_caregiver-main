

import 'package:flutter/material.dart';

class CustomTextForm extends StatelessWidget {
  final String label;
  final String? Function(String?)? valid;
  final TextEditingController? controller;
  final String? initialValue;
  final void Function(String)? onChanged;
  const CustomTextForm({
    required this.label,
    required this.valid,
    this.controller,
    this.initialValue,
    this.onChanged


}) ;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: TextFormField(
        style: TextStyle(
          color: Colors.yellow.shade200
        ),
        cursorColor: Colors.yellow.shade200,
        validator:valid,
        controller: controller,
        initialValue:initialValue ,
        onChanged:onChanged,
        decoration:  InputDecoration(
            label: Text(
              label,
              style: const TextStyle(color: Colors.white),
            ),
            focusedBorder:  UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.yellow.shade200)
            ),
            enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white))),
      ),
    );
  }
}
