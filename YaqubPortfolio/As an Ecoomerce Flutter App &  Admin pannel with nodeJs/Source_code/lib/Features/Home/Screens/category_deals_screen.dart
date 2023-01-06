import 'package:clone/Constants/colors.dart';
import 'package:clone/Features/Home/Services/home_Services.dart';
import 'package:clone/Features/Product_Details/Screens/product_details_screen.dart';
import 'package:clone/Models/product.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CategoryDealsScreen extends StatefulWidget {
  final String category;
  const CategoryDealsScreen({Key? key, required this.category})
      : super(key: key);
  static const String name = "category_deals_Screen";

  @override
  State<CategoryDealsScreen> createState() => _CategoryDealsScreenState();
}

class _CategoryDealsScreenState extends State<CategoryDealsScreen> {
  List<Product>? productList;

  HomeServices homeServices = HomeServices();

  fetchCategoryProducts() async {
    productList = await homeServices.fetchCategoryProducts(
        context: context, category: widget.category);
    setState(() {});
  }

  void navigateToProductDetailScreen(Product product){
    Navigator.pushNamed(context, ProductDetailsScreen.name , arguments: product);
  }

  @override
  void initState() {
    fetchCategoryProducts();
    super.initState();
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
            title: Text(
              widget.category,
              style: TextStyle(color: Colors.black),
            )),
      ),
      body: productList == null
          ? Center(child: CircularProgressIndicator())
          : Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 3.w),
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Keep Shopping for ${widget.category}",
                      style: TextStyle(
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                    child: GridView.builder(
                        itemCount: productList!.length,
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.only(left: 2.w),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            crossAxisSpacing: 2.w,
                            childAspectRatio: 1.4),
                        itemBuilder: (context, index) {
                          final product = productList![index];
                          return InkWell(
                            onTap: () => navigateToProductDetailScreen(product),
                            child: Column(
                              children: [
                                Expanded(
                                    child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                        color: Colors.black12, width: 0.5.w),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(2.w),
                                    child: Image.network(
                                      product.images[0],
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                )),
                                Text(product.name , style: TextStyle(color: Colors.black54 , fontWeight: FontWeight.bold , fontSize: 13.sp),)
                              ],
                            ),
                          );
                        }),
                  )
                ],
              ),
    );
  }
}
