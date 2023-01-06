import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SingleProduct extends StatelessWidget {
  const SingleProduct({Key? key, required this.image}) : super(key: key);
  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 60.w,
        decoration: BoxDecoration(
        border: Border.all(width: 1.5 , color: Colors.grey),
    borderRadius: BorderRadius.circular(15),
    ),
    child: ClipRRect(
        borderRadius: BorderRadius.circular(13),
        child: Image.network( image , fit: BoxFit.contain,)),);
  }
}
