import 'package:flutter/material.dart';

class ValidatorTextFieldEma extends StatefulWidget {
  ValidatorTextFieldEma(
      {required this.styleColor,
        required this.borderColor,
        required this.hintText,
         this.labelText,
        required this.cntrol,
        required this.IconImage, required this.onChangedFunc
      });

  final Color styleColor;
  final Color borderColor;
  final String hintText;
  final String? labelText;
  final TextEditingController cntrol;
  final Widget IconImage;
  final Function onChangedFunc;

  @override
  State<ValidatorTextFieldEma> createState() => _ValidatorTextFieldEmaState();
}

class _ValidatorTextFieldEmaState extends State<ValidatorTextFieldEma> {
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
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(color: widget.styleColor , fontWeight: FontWeight.bold),
                validator:    (value){
                  if (value!.isEmpty || !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}').hasMatch(value)) {
                    return "Your Email is not available , Add a validate Email";
                  }
                },
                onChanged: (value){
                  widget.onChangedFunc();
                },
                decoration: InputDecoration(

                    suffixIcon: widget.IconImage,
                    hintText: widget.hintText,
                    labelText: widget.labelText,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: widget.styleColor ,  width: 2),
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

