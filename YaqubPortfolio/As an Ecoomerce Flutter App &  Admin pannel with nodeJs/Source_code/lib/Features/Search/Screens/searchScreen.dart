import 'package:clone/Constants/colors.dart';
import 'package:clone/Features/Home/Widgets/Adress_Box.dart';
import 'package:clone/Features/Product_Details/Screens/product_details_screen.dart';
import 'package:clone/Features/Search/Services/search_services.dart';
import 'package:clone/Features/Search/Widgets/SearchedProduct.dart';
import 'package:clone/Models/product.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SearchScreen extends StatefulWidget {
  final String searchQuery;

  const SearchScreen({Key? key, required this.searchQuery}) : super(key: key);
  static const String name = "SearchScreen";

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  SearchServices searchServices = SearchServices();
  List<Product>? productList;

  void fetchSearchProducts() async {
    productList = await searchServices.fetchSearchedProduct(
        context: context, searchQuery: widget.searchQuery);
    setState(() {});
  }

  void navigateToProductDetailScreen(Product product){
    Navigator.pushNamed(context, ProductDetailsScreen.name , arguments: product);
  }

  void navigateToSearchScreen(String searchQuery) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      SearchScreen.name,
      arguments: searchQuery,
      (route) => false,
    );
  }

  @override
  void initState() {
    fetchSearchProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(8.h),
              child: AppBar(
                flexibleSpace: Container(
                  decoration:
                      BoxDecoration(gradient: GlobalColors.appBarGradient),
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
                            //onFieldSubmitted: navigateToSearchScreen,
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
                                    borderSide: BorderSide(
                                        color: Colors.black38, width: 1)),
                                hintText: 'Search Amazon.in',
                                hintStyle: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500),
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
            body: productList == null
                ? Center(
              child: CircularProgressIndicator(),
            )
                : Column(
              children: [
                AddressBox(),
                SizedBox(height: 3.w,),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: productList!.length,
                    itemBuilder: (context , index){
                      return InkWell(
                          onTap:() => navigateToProductDetailScreen(productList![index]),
                          child: SearchedProduct(product: productList![index]));
                    },
                  ),
                )

              ],
            ),
          );
  }
}
