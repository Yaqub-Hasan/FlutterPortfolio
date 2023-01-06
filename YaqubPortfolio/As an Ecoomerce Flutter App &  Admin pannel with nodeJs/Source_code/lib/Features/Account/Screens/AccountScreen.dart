import 'package:clone/Constants/colors.dart';
import 'package:clone/Features/Account/Widgets/BelowAppBar.dart';
import 'package:clone/Features/Account/Widgets/ButtonsPart.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../Widgets/OrderPart.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(7.h),
        child: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: GlobalColors.appBarGradient
            ),
          ),
          title:Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.topLeft,
                child: Image.asset("assets/amazon_in.png" , width:  30.w , height: 10.h, color: Colors.black,),
              ),
              Container(
                alignment: Alignment.topLeft,
                child: Row(
                  children: [
                    Icon(Icons.notifications_outlined),
                    SizedBox(width: 5.w,),
                    Icon(Icons.search),
                  ],
                )
              )
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          BelowAppBar(),
          SizedBox(height: 2.h,),
          ButtonsPart(),
          SizedBox(height: 2.h,),
          OrderPart()
        ],
      ),
    );
  }
}
