import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ButtonWidget extends StatefulWidget {
  final String buttonName;
  final Color buttonColor;
  final Function() onClick;
  Size? size;
  ButtonWidget({required this.buttonName, required this.buttonColor, required this.onClick , this.size});


  @override
  State<ButtonWidget> createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: widget.onClick,
        child: Text(widget.buttonName , style: TextStyle(color: Colors.white , fontSize: 15.sp),),
        style: ElevatedButton.styleFrom(
        primary: widget.buttonColor,
        onPrimary: Colors.white,
        elevation: 13,
        shadowColor: Colors.black,
        minimumSize: widget.size != null ? widget.size : null
    ),
    );

  }
}
