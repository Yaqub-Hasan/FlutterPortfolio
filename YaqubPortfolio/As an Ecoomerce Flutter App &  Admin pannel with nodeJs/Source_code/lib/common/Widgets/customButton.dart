import 'package:clone/Constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomButton extends StatefulWidget {
  CustomButton({required this.label, required this.onPressed, this.ButtonWidth, this.color, this.textColor , });
  final String label;
  final double? ButtonWidth;
  final Color? color;
  final Color? textColor;
  final Function() onPressed;


  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: widget.onPressed, child: Text(widget.label , style: TextStyle(color: widget.textColor ?? null),),
    style: ElevatedButton.styleFrom(
      backgroundColor: widget.color ??  GlobalColors.secondBackground,
      elevation: 12,
      shadowColor: Colors.black87,
      foregroundColor: Colors.white, minimumSize: Size(widget.ButtonWidth ?? 50.w, 5.h)
    ),

    );
  }
}
