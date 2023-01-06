import 'dart:convert';
import 'package:http/http.dart' as http;
import '../ConstURLs.dart';


class Register {

  PostRegisterDataWithHTTP({required String name , required int gender , required int age , required int city , required int country ,
   required String phoneNumber , required String email , required String password , required String avatar}) async {
    final msg = jsonEncode({
    "name": name,
    "gender": gender,
    "age": age,
    "cityId": city,
    "countryId": country,
    "phoneNumber": phoneNumber,
    "emailAddress": email,
    "password": password,
    "avatar": avatar
    });
    try{
      var response = await http.post(Uri.parse(RegisterURL) , headers: {
        "Accept": "application/json",
        "content-type":"application/json"
      }  , body: msg );
     if(response.statusCode == 200){
       print(response.body);
       return response.statusCode;
     }else{
       print("status code for this failure is: ${response.statusCode} , ${response.body}");
       return response.statusCode;
     }
    }catch(e){
      print("error accrued: $e" );
    }
  }
}