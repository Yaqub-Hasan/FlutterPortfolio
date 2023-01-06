import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SimpleDropDownWidget extends StatefulWidget {
  const SimpleDropDownWidget({Key? key, required this.onChanged, this.initialValue}) : super(key: key);
  final Function onChanged;
  final String? initialValue;

  @override
  State<SimpleDropDownWidget> createState() => _SimpleDropDownWidgetState();
}

class _SimpleDropDownWidgetState extends State<SimpleDropDownWidget> {

  late String? value = widget.initialValue;
  List<String> intensity = [
    "خفيف",
    "متوسط",
    "قوي"
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90.w,
      padding: EdgeInsets.all(2.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(width: 2)
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
            isExpanded: true,
            hint: Text("شدة الألم" , style: TextStyle(color: Colors.grey , fontSize: 18 , fontWeight: FontWeight.bold),),
            value: value,
            icon: Icon(Icons.arrow_drop_down , size: 25.sp,),
            items: intensity.map((String item) {
              return DropdownMenuItem(
                value: item,
                child: Column(
                  children: [
                    Divider(color: value != null ? Colors.transparent
                        : Colors.black,
                      height: 15,),
                    Text(item , style: TextStyle(fontWeight: FontWeight.bold),),
                  ],
                ),
              );
            }).toList(),
            onChanged: (value) {
              setState(
                    () {
                   this.value = value.toString();
                   widget.onChanged(value);
                },
              );
            }
        ),
      ),
    );
  }
}
