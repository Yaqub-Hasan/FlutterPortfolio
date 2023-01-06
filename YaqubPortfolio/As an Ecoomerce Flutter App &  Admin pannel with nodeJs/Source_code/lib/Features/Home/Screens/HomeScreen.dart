import 'dart:convert';

import 'package:clone/Features/Home/Widgets/deal_of_day.dart';
import 'package:clone/Features/Home/Widgets/top_categories.dart';
import 'package:clone/Features/Search/Screens/searchScreen.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../Constants/colors.dart';
import '../Widgets/Adress_Box.dart';
import '../Widgets/carausel_images.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const String name = "HomeScreen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  void navigateToSearchScreen(String searchQuery){
    Navigator.pushNamed(context, SearchScreen.name , arguments: searchQuery);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(8.h),
        child: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: GlobalColors.appBarGradient
            ),
          ),
          title:Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                   height: 5.h ,
                   margin: EdgeInsets.only(left: 1.w),
                   child: Material(
                     borderRadius: BorderRadius.circular(7),
                     elevation: 5,
                     child: TextFormField(
                       onFieldSubmitted: navigateToSearchScreen,
                       cursorColor: Colors.black26,
                       decoration: InputDecoration(
                         filled: true,
                         fillColor: Colors.white,
                         contentPadding: EdgeInsets.all(2.w),
                         //labelStyle:  TextStyle(color: Colors.orange),
                         border: OutlineInputBorder(
                           borderRadius: BorderRadius.all(Radius.circular(7)),
                           borderSide: BorderSide.none
                         ),
                         enabledBorder: OutlineInputBorder(
                             borderRadius: BorderRadius.all(Radius.circular(7)),
                             borderSide: BorderSide(color: Colors.black38 , width: 1)
                         ),
                         hintText: 'Search Amazon.in',
                         hintStyle: TextStyle(
                           fontSize: 12.sp,
                           fontWeight: FontWeight.w500
                         ),
                         prefixIcon: InkWell(
                           onTap: (){

                           },
                         child: Padding(
                           padding: EdgeInsets.only(left: 1.w),
                           child: Icon(Icons.search , color: Colors.black38,),
                         ),
                         )
                       ),
                     ),
                   ),
                ),
              ),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 2.w),
                  alignment: Alignment.topLeft,
                  child: InkWell(
                    onTap: (){},
                    child: Icon(Icons.mic),
                  )
              )
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            AddressBox(),
            SizedBox(height: 2.w,),
            Top_categories(),
            SizedBox(height: 2.w,),
            CarouselImages(),
            SizedBox(height: 2.w,),
            DealOfTheDay()
           ],
        ),
      )
    );
  }
}
