import 'package:flutter/material.dart';
import 'package:oswah_test/Presentation/Screens/SearchPartner.dart';
import 'package:oswah_test/Presentation/Widgets/Country&CityDropDown.dart';
import 'package:oswah_test/Presentation/Widgets/DropDownMenu.dart';
import 'package:oswah_test/Presentation/Widgets/CusomButtons.dart';
import 'package:oswah_test/Presentation/Widgets/MultiValueDropDown.dart';
import 'package:oswah_test/Presentation/Widgets/NormalTextField.dart';

class FindPartnerScreen extends StatefulWidget {
  const FindPartnerScreen({Key? key}) : super(key: key);

  @override
  State<FindPartnerScreen> createState() => _FindPartnerScreenState();
}

class _FindPartnerScreenState extends State<FindPartnerScreen> {
  TextEditingController startAgeController = TextEditingController();
  TextEditingController endAgeController = TextEditingController();

  DateTime date = DateTime(2022, 1, 1);

  int? gender;
  int? cityId;
  int? countryId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Image(
            image: AssetImage("assets/back.png"),
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          "Find a partner",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),
        ),
        backgroundColor: Colors.orange,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15))),
      ),
      body: Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 20,
              ),
              MultiValueDropDown(
                  returnCountryName: (value) {
                    this.countryId = value;
                    print(countryId);
                  }, returnCityName: (value) {
                    this.cityId = value;
                    print(cityId);
              }),
              SizedBox(
                height: 5,
              ),
              Container(
                  padding: EdgeInsets.only(left: 50),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Partner Gender:",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
              DropDownWidget(OnSelectedItem: (value) {
                gender = value;
                print(gender);
              }),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 18.0, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Partner's Age:",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 22),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Row(
                      children: [
                        Text(
                          "between: ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        NormalTextField(
                          styleColor: Colors.black,
                          borderColor: Colors.black,
                          hintText: "Age ",
                          cntrol: startAgeController,
                          onChange: () {
                            setState(() {});
                          },
                          width: 200,
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "  And:        ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        NormalTextField(
                          styleColor: Colors.black,
                          borderColor: Colors.black,
                          hintText: "Age ",
                          cntrol: endAgeController,
                          onChange: () {
                            setState(() {});
                          },
                          width: 200,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: EdgeInsets.all(8),
                      margin: EdgeInsets.symmetric(horizontal: 25),
                      width: 300,
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Colors.black, width: 2)),
                      child: InkWell(
                        onTap: () async {
                          DateTime? dateTime = await showDatePicker(
                              context: context,
                              initialDate: date,
                              firstDate: DateTime(1900),
                              lastDate: DateTime(2223),
                              builder: (context, child) => Theme(
                                  data: ThemeData().copyWith(
                                      colorScheme: ColorScheme.light(
                                          primary: Colors.orange)),
                                  child: child!));
                          //if 'Cancel' => null
                          if (dateTime == null) return;
                          //if 'Ok' => date
                          setState(() => date = dateTime);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            date != DateTime(2022, 1, 1)
                                ? Text(
                                    "Date: ${date.year}/${date.month}/${date.day}",
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold),
                                  )
                                : Text(
                                    "Date: / /",
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold),
                                  ),
                            Icon(
                              Icons.date_range_sharp,
                              size: 30,
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: ButtonWithIcon(
                          ButtonName: 'Search',
                          icon: Icons.search_outlined,
                          OnPressed: () {
                              if(cityId != null && countryId!=null){
                                Navigator.push(context, MaterialPageRoute(builder: (_)=> SearchPartner(countryId: countryId, cityId: cityId,)));
                              }
                              else{
                                final snackbar = SnackBar(content: Text("Country and City Fields are required" , style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 15),) ,duration: Duration(milliseconds: 1500), backgroundColor: Colors.red,);
                                ScaffoldMessenger.of(context).showSnackBar(snackbar);
                              }
                          },
                        ))
                  ],
                ),
              ),
              Padding(padding: EdgeInsets.only(bottom: 150)),
            ],
          ),
        ),
      ),
    );
  }
}
