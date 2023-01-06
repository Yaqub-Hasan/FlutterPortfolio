import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:oswah_test/API/PostData/Register.dart';
import 'package:oswah_test/Presentation/Screens/DoneSignIn.dart';
import 'package:oswah_test/Presentation/Widgets/LoadingIndicator.dart';
import 'package:oswah_test/Presentation/Screens/LogInScreen.dart';
import 'package:oswah_test/Presentation/Widgets/DropDownMenu.dart';
import 'package:oswah_test/Presentation/Widgets/CusomButtons.dart';
import 'package:oswah_test/Presentation/Widgets/NormalTextField.dart';
import 'package:oswah_test/Presentation/Widgets/ValidatorTextField.dart';
import '../Widgets/MultiValueDropDown.dart';
import '../Widgets/TextButtonWidget.dart';
import '../Widgets/ValidatorTextFieldPassword.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<SignInScreen> {

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController NameController = TextEditingController();
  TextEditingController AgeController = TextEditingController();
  TextEditingController PhoneController = TextEditingController();
  TextEditingController EmailController = TextEditingController();
  TextEditingController Password1Controller = TextEditingController();
  TextEditingController ConfirmPasswordController = TextEditingController();

  bool? isAccepting = false;
  bool isLoading = false;

  int? GenderItem;
  int? Country;
  int? City;

  File? image;
  String? img64;

  ///Image Picker and Converter to base64:
  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return null;

      final imageTemporary = File(image.path);
      final bytes = File(image.path).readAsBytesSync();
      setState(() {
        this.image = imageTemporary;
        this.img64 = base64Encode(bytes);
      });
    } on PlatformException catch (e) {
      print('Failed to pick image $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                      image: AssetImage(
                        "assets/bg1.png",
                      ),
                      fit: BoxFit.fill),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 50.0),
                      child: Center(
                          child: Text(
                        "Sign In",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 30),
                      )),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            width: 140,
                            height: 140,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(color: Colors.black, width: 2)),
                            child: image != null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Image.file(
                                      image!,
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : Image(
                                    image: AssetImage("assets/image.png"),
                                    height: 100,
                                    width: 100,
                                  )),
                        SizedBox(
                          width: 10,
                        ),
                        IconButton(
                          onPressed: () {
                            pickImage();
                          },
                          icon: Icon(
                            Icons.edit,
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    NormalTextField(
                      styleColor: Colors.black,
                      borderColor: Colors.black,
                      hintText: "Name",
                      cntrol: NameController,
                      onChange: () {
                        setState(() {});
                      },
                    ),
                    NormalTextField(
                      styleColor: Colors.black,
                      borderColor: Colors.black,
                      hintText: "Age",
                      cntrol: AgeController,
                      onChange: () {
                        setState(() {});
                      },
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    DropDownWidget(
                      OnSelectedItem: (GenderItem) {
                        this.GenderItem = GenderItem;
                        print(GenderItem.toString());
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    MultiValueDropDown(
                      returnCountryName: (country) {
                        this.Country = country;
                        print(Country.toString());
                      },
                      returnCityName: (city) {
                        this.City = city;
                        print(City.toString());
                      },
                    ),
                    NormalTextField(
                      styleColor: Colors.black,
                      borderColor: Colors.black,
                      hintText: "Phone",
                      cntrol: PhoneController,
                      onChange: () {
                        setState(() {});
                      },
                    ),
                    ValidatorTextFieldEma(
                      styleColor: Colors.black,
                      borderColor: Colors.black,
                      hintText: "Email",
                      cntrol: EmailController,
                      onChangedFunc: (){
                        setState(() {});
                      },
                      IconImage: EmailController.text.isEmpty
                          ? Image(image: AssetImage("assets/email.png"))
                          : Image(image: AssetImage("assets/email-2.png")),
                    ),
                    ValidatorTextFieldPass(
                      styleColor: Colors.black,
                      borderColor: Colors.black,
                      hintText: "Password",
                      cntrol: Password1Controller,
                      IconImage: Password1Controller.text.isEmpty
                          ? Image(image: AssetImage("assets/key.png"))
                          : Image(image: AssetImage("assets/key-2.png")),
                       onChangedFunc: (){
                      setState(() {});
                    },
                    ),
                    ValidatorTextFieldPass(
                      styleColor: Colors.black,
                      borderColor: Colors.black,
                      hintText: "Password",
                      cntrol: ConfirmPasswordController,
                      IconImage: ConfirmPasswordController.text.isEmpty
                          ? Image(image: AssetImage("assets/key.png"))
                          : Image(image: AssetImage("assets/key-2.png")),
                      onChangedFunc: (){
                        setState(() {});
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),


                    //? Sign IN Button
                    isLoading ? LoadingIndicator() : NormalButtonWidget(
                        ButtonName: "Sign In",
                        OnPressed: () async {
                          if(NameController.text.isNotEmpty &&AgeController.text.isNotEmpty && PhoneController.text.isNotEmpty &&EmailController.text.isNotEmpty &&
                              Password1Controller.text.isNotEmpty &&ConfirmPasswordController.text.isNotEmpty &&Password1Controller.text == ConfirmPasswordController.text &&
                              GenderItem != null && City != null &&Country != null && isAccepting == true && img64 != null) {
                            /// email field and password fields have a validation functionality
                            if(formKey.currentState!.validate()){
                              try{

                                ///Showing Indicator after user pressed button:
                                setState(() => isLoading = true );
                                //Future.delayed(Duration(seconds: 4));

                                ///Checking Post data and store response code:
                                int CheckDataPost = await Register().PostRegisterDataWithHTTP(
                                    name: NameController.text,
                                    gender: GenderItem ?? 0,
                                    age: int.parse(AgeController.text),
                                    city: City ?? 0,
                                    country: Country ?? 0,
                                    phoneNumber: PhoneController.text,
                                    email: EmailController.text,
                                    password: Password1Controller.text,
                                    avatar: img64.toString());
                                if(CheckDataPost == 200){
                                  Navigator.pushReplacement(context,
                                      MaterialPageRoute(builder: (_) => DoneSignIn()));
                                }else{
                                  setState(() => isLoading = false );
                                  SnackBarMaker(context, "Error Accrued , Please Try later");
                                }
                              }catch(e){
                                print(e);
                              }
                            }

                           //!Passwords fields must be identical
                          }else if(Password1Controller.text != ConfirmPasswordController.text){
                            SnackBarMaker(context , "Your Passwords are not identical");
                          }

                          //!User Must fill all fields
                          else{
                            SnackBarMaker(context, "Please fill all fields and Accept Privacy policy");
                          }
                        }),
                    BuildAcceptingCheckBox(context),
                    BottomPart()
                  ],
                ),
              ),
            ),
          ),
        ),
    );
  }

  void SnackBarMaker(BuildContext context , String Message) {
    final snackBar = SnackBar(
      content: Text(
        Message,
        style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 15),
      ),
      backgroundColor: Colors.red,
      duration: Duration(milliseconds: 1500),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Row BuildAcceptingCheckBox(BuildContext context) {
    return Row(
                  children: [
                    Checkbox(
                        value: isAccepting,
                        activeColor: Colors.orange,
                        onChanged: (value) {
                          setState(() {
                            isAccepting = value;
                          });
                        }),
                    Text(
                      "Accept The ",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: isAccepting ?? false
                              ? Colors.orange
                              : Colors.black),
                    ),
                    TextButtonWidget(
                      ButtonName: ' Privacy and Policy',
                      onPressed: () {

                      },
                    ),
                  ],
                );
  }

  BottomPart() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      child: Column(
        children: [
          Divider(color: Colors.black, height: 5),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                " Already have an account ?   ",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextButtonWidget(
                ButtonName: 'Log In',
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (_) => LogInScreen()));
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
