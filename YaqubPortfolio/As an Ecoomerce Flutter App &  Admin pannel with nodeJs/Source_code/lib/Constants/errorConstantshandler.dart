import 'dart:convert';
import 'package:clone/Constants/errorMessages.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void httpErrorHandler({
  required http.Response response,
  required BuildContext context,
  required VoidCallback onSuccess,
}){

  switch (response.statusCode){
    case 200:
      onSuccess();
      break;
    case 400:
      ShowSnackBar(context: context, msg: jsonDecode(response.body)['msg']);
      break;
    case 500:
      ShowSnackBar(context: context, msg: jsonDecode(response.body)['error']);
      break;
    default:
      ShowSnackBar(context: context, msg: jsonDecode(response.body)['msg']);
      break;

  }

}