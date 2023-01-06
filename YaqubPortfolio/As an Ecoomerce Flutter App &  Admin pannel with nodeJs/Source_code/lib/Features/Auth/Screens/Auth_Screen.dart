import 'package:clone/Constants/colors.dart';
import 'package:clone/Features/Auth/Services/Auth_services.dart';
import 'package:clone/common/Widgets/customButton.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../common/Widgets/formField.dart';

class AuthScreen extends StatefulWidget {
  static const String name = "auth-Screen";

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

enum authEnum{ signUp , signIn}

class _AuthScreenState extends State<AuthScreen> {

  authEnum _auth = authEnum.signUp;
  GlobalKey<FormState> signInGlobalKey = GlobalKey<FormState>();
  GlobalKey<FormState> signUpGlobalKey = GlobalKey<FormState>();
  AuthServices authServices = AuthServices();

  TextEditingController nameController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  void signUpUser(){
    authServices.signUpUser(name: nameController.text, email: emailController.text, password: passController.text, context: context);
  }

  void signInUser(){
    authServices.signInUser(email: emailController.text, password: passController.text, context: context);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalColors.greyBackgroundColor,
      appBar: AppBar(),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 2.h,),
            Container(
                padding: EdgeInsets.only(left: 0.8.h),
                alignment: Alignment.topLeft,
                child: Text("Welcome" , style: TextStyle(color: Colors.black87 , fontWeight: FontWeight.bold , fontSize: 20.sp),)),
            Container(
              color: GlobalColors.backgroundColor,
              child: Column(
                children: [
                  ListTile(
                    title: Text("Create a new account" , style: TextStyle(color: Colors.black87 , fontWeight: FontWeight.bold , fontSize: 12.sp)),
                    leading: Radio(value: authEnum.signUp, activeColor: GlobalColors.secondBackground  ,groupValue: _auth , onChanged: (val){
                      setState(() {
                         _auth = val!;
                      });
                    },) ,
                  ),
                  _auth == authEnum.signUp ? SignUpFields() : Container(),
                  ListTile(
                    title: Text("Sign in with your account" , style: TextStyle(color: Colors.black87 , fontWeight: FontWeight.bold , fontSize: 12.sp)),
                    leading: Radio(value: authEnum.signIn, activeColor: GlobalColors.secondBackground  ,groupValue: _auth , onChanged: (val){
                      setState(() {
                        _auth = val!;
                      });
                    },),
                  ),
                  _auth == authEnum.signIn ? SignInFields() : Container(),
                ],
              ),
            ),
          ],
        )
      ),
    );
  }

  SignUpFields() {
    return Container(
      color: GlobalColors.backgroundColor,
      child: Form(
        key: signUpGlobalKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            customFormField(controller: nameController, hintText: 'Name', textInputType: TextInputType.name,),
            customFormField(controller: emailController, hintText: 'Email', textInputType: TextInputType.emailAddress,),
            customFormField(controller: passController, hintText: 'Password', textInputType: TextInputType.visiblePassword, obscureText: true,),
            CustomButton(label: "Sign up", onPressed: (){
             if(signUpGlobalKey.currentState!.validate()){
                 signUpUser();
             }
            })
          ],
        ),
      ),
    );
  }

  SignInFields() {
    return Container(
      child: Form(
        key: signInGlobalKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            //customFormField(controller: nameController, hintText: 'Name', textInputType: TextInputType.name,),
            customFormField(controller: emailController, hintText: 'Email', textInputType: TextInputType.emailAddress,),
            customFormField(controller: passController, hintText: 'Password', textInputType: TextInputType.visiblePassword, obscureText: true,),
            CustomButton(label: "Sign in", onPressed: (){
              if(signInGlobalKey.currentState!.validate()){
                signInUser();
              }
            })
          ],
        ),
      ),
    );
  }
}
