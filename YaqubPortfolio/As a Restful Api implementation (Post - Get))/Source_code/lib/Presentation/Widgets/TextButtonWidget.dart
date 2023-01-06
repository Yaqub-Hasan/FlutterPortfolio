import 'package:flutter/material.dart';

class TextButtonWidget extends StatelessWidget {
  const TextButtonWidget({ required this.ButtonName, required this.onPressed});

  final String ButtonName;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(child: Text(ButtonName , style: TextStyle(decoration: TextDecoration.underline , color: Colors.orange , fontSize: 18 , fontWeight: FontWeight.bold),),
      onTap: (){
        onPressed();
      },
    );
  }
}
