import 'dart:convert';
import 'package:http/http.dart' as http;
import '../ConstURLs.dart';
import '../JsonToDart/AllCitiesJson.dart';

class GetCities{

  Future<AllCitiesJson> getAllCities() async {

      http.Response response = await http.get(Uri.parse(GetAllCitiesURL));

      if (response.statusCode == 200) {
        print(response.body);
        return AllCitiesJson.fromJson(json.decode(response.body));

      } else {
        throw Exception("Error with response ${response.statusCode} , ${response.body}");
      }
  }
}