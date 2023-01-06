import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import '../ConstURLs.dart';

class InsertNewMessage{

  final storage = new FlutterSecureStorage();

  SendMessage({required String message , required int YourId , required int recipientID}) async {

    String? token = await storage.read(key: "token");

    try{
      final msg = jsonEncode({
        "recipientID": recipientID,
        "who": YourId, //? what is this?
        "message": message,
        "time": DateTime.now().toString()
      });

      var response = await http.post(Uri.parse(InsertNewMessageURL) , headers: {
        "Accept": "application/json",
        "content-type":"application/json",
        "Authorization" : "Bearer $token"
      }  , body: msg );
      if(response.statusCode == 200){
        //print(response.body);
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