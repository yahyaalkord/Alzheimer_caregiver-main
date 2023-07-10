import 'package:flutter/material.dart';

class CustomTextFormFieldAuthWidget extends StatelessWidget {
  final String labelText;
  final String hintText;
  final TextInputType textInputType;
  final TextEditingController myEditingController;
  final String? Function(String?)? validator;

  const CustomTextFormFieldAuthWidget({
    required this.hintText,
    required this.labelText,
    required this.textInputType,
    required this.validator,
    required this.myEditingController,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: textInputType,
      validator: validator,
      controller: myEditingController,
      decoration: InputDecoration(
          labelStyle: TextStyle(color: Color(0xff08B5B6)),
          //focusColor: Colors.purple.shade500,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
          hintText: hintText,
          labelText: labelText,
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xff08B5B6)),
          )
          // errorText: _wrongEmail ? emailText : null,
          ),
    );
  }
}
