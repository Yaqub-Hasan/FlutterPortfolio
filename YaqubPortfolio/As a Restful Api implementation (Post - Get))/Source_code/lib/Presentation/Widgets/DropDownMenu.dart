import 'package:flutter/material.dart';

class DropDownWidget extends StatefulWidget {
  DropDownWidget(
      {required this.OnSelectedItem});

  final Function OnSelectedItem;

  @override
  State<DropDownWidget> createState() => _DropDownWidgetState();
}

class _DropDownWidgetState extends State<DropDownWidget> {

  List<String> Gender = [
    "Male" ,
    "Female"
  ];
  String? value;

  returnDropDownID(){
    if(value.toString() == Gender[0]){
      return 0;
    }
    else if(value.toString() == Gender[1]){
      return 1;
    }
    else{
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
   return Row(
     mainAxisAlignment: MainAxisAlignment.center,
     children: [
       Container(
         width: 300,
         decoration: BoxDecoration(
             border: Border.all(color: Colors.black, width: 2),
             borderRadius: BorderRadius.circular(15)),
         margin: EdgeInsets.only( right: 10),
         padding: EdgeInsets.symmetric(horizontal: 30),
         child: DropdownButtonHideUnderline(
           child: DropdownButton(
                    isExpanded: true,
                    hint: Text("Gender" , style: TextStyle(color: Colors.grey , fontSize: 18 , fontWeight: FontWeight.bold),),
                    value: value,
                    icon: Image(image: AssetImage("assets/arrow-down-b.png"),),
                    items: Gender.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Column(
                          children: [
                            Divider(color: value != null ? Colors.transparent
                                : Colors.black,
                              height: 15,),
                            Text(items , style: TextStyle(fontWeight: FontWeight.bold),),
                          ],
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(
                        () {
                          this.value = value.toString();
                          int GenderId = returnDropDownID();
                          widget.OnSelectedItem(GenderId);
                        },
                      );
                    }
            ),
         ),
       ),
       value != null ?   Icon(Icons.done , color: Colors.orange,size: 25,) : Container()
     ],
   );
  }
}
