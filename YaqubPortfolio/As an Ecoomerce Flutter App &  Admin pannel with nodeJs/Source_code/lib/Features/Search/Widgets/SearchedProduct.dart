import 'package:clone/Constants/Stars.dart';
import 'package:clone/Models/product.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SearchedProduct extends StatelessWidget {
  final Product product;
  SearchedProduct({Key? key, required this.product}) : super(key: key);

  double avgRating=0;

  void ratingCalcMethod() {
    double totalRating = 0;
    for(int i = 0 ; i< product.rating!.length; i++){
      totalRating+=product.rating![i].rating;
    }
    if(totalRating != 0 ){
      avgRating = totalRating/product.rating!.length;
    }
  }

  @override
  Widget build(BuildContext context) {
    ///Rating Method invoked inside build Function because of it is a stateless widget;
    ratingCalcMethod();
    return Container(
      margin: EdgeInsets.all(2.w),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  product.images[0],
                  fit: BoxFit.fitHeight,
                  width: 15.h,
                  height: 20.h,
                ),
              ),
              Container(
                padding: EdgeInsets.all(5.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w500),
                      maxLines: 2,
                    ),
                    SizedBox(
                      height: 2.w,
                    ),
                    Text(
                      product.description,
                      style: TextStyle(color: Colors.black, fontSize: 13.sp),
                      maxLines: 2,
                    ),
                    SizedBox(
                      height: 1.w,
                    ),
                    Stars(
                      rating: avgRating,
                    ),
                    SizedBox(
                      height: 1.w,
                    ),
                    Text(
                      "\$${product.price}",
                      style: TextStyle(color: Colors.black, fontSize: 13.sp),
                      maxLines: 2,
                    ),
                    SizedBox(
                      height: 1.w,
                    ),
                    Text(
                      "Eligible for free shipping",
                      style: TextStyle(color: Colors.black, fontSize: 11.sp),
                      maxLines: 2,
                    ),
                    SizedBox(
                      height: 1.w,
                    ),
                    Text(
                      "In Stock",
                      style: TextStyle(color: Colors.teal, fontSize: 11.sp),
                      maxLines: 2,
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
