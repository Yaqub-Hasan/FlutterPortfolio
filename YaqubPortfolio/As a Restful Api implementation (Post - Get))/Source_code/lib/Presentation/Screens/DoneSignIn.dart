import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:oswah_test/Presentation/Screens/LogInScreen.dart';
import 'package:oswah_test/Presentation/Screens/SignInScreen.dart';
import 'package:oswah_test/Presentation/Widgets/CusomButtons.dart';

class DoneSignIn extends StatelessWidget {
  const DoneSignIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
        LogInScreen(),
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 8 , sigmaY: 8),
            child: Container(
              color: Colors.transparent,
              child: Center(child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                   Text("Sign In" , style: TextStyle(
                       color: Colors.black,
                       fontWeight: FontWeight.bold,
                       fontSize: 30),),
                  Text("Please Sign In to Continue to the app " , style: TextStyle(
                      color: Colors.black,
                      fontSize: 20),),
                   SizedBox(height: 10,),
                   NormalButtonWidget(ButtonName: "Done!" , OnPressed: (){
                     Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LogInScreen() ));
                   }),
                ],
              ),),
             ),
          ),
        ),
    ],
    ),
    );
  }
}
