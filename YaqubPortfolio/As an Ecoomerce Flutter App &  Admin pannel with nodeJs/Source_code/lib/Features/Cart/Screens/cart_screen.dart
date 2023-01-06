import 'package:clone/Constants/colors.dart';
import 'package:clone/Features/Address/Screens/address_Screen.dart';
import 'package:clone/Features/Cart/Widgets/cart_subtotal.dart';
import 'package:clone/Features/Home/Widgets/Adress_Box.dart';
import 'package:clone/Features/Search/Screens/searchScreen.dart';
import 'package:clone/Logic(Cubit)/user_cubit.dart';
import 'package:clone/common/Widgets/customButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../Widgets/cart_product.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);
  static const String name = "cartScreen";

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

  void navigateToSearchScreen(String searchQuery){
    Navigator.pushNamed(context, SearchScreen.name , arguments: searchQuery);
  }


  void navigateToAddressScreen(){
    Navigator.pushNamed(context, AddressScreen.name );
  }


  @override
  Widget build(BuildContext context) {
    final user = BlocProvider.of<UserCubit>(context).state.user;
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
            SubTotal(),
            BlocBuilder<UserCubit , UserInitial>(builder: (context , state){
              return
                CustomButton(label: 'Proceed to buy (${user.cart!.length ?? 0} items)',
                    color: Colors.yellow[600] , textColor: Colors.black ,
                    ButtonWidth: 90.w, onPressed: navigateToAddressScreen);
            }),
            SizedBox(height: 2.w,),
            Divider(height: 10.sp,
            color: Colors.grey,
            ),
            BlocBuilder<UserCubit , UserInitial>(builder: (context , state){
              return user.cart?.length == 0 ?
                  Center( child: Column(
                    children: [
                      Icon(Icons.shopping_cart_outlined , color: Colors.black, size: 50.sp,),
                      Text("Cart is Empty!" , style: TextStyle(color: Colors.black ,
                      fontWeight: FontWeight.bold,
                        fontSize: 18.sp
                      ),)
                    ],
                  ))
                  :ListView.builder(
                  shrinkWrap: true,
                  itemCount: user.cart!.length,
                  itemBuilder: (context , index){
                   return CartProduct(index: index);
                  });
            }),

          ],
        ),

    ),
    );
  }
}
