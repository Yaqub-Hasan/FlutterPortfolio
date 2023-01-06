import 'dart:convert';
import 'dart:io';
import 'package:clone/Constants/colors.dart';
import 'package:clone/Constants/errorConstantshandler.dart';
import 'package:clone/Constants/errorMessages.dart';
import 'package:clone/Logic(Cubit)/user_cubit.dart';
import 'package:clone/Models/product.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;


class AdminServices {
  void sellProduct({
    required BuildContext context,
    required String name,
    required String description,
    required double price,
    required double quantity,
    required String category,
    required List<File> images,
  }) async {

    final userProvider = BlocProvider.of<UserCubit>(context);

    try {

      final cloudinary = CloudinaryPublic('demxyigkx', 'rsuhvvjk');

      List<String> imageUrls = [];

      for (int i = 0; i < images.length; i++) {
        CloudinaryResponse res = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(images[i].path, folder: name),
        );
        imageUrls.add(res.secureUrl);
      }

      Product product = Product(
        name: name,
        description: description,
        quantity: quantity,
        images: imageUrls,
        category: category,
        price: price,
      );

      http.Response res = await http.post(
        Uri.parse('$url/admin/add-product'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'XToken': userProvider.state.token,
        },
        body: product.toJson(),
      );

      httpErrorHandler(
        response: res,
        context: context,
        onSuccess: () {
          ShowSnackBar(context: context, msg: 'Product Added Successfully!', color: Colors.green );
          Navigator.pop(context);
        },
      );
    } catch (e) {
      ShowSnackBar(context:context , msg: e.toString());
    }
  }

  // // get all the products
  Future<List<Product>> fetchAllProducts(BuildContext context) async {
    final userProvider = BlocProvider.of<UserCubit>(context);
    List<Product> productList = [];
    try {
      http.Response res =
      await http.get(Uri.parse('$url/admin/get-products'), headers: {
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
      ShowSnackBar(context: context , msg: e.toString());
    }
    return productList;
  }

  void deleteProduct({
    required BuildContext context,
    required Product product,
    required VoidCallback onSuccess,
  }) async {

    final userProvider = BlocProvider.of<UserCubit>(context);

    try {
      http.Response res = await http.post(
        Uri.parse('$url/admin/delete-product'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'XToken': userProvider.state.token,
        },
        body: jsonEncode({
          'id': product.id,
        }),
      );

      httpErrorHandler(
        response: res,
        context: context,
        onSuccess: () {
          onSuccess();
        },
      );
    } catch (e) {
      ShowSnackBar(context: context, msg: e.toString());
    }
  }

  // Future<List<Order>> fetchAllOrders(BuildContext context) async {
  //   final userProvider = Provider.of<UserProvider>(context, listen: false);
  //   List<Order> orderList = [];
  //   try {
  //     http.Response res =
  //     await http.get(Uri.parse('$uri/admin/get-orders'), headers: {
  //       'Content-Type': 'application/json; charset=UTF-8',
  //       'XToken': userProvider.user.token,
  //     });
  //
  //     httpErrorHandle(
  //       response: res,
  //       context: context,
  //       onSuccess: () {
  //         for (int i = 0; i < jsonDecode(res.body).length; i++) {
  //           orderList.add(
  //             Order.fromJson(
  //               jsonEncode(
  //                 jsonDecode(res.body)[i],
  //               ),
  //             ),
  //           );
  //         }
  //       },
  //     );
  //   } catch (e) {
  //     showSnackBar(context, e.toString());
  //   }
  //   return orderList;
  // }
  //
  // void changeOrderStatus({
  //   required BuildContext context,
  //   required int status,
  //   required Order order,
  //   required VoidCallback onSuccess,
  // }) async {
  //   final userProvider = Provider.of<UserProvider>(context, listen: false);
  //
  //   try {
  //     http.Response res = await http.post(
  //       Uri.parse('$uri/admin/change-order-status'),
  //       headers: {
  //         'Content-Type': 'application/json; charset=UTF-8',
  //         'XToken': userProvider.user.token,
  //       },
  //       body: jsonEncode({
  //         'id': order.id,
  //         'status': status,
  //       }),
  //     );
  //
  //     httpErrorHandle(
  //       response: res,
  //       context: context,
  //       onSuccess: onSuccess,
  //     );
  //   } catch (e) {
  //     showSnackBar(context, e.toString());
  //   }
  // }
  //
  // Future<Map<String, dynamic>> getEarnings(BuildContext context) async {
  //   final userProvider = Provider.of<UserProvider>(context, listen: false);
  //   List<Sales> sales = [];
  //   int totalEarning = 0;
  //   try {
  //     http.Response res =
  //     await http.get(Uri.parse('$uri/admin/analytics'), headers: {
  //       'Content-Type': 'application/json; charset=UTF-8',
  //       'XToken': userProvider.user.token,
  //     });
  //
  //     httpErrorHandle(
  //       response: res,
  //       context: context,
  //       onSuccess: () {
  //         var response = jsonDecode(res.body);
  //         totalEarning = response['totalEarnings'];
  //         sales = [
  //           Sales('Mobiles', response['mobileEarnings']),
  //           Sales('Essentials', response['essentialEarnings']),
  //           Sales('Books', response['booksEarnings']),
  //           Sales('Appliances', response['applianceEarnings']),
  //           Sales('Fashion', response['fashionEarnings']),
  //         ];
  //       },
  //     );
  //   } catch (e) {
  //     showSnackBar(context, e.toString());
  //   }
  //   return {
  //     'sales': sales,
  //     'totalEarnings': totalEarning,
  //   };
  // }
}
