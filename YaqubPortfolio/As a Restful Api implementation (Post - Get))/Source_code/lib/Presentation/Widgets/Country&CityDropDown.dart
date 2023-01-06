import 'package:flutter/material.dart';
import 'package:oswah_test/Presentation/Widgets/DropDownMenu.dart';

class CountryAndCityDropDown extends StatefulWidget {
  const CountryAndCityDropDown({Key? key, required this.returnCountryName, required this.returnCityName}) : super(key: key);

  final Function returnCountryName;
  final Function returnCityName;

  @override
  State<CountryAndCityDropDown> createState() => _CountryAndCityDropDownState();
}

class _CountryAndCityDropDownState extends State<CountryAndCityDropDown> {

  List Contries = [{"id" : 4 , "label" : "Syria"} ,
    {"id" : 8 , "label" : "Germany"} ,
    {"id" : 21 , "label" : "Sweden" } ,
  ];

  List SyrianCities = [
      {"id" : 112 , "label" : "Homs"},
      {"id" : 114 , "label" : "Aleppo"},
      {"id" : 115 , "label" : "Damascus"},
  ];

  List GermanCities = [{"id" : 133 , "label" : "Dortmund"},
    {"id" : 134 , "label" : "Stuttgart"},
    {"id" : 135 , "label" : "Koeln"}
  ];

  List SwedenCities = [{"id" : 177 , "label" : "Stockholm"},
    {"id" : 174 , "label" : "Uppsala"},
    {"id" : 173 , "label" : "Södermanland"},
  ];

  int? SelectedCountry;
  int? SelectedProvince;
  List province = [{"id" : 0 , "label" : "Choose Country First"},];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CountriesDropDown(),
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
  CountriesDropDown() {
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
              items: Contries.map((items) {
                return DropdownMenuItem(
                  value: items["id"],
                  child: Column(
                    children: [
                      Divider(
                        color: SelectedCountry != null
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
              onChanged: (country) {
                setState(() {
                  this.SelectedCountry = int.parse(country.toString());
                  if (country == 4) {
                    province = SyrianCities;
                    SelectedProvince = null;
                  } else if (country == 8) {
                    province = GermanCities;
                    SelectedProvince = null;
                  } else {
                    province = SwedenCities;
                    SelectedProvince = null;
                  }
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
