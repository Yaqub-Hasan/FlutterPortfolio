import 'package:flutter/material.dart';
import 'package:oswah_test/Presentation/Screens/ChatScreen.dart';

class MessageTextFieldRow extends StatefulWidget {
  MessageTextFieldRow({required this.styleColor, required this.borderColor,
    required this.hintText, required this.cntrol, required this.onChange, required this.InkWellTap, required this.chatID, required this.accountId,});
  final Color styleColor;
  final Color borderColor;
  final String hintText;
  final TextEditingController cntrol;
  final Function onChange;
  final Function InkWellTap;
  final String chatID;
  final int accountId;

  @override
  State<MessageTextFieldRow> createState() => _MessageTextFieldRowState();
}

class _MessageTextFieldRowState extends State<MessageTextFieldRow> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10 , bottom: 5),
      decoration: BoxDecoration(
        color: Colors.white , 
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.black12)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
           SizedBox(
              height: 40 ,
              width:  300,
              child: TextField(
                onChanged: (value){
                  widget.onChange();
                },
                // expands: true,
                // maxLines: null,
                scrollPhysics: ScrollPhysics().parent,
                controller: widget.cntrol,
                keyboardType: TextInputType.multiline,
                textAlign: TextAlign.start,
                style: TextStyle(color: widget.styleColor , fontSize: 15),
                decoration: InputDecoration(
                  hintText: widget.hintText,
                  border: InputBorder.none,
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0 , right: 15),
            child: InkWell(
              onTap: (){
                 setState((){
                   widget.InkWellTap();
                   Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>ChatScreen( recieveId: widget.chatID,contactId: widget.accountId,)));
                 });

              },
              child: widget.cntrol.text.isEmpty ? Image(image: AssetImage("assets/Path 5154.png"),)   : Image(image: AssetImage("assets/Path -1.png"),),
            ),
          ) ,
        ],
      ),
    );
  }
}

