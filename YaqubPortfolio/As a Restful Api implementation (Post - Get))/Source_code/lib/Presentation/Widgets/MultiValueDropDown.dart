import 'package:flutter/material.dart';
import 'package:oswah_test/API/JsonToDart/AllCountriesJson.dart';
import '../../API/GetData/GetAllCountries.dart';
import '../../API/JsonToDart/AllCitiesJson.dart';

class MultiValueDropDown extends StatefulWidget {
  const MultiValueDropDown({Key? key, required this.returnCountryName, required this.returnCityName}) : super(key: key);
  final Function returnCountryName;
  final Function returnCityName;

  @override
  State<MultiValueDropDown> createState() => _MultiValueDropDownState();
}

class _MultiValueDropDownState extends State<MultiValueDropDown> {

  int? SelectedCountry;
  int? SelectedProvince;

  List province = [{"id" : 0 , "label" : "Choose Country First"},];
  late Future<AllCountriesJson> allCountriesJson;

  @override
  initState(){
    super.initState();
    allCountriesJson = GetCountries().getAllCountries();
  }



  @override
  Widget build(BuildContext context) {
    return Column(
          children: [
            FutureBuilder<AllCountriesJson>( future: allCountriesJson , builder: (context , snapshot){
              if(snapshot.hasData){
                final countries = snapshot.data!.result;
                List<Map> name = [];
                for(int i = 0 ; i < countries!.length ; i++){
                    name.add({"name" : countries[i].name , "id" : countries[i].id});
                }
                return CountriesDropDown(name , snapshot);
              }
              else{
                return Container();
              }
            }),
            SizedBox(
              height: 10,
            ),
            CitiesDropDown(),
            SizedBox(
              height: 10,
            ),
          ],
    );
  }



  //DropDownCountries
  CountriesDropDown(List data ,AsyncSnapshot<AllCountriesJson> snapshot) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 300,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 2),
              borderRadius: BorderRadius.circular(15)),
          margin: EdgeInsets.only(right: 10),
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: DropdownButtonHideUnderline(
            child: DropdownButton(
              isExpanded: true,
              hint: Text("Country" , style: TextStyle(color: Colors.grey , fontSize: 18 , fontWeight: FontWeight.bold),),
              value: SelectedCountry,
              icon: Image(
                image: AssetImage("assets/arrow-down-b.png"),
              ),
              items: data.map((items) {
                return DropdownMenuItem(
                  value: items['id'],
                  child: Column(
                    children: [
                      Divider(
                        color: SelectedCountry != null
                            ? Colors.transparent
                            : Colors.black,
                        height: 15,
                      ),
                      Text(
                        items['name'],
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                );
              }).toList(),
              onChanged: (country) {
                setState(() {

                  this.SelectedCountry = int.parse(country.toString());
                  int CountryID = int.parse(country.toString());
                  final citiesData = snapshot.data!.result![CountryID-1].cities;
                  List cities = [];
                  for(int i = 0 ; i < citiesData!.length ; i++){
                    cities.add({"label" : citiesData[i].name , "id" : citiesData[i].id});
                  }

                  province = cities;
                  SelectedProvince = null;

                  widget.returnCountryName(this.SelectedCountry);
                });
              },
            ),
          ),
        ),
        SelectedCountry != null
            ? Icon(
          Icons.done,
          color: Colors.orange,
          size: 25,
        )
            : Container()
      ],
    );
  }


  //CityDropDown
  CitiesDropDown() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 300,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 2),
              borderRadius: BorderRadius.circular(15)),
          margin: EdgeInsets.only(right: 10),
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: DropdownButtonHideUnderline(
            child: DropdownButton(
              isExpanded: true,
              hint: Text("City" , style: TextStyle(color: Colors.grey , fontSize: 18 , fontWeight: FontWeight.bold),),
              value: SelectedProvince,
              icon: Image(
                image: AssetImage("assets/arrow-down-b.png"),
              ),
              items: province.map((items) {
                return DropdownMenuItem(
                  value: items["id"],
                  child: Column(
                    children: [
                      Divider(
                        color: SelectedProvince != null
                            ? Colors.transparent
                            : Colors.black,
                        height: 15,
                      ),
                      Text(
                        items["label"],
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                );
              }).toList(),
              onChanged: (city) {
                setState(() {
                  this.SelectedProvince = int.parse(city.toString());
                  widget.returnCityName(this.SelectedProvince);
                });
              },
            ),
          ),
        ),
        SelectedProvince != null
            ? Icon(
          Icons.done,
          color: Colors.orange,
          size: 25,
        )
            : Container()
      ],
    );
  }
}
