import 'dart:convert';
import 'package:http/http.dart' as http;
import '../ConstURLs.dart';
import '../JsonToDart/AllCountriesJson.dart';


class GetCountries{

  Future<AllCountriesJson> getAllCountries() async {

      var response = await http.get(Uri.parse(GetAllCountriesURL));

      if (response.statusCode == 200) {
        //print(response.body);
        return AllCountriesJson.fromJson(json.decode(response.body));

      } else {
        throw Exception("Error with response ${response.statusCode} , ${response.body}");
      }

  }
}