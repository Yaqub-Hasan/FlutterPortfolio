import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import '../ConstURLs.dart';
import '../JsonToDart/DialogsJson.dart';


class GetChatDialogs{

  final storage = new FlutterSecureStorage();

  Future<DialogJson> getAllChatsDialogs({required String ChatId}) async {

    String? token = await storage.read(key: "token");

      var response = await http.get(
          Uri.parse(ChatDialogsURL), headers: {
        "Accept": "application/json",
        "content-type":"application/json",
        "Authorization" : "Bearer $token",
        "id": ChatId,
      }
      );

      if (response.statusCode == 200) {
        return DialogJson.fromJson(json.decode(response.body));

      } else {
        throw Exception("Error with response ${response.statusCode} , ${response.body}");
      }

  }


}