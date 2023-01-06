import 'package:flutter/material.dart';

class PasswordTextField extends StatelessWidget {
  PasswordTextField({required this.styleColor, required this.borderColor,
    required this.hintText, required this.labelText, required this.cntrol});
  final Color styleColor;
  final Color borderColor;
  final String hintText;
  final String labelText;
  final TextEditingController cntrol;

  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: cntrol,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.visiblePassword,
        obscureText: true,
        enableSuggestions: false,
        autocorrect: false,
        style: TextStyle(color: styleColor),
        decoration: InputDecoration(
          hintText: hintText,
          labelText: labelText,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(color: styleColor),
          ),
          focusedBorder:OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(color: borderColor),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(color: borderColor),
          ),)
    );
  }
}
