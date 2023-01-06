import 'dart:convert';
import 'package:clone/Constants/colors.dart';
import 'package:clone/Constants/errorConstantshandler.dart';
import 'package:clone/Constants/errorMessages.dart';
import 'package:clone/Logic(Cubit)/user_cubit.dart';
import 'package:clone/Models/product.dart';
import 'package:clone/Models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class CartServices {
  void removeFromCart({
    required BuildContext context,
    required Product product,
  }) async {
    final userProvider = BlocProvider.of<UserCubit>(context, listen: false);
    try {
      http.Response res = await http.delete(
        Uri.parse('$url/api/remove-from-cart/${product.id}'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'XToken': userProvider.state.token,
        },
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
      ShowSnackBar(context: context, msg: e.toString());
    }
  }
}
