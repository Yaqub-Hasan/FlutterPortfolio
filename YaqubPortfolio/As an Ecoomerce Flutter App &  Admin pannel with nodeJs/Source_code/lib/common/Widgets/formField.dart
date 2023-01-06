import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class customFormField extends StatefulWidget {

  customFormField({required this.controller, required this.hintText, required this.textInputType, this.obscureText, this.maxLines = 1 });
  final TextEditingController controller;
  final String hintText;
  final TextInputType textInputType;
  final  bool? obscureText;
  final int maxLines;

  @override
  State<customFormField> createState() => _customFormFieldState();
}

class _customFormFieldState extends State<customFormField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(1.h),
      child: TextFormField(
        keyboardType: widget.textInputType,
        obscureText: widget.obscureText ?? false,
        controller: widget.controller,
        maxLines: widget.maxLines,
        decoration: InputDecoration(
          hintText: widget.hintText,
          border: OutlineInputBorder(
           borderSide: BorderSide(color: Colors.black87),
           borderRadius: BorderRadius.circular(15)
          ),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black87),
              borderRadius: BorderRadius.circular(5)
          ),
          errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red , width: 2),
              borderRadius: BorderRadius.circular(15)
          ),
        ),
        validator: (val){
           if(val == null || val.isEmpty){
              return 'Enter your ${widget.hintText}';
           }
        },
      ),
    );
  }
}
