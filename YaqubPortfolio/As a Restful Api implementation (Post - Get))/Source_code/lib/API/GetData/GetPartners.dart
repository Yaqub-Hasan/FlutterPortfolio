import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import '../JsonToDart/FindPartnerJson.dart';

class FindPartner{

  final storage = new FlutterSecureStorage();


  Future<FindPartnerJson> FIndPartner({required int CountryId , required CityId}) async {

    String Url = "https://mobiletest.tuqaatech.com/api/services/app/CityPartner/GetAllCityPartners?CityId=$CityId&CountryId=$CountryId";

    String? token = await storage.read(key: "token");

    var response = await http.get(
        Uri.parse(Url), headers: {
      "Accept": "application/json",
      "content-type":"application/json",
      "Authorization" : "Bearer $token",
    }
    );

    if (response.statusCode == 200) {
      return FindPartnerJson.fromJson(json.decode(response.body));

    } else {
      throw Exception("Error with response ${response.statusCode} , ${response.body}");
    }

  }
}