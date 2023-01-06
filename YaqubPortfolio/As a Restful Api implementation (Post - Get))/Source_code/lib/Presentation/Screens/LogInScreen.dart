import 'package:flutter/material.dart';
import 'package:oswah_test/API/PostData/AuthLogIN.dart';
import 'package:oswah_test/Presentation/Screens/NavigationBarScreen.dart';
import 'package:oswah_test/Presentation/Widgets/LoadingIndicator.dart';
import 'package:oswah_test/Presentation/Screens/SignInScreen.dart';
import 'package:oswah_test/Presentation/Widgets/CusomButtons.dart';
import '../Widgets/TextButtonWidget.dart';
import '../Widgets/ValidatorTextField.dart';
import '../Widgets/ValidatorTextFieldPassword.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool isLoading = false;
  bool? rememberMe = false;

  TextEditingController EmailController = TextEditingController();
  TextEditingController PasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Form(
        key: formKey,
        child: Container(
            alignment: Alignment.center,
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                  image: AssetImage("assets/bg1.png" ,),fit: BoxFit.fill),
            ),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 5 , left: 20 , right: 20 , top: 100),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("LogIn" , style: TextStyle(color: Colors.black , fontWeight: FontWeight.bold , fontSize: 30),),
                  Column(
                    children: [

                      //!TextFields
                      Row(
                        children: [
                          ValidatorTextFieldEma(
                            styleColor: Colors.black,
                            borderColor: Colors.black,
                            hintText: "Email",
                            cntrol: EmailController,
                            IconImage: EmailController.text.isEmpty
                                ? Image(image: AssetImage("assets/email.png"))
                                : Image(image: AssetImage("assets/email-2.png")),
                            onChangedFunc: () {
                              setState(() {});
                            },
                          ),
                        ],
                      ),

                      SizedBox(height: 10),
                      Row(
                        children: [
                          ValidatorTextFieldPass(
                              styleColor: Colors.black,
                              borderColor: Colors.black,
                              hintText: "Password",
                              cntrol: PasswordController,
                              IconImage: PasswordController.text.isEmpty
                                  ? Image(image: AssetImage("assets/key.png"))
                                  : Image(image: AssetImage("assets/key-2.png")),
                              onChangedFunc: () {
                                setState(() {});
                              }),
                        ],
                      ),
                      SizedBox(height: 20,),
                      RememberMeRow(),

                      //?LogInButton
                      isLoading ? LoadingIndicator() :NormalButtonWidget(ButtonName: "Log In", OnPressed: ()async{
                        if(formKey.currentState!.validate()){
                          try{
                            setState(() => isLoading = true );
                            if(EmailController.text.isNotEmpty && PasswordController.text.isNotEmpty ){
                              int CheckDataPost = await AuthLogIn().PostLogInData(UserName: EmailController.text,
                                  Password: PasswordController.text,
                                  RememberMe: rememberMe ?? false);
                              if(CheckDataPost == 200){
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=> NavigationBarScreen()));
                              }else{
                                SnackBarMaker(context , "Error accrued .. email or Password is wrong");
                              }
                              setState(() => isLoading = false );
                            }
                          }catch(e){
                            print(e);
                          }
                        }
                      }),
                    ],
                  ),

                  BottomPart(),
                ],
              ),
            )
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

  Row RememberMeRow() {
    return Row(
                children: [
                  Checkbox(
                      value: rememberMe,
                      activeColor: Colors.orange,
                      onChanged: (value) {
                        setState(() {
                          rememberMe = value;
                        });
                      }),
                  Text(
                    "Remember Me ",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: rememberMe ?? false
                            ? Colors.orange
                            : Colors.black),
                  ),
                ],
              );
  }

  BottomPart() {
    return Column(
      children: [
        Divider( color:  Colors.black , height: 5),
        SizedBox(height: 10,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Text(" Don't have an account ?   " , style: TextStyle(fontWeight: FontWeight.bold),),
          TextButtonWidget(ButtonName: 'Sign In', onPressed: (){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=> SignInScreen()));
          },),
            SizedBox(height: 10,),
        ],)
      ],
    );
  }
}
