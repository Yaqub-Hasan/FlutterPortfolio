import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oswah_test/Presentation/Widgets/ValidatorTextField.dart';
import 'package:oswah_test/Presentation/Widgets/ValidatorTextFieldPassword.dart';

enum TextFieldStatus { empty, writing, full }

class LogInFields extends StatefulWidget {
  const LogInFields(
      {Key? key,
      required this.Emailcontroller,
      required this.Passwordcontroller})
      : super(key: key);
  final TextEditingController Emailcontroller;
  final TextEditingController Passwordcontroller;

  @override
  State<LogInFields> createState() => _LogInFieldsState();
}

class _LogInFieldsState extends State<LogInFields> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
            Row(
              children: [
                ValidatorTextFieldEma(
                  styleColor: Colors.black,
                  borderColor: Colors.black,
                  hintText: "Email",
                  cntrol: widget.Emailcontroller,
                  IconImage: widget.Emailcontroller.text.isEmpty
                      ? Image(image: AssetImage("assets/email.png"))
                      : Image(image: AssetImage("assets/email-2.png")),
                  onChangedFunc: () {
                    setState(() {});
                  },
                ),
              ],
            ),

        SizedBox(height: 10),
        Row(
          children: [
            ValidatorTextFieldPass(
                styleColor: Colors.black,
                borderColor: Colors.black,
                hintText: "Password",
                cntrol: widget.Passwordcontroller,
                IconImage: widget.Passwordcontroller.text.isEmpty
                    ? Image(image: AssetImage("assets/key.png"))
                    : Image(image: AssetImage("assets/key-2.png")),
                onChangedFunc: () {
                  setState(() {});
                }),
          ],
        ),
      ],
    );
  }
}
