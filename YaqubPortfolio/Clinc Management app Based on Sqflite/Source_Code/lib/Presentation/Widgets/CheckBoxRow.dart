import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CheckBoxRow extends StatefulWidget {
  final String textState;
  final Function onChange;
  final bool initialValue;

  const CheckBoxRow({super.key, required this.textState, required this.onChange, required this.initialValue});


  @override
  State<CheckBoxRow> createState() => _CheckBoxRowState();
}

class _CheckBoxRowState extends State<CheckBoxRow> {
  late bool checkBoxState = widget.initialValue;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Directionality(textDirection: TextDirection.rtl, child: Text(
          widget.textState , style: TextStyle(color: checkBoxState == true ? Colors.red : Colors.black , fontSize: 15.sp , ),
        )),
        Checkbox(value: checkBoxState, onChanged: (value){
         setState(() {
           checkBoxState = value!;
           widget.onChange(checkBoxState);
         });
        }),
      ],
    );
  }
}
