import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:oswah_test/API/JsonToDart/ChatListJson.dart';

import '../ConstURLs.dart';

class GetChatsList {

  final storage = new FlutterSecureStorage();

  Future<ChatsListJson> getAllChats() async {

    String? token = await storage.read(key: "token");

      var response = await http.get(
        Uri.parse(GetAllChatsUrl), headers: {
        "Accept": "application/json",
        "content-type":"application/json",
        "Authorization" : "Bearer $token"
      }
      );

      if (response.statusCode == 200) {
           print(response.body);
        return ChatsListJson.fromJson(json.decode(response.body));

      }else {
        throw Exception("Error with response ${response.statusCode} , ${response.body}");
      }
  }
}
