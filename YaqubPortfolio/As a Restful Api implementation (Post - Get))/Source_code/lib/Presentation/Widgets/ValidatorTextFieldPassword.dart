import 'package:flutter/material.dart';

class ValidatorTextFieldPass extends StatefulWidget {
  ValidatorTextFieldPass(
      {required this.styleColor,
        required this.borderColor,
        required this.hintText,
         this.labelText,
        required this.cntrol, required this.IconImage, required this.onChangedFunc,
      });

  final Color styleColor;
  final Color borderColor;
  final String hintText;
  final String? labelText;
  final TextEditingController cntrol;
  final Widget IconImage;
  final Function onChangedFunc;

  @override
  State<ValidatorTextFieldPass> createState() => _ValidatorTextFieldPassState();
}

class _ValidatorTextFieldPassState extends State<ValidatorTextFieldPass> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 10.0 , bottom: 10.0),
          child: SizedBox(
            width: 300,
            child: TextFormField(
                controller: widget.cntrol,
                textAlign: TextAlign.start,
                keyboardType: TextInputType.visiblePassword,
                onChanged: (value){
                  widget.onChangedFunc();
                },
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                style: TextStyle(color: widget.styleColor , fontWeight: FontWeight.bold),
                validator:    (value){
                  if (value!.isEmpty || value.length < 6) {
                    return "Your password have to be 6 letters at least";
                  }
                },
                decoration: InputDecoration(
                    suffixIcon: widget.IconImage,
                    hintText: widget.hintText,
                    labelText: widget.labelText,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: widget.styleColor , width: 2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: widget.borderColor ,  width: 2),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: widget.borderColor ,  width: 2),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: widget.borderColor ,  width: 2),
                    ))),
          ),
        ),
        widget.cntrol.text.isNotEmpty ?  Icon(Icons.done , color: Colors.orange,size: 25,) : Container()
      ],
    );
  }
}



