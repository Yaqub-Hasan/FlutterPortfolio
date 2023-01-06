import 'package:clone/Constants/colors.dart';
import 'package:clone/Logic(Cubit)/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class BelowAppBar extends StatelessWidget {
  const BelowAppBar({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    var user = BlocProvider.of<UserCubit>(context).state.user.name;
    return Container(
      decoration: BoxDecoration(
        gradient: GlobalColors.appBarGradient
      ),
     // padding: const EdgeInsets.only(left: 10 , ),
      child: Padding(
        padding: EdgeInsets.only(left: 2.w , bottom: 2.w),
        child: Row(
          children: [
            RichText(
              text: TextSpan(
                text: "Hello, ",
                style: TextStyle(fontSize: 18.sp , color: Colors.black ),
                children: [
                  TextSpan(
                  text: "$user",
                  style: TextStyle(fontSize: 18.sp , color: Colors.black , fontWeight: FontWeight.w500 ),)
                  ]
              ),

            )
          ],
        ),
      ),
    );
  }
}

