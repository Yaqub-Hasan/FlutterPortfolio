import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class InsertFireBaseToken{

  final storage = new FlutterSecureStorage();
  FirebaseMessaging _fcm = FirebaseMessaging.instance;
  String FireBaseToken = '';


  //get Fire base token
  getFireBaseToken(){
      _fcm.getToken().then((value){
      print(value);
        FireBaseToken = value.toString();
    });
      return FireBaseToken;
  }


  insertToken() async {

    String? token = await storage.read(key: "token");

    try{
      var response = await http.post(Uri.parse("https://mobiletest.tuqaatech.com/api/services/app/User/InsertFireBaseToken?firebaseToken=$FireBaseToken") , headers: {
        "Accept": "application/json",
        "content-type":"application/json",
        "Authorization" : "Bearer $token"
      });

      if(response.statusCode == 200){
        //print(response.body);
        var userID = jsonDecode(response.body)["result"]['id'];
        storage.write(key: "id", value: userID.toString() );
      }
      else{
        print("Error while requesting: ${response.statusCode}  , ${response.body}" );
      }


    }catch(e){
      print("Sadly Couldn't even request $e");
    }

  }



}