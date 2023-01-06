import 'dart:convert';
import 'package:clone/Constants/colors.dart';
import 'package:clone/Constants/errorConstantshandler.dart';
import 'package:clone/Constants/errorMessages.dart';
import 'package:clone/Features/Home/Screens/HomeScreen.dart';
import 'package:clone/Logic(Cubit)/user_cubit.dart';
import 'package:clone/Models/user.dart';
import 'package:clone/common/Widgets/BottomNavigationBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthServices {
  void signUpUser({
    required String name,
    required String email,
    required String password,
    required BuildContext context
  }) async {
    try{
     User user = User(name: name , email: email , password: password);
     http.Response response =  await http.post(Uri.parse("$url/api/authentication") ,
         ///body: jsonEncode(user.toJson()) ,
         body: user.toJson() ,
         headers: <String,String>{
       "Content-type" : "application/json; charset=utf-8",
     });
     httpErrorHandler(response: response, context: context, onSuccess: (){
       ShowSnackBar(context: context , msg:  "Account has created! Sign in with same credentials" , color: Colors.green);
     });
    }catch(e){
        ShowSnackBar(context: context , msg:  e.toString());
    }
  }

  // sign in user
  void signInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      http.Response response = await http.post(
        Uri.parse('$url/api/signIn'),
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      httpErrorHandler(
        response: response,
        context: context,
        onSuccess: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          BlocProvider.of<UserCubit>(context).emitToken(response.body);
          await prefs.setString('XToken', jsonDecode(response.body)['token']);
          Navigator.pushNamedAndRemoveUntil(
            context,
            BottomBar.name,
                (route) => false,
          );
        },
      );
    } catch (e) {
      ShowSnackBar(context: context , msg: e.toString());
    }
  }

  getUserData({
    required BuildContext context
  }) async {
    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString("XToken");
      if(token == null){
        prefs.setString("XToken", " ");
      }
      var tokenRes = await http.post(
          Uri.parse("$url/tokenIsValid") ,
          headers: <String , String>{
        "Content-type" : "application/json; charset=utf-8",
        "XToken" : token!
      });

      var response = jsonDecode(tokenRes.body);

      if(response == true){
       http.Response userRes = await http.get(Uri.parse("$url/") , headers: <String , String>{
         "Content-type" : "application/json; charset=utf-8",
         "XToken" : token
       });
       var userProvider = BlocProvider.of<UserCubit>(context);
       userProvider.emitToken(userRes.body);
       print(userRes.body.toString());
       print("The token is : ${prefs.get("XToken")}");
      }
    }catch(e){
      ShowSnackBar(context: context , msg: e.toString());
    }
  }

}
