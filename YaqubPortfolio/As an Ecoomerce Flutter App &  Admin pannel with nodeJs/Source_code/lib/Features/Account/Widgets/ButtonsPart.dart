import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'AccountButtons.dart';

class ButtonsPart extends StatefulWidget {
  const ButtonsPart({Key? key}) : super(key: key);

  @override
  State<ButtonsPart> createState() => _ButtonsPartState();
}

class _ButtonsPartState extends State<ButtonsPart> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            AccountButtons(buttonName: 'Your Orders ', onTap: (){}),
            AccountButtons(buttonName: 'Turn Seller ', onTap: (){}),
          ],
        ),
        SizedBox(height: 2.h,),
        Row(
          children: [
            AccountButtons(buttonName: 'Log Out ', onTap: (){}),
            AccountButtons(buttonName: 'Your Wish List ', onTap: (){}),
          ],
        )
      ],
    );
  }
}
