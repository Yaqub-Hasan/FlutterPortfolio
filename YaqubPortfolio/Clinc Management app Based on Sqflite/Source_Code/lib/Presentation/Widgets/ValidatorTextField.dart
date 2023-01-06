import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class TextFieldWidget extends StatefulWidget {
  TextFieldWidget(
      {required this.styleColor,
      required this.borderColor,
      required this.hintText,
      this.labelText,
      this.icon,
      required this.controller,
      required this.onChange,
      this.width, this.textInputType});

  final Color styleColor;
  final Color borderColor;
  final String hintText;
  final String? labelText;
  final IconData? icon;
  final TextEditingController controller;
  final Function onChange;
  final double? width;
  final TextInputType? textInputType;

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 10.0, bottom: 10.0),
          child: SizedBox(
            width: widget.width ?? 90.w,
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: TextFormField(
                onChanged: (value) {
                  widget.onChange();
                },
                controller: widget.controller,
                keyboardType: widget.textInputType != null ? widget.textInputType : TextInputType.text,
                style: TextStyle(
                    color: widget.styleColor, fontWeight: FontWeight.bold),
                decoration: InputDecoration(
                  suffixIcon: widget.icon == null
                      ? null : Icon(widget.icon),
                  hintText: widget.hintText,
                  labelText: widget.labelText,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: widget.styleColor, width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: widget.borderColor, width: 2),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: widget.styleColor, width: 2),
                  ),
                ),
                validator: (value) => value != null && value.isEmpty
                    ? ' هذا الحقل إلزامي  من أجل المعلومات عن المريض'
                    : null,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
