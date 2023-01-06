import 'package:clone/Features/Home/Services/home_Services.dart';
import 'package:clone/Features/Product_Details/Screens/product_details_screen.dart';
import 'package:clone/Models/product.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class DealOfTheDay extends StatefulWidget {
  const DealOfTheDay({Key? key}) : super(key: key);

  @override
  State<DealOfTheDay> createState() => _DealOfTheDayState();
}

class _DealOfTheDayState extends State<DealOfTheDay> {
  HomeServices homeServices = HomeServices();
  Product? product;

  fetchDealOfTheDay() async {
    product = await homeServices.fetchDealOfDay(context: context);
    setState(() {});
  }

  void navigateToProductDetailedScreen() {
    Navigator.pushNamed(context, ProductDetailsScreen.name, arguments: product);
  }

  @override
  void initState() {
    fetchDealOfTheDay();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return product == null
        ? Center(
            child: CircularProgressIndicator(),
          )
        : product!.name.isEmpty
            ? SizedBox()
            : InkWell(
                onTap: navigateToProductDetailedScreen,
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        top: 5.w,
                      ),
                      padding: EdgeInsets.only(left: 1.w, bottom: 1.w),
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Deal Of The Day:",
                        style: TextStyle(fontSize: 15.sp),
                      ),
                    ),
                    Image.network(
                      product!.images[0],
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                    Container(
                        padding: EdgeInsets.only(left: 1.w),
                        alignment: Alignment.topLeft,
                        child: Text(
                          "\$${product!.price}",
                          style: TextStyle(
                            fontSize: 11.sp,
                          ),
                        )),
                    Container(
                        padding: EdgeInsets.only(left: 1.w),
                        alignment: Alignment.topLeft,
                        child: Text(
                          product!.name,
                          style: TextStyle(
                            fontSize: 14.sp,
                          ),
                        )),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: product!.images.map((e) {
                            return Image.network(
                              e,
                              fit: BoxFit.cover,
                              width: 25.w,
                              height: 25.w,
                            );
                          }).toList()),
                    ),
                    Container(
                        padding: EdgeInsets.only(left: 1.w, top: 5.w),
                        alignment: Alignment.center,
                        child: InkWell(
                            onTap: () {},
                            child: Text(
                              "See all deals",
                              style: TextStyle(
                                  fontSize: 13.sp, color: Colors.cyan[800]),
                            ))),
                    Container(
                      height: 5.w,
                    )
                  ],
                ),
              );
  }
}
