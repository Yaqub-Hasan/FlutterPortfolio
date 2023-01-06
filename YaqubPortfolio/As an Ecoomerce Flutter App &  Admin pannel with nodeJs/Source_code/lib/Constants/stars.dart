import 'package:clone/Constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:sizer/sizer.dart';

class Stars extends StatelessWidget {
  const Stars({Key? key, required this.rating}) : super(key: key);
  final double rating;

  @override
  Widget build(BuildContext context) {
    return RatingBarIndicator(
      itemCount: 5,
      itemSize: 12.sp,
      direction: Axis.horizontal,
      rating: rating,
      itemBuilder: (context , index){
      return Icon(Icons.star , color: GlobalColors.secondBackground,);
    });
  }
}
