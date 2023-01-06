import 'package:flutter/material.dart';

class NormalTextField extends StatefulWidget {
  NormalTextField({required this.styleColor, required this.borderColor,
    required this.hintText, this.labelText, required this.cntrol, this.IconImage, required this.onChange, this.width});
  final Color styleColor;
  final Color borderColor;
  final String hintText;
  final String? labelText;
  final String? IconImage;
  final TextEditingController cntrol;
  final Function onChange;
  final double? width;

  @override
  State<NormalTextField> createState() => _NormalTextFieldState();
}

class _NormalTextFieldState extends State<NormalTextField> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only( right: 10.0 , bottom: 10.0) ,
          child: SizedBox(
            width: widget.width ?? 300,
            child: TextField(
              onChanged: (value){
                  widget.onChange();
              },
              controller: widget.cntrol,
              keyboardType: TextInputType.emailAddress,
              textAlign: TextAlign.start,
              style: TextStyle(color: widget.styleColor , fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                suffixIcon: widget.IconImage == null ? null : Image(image: AssetImage(widget.IconImage.toString()),),
                hintText: widget.hintText,
                labelText: widget.labelText,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: widget.styleColor , width: 2),
                ),
                focusedBorder:OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: widget.borderColor , width: 2),
                ),
              ),
            ),
          ),
        ),
        widget.cntrol.text.isNotEmpty ?  Icon(Icons.done , color: Colors.orange,size: 25,) : Container()
      ],
    );
  }
}

