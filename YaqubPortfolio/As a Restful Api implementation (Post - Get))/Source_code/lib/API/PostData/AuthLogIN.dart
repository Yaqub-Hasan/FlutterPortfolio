import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import '../ConstURLs.dart';


class AuthLogIn{

  final storage = new FlutterSecureStorage();

  PostLogInData({required String UserName , required String Password , required bool RememberMe })async{
    try{
      var response = await http.post(Uri.parse(TokenURL) , headers: {
        "Accept": "application/json",
        "content-type":"application/json"
         }, body: jsonEncode({
        "userNameOrEmailAddress": UserName,
        "password": Password,
        "rememberClient": RememberMe
         }));

      if(response.statusCode == 200){
         //print(response.body);

        //!Token store way:
        var data = jsonDecode(response.body);
        var token = data["result"]["accessToken"];


        //store user token in secure storage:
        storage.write(key: "token", value: token);


        return response.statusCode;
      }
      else{
        print("status code for this failure is: ${response.statusCode} , ${response.body}");
        return response.statusCode;
      }
    }catch(e){
      print("Error: $e ");
    }

  }

}