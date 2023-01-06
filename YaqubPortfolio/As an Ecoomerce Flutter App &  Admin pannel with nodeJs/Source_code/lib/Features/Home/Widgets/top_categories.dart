import 'package:clone/Constants/colors.dart';
import 'package:clone/Features/Home/Screens/category_deals_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class Top_categories extends StatelessWidget {
  const Top_categories({Key? key}) : super(key: key);

  void navigateToCategoryScreens(BuildContext context , String category){
    Navigator.pushNamed(context, CategoryDealsScreen.name , arguments: category);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 10.h,
      child: ListView.separated(
      scrollDirection: Axis.horizontal,
      itemBuilder: (context , index){
        return GestureDetector(
          onTap: ()=> navigateToCategoryScreens(context , GlobalColors.categoryImages[index]['title']!),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 2.w),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.asset(GlobalColors.categoryImages[index]['image']! , height: 7.h, fit: BoxFit.cover,),
                ),
              ),
              SizedBox(height: 1.w,),
              Text(GlobalColors.categoryImages[index]['title']! , style: TextStyle(fontSize: 9.sp),)
            ],
          ),
        );
      }, separatorBuilder: (context , index){
        return SizedBox(width: 2.w,);
      }, itemCount: GlobalColors.categoryImages.length),
    );
  }
}
