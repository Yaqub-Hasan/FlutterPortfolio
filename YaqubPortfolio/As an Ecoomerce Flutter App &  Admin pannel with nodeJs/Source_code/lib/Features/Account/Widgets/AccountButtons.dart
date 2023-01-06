import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class AccountButtons extends StatelessWidget {
  const AccountButtons({Key? key, required this.buttonName, required this.onTap}) : super(key: key);

  final String buttonName;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
          margin: EdgeInsets.symmetric(horizontal: 1.w),
          width: 40.w,
          height: 5.h,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white , width: 0),
            borderRadius: BorderRadius.circular(40),
            color: Colors.black12.withOpacity(0.03),
          ),
          child: OutlinedButton(
            child: Text(buttonName , style: TextStyle(color: Colors.black , fontWeight: FontWeight.w500),),
            onPressed: onTap,
            style: OutlinedButton.styleFrom(
              backgroundColor: Colors.black12.withOpacity(0.03),
              minimumSize: Size(40.w, 5.h),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40))
            ),
          )
        ),
    );
  }
}
