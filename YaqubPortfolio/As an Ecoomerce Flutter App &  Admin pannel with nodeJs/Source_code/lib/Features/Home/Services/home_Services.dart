import 'dart:convert';
import 'package:clone/Constants/colors.dart';
import 'package:clone/Constants/errorConstantshandler.dart';
import 'package:clone/Constants/errorMessages.dart';
import 'package:clone/Logic(Cubit)/user_cubit.dart';
import 'package:clone/Models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;


class HomeServices {
  Future<List<Product>> fetchCategoryProducts({
    required BuildContext context,
    required String category,
  }) async {
    final userProvider = BlocProvider.of<UserCubit>(context);
    List<Product> productList = [];
    try {
      http.Response res = await http
          .get(Uri.parse('$url/api/products?category=$category'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'XToken': userProvider.state.token,
      });

      httpErrorHandler(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            productList.add(
              Product.fromJson(
                jsonEncode(
                  jsonDecode(res.body)[i],
                ),
              ),
            );
          }
        },
      );
    } catch (e) {
      ShowSnackBar(context: context, msg: e.toString());
    }
    return productList;
  }

  ///Don't forget XToken

  Future<Product> fetchDealOfDay({
    required BuildContext context,
  }) async {
    final userProvider = BlocProvider.of<UserCubit>(context);
    Product product = Product(
      name: '',
      description: '',
      quantity: 0,
      images: [],
      category: '',
      price: 0,
    );

    try {
      http.Response res =
      await http.get(Uri.parse('$url/api/deal-of-day'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'XToken': userProvider.state.token,
      });

      httpErrorHandler(
        response: res,
        context: context,
        onSuccess: () {
          product = Product.fromJson(res.body);
        },
      );
    } catch (e) {
      ShowSnackBar(context: context, msg: e.toString());
    }
    return product;
  }
}