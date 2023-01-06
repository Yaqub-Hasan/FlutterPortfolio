import 'package:carousel_slider/carousel_slider.dart';
import 'package:clone/Constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CarouselImages extends StatelessWidget {
  const CarouselImages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(items: GlobalColors.carouselImages.map((e) {
      return Builder(
          builder: (BuildContext context) => Image.network(e, fit: BoxFit.fill,),
      );
    }).toList(),
        options: CarouselOptions(viewportFraction: 1 , height: 25.h));
  }
}
