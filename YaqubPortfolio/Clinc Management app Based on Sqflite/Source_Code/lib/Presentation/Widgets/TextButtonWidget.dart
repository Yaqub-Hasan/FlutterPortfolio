import 'package:flutter/material.dart';

class TextButtonWidget extends StatefulWidget {
  final String buttonName;
  final Color buttonColor;
  final Function() onClick;

  TextButtonWidget({required this.buttonName, required this.buttonColor, required this.onClick});


  @override
  State<TextButtonWidget> createState() => _TextButtonWidgetState();
}

class _TextButtonWidgetState extends State<TextButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return TextButton(onPressed: widget.onClick,
      child: Text(widget.buttonName , style: TextStyle(color: Colors.white),),
      style: TextButton.styleFrom(
        primary: widget.buttonColor,
      ),
    );
  }
}
