import 'package:carousel_slider/carousel_slider.dart';
import 'package:clone/Constants/Stars.dart';
import 'package:clone/Constants/colors.dart';
import 'package:clone/Features/Home/Widgets/carausel_images.dart';
import 'package:clone/Features/Product_Details/Services/product_details_services.dart';
import 'package:clone/Features/Search/Screens/searchScreen.dart';
import 'package:clone/Logic(Cubit)/user_cubit.dart';
import 'package:clone/Models/product.dart';
import 'package:clone/common/Widgets/customButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:sizer/sizer.dart';

class ProductDetailsScreen extends StatefulWidget {
  final Product product;

  const ProductDetailsScreen({Key? key, required this.product})
      : super(key: key);
  static const String name = "productDetailsScreen";

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {

  ProductDetailsServices productDetailsServices = ProductDetailsServices();
  double avgRating = 0;
  double myRating = 0;

  void navigateToSearchScreen(String searchQuery) {
    Navigator.pushNamed(context, SearchScreen.name, arguments: searchQuery);
  }

  addToCart(){
    productDetailsServices.addToCart(context: context, product: widget.product);
    setState(() {});
  }

  @override
  void initState() {
    ratingCalcMethod();
    super.initState();
  }

  void ratingCalcMethod() {
    double totalRating = 0;
    for(int i = 0 ; i< widget.product.rating!.length; i++){
      totalRating+=widget.product.rating![i].rating;
      if(widget.product.rating![i].userId == BlocProvider.of<UserCubit>(context).state.user.id){
        myRating = widget.product.rating![i].rating;
      }
    }
    if(totalRating != 0 ){
      avgRating = totalRating/widget.product.rating!.length;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(8.h),
        child: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(gradient: GlobalColors.appBarGradient),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  height: 5.h,
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(7)),
                              borderSide: BorderSide.none),
                          enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(7)),
                              borderSide:
                                  BorderSide(color: Colors.black38, width: 1)),
                          hintText: 'Search Amazon.in',
                          hintStyle: TextStyle(
                              fontSize: 12.sp, fontWeight: FontWeight.w500),
                          prefixIcon: InkWell(
                            onTap: () {},
                            child: Padding(
                              padding: EdgeInsets.only(left: 1.w),
                              child: Icon(
                                Icons.search,
                                color: Colors.black38,
                              ),
                            ),
                          )),
                    ),
                  ),
                ),
              ),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 2.w),
                  alignment: Alignment.topLeft,
                  child: InkWell(
                    onTap: () {},
                    child: Icon(Icons.mic),
                  ))
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(2.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text(widget.product.id!), Stars(rating: avgRating)],
              ),
            ),
            Container(
              padding: EdgeInsets.all(2.w),
              child: Text(
                widget.product.name,
                style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
              ),
            ),
            CarouselSlider(
                items: widget.product.images.map((imageItem) {
                  return Builder(
                    builder: (BuildContext context) => Image.network(
                      imageItem,
                      fit: BoxFit.fill,
                    ),
                  );
                }).toList(),
                options: CarouselOptions(viewportFraction: 1, height: 35.h)
            ),
            Divider(
              thickness: 0.3.h,
              color: Colors.black26,
            ),
            Container(
              padding: EdgeInsets.all(2.w),
              child: RichText(
                text: TextSpan(text: 'Deal Price: ' , style: TextStyle(color: Colors.black , fontSize: 15.sp , fontWeight: FontWeight.bold),
                children: [
                  TextSpan(text: "\$${widget.product.price}" , style: TextStyle(color: Colors.red)),
                ]
                ),
              ),
            ),
            Container(padding: EdgeInsets.all(2.w),
            child: Text(widget.product.description , style: TextStyle(color: Colors.black ), maxLines: 20, overflow: TextOverflow.ellipsis,),
            ),
            Divider(
              thickness: 0.3.h,
              color: Colors.black26,
            ),
            Center(
              child: CustomButton(label: 'Buy now!', ButtonWidth: 98.w ,onPressed: (){
              }),
            ),
            SizedBox(height: 2.w,),
            Center(
              child: CustomButton(label: 'Add  to cart', textColor: Colors.black , color: Color.fromRGBO(254, 216, 19, 1)
                  ,ButtonWidth: 98.w ,onPressed: addToCart),
            ),
            Divider(
              thickness: 0.3.h,
              color: Colors.black26,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 3.w).copyWith(top: 5.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(child: Text("Rate This Product: " ,style: TextStyle(fontSize: 22.sp , fontWeight: FontWeight.bold),)),
                  Center(
                    child: RatingBar.builder(
                      initialRating: myRating,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: EdgeInsets.symmetric(horizontal: 2.w),
                      itemSize: 25.sp,
                      itemBuilder: (context , _){
                      return Icon(Icons.star , color: GlobalColors.secondBackground, );
                    }  , onRatingUpdate: (rating){
                      productDetailsServices.rateProduct(context: context , product: widget.product , rating: rating);
                    } ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
