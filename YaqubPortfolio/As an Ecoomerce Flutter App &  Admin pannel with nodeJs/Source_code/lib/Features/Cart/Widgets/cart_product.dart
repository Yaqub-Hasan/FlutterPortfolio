import 'package:clone/Features/Cart/Services/cart_services.dart';
import 'package:clone/Features/Product_Details/Services/product_details_services.dart';
import 'package:clone/Logic(Cubit)/user_cubit.dart';
import 'package:clone/Logic(Cubit)/user_cubit.dart';
import 'package:clone/Models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class CartProduct extends StatefulWidget {
  const CartProduct({Key? key, required this.index}) : super(key: key);
  final int index;

  @override
  State<CartProduct> createState() => _CartProductState();
}

class _CartProductState extends State<CartProduct> {

  ProductDetailsServices productDetailsServices = ProductDetailsServices();
  CartServices cartServices = CartServices();

  void increaseQuantity(Product product){
    productDetailsServices.addToCart(context: context, product: product);
  }

  void decreaseQuantity(Product product){
    cartServices.removeFromCart(context: context, product: product);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserInitial>(
      builder: (context, state) {

        final productCart = state.user.cart![widget.index];
        final product = Product.fromMap(productCart['product']);
        final quantity = productCart['quantity'];

        return Container(
          padding: EdgeInsets.symmetric(horizontal: 2.w),
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
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    width: 22.w,
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(5),
                      ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        PlusMinusButton(icon: Icons.remove , onTap:() => decreaseQuantity(product) ),
                        QuantityNumberWidget(quantity),
                        PlusMinusButton(icon: Icons.add , onTap: () => increaseQuantity(product))
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  PlusMinusButton({required IconData icon , required Function() onTap}) {
    return InkWell(
        borderRadius: BorderRadius.circular(5),
        onTap: onTap,
        child: Container(
            width: 7.w,
            height: 7.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: Colors.grey.shade400),
            ),
            child: Center(child: Icon(icon , size: 13.sp,))),
    );
  }

  QuantityNumberWidget(var quantity) {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade400),
        color: Colors.white
      ),
      child: Container(
        alignment: Alignment.center,
        width: 7.w,
        height: 7.w,
        child:  Text(quantity.toString()),
      ),
    );
  }
}
