import 'dart:convert';
import 'package:clone/Constants/colors.dart';
import 'package:clone/Constants/errorConstantshandler.dart';
import 'package:clone/Constants/errorMessages.dart';
import 'package:clone/Logic(Cubit)/user_cubit.dart';
import 'package:clone/Models/product.dart';
import 'package:clone/Models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class ProductDetailsServices {

  void addToCart({
    required BuildContext context,
    required Product product,
  }) async {
    final userProvider = BlocProvider.of<UserCubit>(context);

    try {
      http.Response res = await http.post(
        Uri.parse('$url/api/add-to-cart'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'XToken': userProvider.state.token,
        },
        body: jsonEncode({
          'id': product.id!,
        }),
      );

      httpErrorHandler(
        response: res,
        context: context,
        onSuccess: () {
          User user =
          userProvider.state.user.copyWith(cart: jsonDecode(res.body)['cart']);
          userProvider.emitUserCartUpdated(user);
        },
      );
    } catch (e) {
      ShowSnackBar(context: context , msg: e.toString());
    }
  }

  void rateProduct({
    required BuildContext context,
    required Product product,
    required double rating,
  }) async {
    final userProvider = BlocProvider.of<UserCubit>(context);

    try {
      http.Response res = await http.post(
        Uri.parse('$url/api/rate-product'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'XToken': userProvider.state.token,
        },
        body: jsonEncode({
          'id': product.id!,
          'rating': rating,
        }),
      );

      httpErrorHandler(
        response: res,
        context: context,
        onSuccess: () {},
      );
    } catch (e) {
      ShowSnackBar(context: context , msg: e.toString());
    }
  }
}
