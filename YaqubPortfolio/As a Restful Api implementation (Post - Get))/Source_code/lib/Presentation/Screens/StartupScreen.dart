import 'package:flutter/material.dart';
import 'package:oswah_test/Presentation/Screens/LogInScreen.dart';
import 'package:oswah_test/Presentation/Screens/SignInScreen.dart';
import 'package:oswah_test/Presentation/Widgets/CusomButtons.dart';

class StartupScreen extends StatefulWidget {
  const StartupScreen({Key? key}) : super(key: key);

  @override
  State<StartupScreen> createState() => _StartupScreenState();
}

class _StartupScreenState extends State<StartupScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Please login to continue: " , style: TextStyle(color: Colors.black , fontSize: 25 , fontWeight: FontWeight.bold),),
                SizedBox(height: 10,),
                NormalButtonWidget(ButtonName: "Log In", OnPressed: (){
                  Navigator.push(context , MaterialPageRoute(builder: (_) => LogInScreen() ));
                }),
                SizedBox(height: 10,),
                OutlinedButtonWidget(ButtonName: "Sign In", OnPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (_) => SignInScreen() ));
                })

              ],
            ),
          )
      ),
    );
  }
}
